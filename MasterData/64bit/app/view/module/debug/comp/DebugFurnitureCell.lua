local BattleKnight = require("app.view.battle.BattleKnight")
local var_0_1 = g.core.const.ConstMgr.FurnitureConst
local var_0_2 = g.core.const.ConstMgr.SpineConst
local DebugFurnitureCell = class("DebugFurnitureCell", require("app.fairyGUI.debug.UI_DebugFurnitureCell"))

function DebugFurnitureCell:ctor()
	self._spineActor = nil

	self.m_knightHolderComp:setScale(var_0_1.ROLE_SCALE_SIZE)
end

function DebugFurnitureCell:hasActor()
	return self._spineActor
end

function DebugFurnitureCell:setActionShowIndex(arg_3_1)
	self.m_actionShowController:setSelectedIndex(arg_3_1)
end

function DebugFurnitureCell:setAnimation(arg_4_1)
	if self._spineActor then
		self._spineActor:setAnimation(0, arg_4_1, true)
	end
end

function DebugFurnitureCell:updateMainKnight(arg_5_1, arg_5_2)
	if self._spineActor then
		self._spineActor:dispose()
	end

	self._spineActor = BattleKnight.new({
		resId = arg_5_1
	})

	self._spineActor:setAnimation(0, arg_5_2, true)
	self.m_knightHolderComp:addNode(self._spineActor)
end

function DebugFurnitureCell:updateURL(arg_6_1, arg_6_2)
	if arg_6_2 then
		if self._furnitureSpine then
			self._furnitureSpine:removeFromParent()
		end

		self._furnitureSpine = self.m_furnitureComp:addEffectSpine({
			isLoop = true,
			name = arg_6_1,
			anim = var_0_2.LOOP_ACTION.IDLE
		})

		self.m_spineFurnitureBorder:setVisible(var_0_1.FURNITURE_SPINE_DEBUG_TOUCH.show)
	else
		self.m_furnitureLoader:setURL(g.core.common.Path:getFurniturePicByRes(arg_6_1))
	end

	self.m_isSpineController:setSelectedIndex(arg_6_2 and 1 or 0)
end

function DebugFurnitureCell:setSpineBorder(arg_7_1, arg_7_2)
	self.m_spineFurnitureBorder:setSize(arg_7_1, arg_7_2)

	local var_7_0 = self.m_furnitureGroup:getPosition()

	self.m_furnitureComp:setPosition(var_7_0.x + arg_7_1 / 2, var_7_0.y + arg_7_2 / 2)
end

function DebugFurnitureCell:getPosition(arg_8_1)
	if arg_8_1 then
		return self.m_knightHolderComp:getPosition()
	else
		return self.m_furnitureLoader:getPosition()
	end
end

function DebugFurnitureCell:setPosition(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3 then
		self.m_knightHolderComp:setPosition(arg_9_1, arg_9_2)
	else
		self.m_furnitureLoader:setPosition(arg_9_1, arg_9_2)
		self.m_furnitureGroup:setPosition(arg_9_1, arg_9_2)
	end
end

return DebugFurnitureCell
