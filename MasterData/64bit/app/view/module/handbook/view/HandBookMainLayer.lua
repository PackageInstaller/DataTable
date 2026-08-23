local var_0_0 = {
	[0] = g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.DEFAULT,
	g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO,
	g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LIN_DONG,
	g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.DONG_XI,
	g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LI_JIN
}
local HandBookMainLayer = class("HandBookMainLayer", require("app.fairyGUI.handBook.UI_HandBookMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "handBook",
		isFullScreen = true,
		pkgPath = "ui/handBook/handBook",
		resName = "HandBookMainLayer"
	})
end)

function HandBookMainLayer:ctor()
	self:addBg("bg/common/pic_bb_beijing.jpg")

	self.m_pnlEnterTransition = self:getView():getTransition("pnlEnter")
	self._handBookList = {}
	self._curSelectCamp = 0
	self._curQualitySelect = 0
	self._curScore = g.core.model.User.handBookData:getTotalKnightBookScore()
	self._curActAdvId = nil
	self._saveActAdvId = nil
	self._oldScore = 0
	self._curShowList = {}

	self.m_selectBtn:addClickListener(handler(self, self._onShowSelectComp))
	self.m_touchLayer:addClickListener(handler(self, self._onHideSelectComp))
	self.m_processComp:addClickListener(handler(self, self._onAchievementBtnClick))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyBtnClick))
	self.m_groupList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onGroupItemClick))
	self.m_groupList:setSelectedIndex(0)
	self.m_runnerComp:init({
		target = self.m_groupList
	})

	local var_2_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_2_1 = self.m_bookList:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_2_0.x > 0 then
		var_2_1 = var_2_1 - var_2_0.x * 2
	end

	self.m_bookList:setWidth(var_2_1)
	self.m_bookList:setVirtual()
	self.m_bookList:doFairyBatching(false)
	self.m_bookList:setItemRenderer(handler(self, self._onBookRenderer))
	self.m_bookList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onItemClick2))

	self._handBookList = g.core.model.User.handBookData:getCurHandBookDataByTag(var_0_0[self._curSelectCamp])

	self:_updateView()
end

function HandBookMainLayer:onLoad()
	self.m_topBarComp:setResInfoById(3)
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_BOOK_UPGRADE, handler(self, self._onRcvUpgrade), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_HANDBOOK_ONEKEYUPGRADE, handler(self, self._onRcvOneKeyUpgrade), self)
end

function HandBookMainLayer:_onItemClick2(arg_4_1)
	local var_4_0 = arg_4_1:getDataValue()

	if self._curExpandIndex and self._curExpandIndex == var_4_0 then
		self._curExpandIndex = nil

		self.m_bookList:setNumItems(#self._curShowList)
	elseif self._curExpandIndex and self._curExpandIndex + 1 == var_4_0 then
		-- block empty
	else
		self._curExpandIndex = self._curExpandIndex and var_4_0 > self._curExpandIndex + 1 and var_4_0 - 1 or var_4_0

		self.m_bookList:setNumItems(#self._curShowList + 1)
	end

	if self.m_bookList:getScrollPane():getPercX() > 0.96 then
		self.m_bookList:getScrollPane():scrollLeft(1, false)
		self.m_bookList:getScrollPane():scrollRight(1, false)
	end
end

function HandBookMainLayer:_updateView()
	self:_updateList()
	self.m_processComp:update()
	self:_updateOneKeyGroup()
end

function HandBookMainLayer:_updateOneKeyGroup()
	local var_6_0, var_6_1, var_6_2 = g.core.model.User.handBookData:getAllCanActiveOrUpgradeHandBookList()
	local var_6_4 = #var_6_0 > 0

	self.m_oneKeyController:setSelectedIndex((g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HANDBOOK_ONEKEY_KNIGHT) and var_6_4 and #var_6_1 <= 0 or nil) and 1)

	if not self._oneKeyEffSpine then
		local var_6_6 = self.m_oneKeyBtn:getSize()

		self._oneKeyEffSpine = self.m_oneKeyBtn:addEffectSpine({
			name = "eff_ui_handbook_activatebtn",
			scale = 1,
			isLoop = true,
			x = var_6_6.width / 2,
			y = var_6_6.height / 2
		})
	end

	self._oneKeyEffSpine:setVisible(var_6_4)
end

function HandBookMainLayer:_updateList()
	self:cancelAllSchedule()
	self:_updateShowData()
	self.m_bookList:setNumItems(#self._curShowList + (self._curExpandIndex and 1 or 0))

	self._isInit = self._isInit or true
end

function HandBookMainLayer:_onBookRenderer(arg_8_1, arg_8_2)
	local var_8_1 = self._curExpandIndex and self._curExpandIndex == arg_8_1
	local var_8_2 = self._curExpandIndex and self._curExpandIndex + 1 == arg_8_1

	arg_8_2:setData(self._curShowList[(self._curExpandIndex and arg_8_1 >= self._curExpandIndex + 1 or nil) and arg_8_1], self._curActAdvId, (self._curActAdvId or nil) and handler(self, self.onEffPlayFinish))

	if var_8_1 then
		arg_8_2:updateOpenCell()
	elseif var_8_2 then
		arg_8_2:updateView()
	end
end

function HandBookMainLayer:_onQualityTabCtrlChange()
	self._curQualitySelect = self.m_qualityTabController:getSelectedIndex()

	self:_updateList()
end

function HandBookMainLayer:_onShowSelectComp()
	self.m_selectStateController:setSelectedIndex(1)
	self.m_pnlEnterTransition:play()
end

function HandBookMainLayer:_onHideSelectComp()
	self.m_selectStateController:setSelectedIndex(0)
	self.m_pnlEnterTransition:playReverse()
end

function HandBookMainLayer:_onGroupItemClick(arg_12_1)
	local var_12_0 = arg_12_1:getDataValue()

	if self._curSelectCamp ~= var_12_0 then
		self._curSelectCamp = var_12_0
		self._handBookList = g.core.model.User.handBookData:getCurHandBookDataByTag(var_0_0[self._curSelectCamp])
		self._curExpandIndex = nil

		self:_updateList()
		self.m_bookList:scrollToView(0, true)
	end
end

function HandBookMainLayer:receiveCompEvent(arg_13_1, arg_13_2)
	if arg_13_1 == "HandBookConfirm_Click" then
		self:_onHideSelectComp()

		if self._curQualitySelect == arg_13_2.quality then
			return
		end

		self._curQualitySelect = arg_13_2.quality
		self._handBookList = g.core.model.User.handBookData:getCurHandBookDataByTag(var_0_0[self._curSelectCamp])
		self._curExpandIndex = nil

		self:_updateList()
		self.m_bookList:scrollToView(0, true)
	end
end

function HandBookMainLayer:_onAchievementBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.handbook.view.HandBookAchievementPop").new(), {
		touchDisappear = true
	})
end

function HandBookMainLayer:_onOneKeyBtnClick()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.HANDBOOK_ONEKEY_KNIGHT) then
		return
	end

	local var_15_0, var_15_1, var_15_2 = g.core.model.User.handBookData:getAllCanActiveOrUpgradeHandBookList()

	if #var_15_2 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(205574))
	else
		g.core.network.GameNetProxy:send_C2S_Handbook_OneKeyUpgrade({
			tp = g.core.network.proto.KNIGHT_HB,
			ids = var_15_2
		})
	end
end

function HandBookMainLayer:playProcessAnim()
	self.m_processComp:playProcessAnim()
end

function HandBookMainLayer:onEffPlayFinish()
	if not self._saveActAdvId then
		return
	end

	local var_17_0 = g.core.model.User.handBookData:getCurScoreInfo(self._oldScore)
	local var_17_1 = g.core.model.User.handBookData:getCurScoreInfo()
	local var_17_2 = false

	if var_17_0 and var_17_0.id ~= var_17_1.id or not var_17_0 and var_17_1 then
		var_17_2 = true

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_WAIT)
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.handbook.view.HandBookLvUpPop").new({
		advId = self._saveActAdvId,
		showLvUpFeedBack = var_17_2,
		oldScore = self._oldScore
	}), {
		touchDisappear = true
	})

	self._saveActAdvId = nil
end

function HandBookMainLayer:_onRcvUpgrade(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	self._oldScore = self._curScore
	self._curScore = g.core.model.User.handBookData:getTotalKnightBookScore()

	if g.core.model.User.handBookData:getKnightBookLevel(arg_18_4.id) ~= 0 then
		self._curActAdvId = arg_18_4.id
		self._saveActAdvId = arg_18_4.id

		self:onEffPlayFinish()
	else
		self._curActAdvId = arg_18_4.id
		self._saveActAdvId = arg_18_4.id
	end

	for iter_18_0, iter_18_1 in ipairs(self._handBookList) do
		self._handBookList[iter_18_0] = g.core.model.User.handBookData:getHandBookNewestData(iter_18_1.advId)
	end

	self:_updateView()

	self._curActAdvId = nil

	self:playProcessAnim()
end

function HandBookMainLayer:_onRcvOneKeyUpgrade(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	self._oldScore = self._curScore
	self._curScore = g.core.model.User.handBookData:getTotalKnightBookScore()

	if arg_19_4.ids and #arg_19_4.ids > 0 then
		local var_19_0 = g.core.model.User.handBookData:getKnightBookLevel(arg_19_4.ids[#arg_19_4.ids])

		self._curActAdvId = arg_19_4.ids[#arg_19_4.ids]
		self._saveActAdvId = arg_19_4.ids[#arg_19_4.ids]

		self:onEffPlayFinish()
	end

	for iter_19_0, iter_19_1 in ipairs(self._handBookList) do
		self._handBookList[iter_19_0] = g.core.model.User.handBookData:getHandBookNewestData(iter_19_1.advId)
	end

	self:_updateView()

	self._curActAdvId = nil

	self:playProcessAnim()
end

function HandBookMainLayer:_updateShowData()
	self._curShowList = {}

	if self._curQualitySelect == 0 then
		self._curShowList = self._handBookList
	else
		for iter_20_0, iter_20_1 in ipairs(self._handBookList) do
			if iter_20_1.quality == self._curQualitySelect then
				table.insert(self._curShowList, iter_20_1)
			end
		end
	end
end

return HandBookMainLayer
