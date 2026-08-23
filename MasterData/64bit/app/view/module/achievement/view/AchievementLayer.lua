local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.AchievementConst
local var_0_2 = g.core.const.ConstMgr.AchievementConst.RECEIVE_STATE
local var_0_3 = g.core.model.User.achievementData
local AchievementTotalProgPop = require("app.view.module.achievement.view.AchievementTotalProgPop")
local AchievementLayer = class("AchievementLayer", require("app.fairyGUI.achievement.UI_AchievementLayer"), function()
	return fgui.GComponent:create({
		pkgName = "achievement",
		isFullScreen = true,
		pkgPath = "ui/achievement/achievement",
		resName = "AchievementLayer"
	}, ...)
end)

function AchievementLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._achievementItemDataStructArr = {}
	self._normalAchieveDictArr = var_0_3:getAchieveDictArr()
	self._pageIdxCpp = math.min(arg_2_1.index or 0, (self:_luaIdxToCppIdx((self:_getTotalPage()))))
	self._progressStatus = var_0_2.NOT_ACHIEVE
	self._awardDataStruct = nil
	self._isFirstIn = true

	self:_initView()
end

function AchievementLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACHIEVEMENT_REWARD, self._onS2CRewardOneKey, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACHIEVEMENT_REWARD_ONEKEY, self._onS2CRewardOneKey, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACHIEVEMENT_FINISH, self._onS2CFinishOneKey, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACHIEVEMENT_FINISH_ONEKEY, self._onS2CFinishOneKey, self)
	self:_updateView()
	self.m_enterTransition:play()
end

function AchievementLayer:onUnload()
	self.m_backTransition:play()
end

function AchievementLayer:_initView()
	self:addBg("bg/achievement/bg_rongyushi.jpg")
	self.m_topBarComp:setResInfoById(4)
	self.m_progressComp:addClickListener(handler(self, self.onClickProgress))
	self.m_oneKeyRcvBtn:addClickListener(handler(self, self._onClickOneKeyRcv))
	self.m_tabList:setIniter()
	self.m_tabList:doFairyBatching(true)
	self.m_tabList:setItemRenderer(handler(self, self._onTabListRenderer))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTab))
	self.m_tabList:setNumItems(self:_getTotalPage())
	self.m_tabList:setSelectedIndex(self._pageIdxCpp)
	self.m_achieveList:setVirtual()
	self.m_achieveList:doFairyBatching(false)
	self.m_achieveList:setItemRenderer(handler(self, self._onAchieveListRenderer))
	self.m_totalProgAwardList:setIniter(self)
	self.m_totalProgAwardList:doFairyBatching(true)
	self.m_totalProgAwardList:setItemRenderer(handler(self, self._onTotalProgAwardListRenderer))
end

function AchievementLayer:_updateView()
	self.m_tabList:setNumItems(self:_getTotalPage())

	if self._isFirstIn then
		self._isFirstIn = false

		self:_updateAchieveListView(true)
	else
		self:_updateAchieveListView(false)
	end

	self:_updateOneKeyRcvBtn()
	self:_updateTotalProgressInfo()
end

function AchievementLayer:_updateOneKeyRcvBtn()
	self.m_oneKeyRcvBtn:setVisible((g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.ACHIEVEMENT_ONE_KEY_AWARD) or nil) and (#var_0_3:getOneKeyGetAchieveRewardIds() > 0 and true or #var_0_3:getOneKeyGetProgressRewardIds() > 0))
end

function AchievementLayer:_updateAchievementItemDataStructArr(arg_8_1)
	local var_8_0 = {}

	if arg_8_1 > #self._normalAchieveDictArr then
		var_8_0 = var_0_3:getShowedHideAchieveArr()
	else
		for iter_8_0 in pairs(self._normalAchieveDictArr[arg_8_1]) do
			table.insert(var_8_0, (var_0_3:getShowAchievementItemDataStruct(arg_8_1, iter_8_0)))
		end
	end

	if #var_8_0 > 1 then
		table.sort(var_8_0, function(arg_9_0, arg_9_1)
			local var_9_0 = arg_9_0:getState()
			local var_9_1 = arg_9_1:getState()

			if var_9_0 == var_9_1 then
				return arg_9_0:getInfo().id < arg_9_1:getInfo().id
			else
				return var_9_0 < var_9_1
			end
		end)
	end

	self._achievementItemDataStructArr = var_8_0
end

function AchievementLayer:_updateAchieveListView(arg_10_1)
	self:_updateAchievementItemDataStructArr((self:_cppIdxToLuaIdx(self._pageIdxCpp)))
	self.m_achieveList:setNumItems(#self._achievementItemDataStructArr)

	if arg_10_1 then
		self.m_achieveList:transitionShowCells("enter_scaleOut", 0.03)
	end
end

function AchievementLayer:onClickProgress()
	if self._progressStatus == var_0_2.CAN_RECEIVE then
		if self._awardDataStruct then
			g.core.network.GameNetProxy:send_C2S_Achievement_Reward({
				id = self._awardDataStruct:getInfo().id
			})
		end
	elseif self._progressStatus == var_0_2.NOT_ACHIEVE then
		g.core.module.ModuleManager:pushPopup(AchievementTotalProgPop.new(), {
			touchDisappear = true
		})
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.CLICK_ENTER)
end

function AchievementLayer:_onClickOneKeyRcv()
	var_0_3:reqGetAchieveRewardOneKey()
end

function AchievementLayer:_onS2CRewardOneKey(arg_13_1, arg_13_2, arg_13_3)
	g.core.module.ModuleManager:awardSummary(arg_13_3.awards)
	self:_updateTotalProgressInfo()
	self:_updateOneKeyRcvBtn()
end

function AchievementLayer:_onS2CFinishOneKey(arg_14_1, arg_14_2, arg_14_3)
	g.core.module.ModuleManager:awardSummary(arg_14_3.awards)
	self.m_tabList:setNumItems(self:_getTotalPage())
	self:_updateAchieveListView(false)
	self:_updateTotalProgressInfo()
	self:_updateOneKeyRcvBtn()
end

function AchievementLayer:_updateTotalProgressInfo()
	local var_15_0 = var_0_3:getCurTotalProgAwardDataStruct()

	self._awardDataStruct = var_15_0
	self._progressStatus = var_15_0:getState()

	local var_15_1 = var_15_0:getCurNum()

	self.m_currentValueText:setText(var_15_1)

	local var_15_2 = var_15_0:getInfo()

	self.m_totalValueText:setText(g.core.lang:get(113001, {
		totalValue = var_15_2.num
	}))
	self.m_progressComp:updateView({
		currentValue = var_15_1,
		totalValue = var_15_2.num
	})
	self.m_totalProgAwardList:setNumItems(#var_15_0:getAwardArr())
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function AchievementLayer:_onTabListRenderer(arg_16_1, arg_16_2)
	arg_16_2:setStyleByIndex(1)
	arg_16_2:setTitle(g.core.lang:get(113007 + arg_16_1))
	arg_16_2:setRedPointId(var_0_1.LEFT_TAB_RED_POINT_ID, {
		page = self:_cppIdxToLuaIdx(arg_16_1)
	})
end

function AchievementLayer:_onAchieveListRenderer(arg_17_1, arg_17_2)
	arg_17_2:updateCell(self._achievementItemDataStructArr[self:_cppIdxToLuaIdx(arg_17_1)])
end

function AchievementLayer:_onTotalProgAwardListRenderer(arg_18_1, arg_18_2)
	local var_18_0 = self._awardDataStruct:getAwardArr()[self:_cppIdxToLuaIdx(arg_18_1)]

	var_18_0.scaleIndex = 4

	arg_18_2:updateIcon(var_18_0)
end

function AchievementLayer:_onClickTab(arg_19_1)
	local var_19_0 = arg_19_1:getDataValue()

	if var_19_0 == self._pageIdxCpp then
		return
	end

	self._pageIdxCpp = var_19_0

	self:_updateAchieveListView(true)
	self.m_achieveList:scrollToView(0)
end

function AchievementLayer:_getTotalPage()
	local var_20_0 = #self._normalAchieveDictArr

	if #var_0_3:getShowedHideAchieveArr() > 0 then
		var_20_0 = var_20_0 + 1
	end

	return var_20_0
end

function AchievementLayer:_cppIdxToLuaIdx(arg_21_1)
	return arg_21_1 + 1
end

function AchievementLayer:_luaIdxToCppIdx(arg_22_1)
	return arg_22_1 - 1
end

return AchievementLayer
