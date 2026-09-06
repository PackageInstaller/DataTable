-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/items/BattleItemSkill.lua

module("logic.extensions.battle.model.items.BattleItemSkill", package.seeall)

local BattleItemSkill = class("BattleItemSkill", BattleItemBase)

function BattleItemSkill:ctor(itemCo, itemNum)
	BattleItemSkill.super.ctor(self, itemCo, itemNum)
	self:_buildEffects()
end

function BattleItemSkill:getPetId()
	if self._itemCo.skill then
		return self._itemCo.skill[1]
	end
end

function BattleItemSkill:getSkillId()
	if self._itemCo.skill then
		return self._itemCo.skill[2]
	end
end

function BattleItemSkill:getItemIcon()
	if self._itemCo.icon and #self._itemCo.icon > 0 then
		return GameUrl.getCharacterIconUrl(self._itemCo.icon)
	end

	local petCo = CharacterConfig.instance:getPetCo(self:getPetId())
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCo.faceIds))

	return GameUrl.getCharacterIconUrl(modelCo.headName)
end

function BattleItemSkill:getItemModel()
	local petCo = CharacterConfig.instance:getPetCo(self:getPetId())
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCo.faceIds))

	if modelCo then
		return GameUrl.getSpineUrl(modelCo.resName)
	end
end

function BattleItemSkill:selectTargetEff()
	return self._selectTargetEff
end

function BattleItemSkill:watingRespondEff()
	return self._watingRespondEff
end

function BattleItemSkill:displaySuccessEff()
	return self._displaySuccessEff
end

function BattleItemSkill:fullScreenSuccessEff()
	return self._fullScreenSuccessEff
end

function BattleItemSkill:displayFailedEff()
	return self._displayFailedEff
end

function BattleItemSkill:fullScreenFailedEff()
	return self._fullScreenFailedEff
end

function BattleItemSkill:_buildEffects()
	self._selectTargetEff = {
		path = "effect/prefabs/ui/fx_ui_buzhuo/fx_ui_kebuzhuo.prefab",
		hagPoint = UnitConst.spineCenterPointPath
	}
end

return BattleItemSkill
