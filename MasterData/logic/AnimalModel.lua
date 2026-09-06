-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/AnimalModel.lua

module("logic.extensions.zoo.model.AnimalModel", package.seeall)

local AnimalModel = class("AnimalModel")

AnimalModel.FOLLOW = 1
AnimalModel.IN_ZOO = 2
AnimalModel.BUDDY_MATCHING = 3
AnimalModel.IN_MARKET = 4
AnimalModel.MARKET_MATCHING = 5
AnimalModel.FAVORITE = 6
AnimalModel.LostAnimalHandleType_Feed = 0
AnimalModel.LostAnimalHandleType_SendHomd = 1
AnimalModel.LostAnimalHandleType_Ingore = 2

function AnimalModel:getDefaultByRaceId(raceId)
	self.raceId = raceId or 1

	local cfg = ZooConfig.instance:getAnimalById(self.raceId)

	self.name = cfg.name

	local _, dataList = ZooConfig.instance:getGene()

	self.effectiveGene = {}
	self.showGeneArray = {}

	for i, data in ipairs(dataList) do
		local keys = GameEnum.ZooPartToGeneKey[data.part] .. "s"

		if data.animalRace == raceId and data.priority == 1 and self[keys] == nil then
			self[keys] = {
				data.id
			}

			table.insert(self.effectiveGene, data.id)
			table.insert(self.showGeneArray, data.id)
		end
	end

	self.follow = false
	self.place = false
	self.collection = false
	self.working = false
	self.exp = 0
	self.quality = 1
end

function AnimalModel:initData(data)
	self.id = tonumber(data.id)
	self.raceId = data.raceId
	self.name = data.name
	self.gainTime = data.gainTime
	self.restMatchTimes = data.restMatchTimes
	self.matchCdEndTime = checknumber(data.matchCdEndTime) / 1000
	self.state = data.state
	self.exp = data.exp or 0

	self:_updateLevel()

	if data.state then
		self.follow = data.state[1]
		self.place = data.state[2]
		self.working = data.state[3]
	else
		self.follow = false
		self.place = false
		self.collection = false
		self.working = false
	end

	self.headGenes = data.geneInfo.headGenes
	self.headWearGenes = data.geneInfo.headWearGenes
	self.expressionGenes = data.geneInfo.expressionGenes
	self.clothesGenes = data.geneInfo.clothesGenes
	self.foreheadGenes = data.geneInfo.foreheadGenes
	self.weaponGenes = data.geneInfo.weaponGenes
	self.backWearGenes = data.geneInfo.backWearGenes
	self.tailWearGenes = data.geneInfo.tailWearGenes
	self.effectiveGene = ZooController.instance:getEffectiveGeneByGeneInfo(data.geneInfo)
	self.showGeneArray = {}

	TableUtil.AddTable(self.showGeneArray, self.headGenes)
	TableUtil.AddTable(self.showGeneArray, self.headWearGenes)
	TableUtil.AddTable(self.showGeneArray, self.expressionGenes)
	TableUtil.AddTable(self.showGeneArray, self.foreheadGenes)
	TableUtil.AddTable(self.showGeneArray, self.backWearGenes)
	TableUtil.AddTable(self.showGeneArray, self.weaponGenes)
	TableUtil.AddTable(self.showGeneArray, self.tailWearGenes)
	TableUtil.AddTable(self.showGeneArray, self.clothesGenes)

	self.propertyGenes = {}
	self.quality = 1
	self.workGene = data.geneInfo.workGene
end

function AnimalModel:updateName(name)
	self.name = name
end

function AnimalModel:updateShowGeneById(id)
	local cfg = ZooConfig.instance:getGene(id)

	if cfg == nil then
		return
	end

	local key = GameEnum.ZooPartToGeneKey[cfg.part]
	local keys = key .. "s"
	local oldGene = ZooController.instance:getEffectiveGene(self[keys])

	for i = 1, #self[keys] do
		if self[keys][i] == oldGene then
			self[keys][i] = id

			break
		end
	end

	for i = 1, #self.showGeneArray do
		if self.showGeneArray[i] == oldGene then
			self.showGeneArray[i] = id

			break
		end
	end

	local gene = ZooController.instance:getEffectiveGene(self[keys])

	for i = 1, #self.effectiveGene do
		if self.effectiveGene[i] == oldGene then
			self.effectiveGene[i] = gene

			break
		end
	end
end

function AnimalModel:isHaveGene(geneType, geneId)
	if geneType == 1 then
		for i, id in ipairs(self.showGeneArray) do
			if id == geneId then
				return true
			end
		end
	else
		return self.workGene == geneId
	end

	return false
end

function AnimalModel:isCanMatch()
	return not self:isMatchCD() and self.restMatchTimes > 0
end

function AnimalModel:isCanMatchNow(now)
	return not self:isMatchCDByTime(now) and self.restMatchTimes > 0
end

function AnimalModel:isMatchCD()
	return self:isMatchCDByTime(ServerTime.now())
end

function AnimalModel:isMatchCDByTime(now)
	return self:getMatchCDByTime(now) > 0
end

function AnimalModel:getMatchCDByTime(now)
	local matchCdEndTime = checknumber(self.matchCdEndTime)

	if matchCdEndTime == 0 then
		return 0
	end

	return math.max(matchCdEndTime - now, 0)
end

function AnimalModel:getMatchCD(now)
	return self:getMatchCDByTime(ServerTime.now())
end

function AnimalModel:isCanPlace()
	return not self.place and not self.follow and not self.working
end

function AnimalModel:isCanWorking()
	return not self.place and not self.follow and not self.working
end

function AnimalModel:setExp(exp)
	self.exp = exp

	self:_updateLevel()
end

function AnimalModel:addExp(exp)
	self.exp = self.exp + exp

	self:_updateLevel()
end

function AnimalModel:_updateLevel()
	local levelInfo, oldLv = ZooConfig.instance:getAnimalLevel(), self.level

	for i = #levelInfo, 1, -1 do
		if self.exp >= levelInfo[i].needExp then
			self.level = i

			break
		end
	end

	if oldLv and oldLv ~= self.level then
		local oldCfg, curCfg = ZooConfig.instance:getAnimalLevelById(oldLv), ZooConfig.instance:getAnimalLevelById(self.level)

		self.restMatchTimes = self.restMatchTimes + (curCfg.canMatchTimes - oldCfg.canMatchTimes)
	end

	local cfg = ZooConfig.instance:getAnimalLevelById(self.level + 1)

	self.nextExp = cfg and cfg.needExp or -1
end

function AnimalModel:refreshNormalGeneView(scroller)
	local normalGenes = {}

	for i, id in ipairs(self.effectiveGene) do
		local cfg = ZooConfig.instance:getGene(id)

		if cfg == nil then
			printError(string.format(ZooConfig.GENENULLERRORTIP, id))
		elseif cfg.name and cfg.name ~= "" then
			cfg.type = 1

			table.insert(normalGenes, cfg)
		end
	end

	scroller:reloadData(normalGenes)
end

function AnimalModel:refreshSpecialGeneView(scroller)
	local specielGenes = {}
	local cfg = ZooConfig.instance:getWorkGeneById(self.workGene)

	if cfg then
		table.insert(specielGenes, cfg)
	else
		printError(string.format(ZooConfig.GENENULLERRORTIP, self.workGene))
	end

	scroller:reloadData({})
end

function AnimalModel:refreshAllGeneView(scroller)
	local genes = {}

	for i, id in ipairs(self.effectiveGene) do
		local cfg = ZooConfig.instance:getGene(id)

		if cfg == nil then
			printError(string.format(ZooConfig.GENENULLERRORTIP, id))
		elseif cfg.name and cfg.name ~= "" then
			table.insert(genes, cfg)
		end
	end

	scroller:reloadData(genes)
end

function AnimalModel:showAnimalAvatar(go, width, height, camY, camsize, avatarUseType)
	local animalShow = AvatarPhotoShow.Get(go)

	if tonumber(width) and tonumber(height) then
		animalShow:setRawWidthAndHeight(width, height)
	end

	local avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Zoo)

	avatar.useType = avatarUseType or AvatarUseType.UI

	local avatarMo = avatar:getNewUseMo()

	avatarMo:setDataByAnimalMo(self)
	animalShow:setFirstAddParent(function()
		local x = ZooModel.instance:getAvatarShowIndex()

		Framework.TransformUtil.SetLocalPos(animalShow._photoEffect._photo.producer.rtCamera.transform.parent, x, 10, 0)
	end)
	animalShow:addShowAvatarEffect(avatar, true)
	animalShow:setCameraPosition(0, camY, -30)
	animalShow:setCamSize(camsize)
	avatar:updateByMo(avatarMo)

	return animalShow, avatar
end

return AnimalModel
