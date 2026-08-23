local var_0_0 = g.core.model.User.fogNightmareData
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.module.ModuleManager
local FogNightmareExploreEnterComp = class("FogNightmareExploreEnterComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreEnterComp"))

function FogNightmareExploreEnterComp:ctor()
	self:_initView()
end

function FogNightmareExploreEnterComp:_initView()
	self.m_startBtn:addClickListener(handler(self, self._onStartBtnClicked))
	self.m_touchComp:addClickListener(handler(self, self._onBuyCompShow))
	self.m_getTimesBtn:addClickListener(handler(self, self._onBuyCompShow))
end

function FogNightmareExploreEnterComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RESOURCE_CHANGE, self._updateTimeText, self)
end

function FogNightmareExploreEnterComp:updateView()
	local var_4_0 = var_0_0:getTowerData():getFastFloors()

	if #var_4_0 > 0 then
		self.m_selectComp:updateBtn(var_4_0)
		self.m_canQuickJumpController:setSelectedIndex(1)
	else
		self.m_canQuickJumpController:setSelectedIndex(0)
	end

	self.m_valueTxt:setText((g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.FOG_NIGHTMARE_EXPLORE)))
	self:_updateTimeText()
end

function FogNightmareExploreEnterComp:_updateTimeText()
	local var_5_0 = var_0_0:getEndTime()

	if var_0_1:getTime() <= var_5_0 then
		self.m_timeText:setText(g.core.lang:get(500103, {
			timeStr = var_0_1:getLeftDHMSFormat(var_5_0)
		}))
	else
		self.m_timeText:setText(g.core.lang:get(500104))
		var_0_2:replaceModule(g.view.entrance.FOG_NIGHTMARE_RESULT_LAYER)
	end
end

function FogNightmareExploreEnterComp:_onStartBtnClicked()
	local var_6_0 = 1

	if self.m_canQuickJumpController:getSelectedIndex() == 1 then
		var_6_0 = self.m_selectComp:getSelectedFloor()
	end

	var_0_0:getFormationData():updateSelectInfos()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareExploreKnightPoolPop").new({
		showBtn = true,
		floor = var_6_0
	}), {
		touchDisappear = false
	})
end

function FogNightmareExploreEnterComp:_onBuyCompShow()
	require("app.view.base.infoPop.BasePlayNumPop").createPlayNum(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.FOG_NIGHTMARE_EXPLORE_TOKEN, handler(self, self.updateView))
end

return FogNightmareExploreEnterComp
