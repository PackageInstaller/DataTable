-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/model/BagPetMo.lua

module("logic.extensions.bag.model.BagPetMo", package.seeall)

local BagPetMo = class("BagPetMo")

function BagPetMo:ctor()
	self._viewType = 0
	self.petId = 0
	self.raceId = 0
	self.curFaceId = 0
	self.name = nil
	self.curLv = 0
	self.level = 0
	self.summonMasterId = 0
	self.summonedPetId = 0
	self._maxHp = 0
	self._attack = 0
	self._physicalAttack = 0
	self._physicalDefence = 0
	self._magicAttack = 0
	self._magicDefence = 0
	self._ultimateAttack = 0
	self._ultimateDefence = 0
	self._speed = 0
	self._hitRate = 0
	self._dodgeRate = 0
	self._strikeRate = 0
	self._blockRate = 0
	self._criticalRate = 0
	self._antiCriticalRate = 0
	self._originalVigourRate = 0
	self.curExp = 0
	self.gainTime = 0
	self.expiredTime = 0
	self.deleted = false
	self.status = 0
	self.forbit = false
	self.awakenLv = 0
	self.awakeLevel = 0
	self.talentLevel = 0
	self.rare = GameEnum.PetRare.N
	self.isSupportedPet = false
	self.isMyPackPet = true
	self.runeSuit = {}
	self.equipments = {}
	self.decoration = nil
	self.hoshigamis = {}
	self.throneList = {}
	self.holystripes = {}
	self.goodFeelingInfos = {}
	self.assistTeamInfoList = {}
	self.benefitInfoList = {}
	self.teamInfo = {}
	self.mountInfo = {}
	self.collectRelationIds = {}
	self.starGodPlusSlots = {}
	self.formStrength = {}
	self.onlyUseExtProperties = false
	self.allPropertyExtZdl = 0
	self.allPropertyExtZdlRate = 0
	self.cutePetShelter = {}
	self.usePublicStrengthsFlag = false
	self.usePublicStrengthsSetAttr = true
	self.extpropertiesArr = {}
	self.zooAnimalFollowGeneIds = {}
	self.kamuiInfos = {}
	self.petTitleId = 0
	self.contractSkillId = 0
	self.attrMo = AttrMo.New()
	self.powerCrystalFollowerOriginalProperties = nil
	self.normalSkillLv = 1
	self.ultimateSkillLv = 1
	self.passiveSkillLv = 1
	self.psychicedNormalSkillLv = 1
	self.psychicedUltimateSkillLv = 1
	self.carriedMasterId = 0
	self.carriedPetId = 0
	self.oracleMasterId = 0
	self.oraclePetId = 0
	self.oraclePetRaceId = 0
	self.heavenAwakenMasterId = 0
	self.heavenAwakenSummonPetId = 0
	self.skinOtherName = nil
	self.bookSpiritPetId = 0
	self.bookSpiritRaceId = 0
	self.sourceTraces = {}
end

function BagPetMo:resetCellStatus()
	self.isDead = false
	self.forbit = false
end

function BagPetMo:initMo(mo)
	if mo:HasField("viewType") then
		self._viewType = self:_checkDefault(mo, "viewType")
	end

	if mo:HasField("switchState") then
		self._switchState = self:_checkDefault(mo, "switchState")
	end

	self.curExp = self:_checkDefault(mo, "curExp")
	self.deleted = self:_checkDefault(mo, "deleted")
	self.gainTime = self:_checkDefault(mo, "gainTime")
	self.expiredTime = checknumber(self:_checkDefault(mo, "expiredTime"))

	if self._viewType == 1 then
		self.powerCrystalFollowerOriginalProperties = nil
	end

	if mo:HasField("baseView") then
		self:initBaseView(mo.baseView)
	end

	return self.petId
end

function BagPetMo:_checkDefault(mo, key)
	if mo.HasField ~= nil and mo:HasField(key) then
		return mo[key]
	end

	return self[key]
end

function BagPetMo:initBaseView(baseView)
	self.petId = self:_checkDefault(baseView, "petId")
	self.raceId = self:_checkDefault(baseView, "raceId")
	self.curFaceId = self:_checkDefault(baseView, "curFaceId")

	local cfg = MaterialMgr.getMatCfg(MatType.Pet, self.raceId)

	self.name = nil

	if cfg then
		if checknumber(self.curFaceId) == 0 then
			self.curFaceId = checknumber(cfg.faceIds)
		end

		if checknumber(self.curFaceId) == 0 then
			self.curFaceId = self.raceId
		end
	end

	self:getName()

	self.curLv = self:_checkDefault(baseView, "curLv")
	self.summonMasterId = self:_checkDefault(baseView, "summonMasterId")
	self.summonedPetId = self:_checkDefault(baseView, "summonedPetId")
	self.awakenLv = self:_checkDefault(baseView, "awakenLv")
	self.talentLevel = self:_checkDefault(baseView, "talentLevel")
	self.level = self.curLv
	self.awakeLevel = self.awakenLv
	self.isMyPackPet = self:_checkDefault(baseView, "isMyPackPet")
	self.petTitleId = self:_checkDefault(baseView, "petTitleId")
	self.status = self:_checkDefault(baseView, "status")

	local t = GameUtil.pbToTable(baseView.collectRelationIds)

	self.collectRelationIds = t or self.collectRelationIds
	t = GameUtil.pbToTable(baseView.activedOnFormRelationIds)
	self.activedOnFormRelationIds = t or self.activedOnFormRelationIds
	t = GameUtil.pbToTable(baseView.runeSuit)
	self.runeSuit = t or self.runeSuit
	t = GameUtil.pbToTable(baseView.teamInfo)
	self.teamInfo = t or self.teamInfo
	t = GameUtil.pbToTable(baseView.mountInfo)
	self.mountInfo = t or self.mountInfo
	t = GameUtil.pbToTable(baseView.throneList)
	self.throneList = t or self.throneList
	t = GameUtil.pbToTable(baseView.goodFeelingInfos)
	self.goodFeelingInfos = t or self.goodFeelingInfos
	t = GameUtil.pbToTable(baseView.assistTeamInfoList)
	self.assistTeamInfoList = t or self.assistTeamInfoList
	t = GameUtil.pbToTable(baseView.benefitInfoList)
	self.benefitInfoList = t or self.benefitInfoList
	t = GameUtil.pbToTable(baseView.hoshigamis)
	self.hoshigamis = t or self.hoshigamis
	t = GameUtil.pbToTable(baseView.formStrength)
	self.formStrength = t or self.formStrength
	t = GameUtil.pbToTable(baseView.extProperties)
	self.extProperties = t or self.extProperties
	t = GameUtil.pbToTable(baseView.cutePetShelter)
	self.cutePetShelter = t or self.cutePetShelter
	self.onlyUseExtProperties = false
	self.extpropertiesArr = {}
	self.allPropertyExtZdl = 0
	self.allPropertyExtZdlRate = 0

	if self.extProperties then
		self.onlyUseExtProperties = checkbool(self.extProperties.onlyUseExtProperties)

		local list = self.extProperties.extProperties

		if list then
			for i, v in ipairs(list) do
				self.extpropertiesArr[v.proertyType] = v.value
			end
		end

		self.allPropertyExtZdl = checknumber(self.extProperties.allPropertyExtZdl)
		self.allPropertyExtZdlRate = checknumber(self.extProperties.allPropertyExtZdlRate)
	end

	t = GameUtil.pbToTable(baseView.zooAnimalFollowGeneIds)
	self.zooAnimalFollowGeneIds = t or self.zooAnimalFollowGeneIds

	self:_updateSourceTraces(baseView.sourceTraces)
	self:_updateKamui(baseView.kamuiInfos)
	self:_updateStarGodPlus(baseView.starGodPlusSlots)
	self:_updateHolyStripes(baseView.holyStripes)
	self:updatePetEquipInfoList(baseView.equipments)

	self.decoration = GameUtil.pbToTable(baseView.decoration)
	self.normalSkillLv = self:_checkDefault(baseView, "normalSkillLv")
	self.ultimateSkillLv = self:_checkDefault(baseView, "ultimateSkillLv")
	self.passiveSkillLv = self:_checkDefault(baseView, "passiveSkillLv")
	self.psychicedNormalSkillLv = self:_checkDefault(baseView, "psychicedNormalSkillLv")
	self.psychicedUltimateSkillLv = self:_checkDefault(baseView, "psychicedUltimateSkillLv")
	self.contractSkillId = self:_checkDefault(baseView, "contractSkillId")
	self.carriedMasterId = self:_checkDefault(baseView, "carriedMasterId")
	self.carriedPetId = self:_checkDefault(baseView, "carriedPetId")
	self.oracleMasterId = self:_checkDefault(baseView, "oracleMasterId")
	self.oraclePetId = self:_checkDefault(baseView, "oraclePetId")
	self.oraclePetRaceId = self:_checkDefault(baseView, "oraclePetRaceId")
	self.bookSpiritPetId = self:_checkDefault(baseView, "bookSpiritPetId")
	self.bookSpiritRaceId = self:_checkDefault(baseView, "bookSpiritRaceId")
	self.skinOtherName = self:_checkDefault(baseView, "skinOtherName")

	self:setAttrMo()
	self:calcAllAttr()
end

function BagPetMo:calcAllAttr()
	if self.onlyUseExtProperties then
		self.attrMo:calcExtAttrs(self)
	else
		self.attrMo:calcBaseAttrs(self, true)
		self:calcSourceTraceAttr(true, true)
		self.attrMo:calcEquipmentAttr(self, true)
		self:calcMountAttr(true, true)
		self:calcFormStrengthAttr(true, true)
		self:calcRuneAttr(true, true)
		self:calcPetThroneAttr(true, true)
		self:calcPetHandbookAttr(true, true)
		self:calcAnimalAttr(true, true)
		self:calcAssistAttr(true, true)
		self:calcPetGoodfellingAttr(true, true)
		self:calcPetHoshigamiAttr(true, true)
		self:calcDecorationAttr(true, true)
		self:calcStarGodPlusAttr(true, true)
		self:calcHolyStripesAttr(true, true)
		self:calcCutePetAttr(true, true)
		self.attrMo:calcPetTeamAttr(self, true)
		self.attrMo:calcPetRelationAttr(self, true)
		self.attrMo:calcTotalAttrs()
	end

	self:refreshAllAttr()

	self.rare = CharacterConfig.instance:getRareByAwakenLv(self.awakeLevel, self.raceId)
end

function BagPetMo:calcEquipAttr()
	self.attrMo:calcEquipmentAttr(self)
	self:refreshAllAttr()
end

function BagPetMo:calcRuneAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcRuneAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcFormStrengthAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcFormStrengthAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcMountAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcMountAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcPetThroneAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcPetThroneAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcPetGoodfellingAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcPetGoodfellingAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcPetHoshigamiAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcPetHoshigamiAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcDecorationAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcDecorationAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcStarGodPlusAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcStarGodPlusAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcHolyStripesAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcHolyStripesAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcPetHandbookAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcPetHandbookAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcAnimalAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcAnimalAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcAssistAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcAssistAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcPetTeamAttr(notRefreshAll)
	self.attrMo:calcPetTeamAttr(self)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcCutePetAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcCutePetAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:calcSourceTraceAttr(notRefreshAll, isForbitCalc)
	self.attrMo:calcSourceTraceAttr(self, isForbitCalc)

	if not notRefreshAll then
		self:refreshAllAttr()
	end
end

function BagPetMo:refreshAllAttr()
	self.attrMo:calcFinalAttr()

	self._maxHp = self.attrMo._maxHp
	self._attack = self.attrMo._attack
	self._physicalAttack = self.attrMo._physicalAttack
	self._physicalDefence = self.attrMo._physicalDefence
	self._magicAttack = self.attrMo._magicAttack
	self._magicDefence = self.attrMo._magicDefence
	self._ultimateAttack = self.attrMo._ultimateAttack
	self._ultimateDefence = self.attrMo._ultimateDefence
	self._speed = self.attrMo._speed
	self._hitRate = self.attrMo._hitRate
	self._dodgeRate = self.attrMo._dodgeRate
	self._strikeRate = self.attrMo._strikeRate
	self._blockRate = self.attrMo._blockRate
	self._criticalRate = self.attrMo._criticalRate
	self._antiCriticalRate = self.attrMo._antiCriticalRate
	self._originalVigourRate = self.attrMo._originalVigourRate

	self.attrMo:calcFightPower(self.onlyUseExtProperties)

	self._zdl = self.attrMo._zdl
end

function BagPetMo:updatePetEquipInfoList(pbList)
	if self._viewType == 1 then
		self.equipments = {}

		if pbList and #pbList then
			for i, v in ipairs(pbList) do
				local tem = GameUtil.pbToTable(v)

				if tem.deleted then
					self.equipments[tem.positionId] = nil
				else
					self.equipments[tem.positionId] = tem
				end
			end
		end
	else
		self.equipments = self.equipments or {}

		if pbList and #pbList > 0 then
			for i, v in ipairs(pbList) do
				local tem = GameUtil.pbToTable(v)

				if tem.deleted then
					self.equipments[tem.positionId] = nil
				else
					local dest = self.equipments[tem.positionId]

					dest = dest or {}

					table.merge(dest, tem)

					self.equipments[tem.positionId] = dest
				end
			end
		end
	end
end

function BagPetMo:_updateHolyStripes(pbList)
	if self._viewType == 1 then
		self.holyStripes = {}

		if pbList and #pbList then
			for i, v in ipairs(pbList) do
				local tem = GameUtil.pbToTable(v)

				if tem.id < 0 then
					self.holyStripes[tem.pos] = nil
				else
					self.holyStripes[tem.pos] = tem
				end
			end
		end
	else
		self.holyStripes = self.holyStripes or {}

		if pbList and #pbList > 0 then
			for i, v in ipairs(pbList) do
				local tem = GameUtil.pbToTable(v)

				if tem.id < 0 then
					self.holyStripes[tem.pos] = nil
				else
					local dest = self.holyStripes[tem.pos]

					dest = dest or {}

					table.merge(dest, tem)

					self.holyStripes[tem.pos] = dest
				end
			end
		end
	end
end

function BagPetMo:_updateStarGodPlus(starGodPlusSlots)
	if self._viewType == 1 then
		self.starGodPlusSlots = {}

		if starGodPlusSlots and #starGodPlusSlots > 0 then
			for i, v in ipairs(starGodPlusSlots) do
				local temp = GameUtil.pbToTable(v)

				table.insert(self.starGodPlusSlots, temp)
			end
		end
	elseif starGodPlusSlots and #starGodPlusSlots > 0 then
		local hasSlotData = {}

		for k, v in pairs(self.starGodPlusSlots) do
			hasSlotData[v.slot] = v
		end

		local toRemoveIndexes = {}

		for _, v in ipairs(starGodPlusSlots) do
			if v.fillerDefineId > 0 then
				if hasSlotData[v.slot] then
					local updatedData = GameUtil.pbToTable(v)

					for key, value in pairs(updatedData) do
						hasSlotData[v.slot][key] = value
					end
				else
					local temp = GameUtil.pbToTable(v)

					table.insert(self.starGodPlusSlots, temp)
				end
			else
				for k, existingSlot in ipairs(self.starGodPlusSlots) do
					if existingSlot.slot == v.slot then
						table.insert(toRemoveIndexes, k)

						break
					end
				end
			end
		end

		table.sort(toRemoveIndexes)

		for i = #toRemoveIndexes, 1, -1 do
			table.remove(self.starGodPlusSlots, toRemoveIndexes[i])
		end
	end
end

function BagPetMo:_updateKamui(kamuiInfos)
	if self._viewType == 1 then
		self.kamuiInfos = {}

		if kamuiInfos and #kamuiInfos > 0 then
			for i, v in ipairs(kamuiInfos) do
				local temp = GameUtil.pbToTable(v)

				table.insert(self.kamuiInfos, temp)
			end
		end
	elseif kamuiInfos and #kamuiInfos > 0 then
		self.kamuiInfos = self.kamuiInfos or {}

		for i, v in ipairs(kamuiInfos) do
			self.kamuiInfos[v.level] = v
		end
	end
end

function BagPetMo:_updateSourceTraces(sourceTraceList)
	if self._viewType == 1 then
		local t = GameUtil.pbToTable(sourceTraceList)

		self.sourceTraces = t or {}
	else
		local t = GameUtil.pbToTable(sourceTraceList)

		if t then
			for i, v in ipairs(t) do
				local isFind = false

				for j, info in ipairs(self.sourceTraces) do
					if v.nodeId == info.nodeId then
						info.effectId = v.effectId
						isFind = true

						break
					end
				end

				if not isFind then
					table.insert(self.sourceTraces, v)
				end
			end
		end
	end

	local isSourceTrace = PetSkinConfig.instance:checkHasJob(self.curFaceId, GameEnum.CareerType.SourceTrace)

	if isSourceTrace == true then
		local petCfg = CharacterConfig.instance:getPetCo(self.raceId)
		local defaultNodeCfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(petCfg.sourceTraceId, SourceTraceController.DEFAULT_ACTIVE_NODE_ID)
		local hasDefalult = false

		if not defaultNodeCfg then
			printError(">>>>>>>>>>>>>>>>>>>>>源起精灵没配置源迹技能树，精灵faceId:" .. self.curFaceId .. "源迹id：" .. petCfg.sourceTraceId)
		end

		for i, v in ipairs(self.sourceTraces) do
			if defaultNodeCfg and v.nodeId == defaultNodeCfg.nodeId then
				hasDefalult = true

				break
			end
		end

		if not hasDefalult and defaultNodeCfg then
			table.insert(self.sourceTraces, {
				nodeId = defaultNodeCfg.nodeId,
				effectId = defaultNodeCfg.effectIds[1]
			})
		end
	end
end

function BagPetMo:refreshData(mo)
	return
end

function BagPetMo:isExist()
	if self.expiredTime <= 0 then
		return not self.deleted
	else
		return self.deleted ~= true and ServerTime.nowMs() <= self.expiredTime
	end
end

function BagPetMo:getPetId()
	return self.petId
end

function BagPetMo:getId()
	return self.petId
end

function BagPetMo:getMatType()
	return MatType.Pet
end

function BagPetMo:getDefineId()
	return self.raceId
end

function BagPetMo:getPetLv()
	return self.level
end

function BagPetMo:getTalentLevel()
	return self.talentLevel
end

function BagPetMo:getAwakenLv()
	return self.awakeLevel
end

function BagPetMo:getGainTime()
	return self.gainTime
end

function BagPetMo:checkHasRace(attr)
	return PetSkinConfig.instance:checkHasEleAttr(self.curFaceId, attr)
end

function BagPetMo:setPetForbit(forbit)
	self.forbit = forbit
end

function BagPetMo:onReset()
	self.petId = 0
	self.raceId = 0
	self.curFaceId = 0
	self.name = 0
	self.level = 0
	self.summonMasterId = 0
	self.summonedPetId = 0
	self._maxHp = 0
	self._physicalAttack = 0
	self._physicalDefence = 0
	self._magicAttack = 0
	self._magicDefence = 0
	self._ultimateAttack = 0
	self._ultimateDefence = 0
	self._speed = 0
	self.isSupportedPet = false
	self.isHirePet = false
	self.normalSkillLv = 1
	self.ultimateSkillLv = 1
	self.passiveSkillLv = 1
end

function BagPetMo:isGeniusTypeToMax()
	return self:GetGeniusType() == TalentConfig.instance:GetGeniusMaxType()
end

function BagPetMo:GetClone()
	return TableUtil.deepcopy(self)
end

function BagPetMo:getFightingPower()
	return FightingPowerFormula.instance:getPetFightingPowerByPetMo(self)
end

function BagPetMo:getMaxFightingPower()
	return FightingPowerFormula.instance:getPetMaxFightingPower(self.raceId)
end

function BagPetMo:toFightingPowerPetMo(petsList)
	local mo = FightingPowerPetMo.New(self.raceId, self.level)

	mo.name = self:getName()
	mo.petId = self.petId
	mo.curFaceId = self.curFaceId

	mo:setAttrMo()

	mo.summonMasterId = self.summonMasterId
	mo.summonedPetId = self.summonedPetId
	mo.awakeLevel = self.awakeLevel
	mo.awakenLv = self.awakeLevel
	mo.talentLevel = self.talentLevel
	mo.isSupportedPet = self.isSupportedPet
	mo.isHirePet = self.isHirePet
	mo.runeSuit = self.runeSuit
	mo.equipments = self.equipments
	mo.decoration = self.decoration
	mo.hoshigamis = self.hoshigamis
	mo.throneList = self.throneList
	mo.starGodPlusSlots = self.starGodPlusSlots
	mo.goodFeelingInfos = self.goodFeelingInfos
	mo.assistTeamInfoList = self.assistTeamInfoList
	mo.benefitInfoList = self.benefitInfoList
	mo.kamuiInfos = self.kamuiInfos
	mo.teamInfo = self.teamInfo
	mo.mountInfo = self.mountInfo
	mo.collectRelationIds = self.collectRelationIds
	mo.activedOnFormRelationIds = self.activedOnFormRelationIds
	mo.formStrength = self.formStrength
	mo.onlyUseExtProperties = checkbool(self.onlyUseExtProperties)
	mo.extpropertiesArr = self.extpropertiesArr
	mo.holyStripes = self.holyStripes
	mo.normalSkillLv = self.normalSkillLv
	mo.ultimateSkillLv = self.ultimateSkillLv
	mo.passiveSkillLv = self.passiveSkillLv
	mo.contractSkillId = self.contractSkillId
	mo.psychicedNormalSkillLv = self.psychicedNormalSkillLv
	mo.psychicedUltimateSkillLv = self.psychicedUltimateSkillLv
	mo.petTitleId = self.petTitleId
	mo.usePublicStrengthsFlag = self.usePublicStrengthsFlag
	mo.cutePetShelter = self.cutePetShelter
	mo.carriedMasterId = self.carriedMasterId
	mo.carriedPetId = self.carriedPetId
	mo.heavenAwakenMasterId = self.heavenAwakenMasterId
	mo.heavenAwakenSummonPetId = self.heavenAwakenSummonPetId
	mo.oracleMasterId = self.oracleMasterId
	mo.oraclePetId = self.oraclePetId
	mo.oraclePetRaceId = self.oraclePetRaceId
	mo.sourceTraces = self.sourceTraces
	mo.bookSpiritPetId = self.bookSpiritPetId
	mo.bookSpiritRaceId = self.bookSpiritRaceId
	mo.isMyPackPet = self.isMyPackPet

	if self.isSupportedPet then
		mo:calcAllAttr()

		mo.supportedFightingPower = self.supportedFightingPower
		mo._speed = self.speed
	else
		mo:calcAllAttr()
	end

	return mo
end

function BagPetMo:isMaxLv()
	return self.level == CharacterConfig.instance:GetMaxLevel(self.raceId)
end

function BagPetMo:getNextLvlExp()
	return CharacterConfig.instance:GetLevelExpByLevel(self.raceId, self.level)
end

function BagPetMo:getCurExp()
	return self.curExp
end

function BagPetMo:getCurExceedExp()
	return self.curExp - CharacterConfig.instance:GetCurLevelExp(self.raceId, self.level)
end

function BagPetMo:isMaxAwaken()
	local maxAwaken = CharacterConfig.instance:getMaxAwaken(self.raceId)

	return maxAwaken <= checknumber(self.awakeLevel)
end

function BagPetMo:isMaxTalent()
	return checknumber(self.talentLevel) >= CharacterConfig.instance:getMaxTalentLv()
end

function BagPetMo:isLocked()
	self._switchState = self._switchState or 0

	return GameUtil.isBitOpenByDigit(self._switchState, 0)
end

function BagPetMo:setSwitchState(value)
	self._switchState = value
end

function BagPetMo:getName()
	if string.nilorempty(self.name) then
		self.name = PetSkinConfig.instance:getPetSkinName(self.curFaceId)
	end

	return self.name
end

function BagPetMo:isSummonedPet()
	return self.summonMasterId > 0 or checknumber(self.contractSkillId) > 0
end

function BagPetMo:isSummonedMaster()
	if self._isSummonMaster == nil then
		self._isSummonMaster = PetSkinConfig.instance:checkHasJob(self.curFaceId, GameEnum.JobZhDefine.Zhaohuanshi)
	end

	return self._isSummonMaster
end

function BagPetMo:getTmpFightMo(force)
	if force or self.__fightMo == nil then
		self.__fightMo = self:toFightingPowerPetMo()
	end

	return self.__fightMo
end

function BagPetMo:isAwakenMax()
	local cfg = CharacterConfig.instance:getPetCo(self.raceId)

	if cfg and cfg.awakenCostStrategyId > 0 then
		return CharacterConfig.instance:getPetAwakenCostCfg(cfg.awakenCostStrategyId, self.awakenLv + 1) == nil
	else
		return false
	end
end

function BagPetMo:getOriginLevel()
	return self.curLv
end

function BagPetMo:getOriginTalentLv()
	return self.talentLevel
end

function BagPetMo:getPetTitleId()
	return self.petTitleId
end

function BagPetMo:reachTrialCondition(trialCondition)
	local realReached = true

	if trialCondition then
		for k, v in pairs(trialCondition) do
			local isRealReached = true

			if k == "PetLv" then
				isRealReached = v <= self:getOriginLevel()
			elseif k == "TalentLv" then
				isRealReached = v <= self:getOriginTalentLv()
			end

			realReached = realReached and isRealReached
		end
	end

	return realReached
end

function BagPetMo:getRare()
	return self.rare
end

function BagPetMo:getStarGodPlusSlots()
	return self.starGodPlusSlots
end

function BagPetMo:isStarGodMaxLv()
	local maxSlotCount = #StargodplusConfig.instance:getSlotCfgs().dataList

	if self.starGodPlusSlots and maxSlotCount <= #self.starGodPlusSlots then
		local isMax = true

		for i, v in ipairs(self.starGodPlusSlots) do
			isMax = isMax and StargodplusModel.instance:isSlotMaxLv(v.slot, v.exp)
		end

		return isMax
	else
		return false
	end
end

function BagPetMo:isStarGodMaxSlotCount()
	local maxSlotCount = #StargodplusConfig.instance:getSlotCfgs().dataList

	if self.starGodPlusSlots then
		local count = 0

		for i, v in ipairs(self.starGodPlusSlots) do
			if v.fillerDefineId > 0 and v.fillerId > 0 then
				count = count + 1
			end
		end

		return maxSlotCount <= count
	else
		return false
	end
end

function BagPetMo:isAllEquipRedStarGodMaxSlot()
	local maxSlotCount = #StargodplusConfig.instance:getSlotCfgs().dataList

	if self.starGodPlusSlots then
		local count = 0

		for i, v in ipairs(self.starGodPlusSlots) do
			if v.fillerDefineId > 0 and v.fillerId > 0 then
				local stargodplusCfg = StargodplusConfig.instance:getFillerCfg(v.fillerDefineId)

				if stargodplusCfg.quality >= 6 then
					count = count + 1
				end
			end
		end

		return maxSlotCount <= count
	else
		return false
	end
end

function BagPetMo:getKamuiInfos()
	return self.kamuiInfos
end

function BagPetMo:checkHasDestroyStarGodPlus()
	local starGodPlusSlots = self.starGodPlusSlots

	for i, v in ipairs(starGodPlusSlots or {}) do
		local defindId = v.fillerDefineId
		local cfg = StargodplusConfig.instance:getFillerCfg(defindId) or {}

		if cfg.needDestroy then
			return true
		end
	end

	return false
end

function BagPetMo:usePublicStrengths()
	local mo = self:GetClone()

	mo.usePublicStrengthsFlag = true

	mo:calcAllAttr()

	return mo
end

function BagPetMo:unUsePublicStrengths()
	self.usePublicStrengthsFlag = false

	self:refreshAllAttr()
end

function BagPetMo:setSupportedPet(isSupport)
	self.isSupportedPet = isSupport
	self.isMyPackPet = not isSupport
end

function BagPetMo:isBorrowPet()
	return self.status == BagPetsController.PET_STATUS_BORROW
end

function BagPetMo:isBagPet()
	return self.status == BagPetsController.PET_STATUS_BAG
end

function BagPetMo:printAttrs()
	print("testPrintPetAttr", "输出精灵id:", self.petId)

	for t, v in pairs(self.attrMo.finalAttrs) do
		print("testPrintPetAttr", "类型：", ConstString.Attr[t], "值：", v)
	end

	local baseAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.baseAttr)
	local talentAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.talentAttr)
	local awakenAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.awakenAttr)
	local decorationAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.decorationAttr)
	local equipAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.equipAttr)
	local runeAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.runeAttr)
	local extAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.extAttr)
	local petTeamAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.petTeamAttr)
	local petSkinAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.petSkinAttr)
	local petHoshigamiAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.petHoshigamiAttr)
	local petHolyStripesAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.petHolyStripesAttr)
	local petCutePetAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.petCutePetAttr)
	local starGodPlusAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.starGodPlusAttr)
	local assistAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.assistAttr)
	local mountAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.mountAttr)
	local petRelationAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.petRelationAttr)
	local petThroneAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.petThroneAttr)
	local handbookAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.handbookAttr)
	local animalAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.animalAttr)
	local petGoodfellingAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.petGoodfellingAttr)
	local formStrengthAttr = AttrMo.calcFightPowerByAttrs(self.attrMo.formStrengthAttr)

	print("testPrintPetAttr", "baseAttr", ":", baseAttr)
	print("testPrintPetAttr", "talentAttr", ":", talentAttr)
	print("testPrintPetAttr", "awakenAttr", ":", awakenAttr)
	print("testPrintPetAttr", "decorationAttr", ":", decorationAttr)
	print("testPrintPetAttr", "equipAttr", ":", equipAttr)
	print("testPrintPetAttr", "runeAttr", ":", runeAttr)
	print("testPrintPetAttr", "extAttr", ":", extAttr)
	print("testPrintPetAttr", "petTeamAttr", ":", petTeamAttr)
	print("testPrintPetAttr", "petSkinAttr", ":", petSkinAttr)
	print("testPrintPetAttr", "petHoshigamiAttr", ":", petHoshigamiAttr)
	print("testPrintPetAttr", "petHolyStripesAttr", ":", petHolyStripesAttr)
	print("testPrintPetAttr", "petCutePetAttr", ":", petCutePetAttr)
	print("testPrintPetAttr", "starGodPlusAttr", ":", starGodPlusAttr)
	print("testPrintPetAttr", "assistAttr", ":", assistAttr)
	print("testPrintPetAttr", "mountAttr", ":", mountAttr)
	print("testPrintPetAttr", "petRelationAttr", ":", petRelationAttr)
	print("testPrintPetAttr", "petThroneAttr", ":", petThroneAttr)
	print("testPrintPetAttr", "handbookAttr", ":", handbookAttr)
	print("testPrintPetAttr", "animalAttr", ":", animalAttr)
	print("testPrintPetAttr", "petGoodfellingAttr", ":", petGoodfellingAttr)
	print("testPrintPetAttr", "formStrengthAttr", ":", formStrengthAttr)
	print("==========testPrintPetAttr?????", "想输出啥", "#goodFeelingInfos", self.goodFeelingInfos and #self.goodFeelingInfos)

	for i, v in ipairs(self.goodFeelingInfos or {}) do
		print("==========testPrintPetAttr?????", "想输出啥", "好感", v.raceId, v.level)
	end
end

function BagPetMo:setAttrMo()
	local checkRaceId = self.curFaceId

	if checknumber(checkRaceId) <= 0 then
		checkRaceId = self.raceId
	end

	local isSourceTrace = PetSkinConfig.instance:checkHasJob(checkRaceId, GameEnum.JobZhDefine.SourceTrace)

	self.attrMo = isSourceTrace == true and SourceTraceAttrMo.New() or AttrMo.New()
end

return BagPetMo
