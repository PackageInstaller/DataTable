local SpineBase = require("app.view.common.SpineBase")
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_2 = g.core.const.ConstMgr.SpineConst
local BattlePath = require("app.view.battle.BattlePath")
local ExplorationRoleVirtual = class("ExplorationRoleVirtual", function()
	return cc.Node:create()
end)

function ExplorationRoleVirtual:ctor(arg_2_1, arg_2_2)
	self._knightVisual = nil
	self.m_pheffect = nil
	self._isHalfOpacity = false
	self.m_talkBubbleComp = nil
	self._innerScale = 1
	self._innerDir = 1
	self._innerFlip = 1
	self._scheduleBubbleId = nil
	self._basePath = g.core.common.Path:getMapKnightPath()
	self._resID = nil
	self._hitRect = cc.rect(-40, 0, 80, 150)

	self:updateRole(arg_2_1, arg_2_2)
end

function ExplorationRoleVirtual:updateRole(arg_3_1, arg_3_2)
	if self._resID == arg_3_1 then
		return
	end

	self._resID = arg_3_1

	if self._knightVisual then
		self._knightVisual:removeFromParent(true)
	end

	local var_3_0 = {
		isLoop = true,
		resId = self._resID,
		path = self._basePath .. self._resID .. "/" .. self._resID,
		anim = BattleConst.SPINE_ACTION_TYPE.IDLE
	}

	if arg_3_2 then
		local var_3_1 = g.core.model.User.roleSkinData:getWearSpineParams()

		var_3_1.anim = BattleConst.SPINE_ACTION_TYPE.IDLE
		var_3_1.path = BattlePath.getSpineKnightPath(var_3_1.resId)
		var_3_1.isLoop = true
		var_3_1.isShowBack = true
		var_3_0 = var_3_1
		self._resID = var_3_1.resId
	end

	self._knightVisual = SpineBase.new(var_3_0)

	self._knightVisual:setCascadeOpacityEnabled(true)
	self:_updateSpineSkin(var_3_0)
	self:addChild(self._knightVisual)
end

function ExplorationRoleVirtual:_updateSpineSkin(arg_4_1)
	if arg_4_1.skinName then
		local var_4_0 = self._knightVisual:getSkeleton()

		if var_4_0 then
			var_4_0:setSkin(arg_4_1.skinName)
			var_4_0:setSlotsToSetupPose()
		end
	end

	if not arg_4_1.isShowBack then
		if self._backSpine then
			self:removeChildAtSlot(var_0_2.DEFAULT_BACK_SLOT_NAME)

			self._backSpine = nil
		end

		return
	end

	if arg_4_1.backName and arg_4_1.backName ~= "" and arg_4_1.backSkin and arg_4_1.backSkin ~= "" then
		self._backSpine = require("app.view.common.SpineBase").new({
			resId = arg_4_1.backName,
			path = g.core.common.Path:getMainRoleBackSpinePath(arg_4_1.backName)
		})

		self._knightVisual:addNodesAtSlots({
			{
				slotStr = var_0_2.DEFAULT_BACK_SLOT_NAME,
				node = self._backSpine
			}
		})

		local var_4_1 = self._backSpine:getSkeleton()

		if var_4_1 then
			var_4_1:setSkin(arg_4_1.backSkin)
			var_4_1:setSlotsToSetupPose()
		end

		self._backSpine:setAnimation(0, "play", true)
	end
end

function ExplorationRoleVirtual:playInnerAction(arg_5_1)
	self._knightVisual:setAnimation(0, arg_5_1, true)
end

function ExplorationRoleVirtual:setHalfOpacity(arg_6_1)
	if self._isHalfOpacity == arg_6_1 then
		return
	end

	self._isHalfOpacity = arg_6_1

	self._knightVisual:setOpacity(self._isHalfOpacity and 100 or 255)
end

function ExplorationRoleVirtual:playJumpEffect()
	if not self._knightVisual then
		return
	end

	local var_7_0

	var_7_0 = SpineBase.new({
		anim = "play",
		isLoop = false,
		resId = "battle_shunyi",
		path = g.core.common.Path:getEffSpine("battle_shunyi"),
		listener = function(self)
			if self.type == "complete" then
				var_7_0:removeFromParent(true)
			end
		end
	})

	;(nil):setPositionY(self._hitRect.height / 2 - 40)
	self:addChild(var_7_0)
end

function ExplorationRoleVirtual:addEffectSpine()
	self.m_pheffect = SpineBase.new({
		anim = "play",
		resId = "battle_guanghuan",
		isLoop = true,
		path = g.core.common.Path:getEffSpine("battle_guanghuan")
	})

	self:addChild(self.m_pheffect, -1)
end

function ExplorationRoleVirtual:showTalkBubble(arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or 1

	if self._scheduleBubbleId then
		g.core.common.Scheduler:cancelSchedule(self._scheduleBubbleId)

		self._scheduleBubbleId = nil
	end

	if self.m_talkBubbleComp then
		self.m_talkBubbleComp:removeSelf()
	end

	local var_10_0 = fgui.UIPackage:createObject("base_new", "BaseTalkBubbleComp")

	var_10_0:setBobbleStr(arg_10_1)

	local var_10_1 = var_10_0:getChild("talkTxt")

	self.m_talkBubbleComp = var_10_0:popDisplayObject()

	self.m_talkBubbleComp:setPosition(30, 120)
	self:addChild(self.m_talkBubbleComp)

	self._scheduleBubbleId = g.core.common.Scheduler:newScheduleOnce(handler(self, self._onBubbleScheduler), arg_10_2)
end

function ExplorationRoleVirtual:setInnerDir(arg_11_1)
	if self._innerDir == arg_11_1 then
		return
	end

	self._innerDir = arg_11_1

	self._knightVisual:setScaleX(self:_getInnerScaleX())
end

function ExplorationRoleVirtual:setInnerFlip(arg_12_1)
	local var_12_0 = arg_12_1 and -1 or 1

	if self._innerFlip == (arg_12_1 and -1 or 1) then
		return
	end

	self._innerFlip = var_12_0

	self._knightVisual:setScaleX(self:_getInnerScaleX())
end

function ExplorationRoleVirtual:setInnerScale(arg_13_1)
	if self._innerScale == arg_13_1 then
		return
	end

	self._innerScale = arg_13_1

	self._knightVisual:setScaleX(self:_getInnerScaleX())
	self._knightVisual:setScaleY(self._innerScale)
end

function ExplorationRoleVirtual:setInnerDir(arg_14_1)
	if self._innerDir == arg_14_1 then
		return
	end

	self._innerDir = arg_14_1

	self._knightVisual:setScaleX(self:_getInnerScaleX())
end

function ExplorationRoleVirtual:_getInnerScaleX()
	return self._innerScale * self._innerDir * self._innerFlip
end

return ExplorationRoleVirtual
