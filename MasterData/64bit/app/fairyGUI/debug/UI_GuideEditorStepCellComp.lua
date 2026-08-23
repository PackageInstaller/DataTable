local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yjd9r5ibhm"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_tipsShapeController = self:getController("tipsShape")
	self.m_showTipsShapeController = self:getController("showTipsShape")
	self.m_showDialogController = self:getController("showDialog")
	self.m_dialogTypeController = self:getController("dialogType")
	self.m_preShowController = self:getController("preShow")
	self.m_opeTypeController = self:getController("opeType")
	self.m_Txt_comment = self:getChild("Txt_comment")
	self.m_GuideEditorInputComp_stepId = self:getChild("GuideEditorInputComp_stepId")
	self.m_GuideEditorInputComp_resetId = self:getChild("GuideEditorInputComp_resetId")
	self.m_GuideEditorInputComp_gotType1 = self:getChild("GuideEditorInputComp_gotType1")
	self.m_GuideEditorInputComp_gotValue = self:getChild("GuideEditorInputComp_gotValue")
	self.m_GuideEditorInputComp_gotValue2 = self:getChild("GuideEditorInputComp_gotValue2")
	self.m_GuideEditorInputComp_false = self:getChild("GuideEditorInputComp_false")
	self.m_GuideEditorInputComp_falseValue1 = self:getChild("GuideEditorInputComp_falseValue1")
	self.m_GuideEditorInputComp_falseValue2 = self:getChild("GuideEditorInputComp_falseValue2")
	self.m_InputComp_voice = self:getChild("InputComp_voice")
	self.m_Btn_select = self:getChild("Btn_select")
	self.m_Btn_touch_finger = self:getChild("Btn_touch_finger")
	self.m_Btn_dialog_check = self:getChild("Btn_dialog_check")
	self.m_Txt_comment2 = self:getChild("Txt_comment2")
	self.m_super = self:getChild("super")
	self.m_weak = self:getChild("weak")
	self.m_weak_2 = self:getChild("weak")
	self.m_bindScene = self:getChild("bindScene")
	self.m_moduleName = self:getChild("moduleName")
	self.m_showTipsGraphyBtn = self:getChild("showTipsGraphyBtn")
	self.m_jx = self:getChild("jx")
	self.m_yx = self:getChild("yx")
	self.m_tipsGraphyScalex = self:getChild("tipsGraphyScalex")
	self.m_tipsGraphyScaley = self:getChild("tipsGraphyScaley")
	self.m_lbx = self:getChild("lbx")
	self.m_perShow = self:getChild("perShow")
	self.m_SmallDialog = self:getChild("SmallDialog")
	self.m_bigDialog = self:getChild("bigDialog")
	self.m_dialogID = self:getChild("dialogID")
	self.m_dialogRevert = self:getChild("dialogRevert")
	self.m_maskCheck = self:getChild("maskCheck")
	self.m_preShowRes = self:getChild("preShowRes")
	self.m_ope1 = self:getChild("ope1")
	self.m_ope2 = self:getChild("ope2")
	self.m_ope3 = self:getChild("ope3")
	self.m_ope4 = self:getChild("ope4")
	self.m_waitEvent = self:getChild("waitEvent")
	self.m_enterEvent = self:getChild("enterEvent")
	self.m_exitEvent = self:getChild("exitEvent")
	self.m_adId = self:getChild("adId")
	self.m_adDesc = self:getChild("adDesc")
	self.m_followFront = self:getChild("followFront")
	self.m_BtnCanRetick = self:getChild("BtnCanRetick")
	self.m_GuideEditorInputComp_listBindId = self:getChild("GuideEditorInputComp_listBindId")
end

var_0_0.TypeCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.TipsShapeCtrl = {
	page2 = 3,
	page1 = 1,
	page0 = 0
}
var_0_0.ShowTipsShapeCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowDialogCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.DialogTypeCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.PreShowCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.OpeTypeCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
