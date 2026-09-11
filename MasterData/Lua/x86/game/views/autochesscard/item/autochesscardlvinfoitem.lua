local AutoChessCardLvInfoItem = class("AutoChessCardLvInfoItem", ReduxView)

function AutoChessCardLvInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AutoChessCardLvInfoItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AutoChessCardLvInfoItem:InitUI()
	self:BindCfgUI()

	self.lvController_ = self.controllerEx_:GetController("lv")
	self.richText_ = self:FindCom("RichText", "", self.descTrs_)

	TerminologyTools.AddTerminologyHandler(self, self.richText_, self.button_, nil)
end

function AutoChessCardLvInfoItem:AddUIListener()
	return
end

function AutoChessCardLvInfoItem:RefreshUI(arg_5_1, arg_5_2)
	if AutoChessTools.IsPlayerChess(arg_5_1) then
		self.lvController_:SetSelectedIndex(arg_5_2 - 1)

		self.richText_.text = GetTips("AUTO_CHESS_2_ADMIN_SKILL")
	else
		local var_5_0 = AutoChessTools.GetChessBuffStr(arg_5_1, arg_5_2)

		self.lvController_:SetSelectedIndex(arg_5_2 - 1)

		self.richText = RichTextTools.SetMixedTextWithImage(self.richText_, var_5_0)
		self.richText.text = var_5_0
	end
end

function AutoChessCardLvInfoItem:Dispose()
	self.richText_:RemoveAllListeners()
	AutoChessCardLvInfoItem.super.Dispose(self)
end

return AutoChessCardLvInfoItem
