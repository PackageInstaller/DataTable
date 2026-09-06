-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/BlockTagCell.lua

module("logic.extensions.qichallenge.view.BlockTagCell", package.seeall)

local BlockTagCell = class("BlockTagCell", CustomRightCell)

BlockTagCell.prefabUrl = "ui/views/qichallenge/blocktagcell.prefab"

function BlockTagCell:buildUI()
	self._targetCol = goutil.findChild(self.mainGO, "targetCol")

	GameUtil.SetActive(self._targetCol, false)
end

function BlockTagCell:onUpdateBlockTagActive(raceId)
	local blockIds = QiChallengeModel.instance:getBlockRaceIds()

	GameUtil.SetActive(self._targetCol, blockIds[raceId] == true)
end

function BlockTagCell:clearTargetCol()
	return
end

return BlockTagCell
