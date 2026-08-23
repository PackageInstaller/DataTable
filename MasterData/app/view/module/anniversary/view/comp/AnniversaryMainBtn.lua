local var_0_0 = g.core.const.ConstMgr.AnniversaryConst
local var_0_1 = g.core.model.User.anniversaryData
local AnniversaryMainBtn = class("AnniversaryMainBtn", require("app.fairyGUI.anniversary.UI_AnniversaryMainBtn"))

function AnniversaryMainBtn:ctor()
	self:getChild("title"):setColor(var_0_0.hexToRgb(var_0_1:getAnniversaryInfo().entry_button))
	self.m_descBg:setURL(var_0_1:getActivityResource("ui_cocos", "pic_xmhy_yijieshudi.png"))
end

return AnniversaryMainBtn
