local var_0_0 = class("PinballBossInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballBossMessagePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

local var_0_1 = 3
local var_0_2 = import("game.views.activity.Submodule.Pinball.PinballCharaPropItem")
local var_0_3 = class("PinballBossInfoView.PropItem", var_0_2)

function var_0_3.UpdatePropValueText(arg_3_0, arg_3_1)
	arg_3_0.value_.text = GetTipsF("PINBALL_MONSTER_ATTRIBUTE", arg_3_1)
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.props = {}

	for iter_4_0 = 1, var_0_1 do
		local var_4_0 = var_0_3.New(arg_4_0[string.format("prop%d_", iter_4_0)])

		table.insert(arg_4_0.props, var_4_0)
	end

	arg_4_0.skills = {}

	arg_4_0:AddBtnListenerScale(arg_4_0.backBtn_, nil, JumpTools.Back)
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.props) do
		iter_5_1:Dispose()
	end

	arg_5_0.props = nil

	for iter_5_2, iter_5_3 in pairs(arg_5_0.skills) do
		iter_5_3:Dispose()
	end

	arg_5_0.skills = nil

	var_0_0.super.Dispose(arg_5_0)
end

local var_0_4 = {
	3000,
	500,
	500
}

function var_0_0.OnEnter(arg_6_0)
	local var_6_0 = arg_6_0.params_.id
	local var_6_1

	arg_6_0:SetData(var_6_0, var_6_1)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnBehind(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.level_.text = ""

	local var_9_0 = PinballPlayerCfg[arg_9_1]

	arg_9_0.name_.text = var_9_0.desc
	arg_9_0.headIcon_.spriteSync = PinballTools.GetBossIconPath(arg_9_1)
	arg_9_0.img_.spriteSync = PinballTools.GetBossFullImgPath(arg_9_1)

	for iter_9_0 = 1, var_0_1 do
		local var_9_1

		arg_9_0.props[iter_9_0]:SetData(var_9_1, var_9_0.base_attributes[iter_9_0], var_0_4[iter_9_0])
	end

	arg_9_0:SetSkillList(var_9_0.skill_list)
end

local function var_0_5(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_2.childCount
	local var_10_1 = #arg_10_0

	for iter_10_0 = 1, math.max(arg_10_1, var_10_1, var_10_0) do
		local var_10_2
		local var_10_3

		if var_10_0 < iter_10_0 then
			var_10_2 = GameObject.Instantiate(arg_10_3, arg_10_2)
		end

		if var_10_1 < iter_10_0 then
			if isNil(var_10_2) then
				var_10_2 = arg_10_2:GetChild(iter_10_0 - 1).gameObject
			end

			var_10_3 = PinballCharaSkillItem.New(var_10_2)

			table.insert(arg_10_0, var_10_3)
		end

		var_10_3 = var_10_3 or arg_10_0[iter_10_0]

		var_10_3:SetVisible(iter_10_0 <= arg_10_1)
	end
end

function var_0_0.SetSkillList(arg_11_0, arg_11_1)
	local var_11_0 = #arg_11_1

	var_0_5(arg_11_0.skills, var_11_0, arg_11_0.skillsRoot_, arg_11_0.skillPrefab_)

	for iter_11_0 = 1, var_11_0 do
		arg_11_0.skills[iter_11_0]:SetData(arg_11_1[iter_11_0])
	end
end

function var_0_0.OnExitInput(arg_12_0)
	JumpTools.Back()

	return true
end

return var_0_0
