ys = ys or {}

local var_0_0 = ys
local BattleEffectBulletUnit = class("BattleEffectBulletUnit", ys.Battle.BattleBulletUnit)

ys.Battle.BattleEffectBulletUnit = BattleEffectBulletUnit
BattleEffectBulletUnit.__name = "BattleEffectBulletUnit"

function BattleEffectBulletUnit:Ctor(arg_1_1, arg_1_2)
	BattleEffectBulletUnit.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function BattleEffectBulletUnit:Update(arg_2_1)
	BattleEffectBulletUnit.super.Update(self, arg_2_1)

	if self._flare then
		self._flare:SetPosition(pg.Tool.FilterY(self:GetPosition():Clone()))
	end

	return
end

function BattleEffectBulletUnit:IsFlare()
	return self:GetTemplate().attach_buff[1].flare
end

function BattleEffectBulletUnit:OutRange()
	BattleEffectBulletUnit.super.OutRange(self)

	if self._flare then
		self._flare:SetActiveFlag(false)

		self._flare = nil
	end

	return
end

function BattleEffectBulletUnit:spawnArea(arg_5_1)
	local var_5_0 = self:GetTemplate()
	local var_5_1 = var_5_0.attach_buff[1].buff_id
	local var_5_2 = var_5_0.attach_buff[1].buff_level or 1

	local function var_5_3(arg_6_0)
		for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
			if iter_6_1.Active then
				self._battleProxy:GetUnitList()[iter_6_1.UID]:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_5_1, var_5_2), true)
			end
		end

		return
	end

	local function var_5_4(arg_7_0)
		if arg_7_0.Active then
			self._battleProxy:GetUnitList()[arg_7_0.UID]:RemoveBuff(var_5_1, true)
		end

		return
	end

	time = var_5_0.hit_type.time

	local var_5_5 = var_5_0.extra_param.ellipse_range and self._battleProxy:SpawnLastingEllipseArea(self:GetEffectField(), self:GetIFF(), pg.Tool.FilterY(self:GetPosition():Clone()), var_5_0.hit_type.range, var_5_0.extra_param.ellipse_range, time, var_5_3, var_5_4, var_5_0.attach_buff[1].friendly, var_5_0.attach_buff[1].effect_id) or self._battleProxy:SpawnLastingColumnArea(self:GetEffectField(), self:GetIFF(), pg.Tool.FilterY(self:GetPosition():Clone()), var_5_0.hit_type.range, time, var_5_3, var_5_4, var_5_0.attach_buff[1].friendly, var_5_0.attach_buff[1].effect_id)

	if arg_5_1 then
		self._flare = var_5_5
	end

	var_5_5:SetSource(var_5_5.SOURCE_BULLET_9)

	return var_5_5
end

function BattleEffectBulletUnit:GetExplodePostion()
	return self._explodePos
end

function BattleEffectBulletUnit:SetExplodePosition(arg_9_1)
	self._explodePos = arg_9_1

	return
end

return
