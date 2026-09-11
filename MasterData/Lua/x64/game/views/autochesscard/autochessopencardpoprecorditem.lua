local AutoChessOpenCardPopRecordItem = class("AutoChessOpenCardPopRecordItem", ReduxView)

function AutoChessOpenCardPopRecordItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AutoChessOpenCardPopRecordItem:Init()
	self:BindCfgUI()

	self.colorCon_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
	self.bgController_ = self.controllerEx_:GetController("bg_or_not")
end

function AutoChessOpenCardPopRecordItem:SetItemColor(arg_3_1)
	self.colorCon_:SetSelectedState(tostring(arg_3_1))
end

function AutoChessOpenCardPopRecordItem:RefreshUI(arg_4_1, arg_4_2)
	local var_4_0 = AutoChessCardData:GetOpenCardRecordByIndex(arg_4_1)

	self.num_label.text = manager.time:STimeDescS(var_4_0.openTime, "!%Y/%m/%d %H:%M")
	self.name_label.text = GetI18NText((AutoChessCardTools.GetCardName(var_4_0.cardId)))
	self.type_label.text = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[AutoChessCardCfg[var_4_0.cardId].type])

	self:SetItemColor(AutoChessCardCfg[var_4_0.cardId].type + 2)
	self.bgController_:SetSelectedState(arg_4_2 % 2 == 1 and "bg" or "not_bg")
end

function AutoChessOpenCardPopRecordItem:Dispose()
	AutoChessOpenCardPopRecordItem.super.Dispose(self)
end

return AutoChessOpenCardPopRecordItem
