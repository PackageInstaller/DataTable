local var_0_0 = class("DormCharacterItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.characterStateController = ControllerUtil.GetController(arg_2_0.transform_, "name")
	arg_2_0.fatigueController = ControllerUtil.GetController(arg_2_0.transform_, "fatigue")
	arg_2_0.positionController = ControllerUtil.GetController(arg_2_0.transform_, "position")
	arg_2_0.curPisitionController = ControllerUtil.GetController(arg_2_0.transform_, "currentPosition")
	arg_2_0.maskController = ControllerUtil.GetController(arg_2_0.transform_, "mask")
	arg_2_0.sameNameController = ControllerUtil.GetController(arg_2_0.transform_, "sameName")
end

function var_0_0.AddUIListener(arg_3_0)
	local var_3_0 = arg_3_0:FindCom("EventTriggerListener")

	function var_3_0.onPointerDown()
		if not arg_3_0.canClick and arg_3_0.downFunc then
			arg_3_0.downFunc(arg_3_0.heroID)
		end
	end

	function var_3_0.onBeginDrag(arg_5_0, arg_5_1)
		arg_3_0:BeginDrag(arg_5_1)
	end

	function var_3_0.onEndDrag(arg_6_0, arg_6_1)
		arg_3_0:EndDrag(arg_6_1)
	end

	function var_3_0.onDrag(arg_7_0, arg_7_1)
		arg_3_0:Drag(arg_7_1)
	end

	arg_3_0:SetListener(var_3_0)
	arg_3_0:AddBtnListenerScale(arg_3_0.recallbtnBtn_, nil, function()
		if not arg_3_0.canClick and arg_3_0.recallHero then
			arg_3_0.recallHero(arg_3_0.heroID)
		end
	end)
end

function var_0_0.RefreshUI(arg_9_0, arg_9_1, arg_9_2)
	if DormNpcTools:CheckIDIsNpc(arg_9_1) then
		arg_9_0:RefreshNpcInfo(arg_9_1, arg_9_2)
	else
		arg_9_0:RefreshHeroInfo(arg_9_1, arg_9_2)
	end
end

function var_0_0.RefreshNpcInfo(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.heroID = arg_10_1
	arg_10_0.iconImg_.sprite = DormNpcTools:GetNpcHeadSprite(arg_10_1)

	if DormNpcTools:GetNpcFatigue(arg_10_1) < 0 then
		arg_10_0.fatigueController:SetSelectedState("infinitew")
	end
end

local var_0_1 = import("game.dorm.DormEnum")
local var_0_2 = {
	[var_0_1.DormHeroState.InCanteenJob] = "canteen",
	[var_0_1.DormHeroState.InCanteenEntrust] = "task",
	[var_0_1.DormHeroState.InPublicDorm] = "lobby",
	[var_0_1.DormHeroState.InIdolTraineeCamp] = "idolCamp"
}
local var_0_3 = {
	[var_0_1.DormHeroState.InCanteenJob] = true,
	[var_0_1.DormHeroState.InCanteenEntrust] = true,
	[var_0_1.DormHeroState.InPublicDorm] = true,
	[var_0_1.DormHeroState.InPrivateDorm] = true,
	[var_0_1.DormHeroState.InIdolTraineeCamp] = true
}

function var_0_0.EnableRecall(arg_11_0)
	local var_11_0 = DormData:GetCurrectSceneID()

	if nullable(BackHomeCfg, var_11_0, "type") == DormConst.BACKHOME_TYPE.PublicDorm and DormHeroTools:CheckHeroInRoom(var_11_0, arg_11_0.archiveID) then
		return true
	end

	return false
end

function var_0_0.RefreshHeroInfo(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 then
		arg_12_0.heroID = arg_12_1
		arg_12_0.archiveID = DormData:GetHeroArchiveID(arg_12_1)

		local var_12_0 = DormData:GetHeroTemplateInfo(arg_12_0.heroID)

		if var_12_0 then
			arg_12_0.iconImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_12_1)

			if not arg_12_0.showFatigue then
				arg_12_0.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]

				local var_12_1 = var_12_0:GetFatigue()

				arg_12_0.curText_.text = var_12_1
				arg_12_0.progressImg_.fillAmount = 1 - math.min(var_12_1 / GameSetting.canteen_hero_fatigue_max.value[1], 1)

				local var_12_2 = GameDisplayCfg.dorm_hero_fatigue_level.value

				if var_12_0:GetFatigue() <= var_12_2[1] then
					arg_12_0.fatigueController:SetSelectedState("low")
				else
					arg_12_0.fatigueController:SetSelectedState("suff")
				end
			else
				arg_12_0.fatigueController:SetSelectedState("none")
			end

			if not arg_12_0.showState then
				arg_12_0.state = var_12_0:GetHeroState()

				local var_12_3 = nullable(var_0_2, arg_12_0.state) or "dorm"

				arg_12_0.curPisitionController:SetSelectedState(var_12_3)

				if var_12_3 == "dorm" then
					arg_12_0.postextText_.text = GetTips("DORM_HERO_AT_DORM")
				elseif var_12_3 == "lobby" then
					arg_12_0.postextText_.text = GetTips("DORM_HERO_AT_LOBBY")
				elseif var_12_3 == "canteen" then
					arg_12_0.postextText_.text = GetTips("DORM_HERO_AT_CANTEEN")
				elseif var_12_3 == "task" then
					arg_12_0.postextText_.text = GetTips("DORM_HERO_AT_TASK")
				elseif var_12_3 == "idolCamp" then
					arg_12_0.postextText_.text = GetTips("DORM_HERO_AT_IDOLCAMP")
				end

				local var_12_4 = nullable(var_0_3, arg_12_0.state) and "busy" or "normal"

				arg_12_0.positionController:SetSelectedState(var_12_4)
			else
				arg_12_0.positionController:SetSelectedState("normal")
			end

			if not arg_12_0.canClick then
				if arg_12_0.selFunc then
					arg_12_0.selFunc(arg_12_0.heroID, arg_12_2, arg_12_0.characterStateController)
				else
					arg_12_0.characterStateController:SetSelectedState("normal")
					arg_12_0.sameNameController:SetSelectedState("false")

					local var_12_5 = DormData:GetHeroArchiveID(arg_12_2)

					if arg_12_0.archiveID == var_12_5 then
						if arg_12_2 == arg_12_0.heroID then
							if arg_12_0:EnableRecall() then
								arg_12_0.characterStateController:SetSelectedState("select_recall")
							else
								arg_12_0.characterStateController:SetSelectedState("select")
							end
						else
							arg_12_0.positionController:SetSelectedState("normal")
							arg_12_0.sameNameController:SetSelectedState("true")
						end
					end
				end
			end

			arg_12_0.maskController:SetSelectedState("false")

			if arg_12_0.maskFunc and arg_12_0.maskFunc(arg_12_0.heroID) then
				arg_12_0.maskController:SetSelectedState("true")
			end
		end
	end
end

function var_0_0.SetCanClickAndState(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.showState = arg_13_1
	arg_13_0.canClick = arg_13_2
	arg_13_0.showFatigue = arg_13_3
end

function var_0_0.RefreshState(arg_14_0)
	arg_14_0.state = DormData:GetHeroTemplateInfo(arg_14_0.heroID):GetHeroState()

	local var_14_0 = nullable(var_0_2, arg_14_0.state) or "dorm"

	arg_14_0.curPisitionController:SetSelectedState(var_14_0)

	if var_14_0 == "dorm" then
		arg_14_0.postextText_.text = GetTips("DORM_HERO_AT_DORM")
	elseif var_14_0 == "lobby" then
		arg_14_0.postextText_.text = GetTips("DORM_HERO_AT_LOBBY")
	elseif var_14_0 == "canteen" then
		arg_14_0.postextText_.text = GetTips("DORM_HERO_AT_CANTEEN")
	elseif var_14_0 == "task" then
		arg_14_0.postextText_.text = GetTips("DORM_HERO_AT_TASK")
	elseif var_14_0 == "idolCamp" then
		arg_14_0.postextText_.text = GetTips("DORM_HERO_AT_IDOLCAMP")
	end

	local var_14_1 = nullable(var_0_3, arg_14_0.state) and "busy" or "normal"

	arg_14_0.positionController:SetSelectedState(var_14_1)
end

function var_0_0.RecallHero(arg_15_0, arg_15_1)
	arg_15_0.recallHero = arg_15_1
end

function var_0_0.SetOnPointerDown(arg_16_0, arg_16_1)
	arg_16_0.downFunc = arg_16_1
end

function var_0_0.ShowMaskCallBack(arg_17_0, arg_17_1)
	if arg_17_1 then
		arg_17_0.maskFunc = arg_17_1
	end
end

function var_0_0.SelCallBack(arg_18_0, arg_18_1)
	if arg_18_1 then
		arg_18_0.selFunc = arg_18_1
	end
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:RemoveAllListeners()

	if not arg_19_0.canClick and arg_19_0.onClickCom_ then
		arg_19_0.onClickCom_.onValueChanged:RemoveAllListeners()
	end

	var_0_0.super.Dispose(arg_19_0)
end

function var_0_0.BeginDrag(arg_20_0, arg_20_1)
	manager.notify:CallUpdateFunc("OnBeginDragHeroItem", arg_20_1)
end

function var_0_0.Drag(arg_21_0, arg_21_1)
	manager.notify:CallUpdateFunc("OnDragHeroItem", arg_21_1)
end

function var_0_0.EndDrag(arg_22_0, arg_22_1)
	manager.notify:CallUpdateFunc("OnEndDragHeroItem", arg_22_1)
end

return var_0_0
