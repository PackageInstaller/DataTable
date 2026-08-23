local var_0_0 = g.core.config.knight_info
local var_0_1 = g.core.config.knight_base_info
local var_0_2 = g.core.const.ConstMgr.SpineConst
local BattleKnight = require("app.view.battle.BattleKnight")
local AllianceMoveKnightComp = class("AllianceMoveKnightComp", require("app.fairyGUI.alliance.UI_AllianceMoveKnightComp"))

function AllianceMoveKnightComp:ctor()
	self._isMoving = false
	self._knight = nil
end

function AllianceMoveKnightComp:updateSelfKnight()
	self:setShowKnight(g.core.model.User:packUser())
end

function AllianceMoveKnightComp:setShowKnight(arg_3_1)
	local var_3_1, var_3_2 = g.core.common.GlobalFunc.checkAndGetRobotData(arg_3_1)
	local var_3_3 = {}

	if var_3_1 then
		var_3_3.resId = (var_3_2.resId == nil and var_0_1.get(var_0_0.get(var_3_2.showId).res_id) or var_0_1.get(var_3_2.resId)).id
		var_3_3.skinName = "yuanpi_0"
	else
		var_3_3 = g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(arg_3_1)
	end

	if self._knight then
		if self._knight:getResId() ~= var_3_3.resId then
			self._knight:removeFromParent()

			self._knight = BattleKnight.new(var_3_3)

			self.m_showKnight:addNode(self._knight)
		end
	else
		self._knight = BattleKnight.new(var_3_3)

		self.m_showKnight:addNode(self._knight)
	end

	self.m_userName:setText(arg_3_1.name)
end

function AllianceMoveKnightComp:startMove(arg_4_1)
	if self._knight then
		self._isMoving = true

		self._knight:setScaleX(arg_4_1 and 1 or -1)
		self._knight:setAnimation(0, var_0_2.LOOP_ACTION.RUN, true)
	end
end

function AllianceMoveKnightComp:stopMove()
	if self._knight then
		self._isMoving = false

		self._knight:setAnimation(0, var_0_2.LOOP_ACTION.IDLE, true)
	end
end

function AllianceMoveKnightComp:isMoving()
	return self._isMoving
end

return AllianceMoveKnightComp
