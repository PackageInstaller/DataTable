-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/AnimalEggModel.lua

module("logic.extensions.zoo.model.AnimalEggModel", package.seeall)

local AnimalEggModel = class("AnimalEggModel")

function AnimalEggModel:ctor(info)
	return
end

function AnimalEggModel:getId()
	return self.id
end

function AnimalEggModel:getDefineId()
	return self.raceId
end

function AnimalEggModel:initData(info)
	self.id = tonumber(info.id)
	self.raceId = info.raceId

	local cfg = ZooConfig.instance:getAnimalById(info.raceId)

	self.name = cfg.eggName
	self.desc = cfg.eggDesc
	self.icon = cfg.eggIcon
	self.eggShow = cfg.eggShow
	self.groupShow = cfg.groupShow
	self.adultShow = cfg.adultShow
	self.effectiveGene = {}
	self.headGenes = info.geneInfo.headGenes
	self.headWearGenes = info.geneInfo.headWearGenes
	self.expressionGenes = info.geneInfo.expressionGenes
	self.clothesGenes = info.geneInfo.clothesGenes
	self.foreheadGenes = info.geneInfo.foreheadGenes
	self.weaponGenes = info.geneInfo.weaponGenes
	self.backWearGenes = info.geneInfo.backWearGenes
	self.tailWearGenes = info.geneInfo.tailWearGenes
	self.effectiveGene = ZooController.instance:getEffectiveGeneByGeneInfo(info.geneInfo)
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
	self.workGene = info.geneInfo.workGene or 0
	self.allGeneArray = {}

	TableUtil.AddTable(self.allGeneArray, self.showGeneArray)
	table.insert(self.allGeneArray, self.workGene)
end

function AnimalEggModel:refreshNormalGeneView(scroller)
	local normalGenes = {}

	for i, id in ipairs(self.effectiveGene) do
		local cfg = ZooConfig.instance:getGene(id)

		if cfg.name and cfg.name ~= "" then
			cfg.type = 1

			table.insert(normalGenes, cfg)
		end
	end

	scroller:reloadData(normalGenes)
end

function AnimalEggModel:refreshSpecialGeneView(scroller)
	local specielGenes = {}
	local cfg = ZooConfig.instance:getWorkGeneById(self.workGene)

	if cfg then
		cfg.type = 3

		table.insert(specielGenes, cfg)
	end

	scroller:reloadData({})
end

return AnimalEggModel
