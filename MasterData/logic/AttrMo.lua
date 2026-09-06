-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/model/AttrMo.lua

module("logic.extensions.bag.model.AttrMo", package.seeall)

local AttrMo = class("AttrMo")

AttrMo.KEY_DIRECT_ZDL = 1000

function AttrMo:ctor()
	self:resetPrivateAttr()
	self:resetPublicAttr()

	self.baseTotalAttr = {}
	self.withoutPercentTotalAttr = {}
	self.totalAttr = {}
	self.finalAttrs = {}
	self.extModelBaseAttrRate = {}
end

function AttrMo:resetPrivateAttr()
	self.isCalcAttr = false
	self.baseAttr = {}
	self.talentAttr = {}
	self.awakenAttr = {}
	self.equipAttr = {}
	self.runeAttr = {}
	self.extAttr = {}
	self.petTeamAttr = {}
	self.petRelationAttr = {}
	self.petSkinAttr = {}
	self.petHoshigamiAttr = {}
	self.petHolyStripesAttr = {}
	self.petCutePetAttr = {}
	self.decorationAttr = {}
	self.starGodPlusAttr = {}
	self.petSourceTraceAttr = {}
end

function AttrMo:resetPublicAttr()
	self.isCalcAttr = false
	self.assistAttr = {}
	self.mountAttr = {}
	self.petThroneAttr = {}
	self.petGoodfellingAttr = {}
	self.handbookAttr = {}
	self.handBookPercentAttr = {}
	self.formStrengthAttr = {}
	self.animalAttr = {}
	self.animalPercentAttr = {}
end

function AttrMo:useTotalPublic()
	self.isCalcAttr = false
	self.assistAttr = PetAssistModel.instance:GetTotalAttributes()
	self.mountAttr = MountModel.instance:getMountAttr()
	self.petThroneAttr = ThroneModel.instance:getCurrPetAttr()
	self.petGoodfellingAttr = GoodFeelModel.instance:calcGoodFeelingAttrs()
	self.handbookAttr, self.handBookPercentAttr = HandbookModel.instance:calcHandBookAttr()
	self.formStrengthAttr = self:getCurrStrengthAttr()
	self.animalAttr, self.animalPercentAttr = ZooModel.instance:getAllPetAttr()
end

function AttrMo:onReset()
	return
end

function AttrMo:calcBaseAttrs(petMo, isForbitCalc)
	self.petMo = petMo

	local skinCfg = MaterialMgr.getMatCfg(MatType.PET_SKIN, petMo.curFaceId)

	self.baseAttr = self:getBaseAttr(skinCfg.propertyStrategyId, petMo.level)
	self.talentAttr = self:getTalentAttr(petMo)
	self.awakenAttr = self:getAwakenAttr(petMo)
	self.petSkinAttr = self:getPetSkinAttr(petMo)
	self.extAttr = petMo.extpropertiesArr or {}

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Base] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Base] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Base]

		for k, v in pairs(self.baseAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.baseAttr[k] = v * (1 + extRate)
			end
		end
	end

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Talent] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Talent] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Talent]

		for k, v in pairs(self.talentAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.talentAttr[k] = v * (1 + extRate)
			end
		end
	end

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Awaken] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Awaken] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Awaken]

		for k, v in pairs(self.awakenAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.awakenAttr[k] = v * (1 + extRate)
			end
		end
	end

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Skin] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Skin] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Skin]

		for k, v in pairs(self.petSkinAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.petSkinAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.baseAttr
end

function AttrMo:calcExtAttrs(petMo)
	self.petMo = petMo
	self.extAttr = petMo.extpropertiesArr or {}

	self:calcTotalAttrs(true)

	return self.extAttr
end

function AttrMo:calcEquipmentAttr(petMo, isForbitCalc)
	self.petMo = petMo
	self.equipAttr = self:getEquipmentAttr(self.petMo)

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Equipment] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Equipment] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Equipment]

		for k, v in pairs(self.equipAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.equipAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.equipAttr
end

function AttrMo:calcRuneAttr(petMo, isForbitCalc)
	self.petMo = petMo
	self.runeAttr = {}

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Rune] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Rune] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Rune]

		for k, v in pairs(self.runeAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.runeAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.runeAttr
end

function AttrMo:calcFormStrengthAttr(petMo, isForbitCalc)
	self.petMo = petMo

	if petMo.usePublicStrengthsFlag then
		local formStrength = FightingPowerPetMo.getFormStrengthMax()

		if petMo.usePublicStrengthsSetAttr then
			petMo.formStrength = formStrength
		end

		local data = {
			isMyPackPet = false,
			formStrength = formStrength
		}

		self.formStrengthAttr = self:getFormStrengthAttr(data)
	else
		self.formStrengthAttr = self:getFormStrengthAttr(petMo)
	end

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.FormStrength] and self.extModelBaseAttrRate[GameEnum.AttrModelType.FormStrength] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.FormStrength]

		for k, v in pairs(self.formStrengthAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.formStrengthAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.formStrengthAttr
end

function AttrMo:calcMountAttr(petMo, isForbitCalc)
	self.petMo = petMo

	table.clear(self.mountAttr)

	if petMo.usePublicStrengthsFlag then
		local mountInfo = FightingPowerPetMo.getMountMax()

		if petMo.usePublicStrengthsSetAttr then
			petMo.mountInfo = mountInfo
		end

		local data = {
			isMyPackPet = false,
			mountInfo = mountInfo
		}

		for k, v in pairs(self:getMountAttr(data)) do
			self.mountAttr[k] = v
		end
	else
		for k, v in pairs(self:getMountAttr(self.petMo)) do
			self.mountAttr[k] = v
		end
	end

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Mount] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Mount] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Mount]

		for k, v in pairs(self.mountAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.mountAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.mountAttr
end

function AttrMo:calcPetTeamAttr(petMo, isForbitCalc)
	self.petMo = petMo

	table.clear(self.petTeamAttr)

	for k, v in pairs(BagModel.instance:getTeamValueByMo(petMo) or {}) do
		self.petTeamAttr[k] = v
	end

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Team] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Team] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Team]

		for k, v in pairs(self.petTeamAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.petTeamAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.petTeamAttr
end

function AttrMo:calcPetRelationAttr(petMo, isForbitCalc)
	self.petMo = petMo
	self.petRelationAttr = BagModel.instance:getRelationValueByMo(petMo) or {}

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Relation] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Relation] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Relation]

		for k, v in pairs(self.petRelationAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.petRelationAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.petRelationAttr
end

function AttrMo:calcPetThroneAttr(petMo, isForbitCalc)
	self.petMo = petMo

	table.clear(self.petThroneAttr)

	if petMo.usePublicStrengthsFlag then
		local throneList = FightingPowerPetMo.getThroneMax()

		if petMo.usePublicStrengthsSetAttr then
			petMo.throneList = throneList
		end

		local data = {
			isMyPackPet = false,
			throneList = throneList
		}

		for k, v in pairs(ThroneModel.instance:getPetThroneAttr(data)) do
			self.petThroneAttr[k] = v
		end

		self.petThroneAttr = ThroneModel.instance:getPetThroneAttr(data)
	else
		for k, v in pairs(ThroneModel.instance:getPetThroneAttr(petMo) or {}) do
			self.petThroneAttr[k] = v
		end
	end

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Throne] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Throne] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Throne]

		for k, v in pairs(self.petThroneAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.petThroneAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.petThroneAttr
end

function AttrMo:calcPetGoodfellingAttr(petMo, isForbitCalc)
	self.petMo = petMo

	table.clear(self.petGoodfellingAttr)

	if petMo.usePublicStrengthsFlag then
		local goodFeelingInfos = FightingPowerPetMo.getGoodFeelingMax()

		if petMo.usePublicStrengthsSetAttr then
			petMo.goodFeelingInfos = goodFeelingInfos
		end

		local data = {
			goodFeelingInfos = goodFeelingInfos
		}

		self.petGoodfellingAttr = GoodFeelModel.instance:calcOtherGoodFeelingAttrs(data)
	elseif self.petMo.isMyPackPet then
		for k, v in pairs(GoodFeelModel.instance:getCacheCalcGoodFeelingAttrs()) do
			self.petGoodfellingAttr[k] = v
		end
	else
		self.petGoodfellingAttr = GoodFeelModel.instance:calcOtherGoodFeelingAttrs(self.petMo)
	end

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Goodfelling] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Goodfelling] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Goodfelling]

		for k, v in pairs(self.petGoodfellingAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.petGoodfellingAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.petGoodfellingAttr
end

function AttrMo:calcPetHoshigamiAttr(petMo, isForbitCalc)
	self.petMo = petMo
	self.petHoshigamiAttr = HoshigamiModel.instance:calcByHoshigamisAttrs(petMo.hoshigamis, self.petMo.isMyPackPet)

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Hoshigami] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Hoshigami] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Hoshigami]

		for k, v in pairs(self.petHoshigamiAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.petHoshigamiAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.petHoshigamiAttr
end

function AttrMo:calcHolyStripesAttr(petMo, isForbitCalc)
	self.petMo = petMo
	self.petHolyStripesAttr = HolyStripeModel.instance:calcByHolyStripeAttrs(petMo.holyStripes, self.petMo.isMyPackPet)

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.HolyStripe] and self.extModelBaseAttrRate[GameEnum.AttrModelType.HolyStripe] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.HolyStripe]

		for k, v in pairs(self.petHolyStripesAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.petHolyStripesAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.petHolyStripesAttr
end

function AttrMo:calcCutePetAttr(petMo, isForbitCalc)
	self.petMo = petMo
	self.petCutePetAttr = CutePetModel.instance:calcByCutePetAttrs(petMo.cutePetShelter, self.petMo.isMyPackPet)

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.CutePet] and self.extModelBaseAttrRate[GameEnum.AttrModelType.CutePet] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.CutePet]

		for k, v in pairs(self.petCutePetAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.petCutePetAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.petCutePetAttr
end

function AttrMo:calcSourceTraceAttr(petMo, isForbitCalc)
	self.petMo = petMo
	self.petSourceTraceAttr = SourceTraceController.instance:calcBySourceTracesAttrs(petMo.sourceTraces, self.petMo.isMyPackPet)

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.SourceTrace] and self.extModelBaseAttrRate[GameEnum.AttrModelType.SourceTrace] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.SourceTrace]

		for k, v in pairs(self.petSourceTraceAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.petSourceTraceAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.petSourceTraceAttr
end

function AttrMo:calcDecorationAttr(petMo, isForbitCalc)
	self.petMo = petMo
	self.decorationAttr = PetEquipModel.instance:calcDecorationAttrs(petMo.decoration, self.petMo.isMyPackPet)

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Decoration] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Decoration] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Decoration]

		for k, v in pairs(self.decorationAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.decorationAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.decorationAttr
end

function AttrMo:calcStarGodPlusAttr(petMo, isForbitCalc)
	self.petMo = petMo

	local starGodPlusSlots = {}

	for i, v in ipairs(petMo.starGodPlusSlots or {}) do
		local slot = v.slot
		local cfg = StargodplusConfig.instance:getSlotCfg(slot)

		if cfg and petMo.level >= cfg.unlockPetLv then
			table.insert(starGodPlusSlots, v)
		end
	end

	self.starGodPlusAttr = StargodplusModel.instance:calcStarGodPlusAttrs(starGodPlusSlots)

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.StarGodPlus] and self.extModelBaseAttrRate[GameEnum.AttrModelType.StarGodPlus] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.StarGodPlus]

		for k, v in pairs(self.starGodPlusAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.starGodPlusAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.starGodPlusAttr
end

function AttrMo:calcPetHandbookAttr(petMo, isForbitCalc)
	self.petMo = petMo

	table.clear(self.handbookAttr)

	local result

	if petMo.usePublicStrengthsFlag then
		local benefitInfoList = FightingPowerPetMo.getBenefitMax()

		if petMo.usePublicStrengthsSetAttr then
			petMo.benefitInfoList = benefitInfoList
		end

		local data = {
			benefitInfoList = benefitInfoList,
			raceId = petMo.raceId
		}

		result, self.handBookPercentAttr = HandbookModel.instance:calcOhterHandBookAttr(data)
	elseif self.petMo.isMyPackPet then
		result, self.handBookPercentAttr = HandbookModel.instance:calcHandBookAttr()
	else
		result, self.handBookPercentAttr = HandbookModel.instance:calcOhterHandBookAttr(self.petMo)
	end

	for k, v in pairs(result or {}) do
		self.handbookAttr[k] = v
	end

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Book] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Book] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Book]

		for k, v in pairs(self.handbookAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.handbookAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.handbookAttr, self.handBookPercentAttr
end

function AttrMo:calcAnimalAttr(petMo, isForbitCalc)
	self.petMo = petMo

	table.clear(self.animalAttr)

	local result

	if self.petMo.isMyPackPet then
		result, self.animalPercentAttr = ZooModel.instance:getAllPetAttr() or {}, {}
	else
		result, self.animalPercentAttr = ZooModel.instance:getPetAttrByProps(petMo.zooAnimalFollowGeneIds) or {}, {}
	end

	for k, v in pairs(result or {}) do
		self.animalAttr[k] = v
	end

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Animal] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Animal] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Animal]

		for k, v in pairs(self.animalAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.animalAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.animalAttr, self.animalPercentAttr
end

function AttrMo:calcAssistAttr(petMo, isForbitCalc)
	self.petMo = petMo

	table.clear(self.assistAttr)

	if petMo.usePublicStrengthsFlag then
		local assistTeamInfoList = FightingPowerPetMo.getAssistMax()

		if petMo.usePublicStrengthsSetAttr then
			petMo.assistTeamInfoList = assistTeamInfoList
		end

		local data = {
			isMyPackPet = false,
			assistTeamInfoList = assistTeamInfoList
		}

		for k, v in pairs(PetAssistModel.instance:GetOtherTotalAttributes(data) or {}) do
			self.assistAttr[k] = v
		end
	elseif self.petMo.isMyPackPet then
		for k, v in pairs(PetAssistModel.instance:GetTotalAttributes() or {}) do
			self.assistAttr[k] = v
		end
	else
		for k, v in pairs(PetAssistModel.instance:GetOtherTotalAttributes(self.petMo) or {}) do
			self.assistAttr[k] = v
		end
	end

	if self.extModelBaseAttrRate[GameEnum.AttrModelType.Assist] and self.extModelBaseAttrRate[GameEnum.AttrModelType.Assist] > 0 then
		local extRate = self.extModelBaseAttrRate[GameEnum.AttrModelType.Assist]

		for k, v in pairs(self.assistAttr) do
			if k ~= GameEnum.AttrType.OriginalVigour and (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) then
				self.assistAttr[k] = v * (1 + extRate)
			end
		end
	end

	if not isForbitCalc then
		self:calcTotalAttrs()
	end

	return self.assistAttr
end

function AttrMo:calcTotalAttrs(extOnly)
	self.isCalcAttr = false
	self.isCalcPower = false
	self.finalAttrs = {}
	self.totalAttr = {}
	self.baseTotalAttr = {}
	self.publicTotalAttr = {}
	self.withoutPercentTotalAttr = {}
	self.baseTotalAttr = AttrMo.addSameAttrs(self.baseAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.talentAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.awakenAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.decorationAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.equipAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.runeAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.extAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.petTeamAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.petSkinAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.petHoshigamiAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.petHolyStripesAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.petCutePetAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.starGodPlusAttr, self.baseTotalAttr)
	self.baseTotalAttr = AttrMo.addSameAttrs(self.petSourceTraceAttr, self.baseTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.assistAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.mountAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.petRelationAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.petThroneAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.handbookAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.animalAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.petGoodfellingAttr, self.publicTotalAttr)
	self.publicTotalAttr = AttrMo.addSameAttrs(self.formStrengthAttr, self.publicTotalAttr)
	self.totalAttr = AttrMo.addSameAttrs(self.baseTotalAttr, self.totalAttr)
	self.totalAttr = AttrMo.addSameAttrs(self.publicTotalAttr, self.totalAttr)
	self.withoutPercentTotalAttr = AttrMo.addSameAttrs(self.totalAttr, self.withoutPercentTotalAttr)

	if extOnly == true then
		-- block empty
	else
		local res = 1
		local petCo = MaterialMgr.getMatCfg(MatType.Pet, self.petMo.raceId)
		local awakenScfg = CharacterConfig.instance:getPetAwakenCostCfg(petCo.awakenCostStrategyId, self.petMo.awakeLevel)

		if awakenScfg then
			res = res + checknumber(awakenScfg.allPropertyWanPercent) / 10000
		end

		if not self.handBookPercentAttr then
			local handBook = {}

			if not self.animalPercentAttr then
				local animal = {}

				for k, v in pairs(self.totalAttr) do
					if k ~= GameEnum.AttrType.OriginalVigour then
						local next = BagModel.instance:getRelationPercentByMoAndType(self.petMo, k)
						local handbookV = checknumber(handBook[k])
						local animalV = checknumber(animal[k])

						self.totalAttr[k] = (k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed) and v * (res + next + handbookV + animalV) or v * (1 + next + handbookV + animalV)
					end
				end
			end
		end
	end
end

function AttrMo:calcFinalAttr()
	if self.isCalcAttr == false then
		self.isCalcAttr = true
		self._maxHp = self:calcMaxHp()
		self._physicalDefence = self:calcPhysicalDefence()
		self._magicDefence = self:calcMagicDefence()
		self._speed = self:calcSpeed()
		self._attack = self:calcAttack()
		self._hitRate = self:calcHitRate()
		self._dodgeRate = self:calcDodgeRate()
		self._strikeRate = self:calcStrikeRate()
		self._blockRate = self:calcBlockRate()
		self._criticalRate = self:calcCriticalRate()
		self._antiCriticalRate = self:calcAntiCriticalRate()
		self._originalVigourRate = self:calcOriginalVigourRate()
	end
end

function AttrMo:calcFightPower(onlyUseExtProperties)
	if self.isCalcPower == false then
		self.isCalcPower = true
		self._zdl = AttrMo.calcFightPowerByAttrs(self.finalAttrs)

		local zdl = 0
		local percent = 0
		local petMo = self.petMo

		if onlyUseExtProperties then
			if petMo then
				zdl = petMo.allPropertyExtZdl or 0
				percent = petMo.allPropertyExtZdlRate or 0
			end
		elseif petMo then
			local petCo = CharacterConfig.instance:getPetCo(petMo.raceId)

			if petCo then
				local strategyId = petCo.skillLevelStrategyId

				zdl, percent = AttrMo._getSkillZdlByType(zdl, percent, strategyId, GameEnum.SeverSkillType.NORMAL, petMo.normalSkillLv)
				zdl, percent = AttrMo:_getSkillZdlByType(percent, strategyId, GameEnum.SeverSkillType.ULTIMATE, petMo.ultimateSkillLv)
				zdl, percent = AttrMo:_getSkillZdlByType(percent, strategyId, GameEnum.SeverSkillType.PASSIVE, petMo.passiveSkillLv)
				zdl, percent = AttrMo:_getSkillZdlByType(percent, strategyId, GameEnum.SeverSkillType.PSYCHICED_NORMAL, petMo.psychicedNormalSkillLv)
				zdl, percent = AttrMo:_getSkillZdlByType(percent, strategyId, GameEnum.SeverSkillType.PSYCHICED_ULTIMATE, petMo.psychicedUltimateSkillLv)
				zdl = zdl + self:baseFormula(AttrMo.KEY_DIRECT_ZDL)
				percent = percent / 10000
			end
		end

		self._provideZdl = zdl
		self._provideZdlRate = percent
		self._zdl = math.round((self._zdl + self._provideZdl) * (1 + self._provideZdlRate))
	end

	return 0
end

function AttrMo._addValueToPorvide(zdl, percent)
	return
end

function AttrMo._getSkillZdlByType(zdl, percent, skillLevelStrategyId, skillType, skillLv)
	local cfg = CharacterConfig.instance:getSkillLevelCfgById(skillLevelStrategyId, skillType, skillLv)

	if cfg then
		zdl = zdl + cfg.skillProvideZdl
		percent = percent + cfg.skillWanPercent
	end

	return zdl, percent
end

function AttrMo.calcFightPowerByAttrs(attrsList)
	local power = 0

	if attrsList == nil then
		return power
	end

	for k, v in pairs(attrsList) do
		local attrStr = GameEnum.AttrTypeName[k]
		local value = CharacterConfig.instance:getPropZdlValue(attrStr)

		power = power + v * value
	end

	power = math.round(power)

	return power
end

function AttrMo:calcHitRate()
	local type = GameEnum.AttrType.HitRate
	local value = self.totalAttr[type]

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcDodgeRate()
	local type = GameEnum.AttrType.DodgeRate
	local value = self.totalAttr[type]

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcStrikeRate()
	local type = GameEnum.AttrType.StrikeRate
	local value = self.totalAttr[type]

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcBlockRate()
	local type = GameEnum.AttrType.BlockRate
	local value = self.totalAttr[type]

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcCriticalRate()
	local type = GameEnum.AttrType.CriticalRate
	local value = self.totalAttr[type]

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcAntiCriticalRate()
	local type = GameEnum.AttrType.AntiCriticalRate
	local value = self.totalAttr[type]

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcAntiCriticalRate()
	local type = GameEnum.AttrType.AntiCriticalRate
	local value = self.totalAttr[type]

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcOriginalVigourRate()
	local type = GameEnum.AttrType.OriginalVigour
	local value = self.totalAttr[type]

	value = math.round(value)
	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcMaxHp()
	local type = GameEnum.AttrType.Hp
	local typeRate = GameEnum.AttrType.HpRate
	local value = self:baseFormula(type, typeRate)

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcAttack()
	local type = GameEnum.AttrType.Attack
	local typeRate = GameEnum.AttrType.AttackRate
	local value = self:baseFormula(type, typeRate)

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcPhysicalAttack()
	local type = GameEnum.AttrType.AttackPhysical
	local typeRate = GameEnum.AttrType.AttackPhysicalRate
	local value = self:baseFormula(type, typeRate)

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcPhysicalDefence()
	local type = GameEnum.AttrType.DefensePhysical
	local typeRate = GameEnum.AttrType.DefensePhysicalRate
	local value = self:baseFormula(type, typeRate)

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcMagicAttack()
	local type = GameEnum.AttrType.AttackMagic
	local typeRate = GameEnum.AttrType.AttackMagicRate
	local value = self:baseFormula(type, typeRate)

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcMagicDefence()
	local type = GameEnum.AttrType.DefenseMagic
	local typeRate = GameEnum.AttrType.DefenseMagicRate
	local value = self:baseFormula(type, typeRate)

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcUltimateAttack()
	local type = GameEnum.AttrType.AttackSuper
	local typeRate = GameEnum.AttrType.AttackSuperRate
	local value = self:baseFormula(type, typeRate)

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcUltimateDefence()
	local type = GameEnum.AttrType.DefenseSuper
	local typeRate = GameEnum.AttrType.DefenseSuperRate
	local value = self:baseFormula(type, typeRate)

	self.finalAttrs[type] = value

	return value
end

function AttrMo:calcSpeed()
	local type = GameEnum.AttrType.Speed
	local typeRate = GameEnum.AttrType.SpeedRate
	local value = self:baseFormula(type, typeRate)

	self.finalAttrs[type] = value

	return value
end

function AttrMo:baseFormula(type, typeRate)
	local temp = checknumber(self.totalAttr[type])
	local tempR = checknumber(self.totalAttr[typeRate]) + 1
	local value = temp * tempR

	return math.round(value)
end

function AttrMo:getEquipmentAttr(petMo)
	local res = {}

	for k, tem in pairs(petMo.equipments or {}) do
		local id = tem.id
		local cfgId = checknumber(tem.defineId)
		local lvl = checknumber(tem.lv)
		local bonusRaceId = checknumber(tem.bonusRaceId)
		local equip

		if checknumber(id) > 0 then
			equip = PetEquipModel.instance:GetEquipInfo(id)

			if equip == nil then
				return {}
			end

			cfgId = equip:getDefineId()
			lvl = equip.starCount

			if bonusRaceId <= 0 then
				bonusRaceId = checknumber(equip.exclRaceId)
			end
		end

		local cfg = EquipmentConfig.instance:GetEquipDefineInfoById(cfgId)
		local equipInfo = EquipmentConfig.instance:GetEquipInfoByLvl(cfg.equipmentLvStrategy, lvl)
		local petCo = CharacterConfig.instance:getPetCo(petMo.raceId)
		local attrs

		if bonusRaceId > 0 and bonusRaceId == petMo.raceId then
			attrs = FightingPowerFormula.instance:parseAttrValues(equipInfo.racePropertyApp) or {}
			res = AttrMo.addSameAttrs(attrs, res)
		elseif PetSkinConfig.instance:checkHasEleAttr(petMo.curFaceId, cfg.additionRaceType) or AttrMo.checkHasYuanEle(petMo.curFaceId, cfg.additionRaceType) then
			attrs = FightingPowerFormula.instance:parseAttrValues(equipInfo.propertyApp2) or {}
			res = AttrMo.addSameAttrs(attrs, res)
		else
			attrs = FightingPowerFormula.instance:parseAttrValues(equipInfo.propertyApp) or {}
			res = AttrMo.addSameAttrs(attrs, res)
		end

		if cfg.quality == 10 then
			attrs = FightingPowerFormula.instance:parseAttrValues(equipInfo.propertyParam) or {}
			res = AttrMo.addSameAttrs(attrs, res)
		end

		res[AttrMo.KEY_DIRECT_ZDL] = checknumber(res[AttrMo.KEY_DIRECT_ZDL]) + equipInfo.numZdl
	end

	return res
end

function AttrMo.checkHasYuanEle(skinId, ele)
	if ele and type(ele) == "string" then
		ele = GameEnum.Races[ele]
	end

	if checknumber(ele) > 0 then
		local extInfo = PetSkinConfig.instance:getSkinAttrs(skinId)

		if extInfo then
			return extInfo.first_elementAttrIdx == GameEnum.RaceType.Yuan
		end

		printError(">>>>>>>>> AttrMo.checkHasYuanEle 对应的皮肤没配置属性数据：", skinId)
	end

	return false
end

function AttrMo:getMountAttr(petMo)
	if petMo.isMyPackPet then
		return MountModel.instance:getMountAttr()
	else
		local res = {}

		if petMo.mountInfo then
			if petMo.mountInfo.isMax and petMo.mountInfo.mounts == nil then
				return MountConfig.instance:getMaxAttr()
			else
				for k, info in pairs((not petMo.mountInfo.mounts or nil) and {}) do
					local cfg = MountConfig.instance:getAttrByPlanLvl(info.mountId, info.level)
					local attribute
					local var_51_1 = FightingPowerFormula.instance:parseAttrValues((cfg or nil) and cfg.attribute) or {}
				end
			end
		end

		return res
	end
end

function AttrMo:getRuneAttr(petMo)
	local res = {}

	if petMo.runeSuit then
		local suitId = petMo.runeSuit.runeSuitId
		local slots = petMo.runeSuit.slots
		local totalStar = 0

		if petMo.isMyPackPet then
			local suitMo = RuneModel.instance:getSuitMo(suitId)

			if suitMo then
				local arr = suitMo:getExtProps()

				totalStar = suitMo:getTotalStar()

				local tem = {}

				for k, v in pairs(arr) do
					if v.value >= 0 then
						table.insert(tem, v.name .. "+" .. v.value)
					else
						table.insert(tem, v.name .. v.value)
					end
				end

				local var_52_0 = FightingPowerFormula.instance:parseAttrValues(table.concat(tem, "#")) or {}
			end
		elseif slots then
			for k, v in pairs(slots) do
				totalStar = totalStar + v.level

				local runeCfg = RuneConfig.instance:getRuneLvlCfg(v.defineId, v.level)

				if runeCfg then
					local var_52_1 = FightingPowerFormula.instance:parseAttrValues(runeCfg.propertyApp) or {}
				end
			end
		end

		if suitId and suitId > 0 then
			local cf = RuneConfig.instance:getSuitEffById(suitId)

			if cf then
				local arr = {}

				for k, v in pairs(cf) do
					table.insert(arr, v)
				end

				ArraySort.sortOn(arr, {
					"needLevel"
				})

				for i = #arr, 1, -1 do
					if totalStar >= arr[i].needLevel then
						local var_52_2 = FightingPowerFormula.instance:parseAttrValues(arr[i].propertyApp) or {}
					end
				end
			end
		end
	end

	::label_52_0::

	return res
end

function AttrMo:getAwakenAttr(petMo)
	local petCo = CharacterConfig.instance:getPetCo(petMo.raceId)
	local res = {}

	for i = 0, checknumber(petMo.awakeLevel) do
		local cfg = CharacterConfig.instance:getPetAwakenStrategyCfg(petCo.awakenStrategyId, i)

		if cfg then
			local var_53_0 = FightingPowerFormula.instance:parseAttrValues(cfg.propertyParam) or {}
		end
	end

	return res
end

function AttrMo:getCurrStrengthAttr()
	local res = {}
	local map = FormationNewModel.instance:getAllFormStrengthInfo()

	for k, v in pairs(map or {}) do
		local cfg = BattleConfig.instance:getFormStrengthLvCfg(v.formStrengthId, v.formStrengthLv)

		if cfg then
			local var_54_0 = FightingPowerFormula.instance:parseAttrValues(cfg.passiveProperties) or {}
		end
	end

	return res
end

function AttrMo:getFormStrengthAttr(petMo)
	local res

	if petMo.isMyPackPet then
		res = self:getCurrStrengthAttr()
	else
		res = {}

		if petMo.formStrength and petMo.formStrength.formStrengths then
			for i, v in ipairs(petMo.formStrength.formStrengths) do
				local cfg = BattleConfig.instance:getFormStrengthLvCfg(v.formStrengthId, v.formStrengthLv)

				if cfg then
					local var_55_0 = FightingPowerFormula.instance:parseAttrValues(cfg.passiveProperties) or {}
				end
			end
		end
	end

	return res
end

function AttrMo:getPetSkinAttr(petMo)
	local skinId = petMo.curFaceId
	local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
	local res = {}

	if cfg then
		local var_56_0 = FightingPowerFormula.instance:parseAttrValues(cfg.propertyApp) or {}
	end

	return res
end

function AttrMo:getTalentAttr(petMo)
	local res = {}
	local cfg = CharacterConfig.instance:getPetTalentCfg(petMo.raceId, petMo.talentLevel)

	if cfg then
		local var_57_0 = FightingPowerFormula.instance:parseAttrValues(cfg.levelProps) or {}
	end

	return res
end

function AttrMo:getBaseAttr(propertyStrategyId, level)
	local cfg = CharacterConfig.instance:getPetLvlStrategyCoByLvl(propertyStrategyId, level)
	local baseAttr = {}

	if cfg then
		baseAttr[GameEnum.AttrType.Hp] = cfg.hp
		baseAttr[GameEnum.AttrType.Attack] = cfg.Atk
		baseAttr[GameEnum.AttrType.DefensePhysical] = cfg.phyDef
		baseAttr[GameEnum.AttrType.DefenseMagic] = cfg.magDef
		baseAttr[GameEnum.AttrType.Speed] = cfg.speed
		baseAttr[GameEnum.AttrType.SpeedRate] = 0
		baseAttr[GameEnum.AttrType.HitRate] = cfg.hitRate
		baseAttr[GameEnum.AttrType.DodgeRate] = cfg.dodgeRate
		baseAttr[GameEnum.AttrType.StrikeRate] = cfg.strikeRate
		baseAttr[GameEnum.AttrType.BlockRate] = cfg.blockRate
		baseAttr[GameEnum.AttrType.CriticalRate] = cfg.criticalRate
		baseAttr[GameEnum.AttrType.AntiCriticalRate] = cfg.antiCriticalRate
	elseif self.petMo then
		printError(">>>不存在配置 raceId:%s, skinId:%s, propertyStrategyId:%s, level:%s (export_升级属性方案  in  j精灵额外信息.xlsx)", self.petMo.raceId, self.petMo.curFaceId, propertyStrategyId, level)
	end

	return baseAttr
end

function AttrMo.addSameAttrs(fromAttrs, toAttrs)
	toAttrs = toAttrs or {}

	if fromAttrs then
		for k, v in pairs(fromAttrs) do
			toAttrs[k] = checknumber(toAttrs[k]) + checknumber(v)
		end
	end

	return toAttrs
end

function AttrMo:compare(attrMo)
	self:traceAttr(self.baseAttr, attrMo.baseAttr, "等级-基础")
	self:traceAttr(self.talentAttr, attrMo.talentAttr, "天赋")
	self:traceAttr(self.awakenAttr, attrMo.awakenAttr, "觉醒")
	self:traceAttr(self.equipAttr, attrMo.equipAttr, "装备")
	self:traceAttr(self.assistAttr, attrMo.assistAttr, "助战")
	self:traceAttr(self.mountAttr, attrMo.mountAttr, "坐骑")
	self:traceAttr(self.petTeamAttr, attrMo.petTeamAttr, "上阵羁绊")
	self:traceAttr(self.petRelationAttr, attrMo.petRelationAttr, "收集羁绊")
	self:traceAttr(self.petThroneAttr, attrMo.petThroneAttr, "神器")
	self:traceAttr(self.petSkinAttr, attrMo.petSkinAttr, "皮肤")
	self:traceAttr(self.petGoodfellingAttr, attrMo.petGoodfellingAttr, "好感度")
	self:traceAttr(self.starGodPlusAttr, attrMo.starGodPlusAttr, "星神")
	self:traceAttr(self.handbookAttr, attrMo.handbookAttr, "图鉴")
	self:traceAttr(self.handBookPercentAttr, attrMo.handBookPercentAttr, "图鉴P")
	self:traceAttr(self.formStrengthAttr, attrMo.formStrengthAttr, "阵法")
	self:traceAttr(self.animalAttr, attrMo.animalAttr, "宠物园")
	self:traceAttr(self.animalPercentAttr, attrMo.animalPercentAttr, "宠物园P")
	self:traceAttr(self.decorationAttr, attrMo.decorationAttr, "饰品")
	self:traceAttr(self.petHoshigamiAttr, attrMo.petHoshigamiAttr, "御魂")
	self:traceAttr(self.petHolyStripesAttr, attrMo.petHolyStripesAttr, "灵纹")
	self:traceAttr(self.petCutePetAttr, attrMo.petCutePetAttr, "萌宠")
	self:traceAttr(self.petSourceTraceAttr, attrMo.petSourceTraceAttr, "源迹养成")
	self:traceAttr(self.extAttr, attrMo.extAttr, "额外")
	self:traceAttr(self.totalAttr, attrMo.totalAttr, "总属性")
end

function AttrMo:traceAttr(attr1, attr2, name)
	if attr1 and attr2 then
		local map = {}

		for k, v in pairs(attr1) do
			map[k] = map[k] or {}
			map[k][1] = v
		end

		for k, v in pairs(attr2) do
			map[k] = map[k] or {}
			map[k][2] = v
		end

		print(">>>>>>>>>>>>>>>>>>>>>>>>>>====@@@@@@@@@@@@@@@@===>>>>>>>>>>>>>>>>>>>>>>>>>>>> ", name)

		for k, arr in pairs(map) do
			local a = checknumber(arr[1])
			local b = checknumber(arr[2])
			local value = a - b
			local name = ConstString.Attr[k]

			if k == AttrMo.KEY_DIRECT_ZDL then
				name = "纯战力"
			end

			if value == 0 then
				print(">>>>>>>>>>>", name, k, "pet:[", arr[1], "] max:[", arr[2], "]")
			elseif value > 0 then
				print(">>>>>>>>>>>", name, k, "<color='#00ff00'>pet:[", arr[1], "]</color> <color='#ff00ff'> max:[", arr[2], "]</color>")
			else
				print(">>>>>>>>>>>", name, k, "<color='#ff00ff'>pet:[", arr[1], "]</color> <color='#00ff00'> max:[", arr[2], "]</color>")
			end
		end
	end
end

AttrMo.instance = AttrMo.New()

return AttrMo
