ys = ys or {}

local var_0_0 = ys
local BattleBuffAuraSquare = class("BattleBuffAuraSquare", ys.Battle.BattleBuffAura)

ys.Battle.BattleBuffAuraSquare = BattleBuffAuraSquare
BattleBuffAuraSquare.__name = "BattleBuffAuraSquare"

local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig

function BattleBuffAuraSquare:Ctor(arg_1_1)
	BattleBuffAuraSquare.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAuraSquare:SetArgs(arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.Battle.BattleDataProxy.GetInstance()
	local var_2_1, var_2_2, var_2_3, var_2_4 = var_2_0:GetTotalBounds()

	self._unit = arg_2_1
	self._buffLevel = arg_2_2:GetLv()

	local var_2_7 = self._tempData.arg_list

	self._arraWidth = self._tempData.arg_list.cld_data.box.width or var_2_4 - var_2_3
	self._auraHeight = var_2_7.cld_data.box.height or var_2_1 - var_2_2
	self._buffID = var_2_7.buff_id
	self._friendly = var_2_7.friendly_fire or false
	self._frontOffset = var_2_7.cld_data.box.front_offset or 0

	local var_2_8, var_2_9, var_2_10 = self:getAreaCldFunc(arg_2_1)
	local var_2_11 = arg_2_1:GetIFF()

	self._aura = var_2_0:SpawnLastingCubeArea(var_0_2.AOEField.SURFACE, var_2_11, arg_2_1:GetPosition(), self._arraWidth, self._auraHeight, 0, var_2_8, var_2_9, self._friendly, nil, var_2_10, false)

	local var_2_12 = var_0_0.Battle.BattleAOEScaleableComponent.New(self._aura)

	var_2_12:SetReferenceUnit(arg_2_1)
	var_2_12:ConfigData(var_2_12.FILL, {
		upperBound = var_2_1,
		lowerBound = var_2_2,
		rearBound = var_2_11 == var_0_3.FRIENDLY_CODE and var_2_3 or var_2_4,
		frontOffset = self._frontOffset
	})

	self._effectIndex = "BattleBuffAuraSquare" .. self._buffID

	arg_2_1:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ADD_EFFECT, {
		index = self._effectIndex,
		effect = var_2_7.effect,
		fillFunc = function(arg_3_0)
			return self._aura:GetPosition(), self._aura:GetWidth(), (self._aura:GetHeight())
		end
	}))

	return
end

function BattleBuffAuraSquare:Clear()
	self._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CANCEL_EFFECT, {
		index = self._effectIndex
	}))
	BattleBuffAuraSquare.super.Clear(self)

	return
end

return
