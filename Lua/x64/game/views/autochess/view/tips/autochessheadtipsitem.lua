local var_0_0 = class("AutoChessHeadTipsItem", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Com/Com_Tips"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_7_0)
	if arg_7_0.params_.type == 1 then
		arg_7_0.tipsTrans_.anchoredPosition = Vector2.New(-54, -170)
	else
		arg_7_0.tipsTrans_.anchoredPosition = Vector2.New(-116, -160)
	end

	local var_7_0 = AutoChessTools.GetAutoChessHeadIndex()

	arg_7_0.nickText_.text = PlayerData:GetPlayerInfo().nick

	local var_7_1 = GameSetting.auto_chess_easter_keys.value
	local var_7_2 = GameSetting.auto_chess_expression_icons.value

	arg_7_0.desc_.text = GetTips(var_7_1[var_7_0])
	arg_7_0.iconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Home_img/" .. var_7_2[var_7_0])
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
