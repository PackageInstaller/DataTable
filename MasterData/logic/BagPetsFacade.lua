-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/facade/BagPetsFacade.lua

module("logic.extensions.bag.facade.BagPetsFacade", package.seeall)

local BagPetsFacade = class("BagPetsFacade")

function BagPetsFacade:ctor()
	return
end

function BagPetsFacade:getFirstPet()
	return BagModel.instance:getFirstPet()
end

function BagPetsFacade:getPetInfo(id)
	return BagPetsController.instance:getPet(id)
end

function BagPetsFacade:getPetRaceId(id)
	local _pet = BagPetsController.instance:getPet(id)

	if _pet then
		return _pet.raceId
	else
		return 0
	end
end

function BagPetsFacade:setPetForbit(id, forbit)
	local _pet = BagPetsController.instance:getPet(id)

	if _pet then
		_pet:setPetForbit(forbit)
	end
end

function BagPetsFacade:loadBagInfo()
	return BagPetsController.instance:getBagModel()
end

function BagPetsFacade:getPetNumByRaceId(raceId)
	return BagPetsController.instance:getPetNumByRaceId(raceId)
end

function BagPetsFacade.setHeadIcon(iconObj, petId)
	local dat = BagPetsController.instance:getPet(petId)

	if not dat then
		return
	end

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(dat.curFaceId))

	uGuiUtil.setSpriteToImage(iconObj.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
end

function BagPetsFacade.setHeadIconByRaceId(iconObj, raceId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(raceId))

	if modelCo then
		uGuiUtil.setSpriteToImage(iconObj.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
	end
end

function BagPetsFacade._loadEffect(view, parentTrans, path, scale, rectTransform)
	local effect = UIEffectManager.instance:playEffect(view, path, parentTrans, 0, 0, true, false, nil, function(self, uiEffect)
		if rectTransform then
			uiEffect:setClipping(rectTransform)
		end
	end, view)

	effect:setParent(parentTrans)
	effect:setScale(scale)
end

function BagPetsFacade:getPetUpType(curMo, preMo, flags)
	local upType = GameEnum.PetUpType.PetAwake

	if curMo.awakeLevel > preMo.awakeLevel and (flags == nil or flags[upType] ~= true) then
		return upType
	end

	upType = GameEnum.PetUpType.PetUpgrade

	if curMo.level > preMo.level and (flags == nil or flags[upType] ~= true) then
		return upType
	end

	upType = GameEnum.PetUpType.PetTalentLvup

	if curMo.talentLevel > preMo.talentLevel and (flags == nil or flags[upType] ~= true) then
		return upType
	end

	return nil
end

function BagPetsFacade:checkAndOpenPetUp(curMo, preMo)
	local upType = self:getPetUpType(curMo, preMo)

	if upType ~= nil then
		UIStateManager.instance:push(ViewName.PetUp, upType, curMo, preMo)
	end
end

function BagPetsFacade:setOnceFlag()
	self._onceFlag = true
end

function BagPetsFacade:getOnceFlag()
	self._onceFlag = false

	return self._onceFlag
end

BagPetsFacade.instance = BagPetsFacade.New()

return BagPetsFacade
