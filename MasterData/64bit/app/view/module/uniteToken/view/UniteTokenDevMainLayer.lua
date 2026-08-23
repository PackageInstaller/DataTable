local var_0_0 = g.core.model.User.uniteTokenData
local var_0_1 = g.core.const.ConstMgr.UniteTokenConst
local UniteTokenCommon = require("app.view.module.uniteToken.common.UniteTokenCommon")
local UniteTokenDevConfig = require("app.view.module.uniteToken.common.UniteTokenDevConfig")
local var_0_4 = g.core.module.ModuleManager
local UniteTokenDevMainLayer = class("UniteTokenDevMainLayer", require("app.fairyGUI.uniteToken.UI_UniteTokenDevMainLayer"), function()
	return fgui.GComponent:create({
		resName = "UniteTokenDevMainLayer",
		pkgName = "uniteToken",
		isFullScreen = true,
		pkgPath = "ui/uniteToken/uniteToken"
	}, ...)
end)

function UniteTokenDevMainLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._params = arg_2_1
	self._tabIndex = arg_2_1.tabIndex or 1
	self._selectIndex = arg_2_1.selIndex or 1
	self._severId = arg_2_1.severId
	self._tokenListData = {}

	self:_initData()
	self:_initView()

	self._curLevel = self:_getValidLevel()

	self:addListen(self.m_rightTabPanel)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
	self.m_lineUpBtn:addClickListener(handler(self, self._onFormationBtnClick))
end

function UniteTokenDevMainLayer:_onFormationBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function UniteTokenDevMainLayer:updateTopBar(arg_4_1)
	self.m_topBarComp:setResInfoById(arg_4_1)
end

function UniteTokenDevMainLayer:_updateTopBarRes(arg_5_1)
	self.m_topBarComp:updateTopRes(arg_5_1)

	if arg_5_1 and arg_5_1.helpId then
		self.m_topBarComp:setHelpId(arg_5_1.helpId)
	end
end

function UniteTokenDevMainLayer:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "Event_refresh_top_bar" then
		self:updateTopBar(arg_6_2)
	elseif arg_6_1 == "Event_refresh_top_bar_res" then
		self:_updateTopBarRes(arg_6_2)
	end
end

function UniteTokenDevMainLayer:_initData()
	self._tokenListData = var_0_0:getSortOwnTokenList()

	if self._severId then
		for iter_7_0, iter_7_1 in pairs(self._tokenListData) do
			if iter_7_1:getServerId() == self._severId then
				self._selectIndex = iter_7_0

				break
			end
		end
	end
end

function UniteTokenDevMainLayer:_initView()
	self:addBg("bg/common/pic_yht_beijing.jpg")

	self._curSelectTokenData = nil

	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onUniteCellRenderer))
	self.m_itemList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onSelectedClicked))
	self.m_domainBtn:addClickListener(handler(self, self._onClickDomainBtn))
	self.m_blankBg:addClickListener(handler(self, self._onClickDomainBg))

	self._tokenListData = var_0_0:getSortOwnTokenList()

	self.m_itemList:setNumItems(#self._tokenListData)
	self.m_itemList:setSelectedIndex(self._selectIndex - 1)
	self.m_itemList:scrollToView(self._selectIndex - 1)
	self.m_rightTabPanel:init(UniteTokenDevConfig, self._tabIndex)
	self:updateTopBar(UniteTokenDevConfig.DEV_LIST[self._tabIndex].resInfoId)
	self:_updateSelectView()
	self.m_topBarComp:setResInfoById(56)
end

function UniteTokenDevMainLayer:playEnterAnim()
	self._tokenListData = var_0_0:getSortOwnTokenList()

	self.m_itemList:setNumItems(#self._tokenListData)
	self.m_itemList:transitionShowCells("leftIn", 0.1)
end

function UniteTokenDevMainLayer:_onUniteCellRenderer(arg_10_1, arg_10_2)
	arg_10_2:updateView(self._tokenListData[arg_10_1 + 1])
end

function UniteTokenDevMainLayer:_onSelectedClicked()
	local var_11_0 = self.m_itemList:getSelectedIndex() + 1

	if var_11_0 ~= self._selectIndex then
		self._selectIndex = var_11_0
		self._curSelectTokenData = self._tokenListData[self._selectIndex]

		self:_updateSelectView()
	end
end

function UniteTokenDevMainLayer:_updateSelectView(arg_12_1)
	local var_12_0 = self._tokenListData[self._selectIndex]

	self._curSelectTokenData = self._tokenListData[self._selectIndex]

	self.m_showComp:updateView(var_12_0)

	if not arg_12_1 then
		self.m_showComp:playSwitchAnim()
	end

	self.m_rightTabPanel:setViewData(var_12_0, arg_12_1)
	g.core.model.User.bagData:clearNewData(g.core.const.ConstMgr.BAG_TYPE.UNITE_TOKEN, var_12_0:getAdvanceId())

	if not arg_12_1 then
		self._curLevel = self:_getValidLevel()
	end

	self.m_domainBtn:setVisible(var_12_0:getQuality() >= g.core.const.ConstMgr.QUALITY_TYPE.UR)
end

function UniteTokenDevMainLayer:_getValidLevel()
	if self._tokenListData[self._selectIndex] then
		return self._tokenListData[self._selectIndex]:getLevel()
	end
end

function UniteTokenDevMainLayer:onLoad()
	self:playEnterAnim()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_UPGRADE, handler(self, self._onRecvTokenUpgrade), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_ONEKEY_UPGRADE, handler(self, self._onRecvTokenUpgrade), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_STARINCREASE, handler(self, self._onRecvTokenStarup), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_AWAKEN, handler(self, self._onRecvTokenAwaken), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_TRANSFORM, handler(self, self._onItemTransform), self)
	self:_refreshDataAndDevComp()
end

function UniteTokenDevMainLayer:_refreshDataAndDevComp()
	self._tokenListData = var_0_0:getSortOwnTokenList()
	self._selectIndex = self:getIndexById((self._curSelectTokenData:getBaseId()))

	self.m_itemList:setSelectedIndex(self._selectIndex - 1)
	self.m_itemList:setNumItems(#self._tokenListData)
	self:_updateSelectView(true)
end

function UniteTokenDevMainLayer:getIndexById(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(self._tokenListData) do
		if arg_16_1 == iter_16_1:getBaseId() then
			return iter_16_0
		end
	end

	return 1
end

function UniteTokenDevMainLayer:_onTokenInfoClick()
	UniteTokenCommon.openUniteInfoPop(self._tokenListData[self._selectIndex])
end

function UniteTokenDevMainLayer:_onClickDomainBtn()
	self.m_showDomainController:setSelectedIndex(1)
end

function UniteTokenDevMainLayer:_onClickDomainBg()
	self.m_showDomainController:setSelectedIndex(0)
end

function UniteTokenDevMainLayer:_onRecvTokenUpgrade()
	self:_refreshDataAndDevComp()

	local var_20_0 = g.core.const.ConstMgr.BaseShowTypeConst

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = g.core.const.ConstMgr.BaseShowTypeConst.UNITE_TOKEN_UPGRADE_SUCCESS
		}
	})

	local var_20_1 = self._tokenListData[self._selectIndex]:getLevel()
	local var_20_2 = -1
	local var_20_3

	for iter_20_0, iter_20_1 in pairs(var_0_0:getTokenUpgradeInfo(self._tokenListData[self._selectIndex]:getUpgradeId(), self._curLevel, var_20_1 >= self._tokenListData[self._selectIndex]:getTokenMaxLevel()).talentList) do
		if var_20_1 >= iter_20_1.level and iter_20_1.level > self._curLevel and var_20_2 < iter_20_1.level then
			var_20_2 = iter_20_1.level
			var_20_3 = iter_20_1
		end
	end

	if var_20_2 > 0 and var_20_3 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			baseShowPop = {
				type = var_20_0.UNITE_TOKEN_TALENT_ACTIVE
			}
		})
	end

	self._curLevel = var_20_1
end

function UniteTokenDevMainLayer:_onRecvTokenStarup()
	local var_21_0 = self._tokenListData[self._selectIndex]

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = {
			{
				flag = "UniteTokenUpgrade",
				func = function()
					return var_0_4:pushPopup((require("app.view.module.uniteToken.view.UniteTokenSuccessPop").new(var_21_0, var_0_1.SUCCESS_TYPE.START_UP)))
				end
			}
		}
	})
	self:_refreshDataAndDevComp()
end

function UniteTokenDevMainLayer:_onItemTransform()
	self:_refreshDataAndDevComp()
end

function UniteTokenDevMainLayer:_onRecvTokenAwaken()
	local var_24_0 = self._tokenListData[self._selectIndex]

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = {
			{
				flag = "UniteTokenUpgrade",
				func = function()
					return var_0_4:pushPopup((require("app.view.module.uniteToken.view.UniteTokenSuccessPop").new(var_24_0, var_0_1.SUCCESS_TYPE.AWAKEN)))
				end
			}
		}
	})
	self:_refreshDataAndDevComp()
end

return UniteTokenDevMainLayer
