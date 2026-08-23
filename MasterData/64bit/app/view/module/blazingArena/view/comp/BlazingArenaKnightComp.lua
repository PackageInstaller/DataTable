local BattleKnight = require("app.view.battle.BattleKnight")
local BattleConst = require("app.view.battle.const.BattleConst")
local BlazingArenaKnightComp = class("BlazingArenaKnightComp", require("app.fairyGUI.blazingArena.UI_BlazingArenaKnightComp"))

function BlazingArenaKnightComp:setPosIndex(arg_1_1)
	self._index = arg_1_1
end

function BlazingArenaKnightComp:getPosIndex()
	return self._index
end

function BlazingArenaKnightComp:setKnightId(arg_3_1)
	self._knightId = arg_3_1
end

function BlazingArenaKnightComp:updateKnightOpacity(arg_4_1)
	self.m_knightPic:setOpacity(arg_4_1)
end

function BlazingArenaKnightComp:updateCompByStruct(arg_5_1, arg_5_2, arg_5_3)
	self.m_isRivalController:setSelectedIndex(arg_5_2 and 1 or 0)

	if not arg_5_1 then
		self:hideKnight(true)

		return
	end

	self:hideKnight(false)

	self._knight = arg_5_1
	self._localResId = arg_5_1:getResInfo().fight_id

	if self._lastResId ~= self._localResId and self._knightPic then
		self._knightPic:removeFromParent()

		self._knightPic = nil
	end

	if not self._knightPic then
		self._knightPic = BattleKnight.new({
			breath = true,
			base = true,
			resId = self._localResId,
			isReverse = checkbool(arg_5_2),
			listener = handler(self, self._knightAnimEvent)
		})
		self._lastResId = self._localResId

		self.m_knightPic:addNode(self._knightPic)
		self._knightPic:setScale(0.9)
	end

	if arg_5_3 then
		self:playInAnim()
	end
end

function BlazingArenaKnightComp:hideKnight(arg_6_1)
	self.m_isEmptyController:setSelectedIndex(arg_6_1 and 1 or 0)
end

function BlazingArenaKnightComp:_knightAnimEvent(arg_7_1, arg_7_2)
	if arg_7_1 and arg_7_1.animation == BattleConst.SPINE_ACTION_TYPE.IN and arg_7_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		self._knightPic:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.IDLE, true)
	end
end

function BlazingArenaKnightComp:playInAnim()
	if self._knightPic then
		self._knightPic:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.IN, false)
	end
end

function BlazingArenaKnightComp:getEmptyStatus()
	return self.m_isEmptyController:getSelectedIndex()
end

return BlazingArenaKnightComp
