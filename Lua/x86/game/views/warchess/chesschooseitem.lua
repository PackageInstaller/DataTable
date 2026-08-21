local var_0_0 = class("ChessChooseItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_1.transform.parent.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "state")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index_ = arg_4_1

	local var_4_0 = WarchessItemCfg[arg_4_2].params[1][1]
	local var_4_1 = WarchessItemCfg[arg_4_2].params[1][2]
	local var_4_2 = AffixTypeCfg[var_4_0].description[1]
	local var_4_3 = GetCfgDescription(var_4_2, var_4_1)

	arg_4_0.textinfoText_.text = var_4_3
	arg_4_0.textnameText_.text = GetI18NText(WarchessItemCfg[arg_4_2].name)
	arg_4_0.iconitemImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", WarchessItemCfg[arg_4_2].icon)

	local var_4_4 = WarchessItemCfg[arg_4_2].item_rare

	arg_4_0.itemrareImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", "board_warcheese_sq_" .. var_4_4)
	arg_4_0.rarebgImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", "bg_bfi_top_" .. var_4_4)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddToggleListener(arg_5_0.selecttglTgl_, function(arg_6_0)
		arg_5_0.func(arg_6_0, arg_5_0.index_)
		OperationRecorder.Record("chess", "select_artifact")
	end)
end

function var_0_0.RegisterListener(arg_7_0, arg_7_1)
	arg_7_0.func = arg_7_1
end

function var_0_0.ResetToggle(arg_8_0)
	arg_8_0.selecttglTgl_.isOn = false
end

function var_0_0.SetSelectState(arg_9_0, arg_9_1)
	arg_9_0.controller_:SetSelectedState(arg_9_1 and 1 or 3)
end

function var_0_0.Dispose(arg_10_0)
	Object.Destroy(arg_10_0.gameObject_)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
