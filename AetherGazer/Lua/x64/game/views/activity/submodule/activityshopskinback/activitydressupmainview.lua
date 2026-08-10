ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityDressUpMainView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_DressUpUI/NorseUI_3_0_DressUpMainUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.isClick = false
	arg_3_0.stateCtrl = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		JumpTools.GoToSystem("/rechargeMain", {
			childShopIndex = 2,
			page = 2
		}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
	end)
	arg_4_0.speedBtn_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_6_0, arg_6_1)
		arg_4_0.stateCtrl:SetSelectedIndex(0)

		arg_4_0.anim_1.speed = 2
		arg_4_0.anim_2.speed = 2
	end))
	arg_4_0.speedBtn_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		arg_4_0.anim_1.speed = 7
		arg_4_0.anim_2.speed = 7

		arg_4_0.stateCtrl:SetSelectedIndex(1)
	end))
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
end

function var_0_0.Show(arg_9_0, arg_9_1)
	if arg_9_1 then
		SetActive(arg_9_0.gameObject_, arg_9_1)
		arg_9_0.anim_1:Play("Fx_DressUpMainUI_cx", 0, arg_9_0.normalizedTime_1 or 0)
		arg_9_0.anim_1:Update(0)
		arg_9_0.anim_2:Play("Fx_skin_loop_01", 0, arg_9_0.normalizedTime_2 or 0)
		arg_9_0.anim_2:Update(0)
	else
		if arg_9_0.gameObject_.activeSelf == true then
			local var_9_0 = arg_9_0.anim_1:GetCurrentAnimatorStateInfo(0)
			local var_9_1 = arg_9_0.anim_2:GetCurrentAnimatorStateInfo(0)

			arg_9_0.normalizedTime_1 = var_9_0.normalizedTime
			arg_9_0.normalizedTime_2 = var_9_1.normalizedTime
		end

		SetActive(arg_9_0.gameObject_, arg_9_1)
	end
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.skinList_ = GameSetting.skin_return.value

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.skinList_) do
		arg_10_0["skinImg_" .. iter_10_0].sprite = pureGetSpriteWithoutAtlas("TextureBg/Version/NorseUI_3_0/NorseUI_3_0_DressUpMainUI/" .. iter_10_1)
	end

	local var_10_0 = ActivityData:GetActivityData(arg_10_0.activityID_).stopTime

	arg_10_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_10_0)
	arg_10_0.pressTxt_.text = GetTips("LONG_PRESS_FILM_ACCELERATE")
	arg_10_0.accelerateTxt_.text = GetTips("ACCELERATING")
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.super.Dispose(arg_12_0)
end

function var_0_0.DonotPreDestroy(arg_13_0)
	return true
end

return var_0_0
