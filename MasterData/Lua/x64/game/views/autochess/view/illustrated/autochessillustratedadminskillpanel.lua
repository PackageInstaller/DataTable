local AutoChessIllustratedAdminSkillPanel = class("AutoChessIllustratedAdminSkillPanel", ReduxView)

function AutoChessIllustratedAdminSkillPanel:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AutoChessIllustratedAdminSkillPanel:Init()
	self:InitUI()
	self:AddUIListener()

	self.skillItemList = {}
end

function AutoChessIllustratedAdminSkillPanel:InitUI()
	self:BindCfgUI()

	self.switchController_ = self.switchController_:GetController("switch")
	self.skillList = LuaList.New(handler(self, self.IndexItem), self.listGo_, AutoChessAdminSkillItem)
end

function AutoChessIllustratedAdminSkillPanel:AddUIListener()
	self.beginStar = 2

	for iter_4_0 = self.beginStar, 4 do
		self:AddBtnListener(self[string.format("switchBtn%s_", iter_4_0)], nil, function()
			self:ChangeSwitchStar(iter_4_0)
		end)
	end
end

function AutoChessIllustratedAdminSkillPanel:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(self.skillDataList[arg_6_1][1], self.selectSwitchStar)
end

function AutoChessIllustratedAdminSkillPanel:ChangeSwitchStar(arg_7_1)
	if self.selectSwitchStar == arg_7_1 then
		return
	end

	self.selectSwitchStar = arg_7_1

	self:RefreshStarUI(arg_7_1)
	self.switchController_:SetSelectedIndex(arg_7_1 - self.beginStar)
	saveData("AutoChess", "IllustratedSkillSwitch", arg_7_1)
end

function AutoChessIllustratedAdminSkillPanel:RefreshStarUI(arg_8_1)
	local var_8_0 = AutoChessTools.GetAdminSkillList(arg_8_1)

	self.skillDataList = var_8_0

	self.skillList:StartScroll(#var_8_0)
end

function AutoChessIllustratedAdminSkillPanel:GetDefaultSwitch()
	return getData("AutoChess", "IllustratedSkillSwitch") or 2
end

function AutoChessIllustratedAdminSkillPanel:OnEnter()
	self:ChangeSwitchStar((self:GetDefaultSwitch()))
end

function AutoChessIllustratedAdminSkillPanel:OnExit()
	self.selectSwitchStar = nil
end

function AutoChessIllustratedAdminSkillPanel:Dispose()
	for iter_12_0, iter_12_1 in pairs(self.skillItemList or {}) do
		if iter_12_1 then
			iter_12_1:Dispose()

			iter_12_1 = nil
		end
	end

	if self.skillList then
		self.skillList:Dispose()

		self.skillList = nil
	end

	AutoChessIllustratedAdminSkillPanel.super.Dispose(self)
end

return AutoChessIllustratedAdminSkillPanel
