local UniteTokenBagLayer = class("UniteTokenBagLayer", require("app.fairyGUI.uniteToken.UI_UniteTokenBagLayer"), function()
	return fgui.GComponent:create({
		pkgName = "uniteToken",
		isFullScreen = true,
		pkgPath = "ui/uniteToken/uniteToken",
		resName = "UniteTokenBagLayer"
	})
end)
local var_0_1 = g.core.model.User.uniteTokenData

function UniteTokenBagLayer:ctor()
	self._ownList = {}
	self._notOwnList = {}
	self._ownNum = 0
	self._maxNum = 0
	self._cardNum = 0
	self._lineIndex = 0
	self._notOwnCardStartIndex = 0
	self._clearNewList = {}
	self._rawNum = self.m_cardList:getColumnCount()

	self.m_rebornBtn:addClickListener(handler(self, self._onRebornClick))
	self.m_lineUpBtn:addClickListener(handler(self, self._onLineUpClick))
	self.m_sellBtn:addClickListener(handler(self, self._onSellClick))
	self:addBg("bg/knightbag/pic_yht_beibao.jpg")
	self.m_topBar:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.UNITE_TOKEN_BAG)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
	self:_initList()
end

function UniteTokenBagLayer:_onRebornClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.REBORN) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.REBORN, {
			index = require("app.view.module.reborn.const.RebornConst").SELECT_INDEX_MAP.TOKEN,
			title = g.core.lang:get(200518)
		})
	end
end

function UniteTokenBagLayer:_onLineUpClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION, {
		title = g.core.lang:get(200518)
	})
end

function UniteTokenBagLayer:_onSellClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.FragSellPop").new(var_0_1:getCanSellUniteTokenFragDataArr(), {
		fragNameId = 202534,
		qualityArr = g.core.const.ConstMgr.QUALITY_TYPE.SELL_POP_QUALITY_ARRAY[g.core.const.ConstMgr.QUALITY_TYPE.NEW_QUALITY_CTRL.UNITETOKEN],
		title = g.core.lang:get(103036),
		emptyTitle = g.core.lang:get(103037)
	})))
end

function UniteTokenBagLayer:_initList()
	self.m_cardList:setVirtual()
	self.m_cardList:doFairyBatching(false)
	self.m_cardList:setItemProvider(handler(self, self._setCardListItemProvider))
	self.m_cardList:setItemRenderer(handler(self, self._onCardItemRenderer))
end

function UniteTokenBagLayer:_setCardListItemProvider(arg_8_1)
	return (arg_8_1 < self._ownNum or arg_8_1 >= self._notOwnCardStartIndex) and "ui://uniteToken/UniteTokenBagCell" or arg_8_1 == self._lineIndex and "ui://uniteToken/UniteTokenBagLineCell" or arg_8_1 > self._lineIndex and arg_8_1 < self._notOwnCardStartIndex and "ui://uniteToken/UniteTokenBagLineEmptyCell" or "ui://uniteToken/UniteTokenBagEmptyCell"
end

function UniteTokenBagLayer:_onCardItemRenderer(arg_9_1, arg_9_2)
	local var_9_0

	if arg_9_1 < self._ownNum then
		var_9_0 = self._ownList[arg_9_1 + 1]
		self._clearNewList[self._ownList[arg_9_1 + 1]:getAdvanceId()] = true
	elseif arg_9_1 >= self._notOwnCardStartIndex then
		var_9_0 = self._notOwnList[arg_9_1 - self._notOwnCardStartIndex + 1]
	end

	if var_9_0 and arg_9_2.updateCell then
		arg_9_2:updateCell(var_9_0, arg_9_1 + 1)
	end
end

function UniteTokenBagLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ADD_UNITE_TOKEN, handler(self, self._onFragmentCompose), self)
	self:updateView()
end

function UniteTokenBagLayer:_onFragmentCompose(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self:updateView()

	local var_11_0

	if not arg_11_4.insert then
		do return end

		var_11_0 = {
			size = 1,
			type = g.core.common.Goods.TYPE_UNITETOKEN
		}
	end

	var_11_0.value = arg_11_4.insert[1].base_id

	g.core.module.ModuleManager:awardSummary({
		var_11_0
	}, false)
end

function UniteTokenBagLayer:updateView()
	self:_refreshData()
	self.m_numTxt:setText(self._ownNum)
	self.m_maxNumTxt:setText("/" .. self._maxNum)
	self.m_cardList:setNumItems(self._cardNum)
	self.m_cardList:transitionShowCells("listCardAUiScaleIn", 0.1)
	self.m_cardList:scrollToView(0)
end

function UniteTokenBagLayer:_refreshData()
	self._ownList, self._notOwnList = var_0_1:getNewSortTokenList()
	self._ownNum = #self._ownList or 0

	local var_13_0 = #self._notOwnList or 0

	self._maxNum = self._ownNum + var_13_0
	self._lineIndex = self._ownNum + ((self._rawNum - self._ownNum % self._rawNum == self._rawNum or nil) and 0)
	self._notOwnCardStartIndex = self._lineIndex + self._rawNum
	self._cardNum = var_13_0 > 0 and self._notOwnCardStartIndex + var_13_0 or self._ownNum
end

function UniteTokenBagLayer:onUnload()
	if next(self._clearNewList) then
		for iter_14_0, iter_14_1 in pairs(self._clearNewList) do
			g.core.model.User.bagData:clearNewData(g.core.const.ConstMgr.BAG_TYPE.UNITE_TOKEN, iter_14_0)
		end

		self._clearNewList = {}
	end
end

return UniteTokenBagLayer
