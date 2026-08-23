local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostExchangeBuildLayer = class("OutpostExchangeBuildLayer", require("app.fairyGUI.outpost.UI_OutpostExchangeBuildLayer"), function()
	return fgui.GComponent:create({
		resName = "OutpostExchangeBuildLayer",
		pkgPath = "ui/outpost/outpost",
		isFullScreen = true,
		pkgName = "outpost"
	}, ...)
end)

function OutpostExchangeBuildLayer:ctor(arg_2_1)
	self:addBg("bg/outpost/pic_hxsz_jiaoyisuobg.jpg")

	self._buildData = g.core.model.User.outpostData:getBuildData():getBuild({
		type = var_0_0.BuildType.Exchange
	})
	self._callKnightDic = {}

	self:_initLayer()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
end

function OutpostExchangeBuildLayer:_initLayer()
	self.m_itemList:setVirtual(self)
	self.m_itemList:doFairyBatching(false)
	self.m_itemList:setItemRenderer(handler(self, self._onExchangeItemRender))
	self.m_knightList:setVirtual(self)
	self.m_knightList:doFairyBatching(false)
	self.m_knightList:setItemRenderer(handler(self, self._onKnightItemRender))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._changeTabChanged))
	self.m_tabController:setSelectedIndex(0)
	self.m_topBarComp:setResInfoById(382)
	self.m_cellOutTransition:setHook("finish", handler(self, self._onTempCellShowOver))
end

function OutpostExchangeBuildLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_ORDERPROCESS, handler(self, self._updateItemUI), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_LEVELUP, handler(self, self.updateBuildLayer), self)
	self:updateBuildLayer()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self.m_enterTransition:play(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end)
end

function OutpostExchangeBuildLayer:updateBuildLayer()
	self.m_buildInfoComp:updateBuildInfoComp(self._buildData)
	self:_changeTabChanged()
end

function OutpostExchangeBuildLayer:_changeTabChanged()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)

	local var_8_0 = self.m_tabController:getSelectedIndex()

	if var_8_0 == 0 then
		self:_updateItemUI()
		self.m_itemList:transitionShowCells("enter_scaleOut", 0.03, 1)
		self:_onResetKnightList()
	elseif var_8_0 == 1 then
		self:_updateKnightUI()
		self.m_knightList:transitionShowCells("enter_right", 0.03, 1)
	end
end

function OutpostExchangeBuildLayer:_updateItemUI()
	self._itemList = self._buildData:getExchangeItemList(true)

	self.m_itemList:setNumItems(#self._itemList)
end

function OutpostExchangeBuildLayer:_onExchangeItemRender(arg_11_1, arg_11_2)
	arg_11_2:updateRecipeComp(self._itemList[arg_11_1 + 1])
end

function OutpostExchangeBuildLayer:_updateKnightUI()
	self._knightList = {}

	for iter_12_0, iter_12_1 in ipairs((g.core.model.User.outpostData:getKnightsData():getAllLineUpKnights())) do
		if not self._callKnightDic[iter_12_1:getServerId()] then
			local var_12_0 = {}
			local var_12_1 = {
				knight = iter_12_1,
				itemList = var_12_0
			}

			for iter_12_2, iter_12_3 in ipairs((self._buildData:getOrders())) do
				if iter_12_3.num > 0 then
					local var_12_2 = iter_12_1:getOwnItemByItemId(g.core.config.outpost_exchange_item_info.get(iter_12_3.id).item_value)

					if var_12_2 and var_12_2.item_num > 0 then
						var_12_0[#var_12_0 + 1] = var_12_2
					end
				end
			end

			if #var_12_0 > 0 then
				self._knightList[#self._knightList + 1] = var_12_1
			end
		end
	end

	self.m_knightList:setNumItems(#self._knightList)

	if #self._knightList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
	end
end

function OutpostExchangeBuildLayer:_onKnightItemRender(arg_13_1, arg_13_2)
	arg_13_2:setBuildType(var_0_0.BuildType.Exchange)
	arg_13_2:updateKnightComp(self._knightList[arg_13_1 + 1], arg_13_1)
end

function OutpostExchangeBuildLayer:receiveCompEvent(arg_14_1)
	local var_14_0 = ...

	if arg_14_1 == "callKnight" then
		self._callKnightDic[var_14_0.sid] = true

		self:_playListOutEffect(var_14_0.pos)

		return true
	end
end

function OutpostExchangeBuildLayer:_playListOutEffect(arg_15_1)
	local var_15_0 = self.m_tempCell:getPosition()

	var_15_0.y = self.m_knightList:getChildAt((self.m_knightList:itemIndexToChildIndex(arg_15_1))):localToGlobal(cc.p(0, 0)).y

	self.m_tempCell:setPosition(var_15_0)
	self.m_tempCell:updateKnightComp(self._knightList[arg_15_1 + 1])
	self.m_tempCell:setVisible(true)
	self:_setCellOpacity(0, arg_15_1 + 1)
	self:_playListUpEffect(arg_15_1 + 2)
	self.m_cellOutTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Menu_Slide_01)
end

function OutpostExchangeBuildLayer:_playListUpEffect(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs((self.m_knightList:getChildren())) do
		if arg_16_1 <= self.m_knightList:childIndexToItemIndex(iter_16_0) then
			iter_16_1:playUpEffect()
		end
	end
end

function OutpostExchangeBuildLayer:_onTempCellShowOver()
	self:_updateKnightUI()
	self:_onResetKnightList()
end

function OutpostExchangeBuildLayer:_onResetKnightList()
	self:_setCellOpacity(255)
	self.m_tempCell:setOpacity(0)
end

function OutpostExchangeBuildLayer:_setCellOpacity(arg_19_1, arg_19_2)
	for iter_19_0, iter_19_1 in ipairs((self.m_knightList:getChildren())) do
		if not arg_19_2 or self.m_knightList:childIndexToItemIndex(iter_19_0) == arg_19_2 then
			if arg_19_1 == 0 then
				iter_19_1:setVisible(false)
				iter_19_1:newScheduleOnce(handler(iter_19_1, function(arg_20_0)
					arg_20_0:setOpacity(arg_19_1)
					arg_20_0:setVisible(true)
				end), 0.2)
			else
				iter_19_1:cancelAllSchedule()
				iter_19_1:setOpacity(arg_19_1)
				iter_19_1:setVisible(true)
			end
		end
	end
end

return OutpostExchangeBuildLayer
