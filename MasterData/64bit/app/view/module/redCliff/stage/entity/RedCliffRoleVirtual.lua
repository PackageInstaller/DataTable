local SpineBase = require("app.view.common.SpineBase")
local var_0_1 = g.core.const.ConstMgr.SpineConst
local BattleConst = require("app.view.battle.const.BattleConst")
local BattlePath = require("app.view.battle.BattlePath")
local RedCliffRoleVirtual = class("RedCliffRoleVirtual", function()
	return cc.Node:create()
end)

function RedCliffRoleVirtual:ctor(arg_2_1, arg_2_2)
	self._knightVisual = nil
	self.m_pheffect = nil
	self._isHalfOpacity = false
	self.m_talkBubbleComp = nil
	self._innerScale = 1
	self._innerDir = 1
	self._innerFlip = 1
	self._scheduleBubbleId = nil
	self._basePath = g.core.common.Path:getMapKnightPath()
	self._actName = ""
	self._resID = nil
	self._hitRect = cc.rect(-40, 0, 80, 150)

	self:updateRole(arg_2_1, arg_2_2)
end

function RedCliffRoleVirtual:addSpineEventListener(arg_3_1)
	self._knightVisual:addSpineEventListener(arg_3_1)
end

function RedCliffRoleVirtual:_getRelatedSkinName(arg_4_1)
	local var_4_0 = g.core.config.role_skin_related_info.fetch(arg_4_1)

	return (var_4_0 or nil) and (var_4_0.skin_name or "yuanpi_0")
end

function RedCliffRoleVirtual:updateRole(arg_5_1, arg_5_2)
	if self._resID == arg_5_1 then
		return
	end

	self._resID = arg_5_1

	if self._knightVisual then
		self._knightVisual:removeFromParent(true)
	end

	local var_5_0 = {
		isLoop = true,
		resId = self._resID,
		path = self._basePath .. self._resID .. "/" .. self._resID,
		anim = BattleConst.SPINE_ACTION_TYPE.IDLE,
		skinName = self:_getRelatedSkinName(arg_5_1)
	}

	if arg_5_2 then
		local var_5_1 = g.core.model.User.roleSkinData:getWearSpineParams()

		var_5_1.anim = BattleConst.SPINE_ACTION_TYPE.IDLE
		var_5_1.path = BattlePath.getSpineKnightPath(var_5_1.resId)
		var_5_1.isLoop = true
		var_5_1.isShowBack = true
		var_5_0 = var_5_1
		self._resID = var_5_1.resId
	end

	self._knightVisual = SpineBase.new(var_5_0)

	self._knightVisual:setCascadeOpacityEnabled(true)
	self:_updateSpineSkin(var_5_0)
	self:addChild(self._knightVisual)
end

function RedCliffRoleVirtual:_updateSpineSkin(arg_6_1)
	if arg_6_1.skinName then
		local var_6_0 = self._knightVisual:getSkeleton()

		if var_6_0 then
			var_6_0:setSkin(arg_6_1.skinName)
			var_6_0:setSlotsToSetupPose()
		end
	end

	if not arg_6_1.isShowBack then
		if self._backSpine then
			self:removeChildAtSlot(var_0_1.DEFAULT_BACK_SLOT_NAME)

			self._backSpine = nil
		end

		return
	end

	if arg_6_1.backName and arg_6_1.backName ~= "" and arg_6_1.backSkin and arg_6_1.backSkin ~= "" then
		self._backSpine = require("app.view.common.SpineBase").new({
			resId = arg_6_1.backName,
			path = g.core.common.Path:getMainRoleBackSpinePath(arg_6_1.backName)
		})

		self._knightVisual:addNodesAtSlots({
			{
				slotStr = var_0_1.DEFAULT_BACK_SLOT_NAME,
				node = self._backSpine
			}
		})

		local var_6_1 = self._backSpine:getSkeleton()

		if var_6_1 then
			var_6_1:setSkin(arg_6_1.backSkin)
			var_6_1:setSlotsToSetupPose()
		end

		self._backSpine:setAnimation(0, "play", true)
	end
end

function RedCliffRoleVirtual:playInnerAction(arg_7_1, arg_7_2)
	if self._actName == arg_7_1 then
		return
	end

	self._actName = arg_7_1

	self._knightVisual:setAnimation(0, arg_7_1, arg_7_2 ~= false)
end

function RedCliffRoleVirtual:setHalfOpacity(arg_8_1)
	if self._isHalfOpacity == arg_8_1 then
		return
	end

	self._isHalfOpacity = arg_8_1

	self._knightVisual:setOpacity(self._isHalfOpacity and 100 or 255)
end

function RedCliffRoleVirtual:playJumpEffect()
	if not self._knightVisual then
		return
	end

	local var_9_0

	var_9_0 = SpineBase.new({
		isLoop = false,
		resId = "battle_shunyi",
		anim = "play",
		path = g.core.common.Path:getEffSpine("battle_shunyi"),
		listener = function(self)
			if self.type == "complete" then
				var_9_0:removeFromParent(true)
			end
		end
	})

	;(nil):setPositionY(self._hitRect.height / 2 - 40)
	self:addChild(var_9_0)
end

function RedCliffRoleVirtual:setInnerFlip(arg_11_1)
	local var_11_0 = arg_11_1 and -1 or 1

	if self._innerFlip == (arg_11_1 and -1 or 1) then
		return
	end

	self._innerFlip = var_11_0

	self._knightVisual:setScaleX(self:_getInnerScaleX())
end

function RedCliffRoleVirtual:setInnerScale(arg_12_1)
	if self._innerScale == arg_12_1 then
		return
	end

	self._innerScale = arg_12_1

	self._knightVisual:setScaleX(self:_getInnerScaleX())
	self._knightVisual:setScaleY(self._innerScale)
end

function RedCliffRoleVirtual:setInnerDir(arg_13_1)
	if self._innerDir == arg_13_1 then
		return
	end

	self._innerDir = arg_13_1

	self._knightVisual:setScaleX(self:_getInnerScaleX())
end

function RedCliffRoleVirtual:_getInnerScaleX()
	return self._innerScale * self._innerDir * self._innerFlip
end

return RedCliffRoleVirtual
