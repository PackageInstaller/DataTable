local BattleSuccubaCompareResultPop = class("BattleSuccubaCompareResultPop", require("app.fairyGUI.battle.UI_BattleSuccubaCompareResultPop"), function()
	return fgui.GComponent:create({
		resName = "BattleSuccubaCompareResultPop",
		pkgPath = "ui/battle/battle",
		isFullScreen = true,
		pkgName = "battle"
	})
end)

function BattleSuccubaCompareResultPop:ctor(arg_2_1, arg_2_2, arg_2_3)
	self._battleLayer = arg_2_1
	self._endEvent = arg_2_2
	self._result = arg_2_3.result

	self:play()

	local var_2_0 = 2700
	local var_2_1

	if self._result.buffId == 903 then
		var_2_0 = 2702

		if self._result.identity == 2 then
			var_2_0 = 2703
		end
	elseif self._result.identity == 2 then
		var_2_0 = 2701
		var_2_1 = {}
	end

	var_2_1.num = g.core.config.buff_info.get(self._result.buffId).buff_value_3

	self.m_title:setText(g.core.lang:get(var_2_0, var_2_1))

	local var_2_2 = #self._result.knights

	if #self._result.knights > 3 then
		var_2_2 = 3
	end

	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightListRenderer))
	self.m_knightList:setNumItems(var_2_2)
end

function BattleSuccubaCompareResultPop:_onKnightListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateCompareCell(self._result.knights[arg_3_1 + 1])
end

function BattleSuccubaCompareResultPop:onLoad()
	return
end

function BattleSuccubaCompareResultPop:onUnload()
	return
end

function BattleSuccubaCompareResultPop:play()
	self.m_enterTransition:play(handler(self, self.onEnterAnimPlayEnd))
end

function BattleSuccubaCompareResultPop:onEnterAnimPlayEnd()
	self:newScheduleOnce(handler(self, function()
		self.m_backTransition:play(handler(self, self.onPlayEndFinish))
	end), 1)
end

function BattleSuccubaCompareResultPop:onPlayEndFinish()
	if self._endEvent then
		self._endEvent()
	end
end

return BattleSuccubaCompareResultPop
