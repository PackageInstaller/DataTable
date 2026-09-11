local AutoChessIllustatedAdminSkillItem = class("AutoChessIllustatedAdminSkillItem", ReduxView)

function AutoChessIllustatedAdminSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AutoChessIllustatedAdminSkillItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AutoChessIllustatedAdminSkillItem:InitUI()
	self:BindCfgUI()

	self.gradeController_ = self.controllerEx_:GetController("grade")
	self.richText_ = self:FindCom("RichText", "", self.buffDescText_.transform)

	TerminologyTools.AddTerminologyHandler(self, self.richText_, nil, nil)
end

function AutoChessIllustatedAdminSkillItem:AddUIListener()
	return
end

function AutoChessIllustatedAdminSkillItem:RefreshUI(arg_5_1, arg_5_2)
	local var_5_0 = AutoChessTools.GetChessBuffStr(nil, nil, arg_5_1)

	self.richText = RichTextTools.SetMixedTextWithImage(self.richText_, var_5_0)
	self.richText_.text = var_5_0

	self.gradeController_:SetSelectedIndex(arg_5_2 - 1)

	self.skillIcon_.sprite = AutoChessTools.GetBuffIcon(AutoChessBuffCfg[arg_5_1].icon)
end

function AutoChessIllustatedAdminSkillItem:Dispose()
	AutoChessIllustatedAdminSkillItem.super.Dispose(self)
end

return AutoChessIllustatedAdminSkillItem
