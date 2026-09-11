local DormEnum = import("game.dorm.DormEnum")
local DormHeroDeployView = class("DormHeroDeployView", ReduxView)

function DormHeroDeployView:UIName()
	return "Widget/BackHouseUI/Dorm/DormPersonnelAllocationUI"
end

function DormHeroDeployView:UIParent()
	return manager.ui.uiMain.transform
end

function DormHeroDeployView:OnCtor()
	return
end

function DormHeroDeployView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormHeroDeployView:InitUI()
	self:BindCfgUI()

	self.characterScroll = LuaList.New(handler(self, self.indexItem), self.uilistGo_, DormCharacterItem)
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.allCharacterController = ControllerUtil.GetController(self.quickRecall.transform, "useState")
end

local function var_0_2()
	return Dorm.storage:GetData(DormCharacterManager.curGrabbingInfoNamespace, "eid")
end

local function var_0_3(arg_7_0)
	local var_7_0 = DormUtils.GetEntityData(arg_7_0)

	return var_7_0.heroID or var_7_0.cfgID
end

function DormHeroDeployView:IndexOf(arg_8_1)
	return table.indexof(self.dataList_, self.heroID)
end

function DormHeroDeployView:OnEnter()
	self.roomID = DormData:GetCurrectSceneID()

	if BackHomeCfg[self.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		self.maxNum = GameSetting.dorm_lobby_hero_max.value[1]

		self.stateController:SetSelectedState("public")
	else
		self.maxNum = DormConst.PRIVATE_CHARACTER_MAX_NUM

		self.stateController:SetSelectedState("private")
	end

	self.maxnumText_.text = "/" .. self.maxNum

	self:RefreshDormHeroList()
	self:RegisterEvents()
	self:RefreshPlaceHeroNum()

	self.postStartHandle = FrameTimer.New(function()
		self.curGrabbing = var_0_2()

		if self.curGrabbing then
			self.selHeroID = var_0_3(self.curGrabbing)

			local var_10_0 = self:IndexOf(self.curGrabbing)

			if var_10_0 then
				self.characterScroll:ScrollToIndex(var_10_0, false, true, 0.2)
			end
		else
			self.selHeroID = nil
		end

		self.characterScroll:Refresh()

		self.postStartHandle = nil
	end, 1, false)

	self.postStartHandle:Start()
end

function DormHeroDeployView:OnExit()
	self:RemoveAllEventListener()

	if self.postStartHandle then
		self.postStartHandle:Stop()

		self.postStartHandle = nil
	end
end

function DormHeroDeployView:indexItem(arg_12_1, arg_12_2)
	arg_12_2:ShowMaskCallBack(function(arg_13_0)
		local var_13_0 = DormData:GetHeroTemplateInfo(arg_13_0)

		if var_13_0 then
			local var_13_1 = var_13_0:GetHeroState()

			if var_13_1 == DormEnum.DormHeroState.InCanteenEntrust or var_13_1 == DormEnum.DormHeroState.InCanteenJob then
				return true
			end

			if var_13_1 == DormEnum.DormHeroState.InPublicDorm and var_13_0.hero_id ~= arg_13_0 then
				return nullable(BackHomeCfg, DormData:GetCurrectSceneID(), "type") ~= DormConst.BACKHOME_TYPE.PrivateDorm
			end

			return false
		end
	end)
	arg_12_2:RefreshUI(self.dataList_[arg_12_1], self.selHeroID, arg_12_1)
	arg_12_2:SetOnPointerDown(function(arg_14_0)
		self.selHeroID = self.curGrabbing and var_0_3(self.curGrabbing) or arg_14_0

		self.characterScroll:Refresh()
	end)
	arg_12_2:RecallHero(function(arg_15_0)
		local var_15_0 = DormData:GetCurrectSceneID()

		if var_15_0 == DormConst.PUBLIC_DORM_ID then
			local var_15_1 = {}
			local var_15_2 = DormData:GetHeroTemplateInfo(arg_15_0):GetHeroId()

			for iter_15_0, iter_15_1 in ipairs((DormitoryData:GetDormHerosByArchitecture(var_15_0))) do
				if iter_15_1 ~= var_15_2 then
					table.insert(var_15_1, iter_15_1)
				end
			end

			DormAction:DeployHeroInRoom(var_15_0, var_15_1, DormEnum.DormDeployType.ReCall)
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
			var_16_2 = var_16_2 - iter_16_3[2]

			if var_16_2 < 0 then
				return iter_16_3[1]
			end
		end
	end

	return 0
end

function DormHeroDeployView:RegisterEvents()
	self:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function()
		self.characterScroll:Refresh()
		self:RefreshPlaceHeroNum()
	end)
	self:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function()
		self.characterScroll:Refresh()
	end)
end

function DormHeroDeployView:AddUIListener()
	self:AddBtnListenerScale(self.backBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListenerScale(self.quickRecall, nil, function()
		local var_22_0 = DormitoryData:GetDormHerosByArchitecture((DormData:GetCurrectSceneID()))

		if #var_22_0 > 0 then
			DormHeroTools:RecallAllHero(var_22_0)
		else
			ShowTips("DORM_NO_HERO_RECALL")
		end
	end)
end

function DormHeroDeployView:OnStartGrabHero(arg_23_1)
	self.curGrabbing = arg_23_1
	self.selHeroID = var_0_3(arg_23_1), DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.UpCharacter)

	self.characterScroll:Refresh()
end

function DormHeroDeployView:OnReleaseGrabHero()
	if self.curGrabbing then
		self.curGrabbing = nil

		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.DownCharacter)

		local var_24_0 = var_0_4()

		if var_24_0 ~= 0 then
			manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, self.curGrabbing, var_24_0)
		end

		self.characterScroll:Refresh()
	end
end

function DormHeroDeployView:NotDragOutYet(arg_25_1)
	return UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self.dragOutRect_, arg_25_1.position, manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera)
end

function DormHeroDeployView:OnBeginDragHeroItem(arg_26_1)
	if not self.curGrabbing then
		self.uilistSrex_:OnBeginDrag(arg_26_1)

		self.alreadyDragOut = false
	end
end

function DormHeroDeployView:OnDragHeroItem(arg_27_1)
	if not self.curGrabbing and not self.alreadyDragOut then
		if self:NotDragOutYet(arg_27_1) then
			self.uilistSrex_:OnDrag(arg_27_1)
		else
			self.uilistSrex_:OnEndDrag(arg_27_1)
			self:TryDragHeroOut(arg_27_1)

			self.alreadyDragOut = true
		end
	end
end

local var_0_5 = {
	[DormEnum.DormHeroState.InCanteenEntrust] = "DORM_HERO_WORK_IN_CANTEEN",
	[DormEnum.DormHeroState.InCanteenJob] = "DORM_HERO_WORK_IN_CANTEEN"
}

function DormHeroDeployView:TryDragHeroOut(arg_28_1)
	if self.curGrabbing then
		return
	end

	if self.selHeroID then
		local var_28_0 = DormData:GetHeroArchiveID(self.selHeroID)
		local var_28_1 = DormData:GetHeroInfo(var_28_0)
		local var_28_2 = var_28_1:GetHeroState()
		local var_28_3 = nullable(var_0_5, var_28_2)

		if var_28_3 then
			ShowTips(GetTips(var_28_3))

			return
		end

		if self:CheckCharacterNumMax() then
			local var_28_4 = DormData:GetCurrectSceneID()

			if BackHomeCfg[var_28_4].type == DormConst.BACKHOME_TYPE.PublicDorm then
				for iter_28_0, iter_28_1 in ipairs((DormitoryData:GetDormArchivesByArchitecture(var_28_4))) do
					if iter_28_1 == var_28_0 then
						ShowTips(GetTips("DORM_HERO_SAME_SET"))

						return
					end
				end

				local var_28_5 = {}

				for iter_28_2, iter_28_3 in ipairs((DormitoryData:GetDormHerosByArchitecture(var_28_4))) do
					table.insert(var_28_5, iter_28_3)
				end

				table.insert(var_28_5, self.selHeroID)
				self:OnStartGrabHero(DormHeroTools.GenerateHeroByDrag(self.selHeroID, arg_28_1))
				DormAction:DeployHeroInRoom(var_28_4, var_28_5, DormEnum.DormDeployType.Place)
			elseif BackHomeCfg[var_28_4].type == DormConst.BACKHOME_TYPE.PrivateDorm then
				if var_28_2 == DormEnum.DormHeroState.InPrivateDorm then
					local var_28_6 = var_28_1:GetHeroId()

					if var_28_6 == self.selHeroID then
						return
					end

					DormHeroTools.RemoveHero(var_28_6)
				end

				self:OnStartGrabHero(DormHeroTools.GenerateHeroByDrag(self.selHeroID, arg_28_1))
				DormAction:RecallHeroInPrivateDorm(var_28_4, self.selHeroID)
			end
		else
			ShowTips(GetTips("DORM_LOBBY_SET_MAX"))
		end
	end
end

function DormHeroDeployView:OnEndDragHeroItem(arg_29_1)
	if self.curGrabbing then
		DormLuaBridge.EndGrabPlayerEntity(self.curGrabbing)
		self:OnReleaseGrabHero()
	else
		self.uilistSrex_:OnEndDrag(arg_29_1)
	end
end

function DormHeroDeployView:GetDormHeroList()
	self = self or DormData:GetCurrectSceneID()

	local var_30_1 = DormHeroTools:GetBackHomeCanUseHeroList(self)

	DormTools.SortDormHeroList(var_30_1)

	return var_30_1
end

function DormHeroDeployView:RefreshDormHeroList()
	self.dataList_ = DormHeroDeployView.GetDormHeroList()

	self.characterScroll:StartScroll(#self.dataList_)
end

function DormHeroDeployView:CheckCharacterNumMax()
	if BackHomeCfg[self.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		local var_32_0 = DormitoryData:GetDormSceneData(self.roomID).archiveIDList

		if var_32_0 then
			local var_32_1 = DormCharacterManager.GetInstance():GetCharacterNum()

			var_32_1 = var_32_1 or 0

			if #var_32_0 >= self.maxNum or var_32_1 >= self.maxNum then
				return false
			else
				return true
			end
		end
	else
		return true
	end
end

function DormHeroDeployView:RefreshPlaceHeroNum()
	if BackHomeCfg[self.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		local var_33_0 = DormitoryData:GetDormSceneData(self.roomID).archiveIDList

		self.curnumText_.text = var_33_0 and #var_33_0 or 0

		local var_33_1 = false

		for iter_33_0, iter_33_1 in ipairs(var_33_0) do
			if DormData:GetHeroFatigue(iter_33_1) >= GameSetting.canteen_hero_fatigue_max.value[1] then
				var_33_1 = true

				break
			end
		end

		if var_33_1 then
			self.allCharacterController:SetSelectedState("true")
		else
			self.allCharacterController:SetSelectedState("false")
		end
	else
		self.curnumText_.text = DormData:GetHeroInfo(DormitoryData:GetDormSceneData(self.roomID).archiveIDList[1]):GetHeroState() == DormEnum.DormHeroState.InPrivateDorm and 1 or 0
	end
end

function DormHeroDeployView:Dispose()
	if self.characterScroll then
		self.characterScroll:Dispose()
	end

	self.uilistSrex_.ExitScrollArea:RemoveAllListeners()
	DormHeroDeployView.super.Dispose(self)
end

return DormHeroDeployView
