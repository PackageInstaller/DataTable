local BattleResultStormSmallCompleteLayer = class("BattleResultStormSmallCompleteLayer", require("app.fairyGUI.battleResult.UI_BattleResultStormSmallCompleteLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/battleResult/battleResult",
		resName = "BattleResultStormSmallCompleteLayer",
		pkgName = "battleResult"
	})
end)

function BattleResultStormSmallCompleteLayer:ctor(arg_2_1)
	self.m_rewardComp:setDesc(arg_2_1.desc)

	self._callBack = arg_2_1.callback

	self:addClickListener(handler(self, self._onTouchClicked))
	self:setTouchable(false)
	self:showKnight()

	self._isPlayAnim = true

	self.m_comEnterTransition:play(handler(self, self._onEnterAnimEnd))
end

function BattleResultStormSmallCompleteLayer:_onEnterAnimEnd()
	self._isPlayAnim = false
end

function BattleResultStormSmallCompleteLayer:showKnight()
	local var_4_0 = {}

	var_4_0.resId = g.core.model.User.knightsData:getKnight({
		advance_id = g.core.config.knight_info.get(g.core.model.User.knightsData:getMainKnight():getResInfo().id).advance_id
	}):getResInfo().painted_id

	local var_4_1 = require("app.view.common.DrawKnight").new(var_4_0)

	self.m_knightComp:addChild(var_4_1)
	var_4_1:setPosition(400, 0)
	var_4_1:runFGAction((fgui.FSequence:create({
		fgui.FEaseCubicActionOut:create(fgui.FMoveBy:create(1, {
			x = -400,
			y = 0
		})),
		fgui.FCallFunc:create(function()
			self:setTouchable(true)
		end)
	})))
end

function BattleResultStormSmallCompleteLayer:_onTouchClicked()
	if self._isPlayAnim then
		return
	end

	self.m_backTransition:play(handler(self, self.onClose))
end

function BattleResultStormSmallCompleteLayer:onClose()
	g.core.module.ModuleManager:popComponent()

	if self._callBack then
		self._callBack()

		self._callBack = nil
	end
end

return BattleResultStormSmallCompleteLayer
