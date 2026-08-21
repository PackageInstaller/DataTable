local var_0_0 = class("AutoChessIllustratedAdminSkillPanel", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.skillItemList = {}
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.switchController_ = arg_3_0.switchController_:GetController("switch")
	arg_3_0.skillList = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, AutoChessAdminSkillItem)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0.beginStar = 2

	for iter_4_0 = arg_4_0.beginStar, 4 do
		local var_4_0 = string.format("switchBtn%s_", iter_4_0)

		arg_4_0:AddBtnListener(arg_4_0[var_4_0], nil, function()
			arg_4_0:ChangeSwitchStar(iter_4_0)
		end)
	end
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.skillDataList[arg_6_1]

	arg_6_2:RefreshUI(var_6_0[1], arg_6_0.selectSwitchStar)
end

function var_0_0.ChangeSwitchStar(arg_7_0, arg_7_1)
	if arg_7_0.selectSwitchStar == arg_7_1 then
		return
	end

	arg_7_0.selectSwitchStar = arg_7_1

	arg_7_0:RefreshStarUI(arg_7_1)
	arg_7_0.switchController_:SetSelectedIndex(arg_7_1 - arg_7_0.beginStar)
	saveData("AutoChess", "IllustratedSkillSwitch", arg_7_1)
end

function var_0_0.RefreshStarUI(arg_8_0, arg_8_1)
	local var_8_0 = AutoChessTools.GetAdminSkillList(arg_8_1)

	arg_8_0.skillDataList = var_8_0

	arg_8_0.skillList:StartScroll(#var_8_0)
end

function var_0_0.GetDefaultSwitch(arg_9_0)
	return getData("AutoChess", "IllustratedSkillSwitch") or 2
end

function var_0_0.OnEnter(arg_10_0)
	local var_10_0 = arg_10_0:GetDefaultSwitch()

	arg_10_0:ChangeSwitchStar(var_10_0)
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0.selectSwitchStar = nil
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.skillItemList or {}) do
		if iter_12_1 then
			iter_12_1:Dispose()

			iter_12_1 = nil
		end
	end

	if arg_12_0.skillList then
		arg_12_0.skillList:Dispose()

		arg_12_0.skillList = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
