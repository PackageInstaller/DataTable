local PinballBossInfoView = class("PinballBossInfoView", ReduxView)

function PinballBossInfoView:UIName()
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballBossMessagePopUI"
end

function PinballBossInfoView:UIParent()
	return manager.ui.uiPop.transform
end

local var_0_1 = 3
local var_0_2 = class("PinballBossInfoView.PropItem", (import("game.views.activity.Submodule.Pinball.PinballCharaPropItem")))

function var_0_2:UpdatePropValueText(arg_3_1)
	self.value_.text = GetTipsF("PINBALL_MONSTER_ATTRIBUTE", arg_3_1)
end

function PinballBossInfoView:Init()
	self:BindCfgUI()

	self.props = {}

	for iter_4_0 = 1, var_0_1 do
		table.insert(self.props, (var_0_2.New(self[string.format("prop%d_", iter_4_0)])))
	end

	self.skills = {}

	self:AddBtnListenerScale(self.backBtn_, nil, JumpTools.Back)
end

function PinballBossInfoView:Dispose()
	for iter_5_0, iter_5_1 in pairs(self.props) do
		iter_5_1:Dispose()
	end

	self.props = nil

	for iter_5_2, iter_5_3 in pairs(self.skills) do
		iter_5_3:Dispose()
	end

	self.skills = nil

	PinballBossInfoView.super.Dispose(self)
end

local var_0_3 = {
	3000,
	500,
	500
}

function PinballBossInfoView:OnEnter()
	self:SetData(self.params_.id, nil)
end

function PinballBossInfoView:OnTop()
	manager.windowBar:HideBar()
end

function PinballBossInfoView:OnBehind()
	manager.windowBar:HideBar()
end

function PinballBossInfoView:SetData(arg_9_1, arg_9_2)
	self.level_.text = ""
	self.name_.text = PinballPlayerCfg[arg_9_1].desc
	self.headIcon_.spriteSync = PinballTools.GetBossIconPath(arg_9_1)
	self.img_.spriteSync = PinballTools.GetBossFullImgPath(arg_9_1)

	for iter_9_0 = 1, var_0_1 do
		self.props[iter_9_0]:SetData(nil, PinballPlayerCfg[arg_9_1].base_attributes[iter_9_0], var_0_3[iter_9_0])
	end

	self:SetSkillList(PinballPlayerCfg[arg_9_1].skill_list)
end

local function var_0_4(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	for iter_10_0 = 1, math.max(arg_10_1, #arg_10_0, arg_10_2.childCount) do
		local var_10_0
		local var_10_1

		if arg_10_2.childCount < iter_10_0 then
			var_10_0 = GameObject.Instantiate(arg_10_3, arg_10_2)
		end

		if #arg_10_0 < iter_10_0 then
			if isNil(var_10_0) then
				var_10_0 = arg_10_2:GetChild(iter_10_0 - 1).gameObject
			end

			var_10_1 = PinballCharaSkillItem.New(var_10_0)

			table.insert(arg_10_0, var_10_1)
		end

		var_10_1 = var_10_1 or arg_10_0[iter_10_0]

		var_10_1:SetVisible(iter_10_0 <= arg_10_1)
	end
end

function PinballBossInfoView:SetSkillList(arg_11_1)
	var_0_4(self.skills, #arg_11_1, self.skillsRoot_, self.skillPrefab_)

	for iter_11_0 = 1, #arg_11_1 do
		self.skills[iter_11_0]:SetData(arg_11_1[iter_11_0])
	end
end

function PinballBossInfoView:OnExitInput()
	JumpTools.Back()

	return true
end

return PinballBossInfoView
