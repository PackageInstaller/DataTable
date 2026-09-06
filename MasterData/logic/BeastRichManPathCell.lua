-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManPathCell.lua

module("logic.extensions.beastrichman.view.BeastRichManPathCell", package.seeall)

local json = require("cjson")
local BeastRichManPathCell = class("BeastRichManPathCell", BeastRichManBaseCell)

function BeastRichManPathCell:trickCell(activityId, gridId, isFinish)
	if not isFinish then
		local activityId = self._activityId
		local zoneId = self._zoneId

		if self._gridType == BeastRichManEnum.CellType.StorySelect or self._gridType == BeastRichManEnum.CellType.StoryPlay then
			local gridCfg = BeastRichmanConfig.instance:getGridCfgById(activityId, zoneId, gridId)
			local storyId = checknumber(gridCfg.gridParam)
			local storyCfg = BeastRichmanConfig.instance:getStoryCfgById(activityId, storyId)

			if storyCfg.type == BeastRichManEnum.StoryType.Select then
				UIStateManager.instance:push(ViewName.BeastRichManStorySelectView, activityId, zoneId, self._gridId)
			else
				self:_playStory(activityId, zoneId, self._gridId)
			end

			return false
		elseif self._gridType == BeastRichManEnum.CellType.Game then
			local gridParam = BeastRichmanController.instance:curGridParam(activityId, zoneId)
			local gameId = checknumber(gridParam) > 0 and checknumber(gridParam) or 1

			UIStateManager.instance:push(ViewName.BeastRichManGameSelectView, activityId, zoneId, self._gridId, gameId)

			return false
		end
	end

	return true
end

function BeastRichManPathCell:showServerAutoFinish()
	local activityId = self._activityId
	local zoneId = self._zoneId

	if self._gridType == BeastRichManEnum.CellType.GainCard then
		local param = BeastRichmanController.instance:curGridParam(activityId, zoneId)
		local cardId = checknumber(param)
		local cardCfg = BeastRichmanConfig.instance:getCardCfg(activityId, cardId)
		local matStr = cardCfg.matStr
		local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
		local matMo = MaterialModel.instance:getMaterialMo(matType, matId)

		if not matMo then
			MaterialModel.instance:AddMaterial(matType, matId, 1)
		end

		local moList = {}
		local mo = MaterialModel.instance:createMo(matType, matId, matNum)

		table.insert(moList, mo)

		if #moList > 0 then
			local clientChangeSetId = MaterialController.instance:getClientChangeSetId(true)

			MaterialController.instance:showChangeSetItemMo(moList, clientChangeSetId)
		end
	end
end

function BeastRichManPathCell:init(activityId, zoneId, gridId, offsetPosX, offsetPosY)
	local gridCfg = BeastRichmanConfig.instance:getGridCfg(activityId, zoneId, gridId)

	self._gridId = gridId
	self._gridType = gridCfg.gridType

	BeastRichManPathCell.super.init(self, activityId, zoneId, gridCfg.uniqueId, offsetPosX, offsetPosY)
end

function BeastRichManPathCell:_initUI()
	BeastRichManPathCell.super._initUI(self)

	local pathGo = self:getNodeGo("path")

	if pathGo then
		self._changeSpriteComp = goutil.findChild(pathGo, "imgPath"):GetComponent(ComponentType.UIImageSpriteChange)

		self._changeSpriteComp:SetState(self._gridType)
	end

	local bgGo = self:getNodeGo("bg")

	if bgGo then
		local gridCfg = BeastRichmanConfig.instance:getGridCfg(self._activityId, self._zoneId, self._gridId)
		local change = bgGo:GetComponent(ComponentType.UIImageSpriteChange)

		if gridCfg.beastType > 0 and gridCfg.beastId > 0 then
			local cfg

			change:ChangeSprite((gridCfg.beastType == BeastRichManEnum.BossType.Boss and BeastRichmanConfig.instance:getBossCfgById(self._activityId, gridCfg.beastId) or BeastRichmanConfig.instance:getBeakStageCfg(self._activityId, gridCfg.beastId, 1)).iconName)
		else
			change:ChangeSprite("board_ruishoudamaoxian_gz09")
		end
	end
end

function BeastRichManPathCell:_playStory(activityId, zoneId, gridId)
	local gridCfg = BeastRichmanConfig.instance:getGridCfgById(activityId, zoneId, gridId)
	local storyId = checknumber(gridCfg.gridParam)
	local storyCfg = BeastRichmanConfig.instance:getStoryCfgById(activityId, storyId)
	local playStoryId = checknumber(storyCfg.playStoryId)

	if playStoryId > 0 then
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, playStoryId)
	end
end

return BeastRichManPathCell
