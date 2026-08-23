local var_0_0 = g.core.model.User
local var_0_1 = {
	ARTIFACT_FRAG = 1,
	ARTIFACT = 0
}
local RebornConst = require("app.view.module.reborn.const.RebornConst")
local BagNewArtifactBagComp = class("BagNewArtifactBagComp", require("app.fairyGUI.bagNew.UI_BagNewArtifactBagComp"))

function BagNewArtifactBagComp:ctor(arg_1_1)
	self._fragmentData = {}
	self._artifactData = {}
	self._tabIndex = var_0_1.ARTIFACT
	self._isNotWear = false
	self._selectData = {}
	self._selectedIndex = 1

	self.m_hideInWearBtn:addEventListener(fgui.UIEventType.Changed, handler(self, self._onHideInWearChange))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
	self.m_itemList:setVirtual()
	self.m_itemList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._updateItemInfo))
	self.m_itemList:setItemProvider(handler(self, self._onItemGetProvider))
	self.m_itemList:setItemRenderer(handler(self, self._onRenderItemList))
	self.m_rebornBtn:addClickListener(handler(self, self._onRebornTouchClick))
	self.m_handBookBtn:addClickListener(handler(self, self._onHandBookClick))
	self.m_sellBtn:addClickListener(handler(self, self._onSellClick))
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT)
	self:fitRedPoint()
	self:fitMainRedPoint()
end

function BagNewArtifactBagComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SELL, handler(self, self._refreshListView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE, handler(self, self._onRcvFragmentCompose), self)
	self:_refreshListView()
end

function BagNewArtifactBagComp:_refreshListView()
	local var_3_0 = false

	if self._tabIndex == var_0_1.ARTIFACT then
		self._artifactData = self._isNotWear and var_0_0.artifactData:getNotLineUpList() or var_0_0.artifactData:getOwnArtifactList()

		if #self._artifactData > 0 then
			var_3_0 = true

			self:_updateArtifactList()
			self.m_isEmptyController:setSelectedIndex(0)
			self:_updateRight()
		else
			self.m_isEmptyController:setSelectedIndex(1)
		end

		self.m_bagNumComp:showNum(#self._artifactData)
	elseif self._tabIndex == var_0_1.ARTIFACT_FRAG then
		self._fragmentData = var_0_0.artifactData:getHasOwnFragList()

		if #self._fragmentData > 0 then
			var_3_0 = true

			self:_updateArtifactFragList()
			self.m_isEmptyController:setSelectedIndex(0)
			self:_updateRight()
		else
			self.m_isEmptyController:setSelectedIndex(1)
		end
	end

	self:_judgeIsShowCheckBox()

	if var_3_0 then
		self.m_itemList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
	end

	self:_updateRedPoint()
end

function BagNewArtifactBagComp:playEnterAnim()
	self.m_rightComp:playEnterAnim()
end

function BagNewArtifactBagComp:fitRedPoint()
	self.m_fitTitle:setText(self.m_fragBtn:getTitle())

	local var_5_0 = self.m_fitTitle:getSize().width

	if var_5_0 > 100 then
		var_5_0 = 100
	end

	self.m_fragRedPointComp:setX(self.m_fitTitle:getX() + var_5_0)
end

function BagNewArtifactBagComp:fitMainRedPoint()
	self.m_fitMainTitle:setText(self.m_artifactBtn:getTitle())

	local var_6_0 = self.m_fitMainTitle:getSize().width

	if var_6_0 > 100 then
		var_6_0 = 100
	end

	self.m_artifactRedPointComp:setX(self.m_fitMainTitle:getX() + var_6_0)
end

function BagNewArtifactBagComp:receiveCompEvent(arg_7_1, arg_7_2)
	return
end

function BagNewArtifactBagComp:_onRcvFragmentCompose(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self:_refreshListView()

	local var_8_0 = g.core.config.fragment_info.get(arg_8_4.id)

	if var_8_0 then
		g.core.module.ModuleManager:awardSummary({
			{
				type = var_8_0.fragment_type,
				value = var_8_0.fragment_value,
				size = arg_8_4.num
			}
		})
	end
end

function BagNewArtifactBagComp:_onRebornTouchClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.REBORN) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.REBORN, {
			index = RebornConst.SELECT_INDEX_MAP.ARTIFACT
		})
	end
end

function BagNewArtifactBagComp:_onHideInWearChange()
	self._isNotWear = self.m_hideInWearBtn:isSelected()

	self:_refreshListView()
end

function BagNewArtifactBagComp:_onChangeTabCtrl()
	local var_11_0 = self.m_tabController:getSelectedIndex()

	if self._tabIndex ~= var_11_0 then
		self._tabIndex = var_11_0
		self._selectedIndex = 1

		self:_refreshListView()
	end
end

function BagNewArtifactBagComp:_onItemGetProvider()
	if self.m_tabController:getSelectedIndex() == var_0_1.ARTIFACT then
		return "ui://bagNew/BagNewArtifactCell"
	else
		return "ui://bagNew/BagNewArtifactFragCell"
	end
end

function BagNewArtifactBagComp:_onRenderItemList(arg_13_1, arg_13_2)
	if self.m_tabController:getSelectedIndex() == var_0_1.ARTIFACT_FRAG then
		arg_13_2:updateIconView(self._fragmentData[arg_13_1 + 1])
	else
		arg_13_2:updateIconView(self._artifactData[arg_13_1 + 1])
	end
end

function BagNewArtifactBagComp:_updateArtifactFragList()
	self:fitPosition()
	self.m_itemList:setNumItems(#self._fragmentData)

	if #self._fragmentData < self._selectedIndex then
		self._selectedIndex = 1
	end

	self.m_itemList:setSelectedIndex(self._selectedIndex - 1)
end

function BagNewArtifactBagComp:_updateArtifactList()
	self:fitPosition()
	self.m_itemList:setNumItems(#self._artifactData)

	if #self._artifactData < self._selectedIndex then
		self._selectedIndex = 1
	end

	self.m_itemList:setSelectedIndex(self._selectedIndex - 1)
end

function BagNewArtifactBagComp:_updateItemInfo(arg_16_1)
	local var_16_0 = arg_16_1:getDataValue()

	if var_16_0 + 1 ~= self._selectedIndex then
		self._selectedIndex = var_16_0 + 1

		self:_updateRight()
	end
end

function BagNewArtifactBagComp:_updateRight()
	local var_17_0

	if self._tabIndex == var_0_1.ARTIFACT then
		self._selectData = self._artifactData[self._selectedIndex]
	else
		self._selectData = self._fragmentData[self._selectedIndex]
		var_17_0 = true
	end

	if self._selectData then
		self.m_rightComp:updateComp(self._selectData, var_17_0)
	end
end

function BagNewArtifactBagComp:_onHandBookClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_HANDBOOK) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ARTIFACT_HANDBOOK)
	end
end

function BagNewArtifactBagComp:_onSellClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.FragSellPop").new(g.core.model.User.artifactData:getAllCanSellFrag(), {
		fragNameId = 205536,
		qualityArr = g.core.const.ConstMgr.QUALITY_TYPE.SELL_POP_QUALITY_ARRAY[g.core.const.ConstMgr.QUALITY_TYPE.NEW_QUALITY_CTRL.ARTIFACT],
		title = g.core.lang:get(205535),
		emptyTitle = g.core.lang:get(205537)
	})))
end

function BagNewArtifactBagComp:fitPosition()
	if not self._fited then
		self._fited = true

		local var_20_0 = self.m_itemList:getFromPool()
		local var_20_1 = var_20_0:getWidth()

		self.m_itemList:returnToPool(var_20_0)

		local var_20_2 = self.m_itemList:getWidth()
		local var_20_3 = self.m_itemList:getColumnGap()
		local var_20_4 = math.floor(var_20_2 / (var_20_1 + var_20_3))

		if var_20_2 - (var_20_4 * var_20_1 + var_20_3) >= var_20_1 + var_20_3 then
			var_20_4 = var_20_4 + 1
		end

		local var_20_5 = (var_20_2 - (var_20_1 + var_20_3) * var_20_4) / 4

		self.m_itemList:setX(self.m_itemList:getX() + (var_20_2 - (var_20_1 + var_20_3) * var_20_4) / 4)
		self.m_hideInWearBtn:setX(self.m_hideInWearBtn:getX() - var_20_5 * 2)
	end
end

function BagNewArtifactBagComp:_judgeIsShowCheckBox()
	self.m_hideInWearBtn:setVisible(false)

	if self._tabIndex == var_0_1.ARTIFACT and #self._artifactData > 0 and #var_0_0.artifactData:getNotLineUpList() > 0 then
		self.m_hideInWearBtn:setVisible(true)
	end
end

function BagNewArtifactBagComp:_updateRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_fragRedPointComp
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_artifactRedPointComp
	})
end

return BagNewArtifactBagComp
