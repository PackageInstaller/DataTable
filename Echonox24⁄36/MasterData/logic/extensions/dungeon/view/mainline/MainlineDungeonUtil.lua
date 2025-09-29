-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/mainline/MainlineDungeonUtil.lua

module("logic.extensions.dungeon.view.mainline.MainlineDungeonUtil", package.seeall)

local attrTyp2Name = {
	"力量",
	"敏捷",
	"知识",
	"沟通",
	"洞察",
	"幸运"
}
local Attr2Icon = {
	"fhdt19",
	"fhdt20",
	"fhdt21",
	"fhdt22",
	"fhdt23",
	"fhdt24"
}

function getPassAttrDesc()
	return string.format("%s <sprite name=\"1100012\"> 1 ", lang("tip_chapter_node_static2"))
end

function getAttribute(dungeonId)
	local plotId, plotValue = getPlotInfo(dungeonId)
	local arrStep = string.split(plotValue, "#")
	local question = tonumber(arrStep[1])
	local index = tonumber(arrStep[2])
	local attrType, attrVal = StoryAttrConfig.instance:getStoryAttrInfo(plotId, question, index)

	if not attrType or not attrVal then
		return false
	end

	return string.format(" <sprite name=\"%s\"> ", Attr2Icon[attrType]), attrTyp2Name[attrType], attrVal
end

function getPlotInfo(dungeonId)
	local co
	local cfgList = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonList()

	for _, cfg in ipairs(cfgList) do
		if cfg.showUnlockCondition then
			for i, v in ipairs(cfg.showUnlockCondition) do
				if v.type == "dungeon" then
					local id = tonumber(v.value)

					if id == dungeonId then
						co = cfg

						break
					end
				end
			end
		end
	end

	local unlockCondition = co and co.unlockCondition or {}
	local showUnlockCondition = co and co.showUnlockCondition or {}
	local preDungeonId = 0
	local plotId = 0
	local plotValue

	for _, v in ipairs(unlockCondition) do
		if v.type == "dungeon" then
			preDungeonId = tonumber(v.value)
		elseif v.type == "plot" then
			plotValue = v.value
		end
	end

	for _, v in ipairs(showUnlockCondition) do
		if v.type == "dungeon" then
			preDungeonId = tonumber(v.value)
		end
	end

	if preDungeonId > 0 then
		local plotCo = DungeonConfig.instance:getDungeonCfgById(preDungeonId)

		plotCo = plotCo or DungeonConfig.instance:getMainlinePlotDungeonCOByDungeonId(preDungeonId)
		plotId = plotCo and plotCo.plotBeforeBattle or 0
	end

	return plotId, plotValue
end

function sortMonster(ma, mb)
	if ma.monsterType ~= mb.monsterType then
		return ma.monsterType > mb.monsterType
	else
		return ma.id < mb.id
	end
end
