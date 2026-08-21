local var_0_0 = class("MardukSpecialItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.detailController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "detail")
	arg_3_0.raceController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "race")
	arg_3_0.viewController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "view")
	arg_3_0.detailraceController_ = ControllerUtil.GetController(arg_3_0.detailtrans_, "color")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_4_0.subActivityId_) then
			if ActivityData:GetActivityData(arg_4_0.subActivityId_).stopTime < manager.time:GetServerTime() then
				ShowTips(GetTips("TIME_OVER"))
			else
				local var_5_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_4_0.subActivityId_).startTime)

				ShowTips(string.format(GetTips("OPEN_TIME"), var_5_0))
			end

			return
		end

		if arg_4_0.itemSelectHandler_ ~= nil then
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.transform_)
			arg_4_0.itemSelectHandler_(arg_4_0.index_, true)
		end

		MardukSpecialAction.ClickMardukSpecial(arg_4_0.subActivityId_)
		arg_4_0:UpdateRedPoint()
	end)
	arg_4_0:AddBtnListener(arg_4_0.closeBtn_, nil, function()
		if arg_4_0.itemSelectHandler_ ~= nil then
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.transform_)
			arg_4_0.itemSelectHandler_(arg_4_0.index_, false)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.readyBtn_, nil, function()
		local var_7_0 = BattleQuickTrainingCfg[ActivityQuickTrainingCfg[arg_4_0.subActivityId_].stage_id]

		gameContext:Go("/sectionSelectHero", {
			section = var_7_0.id,
			sectionType = BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL,
			activityID = arg_4_0.subActivityId_
		})
	end)
end

function var_0_0.AddEventListeners(arg_8_0)
	return
end

function var_0_0.ShowSelect(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.detailController_:SetSelectedState("true")
	else
		arg_9_0.detailController_:SetSelectedState("false")
	end
end

function var_0_0.SetItemSelectHandler(arg_10_0, arg_10_1)
	arg_10_0.itemSelectHandler_ = arg_10_1
end

function var_0_0.SetData(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.index_ = arg_11_1
	arg_11_0.activityId_ = arg_11_2
	arg_11_0.subActivityId_ = arg_11_3
	arg_11_0.battleCfg_ = BattleQuickTrainingCfg[ActivityQuickTrainingCfg[arg_11_0.subActivityId_].stage_id]

	arg_11_0:UpdateView()
end

function var_0_0.UpdateView(arg_12_0)
	local var_12_0 = ActivityData:GetActivityIsOpen(arg_12_0.subActivityId_)

	arg_12_0.nameLabel1_.text = GetI18NText(arg_12_0.battleCfg_.name)
	arg_12_0.nameLabel2_.text = GetI18NText(arg_12_0.battleCfg_.name)
	arg_12_0.descLabel_.text = GetI18NText(arg_12_0.battleCfg_.tips)
	arg_12_0.scoreLabel1_.text = MardukSpecialData:GetPoint(arg_12_0.subActivityId_)
	arg_12_0.scoreLabel2_.text = MardukSpecialData:GetPoint(arg_12_0.subActivityId_)

	if var_12_0 then
		arg_12_0.viewController_:SetSelectedState("open")
		arg_12_0.raceController_:SetSelectedIndex(arg_12_0.index_ - 1)
		arg_12_0.detailraceController_:SetSelectedIndex(arg_12_0.index_ - 1)
	else
		arg_12_0.viewController_:SetSelectedState("close")
		arg_12_0.raceController_:SetSelectedIndex(arg_12_0.index_ - 1)
		arg_12_0.detailraceController_:SetSelectedIndex(arg_12_0.index_ - 1)

		local var_12_1 = ActivityData:GetActivityData(arg_12_0.subActivityId_)
		local var_12_2 = var_12_1.stopTime

		if var_12_1.stopTime < manager.time:GetServerTime() then
			arg_12_0.timeCntText_.text = GetTips("TIME_OVER")
		else
			local var_12_3 = manager.time:GetLostTimeStr(var_12_1.startTime)

			arg_12_0.timeCntText_.text = string.format(GetTips("OPEN_TIME"), var_12_3)
		end
	end

	arg_12_0:UpdateRedPoint()
end

function var_0_0.UpdateTime(arg_13_0)
	if not ActivityData:GetActivityIsOpen(arg_13_0.subActivityId_) then
		local var_13_0 = ActivityData:GetActivityData(arg_13_0.subActivityId_)

		if var_13_0.stopTime < manager.time:GetServerTime() then
			arg_13_0.timeCntText_.text = GetTips("TIME_OVER")
		else
			local var_13_1 = manager.time:GetLostTimeStr(var_13_0.startTime)

			arg_13_0.timeCntText_.text = string.format(GetTips("OPEN_TIME"), var_13_1)
		end
	end
end

function var_0_0.UpdateRedPoint(arg_14_0)
	SetActive(arg_14_0.redGo_, manager.redPoint:getTipValue(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, arg_14_0.subActivityId_)) > 0 and true or false)
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:AddEventListeners()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_17_0)
	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.data_ = nil

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
