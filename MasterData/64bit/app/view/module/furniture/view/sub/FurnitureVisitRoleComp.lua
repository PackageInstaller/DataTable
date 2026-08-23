local CommonKnight = require("app.view.common.CommonKnight")
local var_0_1 = g.core.const.ConstMgr.FurnitureConst
local var_0_2 = g.core.const.ConstMgr.SpineConst
local FurnitureRoleBehavior = import(".FurnitureRoleBehavior")
local FurnitureVisitRoleComp = class("FurnitureVisitRoleComp", require("app.fairyGUI.furniture.UI_FurnitureVisitRoleComp"))

function FurnitureVisitRoleComp:ctor()
	self._coordx = 0
	self._coordy = 0
	self._behaviorType = 0
	self._routeArray = {}
	self._roleBehavior = nil
	self._furnitureNamePlaced = ""

	self:setDraggable(true)
	self:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragRoleStart))
	self:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onDragEnd))
end

function FurnitureVisitRoleComp:_onDragEnd()
	self._isDragRole = false

	self:setRoleBehavior(var_0_1.ROLE_ACTION.IDLE)
	self.m_isPlaceController:setSelectedIndex(0)
end

function FurnitureVisitRoleComp:_dragRoleStart()
	self._isDragRole = true

	self:setRoleBehavior(var_0_1.ROLE_ACTION.IDLE)

	local var_3_0 = self.m_roleHolderComp:getChild("CommonKnight")

	if var_3_0 then
		var_3_0:playAction(var_0_2.LOOP_ACTION.HEADLINE)
	end

	self:playRoleBathingAni(false)
	self:dispatchCompEvent("DRAG_ROLE_START", (self:getName()))
end

function FurnitureVisitRoleComp:updateRoleComp(arg_4_1)
	local var_4_0 = g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(arg_4_1)

	var_4_0.scale = var_0_1.ROLE_SCALE_SIZE

	self.m_roleHolderComp:addChild((CommonKnight.new(var_4_0)))

	self._roleBehavior = FurnitureRoleBehavior.new()

	self._roleBehavior:setRoleObj(self)

	if arg_4_1 then
		self.m_roleNameTxt:setText(arg_4_1.name)
		self.m_roleLvTxt:setText(g.core.lang:get(120) .. arg_4_1.level)
		self.m_isSelfController:setSelectedIndex(0)
	end
end

function FurnitureVisitRoleComp:updateRoleCompByAdvanceId(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = 0

	if arg_5_2 then
		var_5_0 = arg_5_1

		self.m_roleNameTxt:setText(g.core.model.User:getName())
		self.m_roleLvTxt:setText(g.core.lang:get(120) .. g.core.model.User:getLevel())
	else
		var_5_0 = g.core.config.knight_info.get(arg_5_1).res_id
	end

	self.m_isSelfController:setSelectedIndex(arg_5_2 and 0 or 1)

	if arg_5_3 and arg_5_3 ~= 0 then
		var_5_0 = arg_5_3
	end

	self._knightResId = var_5_0

	self.m_roleHolderComp:addChild((CommonKnight.new({
		resId = var_5_0,
		scale = var_0_1.ROLE_SCALE_SIZE
	})))

	self._roleBehavior = FurnitureRoleBehavior.new()

	self._roleBehavior:setRoleObj(self)

	if arg_5_4 and arg_5_5 then
		self.m_roleNameTxt:setText(arg_5_4)
		self.m_roleLvTxt:setText(g.core.lang:get(120) .. arg_5_5)
		self.m_isSelfController:setSelectedIndex(0)
	end
end

function FurnitureVisitRoleComp:setSpin(arg_6_1)
	self.m_roleHolderComp:getChild("CommonKnight"):setScaleX(arg_6_1)
end

function FurnitureVisitRoleComp:setRoleBehavior(arg_7_1)
	self._behaviorType = arg_7_1

	self._roleBehavior:stopRoleAction()
	self._roleBehavior:updateBeHaviorType(arg_7_1)
	self:playRoleBathingAni(arg_7_1 == var_0_1.ROLE_ACTION.BATH)
end

function FurnitureVisitRoleComp:getRoleActionType()
	return self._behaviorType
end

function FurnitureVisitRoleComp:setRolePlaceCoordXY(arg_9_1, arg_9_2)
	self._coordx = arg_9_1
	self._coordy = arg_9_2
end

function FurnitureVisitRoleComp:getCoordXY()
	return self._coordx, self._coordy
end

function FurnitureVisitRoleComp:getPosList()
	local var_11_0 = {}

	table.insert(var_11_0, {
		x = self._coordx,
		y = self._coordy
	})

	return var_11_0
end

function FurnitureVisitRoleComp:playRoleBathingAni(arg_12_1)
	self.m_bathEff:removeAllEffect()

	if arg_12_1 then
		self.m_bathEff:addEffectSpine({
			name = "jiayuan_zhedang",
			isLoop = true,
			anim = "idle"
		})
	end
end

function FurnitureVisitRoleComp:getRoleResId()
	return self._knightResId
end

function FurnitureVisitRoleComp:setFurnitureNamePlaced(arg_14_1)
	self._furnitureNamePlaced = arg_14_1 or ""
end

function FurnitureVisitRoleComp:getFurnitureNamePlaced()
	return self._furnitureNamePlaced
end

function FurnitureVisitRoleComp:clearFurnitureNamePlaced()
	self._furnitureNamePlaced = ""
end

function FurnitureVisitRoleComp:setRoleCanPutState(arg_17_1)
	self.m_isPlaceController:setSelectedIndex(arg_17_1 and 2 or 1)
end

function FurnitureVisitRoleComp:setRoleCompRouteArray(arg_18_1)
	if not arg_18_1 then
		return
	end

	self._routeArray = arg_18_1

	if self._roleBehavior then
		self._roleBehavior:setRouteArray(self._routeArray)
	end
end

function FurnitureVisitRoleComp:createKnightSpineForSlot(arg_19_1, arg_19_2)
	local var_19_0 = self:getRoleResId()
	local var_19_1 = require("app.view.common.SpineBase").new({
		resId = var_19_0,
		path = require("app.view.battle.BattlePath").getSpineKnightPath(var_19_0),
		anim = self:_getAniWithBehaviorType(arg_19_1)
	})

	var_19_1:setAnchorPoint(0.5, 0.5)
	var_19_1:setScale(var_0_1.ROLE_SCALE_SIZE)

	return var_19_1
end

function FurnitureVisitRoleComp:_getAniWithBehaviorType(arg_20_1)
	if arg_20_1 == var_0_1.ROLE_ACTION.SIT then
		return var_0_2.LOOP_ACTION.SIT
	elseif arg_20_1 == var_0_1.ROLE_ACTION.BATH then
		return var_0_2.LOOP_ACTION.BATHE
	elseif arg_20_1 == var_0_1.ROLE_ACTION.REST then
		return var_0_2.LOOP_ACTION.SLEEP
	else
		return var_0_2.LOOP_ACTION.IDLE
	end
end

function FurnitureVisitRoleComp:isVisitRoleType()
	return true
end

return FurnitureVisitRoleComp
