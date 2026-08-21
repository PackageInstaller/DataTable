-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\Pet.lua

local BaseObject = require("Common/Object/BaseObject")
local ResPet = require("ClientData/ResPet")
local ResPetAmulet = require("ClientData/ResPetAmulet")
local ResPetStar = require("ClientData/ResPetStar")
local ResPetMisc = require("ClientData/ResPetMisc")
local EmptyProp = require("Entity/EmptyProp")
local PropBoard = require("ClientData/PropBoard")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")
local strClassName = "Pet"
local Pet = Class(strClassName, BaseObject)

function Pet:ctor(data)
	return
end

function Pet:_initData()
	Pet.super._initData(self)

	self.id = self._serverData.resid or 0
	self.resData = ResPet[self.id]

	if not self.resData then
		-- block empty
	end

	self.name = self.resData.name
	self.quality = self.resData.quality
	self.degreeId = self.resData.degree
	self.baseStar = self.resData.base_star
	self.translateItemId = self.resData.translate_item_id
	self.star = self._serverData.star or self.baseStar
	self.amuletFight = self._serverData.amulet1
	self.amuletHelpFight = self._serverData.amulet2
	self.gem = {}

	for i, v in ipairs(self._serverData.gem or {}) do
		table.insert(self.gem, v)
	end

	self:updatePossessData(self._serverData.possess_tick)
	self:updateIntelligenceData(self._serverData.intelligence)
	self:updateGiftData(self._serverData.gifted)

	self.modelData = utils.getCommonModelData(self:getShowModelId())
	self.itemType = Const.ITEM_TYPE_PET
end

function Pet:updatePossessData(possess_tick)
	self.possessTick = possess_tick
end

function Pet:updateIntelligenceData(intelligence_data)
	self.intelligenceList = {}
	self.unSaveIntelligenceList = nil

	if intelligence_data then
		if intelligence_data.item then
			for _, tmp in ipairs(intelligence_data.item) do
				table.insert(self.intelligenceList, tmp.num)
			end
		end

		if intelligence_data.rand_item and #intelligence_data.rand_item > 0 then
			self.unSaveIntelligenceList = {}

			for idx, tmp in ipairs(intelligence_data.rand_item) do
				local num = (self.intelligenceList[idx] or 0) + tmp.num

				table.insert(self.unSaveIntelligenceList, num)
			end
		end
	end
end

function Pet:updateGiftData(gift_data)
	self.giftList = {}
	self.unSaveGiftData = nil

	if gift_data then
		if gift_data.id then
			for _, tmp in ipairs(gift_data.id) do
				table.insert(self.giftList, tmp.id)
			end
		end

		if gift_data.rand_item and gift_data.rand_item > 0 and gift_data.rand_pos then
			self.unSaveGiftData = {}
			self.unSaveGiftData.pos = gift_data.rand_pos
			self.unSaveGiftData.id = gift_data.rand_item
		end
	end
end

function Pet:getShowModelId()
	if self.resData and self.resData.model then
		return self.resData.model
	end
end

function Pet:getShowBaseModelId()
	if self.resData and self.resData.base_model then
		local stage = ResPetStar[self.star].stage
		local baseId = self.resData.base_model[stage]

		return baseId or self.resData.base_model[1]
	end
end

function Pet:getIconPath()
	if self.modelData and self.modelData.icon_path and self.modelData.icon_name then
		return {
			"Atlas/" .. self.modelData.icon_path,
			self.modelData.icon_name
		}
	end
end

function Pet:getQIconPath()
	if self.modelData and self.modelData.q_icon_path and self.modelData.q_icon_name then
		return {
			"Atlas/" .. self.modelData.q_icon_path,
			self.modelData.q_icon_name
		}
	end
end

function Pet:getHeadIconPath()
	if self.modelData and self.modelData.head_path and self.modelData.head_name then
		return {
			"Atlas/" .. self.modelData.head_path,
			self.modelData.head_name
		}
	end
end

function Pet:initGemList()
	return
end

function Pet:isWearMainAmulet()
	if self.amuletFight and self.amuletFight ~= 0 and self.amuletFight ~= ResPetMisc[1].default_amulet_id then
		return true
	end

	return false
end

function Pet:isWearAssistAmulet()
	if self.amuletHelpFight and self.amuletHelpFight ~= 0 then
		return true
	end

	return false
end

function Pet:checkCanWearAmulet()
	if self:checkCanWearAmuletByPos(1) or self:checkCanWearAmuletByPos(2) then
		return true
	end

	return false
end

function Pet:checkCanWearAmuletByPos(pos)
	local isWear = false

	if pos == 1 then
		isWear = self:isWearMainAmulet()
	else
		isWear = self:isWearAssistAmulet()
	end

	if not isWear then
		local amuletList = CurAvatar:getAllCanWearAmuletList(pos)

		if #amuletList >= 1 then
			return true
		end
	end

	return false
end

function Pet:checkCanWearMainAmulet()
	if not self:isWearMainAmulet() then
		local amuletList1 = CurAvatar:getAllCanWearAmuletList(1)

		if #amuletList1 >= 1 then
			return true
		end
	end

	return false
end

function Pet:checkCanWearAssistAmulet()
	if not self:isWearAssistAmulet() then
		local amuletList2 = CurAvatar:getAllCanWearAmuletList(2)

		if #amuletList2 >= 1 then
			return true
		end
	end

	return false
end

function Pet:checkMainAmuletCanStarUp()
	if self.amuletFight and CurAvatar.petAmuletDic[self.amuletFight] then
		local amulet = CurAvatar.petAmuletDic[self.amuletFight]

		return amulet:checkCanStarUp()
	end

	return false
end

function Pet:checkAssistAmuletCanStarUp()
	if self.amuletHelpFight and CurAvatar.petAmuletDic[self.amuletHelpFight] then
		local amulet = CurAvatar.petAmuletDic[self.amuletHelpFight]

		return amulet:checkCanStarUp()
	end

	return false
end

function Pet:checkCanWearGem()
	local gemNum = ResPetStar[self.star].gem_num

	if gemNum > #self.gem and CurAvatar:checkIsHasGemNotWearing() then
		return true
	end

	return false
end

function Pet:checkCanWearHigherLvGem()
	for i, gem in ipairs(self.gem) do
		if CurAvatar.petGemDic[gem.gid] and CurAvatar.petGemDic[gem.gid]:checkHasHigherLvGemNotWearing() then
			return true
		end
	end

	return false
end

function Pet:setNormalRune()
	return
end

function Pet:becomePropsContainer()
	if self.propContainerInit == nil then
		self.stateGroup = EmptyProp(self)
		self.fixedProp = EmptyProp(self)

		PropBoard.set_default_props(self)

		self.stateGroup.props = {}
		self.fixedProp.props = PropHelper.getPetAttrByPet(self)

		PropBoard.init_props(self)

		self.propContainerInit = true
	else
		self.stateGroup.props = {}
		self.fixedProp.props = PropHelper.getPetAttrByPet(self)

		PropBoard.init_props(self)
	end
end

function Pet:isMaxStar()
	return self.star >= ResPetMisc[1].max_star
end

function Pet:setPetLevel(level)
	self.petLevel = level
end

function Pet:getPetLevel()
	if self.petLevel then
		return self.petLevel
	end

	return CurAvatar.petDegreeLevel
end

function Pet:setBattlePetAmulet(mainAmulet, helpAmulet)
	if mainAmulet then
		self.mainAmulet = mainAmulet
	else
		local defaultAmuletId = ResPetMisc[1].default_amulet_id

		self.mainAmulet = BaseObject.GetObject(defaultAmuletId)
	end

	self.helpAmulet = helpAmulet
end

function Pet:getBattleFightAmulet()
	if self.mainAmulet then
		return self.mainAmulet, self.helpAmulet
	elseif self.amuletFight and CurAvatar.petAmuletDic[self.amuletFight] then
		return CurAvatar.petAmuletDic[self.amuletFight], CurAvatar.petAmuletDic[self.amuletHelpFight]
	else
		local defaultAmuletId = ResPetMisc[1].default_amulet_id

		return BaseObject.GetObject(defaultAmuletId), CurAvatar.petAmuletDic[self.amuletHelpFight]
	end
end

function Pet:setBattlePetGem(gemObjs)
	if gemObjs then
		self.gemObjs = gemObjs
	end
end

function Pet:getBattlePetGem()
	if self.gemObjs then
		return self.gemObjs
	else
		local gemObjs = {}

		for i, v in ipairs(self.gem) do
			if CurAvatar.petGemDic[v.gid] then
				table.insert(gemObjs, CurAvatar.petGemDic[v.gid])
			end
		end

		return gemObjs
	end
end

function Pet:setBattlePetRune(commonRune, exclusiveRune)
	self.commonRune = commonRune
	self.exclusiveRune = exclusiveRune
end

function Pet:getModelChangeStar()
	local changeStarTable = {}
	local curStage = 0
	local myStage = 1

	for i, v in ipairs(ResPetStar) do
		if curStage < v.stage then
			table.insert(changeStarTable, v.star)

			curStage = v.stage
		end

		if v.star == self.star then
			myStage = v.stage
		end
	end

	return changeStarTable, myStage
end

function Pet:getCapacity()
	return CapacityHelper.getPetCapacity(self)
end

function Pet:getMaxExRuneId()
	return self.resData.ex_rune_id or 0
end

function Pet:checkHaveGift(gift_id)
	for _, giftId in ipairs(self.giftList) do
		if giftId == gift_id then
			return true
		end
	end

	return false
end

function Pet:checkCanPossess(checkTip)
	local now = ClientUtils:getServerTime()
	local check = now > self.possessTick + Const.PET_POSSESS_CD

	if checkTip and not check then
		MsgManager.clientNotice(755)
	end

	return check
end

function Pet:checkHaveWear()
	if CurAvatar.petAmuletDic[self.amuletFight] and self.amuletFight ~= Const.PET_DEFAULT_AMULET then
		return true
	end

	if CurAvatar.petAmuletDic[self.amuletHelpFight] then
		return true
	end

	local gemList = self:getBattlePetGem() or {}

	return #gemList > 0
end

return Pet
