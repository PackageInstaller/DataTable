-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\Hero.lua

local ResHeroRecharge = require("ClientData/ResHeroRecharge")
local BaseObject = require("Common/Object/BaseObject")
local Relic = require("Common/Object/Relic")
local ResHero = require("ClientData/ResHero")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local ResStar = require("ClientData/ResStar")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local HeroSkill = require("Common/Object/HeroSkill")
local EmptyProp = require("Entity/EmptyProp")
local PropBoard = require("ClientData/PropBoard")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")
local ResHeroPassiveConfig = require("ClientData/ResHeroPassiveConfig")
local ResStep = require("ClientData/ResStep")
local ResStepDes = require("ClientData/ResStepDes")
local ResColor = require("ClientData/ResColor")
local ResEquipRecSuit = require("ClientData/ResEquipRecSuit")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResItemHeroBase = require("ClientData/ResItemHeroBase")
local ResDevelopPlot = require("ClientData/ResDevelopPlot")
local ResDevelopUnlock = require("ClientData/ResDevelopUnlock")
local ResDevelopMisc = require("ClientData/ResDevelopMisc")
local ResDevelopConf = require("ClientData/ResDevelopConf")
local ResDevelopCost = require("ClientData/ResDevelopCost")
local ResRelationLetterName = require("ClientData/ResRelationLetterName")
local ResDevelopDesc = require("ClientData/ResDevelopDesc")
local ResHeroBanEquipPropType = require("ClientData/ResHeroBanEquipPropType")
local ResEquipTowerCustomEquipEffect = require("ClientData/ResEquipTowerCustomEquipEffect")
local ResVoidHero = require("ClientData/ResVoidHero")
local ResEquipQuality = require("ClientData/ResEquipQuality")
local ResVowMisc = require("ClientData/ResVowMisc")
local ResHeroNewPaint = require("ClientData/ResHeroNewPaint")
local isOfflineHero = NO_CSHARP
local ResPaintRelate = require("ClientData/ResPaintRelate")
local ResHeroPaint = require("ClientData/ResHeroPaint")
local ResSeasonRelicOp = require("ClientData/ResSeasonRelicOp")
local ResSeasonRelicShow = require("ClientData/ResSeasonRelicShow")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local RELATION_NNKNOWN_ICONATH = {
	[Const.RELATION_DESC_LETTER] = {
		"Atlas/CommonAtlas/IconAtlas/ShowRoomAticleAtlas/ShowRoomAticleAtlas01",
		"IconLockBook"
	},
	[Const.RELATION_DESC_ITEM] = {
		"Atlas/CommonAtlas/IconAtlas/ShowRoomAticleAtlas/ShowRoomAticleAtlas05",
		"IconLockBox"
	},
	[Const.RELATION_DESC_AVG] = {
		"Atlas/CommonAtlas/IconAtlas/ShowRoomAticleAtlas/ShowRoomAticleAtlas07",
		"CDdis"
	},
	[Const.RELATION_DESC_VOW] = {
		"Atlas/CommonAtlas/IconAtlas/ShowRoomAticleAtlas/ShowRoomAticleAtlas06",
		"IconBookDis"
	}
}
local RELATION_TEAM_COLOR = {
	{
		124,
		159,
		255
	},
	{
		255,
		222,
		73
	},
	{
		225,
		182,
		193
	},
	{
		201,
		175,
		255
	},
	{
		255,
		159,
		110
	},
	{
		112,
		229,
		221
	}
}
local strClassName = "Hero"
local Hero = Class(strClassName, BaseObject)

function Hero:ctor(data)
	return
end

function Hero:_initData()
	Hero.super._initData(self)

	self.gid = self._serverData.gid or ""
	self.id = self._serverData.resid or 0
	self.resData = ResHero[self.id]

	if not self.resData then
		-- block empty
	end

	self.name = self.resData.hero_name or ""
	self.fullName = self.resData.full_name or ""
	self.careerName = Const.CAREER_CONFIG[self.resData.career].name
	self.groupName = Const.CAMP_CONFIG[self.resData.camp].name
	self.isFront = self.resData.attack_range == 1
	self.career = self.resData.career
	self.quality = self.resData.quality
	self.camp = self.resData.camp
	self.team = self.resData.belong_team or 0
	self.banStarMaterial = self.resData.ban_star_material or 0
	self.seasonRelicId = self.resData.season_relic_id or 0

	if self.camp == Const.CAMP_TYPE.SLIM_SNOW or self.camp == Const.CAMP_TYPE.NINE_NIGHT then
		self.specialCamp = self.resData.belong_camp
	end

	self.star = self._serverData.star or self.resData.ori_star
	self.level = self._serverData.level or 1
	self.realLevel = self._serverData.level or 1
	self.step = self._serverData.step or 0
	self.wake = self._serverData.wake or 0
	self.recharge = self.step
	self.lock = self._serverData.lock or 0
	self.skin = self._serverData.skin or 0
	self.base = self._serverData.base or 0
	self.crystalSecondLevel = self._serverData.crystal_level or 0
	self.starUpPriority = self.resData.star_up_priority or 1
	self.heroSkinData = ResItemHeroSkin[self.id]
	self.modelData = utils.getCommonModelData(self:getShowModelId())

	self:initStep()
	self:initEquipInfo()

	self.artifactGid = self._serverData.artifact
	self.relicId = self._serverData.relic
	self.inTeam = 0
	self.mazeStatus = 0
	self.mazeHpStep = 0.1
	self.isCryPriests = 0
	self.isCrySlot = 0
	self.inCry = 0
	self.itemType = Const.ITEM_TYPE_HERO
	self.resDevelopPlotData = ResDevelopPlot[self.id]
	self.resDevelopUnlockData = ResDevelopUnlock[self.id]

	if self.resDevelopUnlockData then
		self.resDevelopConfData = ResDevelopConf[self.resDevelopUnlockData.develop_id]
	end

	self.otherCrystalStep = 0
	self.otherCrystalType = 0
end

function Hero:setSkin(skinId)
	if self._serverData then
		self._serverData.skin = skinId
	end

	self.skin = skinId
	self.modelData = utils.getCommonModelData(self:getShowModelId())
end

function Hero:setBase(baseId)
	if self._serverData then
		self._serverData.base = baseId
	end

	self.base = baseId
end

function Hero:setMazeAttr(hp)
	self.mazeHp = hp or 10000
	self.mazeHpStep = math.ceil(self.mazeHp / 100)

	if self.mazeHp <= 0 then
		self.mazeStatus = 1
	else
		self.mazeStatus = 2
	end
end

function Hero:isLightOrDark()
	return utils.campIsLightOrDark(self.camp)
end

function Hero:notLimitedHero()
	return self.resData.launch == 1
end

function Hero:isRelatedHero()
	return ResVoidHero[self.id] ~= nil
end

function Hero:isUniqueHero()
	return Const.UNIQUE_HERO[self.id] ~= nil
end

function Hero:getRelatedHero()
	local relateData = Const.UNIQUE_HERO[self.id]

	if relateData then
		return CurAvatar:getHeroMaxStarHero(relateData.resid)
	end
end

function Hero:resetMazeAttr(...)
	self.mazeHp = nil
	self.mazeHpStep = 0.1
	self.mazeStatus = 0
end

function Hero:initStep()
	self.battleStep = math.min(self.step, self:getLvMaxStep())
	self.recharge = self.battleStep

	self:refreshSkillInfo()
end

function Hero:getLvMaxStep()
	local lvMaxStep = 0

	for step, stepInfo in ipairs(ResStep) do
		if self.level < stepInfo.level_limit then
			break
		else
			lvMaxStep = step
		end
	end

	return lvMaxStep
end

function Hero:isMyHero(...)
	if not isOfflineHero and CurAvatar and CurAvatar.heroDic then
		return CurAvatar.heroDic[self.gid] ~= nil
	end

	return false
end

function Hero:initCrystalData()
	self.isCryPriests = self:isCrystalPriests() and 1 or 0
	self.isCrySlot = self:isCrystalSlot() and 1 or 0
	self.inCry = (self:isCrystalPriests() or self:isCrystalSlot()) and 1 or 0
	self.realLevel = self._serverData.level or 1

	if not isOfflineHero and CurAvatar and CurAvatar.crystalData then
		if self.isCrySlot == 1 then
			self.crystalLevel = math.min(CurAvatar.crystalData.level, self:getMaxLv())
			self.crystalSecondLevel = CurAvatar.crystalNewLevel or 0
		else
			self.crystalLevel = self.realLevel
			self.crystalSecondLevel = self._serverData.crystal_level or 0
		end
	else
		self.crystalLevel = 1
	end

	if self.isCryPriests == 1 then
		self.crystalSecondLevel = CurAvatar.crystalNewLevel or 0
	end

	self.level = math.max(self.realLevel, self.crystalLevel)

	self:initStep()
end

function Hero:setCrystalStoryData(crystalMaxLevel, storyUnlockDic)
	self.crystalMaxLevel = crystalMaxLevel or self.crystalMaxLevel
	self.storyUnlockDic = storyUnlockDic or self.storyUnlockDic
end

function Hero:isCrystalPriests()
	if not self:isMyHero() then
		return self.otherCrystalType == Const.TYPE_CRYSTAL_PRIESTS
	elseif not isOfflineHero and CurAvatar and CurAvatar.crystalPriestsDic then
		return CurAvatar.crystalPriestsDic[self.gid] ~= nil
	else
		return false
	end
end

function Hero:isCrystalSlot()
	if not self:isMyHero() then
		return self.otherCrystalType == Const.TYPE_CRYSTAL_SYMPATHIZER
	elseif not isOfflineHero and CurAvatar and CurAvatar.crystalSlotDic then
		return CurAvatar.crystalSlotDic[self.gid] ~= nil
	else
		return false
	end
end

function Hero:getCrystalStep(...)
	if not self:isMyHero() then
		return self.otherCrystalStep
	elseif not isOfflineHero and CurAvatar and CurAvatar.crystalData then
		return CurAvatar.crystalData.step
	else
		return 1
	end
end

function Hero:getFakeCrystalLevel(...)
	local level = 1

	if not isOfflineHero and CurAvatar and CurAvatar.crystalData then
		level = math.max(math.min(CurAvatar.crystalData.level, self:getMaxLv()), self.realLevel)
	end

	return level
end

function Hero:getFakeCrystalSecondLevel()
	if not isOfflineHero and CurAvatar and CurAvatar.crystalData then
		return CurAvatar.crystalNewLevel
	end
end

function Hero:getFakeCrystalColor(...)
	local slotColor = ResColor.LVGONGMING

	return slotColor
end

function Hero:getShowLv()
	if not self:isMyHero() then
		return self.realLevel or self.level
	else
		return self.level
	end
end

function Hero:getLvColor(campColorDic)
	local slotColor = ResColor.LVGONGMING

	if self:isMyHero() then
		if not isOfflineHero and CurAvatar and self:isCrystalPriests() and CurAvatar:isCrystalOpened() then
			return ResColor.LVGONGM2
		elseif not isOfflineHero and CurAvatar and self:isCrystalSlot() and CurAvatar:isCrystalOpened() then
			return slotColor
		end
	elseif self:isCrystalPriests() then
		return ResColor.LVGONGM2
	elseif self:isCrystalSlot() then
		return slotColor
	end

	if campColorDic then
		return campColorDic[self.camp]
	else
		return ResColor.WHITE
	end
end

function Hero:isFullHp(...)
	return self.mazeHp == 10000
end

function Hero:refreshSkillInfo()
	if self.resData.attack_id then
		self.skillBase = HeroSkill(self.resData.attack_id, utils.calHeroSkillLevel(self, Const.HERO_SKILL_FIELD.ATTACK), Const.HERO_SKILL_FIELD.ATTACK)
	end

	if self.resData.skill_id then
		self.skillLast = HeroSkill(self.resData.skill_id, utils.calHeroSkillLevel(self, Const.HERO_SKILL_FIELD.SKILL), Const.HERO_SKILL_FIELD.SKILL)
	end

	if self.resData.enter_passive then
		self.skillPassive1 = HeroSkill(self.resData.enter_passive, utils.calHeroSkillLevel(self, Const.HERO_SKILL_FIELD.ENTER_PASSIVE), Const.HERO_SKILL_FIELD.ENTER_PASSIVE)
	end

	if self.resData.hero_passive then
		self.skillPassive2 = HeroSkill(self.resData.hero_passive, utils.calHeroSkillLevel(self, Const.HERO_SKILL_FIELD.HERO_PASSIVE), Const.HERO_SKILL_FIELD.HERO_PASSIVE)
	end
end

function Hero:getSkillTotalLevel()
	local skillLevel = 0

	if self.skillBase then
		skillLevel = skillLevel + self.skillBase.level
	end

	if self.skillLast then
		skillLevel = skillLevel + self.skillLast.level
	end

	if self.skillPassive1 then
		skillLevel = skillLevel + self.skillPassive1.level
	end

	if self.skillPassive2 then
		skillLevel = skillLevel + self.skillPassive2.level
	end

	return skillLevel
end

function Hero:getBgSpritePath()
	return UIConst.getHeroCardBgByCamp(self.camp)
end

function Hero:initEquipInfo()
	self.equipList = {}

	if self._serverData and self._serverData.equip then
		for i, v in ipairs(self._serverData.equip) do
			if v.gid ~= "0" then
				table.insert(self.equipList, v)
			end
		end
	end
end

function Hero:getEquipGidList()
	local gidList = {}

	for i, v in ipairs(self.equipList) do
		table.insert(gidList, v.gid)
	end

	return gidList
end

function Hero:setEquipGidList(gidList)
	local bagEquips = self.wearDic ~= nil and self.wearDic.equips or nil

	if not bagEquips and CurAvatar then
		bagEquips = CurAvatar.bagEquips
	end

	self.equipList = {}

	for _, equipGid in ipairs(gidList) do
		if bagEquips[equipGid] then
			local gidStruct = {}

			gidStruct.gid = equipGid

			table.insert(self.equipList, gidStruct)

			bagEquips[equipGid].inWearing = self.gid
		end
	end
end

function Hero:offAllEquips(ignoreArtifact, ignoreRelic)
	if self.equips then
		self.equips = nil
	end

	if self._serverData and self._serverData.equip then
		self._serverData.equip = {}
	end

	self.equipList = {}

	if not ignoreArtifact then
		if self.artifact then
			self.artifact = nil
		end

		if self.artifactGid then
			self.artifactGid = 0
			self._serverData.artifact = 0
		end
	end

	if not ignoreRelic then
		if self.relic then
			self.relic = nil
		end

		if self.relicId then
			self.relicId = 0
			self._serverData.relic = 0
		end
	end
end

function Hero:initTeamInfo()
	local formationIndex

	if CurAvatar then
		formationIndex = CurAvatar:heroInBattle(self.gid)
	end

	if not isOfflineHero and CurAvatar and (formationIndex or CurAvatar.asyncPVPDefendFormation[self.gid]) then
		self.inTeam = 1

		if formationIndex then
			self.formationIndex = formationIndex
		else
			self.formationIndex = Const.FORMATION_ASYNC_DEFEND
		end
	else
		self.inTeam = 0
	end
end

function Hero:getIconPath(isHead)
	if self.modelData then
		if isHead and self.modelData.head_path and self.modelData.head_name then
			return {
				"Atlas/" .. self.modelData.head_path,
				self.modelData.head_name
			}
		end

		if not isHead and self.modelData.icon_path and self.modelData.icon_name then
			return {
				"Atlas/" .. self.modelData.icon_path,
				self.modelData.icon_name
			}
		end
	end
end

function Hero:getQIconPath()
	if self.modelData and self.modelData.q_icon_path and self.modelData.q_icon_name then
		return {
			"Atlas/" .. self.modelData.q_icon_path,
			self.modelData.q_icon_name
		}
	end
end

function Hero:getPortraitIconPath()
	if self.modelData and self.modelData.portrait_atlas and self.modelData.portrait_sprite then
		return {
			"Atlas/" .. self.modelData.portrait_atlas,
			self.modelData.portrait_sprite
		}
	end
end

function Hero:getStepBgPath()
	local stepImgIdx = ResStarUpCondition[self.star].step_img_idx or 1

	return UIConst.HERO_CARD_SPRITE_BY_STEP[stepImgIdx]
end

function Hero:getStepPath()
	if self.step > 0 then
		local stageSpriteName = self.step < 10 and "TxtStage0" or "TxtStage"

		return {
			"Atlas/HeroAtlas/HeroCardCommonAtlas",
			stageSpriteName .. self.step
		}
	end
end

function Hero:isURHero()
	return self:getQuality() == Const.HERO_QUALITY_SS
end

function Hero:getQuality()
	if self.resData and self.resData.quality then
		return self.resData.quality
	end
end

function Hero:getQualityPath(isLogo)
	if self.resData and self.resData.quality then
		if isLogo then
			return UIConst.HERO_QUALITY_LOGO_CONFIG[self.resData.quality]
		else
			return UIConst.HERO_QUALITY_CONFIG[self.resData.quality]
		end
	end
end

function Hero:getStepImgPath()
	local stepImgIdx = ResStarUpCondition[self.star].step_img_idx or 1

	return UIConst.HERO_QUALITY_HEAD_CONFIG[stepImgIdx]
end

function Hero:getStepIdx()
	return ResStarUpCondition[self.star].step_img_idx or 1
end

function Hero:getCareerPath()
	if self.resData and self.resData.career then
		return UIConst.getHeroCareerIconPath(self.resData.career)
	end
end

function Hero:getGragCareerPath()
	if self.resData and self.resData.career then
		return {
			"Atlas/HeroAtlas/HeroCardCommonAtlas",
			"IconCareerW0" .. (self.resData.career or 0)
		}
	end
end

function Hero:getGroupPath()
	if self.resData and self.resData.camp then
		return UIConst.getHeroCampIconPath(self.resData.camp)
	end
end

function Hero:getGroupLargePath()
	if self.resData and self.resData.camp then
		local camp = self.resData.camp

		if camp == Const.CAMP_TYPE.SLIM_SNOW or camp == Const.CAMP_TYPE.NINE_NIGHT then
			return {
				"Atlas/OtherBattleAtlas/EquipTowerAtlas2",
				"IconGroupL0" .. camp
			}
		else
			return {
				"Atlas/OtherBattleAtlas/EquipTowerAtlas",
				"IconGroupL0" .. camp
			}
		end
	end
end

function Hero:getGroupTeamPath()
	if self.team and self.team > 0 then
		return UIConst.getHeroGroupTeamIconPath(self.team)
	end
end

function Hero:getTeamPath()
	if self.resData and self.resData.camp then
		return {
			"Atlas/TeamSetAtlas/TeamSetAtlas",
			"BgGroup0" .. self.resData.camp
		}
	end
end

function Hero:setWearDic(wearDic)
	self.wearDic = wearDic
end

function Hero:setEquips(equips, artifact, relic)
	self.equips = equips
	self.artifact = artifact
	self.relic = relic
end

function Hero:setSkinData(data)
	self.skinAttrData = data
end

function Hero:getEquips()
	if self.equips then
		return self.equips
	end

	if self:isMyHero() and self.equipList then
		local equips = {}
		local bagEquips = self.wearDic ~= nil and self.wearDic.equips or nil

		if not bagEquips and CurAvatar then
			bagEquips = CurAvatar.bagEquips
		end

		for _, equipGid in ipairs(self.equipList) do
			if bagEquips and bagEquips[equipGid.gid] and bagEquips[equipGid.gid].inRecycling ~= Const.EQUIP_STATE_RECYCLE then
				local tempEquip = bagEquips[equipGid.gid]
				local subType = tempEquip.subType

				equips[subType] = tempEquip
			end
		end

		return equips
	end
end

function Hero:getArtifactRankScore()
	local artifact = self:getArtifact()
	local rankScore = artifact ~= nil and artifact.rankScore or 0

	return rankScore
end

function Hero:getEquipBySubType(subType)
	if self.equipList then
		for _, equipGid in ipairs(self.equipList) do
			if CurAvatar then
				local equip = CurAvatar.bagEquips[equipGid.gid]

				if equip.subType == subType then
					return equip
				end
			else
				break
			end
		end
	end
end

function Hero:getSuits()
	local equips = self:getEquips()
	local suits = {}

	if equips then
		local tempSuitInfo = {}

		for _, equip in pairs(equips) do
			tempSuitInfo[equip.suitId] = tempSuitInfo[equip.suitId] ~= nil and tempSuitInfo[equip.suitId] + 1 or 1
		end

		for suitId, count in pairs(tempSuitInfo) do
			local needNum = ResEquipSuit[suitId] ~= nil and ResEquipSuit[suitId].need_num or 99
			local suitCount = math.floor(count / needNum)

			if suitCount > 0 then
				for i = 1, suitCount do
					table.insert(suits, suitId)
				end
			end
		end
	end

	return suits
end

function Hero:getSpeSuitCounts()
	local speSuits = {}
	local equips = self:getEquips()

	if equips then
		for _, equip in pairs(equips) do
			if equip:isDefineHeroEquip() and equip:getDefineHeroId() == self.id then
				if not speSuits[equip.resDefineEffctData[1].effect_id] then
					speSuits[equip.resDefineEffctData[1].effect_id] = {}
				end

				table.insert(speSuits[equip.resDefineEffctData[1].effect_id], equip)
			end
		end
	end

	return speSuits
end

function Hero:getActiveSpeSuitsInfo()
	local activeSuitsInfo
	local speSuits = self:getSpeSuitCounts()

	for effectId, effectEquipList in pairs(speSuits) do
		for effectLv, effectInfo in ipairs(ResEquipTowerCustomEquipEffect[effectId]) do
			local effectEquipListNum = #effectEquipList

			effectEquipListNum = self:getRealSpeSuitCounts(effectEquipList, #effectEquipList)

			if effectEquipListNum >= effectInfo.num then
				activeSuitsInfo = effectInfo
			end
		end
	end

	return activeSuitsInfo
end

function Hero:getRealSpeSuitCounts(speSuitsByEffectId, speSuitsNum)
	local realSpeSuitsNum = speSuitsNum

	if Const.EQUIP_BUILD_OPEN then
		table.sort(speSuitsByEffectId, function(a, b)
			if a.buildQuality ~= nil and a.buildQuality ~= nil == (b.buildQuality ~= nil) then
				return a.buildQuality < b.buildQuality
			end

			return false
		end)

		for i, equip in ipairs(speSuitsByEffectId) do
			if equip.buildQuality and ResEquipQuality[equip.buildQuality] and realSpeSuitsNum > ResEquipQuality[equip.buildQuality].exclusive_num then
				realSpeSuitsNum = realSpeSuitsNum - 1
			end
		end
	end

	return realSpeSuitsNum
end

function Hero:getArtifact()
	if self.artifact then
		return self.artifact
	end

	local bagArtifacts = self.wearDic ~= nil and self.wearDic.artifacts or nil

	if not bagArtifacts and CurAvatar then
		bagArtifacts = CurAvatar.bagArtifacts
	end

	if self:isMyHero() and bagArtifacts and self.artifactGid then
		return bagArtifacts[self.artifactGid]
	end
end

function Hero:getRelic()
	if self.relic then
		return self.relic
	end

	local bagRelics = self.wearDic ~= nil and self.wearDic.relics or nil

	if not bagRelics and CurAvatar then
		bagRelics = CurAvatar.bagRelics
	end

	if self:isMyHero() and bagRelics and self.relicId then
		return bagRelics[self.relicId]
	end
end

function Hero:setStickData(stick)
	self.stickData = stick
end

function Hero:getStickData()
	if self.stickData then
		return self.stickData
	end

	if self:isMyHero() and CurAvatar then
		local stickData = CurAvatar:getStickDataByHeroId(self.id)

		return stickData
	end
end

function Hero:getSkinData()
	if self.skinAttrData and self.skinAttrData.skin then
		return self.skinAttrData.skin
	end

	if self:isMyHero() and CurAvatar then
		local skinAttrData = CurAvatar:getSkinDataByHeroId(self.id)

		if skinAttrData and skinAttrData.skin then
			return skinAttrData.skin
		end
	end
end

function Hero:getBaseData()
	if self.skinAttrData and self.skinAttrData.base then
		return self.skinAttrData.base
	end

	if self:isMyHero() and CurAvatar then
		local skinAttrData = CurAvatar:getSkinDataByHeroId(self.id)

		if skinAttrData and skinAttrData.base then
			return skinAttrData.base
		end
	end
end

function Hero:setPaintLv(paintLv)
	local paintData = utils.getPaintData(self.id, paintLv)

	self:setPaintData(paintData)
end

function Hero:setPaintData(paintData)
	self.paintData = paintData
end

function Hero:getPaintLevel()
	local paintData = self:getPaintData()

	if paintData and paintData.level then
		return paintData.level
	end

	return 0
end

function Hero:getPaintData()
	if self.paintData then
		return self.paintData
	end

	if not isOfflineHero and CurAvatar and self:isMyHero() then
		local paintData = CurAvatar:getPaintDataByHeroId(self.id)

		if paintData then
			return paintData
		end
	end
end

function Hero:getPaintPath(paintImgType, _paintData)
	if CurAvatar then
		local paintData = _paintData or self:getPaintData()

		if paintData and paintData.resData and paintData.resData.card_show_id ~= 0 then
			if paintImgType == Const.PAINT_HERO_CARD then
				return {
					"Atlas/HeroAtlas/HeroCoatingAtlas",
					"CoatingImg0" .. paintData.resData.card_show_id
				}
			elseif paintImgType == Const.PAINT_HERO_BASEPANEL then
				return {
					"Atlas/HeroAtlas/HeroCoatingAtlas",
					"CoatingImgH0" .. paintData.resData.card_show_id
				}
			elseif paintImgType == Const.PAINT_HERO_HEAD then
				return {
					"Atlas/HeroAtlas/HeroCoatingAtlas",
					"CoatingImgName0" .. paintData.resData.card_show_id
				}
			elseif paintImgType == Const.PAINT_HERO_GRID then
				return {
					"Atlas/HeroAtlas/HeroCoatingAtlas",
					"CoatingImgC0" .. paintData.resData.card_show_id
				}
			end
		end
	end
end

function Hero:getPaintEfxPath(paintImgType, _paintData)
	if CurAvatar then
		local paintData = _paintData or self:getPaintData()

		if paintData and paintData.resData and paintData.resData.card_efx_id ~= 0 then
			if paintImgType == Const.PAINT_HERO_CARD then
				return "Effects/UI/efx_ui_Cards_Card1_" .. paintData.resData.card_efx_id .. ".prefab"
			elseif paintImgType == Const.PAINT_HERO_BASEPANEL then
				return "Effects/UI/efx_ui_Cards_Card3_" .. paintData.resData.card_efx_id .. ".prefab"
			elseif paintImgType == Const.PAINT_HERO_HEAD then
				return "Effects/UI/efx_ui_Cards_Card4_" .. paintData.resData.card_efx_id .. ".prefab"
			elseif paintImgType == Const.PAINT_HERO_GRID then
				return "Effects/UI/efx_ui_Cards_Card2_" .. paintData.resData.card_efx_id .. ".prefab"
			end
		end
	end
end

function Hero:getPaintMaterialRadio()
	if ResStar[self.resData.star_prop_id] and ResStar[self.resData.star_prop_id][self.star] and self.resData.can_sell and self.resData.can_sell == 2 then
		return ResStar[self.resData.star_prop_id][self.star].recovery_ratio or 10000
	else
		return 10000
	end
end

function Hero:getPaintPlusMaterialResData()
	if ResHero[self.id].new_paint_id then
		local id = ResHero[self.id].new_paint_id

		if id and ResHeroNewPaint[id] then
			return ResHeroNewPaint[id]
		end
	end
end

function Hero:setPaintPlusData(paintPlusData)
	self.paintPlusData = paintPlusData
end

function Hero:getPaintPlusData()
	if self.paintPlusData then
		return self.paintPlusData
	end

	if not isOfflineHero and CurAvatar and self:isMyHero() then
		local paintPlusData = CurAvatar:getPaintPlusDataByHeroId(self.id)

		if paintPlusData then
			return paintPlusData
		end
	end
end

function Hero:canUpPaintPlusRelateLevel(Level)
	local checkLevel

	if not Level then
		checkLevel = self:getPaintPlusRelateLevel() + 1
	else
		checkLevel = Level
	end

	local ResPaintRelateUnlock = require("ClientData/ResPaintRelateUnlock")

	if ResPaintRelate[self.id] and ResPaintRelate[self.id].relate_hero and ResPaintRelate[self.id].type_id then
		local typeId = ResPaintRelate[self.id].type_id

		if typeId and ResPaintRelateUnlock[typeId] then
			local unLockResData = ResPaintRelateUnlock[typeId]
			local heros = ResPaintRelate[self.id].relate_hero
			local nowMainLevel = self:getPaintPlusMainLevel()

			if checkLevel > #unLockResData then
				return false
			end

			local resNowData = unLockResData[checkLevel]

			if resNowData.paint_level and nowMainLevel < resNowData.paint_level then
				return false
			end

			local resNowRelatePaintLevelData = resNowData.relate_paint_level
			local count = math.min(#heros, #resNowRelatePaintLevelData)

			for i = 1, count do
				local heroId = heros[i]
				local relateHeropaintPlusData = CurAvatar:getPaintPlusDataByHeroId(heroId)

				if relateHeropaintPlusData then
					if relateHeropaintPlusData.level < resNowRelatePaintLevelData[i] then
						return false
					end
				else
					return false
				end
			end

			return true
		end
	end

	return false
end

function Hero:checkCanUnlockedMainLevel(...)
	if not Const.PAINT_PLUS_OPEN then
		return false
	end

	local paintData = self:getPaintData()

	if paintData and paintData.level then
		if paintData.level < #ResHeroPaint[paintData.resData.paint_id] then
			return false
		end
	else
		return false
	end

	local nowMainLevel = self:getPaintPlusMainLevel()

	if nowMainLevel ~= 0 then
		return false
	end

	local resReplateData = ResPaintRelate[self.id]

	if resReplateData and resReplateData.relate_hero then
		local heros = resReplateData.relate_hero

		for i = 1, #heros do
			local id = heros[i]
			local paintData = CurAvatar:getPaintDataByHeroId(id)

			if paintData then
				if paintData.level < #ResHeroPaint[paintData.resData.paint_id] then
					return false
				end
			else
				return false
			end
		end

		return true
	end

	return false
end

function Hero:getPaintPlusShowLevel(...)
	local resData = self:getPaintPlusMaterialResData()

	if resData then
		local level = self:getPaintPlusMainLevel()

		if level and resData[level] and resData[level].paint_show_level then
			return resData[level].paint_show_level
		end
	end

	return 0
end

function Hero:getPaintPlusMainLevel(...)
	local paintPlusData = self:getPaintPlusData()

	if paintPlusData and paintPlusData.level then
		return paintPlusData.level
	end

	return 0
end

function Hero:getPaintPlusRelateLevel(...)
	local paintPlusData = self:getPaintPlusData()

	if paintPlusData and paintPlusData.relateLevel then
		return paintPlusData.relateLevel
	end

	return 0
end

function Hero:getEquipedList()
	local equipedDic = self:getEquipedDic()
	local equipedList = {}

	for _, equipedItem in pairs(equipedDic) do
		table.insert(equipedList, equipedItem)
	end

	local function sortEquipedItem(a, b)
		if a.itemType == Const.ITEM_TYPE_RELIC or b.itemType == Const.ITEM_TYPE_RELIC then
			return a.itemType == Const.ITEM_TYPE_RELIC
		elseif a.itemType == Const.ITEM_TYPE_ARTIFACT or b.itemType == Const.ITEM_TYPE_ARTIFACT then
			return a.itemType == Const.ITEM_TYPE_ARTIFACT
		else
			return a.part < b.part
		end
	end

	table.sort(equipedList, sortEquipedItem)

	return equipedList
end

function Hero:getEquipedDic()
	local equipedDic = self:getEquips()
	local artifact = self:getArtifact()
	local relic = self:getRelic()

	if artifact then
		equipedDic[Const.PART_OF_ARTIFACT] = artifact
	end

	if relic then
		equipedDic[Const.PART_OF_RELIC] = relic
	end

	return equipedDic
end

function Hero:getStarPath(star)
	star = star or self.star

	if star then
		local starPath = star < 10 and "IconStar0" or "IconStar"

		return {
			"Atlas/HeroAtlas/HeroCardCommonAtlas",
			starPath .. star
		}
	end
end

function Hero:getLargeStarPath(star)
	star = star or self.star

	if star then
		local starPath = star < 10 and "IconStarL0" or "IconStarL"

		return {
			"Atlas/HeroAtlas/HeroAtlas",
			starPath .. star
		}
	end
end

function Hero:getResetStepCD()
	if ResStep[self.step] then
		return ResStep[self.step].reset_cd or 0
	else
		return 0
	end
end

function Hero:getPropLevel()
	return self.level + self.crystalSecondLevel
end

function Hero:becomePropsContainer(equips, artifact, skin, bases, relic, paintData, relationPointData, stickData)
	if self.propContainerInit == nil then
		self.stateGroup = EmptyProp(self)
		self.fixedProp = EmptyProp(self)

		PropBoard.set_default_props(self)

		self.stateGroup.props = PropHelper.getHeroStateAttrsByHero(self)
		self.fixedProp.props = PropHelper.getHeroAttrByHero(self, equips, artifact, skin, bases, relic, paintData, relationPointData, stickData)

		PropBoard.init_props(self)

		self.propContainerInit = true
	else
		self.stateGroup.props = PropHelper.getHeroStateAttrsByHero(self)
		self.fixedProp.props = PropHelper.getHeroAttrByHero(self, equips, artifact, skin, bases, relic, paintData, relationPointData, stickData)

		PropBoard.init_props(self)
	end
end

function Hero:getShowModelId()
	if self.skin and self.heroSkinData and self.heroSkinData[self.skin] then
		return self.heroSkinData[self.skin].model_id
	end

	if self.resData and self.resData.model then
		return self.resData.model
	end
end

function Hero:getFashionTag()
	if self.skin and self.heroSkinData and self.heroSkinData[self.skin] then
		return self.heroSkinData[self.skin].eff_tag
	end
end

function Hero:getShowBaseModelId()
	if self.skin and self.heroSkinData and self.heroSkinData[self.skin] and self.heroSkinData[self.skin].base_id then
		return self.heroSkinData[self.skin].base_id
	end

	if self.base and self.base and ResItemHeroBase[self.id] and ResItemHeroBase[self.id][self.base] then
		return ResItemHeroBase[self.id][self.base].base_id
	end

	if self.resData and self.resData.model then
		return self.resData.model
	end
end

function Hero:checkIsSeasonSkin(...)
	if self.skin and self.heroSkinData and self.heroSkinData[self.skin] and self.heroSkinData[self.skin].base_id == Const.SKIN_QUAILTY_SEASON then
		return true
	end

	return false
end

function Hero:getShowPortId()
	if self.skin and self.heroSkinData and self.heroSkinData[self.skin] then
		return self.heroSkinData[self.skin].port_id
	end

	return self.id
end

function Hero:getShowAniName()
	if self.skin and self.heroSkinData and self.heroSkinData[self.skin] then
		return self.heroSkinData[self.skin].ani_con_path
	end

	return self.resData.ani_con_name
end

function Hero:getSkinQuality()
	if self.skin and self.heroSkinData and self.heroSkinData[self.skin] then
		return self.heroSkinData[self.skin].quality
	end
end

function Hero:supportSkillEnable()
	if self.career == Const.CAREER_TYPE.SUPPORT and self.skillPassive2 and self.skillPassive2.level > 0 then
		return true
	end

	return false
end

function Hero:getCapacity(propAddLevel)
	if propAddLevel then
		self.crystalSecondLevel = self.crystalSecondLevel + propAddLevel

		local capa = CapacityHelper.getHeroCapacity(self)

		self.crystalSecondLevel = self.crystalSecondLevel - propAddLevel

		return capa
	else
		return CapacityHelper.getHeroCapacity(self)
	end
end

function Hero:getInitMana()
	local initMana = self.resData.init_mana or 0

	if self.skillPassive1 and ResHeroPassiveConfig[self.skillPassive1.id] and ResHeroPassiveConfig[self.skillPassive1.id][self.skillPassive1.level] then
		initMana = initMana + ResHeroPassiveConfig[self.skillPassive1.id][self.skillPassive1.level].add_mana
	end

	return initMana
end

function Hero:getMaxStep()
	local maxStep = 1

	if not self:getMaxStar() then
		return maxStep
	end

	for step, stepInfo in ipairs(ResStep) do
		if self:getMaxStar() >= stepInfo.need_star_limit then
			maxStep = step
		end
	end

	return maxStep
end

function Hero:getMaxLv()
	local maxLv = 1

	if not self:getMaxStar() then
		return maxLv
	end

	maxLv = ResStar[self.resData.star_prop_id][self:getMaxStar()].max_level

	return maxLv
end

function Hero:getMaxStarLv()
	return ResStar[self.resData.star_prop_id][self.star].max_level
end

local ResStarCost = require("ClientData/ResStarCost")

function Hero:getMaxStar()
	return self.resData.star_limit
end

function Hero:getStepDes()
	if ResStepDes[self.id] and ResStepDes[self.id][self.step] then
		return ResStepDes[self.id][self.step]
	else
		return nil
	end
end

function Hero:getStarUpNeedGids(ignoreLastDefend)
	if not self.starUpNeedGids then
		local sameStarList, campStarList, anyStarList = CurAvatar:getHeroStarUpNeedGids(self, ignoreLastDefend)

		self.starUpNeedGids = {}
		self.starUpNeedGids[Const.HERO_STARUP_MATERIAL_TYPE.SAME_ID] = sameStarList
		self.starUpNeedGids[Const.HERO_STARUP_MATERIAL_TYPE.SAME_CAMP] = campStarList
		self.starUpNeedGids[Const.HERO_STARUP_MATERIAL_TYPE.ANY_ID] = anyStarList
	end

	return self.starUpNeedGids
end

function Hero:canStarUp()
	if self:isUniqueHero() then
		return false
	end

	if self.star >= self:getMaxStar() then
		return false
	end

	local starConstInfo = ResStarCost[self.resData.star_up_id][self.star + 1]

	if not starConstInfo then
		return false
	end

	local needGids = self:getStarUpNeedGids()

	return #needGids[Const.HERO_STARUP_MATERIAL_TYPE.SAME_ID] == starConstInfo.same_num and #needGids[Const.HERO_STARUP_MATERIAL_TYPE.SAME_CAMP] == starConstInfo.camp_num and #needGids[Const.HERO_STARUP_MATERIAL_TYPE.ANY_ID] == starConstInfo.any_num
end

function Hero:getQualityColor(getQuality)
	local quality = getQuality or self.quality
	local ResColor = require("ClientData/ResColor")
	local color

	if quality == Const.OBJ_QUALITY_WHITE then
		color = ResColor.QUALITYGREEN
	elseif quality == Const.OBJ_QUALITY_GREEN then
		color = ResColor.QUALITYBLUE
	elseif quality == Const.OBJ_QUALITY_BLUE then
		color = ResColor.QUALITYPURPLE
	elseif quality == Const.OBJ_QUALITY_PURPLE then
		color = ResColor.QUALITYFUCHSIA
	elseif quality == Const.OBJ_QUALITY_GOLD then
		color = ResColor.QUALITYORANGE
	elseif quality == 6 then
		color = ResColor.QUALITYPINK
	elseif quality == 7 then
		color = ResColor.QUALITYRED
	end

	return color
end

function Hero:getNextUpSkillField()
	if self.recharge < self:getMaxStep() then
		for _, field in pairs(Const.HERO_SKILL_FIELD) do
			local curLevel = 0

			if self.recharge == 0 and (field == Const.HERO_SKILL_FIELD.ATTACK or field == Const.HERO_SKILL_FIELD.SKILL) then
				curLevel = 1
			elseif self.recharge ~= 0 then
				curLevel = ResHeroRecharge[self.recharge] and ResHeroRecharge[self.recharge][Const.HERO_SKILL_LEVEL_FIELD_DIC[field]] or 0
			end

			local nextStepLevel = ResHeroRecharge[self.recharge + 1][Const.HERO_SKILL_LEVEL_FIELD_DIC[field]]

			if curLevel < nextStepLevel then
				return field
			end
		end
	end
end

function Hero:getRecSuit()
	local suitId = ResEquipRecSuit[self.career].suit_id

	return ResEquipSuit[suitId]
end

function Hero:isHero()
	return true
end

function Hero:getWallPath()
	local relic = self:getRelic()

	if relic and relic.wallPath then
		return relic.wallPath
	else
		return "Characters/Common/efx_HeroEquipBgBox"
	end
end

function Hero:setHeroStepUI(bgStage, txtStage, isNotHandleCamp)
	local step, star = self.step, self.star

	if bgStage then
		bgStage:setVisible(step > 0)
	end

	if step <= 0 then
		return
	end

	local stepImgIdx = ResStarUpCondition[star].step_img_idx or 1
	local stepImgInfo = UIConst.HERO_CARD_SPRITE_BY_STEP[stepImgIdx]
	local stageSpriteName = step < 10 and "TxtStage0" or "TxtStage"

	if self:getStepDes() then
		txtStage:setText(self:getStepDes().step_name)
	end

	if isNotHandleCamp ~= true then
		if self.camp == Const.CAMP_TYPE.NINE_NIGHT then
			txtStage:setFontColor(ResColor.WHITE)
		else
			txtStage:setFontColor(ResColor.GREYDIS)
		end
	end
end

function Hero:getRelicBgmIdByType(bgm_type)
	local relic = self:getRelic()

	if relic then
		return relic:getBgmIdByType(bgm_type)
	end
end

function Hero:getRelicValueByKey(key)
	local relic = self:getRelic()

	if relic then
		return relic:getActionByKey(key)
	end
end

function Hero:getHeroCanWearEquipEmptyPart()
	if CurAvatar then
		local canEquipPartList = CurAvatar:getHeroCanEquipPart(self)
		local equips = self:getEquips()

		for _, part in ipairs(canEquipPartList) do
			if not equips[part] and part <= 6 then
				return part
			end
		end
	end
end

function Hero:getHeroCanWearArtifactEmptyPart()
	if CurAvatar then
		local canEquipPartList = CurAvatar:getHeroCanEquipPart(self)

		for _, part in ipairs(canEquipPartList) do
			if part == Const.PART_OF_ARTIFACT then
				return self:getArtifact() == nil
			end
		end

		return false
	end
end

function Hero:getRelationPlotIconPath(relationPoint)
	if self.resDevelopPlotData[relationPoint] then
		local plotData = self.resDevelopPlotData[relationPoint]

		if plotData.relation_pack_type == Const.RELATION_DESC_ITEM then
			if plotData.icon_path then
				return {
					"Atlas/CommonAtlas/IconAtlas/" .. plotData.icon_path,
					plotData.icon,
					plotData.posy
				}
			end
		else
			local letterInfo = ResRelationLetterName[self.team][relationPoint]

			if letterInfo and letterInfo.icon_path then
				return {
					letterInfo.icon_path,
					letterInfo.icon
				}
			end
		end
	end
end

function Hero:getRelationPlotDesc(relationPoint)
	if self.resDevelopPlotData[relationPoint] then
		local plotData = self.resDevelopPlotData[relationPoint]

		if plotData.relation_pack_type == Const.RELATION_DESC_ITEM then
			local descInfo = ResDevelopDesc[plotData.relation_pack_id]

			if descInfo and descInfo then
				return descInfo
			end
		else
			local letterInfo = ResRelationLetterName[self.team][relationPoint]

			if letterInfo and letterInfo then
				return letterInfo
			end
		end
	end
end

function Hero:getRelationPlotUnknownIconPath(relationPoint)
	local plotData = self.resDevelopPlotData[relationPoint]

	if plotData then
		return RELATION_NNKNOWN_ICONATH[plotData.relation_pack_type]
	end
end

function Hero:setRelationPointData(relationPointData)
	self.relationPointData = relationPointData
end

function Hero:getRelationPointData()
	if self.relationPointData then
		return self.relationPointData
	end

	if not isOfflineHero and CurAvatar and (self.isRoomHero or self:isMyHero()) then
		local relationData = CurAvatar:getRelationDataByHeroId(self.id)

		if relationData and relationData.pointDevData then
			local devData = relationData.pointDevData

			if not devData[7] then
				devData[7] = {
					level = 0
				}
			end

			return devData
		end
	end
end

function Hero:getSeasonRelicWallPath(...)
	if self:checkSeasonRelicOpen() and ResSeasonRelicShow[self.seasonRelicId] then
		if self:checkMyHeroUnlockSeasonRelic() then
			return ResSeasonRelicShow[self.seasonRelicId].unlock_wall_path
		else
			return ResSeasonRelicShow[self.seasonRelicId].lock_wall_path
		end
	end
end

function Hero:checkSeasonRelicOpen(...)
	if self.seasonRelicId and self.seasonRelicId ~= 0 and ResSeasonRelicOp[self.seasonRelicId] then
		local data = ResSeasonRelicOp[self.seasonRelicId][Const.SEASON_RELIC_UNLOCK]

		if data and data[1] and data[1].limit_id then
			return LimitManager.checkConditionOK(data[1].limit_id)
		end
	end

	return false
end

function Hero:checkMyHeroUnlockSeasonRelic()
	if self.seasonRelicId and CurAvatar and CurAvatar.bagSeasonRelics and CurAvatar.bagSeasonRelics[self.seasonRelicId] then
		return true
	end

	return false
end

function Hero:checkSeasonRelicCanLvUp()
	if self:checkSeasonRelicOpen() then
		local relic = self:getSeasonRelic()

		if relic then
			return relic:seasonRelicCanLvUp()
		end
	end

	return false
end

function Hero:checkSeasonRelicCanUnLock(...)
	if not self:checkMyHeroUnlockSeasonRelic() and self:checkSeasonRelicOpen() then
		local relic = Relic({
			id = self.seasonRelicId
		})

		if relic then
			return relic:seasonRelicCanUnLock()
		end
	end

	return false
end

function Hero:setSeasonRelic(relic)
	self.seasonRelic = relic
end

function Hero:getSeasonRelic(...)
	if self.seasonRelic then
		return self.seasonRelic
	end

	if self.seasonRelicId == 0 then
		return
	end

	if not isOfflineHero and CurAvatar and self:isMyHero() then
		return CurAvatar.bagSeasonRelics[self.seasonRelicId]
	end
end

function Hero:getRelationPointLevel(relationPoint)
	local relationPointData = self:getRelationPointData()

	if relationPointData and relationPointData[relationPoint] then
		return relationPointData[relationPoint].level
	else
		return 0
	end
end

function Hero:getRelationPointNeedMaterial(relationPoint, onlyLack)
	local plotData = self.resDevelopPlotData[relationPoint]

	if not plotData then
		return
	end

	if plotData.relation_pack_type == Const.RELATION_DESC_VOW then
		local vowMaterals = {}
		local itemId, vosItems = next(ResVowMisc)

		if not onlyLack then
			vowMaterals[1] = vosItems
		else
			local curCount = CurAvatar:getItemNumById(itemId)

			if curCount < vosItems.num then
				vowMaterals[1] = vosItems
			end
		end

		return vowMaterals
	else
		local relationPointData = self:getRelationPointData()
		local level = 1

		if relationPointData and relationPointData[relationPoint] then
			level = relationPointData[relationPoint].level + 1
		end

		local confData = self:getRelationConfData(relationPoint, level)

		if confData then
			local materialData = ResDevelopCost[confData.develop_up_id]

			if materialData then
				if not onlyLack then
					return materialData.materials
				elseif CurAvatar then
					local lackMaterials = {}

					for _, idNum in ipairs(materialData.materials) do
						local itemId = idNum.id
						local needNum = idNum.num
						local curCount = CurAvatar:getItemNumById(idNum.id)

						if curCount < needNum then
							table.insert(lackMaterials, idNum)
						end
					end

					return lackMaterials
				end
			end
		end
	end
end

function Hero:getCurRelationPoint()
	local unlockStage = self:getRelationUnlockStage()
	local relationPointData = self:getRelationPointData()

	if unlockStage > 0 then
		if relationPointData then
			for relationPoint, pointData in ipairs(relationPointData) do
				if unlockStage >= ResDevelopMisc[relationPoint].develop_stage and pointData.level < ResDevelopMisc[relationPoint].max_level then
					return relationPoint
				end
			end

			return -1
		else
			return 1
		end
	else
		return -1
	end
end

function Hero:getRelationUnlockStage()
	if self.resDevelopUnlockData and self.resDevelopUnlockData.valid_time_id and ClientUtils.isTimeConfigPassed(self.resDevelopUnlockData.valid_time_id) then
		return self.resDevelopUnlockData.new_unlock_stage or 0
	elseif self.resDevelopUnlockData then
		return self.resDevelopUnlockData.unlock_stage or 0
	else
		return 0
	end
end

function Hero:getRelationConfData(relationPoint, level)
	if self.resDevelopConfData and self.resDevelopConfData[relationPoint] and self.resDevelopConfData[relationPoint][level] then
		return self.resDevelopConfData[relationPoint][level]
	end
end

function Hero:getEquipBanPropType(banType)
	if ResHeroBanEquipPropType[self.id] then
		return ResHeroBanEquipPropType[self.id].ban_prop_type or Const.HERO_PROP_INVALID_TYPE_ALL
	else
		return Const.HERO_PROP_INVALID_TYPE_ALL
	end
end

function Hero:getExtraSystemProps()
	local props = {}

	props = utils.getHeroStoryProps(self.crystalMaxLevel, self.storyUnlockDic, props)

	return props
end

function Hero:getRelationTeamColor()
	return RELATION_TEAM_COLOR[self.team]
end

function Hero:getPackTypeByRelationId(relationPoint)
	return self.resDevelopPlotData[relationPoint] and self.resDevelopPlotData[relationPoint].relation_pack_type
end

function Hero:getSkillFieldBySkillId(skillId)
	local skillField

	if skillId == self.resData.attack_id then
		skillField = Const.HERO_SKILL_FIELD.ATTACK
	elseif skillId == self.resData.skill_id then
		skillField = Const.HERO_SKILL_FIELD.SKILL
	elseif skillId == self.resData.enter_passive then
		skillField = Const.HERO_SKILL_FIELD.ENTER_PASSIVE
	elseif skillId == self.resData.hero_passive then
		skillField = Const.HERO_SKILL_FIELD.HERO_PASSIVE
	end

	return skillField
end

function Hero:mazeSolderIsDefault(solderId)
	local mazeData = ResNewMazeHero[self.id] or {}

	return solderId == mazeData.team_label or solderId == mazeData.feature_label1 or solderId == mazeData.feature_label2
end

function Hero:setMazeSolder(solder)
	self.mazeSolder = solder
end

function Hero:getMazeSolderState(isShowDefault)
	local defaultSolder = {}
	local defaultList = {}
	local mazeData = ResNewMazeHero[self.id] or {}

	if mazeData.team_label then
		defaultSolder[mazeData.team_label] = true

		table.insert(defaultList, mazeData.team_label)
	end

	if mazeData.feature_label1 then
		defaultSolder[mazeData.feature_label1] = true

		table.insert(defaultList, mazeData.feature_label1)
	end

	if mazeData.feature_label2 then
		defaultSolder[mazeData.feature_label2] = true

		table.insert(defaultList, mazeData.feature_label2)
	end

	local mazeSolder = self.mazeSolder

	if not mazeSolder or #mazeSolder == 0 or isShowDefault then
		mazeSolder = defaultList
	end

	local solderInfo = {}

	for _, solderId in ipairs(mazeSolder) do
		local oneSolder = {}

		oneSolder.id = solderId

		if defaultSolder[solderId] then
			oneSolder.isDefault = true
		else
			oneSolder.isDefault = false
		end

		table.insert(solderInfo, oneSolder)
	end

	return solderInfo
end

function Hero:newMazeOwnSolder(solderId)
	local solderList = self:getMazeSolderState()

	for _, oneSolder in ipairs(solderList) do
		if oneSolder.id == solderId then
			return true
		end
	end

	return false
end

return Hero
