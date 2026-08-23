local var_0_0 = g.core.common.Path
local SpineBase = require("app.view.common.SpineBase")
local KsMath = require("app.core.utils.KsMath")
local var_0_3 = g.core.const.ConstMgr.outpostConst
local OutpostBulletComp = class("OutpostBulletComp", require("app.fairyGUI.outpost.UI_OutpostBulletComp"))

function OutpostBulletComp:ctor()
	self._objType = var_0_3.EntityType.Bullet
	self._spine = nil
end

function OutpostBulletComp:resetComp()
	return
end

function OutpostBulletComp:getEntityType()
	return self._objType
end

function OutpostBulletComp:updateEntityShowParam(arg_4_1)
	self._objType = arg_4_1.entityType

	local var_4_0 = arg_4_1:getFightResult()

	self:setRotation(-KsMath.mathCalculateRotation(cc.p(var_4_0.attacker:getPos()), cc.p(var_4_0.victim:getPos())))

	local var_4_1 = ""

	var_4_1 = var_4_0.skillInfo.skill_type == var_0_3.SkillType.ActiveSkill and var_4_0.elementalInfo.outpost_skill_shoot or var_4_0.elementalInfo.outpost_attack_shoot

	if self._spine and self._spine:getResId() ~= var_4_1 then
		self._spine:removeFromParent()

		self._spine = nil
	end

	if not self._spine and (var_4_1 ~= "" or var_4_1 ~= "0") then
		self._spine = SpineBase.new({
			anim = "play",
			isLoop = true,
			resId = var_4_1,
			path = var_0_0:getOutpostEffectSpine(var_4_1)
		})

		self.m_effectHolder:addNode(self._spine)
	end
end

return OutpostBulletComp
