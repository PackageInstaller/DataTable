local StormSkillTreeLayer = class("StormSkillTreeLayer", require("app.fairyGUI.storm.UI_StormSkillTreeLayer"), function()
	return fgui.GComponent:create({
		resName = "StormSkillTreeLayer",
		pkgPath = "ui/storm/storm",
		isFullScreen = true,
		pkgName = "storm"
	}, ...)
end)

function StormSkillTreeLayer:ctor()
	self:showAtCenter()
	self:getView():setSize(display.width, display.height)
	self:updateRes()
	self.m_attrAddBtn:addClickListener(handler(self, self._onShowInfoBtnClick))
	self.m_resetBtn:addClickListener(handler(self, self._onClickReset))
end

function StormSkillTreeLayer:updateRes()
	self.m_skillPointComp:updateResBtn({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_STORM_SKILL_POINT,
		updateResFunc = function()
			return g.core.model.User.stormData:getSkillPoint()
		end
	})
end

function StormSkillTreeLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BUY_COMMON_PLAY_NUM, self._onRcvBuyPlayNum, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_SKILLRESET, self._onRcvSkillReset, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_SKILLLVUP, self._onRcvSkillLvUp, self)
	self:_updateView()
end

function StormSkillTreeLayer:_updateView()
	self.m_resetTimesTxt:setText(g.core.lang:get(304518, {
		num = g.core.model.User.shopData:getBuyLimitLeft((g.core.config.play_num_info.get(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.STORM_RESET_SKILL)))
	}))
	self.m_skillTreeComp:updateView()
end

function StormSkillTreeLayer:_onRcvSkillLvUp()
	self.m_skillTreeComp:updateView()
end

function StormSkillTreeLayer:_onShowInfoBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.storm.view.pop.StormSkillAttrShowPop").new(), {
		touchDisappear = true
	})
end

function StormSkillTreeLayer:_onClickReset()
	if g.core.model.User.shopData:getBuyLimitLeft((g.core.config.play_num_info.get(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.STORM_RESET_SKILL))) == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1073))

		return
	end

	if g.core.model.User.stormData:getCostSkillPoint() == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1204))
	else
		local var_9_0 = g.core.config.play_num_info.get(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.STORM_RESET_SKILL)
		local var_9_1 = var_9_0.toObject()

		var_9_1.price_type_1 = var_9_1.price_type
		var_9_1.price_value_1 = var_9_1.price_value
		var_9_1.price_add_id_1 = var_9_1.price_add_id
		var_9_1.price_add_id_2 = 0
		var_9_1.price_type_2 = 0
		self._resetInfo = var_9_0

		local var_9_2 = fgui.UIPackage:createObject("storm", "StormSkillResetTipComp")

		var_9_2:updateCost({
			type = g.core.common.Goods.TYPE_GOLD,
			size = g.core.model.User.shopData:getBuyItemPrice(var_9_1, 1)
		})
		g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(304519),
			childComp = var_9_2,
			onConfirm = handler(self, self._onResetConfirm)
		})))
	end
end

function StormSkillTreeLayer:_onResetConfirm()
	g.core.network.GameNetProxy:send_C2S_BuyCommonPlayNum({
		num = 1,
		id = self._resetInfo.id
	})
end

function StormSkillTreeLayer:_onRcvSkillReset()
	self:_updateView()
	self:updateRes()
end

function StormSkillTreeLayer:_onRcvBuyPlayNum(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3.info and arg_12_3.info.id == g.core.const.ConstMgr.ShopConst.PLAY_TYPE.STORM_RESET_SKILL then
		g.core.network.GameNetProxy:send_C2S_Storm_SkillReset({})
	end
end

return StormSkillTreeLayer
