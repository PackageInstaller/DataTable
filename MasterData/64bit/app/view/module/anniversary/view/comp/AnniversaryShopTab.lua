local var_0_0 = g.core.const.ConstMgr.AnniversaryConst
local var_0_1 = g.core.model.User.anniversaryData
local AnniversaryShopTab = class("AnniversaryShopTab", require("app.fairyGUI.anniversary.UI_AnniversaryShopTab"))

function AnniversaryShopTab:ctor()
	self.m_costNumText:enableRich()
end

function AnniversaryShopTab:updateTab(arg_2_1)
	if not arg_2_1 then
		return
	end

	self.m_bg:setURL(var_0_1:getActivityResource("ui_cocos", "btn_xmhy_shopdi01.png"))
	self.m_selectBg:setURL(var_0_1:getActivityResource("ui_cocos", "btn_xmhy_shopdi02.png"))
	self.m_zhezhao:setURL(var_0_1:getActivityResource("ui_cocos", "btn_xmhy_shopdi_zhezhao.png"))
	self.m_tittle:setText(arg_2_1.name)
	self.m_tittle:setColor(var_0_0.hexToRgb(var_0_1:getAnniversaryInfo().shop_item_color))

	local var_2_0 = var_0_1:getCurScore()
	local var_2_1 = g.core.common.Goods:convert({
		size = 0,
		type = var_0_0.SCORE_TYPE,
		value = var_0_0.SCORE_VALUE
	})

	self.m_stateController:setSelectedIndex(var_2_0 >= arg_2_1.openScoreNum and 0 or 1)
	self.m_costIcon:setURL(var_2_1.icon_mini)
	self.m_costNumText:setText(g.core.lang:get(431611, {
		curNum = var_2_0,
		targetNum = arg_2_1.openScoreNum
	}))
end

return AnniversaryShopTab
