local var_0_0 = import("game.dorm.DormEnum")
local var_0_1 = class("DormHeroDeployView", ReduxView)

function var_0_1.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormPersonnelAllocationUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_1.OnCtor(arg_3_0)
	return
end

function var_0_1.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_1.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.characterScroll = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, DormCharacterItem)
	arg_5_0.stateController = ControllerUtil.GetController(arg_5_0.transform_, "state")
	arg_5_0.allCharacterController = ControllerUtil.GetController(arg_5_0.quickRecall.transform, "useState")
end

local function var_0_2()
	return Dorm.storage:GetData(DormCharacterManager.curGrabbingInfoNamespace, "eid")
end

local function var_0_3(arg_7_0)
	local var_7_0 = DormUtils.GetEntityData(arg_7_0)

	return var_7_0.heroID or var_7_0.cfgID
end

function var_0_1.IndexOf(arg_8_0, arg_8_1)
	return table.indexof(arg_8_0.dataList_, arg_8_0.heroID)
end

function var_0_1.OnEnter(arg_9_0)
	arg_9_0.roomID = DormData:GetCurrectSceneID()

	if BackHomeCfg[arg_9_0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		arg_9_0.maxNum = GameSetting.dorm_lobby_hero_max.value[1]

		arg_9_0.stateController:SetSelectedState("public")
	else
		arg_9_0.maxNum = DormConst.PRIVATE_CHARACTER_MAX_NUM

		arg_9_0.stateController:SetSelectedState("private")
	end

	arg_9_0.maxnumText_.text = "/" .. arg_9_0.maxNum

	arg_9_0:RefreshDormHeroList()
	arg_9_0:RegisterEvents()
	arg_9_0:RefreshPlaceHeroNum()

	arg_9_0.postStartHandle = FrameTimer.New(function()
		arg_9_0.curGrabbing = var_0_2()

		if arg_9_0.curGrabbing then
			arg_9_0.selHeroID = var_0_3(arg_9_0.curGrabbing)

			local var_10_0 = arg_9_0:IndexOf(arg_9_0.curGrabbing)

			if var_10_0 then
				arg_9_0.characterScroll:ScrollToIndex(var_10_0, false, true, 0.2)
			end
		else
			arg_9_0.selHeroID = nil
		end

		arg_9_0.characterScroll:Refresh()

		arg_9_0.postStartHandle = nil
	end, 1, false)

	arg_9_0.postStartHandle:Start()
end

function var_0_1.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()

	if arg_11_0.postStartHandle then
		arg_11_0.postStartHandle:Stop()

		arg_11_0.postStartHandle = nil
	end
end

function var_0_1.indexItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:ShowMaskCallBack(function(arg_13_0)
		local var_13_0 = DormData:GetHeroTemplateInfo(arg_13_0)

		if var_13_0 then
			local var_13_1 = var_13_0:GetHeroState()

			if var_13_1 == var_0_0.DormHeroState.InCanteenEntrust or var_13_1 == var_0_0.DormHeroState.InCanteenJob then
				return true
			end

			if var_13_1 == var_0_0.DormHeroState.InPublicDorm and var_13_0.hero_id ~= arg_13_0 then
				return nullable(BackHomeCfg, DormData:GetCurrectSceneID(), "type") ~= DormConst.BACKHOME_TYPE.PrivateDorm
			end

			return false
		end
	end)
	arg_12_2:RefreshUI(arg_12_0.dataList_[arg_12_1], arg_12_0.selHeroID, arg_12_1)
	arg_12_2:SetOnPointerDown(function(arg_14_0)
		arg_12_0.selHeroID = arg_12_0.curGrabbing and var_0_3(arg_12_0.curGrabbing) or arg_14_0

		arg_12_0.characterScroll:Refresh()
	end)
	arg_12_2:RecallHero(function(arg_15_0)
		local var_15_0 = DormData:GetCurrectSceneID()

		if var_15_0 == DormConst.PUBLIC_DORM_ID then
			local var_15_1 = DormitoryData:GetDormHerosByArchitecture(var_15_0)
			local var_15_2 = {}
			local var_15_3 = DormData:GetHeroTemplateInfo(arg_15_0):GetHeroId()

			for iter_15_0, iter_15_1 in ipairs(var_15_1) do
				if iter_15_1 ~= var_15_3 then
					table.insert(var_15_2, iter_15_1)
				end
			end

			DormAction:DeployHeroInRoom(var_15_0, var_15_2, var_0_0.DormDeployType.ReCall)
		elseif var_15_0 then
			DormAction:RecallHeroInPrivateDorm(var_15_0, arg_15_0)
		end
	end)
end

local function var_0_4()
	local var_16_0 = nullable(GameDisplayCfg.dorm_hero_first_set_dialogue, "value")

	if var_16_0 then
		local var_16_1 = 0

		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			var_16_1 = var_16_1 + iter_16_1[2]
		end

		local var_16_2 = math.random() * var_16_1

		for iter_16_2, iter_16_3 in ipairs(var_16_0) do
			local var_16_3 = iter_16_3[1]

			var_16_2 = var_16_2 - iter_16_3[2]

			if var_16_2 < 0 then
				return var_16_3
			end
		end
	end

	return 0
end

function var_0_1.RegisterEvents(arg_17_0)
	arg_17_0:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function()
		arg_17_0.characterScroll:Refresh()
		arg_17_0:RefreshPlaceHeroNum()
	end)
	arg_17_0:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function()
		arg_17_0.characterScroll:Refresh()
	end)
end

function var_0_1.AddUIListener(arg_20_0)
	arg_20_0:AddBtnListenerScale(arg_20_0.backBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_20_0:AddBtnListenerScale(arg_20_0.quickRecall, nil, function()
		local var_22_0 = DormData:GetCurrectSceneID()
		local var_22_1 = DormitoryData:GetDormHerosByArchitecture(var_22_0)

		if #var_22_1 > 0 then
			DormHeroTools:RecallAllHero(var_22_1)
		else
			ShowTips("DORM_NO_HERO_RECALL")
		end
	end)
end

function var_0_1.OnStartGrabHero(arg_23_0, arg_23_1)
	arg_23_0.curGrabbing = arg_23_1
	arg_23_0.selHeroID = var_0_3(arg_23_1), DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.UpCharacter)

	arg_23_0.characterScroll:Refresh()
end

function var_0_1.OnReleaseGrabHero(arg_24_0)
	if arg_24_0.curGrabbing then
		local var_24_0 = arg_24_0.curGrabbing

		arg_24_0.curGrabbing = nil

		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.DownCharacter)

		local var_24_1 = var_0_4()

		if var_24_1 ~= 0 then
			manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, var_24_0, var_24_1)
		end

		arg_24_0.characterScroll:Refresh()
	end
end

function var_0_1.NotDragOutYet(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1.position
	local var_25_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	return UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(arg_25_0.dragOutRect_, var_25_0, var_25_1)
end

function var_0_1.OnBeginDragHeroItem(arg_26_0, arg_26_1)
	if not arg_26_0.curGrabbing then
		arg_26_0.uilistSrex_:OnBeginDrag(arg_26_1)

		arg_26_0.alreadyDragOut = false
	end
end

function var_0_1.OnDragHeroItem(arg_27_0, arg_27_1)
	if not arg_27_0.curGrabbing and not arg_27_0.alreadyDragOut then
		if arg_27_0:NotDragOutYet(arg_27_1) then
			arg_27_0.uilistSrex_:OnDrag(arg_27_1)
		else
			arg_27_0.uilistSrex_:OnEndDrag(arg_27_1)
			arg_27_0:TryDragHeroOut(arg_27_1)

			arg_27_0.alreadyDragOut = true
		end
	end
end

local var_0_5 = {
	[var_0_0.DormHeroState.InCanteenEntrust] = "DORM_HERO_WORK_IN_CANTEEN",
	[var_0_0.DormHeroState.InCanteenJob] = "DORM_HERO_WORK_IN_CANTEEN"
}

function var_0_1.TryDragHeroOut(arg_28_0, arg_28_1)
	if arg_28_0.curGrabbing then
		return
	end

	if arg_28_0.selHeroID then
		local var_28_0 = DormData:GetHeroArchiveID(arg_28_0.selHeroID)
		local var_28_1 = DormData:GetHeroInfo(var_28_0)
		local var_28_2 = var_28_1:GetHeroState()
		local var_28_3 = nullable(var_0_5, var_28_2)

		if var_28_3 then
			ShowTips(GetTips(var_28_3))

			return
		end

		if arg_28_0:CheckCharacterNumMax() then
			local var_28_4 = DormData:GetCurrectSceneID()
			local var_28_5 = BackHomeCfg[var_28_4].type

			if var_28_5 == DormConst.BACKHOME_TYPE.PublicDorm then
				local var_28_6 = DormitoryData:GetDormHerosByArchitecture(var_28_4)
				local var_28_7 = DormitoryData:GetDormArchivesByArchitecture(var_28_4)

				for iter_28_0, iter_28_1 in ipairs(var_28_7) do
					if iter_28_1 == var_28_0 then
						ShowTips(GetTips("DORM_HERO_SAME_SET"))

						return
					end
				end

				local var_28_8 = {}

				for iter_28_2, iter_28_3 in ipairs(var_28_6) do
					table.insert(var_28_8, iter_28_3)
				end

				table.insert(var_28_8, arg_28_0.selHeroID)
				arg_28_0:OnStartGrabHero(DormHeroTools.GenerateHeroByDrag(arg_28_0.selHeroID, arg_28_1))
				DormAction:DeployHeroInRoom(var_28_4, var_28_8, var_0_0.DormDeployType.Place)
			elseif var_28_5 == DormConst.BACKHOME_TYPE.PrivateDorm then
				if var_28_2 == var_0_0.DormHeroState.InPrivateDorm then
					local var_28_9 = var_28_1:GetHeroId()

					if var_28_9 == arg_28_0.selHeroID then
						return
					end

					DormHeroTools.RemoveHero(var_28_9)
				end

				arg_28_0:OnStartGrabHero(DormHeroTools.GenerateHeroByDrag(arg_28_0.selHeroID, arg_28_1))
				DormAction:RecallHeroInPrivateDorm(var_28_4, arg_28_0.selHeroID)
			end
		else
			ShowTips(GetTips("DORM_LOBBY_SET_MAX"))
		end
	end
end

function var_0_1.OnEndDragHeroItem(arg_29_0, arg_29_1)
	if arg_29_0.curGrabbing then
		DormLuaBridge.EndGrabPlayerEntity(arg_29_0.curGrabbing)
		arg_29_0:OnReleaseGrabHero()
	else
		arg_29_0.uilistSrex_:OnEndDrag(arg_29_1)
	end
end

function var_0_1.GetDormHeroList(arg_30_0)
	local var_30_0 = {}

	arg_30_0 = arg_30_0 or DormData:GetCurrectSceneID()

	local var_30_1 = DormHeroTools:GetBackHomeCanUseHeroList(arg_30_0)

	DormTools.SortDormHeroList(var_30_1)

	return var_30_1
end

function var_0_1.RefreshDormHeroList(arg_31_0)
	arg_31_0.dataList_ = var_0_1.GetDormHeroList()

	arg_31_0.characterScroll:StartScroll(#arg_31_0.dataList_)
end

function var_0_1.CheckCharacterNumMax(arg_32_0)
	if BackHomeCfg[arg_32_0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		local var_32_0 = DormitoryData:GetDormSceneData(arg_32_0.roomID).archiveIDList

		if var_32_0 then
			local var_32_1 = #var_32_0
			local var_32_2 = DormCharacterManager.GetInstance():GetCharacterNum() or 0

			if var_32_1 >= arg_32_0.maxNum or var_32_2 >= arg_32_0.maxNum then
				return false
			else
				return true
			end
		end
	else
		return true
	end
end

function var_0_1.RefreshPlaceHeroNum(arg_33_0)
	if BackHomeCfg[arg_33_0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		local var_33_0 = DormitoryData:GetDormSceneData(arg_33_0.roomID).archiveIDList

		if var_33_0 then
			local var_33_1 = #var_33_0

			arg_33_0.curnumText_.text = var_33_1
		else
			arg_33_0.curnumText_.text = 0
		end

		local var_33_2 = false

		for iter_33_0, iter_33_1 in ipairs(var_33_0) do
			if DormData:GetHeroFatigue(iter_33_1) >= GameSetting.canteen_hero_fatigue_max.value[1] then
				var_33_2 = true

				break
			end
		end

		if var_33_2 then
			arg_33_0.allCharacterController:SetSelectedState("true")
		else
			arg_33_0.allCharacterController:SetSelectedState("false")
		end
	else
		local var_33_3 = DormitoryData:GetDormSceneData(arg_33_0.roomID).archiveIDList[1]

		if DormData:GetHeroInfo(var_33_3):GetHeroState() == var_0_0.DormHeroState.InPrivateDorm then
			arg_33_0.curnumText_.text = 1
		else
			arg_33_0.curnumText_.text = 0
		end
	end
end

function var_0_1.Dispose(arg_34_0)
	if arg_34_0.characterScroll then
		arg_34_0.characterScroll:Dispose()
	end

	arg_34_0.uilistSrex_.ExitScrollArea:RemoveAllListeners()
	var_0_1.super.Dispose(arg_34_0)
end

return var_0_1
