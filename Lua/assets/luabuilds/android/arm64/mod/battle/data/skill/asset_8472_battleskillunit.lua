ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleSkillUnit = class("BattleSkillUnit")
ys.Battle.BattleSkillUnit.__name = "BattleSkillUnit"

function ys.Battle.BattleSkillUnit:Ctor(arg_1_1, arg_1_2)
	self._id = arg_1_1
	self._level = arg_1_2
	self._tempData = var_0_0.Battle.BattleDataFunction.GetSkillTemplate(arg_1_1, arg_1_2)
	self._cd = self._tempData.cd
	self._effectList = {}
	self._lastEffectTarget = {}

	for iter_1_0, iter_1_1 in ipairs(self._tempData.effect_list) do
		self._effectList[iter_1_0] = var_0_0.Battle[iter_1_1.type].New(iter_1_1, arg_1_2)
	end

	self._finaleEffectCount = 0
	self._dataProxy = var_0_0.Battle.BattleDataProxy.GetInstance()

	return
end

function ys.Battle.BattleSkillUnit.GenerateSpell(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = var_0_0.Battle.BattleSkillUnit.New(arg_2_0, arg_2_1)

	var_2_0._attachData = arg_2_3

	return var_2_0
end

function ys.Battle.BattleSkillUnit:GetSkillEffectList()
	return self._effectList
end

function ys.Battle.BattleSkillUnit:Cast(arg_4_1, arg_4_2)
	local var_4_0 = var_0_0.Battle.BattleState.GetInstance()

	if self._tempData.focus_duration then
		arg_4_1:DispatchCutIn(self._tempData)
	end

	if self._tempData.painting == 1 then
		if arg_4_2 then
			arg_4_1:DispatchSkillFloat(arg_4_2:getSkills()[1]:getConfig("name"), arg_4_2:getPainting())
		else
			arg_4_1:DispatchSkillFloat(self._tempData.name)
		end
	elseif type(self._tempData.painting) == "string" then
		arg_4_1:DispatchSkillFloat(self._tempData.name, nil, self._tempData.painting)
	end

	local var_4_1 = type(self._tempData.castCV)

	if var_4_1 == "string" then
		arg_4_1:DispatchVoice(self._tempData.castCV)
	elseif var_4_1 == "table" then
		local var_4_2, var_4_3, var_4_4 = ShipWordHelper.GetWordAndCV(self._tempData.castCV.skinID, self._tempData.castCV.key)

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_4_3)
	end

	if self._tempData.sfx then
		var_0_0.Battle.PlayBattleSFX(self._tempData.sfx)
	end

	local var_4_5 = self._attachData

	for iter_4_0, iter_4_1 in ipairs(self._effectList) do
		local var_4_6 = iter_4_1:GetTarget(arg_4_1, self)

		self._lastEffectTarget = var_4_6

		iter_4_1:SetCommander(arg_4_2)

		if iter_4_1:IsFinaleEffect() then
			self._finaleEffectCount = self._finaleEffectCount + 1

			iter_4_1:SetFinaleCallback(function()
				self:callbackCount(arg_4_1)

				return
			end)
		end

		iter_4_1:Effect(arg_4_1, var_4_6, var_4_5)
	end

	if self._tempData.aniEffect and self._tempData.aniEffect ~= "" then
		arg_4_1:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ADD_EFFECT, {
			effect = self._tempData.aniEffect.effect,
			time = self._tempData.aniEffect.time,
			offset = self._tempData.aniEffect.offset,
			posFun = self._tempData.aniEffect.posFun
		}))
	end

	if self._tempData.action then
		arg_4_1:StateChange(var_0_0.Battle.UnitState.STATE_SKILL_START)
	end

	return
end

function ys.Battle.BattleSkillUnit.SetTarget(arg_6_0, arg_6_1)
	arg_6_0._lastEffectTarget = arg_6_1

	return
end

function ys.Battle.BattleSkillUnit:Interrupt()
	for iter_7_0, iter_7_1 in ipairs(self._effectList) do
		iter_7_1:Interrupt()
	end

	return
end

function ys.Battle.BattleSkillUnit:Clear()
	for iter_8_0, iter_8_1 in ipairs(self._effectList) do
		iter_8_1:Clear()
	end

	return
end

function ys.Battle.BattleSkillUnit:callbackCount(arg_9_1)
	self._finaleEffectCount = self._finaleEffectCount - 1

	if self._finaleEffectCount == 0 and self._tempData.action then
		arg_9_1:StateChange(var_0_0.Battle.UnitState.STATE_SKILL_END)
	end

	return
end

function ys.Battle.BattleSkillUnit:GetDamageSum()
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(self._effectList) do
		var_10_0 = iter_10_1:GetDamageSum() + var_10_0
	end

	return var_10_0
end

function ys.Battle.BattleSkillUnit.IsFireSkill(arg_11_0, arg_11_1)
	local var_11_0 = false

	for iter_11_0, iter_11_1 in ipairs(var_0_0.Battle.BattleDataFunction.GetSkillTemplate(arg_11_0, arg_11_1).effect_list) do
		if iter_11_1.type == var_0_0.Battle.BattleSkillFire.__name or iter_11_1.type == var_0_0.Battle.BattleSkillFireSupport.__name then
			var_11_0 = true

			break
		end
	end

	return var_11_0
end

return
