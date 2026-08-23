local var_0_0 = g.core.model.User.outpostData
local OutpostFightEffectEnum = require("app.view.module.outpost.simulationWorld.fight.OutpostFightEffectEnum")
local var_0_2 = table.remove
local var_0_3 = table.concat
local var_0_4 = g.core.const.ConstMgr.outpostConst
local var_0_5 = g.core.const.ConstMgr.outpostConst.TweenType
local OutpostFightEffectComp = class("OutpostFightEffectComp", require("app.fairyGUI.outpost.UI_OutpostFightEffectComp"))

function OutpostFightEffectComp:ctor()
	self._tweenPool = {}
	self._eventManager = var_0_0:getEventManager()
end

function OutpostFightEffectComp:playEffectList(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		self:addEffectTween(iter_2_1)
	end
end

function OutpostFightEffectComp:addEffectTween(arg_3_1)
	local var_3_0
	local var_3_1 = var_0_5.Number
	local var_3_2 = ""
	local var_3_3

	if arg_3_1.isDodge then
		var_3_0 = var_0_4.EffectTween.Dodge
		var_3_1 = var_0_5.Word
		var_3_3 = "txt_huibi"
	elseif arg_3_1.isCrit then
		var_3_0 = var_0_4.EffectTween.Crit
		var_3_1 = var_0_5.IconNumberNoLine
		var_3_2 = "baoji"
		var_3_3 = "txt_baoji"
	elseif arg_3_1.effectType == OutpostFightEffectEnum.Recover then
		var_3_0 = var_0_4.EffectTween.Recover
		var_3_2 = "buff"
	elseif arg_3_1.effectType == OutpostFightEffectEnum.Damage then
		var_3_0 = var_0_4.EffectTween.Damage
		var_3_2 = "putongshanghai"
	elseif arg_3_1.effectType == OutpostFightEffectEnum.Shield then
		var_3_0 = var_0_4.EffectTween.Shield
		var_3_1 = var_0_5.IconNumberLine
		var_3_2 = "putongshanghai"
		var_3_3 = "txt_hudun"
	else
		var_3_0 = var_0_4.EffectTween.Shield
		var_3_2 = "putongshanghai"
	end

	local var_3_4 = self:getEffectFromPool(var_3_0, var_3_1, var_3_2, var_3_3)

	var_3_4:playEffect(arg_3_1)
	var_3_4:setPosition(arg_3_1.victim.x + math.random(-30, 30), arg_3_1.victim.y - math.random(var_0_4.ROLE_HEIGHT, var_0_4.ROLE_HEIGHT + 40))
end

function OutpostFightEffectComp:getEffectFromPool(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = var_0_3({
		arg_4_1,
		arg_4_2,
		arg_4_3
	}, "_")

	self._tweenPool[var_4_0] = self._tweenPool[var_4_0] or {}

	if self._tweenPool[var_4_0] and next(self._tweenPool[var_4_0]) then
		local var_4_1 = var_0_2(self._tweenPool[var_4_0], 1)

		var_4_1:setVisible(true)

		return var_4_1
	else
		local var_4_2 = fgui.UIPackage:createObject("outpost", "OutpostEffectTweenComp", self)

		var_4_2:initComp({
			endCall = handler(self, self.returnObjectToPool),
			effectTweenName = arg_4_1,
			poolKey = var_4_0,
			tweenType = arg_4_2,
			fontTypeName = arg_4_3,
			tweenImage = arg_4_4
		})
		self.m_root:addChild(var_4_2)

		return var_4_2
	end
end

function OutpostFightEffectComp:returnObjectToPool(arg_5_1, arg_5_2)
	self._tweenPool[arg_5_1] = self._tweenPool[arg_5_1] or {}

	arg_5_2:setVisible(false)
	table.insert(self._tweenPool[arg_5_1], arg_5_2)
end

return OutpostFightEffectComp
