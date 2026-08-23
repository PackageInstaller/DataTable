local BattleKnight = require("app.view.battle.BattleKnight")
local BattleConst = require("app.view.battle.const.BattleConst")
local CrossServerArenaKnightComp = class("CrossServerArenaKnightComp", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaKnightComp"))

function CrossServerArenaKnightComp:ctor()
	self._buffEffUp = nil
	self._buffEffDown = nil
end

function CrossServerArenaKnightComp:setPosIndex(arg_2_1)
	self._index = arg_2_1
end

function CrossServerArenaKnightComp:getPosIndex()
	return self._index
end

function CrossServerArenaKnightComp:setKnightId(arg_4_1)
	self._knightId = arg_4_1
end

function CrossServerArenaKnightComp:updateKnightOpacity(arg_5_1)
	self.m_knightPic:setOpacity(arg_5_1)
end

function CrossServerArenaKnightComp:updateCompByStruct(arg_6_1, arg_6_2, arg_6_3)
	self.m_isRivalController:setSelectedIndex(arg_6_2 and 1 or 0)

	if not arg_6_1 then
		self:hideKnight(true)

		return
	end

	self:hideKnight(false)

	self._knight = arg_6_1
	self._localResId = arg_6_1:getResInfo().fight_id

	if self._lastResId ~= self._localResId and self._knightPic then
		self._knightPic:removeFromParent()

		self._knightPic = nil
	end

	if not self._knightPic then
		self._knightPic = BattleKnight.new({
			breath = true,
			base = true,
			resId = self._localResId,
			isReverse = checkbool(arg_6_2),
			listener = handler(self, self._knightAnimEvent)
		})
		self._lastResId = self._localResId

		self.m_knightPic:addNode(self._knightPic)
		self._knightPic:setScale(0.9)
	end

	if arg_6_3 then
		self:playInAnim()
	end
end

function CrossServerArenaKnightComp:hideKnight(arg_7_1)
	self.m_isEmptyController:setSelectedIndex(arg_7_1 and 1 or 0)
end

function CrossServerArenaKnightComp:_knightAnimEvent(arg_8_1, arg_8_2)
	if arg_8_1 and arg_8_1.animation == BattleConst.SPINE_ACTION_TYPE.IN and arg_8_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		self._knightPic:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.IDLE, true)
	end
end

function CrossServerArenaKnightComp:playInAnim()
	if self._knightPic then
		self._knightPic:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.IN, false)
	end
end

function CrossServerArenaKnightComp:getEmptyStatus()
	return self.m_isEmptyController:getSelectedIndex()
end

function CrossServerArenaKnightComp:playBuff(arg_11_1)
	if arg_11_1 then
		if self._buffEffUp then
			self._buffEffUp:setVisible(true)
		else
			self._buffEffUp = self.m_buffUp:addEffectSpine({
				isLoop = true,
				anim = "play",
				name = "chief_arena_buff_up"
			})
		end

		if self._buffEffDown then
			self._buffEffDown:setVisible(true)
		else
			self._buffEffDown = self.m_buffDown:addEffectSpine({
				isLoop = true,
				anim = "play",
				name = "chief_arena_buff_down"
			})
		end
	else
		if self._buffEffUp then
			self._buffEffUp:setVisible(false)
		end

		if self._buffEffDown then
			self._buffEffDown:setVisible(false)
		end
	end
end

return CrossServerArenaKnightComp
