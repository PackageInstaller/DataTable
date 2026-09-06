-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/model/BattleRecordFmtModel.lua

module(..., package.seeall)

local BattleRecordFmtModel = class("BattleRecordFmtModel", BaseModel)

function BattleRecordFmtModel:ctor()
	return
end

function BattleRecordFmtModel:onInit()
	self._formation = nil
	self._teamId = 1
end

function BattleRecordFmtModel:onReset()
	self._formation = nil
	self._teamId = 1
end

function BattleRecordFmtModel:getTeamId()
	return self._teamId
end

function BattleRecordFmtModel:getFormation()
	return self._formation
end

function BattleRecordFmtModel:changeSkillId(id)
	self._formation:SetHeroSkillId(id)
end

function BattleRecordFmtModel:getHeroSkillId()
	return self._formation:GetHeroSkillId()
end

function BattleRecordFmtModel:getCurFormationId()
	return self._formation:GetId()
end

function BattleRecordFmtModel:getFormPetsHeroSkills()
	local heroskills = {}

	for i, v in ipairs(self._pos) do
		if v > 0 then
			local pet = self:getPet(checknumber(v))
			local petCo = PetSkinConfig.instance:getPetSkinCfg(pet.curFaceId)

			if petCo and petCo.heroSkillId > 0 and not TableUtil.isHad(heroskills, petCo.heroSkillId) then
				table.insert(heroskills, petCo.heroSkillId)
			end
		end
	end

	return heroskills
end

function BattleRecordFmtModel:setRecordInfo(data)
	self._data = data
	self._teamId = 1
	self._myPlayer = data.myPlayer
	self._petInfos = self._myPlayer.petInfos
	self._petZdlList = self._myPlayer.petZdlList
	self._form = self._myPlayer.form
	self._pos = self._form.pos
	self._petDic = {}
	self._formation = RecordFormationMO.New()

	self._formation:SetData(self._form)
end

function BattleRecordFmtModel:getPetInfoByPetId(petId)
	for k, v in ipairs(self._petInfos) do
		if v.petId == petId then
			return v
		end
	end
end

function BattleRecordFmtModel:getPetInfoByPos(pos)
	local petId = self._form.pos[pos]

	for k, v in ipairs(self._petInfos) do
		if v.petId == petId then
			return v
		end
	end
end

function BattleRecordFmtModel:hasPetState()
	local state = 3
	local allGot = true

	for i = 1, 9 do
		if self._pos[i] > 0 then
			local raceId = self:getPetInfoByPetId(self._pos[i]).raceId
			local bagPetInfo = BagModel.instance:getPetIdByRaceId(raceId)
			local got = bagPetInfo ~= nil

			if got then
				state = 2
			else
				allGot = false
			end
		end
	end

	return (allGot or nil) and 1
end

function BattleRecordFmtModel:getPet(petId)
	self._petDic = self._petDic or {}

	local petInfo = self:getPetInfoByPetId(petId)

	if petInfo and not self._petDic[petId] then
		local bagPet = BagPetMo.New()

		bagPet:initBaseView(petInfo)

		self._petDic[petId] = bagPet
	end

	return self._petDic[petId]
end

function BattleRecordFmtModel:getRecordPetZdl(petId)
	return self:_getPetZdl(petId)
end

function BattleRecordFmtModel:_getPetZdl(petId)
	for k, v in ipairs(self._petZdlList) do
		if v.petId == petId then
			return v.zdl
		end
	end

	return 0
end

BattleRecordFmtModel.instance = BattleRecordFmtModel.New()

return BattleRecordFmtModel
