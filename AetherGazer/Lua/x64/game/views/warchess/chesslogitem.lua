local var_0_0 = class("ChessLogItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "conName")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = WarchessContentCfg[arg_4_2]

	arg_4_0.textinfoText_.text = GetI18NText(var_4_0.content)
	arg_4_0.textnameText_.text = GetI18NText(var_4_0.name)

	local var_4_1 = WarChessData:GetCurrentWarChessMapData().mapId
	local var_4_2 = WarchessLevelCfg[var_4_1].log_icon

	arg_4_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Story/Character/" .. var_4_2)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
