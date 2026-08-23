local var_0_0 = g.core.const.ConstMgr.BattleResultConst
local BattleSelectCardLayer = class("BattleSelectCardLayer", require("app.fairyGUI.battleResult.UI_BattleSelectCardLayer"), function()
	return fgui.GComponent:create({
		resName = "BattleSelectCardLayer",
		pkgPath = "ui/battleResult/battleResult",
		isFullScreen = true,
		pkgName = "battleResult"
	}, ...)
end)

function BattleSelectCardLayer:ctor(arg_2_1)
	self._countdown = var_0_0.CARD_COUNTDOWN_TIME
	self._isDone = false
	self._isClick = false

	self:_initData(arg_2_1)
	self:_initTouch()
	self:_startCountdown()
end

function BattleSelectCardLayer:_initTouch()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))

	for iter_3_0 = 1, var_0_0.CARD_NUM do
		self["m_cardComp" .. iter_3_0]:addClickListener(function()
			self:_onClickCard(iter_3_0)
		end)
	end
end

function BattleSelectCardLayer:_initData(arg_5_1)
	local var_5_0 = g.core.common.Drops:getGoodsArray(arg_5_1.dropId, true)

	self._randomAwardList = g.core.utils.Table.randomMultiple(var_5_0, 2)

	if #self._randomAwardList == 1 then
		table.insert(self._randomAwardList, var_5_0[1])
	end

	table.insert(self._randomAwardList, (g.core.common.Goods:convert(arg_5_1.drops[1])))
end

function BattleSelectCardLayer:_onTouchBegin(arg_6_1)
	if self._isDone then
		g.core.module.ModuleManager:popComponent()
		g.core.battle.BattleProxy:exitBattle()
	end
end

function BattleSelectCardLayer:_onClickCard(arg_7_1)
	if self._isClick then
		return
	end

	self._isClick = true

	self["m_cardComp" .. arg_7_1]:updateCell(self._randomAwardList[var_0_0.CARD_NUM], true)
	self:runFGAction((fgui.FSequence:create({
		fgui.FDelayTime:create(var_0_0.CARD_DELAYOPEN_TIME),
		fgui.FCallFunc:create(function()
			for iter_8_0 = 1, var_0_0.CARD_NUM do
				local var_8_0

				if iter_8_0 ~= arg_7_1 then
					self["m_cardComp" .. iter_8_0]:updateCell(self._randomAwardList[1], false)

					var_8_0 = 1 + 1
				end
			end
		end),
		fgui.FDelayTime:create(1),
		fgui.FCallFunc:create(function()
			self._isDone = true
		end)
	})))
end

function BattleSelectCardLayer:_startCountdown()
	self:scheduleUpdate(1)
	self:onScheduleUpdate(nil, 0)
end

function BattleSelectCardLayer:_stopCountdown()
	self:unscheduleUpdate()
end

function BattleSelectCardLayer:onScheduleUpdate(arg_12_1, arg_12_2)
	self._countdown = self._countdown - arg_12_2

	if self._countdown == 0 then
		self:_onClickCard(math.random(var_0_0.CARD_NUM))
		self:_stopCountdown()
	end
end

return BattleSelectCardLayer
