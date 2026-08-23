local var_0_0 = g.core.model.User.resourceData
local var_0_1 = g.core.common.Goods.RESOURCE.TYPE_ROB_NUM
local var_0_2 = g.core.config.basic_figure_info
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.const.ConstMgr.ShopConst
local ExploreNumRefreshComp = class("ExploreNumRefreshComp", require("app.fairyGUI.robTreasure.UI_ExploreNumRefreshComp"))

function ExploreNumRefreshComp:ctor()
	self._robLimitNum = var_0_2.get(2).time_limit

	self.m_addBtn:addClickListener(handler(self, self._onClickAdd))
end

function ExploreNumRefreshComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RECOVER_NOTIFY, self._onRecoverOne, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RECOVER_STEP, self._onRecoverStep, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, self.updateNum, self)
end

function ExploreNumRefreshComp:updateNum()
	local var_3_0 = g.core.model.User.resourceData:getRobNum()

	self.m_numTxt:setText(var_3_0)

	if var_3_0 >= self._robLimitNum then
		self.m_isMaxController:setSelectedIndex(1)
	else
		self.m_isMaxController:setSelectedIndex(0)
	end

	if var_3_0 <= 0 then
		self.m_hasNumController:setSelectedIndex(0)
	else
		self.m_hasNumController:setSelectedIndex(1)
	end

	return var_3_0
end

function ExploreNumRefreshComp:_onClickAdd()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
		type = var_0_3.TYPE_ITEM,
		value = var_0_3.ITEM.TYPE_ROB_TOKEN,
		shopId = var_0_4.SHOP_ITEM_ID.ROB_TREASURE_TOKEN
	}), {
		touchDisappear = true
	})
end

function ExploreNumRefreshComp:_onRecoverStep(arg_5_1, arg_5_2)
	if arg_5_2.info.value == var_0_1 then
		if arg_5_2.isMax then
			self.m_isMaxController:setSelectedIndex(1)
		else
			local var_5_0 = {}

			var_5_0.time = g.core.common.ServerTime:_secondToString(arg_5_2.nextCountdown)

			self.m_timeTxt:setText((g.core.lang:get(304010, var_5_0)))
		end
	end
end

function ExploreNumRefreshComp:_onRecoverOne(arg_6_1, arg_6_2)
	if arg_6_2.info.value == var_0_1 then
		var_0_0:setRobNum(arg_6_2 and arg_6_2.curValue)
		self.m_numTxt:setText((var_0_0:getRobNum()))

		if arg_6_2.isMax then
			self.m_isMaxController:setSelectedIndex(1)
		end
	end
end

return ExploreNumRefreshComp
