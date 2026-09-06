-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManBaseCell.lua

module("logic.extensions.beastrichman.view.BeastRichManBaseCell", package.seeall)

local BeastRichManBaseCell = class("BeastRichManBaseCell")

function BeastRichManBaseCell:ctor(nodes)
	self._nodes = nodes or {}
	self._cellType = BeastRichManEnum.CellType.None
end

function BeastRichManBaseCell:init(activityId, zoneId, uniqueId, offsetPosX, offsetPosY)
	self._activityId = activityId
	self._zoneId = zoneId
	self._uniqueId = uniqueId
	self._posX, self._posY = self:_getPos(activityId, zoneId, uniqueId)
	self._posX = self._posX + offsetPosX
	self._posY = self._posY + offsetPosY

	self:_initUI()
end

function BeastRichManBaseCell:_initUI()
	for _, node in pairs(self._nodes) do
		if node then
			node.name = "cell_" .. self._uniqueId

			GameUtil.setLocalPos(node, self._posX, self._posY, 0)
		end
	end
end

function BeastRichManBaseCell:updateUI()
	return
end

function BeastRichManBaseCell:trickCell()
	printError("触发基类 Cell: ", self._activityId, self._uniqueId)
end

function BeastRichManBaseCell:clearCell()
	return
end

function BeastRichManBaseCell:getNodeGo(key)
	return self._nodes[key]
end

function BeastRichManBaseCell:_getPos(activityId, zoneId, uniqueId)
	return BeastRichManMapMgr.instance:calCellPos(activityId, zoneId, uniqueId)
end

function BeastRichManBaseCell:destroy()
	for k, node in pairs(self._nodes) do
		if node then
			goutil.destroy(node)
		end
	end

	self._nodes = {}
end

return BeastRichManBaseCell
