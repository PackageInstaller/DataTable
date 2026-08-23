local KsMath = require("app.core.utils.KsMath")
local var_0_1 = g.core.const.ConstMgr.SpineConst
local RiskVirtualRole = class("RiskVirtualRole", require("app.core.ksmap.entity.MapVisualKnight"))

function RiskVirtualRole:ctor(arg_1_1)
	RiskVirtualRole.super.ctor(self, arg_1_1)
end

function RiskVirtualRole:setViewHP(arg_2_1)
	if arg_2_1 then
		self.m_billboard:setVisible(true)
		self.m_perBarHP:setPercentage(arg_2_1)
	else
		self.m_billboard:setVisible(false)
	end
end

function RiskVirtualRole:_doInitBillboard()
	self._hitRect.width = 80
	self._hitRect.height = 150
	self._hitRect.x = -40
	self._hitRect.y = 0
	self.m_billboard = cc.Node:create()

	self:addChild(self.m_billboard)
	self.m_billboard:setPosition(0, self._hitRect.height + 30)

	local var_3_0 = display.newSprite("ui_cocos/risk/bg_xuetiaodi.png", {
		scale9 = true,
		capInsets = cc.rect(5, 5, 2, 2)
	})

	var_3_0:setContentSize(cc.size(114, 4))
	var_3_0:setPosition(0, 0)
	self.m_billboard:addChild(var_3_0)

	local var_3_1 = cc.ProgressTimer:create((cc.Sprite:create("ui_cocos/risk/pic_xuetiao.png")))

	var_3_1:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_3_1:setMidpoint(cc.p(0, 0.5))
	var_3_1:setBarChangeRate(cc.p(1, 0))
	self.m_billboard:addChild(var_3_1)

	self.m_perBarHP = var_3_1

	self.m_billboard:setVisible(false)
end

function RiskVirtualRole:playStatus(arg_4_1)
	return
end

function RiskVirtualRole:playTransStatus(arg_5_1)
	return
end

function RiskVirtualRole:playBornStatus(arg_6_1)
	return
end

function RiskVirtualRole:playUseAnim(arg_7_1, arg_7_2)
	self._realVisual:setAnimation(0, "dead", false)
	self._realVisual:addSpineEventListener(function(arg_8_0)
		if arg_8_0.type == var_0_1.SPINE_EVENT.COMPLETE and arg_8_0.animation == "dead" then
			if tolua.isnull(self) then
				return
			end

			if arg_7_2 then
				arg_7_2()
			end

			if not tolua.isnull(self._realVisual) then
				self._spineNode:addSpineEventListener(nil)
			end
		end
	end)
end

function RiskVirtualRole:setPosBothZ(arg_9_1)
	if self.m_pheffect then
		self:setPosition(arg_9_1)

		local var_9_0 = KsMath.countPixZOrder(arg_9_1) + 200

		if var_9_0 == self._curZIndex then
			return
		end

		self._curZIndex = var_9_0

		self:setLocalZOrder(self._curZIndex)
	else
		RiskVirtualRole.super.setPosBothZ(self, arg_9_1)
	end
end

return RiskVirtualRole
