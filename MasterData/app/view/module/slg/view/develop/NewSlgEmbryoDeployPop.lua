local var_0_0 = g.core.model.User.newSlgDevelopData
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local NewSlgEmbryoDeployPop = class("NewSlgEmbryoDeployPop", require("app.fairyGUI.newSlg.UI_NewSlgEmbryoDeployPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgEmbryoDeployPop",
		pkgPath = "ui/newSlg/newSlg",
		isFullScreen = true,
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgEmbryoDeployPop:ctor(arg_2_1)
	self._embryoType = arg_2_1.embryoType or 0
	self._maxLineupNum = var_0_0:getMaxLineUpByType(arg_2_1.embryoType)
	self._isExpand = false
	self._pos = 0
	self._embryoList = {}
	self._lineupList = {}
	self._unlockList = {}

	self:_initView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
end

function NewSlgEmbryoDeployPop:_initView()
	local var_4_0 = g.core.common.GlobalFunc.getEmbryoNameByType(self._embryoType)

	self.m_filterBtn:setTitle(g.core.lang:get(429537, {
		embryo = var_4_0
	}))
	self.m_emptyText:setTitle(g.core.lang:get(429538, {
		embryo = var_4_0
	}))
	self.m_embryoList:setVirtual(self)
	self.m_embryoList:doFairyBatching(false)
	self.m_embryoList:setItemRenderer(handler(self, self._onRenderEmbryoCell))
	self.m_canLineupList:setVirtual(self)
	self.m_canLineupList:setItemRenderer(handler(self, self._onRenderCardList))
	self.m_filterBtn:addClickListener(handler(self, self._onClickFilterBtn))
	self.m_touchBg:addClickListener(handler(self, self._onClickTouchBg))
	self.m_isExpandController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onExpandChanged))
	self.m_topBarComp:setReturnCallBack(function()
		g.core.module.ModuleManager:replaceModule(g.view.entrance.NEW_SLG_EMBRYO_LINEUP_POP, {
			isBack = true
		})
	end)
	self.m_topBarComp:hideHomeBtn()
	self.m_topBarComp:setResInfoById(345)
	self.m_mainCityComp:updateView(self._embryoType)
end

function NewSlgEmbryoDeployPop:onCancelCallback()
	g.core.module.ModuleManager:replaceModule(g.view.entrance.NEW_SLG_EMBRYO_LINEUP_POP, {
		isBack = true
	})
end

function NewSlgEmbryoDeployPop:_updateView()
	self.m_mainCityComp:updateAuthority(self._embryoType)

	local var_7_0 = self.m_filterBtn:isSelected()

	self._lineupList = var_0_0:getFilteredEmbryoStructArrByType(self._embryoType, function(arg_8_0)
		local var_8_0 = arg_8_0:getEmbryoStruct()

		if not var_8_0 or not var_8_0:isOwn() then
			return false
		end

		return not var_7_0 or not arg_8_0:isLineUp()
	end)

	table.sort(self._lineupList, function(arg_9_0, arg_9_1)
		if arg_9_0:isLineUp() ~= arg_9_1:isLineUp() then
			return arg_9_0:isLineUp()
		end

		if arg_9_0:isRecommend() ~= arg_9_1:isRecommend() then
			return arg_9_0:isRecommend()
		end

		if arg_9_0:getAuthorityNum() ~= arg_9_1:getAuthorityNum() then
			return arg_9_0:getAuthorityNum() > arg_9_1:getAuthorityNum()
		end

		if arg_9_0:getQuality() ~= arg_9_1:getQuality() then
			return arg_9_0:getQuality() > arg_9_1:getQuality()
		end

		if arg_9_0:getStar() ~= arg_9_1:getStar() then
			return arg_9_0:getStar() > arg_9_1:getStar()
		end

		return arg_9_0:getAdvId() > arg_9_1:getAdvId()
	end)
	self.m_canLineupList:setNumItems(#self._lineupList)
	self.m_emptyText:setVisible(#self._lineupList == 0)

	self._unlockList = {}

	for iter_7_0, iter_7_1 in pairs((var_0_0:getNumUnlockMapByType(self._embryoType))) do
		table.insert(self._unlockList, {
			level = iter_7_1,
			posNum = iter_7_0
		})
	end

	table.sort(self._unlockList, function(arg_10_0, arg_10_1)
		return arg_10_0.level < arg_10_1.level
	end)
	self.m_embryoList:setNumItems(self._maxLineupNum)
end

function NewSlgEmbryoDeployPop:_getUnlockLv(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(self._unlockList) do
		if arg_11_1 <= self._unlockList[iter_11_0].posNum then
			if iter_11_0 == 1 then
				return self._unlockList[iter_11_0].level
			elseif arg_11_1 > self._unlockList[iter_11_0 - 1].posNum then
				return self._unlockList[iter_11_0].level
			end
		end
	end

	return self._unlockList[#self._unlockList].level
end

function NewSlgEmbryoDeployPop:_onRenderEmbryoCell(arg_12_1, arg_12_2)
	arg_12_2:updateEmbryoIcon(var_0_0:getLineUpEmbryoStructByTypeAndPos(self._embryoType, arg_12_1 + 1), arg_12_1 + 1, self._embryoType, self:_getUnlockLv(arg_12_1 + 1))
end

function NewSlgEmbryoDeployPop:_onRenderCardList(arg_13_1, arg_13_2)
	arg_13_2:updateCell({
		struct = self._lineupList[arg_13_1 + 1]
	})
end

function NewSlgEmbryoDeployPop:_onClickFilterBtn()
	self:_updateView()
end

function NewSlgEmbryoDeployPop:_onExpandChanged()
	if self.m_isExpandController:getSelectedIndex() == 0 then
		self._pos = 0

		self.m_embryoList:setSelectedIndex(-1)
	end
end

function NewSlgEmbryoDeployPop:_onClickTouchBg()
	if self._isExpand then
		self._isExpand = false

		self.m_isExpandController:setSelectedIndex(0)
		self.m_hideListTransition:play()
	end
end

function NewSlgEmbryoDeployPop:receiveCompEvent(arg_17_1, arg_17_2)
	if arg_17_1 == "SHOW_CAN_LINEUP_LIST" then
		self._isExpand = true

		self.m_isExpandController:setSelectedIndex(1)

		self._pos = arg_17_2.pos

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
		self:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end, 0.5)
		self.m_showListTransition:play()
	elseif arg_17_1 == "EXCHANGE_LINE_UP_EMBRYO" then
		self.m_canLineupList:setTouchable(false)
		self.m_embryoList:setTouchable(false)
		g.core.model.User.newSlgData:saveMyOldFightValue()
		g.core.network.GameNetProxy:send_C2S_NewSlg_StationMainCity({
			tp = arg_17_2.tp,
			pos = self._pos,
			id = arg_17_2.id
		})
	end
end

function NewSlgEmbryoDeployPop:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_STATIONMAINCITY, self._onRcvStationMainCity, self)
	self:_updateView()
	self.m_enterTransition:play()
end

function NewSlgEmbryoDeployPop:_onRcvStationMainCity(arg_20_1, arg_20_2, arg_20_3)
	self:_updateView()

	self._isExpand = false

	self.m_isExpandController:setSelectedIndex(0)
	self.m_hideListTransition:play(handler(self, function(arg_21_0)
		arg_21_0.m_canLineupList:setTouchable(true)
		arg_21_0.m_embryoList:setTouchable(true)
	end))

	if arg_20_3.pos > 0 then
		self.m_embryoList:getChildAt((self.m_embryoList:itemIndexToChildIndex(arg_20_3.pos - 1))):playLineUpEffect()
	end
end

return NewSlgEmbryoDeployPop
