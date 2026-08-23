local BattleResultThemeGuessAwardComp = class("BattleResultThemeGuessAwardComp", require("app.fairyGUI.battleResult.UI_BattleResultThemeGuessAwardComp"))

function BattleResultThemeGuessAwardComp:ctor()
	self._awardCells = {}
	self._dropParams = {}
	self._isPlayed = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onListAwardRenderer))
	self.m_awardList:setNumItems(0)
	self.m_newImg:setVisible(false)

	if g.core.guide.GuideProxy:isGuideRunning() then
		self.m_awardList:setTouchable(false)
	end

	self.m_enterTransition:setHook("listLeftIn", handler(self, self._onTransAward))
end

function BattleResultThemeGuessAwardComp:_onListAwardRenderer(arg_2_1, arg_2_2)
	local var_2_0

	if not arg_2_2._inAnim then
		arg_2_2._inAnim = arg_2_2.getSharedTrans(arg_2_2, "listIconUiLeftIn", "ItemBagList", arg_2_2)
		var_2_0 = {
			scaleIndex = 2,
			darkQuality = true,
			nameRow = 0,
			type = self._dropParams[arg_2_1 + 1].type,
			value = self._dropParams[arg_2_1 + 1].value,
			size = self._dropParams[arg_2_1 + 1].size
		}
	end

	var_2_0.rightTxt = self._dropParams[arg_2_1 + 1].rightTxt or ""

	arg_2_2:updateIcon(var_2_0)
end

function BattleResultThemeGuessAwardComp:update(arg_3_1)
	self._dropParams = arg_3_1.dropList or {}

	if arg_3_1.resAwards then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.resAwards) do
			table.insert(self._dropParams, iter_3_1)
		end
	end

	self.m_fristPassController:setSelectedIndex(arg_3_1.resAwards and 1 or 0)
	self.m_curScoreTxt:setText(arg_3_1.score)

	local var_3_0 = arg_3_1.maxScore or 0

	self.m_historyScoreTxt:setText(var_3_0)
	self.m_newImg:setVisible(var_3_0 < arg_3_1.score)
	self:_checkNoAwardText()
end

function BattleResultThemeGuessAwardComp:_onTransAward()
	if self._dropParams then
		self.m_awardList:setNumItems(#self._dropParams)
		self.m_awardList:transitionShowCells("listIconUiLeftIn", 0.06, 1)
	end
end

function BattleResultThemeGuessAwardComp:play()
	self.m_enterTransition:play(handler(self, function()
		self:dispatchCompEvent("BattleResult_continue")
	end))

	return true
end

function BattleResultThemeGuessAwardComp:_checkNoAwardText()
	if self.m_noAwardTxt then
		self.m_noAwardTxt:setText((g.core.lang:get(405800)))
	end
end

return BattleResultThemeGuessAwardComp
