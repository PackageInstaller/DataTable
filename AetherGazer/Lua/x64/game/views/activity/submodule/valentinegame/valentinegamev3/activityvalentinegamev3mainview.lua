ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityValentineGameV3MainView", ActivityMainBasePanel)
local var_0_1 = "ACTIVITY_VALENTINE_V3_DES"

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/Alone_ValentineUI/Alone_Valentine_MainUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.btnController_ = arg_2_0.btnControllerEx_:GetController("statelock01")

	if arg_2_0.bg_ then
		arg_2_0.bg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Version/Alone_ValentineUI/Valentine_bg_ST05")
	end
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		JumpTools.OpenPageByJump("/valentineGameV3SelectHeroView", {
			activityID = arg_3_0.activityID_
		})
	end)
	arg_3_0:BindHelpBtn(var_0_1)
end

function var_0_0.OnEnter(arg_5_0)
	var_0_0.super.OnEnter(arg_5_0)

	arg_5_0.btnText_.text = GetTips("ACTIVITY_VALENTINE_V3_BTN")

	arg_5_0:UpdatePreview()
	manager.redPoint:bindUIandKey(arg_5_0.btn_.transform, RedPointConst.VALENTINE_GAME_ENTER .. "_" .. arg_5_0.activityID_)
end

function var_0_0.OnExit(arg_6_0)
	var_0_0.super.OnExit(arg_6_0)
	manager.redPoint:unbindUIandKey(arg_6_0.btn_.transform, RedPointConst.VALENTINE_GAME_ENTER .. "_" .. arg_6_0.activityID_)
end

function var_0_0.isHasLeftTimeDes(arg_7_0)
	return false
end

function var_0_0.RefreshAcvanceStatus(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.btnController_:SetSelectedState("normal01")
	else
		arg_8_0.btnController_:SetSelectedState("lock01")
	end
end

return var_0_0
