ys = ys or {}

local BattleMainFleetCharacter = class("BattleMainFleetCharacter", ys.Battle.BattlePlayerCharacter)

ys.Battle.BattleMainFleetCharacter = BattleMainFleetCharacter
BattleMainFleetCharacter.__name = "BattleMainFleetCharacter"

function BattleMainFleetCharacter:Ctor()
	BattleMainFleetCharacter.super.Ctor(self)

	return
end

function BattleMainFleetCharacter:Update()
	BattleMainFleetCharacter.super.Update(self)
	self:UpdateArrowBarPosition()

	return
end

function BattleMainFleetCharacter:AddArrowBar(arg_3_1)
	BattleMainFleetCharacter.super.AddArrowBar(self, arg_3_1)
	setImageSprite(findTF(self._arrowBar, "icon"), LoadSprite("qicon/" .. self._unitData:GetTemplate().painting) or LoadSprite("heroicon/unknown"))

	return
end

function BattleMainFleetCharacter:UpdateHPBarPosition()
	if not self._inViewArea then
		BattleMainFleetCharacter.super.UpdateHPBarPosition(self)
	end

	return
end

function BattleMainFleetCharacter:GetReferenceVector(arg_5_1)
	if not self._inViewArea then
		return BattleMainFleetCharacter.super.GetReferenceVector(self, arg_5_1)
	else
		return self._arrowVector
	end

	return
end

return
