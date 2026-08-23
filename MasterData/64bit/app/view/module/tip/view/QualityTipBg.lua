local QualityTipBg = class("QualityTipBg", require("app.fairyGUI.tip.UI_QualityTipBg"))

function QualityTipBg:setQuality(arg_1_1)
	self.m_qualityLoader:setURL("pic/base_new/quality/pic_rhwzs_pinzhi_" .. arg_1_1 .. ".png")
end

function QualityTipBg:hideQuality()
	self.m_qualityLoader:setVisible(false)
end

return QualityTipBg
