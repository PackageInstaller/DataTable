local BattleResultAwardNewComp = class("BattleResultAwardNewComp", require("app.fairyGUI.battleResult.UI_BattleResultAwardNewComp"))

function BattleResultAwardNewComp:ctor()
	self._awardCells = {}
	self._dropParams = {}
	self._isPlayed = {}
	self._isThemeBio = false

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onListAwardRenderer))
	self.m_awardList:setNumItems(0)

	if g.core.guide.GuideProxy:isGuideRunning() then
		self.m_awardList:setTouchable(false)
	end

	self.m_enterTransition:setHook("listLeftIn", handler(self, self._onTransAward))
end

function BattleResultAwardNewComp:_onListAwardRenderer(arg_2_1, arg_2_2)
	arg_2_2._inAnim = arg_2_2._inAnim or arg_2_2.getSharedTrans(arg_2_2, "listIconUiLeftIn", "ItemBagList", arg_2_2)

	local var_2_0 = self._dropParams[arg_2_1 + 1]
	local var_2_1

	if self._dropParams[arg_2_1 + 1].type == g.core.common.Goods.TYPE_ITEM and not self._isThemeBio and g.core.model.User.themeData:isActivityItem(var_2_0.value) then
		var_2_1 = g.core.const.ConstMgr.BASE_CONST.ICON_TAG_TYPE.PROB
	end

	local var_2_2 = {
		nameRow = 0,
		scaleIndex = 2,
		darkQuality = true,
		type = var_2_0.type,
		value = var_2_0.value,
		size = var_2_0.size
	}

	var_2_2.rightTxt = var_2_0.rightTxt or ""
	var_2_2.iconTagType = var_2_1

	arg_2_2:updateIcon(var_2_2)
end

function BattleResultAwardNewComp:update(arg_3_1)
	self._dropParams = arg_3_1.dropList or {}
	self._isThemeBio = arg_3_1.isThemeBio or false

	if arg_3_1.resAwards then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.resAwards) do
			table.insert(self._dropParams, iter_3_1)
		end
	end

	self:_checkNoAwardText(arg_3_1)
end

function BattleResultAwardNewComp:_onTransAward()
	if self._dropParams then
		self.m_awardList:setNumItems(#self._dropParams)
		self.m_awardList:transitionShowCells("listIconUiLeftIn", 0.06, 1)
	end
end

function BattleResultAwardNewComp:play()
	self.m_enterTransition:play(handler(self, function()
		self:dispatchCompEvent("BattleResult_continue")
	end))

	return true
end

function BattleResultAwardNewComp:_checkNoAwardText(arg_7_1)
	if self.m_noAwardTxt then
		local var_7_0 = ""

		if arg_7_1.isPuzzleGameRepeatModel then
			var_7_0 = g.core.lang:get(111541)
		elseif self._dropParams and arg_7_1.isMysteryBattleResult and #self._dropParams == 0 then
			var_7_0 = g.core.lang:get(423009)
		end

		self.m_noAwardTxt:setText(var_7_0)
	end
end

return BattleResultAwardNewComp
