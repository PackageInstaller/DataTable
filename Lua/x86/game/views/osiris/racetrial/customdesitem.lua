local var_0_0 = class("CustomDesItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

local var_0_1 = {
	"Ⅰ",
	"Ⅱ",
	"Ⅲ",
	"Ⅳ",
	"Ⅴ",
	"Ⅵ",
	"Ⅶ",
	"Ⅷ",
	"Ⅸ"
}

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0
	local var_6_1

	if arg_6_2 then
		var_6_0 = string.format("<size=28>%s%s(%s)</size>", GetI18NText(AffixTypeCfg[arg_6_1[1]].name), var_0_1[arg_6_1[2]], GetTips("IS_LOCK"))
	else
		var_6_0 = string.format("<size=28>%s%s</size>", GetI18NText(AffixTypeCfg[arg_6_1[1]].name), var_0_1[arg_6_1[2]])
	end

	local var_6_2 = string.format("<size=22>%s</size>", getAffixDesc(arg_6_1))

	arg_6_0.text_.text = var_6_0 .. "\n" .. var_6_2
	arg_6_0.icon_.sprite = getAffixSprite(arg_6_1)
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
