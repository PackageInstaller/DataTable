local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostRecoverInfoComp = class("OutpostRecoverInfoComp", require("app.fairyGUI.outpost.UI_OutpostRecoverInfoComp"))

function OutpostRecoverInfoComp:ctor()
	self._buildData = nil
	self._lastBonusDic = nil
	self._curBonusList = nil
	self._nextBonusList = nil
	self._inLevelUp = false

	self:_initComp()
end

function OutpostRecoverInfoComp:_initComp()
	self.m_levelUpBtn:addClickListener(handler(self, self._onLevelUpBtnClicked))
	self.m_curBonusInfoList:setVirtual(self)
	self.m_curBonusInfoList:doFairyBatching(false)
	self.m_curBonusInfoList:setItemRenderer(handler(self, self._onCurBonusItemRender))
	self.m_nextBonusInfoList:setVirtual(self)
	self.m_nextBonusInfoList:doFairyBatching(false)
	self.m_nextBonusInfoList:setItemRenderer(handler(self, self._onNextBonusItemRender))
	self.m_costComp:setCustomGetNumFunc(function()
		return g.core.model.User.outpostData:getBagData():getOwnNum(var_0_0.KNIGHT_COIN_ID)
	end)
	self.m_progComp:setMax(100)
end

function OutpostRecoverInfoComp:updateInfoComp(arg_4_1)
	self._buildData = arg_4_1

	self:setTitle(arg_4_1:getBuildName())
	self.m_levelTxt:setText((g.core.lang:get(100038, {
		level = arg_4_1:getLevel()
	})))

	local var_4_0 = self._buildData:getNodeInfo()

	self:_updateCurBonusInfo()
	self.m_costComp:updateByTVS(self:_dicToList((self._buildData:getLevelUpCostDic()))[1])

	if var_4_0 then
		self.m_progComp:setValue((math.floor((self._buildData:getLevel() - var_4_0.min) / (var_4_0.cnt - 1) * 100)))
		self.m_progComp:setVisible(true)
	else
		self.m_progComp:setVisible(false)
	end

	self:_updateNodeBonusInfo(var_4_0)

	if self._buildData:isMaxBuildLevel() then
		self.m_isMaxLevelController:setSelectedIndex(1)
	else
		self.m_isMaxLevelController:setSelectedIndex(0)
	end

	self._inLevelUp = false
end

function OutpostRecoverInfoComp:_dicToList(arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		var_5_0[#var_5_0 + 1] = iter_5_1
	end

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		return arg_6_0.type < arg_6_1.type
	end)

	return var_5_0
end

function OutpostRecoverInfoComp:_updateCurBonusInfo()
	self._lastEffectList = {}

	if self._inLevelUp then
		self._lastEffectList = self._buildData:getEffectInfoList(self._buildData:getLevel() - 1)
	end

	self._curBonusList = self._buildData:getEffectInfoList()

	self.m_curBonusInfoList:setNumItems(#self._curBonusList)
end

function OutpostRecoverInfoComp:_onCurBonusItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateUpComp(self._curBonusList[arg_8_1 + 1], {
		isTotalTime = true,
		needShake = (self._curBonusList[arg_8_1 + 1].type == var_0_0.BONUS_TYPE.COIN_TYPE and self._inLevelUp or nil) and self._curBonusList[arg_8_1 + 1].value - ((self._lastEffectList[arg_8_1 + 1] or {}).value or 0) ~= 0
	})
end

function OutpostRecoverInfoComp:_updateNodeBonusInfo(arg_9_1)
	if not arg_9_1 then
		self.m_nextBonusInfoList:setNumItems(0)

		return
	end

	self._nextBonusList = self:_dicToList((self._buildData:getOneBonusInfoByLevel(arg_9_1.max)))

	self.m_nextBonusInfoList:setNumItems(#self._nextBonusList)
end

function OutpostRecoverInfoComp:_onNextBonusItemRender(arg_10_1, arg_10_2)
	arg_10_2:updateUpComp(self._nextBonusList[arg_10_1 + 1])
end

function OutpostRecoverInfoComp:_onLevelUpBtnClicked()
	self:dispatchCompEvent("buildLevelUp")
end

function OutpostRecoverInfoComp:checkAndPlayNodeMatchEff(arg_12_1)
	self._effCallback = arg_12_1

	self.m_effectNode:addEffectSpine({
		remove = true,
		name = "eff_ui_outpost_makeuplight",
		isLoop = false,
		eventHandler = handler(self, self._onUpEffEnd)
	})

	self._inLevelUp = true
end

function OutpostRecoverInfoComp:_onUpEffEnd(arg_13_1)
	if arg_13_1.type == "complete" and self._effCallback then
		self._effCallback()
	end
end

return OutpostRecoverInfoComp
