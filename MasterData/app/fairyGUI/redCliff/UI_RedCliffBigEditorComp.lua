local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2sem3m7g"

function var_0_0:__ctor()
	self.m_isFertileController = self:getController("isFertile")
	self.m_isBarrierController = self:getController("isBarrier")
	self.m_editorTypeController = self:getController("editorType")
	self.m_icon = self:getChild("icon")
	self.m_knightComp = self:getChild("knightComp")
	self.m_coordTxt = self:getChild("coordTxt")
	self.m_editorTypeTxt = self:getChild("editorTypeTxt")
	self.m_pos = self:getChild("pos")
	self.m_editorScore = self:getChild("editorScore")
	self.m_editorName = self:getChild("editorName")
	self.m_fertileEffect = self:getChild("fertileEffect")
	self.m_outputScore = self:getChild("outputScore")
end

return var_0_0
