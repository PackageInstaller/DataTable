local var_0_0 = class("ActivityToggleSpecialItem", ReduxView)

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

	arg_3_0.activityOpenHandler_ = handler(arg_3_0, arg_3_0.ActivityOpen)
	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
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
	arg_4_0:AddBtnListener(arg_4_0.readyBtn_, nil, function()
		local var_6_0 = BattleQuickTrainingCfg[ActivityQuickTrainingCfg[arg_4_0.subActivityId_].stage_id]

		gameContext:Go("/sectionSelectHero", {
			section = var_6_0.id,
			sectionType = BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL,
			activityID = arg_4_0.subActivityId_
		})
	end)
end

function var_0_0.AddEventListeners(arg_7_0)
	manager.notify:RegistListener(ACTIVITY_UPDATE, arg_7_0.activityOpenHandler_)
end

function var_0_0.ShowSelect(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.statusController_:SetSelectedState("select")

		arg_8_0.panelTrans_.sizeDelta = Vector2(arg_8_0.panelTrans_.rect.width, 470)
	else
		arg_8_0.statusController_:SetSelectedState("normal")

		arg_8_0.panelTrans_.sizeDelta = Vector2(arg_8_0.panelTrans_.rect.width, 140)
	end
end

function var_0_0.ActivityOpen(arg_9_0, arg_9_1)
	if arg_9_1 == arg_9_0.subActivityId_ then
		arg_9_0:UpdateView()
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

	arg_12_0.nameLabel1_.text = arg_12_0.battleCfg_.name
	arg_12_0.descLabel_.text = arg_12_0.battleCfg_.tips
	arg_12_0.scoreLabel1_.text = MardukSpecialData:GetPoint(arg_12_0.subActivityId_)

	local var_12_1 = ActivityQuickTrainingCfg[arg_12_0.subActivityId_]

	arg_12_0.bgImage_.sprite = getSprite("Atlas/XuHeng3rdUI", var_12_1.bg_id)
	arg_12_0.iconImage_.sprite = getSprite("Atlas/CampItemAtlas", var_12_1.icon_id)

	if var_12_0 then
		arg_12_0.statusController_:SetSelectedState("normal")

		arg_12_0.panelTrans_.sizeDelta = Vector2(arg_12_0.panelTrans_.rect.width, 140)
	else
		arg_12_0.statusController_:SetSelectedState("lock")

		arg_12_0.panelTrans_.sizeDelta = Vector2(arg_12_0.panelTrans_.rect.width, 140)

		local var_12_2 = ActivityData:GetActivityData(arg_12_0.subActivityId_)
		local var_12_3 = var_12_2.stopTime

		if var_12_2.stopTime < manager.time:GetServerTime() then
			arg_12_0.timeCntText_.text = GetTips("TIME_OVER")
		else
			local var_12_4 = manager.time:GetLostTimeStr(var_12_2.startTime)

			arg_12_0.timeCntText_.text = string.format(GetTips("OPEN_TIME"), var_12_4)
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

function var_0_0.RemoveAllEventListener(arg_17_0)
	manager.notify:RemoveListener(ACTIVITY_UPDATE, arg_17_0.activityOpenHandler_)
	var_0_0.super.RemoveAllEventListener(arg_17_0)
end

function var_0_0.OnMainHomeViewTop(arg_18_0)
	return
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0.data_ = nil
	arg_19_0.activityOpenHandler_ = nil

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
