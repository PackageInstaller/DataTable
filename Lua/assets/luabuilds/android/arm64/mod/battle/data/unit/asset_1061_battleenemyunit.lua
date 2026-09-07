ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleDataFunction
local var_0_2 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleAttr
local var_0_5 = ys.Battle.BattleConfig
local var_0_7 = ys.Battle.UnitState
local BattleEnemyUnit = class("BattleEnemyUnit", ys.Battle.BattleUnit)

ys.Battle.BattleEnemyUnit = BattleEnemyUnit
BattleEnemyUnit.__name = "BattleEnemyUnit"

function BattleEnemyUnit:Ctor(arg_1_1, arg_1_2)
	BattleEnemyUnit.super.Ctor(self, arg_1_1, arg_1_2)

	self._type = var_0_2.UnitType.ENEMY_UNIT
	self._level = self._battleProxy:GetDungeonLevel()

	return
end

function BattleEnemyUnit:Dispose()
	if self._aimBias then
		self._aimBias:Dispose()
	end

	BattleEnemyUnit.super.Dispose(self)

	return
end

function BattleEnemyUnit:SetBound(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	BattleEnemyUnit.super.SetBound(self, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)

	self._weaponRightBound = arg_3_4
	self._weaponLowerBound = arg_3_2

	return
end

function BattleEnemyUnit:UpdateAction()
	if self._oxyState and self._oxyState:GetCurrentDiveState() == var_0_2.OXY_STATE.DIVE then
		if self:GetSpeed().x > 0 then
			self._unitState:ChangeState(var_0_7.STATE_DIVELEFT)
		else
			self._unitState:ChangeState(var_0_7.STATE_DIVE)
		end
	elseif self:GetSpeed().x > 0 then
		self._unitState:ChangeState(var_0_7.STATE_MOVELEFT)
	else
		self._unitState:ChangeState(var_0_7.STATE_MOVE)
	end

	return
end

function BattleEnemyUnit:UpdateHP(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if self._phaseSwitcher then
		self._phaseSwitcher:UpdateHP(self:GetHPRate())
	end

	return (BattleEnemyUnit.super.UpdateHP(self, arg_5_1, arg_5_2, arg_5_3, arg_5_4))
end

function BattleEnemyUnit:SetMaster(arg_6_1)
	self._master = arg_6_1

	return
end

function BattleEnemyUnit:GetMaster()
	return self._master
end

function BattleEnemyUnit:SetTemplate(arg_8_1, arg_8_2)
	BattleEnemyUnit.super.SetTemplate(self, arg_8_1)

	self._tmpData = var_0_1.GetMonsterTmpDataFromID(self._tmpID)

	self:configWeaponQueueParallel()
	self:InitCldComponent()
	self:SetAttr()

	arg_8_2 = arg_8_2 or {}

	local var_8_0 = self:GetExtraInfo()

	for iter_8_0, iter_8_1 in pairs(arg_8_2) do
		var_8_0[iter_8_0] = iter_8_1
	end

	self:setStandardLabelTag()

	return
end

function BattleEnemyUnit:SetTeamVO(arg_9_1)
	self._team = arg_9_1

	return
end

function BattleEnemyUnit:SetFormationIndex(arg_10_1)
	self._formationIndex = arg_10_1

	return
end

function BattleEnemyUnit:SetWaveIndex(arg_11_1)
	self._waveIndex = arg_11_1

	return
end

function BattleEnemyUnit:SetAttr()
	var_0_4.SetEnemyAttr(self)
	var_0_4.InitDOTAttr(self._attr, self._tmpData)

	return
end

function BattleEnemyUnit:GetTemplate()
	return self._tmpData
end

function BattleEnemyUnit:GetRarity()
	return self._tmpData.rarity
end

function BattleEnemyUnit:GetLevel()
	return self._overrideLevel or self._level or 1
end

function BattleEnemyUnit:GetTeam()
	return self._team
end

function BattleEnemyUnit:GetWaveIndex()
	return self._waveIndex
end

function BattleEnemyUnit:IsShowHPBar()
	return self._IFF ~= var_0_5.FRIENDLY_CODE
end

function BattleEnemyUnit:IsSpectre()
	local var_19_0 = self:GetAttr()[var_0_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY] ~= nil and self:GetAttrByName(var_0_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY) or self._tmpData.battle_unit_type

	return var_19_0 <= var_0_5.SPECTRE_UNIT_TYPE, var_19_0
end

function BattleEnemyUnit:InitCldComponent()
	BattleEnemyUnit.super.InitCldComponent(self)
	self._cldComponent:SetCldData({
		type = var_0_2.CldType.SHIP,
		IFF = self:GetIFF(),
		UID = self:GetUniqueID(),
		Mass = var_0_2.CldMass.L1,
		IsBoss = self._isBoss
	})

	if self:GetTemplate().friendly_cld ~= 0 then
		self._cldComponent:ActiveFriendlyCld()
	end

	return
end

function BattleEnemyUnit:ConfigBubbleFX()
	self._bubbleFX = self._tmpData.bubble_fx[1]

	self._oxyState:SetBubbleTemplate(self._tmpData.bubble_fx[2], self._tmpData.bubble_fx[3])

	return
end

return
