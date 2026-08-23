local var_0_0 = g.core.config.daily_dungeon_stage_info
local BattleResultDailyDungeonComp = class("BattleResultDailyDungeonComp", require("app.fairyGUI.battleResult.UI_BattleResultDailyDungeonComp"))

function BattleResultDailyDungeonComp:ctor()
	return
end

function BattleResultDailyDungeonComp:update(arg_2_1)
	self._knightId = arg_2_1.knight_id

	self.m_titleText:setText(var_0_0.get(arg_2_1.id).name)

	if arg_2_1.isWin then
		self.m_passStateController:setSelectedIndex(1)
	else
		self.m_passStateController:setSelectedIndex(0)
	end

	self:updateFrontView()
end

function BattleResultDailyDungeonComp:updateFrontView()
	local var_3_0 = self._knightId

	if not self._knightId or var_3_0 == 0 then
		var_3_0 = g.core.model.User.knightsData:getMainKnight():getAdvanceId()
	end

	local var_3_1 = g.core.model.User.knightsData:getKnight({
		advance_id = var_3_0
	})

	self.m_knightPicComp:updateKnight({
		resId = var_3_1:getResInfo().painted_id
	})
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 500, 0), 250)
end

function BattleResultDailyDungeonComp:_onTransSmoke()
	self.m_loseEffComp:addEffectSpine({
		name = "eff_ui_battleResult_titlesmoke",
		scale = 1,
		isLoop = false
	})
end

return BattleResultDailyDungeonComp
