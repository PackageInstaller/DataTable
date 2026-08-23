local var_0_0 = g.core.const.ConstMgr.SpineConst
local var_0_1 = g.core.const.ConstMgr.FurnitureConst
local CommonKnight = require("app.view.common.CommonKnight")
local FurnitureRoleBehavior = import(".FurnitureRoleBehavior")
local var_0_4 = g.core.model.User.furnitureData
local FurnitureRoleComp = class("FurnitureRoleComp", require("app.fairyGUI.furniture.UI_FurnitureRoleComp"))

function FurnitureRoleComp:ctor()
	self._bathingTimer = nil
	self._coordx = 0
	self._coordy = 0
	self._mobilityFrom = 0
	self._behaviorType = 0
	self._passedTime = 0
	self._furnitureNamePlaced = ""
	self._knightStruct = nil
	self._roleBehavior = nil
	self._bathingEffNode = nil
	self._isDragRole = false

	self:setDraggable(true)
	self:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragRoleStart))
	self:addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onDragEnd))
	self:addClickListener(handler(self, self._onShowQuickBubButton))
	self.m_bathBubBtn:addClickListener(handler(self, self._onClickQuickBathBtn))
end

function FurnitureRoleComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self._onModuleExit), self)
	self.m_actionCircleBar:runFGAction(fgui.FSequence:create({
		fgui.FDelayTime:create(1),
		fgui.FFadeOut:create(0.5)
	}))
	self.m_isShowBubbleController:setSelectedIndex(0)
end

function FurnitureRoleComp:_onModuleExit()
	self.m_actionCircleBar:runFGAction(fgui.FSequence:create({
		fgui.FFadeIn:create(0.2),
		fgui.FDelayTime:create(1),
		fgui.FFadeOut:create(0.5)
	}))
end

function FurnitureRoleComp:onUnload()
	self:_stopBathingTimer()
end

function FurnitureRoleComp:_onDragEnd()
	self._isDragRole = false

	self.m_isPlaceController:setSelectedIndex(0)
	self:setRoleBehavior(var_0_1.ROLE_ACTION.IDLE)
end

function FurnitureRoleComp:_dragRoleStart()
	self._isDragRole = true

	self:setRoleBehavior(var_0_1.ROLE_ACTION.IDLE)

	local var_6_0 = self.m_roleHolderComp:getChild("CommonKnight")

	if var_6_0 then
		var_6_0:playAction(var_0_0.LOOP_ACTION.HEADLINE)
	end

	self:playRoleBathingAni(false)
	self:dispatchCompEvent("DRAG_ROLE_START", (self:getName()))
end

function FurnitureRoleComp:_onShowQuickBubButton()
	if self._isDragRole then
		return
	elseif self._behaviorType ~= var_0_1.ROLE_ACTION.IDLE then
		return
	end

	local var_7_0 = self.m_roleHolderComp:getChild("CommonKnight")

	if var_7_0 then
		var_7_0:playAction(var_0_0.DRAW_ACTION.TOUCH)
	end

	if self:_checkCanShowBub() and self.m_isShowBubbleController:getSelectedIndex() == 0 then
		self.m_isShowBubbleController:setSelectedIndex(1)
		self.m_bathBubBtn:runFGAction(fgui.FSequence:create({
			fgui.FFadeIn:create(0.12),
			fgui.FDelayTime:create(4),
			fgui.FFadeOut:create(0.5)
		}))
		self.m_bubImg:runFGAction(fgui.FSequence:create({
			fgui.FFadeIn:create(0.12),
			fgui.FDelayTime:create(4),
			fgui.FFadeOut:create(0.5),
			fgui.FCallFunc:create(function()
				self.m_isShowBubbleController:setSelectedIndex(0)
			end)
		}))
	end
end

function FurnitureRoleComp:_checkCanShowBub()
	self._dormId = var_0_4:getCheckInDormId((self:getRoleServerId()))
	self._furnitureStruct = var_0_4:getFurnitureInfo(self._dormId, var_0_1.FURNITURE_TYPE.BATH_CROCK)

	return self._furnitureStruct and self._furnitureStruct:isCDOver()
end

function FurnitureRoleComp:_onClickQuickBathBtn()
	g.core.network.GameNetProxy:send_C2S_FurnitureRoom_Bath({
		room_id = self._dormId,
		knight_id = self:getRoleServerId(),
		bathtbu_id = self._furnitureStruct.furniture_id,
		x = self._furnitureStruct.x,
		y = self._furnitureStruct.y,
		level = self._furnitureStruct.level
	})
	self.m_isShowBubbleController:setSelectedIndex(0)
end

function FurnitureRoleComp:updateRoleComp(arg_11_1)
	self._knightStruct = arg_11_1

	if not arg_11_1 then
		return
	end

	self._mobilityFrom = self:getMobilityVal()

	self.m_roleHolderComp:addChild((CommonKnight.new({
		resId = arg_11_1:getResInfo().fight_id,
		scale = var_0_1.ROLE_SCALE_SIZE
	})))

	self._roleBehavior = FurnitureRoleBehavior.new()

	self._roleBehavior:setRoleObj(self)
	self:setTouchable(not self:isRoleInBathing())
	self:updateMobility()
end

function FurnitureRoleComp:setSpin(arg_12_1)
	self.m_roleHolderComp:setScaleX(arg_12_1)
end

function FurnitureRoleComp:getRoleServerId()
	return self._knightStruct:getServerId()
end

function FurnitureRoleComp:getRoleResId()
	local var_14_0 = self._knightStruct:getBaseInfo().res_id

	return (self._knightStruct:getInfo().skin > 0 or nil) and self._knightStruct:getInfo().skin
end

function FurnitureRoleComp:clearFurnitureNamePlaced()
	self._furnitureNamePlaced = ""
end

function FurnitureRoleComp:setFurnitureNamePlaced(arg_16_1)
	self._furnitureNamePlaced = arg_16_1 or ""
end

function FurnitureRoleComp:getFurnitureNamePlaced()
	return self._furnitureNamePlaced
end

function FurnitureRoleComp:getMobilityVal()
	return self._knightStruct:getMobilityVal()
end

function FurnitureRoleComp:getMaxMobility()
	return self._knightStruct:getMaxMobility()
end

function FurnitureRoleComp:isMobilityFull()
	return self:getMobilityVal() >= self:getMaxMobility()
end

function FurnitureRoleComp:setRoleBehavior(arg_21_1)
	self._behaviorType = arg_21_1

	self._roleBehavior:stopRoleAction()
	self._roleBehavior:updateBeHaviorType(arg_21_1)
	self:playRoleBathingAni(arg_21_1 == var_0_1.ROLE_ACTION.BATH)
end

function FurnitureRoleComp:getRoleActionType()
	return self._behaviorType
end

function FurnitureRoleComp:setRolePlaceCoordXY(arg_23_1, arg_23_2)
	self._coordx = arg_23_1
	self._coordy = arg_23_2
end

function FurnitureRoleComp:getCoordXY()
	return self._coordx, self._coordy
end

function FurnitureRoleComp:getPosList()
	local var_25_0 = {}

	table.insert(var_25_0, {
		x = self._coordx,
		y = self._coordy
	})

	return var_25_0
end

function FurnitureRoleComp:setRoleCompRouteArray(arg_26_1)
	if not arg_26_1 then
		return
	end

	if self._roleBehavior then
		self._roleBehavior:setRouteArray(arg_26_1)
	end
end

function FurnitureRoleComp:setRoleCanPutState(arg_27_1)
	self.m_isPlaceController:setSelectedIndex(arg_27_1 and 2 or 1)
end

function FurnitureRoleComp:isRoleInBathing()
	return self._isBathing
end

function FurnitureRoleComp:startBathing()
	self._passedTime = 0
	self._isBathing = true
	self._bathingEffNode = self._bathingEffNode or self.m_effDadComp:addEffectSpine({
		remove = false,
		name = "eff_ui_furniture_recover",
		isLoop = true
	})
	self._bathingTimer = self._bathingTimer or g.core.common.Scheduler:newSchedule(handler(self, self._onBathing), 0.1)

	self:setTouchable(false)
end

function FurnitureRoleComp:_onBathing(arg_30_1)
	self._passedTime = self._passedTime + arg_30_1

	if self._passedTime >= var_0_1.BATHING_ANI_PLAY_TIME then
		self:_stopBathingTimer()
		self:_outOfBathing()
	else
		local var_30_0 = self:getMaxMobility()

		self.m_actionCircleBar:setCurMax((var_30_0 - self._mobilityFrom) / var_0_1.BATHING_ANI_PLAY_TIME * self._passedTime + self._mobilityFrom, var_30_0)
	end
end

function FurnitureRoleComp:playRoleBathingAni(arg_31_1)
	self.m_bathEff:removeAllEffect()

	if arg_31_1 then
		self.m_bathEff:addEffectSpine({
			anim = "idle",
			name = "jiayuan_zhedang",
			isLoop = true
		})
	end
end

function FurnitureRoleComp:_outOfBathing()
	self._isBathing = false

	if self._bathingEffNode then
		self._bathingEffNode:removeFromParent(true)

		self._bathingEffNode = nil
	end

	self:updateMobility()
	self:setTouchable(true)
	self:dispatchCompEvent("BATHING_OVER", self:getName())
end

function FurnitureRoleComp:updateMobility()
	if self:isRoleInBathing() then
		return
	end

	local var_33_0 = self:getMobilityVal()

	self._mobilityFrom = var_33_0

	self.m_actionCircleBar:setCurMax(var_33_0, (self:getMaxMobility()))
end

function FurnitureRoleComp:_stopBathingTimer()
	if self._bathingTimer then
		g.core.common.Scheduler:cancelSchedule(self._bathingTimer)

		self._bathingTimer = nil
	end
end

function FurnitureRoleComp:setActionBarVisible(arg_35_1)
	self.m_actionCircleBar:setVisible(arg_35_1)
end

function FurnitureRoleComp:setShareStatus(arg_36_1)
	if arg_36_1 then
		self.m_actionCircleBar:setOpacity(0)
		self.m_isShowBubbleController:setSelectedIndex(0)
	else
		self.m_actionCircleBar:setOpacity(255)
	end
end

function FurnitureRoleComp:createKnightSpineForSlot(arg_37_1, arg_37_2)
	local var_37_0 = self:getRoleResId()
	local var_37_1 = require("app.view.common.SpineBase").new({
		resId = var_37_0,
		path = require("app.view.battle.BattlePath").getSpineKnightPath(var_37_0),
		anim = self:_getAniWithBehaviorType(arg_37_1)
	})

	var_37_1:setAnchorPoint(0.5, 0.5)
	var_37_1:setScale(var_0_1.ROLE_SCALE_SIZE)

	return var_37_1
end

function FurnitureRoleComp:_getAniWithBehaviorType(arg_38_1)
	if arg_38_1 == var_0_1.ROLE_ACTION.SIT then
		return var_0_0.LOOP_ACTION.SIT
	elseif arg_38_1 == var_0_1.ROLE_ACTION.BATH then
		return var_0_0.LOOP_ACTION.BATHE
	elseif arg_38_1 == var_0_1.ROLE_ACTION.REST then
		return var_0_0.LOOP_ACTION.SLEEP
	else
		return var_0_0.LOOP_ACTION.IDLE
	end
end

function FurnitureRoleComp:isVisitRoleType()
	return false
end

return FurnitureRoleComp
