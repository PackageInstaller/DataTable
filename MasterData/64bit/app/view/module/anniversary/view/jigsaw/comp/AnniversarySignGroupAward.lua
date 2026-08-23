local var_0_0 = g.core.model.User.anniversaryData
local AnniversarySignGroupAward = class("AnniversarySignGroupAward", require("app.fairyGUI.anniversary.UI_AnniversarySignGroupAward"))

function AnniversarySignGroupAward:updateGroupAward(arg_1_1)
	self.m_iconComp:updateIcon(g.core.common.Drops:getGoodsArray(var_0_0:getJigsawGroupInfo(arg_1_1).reward)[1])
	self.m_isAwardController:setSelectedIndex(var_0_0:isGetGroupAward(arg_1_1) and 1 or 0)
	self.m_star:setURL(var_0_0:getActivityResource("ui_cocos", "pic_xmhy_xing1.png"))
	self.m_star1:setURL(var_0_0:getActivityResource("ui_cocos", "pic_xmhy_xing2.png"))
end

function AnniversarySignGroupAward:playBigAwardTransition()
	self.m_isAwardController:setSelectedIndex(1)
	self.m_getBigTransition:play()
end

return AnniversarySignGroupAward
