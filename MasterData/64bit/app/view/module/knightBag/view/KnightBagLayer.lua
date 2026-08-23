local KnightBagLayer = class("KnightBagLayer", require("app.fairyGUI.knightBag.UI_KnightBagLayer"), function()
	return fgui.GComponent:create({
		pkgName = "knightBag",
		isFullScreen = true,
		pkgPath = "ui/knightBag/knightBag",
		resName = "KnightBagLayer"
	})
end)
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.module.ModuleManager

function KnightBagLayer:ctor()
	self._data = {}
	self._tabGroup = 0
	self._tabProfession = 0
	self._tabDamage = 0
	self._tabElement = 0
	self._selectedData = nil
	self._rawNum = self.m_cardList:getColumnCount()
	self._showList = {}

	self:_setScreenVisible(false)
	self:addBg("bg/knightbag/pic_yht_beibao.jpg")
	self.m_topBarComp:setResInfoById(62)
	self.m_groupList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onGroupItemClick))
	self:_initList()
	self.m_runnerComp:init({
		target = self.m_groupList
	})
	self.m_rebornBtn:addClickListener(handler(self, self._onRebornClick))
	self.m_recommendBtn:addClickListener(handler(self, self._onRecommendClick))
	self.m_lineUpBtn:addClickListener(handler(self, self._onLineUpClick))
	self.m_sellBtn:addClickListener(handler(self, self._onSellBtnClicked))
	self.m_bookBtn:addClickListener(handler(self, self._onSkinBookShow))
	self.m_screenBtn:addClickListener(handler(self, self._onClickScreenBtn))
	self.m_touchBg:addClickListener(handler(self, self._onCLickTouchBg))
	self.m_guideBtn:addClickListener(handler(self, self._onClickGuideBtn))

	if g.core.utils.Rule.isHideSkinHandbook() then
		self.m_bookBtn:setVisible(false)
	else
		self.m_bookBtn:setVisible(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SKIN_SHOP))
	end

	self.m_guideBtn:setVisible(g.core.common.ModuleUnlock:isFunctionUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.UR_PROPERTY, nil, true))
end

function KnightBagLayer:_onRebornClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.REBORN) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.REBORN, {
			index = require("app.view.module.reborn.const.RebornConst").SELECT_INDEX_MAP.KNIGHT,
			title = g.core.lang:get(108037)
		})
	end
end

function KnightBagLayer:_onRecommendClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.RECOMMEND_KNIGHT) then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.knightBag.view.KnightRecommendLayer").new()))
	end
end

function KnightBagLayer:_onLineUpClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION, {
		title = g.core.lang:get(108037)
	})
end

function KnightBagLayer:_onGroupItemClick(arg_6_1)
	local var_6_0 = arg_6_1:getDataValue()

	if self._tabGroup ~= var_6_0 then
		self._tabGroup = var_6_0

		self:updateView()
	end
end

function KnightBagLayer:_initList()
	self.m_groupList:setSelectedIndex(0)
	self.m_cardList:setVirtual()
	self.m_cardList:doFairyBatching(false)
	self.m_cardList:setItemProvider(handler(self, self._setCardListItemProvider))
	self.m_cardList:setItemRenderer(handler(self, self._onCardItemRenderer))
end

function KnightBagLayer:_setCardListItemProvider(arg_8_1)
	return (arg_8_1 < self._selectedData.ownNum or arg_8_1 >= self._selectedData.notOwnCardStartIndex) and "ui://knightBag/BaseKnightCardComp" or arg_8_1 == self._selectedData.lineIndex and "ui://knightBag/KnightBagLineCell" or arg_8_1 > self._selectedData.lineIndex and arg_8_1 < self._selectedData.notOwnCardStartIndex and "ui://knightBag/KnightBagEmptyLineCell" or "ui://knightBag/KnightBagEmptyCardCell"
end

function KnightBagLayer:_onCardItemRenderer(arg_9_1, arg_9_2)
	local var_9_0

	if arg_9_1 < self._selectedData.ownNum then
		var_9_0 = self._selectedData.ownList[arg_9_1 + 1]
		self._showList[self._tabGroup] = self._showList[self._tabGroup] or {}
		self._showList[self._tabGroup][arg_9_1 + 1] = var_9_0
	elseif arg_9_1 >= self._selectedData.canOwnCardStartIndex then
		var_9_0 = self._selectedData.canOwnList[arg_9_1 - self._selectedData.canOwnCardStartIndex + 1]
	end

	if var_9_0 then
		arg_9_2:updateCell(var_9_0, nil, self._tabGroup)
	end
end

function KnightBagLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CHANGE_KNIGHT, handler(self, self._onFragmentCompose), self)

	self._data = {}

	self:updateView()

	if g.core.platform.ServerListProxy:isTesting() then
		self.m_bookBtn:setVisible(false)
	end

	self.m_recommendBtn:setVisible((g.core.common.ModuleUnlock:isFunctionUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.RECOMMEND_KNIGHT)))
end

function KnightBagLayer:onUnload()
	for iter_11_0, iter_11_1 in pairs(self._showList) do
		if next(iter_11_1) then
			for iter_11_2, iter_11_3 in pairs(iter_11_1) do
				iter_11_3:setIsNewKnight()
			end

			self._showList = {}
		end
	end
end

function KnightBagLayer:_onFragmentCompose(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self._data = {}

	self:updateView()

	local var_12_0, var_12_1

	if not arg_12_4.insert or not arg_12_4.insert[1] then
		do return end

		var_12_0 = require("app.view.base.infoPop.KnightShowTimePop").new
		var_12_1 = {
			justShow = true
		}
	end

	var_12_1.knightId = arg_12_4.insert[1].base_id

	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.KnightShowTimePop").new(var_12_1), {
		withoutAni = true
	})
end

function KnightBagLayer:updateView()
	self._selectedData = self:_newGetData()

	self.m_numText:setText(self._selectedData.knightSum)
	self.m_maxNumText:setText("/" .. self._selectedData.maxNum)
	self.m_cardList:setNumItems(self._selectedData.cardNum)
	self.m_cardList:transitionShowCells("listCardAUiScaleIn", 0.1)
	self.m_cardList:scrollToView(0)
end

function KnightBagLayer:_getData()
	if not self._data[self._tabGroup] then
		local var_14_0 = {
			knightSum = #var_0_1:getOwnKnightList(self._tabGroup),
			ownList = var_0_1:getBagList(self._tabGroup),
			canOwnList = var_0_1:getCanOwnList(self._tabGroup)
		}

		var_14_0.ownNum = #var_14_0.ownList or 0
		var_14_0.isEmpty = #var_14_0.ownList == 0
		var_14_0.maxNum = #var_14_0.ownList + #var_14_0.canOwnList
		var_14_0.emptyCardNum = self._rawNum - #var_14_0.ownList % self._rawNum

		if var_14_0.emptyCardNum == self._rawNum then
			var_14_0.emptyCardNum = 0
		end

		var_14_0.lineIndex = var_14_0.ownNum + var_14_0.emptyCardNum
		var_14_0.notOwnCardStartIndex = var_14_0.lineIndex + self._rawNum
		var_14_0.canOwnCardStartIndex = var_14_0.notOwnCardStartIndex
		var_14_0.cardNum = #var_14_0.canOwnList > 0 and var_14_0.canOwnCardStartIndex + #var_14_0.canOwnList or var_14_0.ownNum
		self._data[self._tabGroup] = var_14_0
	end

	return self._data[self._tabGroup]
end

function KnightBagLayer:_newGetData()
	local var_15_0 = {}
	local var_15_1 = {
		group = self._tabGroup,
		profession = self._tabProfession,
		damage = self._tabDamage,
		element = self._tabElement
	}

	var_15_0.knightSum = #var_0_1:getKnightListByParams(var_15_1, true, false, true)
	var_15_0.ownList = var_0_1:getKnightListByParams(var_15_1, true, true, true)
	var_15_0.canOwnList = var_0_1:getKnightListByParams(var_15_1, false, false, false)
	var_15_0.ownNum = #var_15_0.ownList or 0
	var_15_0.isEmpty = #var_15_0.ownList == 0
	var_15_0.maxNum = #var_15_0.ownList + #var_15_0.canOwnList
	var_15_0.emptyCardNum = self._rawNum - #var_15_0.ownList % self._rawNum

	if var_15_0.emptyCardNum == self._rawNum then
		var_15_0.emptyCardNum = 0
	end

	var_15_0.lineIndex = var_15_0.ownNum + var_15_0.emptyCardNum
	var_15_0.notOwnCardStartIndex = var_15_0.lineIndex + self._rawNum
	var_15_0.canOwnCardStartIndex = var_15_0.notOwnCardStartIndex
	var_15_0.cardNum = #var_15_0.canOwnList > 0 and var_15_0.canOwnCardStartIndex + #var_15_0.canOwnList or var_15_0.ownNum

	return var_15_0
end

function KnightBagLayer:_onSellBtnClicked()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.FragSellPop").new(var_0_1:getCanSellKnightFragDataList(), {
		qualityArr = g.core.const.ConstMgr.QUALITY_TYPE.SELL_POP_QUALITY_ARRAY[g.core.const.ConstMgr.QUALITY_TYPE.NEW_QUALITY_CTRL.KNIGHT]
	})))
end

function KnightBagLayer:_onSkinBookShow()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SKIN_BOOK)
end

function KnightBagLayer:_onClickScreenBtn()
	self:_setScreenVisible((self.m_screenBtn:isSelected()))
end

function KnightBagLayer:_onCLickTouchBg()
	self:_setScreenVisible(false)
	self.m_screenBtn:setSelected(false)
end

function KnightBagLayer:_setScreenVisible(arg_20_1)
	self.m_touchBg:setVisible(arg_20_1)
	self.m_screenComp:setVisible(arg_20_1)
end

function KnightBagLayer:receiveCompEvent(arg_21_1, arg_21_2)
	if arg_21_1 == "changeProfession" then
		self._tabProfession = arg_21_2.index

		self:updateView()
	elseif arg_21_1 == "changeDamageType" then
		self._tabDamage = arg_21_2.index

		self:updateView()
	elseif arg_21_1 == "changeElement" then
		self._tabElement = arg_21_2.index

		self:updateView()
	end
end

function KnightBagLayer:_onClickGuideBtn()
	var_0_2:pushPopup(require("app.view.module.guide.view.GuideCommonPopup").new({
		group = 1
	}), {
		touchDisappear = true
	})
end

return KnightBagLayer
