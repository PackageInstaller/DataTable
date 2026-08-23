local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEquipBuildLayer = class("OutpostEquipBuildLayer", require("app.fairyGUI.outpost.UI_OutpostEquipBuildLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/outpost/outpost",
		resName = "OutpostEquipBuildLayer",
		pkgName = "outpost"
	}, ...)
end)

function OutpostEquipBuildLayer:ctor(arg_2_1)
	if arg_2_1.route1 then
		arg_2_1.type = arg_2_1.route1
	end

	self:addBg("bg/outpost/pic_hxsz_jiaoyisuobg.jpg")

	self._buildData = g.core.model.User.outpostData:getBuildData():getBuild(arg_2_1)
	self._callKnightDic = {}

	self:_initLayer()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
	self.m_guideBtn:addClickListener(handler(self, self.onGuideBtnClick))
end

function OutpostEquipBuildLayer:_initLayer()
	self.m_selIndexController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChanged))
	self.m_selIndexController:setSelectedIndex(0)
	self.m_recipeList:setVirtual(self)
	self.m_recipeList:doFairyBatching(false)
	self.m_recipeList:setItemRenderer(handler(self, self._onProduceItemRender))
	self.m_recipeList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onProduceItemClicked))
	self.m_shelfList:setVirtual(self)
	self.m_shelfList:doFairyBatching(false)
	self.m_shelfList:setItemRenderer(handler(self, self._onSellItemRender))
	self.m_shelfList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onSellItemClicked))
	self.m_knightList:setVirtual(self)
	self.m_knightList:doFairyBatching(false)
	self.m_knightList:setItemRenderer(handler(self, self._onKnightItemRender))
	self.m_topBarComp:setResInfoById(383)
	self.m_cellOutTransition:setHook("finish", handler(self, self._onTempCellShowOver))
end

function OutpostEquipBuildLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_ORDERPROCESS, handler(self, self.onEquipCreate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_LEVELUP, handler(self, self.updateBuildLayer), self)
	self:updateBuildLayer()
	self.m_enterTransition:play()
end

function OutpostEquipBuildLayer:updateBuildLayer()
	self.m_buildInfoComp:updateBuildInfoComp(self._buildData)
	self:_onTabChanged()
end

function OutpostEquipBuildLayer:_onTabChanged()
	local var_7_0 = self.m_selIndexController:getSelectedIndex()

	if var_7_0 == 0 then
		self:_onResetKnightList()
		self:_updateProduceUI()
		self.m_recipeList:transitionShowCells("enter_scaleOut", 0.03, 1)
	elseif var_7_0 == 1 then
		self:_onResetKnightList()
		self:_updateSellUI()
		self.m_shelfList:transitionShowCells("enter_scaleOut", 0.03, 1)
	elseif var_7_0 == 2 then
		self:_updateKnightUI()
		self.m_knightList:transitionShowCells("enter_right", 0.03, 1)
	end
end

function OutpostEquipBuildLayer:_updateProduceUI()
	self._equipList = self._buildData:getEquipList()

	table.sort(self._equipList, function(arg_9_0, arg_9_1)
		return arg_9_0:isBaseAttrHighThanOtherEquip(arg_9_1)
	end)
	self.m_recipeList:setNumItems(#self._equipList)
end

function OutpostEquipBuildLayer:_onProduceItemRender(arg_10_1, arg_10_2)
	arg_10_2:updateRecipeComp(self._equipList[arg_10_1 + 1])
end

function OutpostEquipBuildLayer:_onProduceItemClicked(arg_11_1)
	local var_11_0 = self._equipList[arg_11_1:getDataValue() + 1]

	self._selectEquip = var_11_0

	g.core.module.ModuleManager:pushPopup(require("app.view.module.outpost.view.build.OutpostBuildEquipCreatePop").new({
		maxNum = 9999,
		struct = var_11_0,
		onConfirm = handler(self, self._onEquipProduce),
		ownNum = self._buildData:getEquipProductNum(var_11_0:getCfg().id)
	}), {
		hideContinue = true,
		touchDisappear = true
	})
end

function OutpostEquipBuildLayer:_onEquipProduce(arg_12_1)
	self._buildData:onEffect({
		knightId = 0,
		orderType = var_0_0.EXCHANGE_TYPE.PUBLISH,
		itemId = self._selectEquip:getCfg().id,
		num = arg_12_1.num
	})
end

function OutpostEquipBuildLayer:_updateSellUI()
	self._produceList = {}

	for iter_13_0, iter_13_1 in ipairs((self._buildData:getOrders())) do
		self._produceList[#self._produceList + 1] = {
			equip = self._buildData:getEquipById(iter_13_1.id),
			order = iter_13_1
		}
	end

	table.sort(self._produceList, function(arg_14_0, arg_14_1)
		return arg_14_0.equip:isBaseAttrHighThanOtherEquip(arg_14_1.equip)
	end)
	self.m_shelfList:setNumItems(#self._produceList)

	if #self._produceList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
	end
end

function OutpostEquipBuildLayer:_onSellItemRender(arg_15_1, arg_15_2)
	arg_15_2:updateShelfComp(self._produceList[arg_15_1 + 1])
end

function OutpostEquipBuildLayer:_onSellItemClicked(arg_16_1)
	g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.knight.OutpostKnightSuitDetailPop").new({
		struct = self._produceList[arg_16_1:getDataValue() + 1].equip
	})))
end

function OutpostEquipBuildLayer:_updateKnightUI()
	self._knightList = {}

	for iter_17_0, iter_17_1 in ipairs((g.core.model.User.outpostData:getKnightsData():getAllLineUpKnights())) do
		if not self._callKnightDic[iter_17_1:getServerId()] then
			self._knightList[#self._knightList + 1] = iter_17_1
		end
	end

	if g.core.guide.GuideProxy:isGuideRunning() then
		table.sort(self._knightList, function(arg_18_0, arg_18_1)
			if arg_18_0:getCfg().advance_id == 500070 or arg_18_1:getCfg().advance_id == 500070 then
				return arg_18_0:getCfg().advance_id == 500070
			end

			return arg_18_0:getCfg().advance_id < arg_18_1:getCfg().advance_id
		end)
	end

	self.m_knightList:setNumItems(#self._knightList)

	if #self._knightList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
	end
end

function OutpostEquipBuildLayer:onEquipCreate(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if arg_19_4.order_tp == var_0_0.EXCHANGE_TYPE.PUBLISH then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.build.OutpostEquipCreatingPop").new({
			equipCfg = g.core.config.outpost_equip_info.get(arg_19_4.target_id)
		})))
	end
end

function OutpostEquipBuildLayer:_onKnightItemRender(arg_20_1, arg_20_2)
	arg_20_2:setBuildType(self._buildData:getBuildType())
	arg_20_2:updateKnightComp(self._knightList[(g.core.guide.GuideProxy:isGuideRunning() or nil) and arg_20_1 + 1], arg_20_1)
end

function OutpostEquipBuildLayer:receiveCompEvent(arg_21_1)
	local var_21_0 = ...

	if arg_21_1 == "callKnight" then
		self._callKnightDic[var_21_0.sid] = true

		self:_playListOutEffect(var_21_0.pos)

		return true
	end
end

function OutpostEquipBuildLayer:_playListOutEffect(arg_22_1)
	local var_22_0 = self.m_tempCell:getPosition()

	var_22_0.y = self.m_knightList:getChildAt((self.m_knightList:itemIndexToChildIndex(arg_22_1))):localToGlobal(cc.p(0, 0)).y

	self.m_tempCell:setPosition(var_22_0)
	self.m_tempCell:updateKnightComp(self._knightList[arg_22_1 + 1])
	self.m_tempCell:setVisible(true)
	self:_setCellOpacity(0, arg_22_1 + 1)
	self:_playListUpEffect(arg_22_1 + 2)
	self.m_cellOutTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Menu_Slide_01)
end

function OutpostEquipBuildLayer:_playListUpEffect(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs((self.m_knightList:getChildren())) do
		if arg_23_1 <= self.m_knightList:childIndexToItemIndex(iter_23_0) then
			iter_23_1:playUpEffect()
		end
	end
end

function OutpostEquipBuildLayer:_onTempCellShowOver()
	self:_updateKnightUI()
	self:_onResetKnightList()
end

function OutpostEquipBuildLayer:_onResetKnightList()
	self:_setCellOpacity(255)
	self.m_tempCell:setOpacity(0)
end

function OutpostEquipBuildLayer:_setCellOpacity(arg_26_1, arg_26_2)
	for iter_26_0, iter_26_1 in ipairs((self.m_knightList:getChildren())) do
		if not arg_26_2 or self.m_knightList:childIndexToItemIndex(iter_26_0) == arg_26_2 then
			if arg_26_1 == 0 then
				iter_26_1:setVisible(false)
				iter_26_1:newScheduleOnce(handler(iter_26_1, function(arg_27_0)
					arg_27_0:setOpacity(arg_26_1)
					arg_27_0:setVisible(true)
				end), 0.2)
			else
				iter_26_1:cancelAllSchedule()
				iter_26_1:setOpacity(arg_26_1)
				iter_26_1:setVisible(true)
			end
		end
	end
end

function OutpostEquipBuildLayer:onGuideBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.outpost.view.build.OutpostGuideVideoPop").new(), {
		ignoreTouch = true,
		touchDisappear = false
	})
end

return OutpostEquipBuildLayer
