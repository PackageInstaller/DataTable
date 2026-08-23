local var_0_0 = g.core.const.ConstMgr.SpineConst
local RiskMapConst = require("app.view.module.summerTheme.view.explore.world.RiskMapConst")
local RiskVirtualEffect = class("RiskVirtualEffect", require("app.core.ksmap.entity.MapVisualEffect"))

function RiskVirtualEffect:ctor(arg_1_1)
	RiskVirtualEffect.super.ctor(self, arg_1_1)
end

function RiskVirtualEffect:_doInitBillboard()
	self._hitRect.width = 120
	self._hitRect.height = 120
	self._hitRect.x = -60
	self._hitRect.y = -30
end

function RiskVirtualEffect:playStatus(arg_3_1)
	if not RiskMapConst.ACT_NAME["IDLE" .. arg_3_1] then
		return
	end

	self._spineNode:setAnimation(0, RiskMapConst.ACT_NAME["IDLE" .. arg_3_1], true)
end

function RiskVirtualEffect:playTransStatus(arg_4_1)
	local var_4_0 = RiskMapConst.ACT_NAME["TO_IDLE" .. arg_4_1]

	if not RiskMapConst.ACT_NAME["TO_IDLE" .. arg_4_1] then
		self:playStatus(arg_4_1)

		return
	end

	self._spineNode:addSpineEventListener(function(arg_5_0)
		if arg_5_0.type == var_0_0.SPINE_EVENT.COMPLETE and arg_5_0.animation == var_4_0 then
			if tolua.isnull(self) then
				return
			end

			self:playStatus(arg_4_1)
			self._spineNode:addSpineEventListener(nil)
		end
	end)
	self._spineNode:setAnimation(0, RiskMapConst.ACT_NAME["TO_IDLE" .. arg_4_1], false)
end

function RiskVirtualEffect:playBornStatus(arg_6_1)
	local var_6_0 = RiskMapConst.ACT_NAME.BORN

	self._spineNode:addSpineEventListener(function(arg_7_0)
		if arg_7_0.type == var_0_0.SPINE_EVENT.COMPLETE and arg_7_0.animation == var_6_0 then
			if tolua.isnull(self) then
				return
			end

			self:playStatus(arg_6_1)
			self._spineNode:addSpineEventListener(nil)
		end
	end)
	self._spineNode:setAnimation(0, RiskMapConst.ACT_NAME.BORN, false)
end

function RiskVirtualEffect:playDeadStatus()
	local var_8_0 = RiskMapConst.ACT_NAME.DEAD

	self._spineNode:addSpineEventListener(function(arg_9_0)
		if arg_9_0.type == var_0_0.SPINE_EVENT.COMPLETE and arg_9_0.animation == var_8_0 then
			if tolua.isnull(self) then
				return
			end

			self:removeFromParent()
		end
	end)
	self._spineNode:setAnimation(0, RiskMapConst.ACT_NAME.DEAD, false)
end

function RiskVirtualEffect:playErrorStatus()
	local var_10_0 = RiskMapConst.ACT_NAME.TO_IDLE2

	self._spineNode:addSpineEventListener(function(arg_11_0)
		if arg_11_0.type == var_0_0.SPINE_EVENT.COMPLETE and arg_11_0.animation == var_10_0 then
			if tolua.isnull(self) then
				return
			end

			self._spineNode:addSpineEventListener(nil)
			self:playTransStatus(1)
		end
	end)
	self._spineNode:setAnimation(0, RiskMapConst.ACT_NAME.TO_IDLE2, false)
end

function RiskVirtualEffect:playIdleAnim()
	self._spineNode:setAnimation(0, "idle", true)
end

function RiskVirtualEffect:playUseAnim(arg_13_1, arg_13_2)
	self._spineNode:setAnimation(0, "play", false)
	self._spineNode:addSpineEventListener(function(arg_14_0)
		if arg_14_0.type == var_0_0.SPINE_EVENT.COMPLETE and arg_14_0.animation == "play" then
			if tolua.isnull(self) then
				return
			end

			if arg_13_1 == RiskMapConst.SPECIAL_ITEM.TORCH then
				self:playBurnAnim()
			elseif arg_13_1 == RiskMapConst.SPECIAL_ITEM.GUN or arg_13_1 == RiskMapConst.SPECIAL_ITEM.TRACK then
				self:playIdleAnim()
			elseif arg_13_1 == RiskMapConst.SPECIAL_ITEM.ICE then
				self:playDeadAnim()
			end

			self._spineNode:addSpineEventListener(nil)

			if arg_13_2 then
				arg_13_2()
			end
		end
	end)
end

function RiskVirtualEffect:playBurnAnim()
	self._spineNode:setAnimation(0, "repeat", true)
end

function RiskVirtualEffect:playDeadAnim()
	self._spineNode:setVisible(false)
end

return RiskVirtualEffect
