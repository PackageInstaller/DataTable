local var_0_0 = class("BattleSkillItem", ReduxView)
local var_0_1 = import("game.const.HeroConst")

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.info_ = arg_1_3

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:InitUI()
	arg_1_0:Init()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.data_ = arg_2_1
	arg_2_0.info_ = arg_2_2

	arg_2_0:Render()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.typeIcon_ = arg_3_0:FindCom(typeof(Image), "type")
	arg_3_0.lvText_ = arg_3_0:FindCom(typeof(Text), "level")
	arg_3_0.nameText_ = arg_3_0:FindCom(typeof(Text), "name")
	arg_3_0.desText_ = arg_3_0:FindCom(typeof(Text), "des")
end

function var_0_0.Init(arg_4_0)
	arg_4_0:RefreshUI(arg_4_0.info_)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.Render(arg_6_0)
	arg_6_0:RefreshUI(arg_6_0.info_)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.lv or 1

	arg_7_0.lvText_.text = "LEVEL " .. var_7_0
end

return var_0_0
