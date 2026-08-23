local BagNewLayer = class("BagNewLayer", require("app.fairyGUI.bagNew.UI_BagNewLayer"), function()
	return fgui.GComponent:create({
		resName = "BagNewLayer",
		pkgPath = "ui/bagNew/bagNew",
		isFullScreen = true,
		pkgName = "bagNew"
	})
end)
local BagNewFuncCfg = require("app.view.module.bagNew.const.BagNewFuncCfg")
local var_0_3 = {
	[BagNewFuncCfg.FUNC_TYPE.PROP] = 292,
	[BagNewFuncCfg.FUNC_TYPE.EQUIPMENT] = 95,
	[BagNewFuncCfg.FUNC_TYPE.TREASURE] = 98
}

function BagNewLayer:ctor(arg_2_1)
	self._tabCfgs = nil
	self._currentCfg = nil

	if arg_2_1 then
		self._currentSelectIndex = arg_2_1.tab or 0
	end

	if arg_2_1 and arg_2_1.tab then
		self._firstEnterWithTab = true
	end

	self._rightComps = {}
	self._currentComp = nil
	self._contentCompCache = {}
	self._childSize = self.m_childComp:getSize()
	self._childX = self.m_childComp:getX()
	self._childY = self.m_childComp:getY()

	self:_addListeners()
	self:_init()
end

function BagNewLayer:_addListeners()
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, self._onOpObjectUpdate, self)
end

function BagNewLayer:_onTabListClickItem()
	local var_4_0 = self.m_tabList:getSelectedIndex()

	if self._currentSelectIndex ~= var_4_0 then
		self._currentSelectIndex = var_4_0
		self._currentCfg = self._tabCfgs[var_4_0 + 1]

		self:_updateHelpId()
		self:_updateRightCompView(true)
		self:_updateTabList()
	end
end

function BagNewLayer:_init()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_tabList:setIniter(self)
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRenderer))
end

function BagNewLayer:_onTabListItemRenderer(arg_6_1, arg_6_2)
	if arg_6_1 > #self._tabCfgs then
		return
	end

	local var_6_0 = self._tabCfgs[arg_6_1 + 1]

	if self._tabCfgs[arg_6_1 + 1] then
		arg_6_2:setTitle(var_6_0.title)
		arg_6_2:setShowData({
			[0] = "ui://bagNew/" .. var_6_0.icons[2],
			"ui://bagNew/" .. var_6_0.icons[1],
			shading = "ui://bagNew/" .. var_6_0.icons[3]
		})
	end

	if var_0_3[var_6_0.tabType] then
		arg_6_2:setRedPointId(var_0_3[var_6_0.tabType])
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = arg_6_2
		})

		if self:_isTabBagFull(var_6_0.tabType) then
			arg_6_2.m_redPointComp:setStyleManually(g.core.const.ConstMgr.RedPointConst.STYLE.RED_POINT)
		end
	end
end

function BagNewLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_COMMON_CHANGE_TAB, self._onChangeTagEvent, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_AWARD, self._onRechargeAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self:_updateView()
end

function BagNewLayer:_onCrossDayUpdate()
	self:_updateView()
end

function BagNewLayer:_onChangeTagEvent(arg_9_1, arg_9_2)
	self._currentSelectIndex = arg_9_2.type - 1
	self._firstEnterWithTab = true

	self:_checkSelectedIndex()
	self:_updateView()
end

function BagNewLayer:_updateView()
	self:_updateTabList()

	self._currentCfg = self._tabCfgs[self._currentSelectIndex + 1]

	self:_updateHelpId()
	self:_updateRightCompView(true)
end

function BagNewLayer:_updateTabList()
	self._tabCfgs = BagNewFuncCfg:getShowFuncList()

	self.m_tabList:setNumItems(#self._tabCfgs)
	self:_checkSelectedIndex()
	self.m_tabList:setSelectedIndex(self._currentSelectIndex)
end

function BagNewLayer:_checkSelectedIndex()
	if self._firstEnterWithTab then
		self._firstEnterWithTab = false

		local var_12_0 = false

		for iter_12_0, iter_12_1 in ipairs(self._tabCfgs or {}) do
			if iter_12_1 and iter_12_1.tabType == self._currentSelectIndex + 1 then
				self._currentSelectIndex = iter_12_0 - 1
				var_12_0 = true

				return
			end
		end

		if not var_12_0 then
			self._currentSelectIndex = 0
		end
	end
end

function BagNewLayer:_updateHelpId()
	if self._currentCfg then
		self.m_topBarComp:setResInfoById(self._currentCfg.resInfoId)
	end
end

function BagNewLayer:_updateRightCompView(arg_14_1)
	local var_14_0 = self._currentCfg.tabType

	for iter_14_0, iter_14_1 in pairs(self._contentCompCache) do
		iter_14_1._contentComp:setVisible(iter_14_0 == var_14_0)
	end

	if not self._contentCompCache[var_14_0] then
		local var_14_1 = self._currentCfg.getComp()

		var_14_1:setSize(display.width, display.height)
		self:addChild(var_14_1)

		self._contentCompCache[var_14_0] = {
			isFirstCreate = true,
			_contentComp = var_14_1
		}

		var_14_1:playEnterAnim()
	else
		self._contentCompCache[var_14_0]._contentComp:playEnterAnim()
	end

	local var_14_2 = self._contentCompCache[var_14_0]

	if not self._contentCompCache[var_14_0].isFirstCreate and arg_14_1 then
		if var_14_2._contentComp.onSelectAction then
			var_14_2._contentComp:onSelectAction()
		else
			var_14_2._contentComp:onLoad()
		end
	end

	var_14_2.isFirstCreate = false
end

function BagNewLayer:getCurComp()
	return self._currentComp
end

function BagNewLayer:onRemoved()
	return
end

function BagNewLayer:_onRechargeAward(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = {}

	if arg_17_3.awards and next(arg_17_3.awards) then
		for iter_17_0, iter_17_1 in ipairs(arg_17_3.awards) do
			if iter_17_1.size ~= 0 then
				table.insert(var_17_0, iter_17_1)
			end
		end

		g.core.module.ModuleManager:awardSummary(var_17_0)
	end

	self:_updateRightCompView(true)
end

function BagNewLayer:_isTabBagFull(arg_18_1)
	if arg_18_1 == BagNewFuncCfg.FUNC_TYPE.EQUIPMENT then
		return g.core.model.User.equipmentData:countEquipmentNum() >= g.core.model.User.equipmentData:getBagLimit()
	elseif arg_18_1 == BagNewFuncCfg.FUNC_TYPE.TREASURE then
		return g.core.model.User.treasureData:countTreasureNum() >= g.core.model.User.treasureData:getBagLimit()
	end

	return false
end

function BagNewLayer:_refreshBagFullRedPoint()
	if not self._tabCfgs then
		return
	end

	local var_19_0 = g.core.const.ConstMgr.RedPointConst

	for iter_19_0 = 0, self.m_tabList:numChildren() - 1 do
		local var_19_1 = self.m_tabList:getChildAt(iter_19_0)

		if self._tabCfgs[iter_19_0 + 1] and var_0_3[self._tabCfgs[iter_19_0 + 1].tabType] then
			if self:_isTabBagFull(self._tabCfgs[iter_19_0 + 1].tabType) then
				var_19_1.m_redPointComp:setStyleManually(var_19_0.STYLE.RED_POINT)
			else
				var_19_1.m_redPointComp._isManually = false

				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
					redPointComp = var_19_1.m_redPointComp
				})
			end
		end
	end
end

function BagNewLayer:_onOpObjectUpdate()
	self:_refreshBagFullRedPoint()
end

return BagNewLayer
