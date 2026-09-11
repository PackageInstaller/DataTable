local AutoChessLvInfoItem = class("AutoChessLvInfoItem", ReduxView)

function AutoChessLvInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AutoChessLvInfoItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AutoChessLvInfoItem:InitUI()
	self:BindCfgUI()

	self.lvController_ = self.controllerEx_:GetController("lv")
	self.richText_ = self:FindCom("RichText", "", self.descTrs_)

	TerminologyTools.AddTerminologyHandler(self, self.richText_, self.button_, nil)
end

function AutoChessLvInfoItem:AddUIListener()
	return
end

function AutoChessLvInfoItem:RefreshUI(arg_5_1, arg_5_2)
	local var_5_0 = AutoChessTools.GetChessBuffStr(arg_5_1, arg_5_2)

	self.lvController_:SetSelectedIndex(arg_5_2 - 1)

	self.richText = RichTextTools.SetMixedTextWithImage(self.richText_, var_5_0)
	self.richText.text = var_5_0
end

function AutoChessLvInfoItem:Dispose()
	self.richText_:RemoveAllListeners()
	AutoChessLvInfoItem.super.Dispose(self)
end

return AutoChessLvInfoItem
