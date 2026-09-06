-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/model/BagModel.lua

module("logic.extensions.bag.model.BagModel", package.seeall)

local BagModel = class("BagModel", BaseModel)

BagModel.BAGMODEL_SORTVALUE_KEY = "BagModel_sortValue"
BagModel.SORT_NAME = {
	function(petMo)
		return petMo:getFightingPower()
	end,
	"level",
	"rare",
	"awakeLevel",
	"petId"
}
BagModel.SORT_VALUE = {
	{
		-1,
		ArraySort.DESCENDING,
		ArraySort.NONE
	},
	{
		-1,
		ArraySort.DESCENDING,
		ArraySort.NONE
	},
	{
		-1,
		ArraySort.DESCENDING,
		ArraySort.NONE
	},
	{
		-1,
		ArraySort.DESCENDING,
		ArraySort.NONE
	},
	{
		ArraySort.NONE,
		ArraySort.DESCENDING
	}
}
BagModel.NotifyName_PetShowViewPlayPetAnim = "petshowviewplaypetanim"
BagModel.SKILL_TYPE_LEVEL_MAP = {
	"passiveSkillLv",
	"normalSkillLv",
	"ultimateSkillLv",
	"psychicedNormalSkillLv",
	"psychicedUltimateSkillLv"
}
BagModel.KEY_LIST = {
	"passiveSkillId",
	"normalSkillId",
	"ultSkillId",
	"psychicedNormalSkillId",
	"psychicedUltSkillId"
}
BagModel.SERVER_ID = {
	passiveSkillId = GameEnum.SeverSkillType.PASSIVE,
	normalSkillId = GameEnum.SeverSkillType.NORMAL,
	ultSkillId = GameEnum.SeverSkillType.ULTIMATE,
	psychicedNormalSkillId = GameEnum.SeverSkillType.PSYCHICED_NORMAL,
	psychicedUltSkillId = GameEnum.SeverSkillType.PSYCHICED_ULTIMATE
}
BagModel.ONE_KEY_AWAKE_LIMIT_COUNT = 20

function BagModel:ctor()
	self._pets = {}
	self._petViewTempTopPetIds = nil
end

function BagModel:onInit()
	self:onReset()
end

function BagModel:onReset()
	self._pets = {}
	self._petViewTempTopPetIds = nil
	self.followPetId = 0
	self._updatePetId = 0
	self.teamInfo = {}
	self.allAttr = nil
	self.teamZdl = 0
	self._yuanPetsMap = {}
end

function BagModel:getPetSkills(petMo)
	local list = {}
	local petCo = checknumber(petMo.curFaceId) > 0 and PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId) or PetSkinConfig.instance:getPetSkinCfg(petMo.raceId)

	petCo = petCo or {}

	local sortedKeys = MaterialMgr.getSkillSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local v = MaterialMgr.SkillName[skillType]
		local skillId = checknumber(petCo[v])
		local lvl = skillId % 100
		local key = MaterialMgr.SkillLvlKey[skillType]

		if not string.nilorempty(key) then
			lvl = petMo[key] or 1

			if lvl then
				local skillInfocfg = CharacterConfig.instance:getSkillInfoByLvl(petMo.curFaceId, lvl)

				if skillInfocfg then
					skillId = checknumber(skillInfocfg[v])
				end
			end
		end

		if skillId > 0 then
			table.insert(list, skillId)
		end
	end

	if checknumber(petMo.contractSkillId) > 0 then
		table.insert(list, checknumber(petMo.contractSkillId))
	end

	return list
end

function BagModel:getPetPsychicSkills(petMo)
	local list = {}
	local petCo = checknumber(petMo.curFaceId) > 0 and PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId) or PetSkinConfig.instance:getPetSkinCfg(petMo.raceId)

	petCo = petCo or {}

	local sortedKeys = MaterialMgr.getPsychicSkillSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local v = MaterialMgr.getSkillKeyNameByType(skillType)
		local skillId = checknumber(petCo[v])
		local lvl = skillId % 100
		local key = MaterialMgr.SkillLvlKey[skillType]

		if not string.nilorempty(key) then
			lvl = petMo[key] or 1

			if lvl then
				local skillInfocfg = CharacterConfig.instance:getSkillInfoByLvl(petMo.curFaceId, lvl)

				if skillInfocfg then
					skillId = checknumber(skillInfocfg[v])
				end
			end
		end

		if skillId > 0 then
			table.insert(list, skillId)
		end
	end

	return list
end

function BagModel:addTeamInfo(petTeams)
	if petTeams then
		for i, v in ipairs(petTeams) do
			local teamId = v.teamId

			self.teamInfo[teamId] = v
		end
	end

	self.allAttr = nil

	local list = {}

	for k, v in pairs(self.teamInfo) do
		table.insert(list, v)
	end

	self.allAttr, self.teamZdl = HandbookConfig.instance:calcAllAttr(list, self.allAttr)

	BagPetsController.instance:calcAllPetTeamAttr()
end

function BagModel:getTeamValueByMo(petMo)
	if petMo and petMo.teamInfo then
		if petMo.isMyPackPet == true then
			return self.allAttr
		elseif petMo.teamInfo.isMax and petMo.teamInfo.infos == nil then
			return HandbookConfig.instance.maxAttr
		else
			local res, zdl = HandbookConfig.instance:calcAllAttr(petMo.teamInfo.infos)

			return res
		end
	end
end

function BagModel:getRelationValueByMo(petMo)
	if petMo and petMo.collectRelationIds then
		local arr = petMo.collectRelationIds
		local res = {}

		for i, id in ipairs(arr) do
			local cfg = CharacterConfig.instance:getBondCfgsCollectByID(id)

			if cfg then
				local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.property) or {}

				res = AttrMo.addSameAttrs(attrs, res)
			end
		end

		return res
	end
end

function BagModel:getRelationPercentByMoAndType(petMo, type)
	local res = 0

	if petMo and petMo.collectRelationIds then
		local arr = petMo.collectRelationIds

		for i, id in ipairs(arr) do
			local map = CharacterConfig.instance:getFormulaPropertyTypeMap(id)

			if map and map[type] then
				local cfg = CharacterConfig.instance:getBondCfgsCollectByID(id)

				res = res + cfg.formulaWanPercent
			end
		end

		res = res / 10000
	end

	return res
end

function BagModel:setPet(petId, data)
	if self._pets[petId] then
		local oldData = self._pets[petId]:GetClone()

		self._pets[petId]:initMo(data)
		MountModel.instance:checkMountLogicRaceId(oldData.raceId)

		return oldData
	else
		local bagPetMo = BagPetMo.New()
		local petId = bagPetMo:initMo(data)

		self._pets[petId] = bagPetMo

		MountModel.instance:checkMountLogicRaceId(bagPetMo.raceId)
	end

	MaterialFacade.instance:AddMaterial(MatType.Pet, petId, 1)
end

function BagModel:isPetMaxLevel(id)
	if self._pets then
		return self._pets[id].level >= 100
	end

	return false
end

function BagModel:getPets()
	return self._pets
end

function BagModel:getBagPets()
	local ret = {}

	for i, v in pairs(self._pets) do
		if v:isExist() then
			table.insert(ret, v)
		end
	end

	return ret
end

function BagModel:getBagPetById(petId)
	local mo

	if self._pets then
		mo = self._pets[petId]
	end

	if mo and mo:isExist() then
		return mo
	end

	return nil
end

function BagModel:setPetViewTempTopPetIds(petIds)
	local petIdMap = {}

	for _, petId in pairs(petIds or {}) do
		if checknumber(petId) > 0 then
			petIdMap[checknumber(petId)] = true
		end
	end

	self._petViewTempTopPetIds = petIdMap
end

function BagModel:isPetViewTempTopPet(petId)
	return self._petViewTempTopPetIds and self._petViewTempTopPetIds[checknumber(petId)] or false
end

function BagModel:clearPetViewTempTopPetIds()
	self._petViewTempTopPetIds = nil
end

function BagModel:getCullingBagPets(petIdDic)
	local ret = {}

	for i, v in pairs(self._pets) do
		if v:isExist() and petIdDic[v.petId] ~= true then
			table.insert(ret, v)
		end
	end

	return ret
end

function BagModel:getPet(id)
	local mo

	return (self._pets or nil) and self._pets[id]
end

function BagModel:getPetsByRaceId(raceId)
	local list = {}

	if self._pets then
		for k, v in pairs(self._pets) do
			if v:isExist() and v.raceId == raceId then
				table.insert(list, v)
			end
		end
	end

	return list
end

function BagModel:getPetMaxLv(raceId)
	local maxLv = 0

	for i, v in pairs(self._pets) do
		if v.raceId == raceId and maxLv < checknumber(v.level) then
			maxLv = v.level
		end
	end

	return maxLv
end

function BagModel:getRaceIdCount(raceId)
	local count = 0

	if self._pets then
		for k, v in pairs(self._pets) do
			if v:isExist() and v.raceId == raceId then
				count = count + 1
			end
		end
	end

	return count
end

function BagModel:getRaceIdAndLvlCount(raceId, lvl)
	local count = 0

	if self._pets then
		for k, v in pairs(self._pets) do
			if v:isExist() and v.raceId == raceId and lvl <= v.level then
				count = count + 1
			end
		end
	end

	return count
end

function BagModel:getPetIdByRaceId(raceId)
	if self._pets then
		for k, v in pairs(self._pets) do
			if v:isExist() and v.raceId == raceId then
				return k
			end
		end
	end

	return nil
end

function BagModel:getMaxZdlPetIdByRaceId(raceId)
	local res
	local maxZdl = 0

	if self._pets then
		for k, v in pairs(self._pets) do
			if v:isExist() and v.raceId == raceId then
				local tempPetMo = self:getPet(k)
				local tempZdl = tempPetMo:getFightingPower()

				if maxZdl < tempZdl then
					res = k
					maxZdl = tempZdl
				end
			end
		end
	end

	return res
end

function BagModel:isExistRaceId(raceId)
	return self:getPetIdByRaceId(raceId) ~= nil
end

function BagModel:getFirstPet()
	for k, v in pairs(self._pets) do
		return v
	end

	return nil
end

function BagModel:getUpdatePetId()
	return self._updatePetId
end

function BagModel:BagCount()
	return TableUtil.Count(self._pets, function(k, pet)
		return pet:isExist()
	end, pairs)
end

function BagModel:diffRacePetCount(pets)
	if pets == nil then
		pets = self:getBagPets()
	end

	ArraySort.sortOn(pets, "raceId")

	local lastId = -1
	local num = 0

	for i, v in ipairs(pets) do
		if lastId ~= v.raceId then
			lastId = v.raceId
			num = num + 1
		end
	end

	return num
end

function BagModel:SetNextSort(idx)
	self._sortValue = self:GetSortState()

	local v = self._sortValue[idx]

	v = v + 1

	local vArr = BagModel.SORT_VALUE[idx]

	v = v % #vArr

	if idx ~= #BagModel.SORT_VALUE then
		for i = 1, #BagModel.SORT_VALUE - 1 do
			self._sortValue[i] = 0
		end
	end

	self._sortValue[idx] = v

	GameUtil.saveUserData(BagModel.BAGMODEL_SORTVALUE_KEY, self._sortValue)
end

function BagModel:GetSortState()
	if self._sortValue == nil then
		self._sortValue = GameUtil.getUserData(BagModel.BAGMODEL_SORTVALUE_KEY)

		if self._sortValue == nil or #self._sortValue ~= #BagModel.SORT_NAME then
			self._sortValue = {}

			for i = 1, #BagModel.SORT_NAME do
				self._sortValue[i] = i == 1 and 1 or 0
			end
		end
	end

	return self._sortValue
end

function BagModel:GetSortParms(checkIsInTeamFunc)
	local parm1 = {}
	local parm2 = {}
	local sortName

	local function func(data)
		local res = 0

		if checkIsInTeamFunc then
			if data ~= nil then
				res = checkIsInTeamFunc(data)
			end
		elseif data ~= nil and FormationNewModel.instance:HasPetAtCurFormation(data.petId) then
			res = 1
		end

		return res
	end

	local function funcBorrw(petMo)
		if petMo.isBorrowPet then
			return petMo:isBorrowPet()
		else
			return 0
		end
	end

	local function funcTop(petMo)
		local isTop = BagPetsController.instance:getPetIsTop(petMo.petId)

		return isTop and 1 or 0
	end

	table.insert(parm1, func)
	table.insert(parm2, ArraySort.DESCENDING)
	table.insert(parm1, funcTop)
	table.insert(parm2, ArraySort.DESCENDING)
	table.insert(parm1, funcBorrw)
	table.insert(parm2, ArraySort.DESCENDING)
	table.insert(parm1, "isHirePet")
	table.insert(parm2, ArraySort.DESCENDING)
	table.insert(parm1, "isSupportedPet")
	table.insert(parm2, ArraySort.DESCENDING)

	self._sortValue = self:GetSortState()

	for k, v in ipairs(self._sortValue) do
		local vArr = BagModel.SORT_VALUE[k]

		if vArr[v + 1] ~= -1 then
			table.insert(parm1, BagModel.SORT_NAME[k])
			table.insert(parm2, vArr[v + 1])
		end
	end

	return parm1, parm2
end

function BagModel:getPetBagAwakeStatus()
	if not FuncOpenModel.instance:getFuncIsOpen(49) then
		return false
	end

	local petList = self:getBagPets()
	local map = {}

	for _, pet in ipairs(petList) do
		map[pet.raceId] = map[pet.raceId] or {}
		map[pet.raceId].count1 = checknumber(map[pet.raceId].count1)
		map[pet.raceId].count2 = checknumber(map[pet.raceId].count2)

		if pet.awakeLevel == CharacterConfig.MIN_AWAKE_LVL then
			map[pet.raceId].count1 = map[pet.raceId].count1 + 1
		elseif not pet:isMaxAwaken() then
			map[pet.raceId].count2 = map[pet.raceId].count2 + 1
		end

		if map[pet.raceId].count1 >= 2 then
			return true
		end

		if map[pet.raceId].count1 == 1 and map[pet.raceId].count2 >= 1 then
			return true
		end
	end

	return false
end

function BagModel:getPetBagRedStatus()
	if not FuncOpenModel.instance:getFuncIsOpen(9) then
		return false
	end

	local petIds = FormationNewModel.instance:getHasPets()

	for _, v in ipairs(petIds) do
		if self:getPetTalentStatus(v) or self:getPetAwakeStatus(v) or BagPetsController.instance:getIfPetSkillUpgrade(v) or StargodplusModel.instance:checkPetCanEquipById(v) or DomainCultivateController.instance:getIfKamuiActive(v) or PetTitleModel.instance:checkPetIsRedByPetId(v) then
			return true
		end
	end

	return PetEquipController.instance:GetPlayAndSlotPetRed()
end

function BagModel:getPetRedStatus(petId)
	if FormationGroupModel.instance:checkIsInTeam(petId) and (self:getPetTalentStatus(petId) or self:getPetAwakeStatus(petId) or BagPetsController.instance:getIfPetSkillUpgrade(petId) or StargodplusModel.instance:checkPetCanEquipById(petId) or DomainCultivateController.instance:getIfKamuiActive(petId) or PetEquipModel.instance:GetPetCardRedPoint(petId, PetEquipModel.PetEquipRedType.All) or HolyStripeModel.instance:petHaveRetPoint(petId)) then
		return true
	end

	return (self:getHasSkin(petId))
end

function BagModel:getHasSkin(petId)
	local hasRed = false
	local petMo = self:getPet(petId)

	if petMo then
		local list = PetSkinConfig.instance:getPetSkinListBySkinId(petMo.curFaceId)

		if list then
			for k, v in pairs(list) do
				local skinId = v.skinId

				hasRed = hasRed or RedPointModel.instance:isActive(RedPointModel.ID_PETSKIN_PRE .. skinId)

				if hasRed then
					break
				end
			end
		end
	end

	return hasRed
end

function BagModel:getPetAwakeStatus(petId)
	if not FuncOpenModel.instance:getFuncIsOpen(49) then
		return false
	end

	local petMo = self:getPet(petId)

	return self:getPetAwakeStatusByMo(petMo)
end

function BagModel:getPetAwakeStatusByMo(petMo)
	if petMo then
		local count = 0
		local isMax = petMo.awakenLv >= BagModel.instance:getMaxAwakenLv(petMo.raceId)

		if not petMo:isMaxAwaken() and isMax then
			local cfg = CharacterConfig.instance:getPetCo(petMo.raceId)
			local costCfg = CharacterConfig.instance:getPetAwakenCostCfg(cfg.awakenCostStrategyId, petMo.awakeLevel + 1)

			if not costCfg then
				return false
			end

			if petMo.rare >= GameEnum.PetRare.SSR and not isMax then
				return false
			end

			local isGoldEnough = MaterialModel.instance:getMaterialsNumber(MatType.Coin, 8) >= checknumber(costCfg.needCoinNum)

			if not isGoldEnough then
				return false
			end

			local upType = costCfg.petCostType
			local allNums = 0
			local raceList, bases = ItemConfig.instance:getReplaceItemCfgList(petMo)

			for i, v in ipairs(raceList) do
				allNums = allNums + MaterialModel.instance:getMaterialsNumber(MatType.Item, v.id)
			end

			for i, v in ipairs(bases) do
				allNums = allNums + MaterialModel.instance:getMaterialsNumber(MatType.Item, v.id)
			end

			if allNums >= costCfg.needPetNum then
				return true
			end

			local petList = self:getBagPets()

			for _, pet in ipairs(petList) do
				if pet.petId ~= petMo.petId and pet.awakeLevel == costCfg.needPetAwakenLv then
					local petCfg = CharacterConfig.instance:getPetCo(pet.raceId)

					if upType == GameEnum.PetStarUpStrategy.RaceId then
						if pet.raceId == petMo.raceId then
							count = count + 1
						end
					elseif upType == GameEnum.PetStarUpStrategy.Attr then
						if PetSkinConfig.instance:checkIsSameFirstEleAttr(pet.curFaceId, petMo.curFaceId) then
							count = count + 1
						end
					elseif upType == GameEnum.PetStarUpStrategy.Job then
						local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(pet.curFaceId)

						if PetSkinConfig.instance:checkHasJob(petMo.curFaceId, firstJobIdx) then
							count = count + 1
						end
					end

					if count + allNums >= costCfg.needPetNum then
						return true
					end
				end
			end
		end
	end

	return false
end

function BagModel:getPetTalentStatus(petId)
	local petMo = self:getPet(petId)

	return self:getTalentCanLvlup(petMo)
end

function BagModel:getTalentCanLvlup(mo)
	if not FuncOpenModel.instance:getFuncIsOpen(48) then
		return false
	end

	if mo == nil then
		return false
	end

	local isMaxLv = mo:isMaxLv()
	local maxTalentLv = CharacterConfig.instance:getMaxLvByTalentLv(mo.talentLevel)

	if not isMaxLv and mo.level == maxTalentLv then
		local cfg = CharacterConfig.instance:getPetCo(mo.raceId)
		local talentLevel = mo.talentLevel
		local targetLevel = math.min(CharacterConfig.instance:getMaxTalentLv(), talentLevel + 1)
		local raceId = mo.raceId
		local curCfg = CharacterConfig.instance:getPetTalentCfg(raceId, math.max(0, talentLevel))
		local _isGoldEnough = true
		local _isMatsEnough = true

		if curCfg ~= nil then
			if not string.nilorempty(curCfg.materialCost) then
				local t = string.split(curCfg.materialCost, "#")

				for _, v in ipairs(t) do
					_isMatsEnough = _isMatsEnough and MaterialMgr.getMatEnough(v)
				end
			end

			local curNum = MaterialFacade.instance:getMatNumber(MatType.Coin, 1)
			local needNum = checknumber(curCfg.upgradeCoinCost)

			_isGoldEnough = needNum <= curNum
		end

		local _isPowerCrystalFollower = BagModel.instance:isPowerCrystalFollower(mo.petId)

		return _isGoldEnough and _isMatsEnough and not _isPowerCrystalFollower
	else
		return false
	end
end

function BagModel:_compareTwoPetAwakePriority(mo1, mo2)
	if mo2:isMaxAwaken() then
		return true
	end

	local val1, val2

	val1 = mo1:getFightingPower()
	val2 = mo2:getFightingPower()

	if val1 ~= val2 then
		return val2 < val1
	end

	val1 = mo1.awakeLevel
	val2 = mo2.awakeLevel

	if mo1.awakeLevel ~= mo2.awakeLevel then
		return val2 < val1
	end

	val1 = checknumber(mo1.gainTime)
	val2 = checknumber(mo2.gainTime)

	if val1 ~= val2 then
		return val1 < val2
	end

	return mo1.petId < mo2.petId
end

function BagModel:setCurPetViewList(list)
	self.curPetViewList = list
end

function BagModel:getCurPetViewList()
	if not self.curPetViewList then
		return self.curPetViewList
	end

	local result = {}

	for _, petView in ipairs(self.curPetViewList) do
		if petView:isExist() then
			table.insert(result, petView)
		end
	end

	return result
end

function BagModel:getPetViewIdxByRaceId(raceId, arr, petReg)
	arr = arr or self.curPetViewList

	local last = 0

	if arr then
		for i, v in ipairs(arr) do
			if v.raceId == raceId then
				last = i - 1

				if string.nilorempty(petReg) or self:checkPetReg(v, petReg) then
					return i - 1
				end
			end
		end
	end

	return last
end

function BagModel:checkPetReg(petMo, petReg)
	GameUtil.expScript(petReg, function(str)
		local arr = string.split(str, "#")
		local key = arr[1]

		if key == "lvl" then
			local op = arr[2]
			local lvl = checknumber(arr[3])

			if op == ">=" then
				return lvl <= petMo.level
			elseif op == "<=" then
				return lvl >= petMo.level
			elseif op == "==" then
				return petMo.level == lvl
			elseif op == ">" then
				return lvl < petMo.level
			elseif op == "<" then
				return lvl > petMo.level
			elseif op == "!=" or op == "~=" then
				return petMo.level ~= lvl
			end
		end
	end)
end

function BagModel:isPowerCrystalFollower(petId)
	local info = self:getPet(petId)

	if info then
		local properties = info.powerCrystalFollowerOriginalProperties

		if properties and properties.deleted ~= true then
			return true
		end
	end

	return false
end

function BagModel:getMaxAwakenLv(raceId)
	local pets = self:getBagPets()
	local maxAwakenLv = 0

	for _, v in ipairs(pets) do
		if v.raceId == raceId then
			maxAwakenLv = math.max(maxAwakenLv, v.awakeLevel)
		end
	end

	return maxAwakenLv
end

function BagModel:getPetIdForEquipStargod()
	local cfgs = StargodplusConfig.instance:getSlotCfgs()
	local petIdsInFormation = FormationNewModel.instance:getHasPets()

	for i, petId in ipairs(petIdsInFormation) do
		local canEquip = StargodplusModel.instance:checkPetCanEquipById(petId)

		if canEquip then
			return petId
		end
	end

	local petMos = self:getBagPets()

	for k, petMo in pairs(petMos) do
		local canEquip = StargodplusModel.instance:checkPetCanEquipById(petMo.petId)

		if canEquip then
			return petMo.petId
		end
	end

	return nil
end

function BagModel:sortPetForTaskGuide(pets)
	table.sort(pets, function(x, y)
		if x.rare > y.rare then
			return true
		end

		if x.rare < y.rare then
			return false
		end

		local xPower = x:getFightingPower()
		local yPower = y:getFightingPower()

		return xPower - yPower > 0
	end)
end

function BagModel:getPetIdForLevelUp(level)
	local isLimitLevel = level and level > 0
	local petsMo = {}
	local petIdsInFormation = FormationNewModel.instance:getHasPets()

	for i, petId in ipairs(petIdsInFormation) do
		local petMo = self:getPet(petId)

		if petMo and not petMo:isMaxLv() and (not isLimitLevel or level > petMo:getPetLv()) and not petMo:isBorrowPet() then
			table.insert(petsMo, petMo)
		end
	end

	if #petsMo > 0 then
		self:sortPetForTaskGuide(petsMo)

		return petsMo[1]:getPetId()
	end

	local petMos = self:getBagPets()

	for k, v in pairs(petMos) do
		if not v:isMaxLv() and (not isLimitLevel or level > v:getPetLv()) then
			table.insert(petsMo, v)
		end
	end

	if #petsMo > 0 then
		self:sortPetForTaskGuide(petsMo)

		return petsMo[1]:getPetId()
	end

	return nil
end

function BagModel:getPetIdForTalentLevelUp(raceIds, targetTalentLevel)
	local isLimitLevel = targetTalentLevel and targetTalentLevel > 0
	local targetRaceIds = {}
	local petsMo = {}

	if raceIds then
		for i, raceId in ipairs(raceIds) do
			if raceId > 0 then
				table.insert(targetRaceIds, raceId)
			end
		end
	end

	local petIdsInFormation = FormationNewModel.instance:getHasPets()
	local petMos = self:getBagPets()

	if #targetRaceIds > 0 then
		for i, petId in ipairs(petIdsInFormation) do
			local petMo = self:getPet(petId)
			local raceId = petMo:getDefineId()

			for i, v in ipairs(targetRaceIds) do
				if v == raceId and petMo and not petMo:isMaxTalent() and (not isLimitLevel or targetTalentLevel > petMo:getTalentLevel()) then
					table.insert(petsMo, petMo)
				end
			end
		end

		if #petsMo > 0 then
			self:sortPetForTaskGuide(petsMo)

			return petsMo[1]:getPetId()
		end

		for k, petMo in pairs(petMos) do
			local raceId = petMo:getDefineId()

			for i, v in ipairs(targetRaceIds) do
				if v == raceId and not petMo:isMaxTalent() and (not isLimitLevel or targetTalentLevel > petMo:getTalentLevel()) then
					table.insert(petsMo, petMo)
				end
			end
		end

		if #petsMo > 0 then
			self:sortPetForTaskGuide(petsMo)

			return petsMo[1]:getPetId()
		end
	end

	for i, petId in ipairs(petIdsInFormation) do
		local petMo = self:getPet(petId)

		if petMo and not petMo:isMaxTalent() and (not isLimitLevel or targetTalentLevel > petMo:getTalentLevel()) then
			table.insert(petsMo, petMo)
		end
	end

	if #petsMo > 0 then
		self:sortPetForTaskGuide(petsMo)

		return petsMo[1]:getPetId()
	end

	for k, petMo in pairs(petMos) do
		if not petMo:isMaxTalent() and (not isLimitLevel or targetTalentLevel > petMo:getTalentLevel()) then
			table.insert(petsMo, petMo)
		end
	end

	if #petsMo > 0 then
		self:sortPetForTaskGuide(petsMo)

		return petsMo[1]:getPetId()
	end

	return nil
end

function BagModel:getAwakenablePetMoList()
	local awakenablePetMoList = {}
	local awakenablePetMoHash = {}

	if FuncOpenModel.instance:getFuncIsOpen(49) then
		local petMos = self:getBagPets()

		for k, mo in ipairs(petMos) do
			if self:getPetAwakeStatusByMo(mo) then
				local curMo = awakenablePetMoHash[mo.raceId]

				if curMo then
					if mo.curLv == curMo.curLv then
						if mo.petId < curMo.petId then
							awakenablePetMoHash[mo.raceId] = mo
						end
					elseif mo.curLv > curMo.curLv then
						awakenablePetMoHash[mo.raceId] = mo
					end
				else
					awakenablePetMoHash[mo.raceId] = mo
				end
			end
		end

		for k, mo in pairs(awakenablePetMoHash) do
			table.insert(awakenablePetMoList, mo)
		end
	end

	return awakenablePetMoList
end

function BagModel:getPetAwakeTotalCost(petMo, awakenLv)
	local costNum = 0
	local costDustNum = 0
	local cfg = CharacterConfig.instance:getPetCo(petMo.raceId)

	for i = petMo.awakenLv, awakenLv - 1 do
		local costCfg = CharacterConfig.instance:getPetAwakenCostCfg(cfg.awakenCostStrategyId, i + 1)

		if costCfg then
			costNum = costNum + costCfg.needPetNum
			costDustNum = costDustNum + costCfg.needCoinNum
		else
			break
		end
	end

	return costNum, costDustNum
end

function BagModel:getPetAwakeMaxLvByCost(petMo, costNum)
	costNum = checknumber(costNum)

	local cfg = CharacterConfig.instance:getPetCo(petMo.raceId)
	local maxLv = petMo.awakenLv

	for i = petMo.awakenLv, 5 do
		local costCfg = CharacterConfig.instance:getPetAwakenCostCfg(cfg.awakenCostStrategyId, i + 1)

		if costCfg and costNum >= costCfg.needPetNum then
			costNum = costNum - costCfg.needPetNum
			maxLv = i + 1
		end
	end

	return maxLv
end

function BagModel:getYuanRaceTypeChange(petId)
	if self._yuanPetsMap[petId] then
		return self._yuanPetsMap[petId]
	end

	return nil
end

function BagModel:setYuanRaceTypeChange(petId, raceType)
	self._yuanPetsMap[petId] = raceType
end

BagModel.instance = BagModel.New()

return BagModel
