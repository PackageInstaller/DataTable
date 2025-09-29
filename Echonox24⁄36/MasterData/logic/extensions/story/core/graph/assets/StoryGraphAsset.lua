-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/assets/StoryGraphAsset.lua

module("logic.extensions.story.core.graph.assets.StoryGraphAsset", package.seeall)

local M = class("StoryGraphAsset")

function M:ctor()
	self.settingData = nil
	self.containerNodes = {}
	self.containerEdges = {}
end

function M.__index(tb, key)
	if key == "Count" then
		return #tb.containerNodes
	end

	return tb[key]
end

function M:GetNode(index)
	if index < 0 or index > #self.containerNodes then
		return nil
	end

	return self.containerNodes[index]
end

function M:FindContainerByGUID(uid)
	for index, value in ipairs(self.containerNodes) do
		if value.GUID == uid then
			return value
		end
	end

	return nil
end

function M:IndexOf(shotId)
	for index, value in ipairs(self.containerNodes) do
		if value.ShotID == shotId then
			return index
		end
	end

	return -1
end

function M:ContainEdge(edge)
	for key, value in pairs(self.containerEdges) do
		if value == edge then
			return true
		end
	end

	return false
end

function M:ContainEdgeByFromToID(sourceId, targetId)
	return self:Any(self.containerEdges, function(item)
		return item.baseNodeGuid == sourceId and item.targetNodeGuid == targetId
	end)
end

function M:ContainEdgeByType(type)
	return self:Any(self.containerEdges, function(item)
		return item.containerLinkType == type
	end)
end

function M:AddEdge(edge)
	if not edge then
		printError("edge is nil..........")

		return
	end

	table.insert(self.containerEdges, edge)
end

function M:RemoveEdge(edge)
	table.removebyvalue(self.containerEdges, edge, true)
end

function M:RemoveEdgesByFromToID(sourceId, targetId)
	self:RemoveAll(self.containerEdges, function(item)
		return item.baseNodeGuid == sourceId and item.targetNodeGuid == targetId
	end)
end

function M:RemoveEdgesByFromIDAndType(sourceId, type)
	self:RemoveAll(self.containerEdges, function(item)
		return item.baseNodeGuid == sourceId and item.containerLinkType == type
	end)
end

function M:RemoveAllEdgesByFromID(sourceId)
	self:RemoveAll(self.containerEdges, function(item)
		return item.baseNodeGuid == sourceId
	end)
end

function M:FindEdgesByFromToID(sourceId, targetId)
	local tb = {}

	for index, value in ipairs(self.containerEdges) do
		if value.baseNodeGuid == sourceId and value.targetNodeGuid == targetId then
			tb[#tb + 1] = value
		end
	end

	return tb
end

function M:FindAnyOutEdgeByFromID(sourceId)
	for index, value in ipairs(self.containerEdges) do
		if value.baseNodeGuid == sourceId then
			return value
		end
	end

	return nil
end

function M:FindAnyOutEdgeByFromIDAndType(sourceId, type)
	for index, value in ipairs(self.containerEdges) do
		if value.baseNodeGuid == sourceId and value.containerLinkType == type then
			return value
		end
	end

	return nil
end

function M:FindOutEdgesByFromIDAndType(sourceId, type)
	local tb = {}

	for index, value in ipairs(self.containerEdges) do
		if value.baseNodeGuid == sourceId and value.containerLinkType == type then
			tb[#tb + 1] = value
		end
	end

	return tb
end

function M:FindOutEdgesByFromIDAndTypeOutList(sourceId, type, outList)
	for index, value in ipairs(self.containerEdges) do
		if value.baseNodeGuid == sourceId and value.containerLinkType == type then
			outList[#outList + 1] = value
		end
	end
end

function M:FindAllOutEdgesByFromIdOutList(sourceId, outList)
	for index, value in ipairs(self.containerEdges) do
		if value.baseNodeGuid == sourceId then
			outList[#outList + 1] = value
		end
	end
end

function M:FindAnyInEdgeByToID(targetId)
	for index, value in ipairs(self.containerEdges) do
		if value.targetNodeGuid == targetId then
			return value
		end
	end

	return nil
end

function M:Any(tbData, func)
	if not tbData then
		return false
	end

	for key, value in pairs(tbData) do
		if func(value) then
			return true
		end
	end

	return false
end

function M:RemoveAll(tbData, func)
	if not tbData then
		return
	end

	local count = #tbData

	for i = count, 1, -1 do
		local item = tbData[i]

		if func(item) then
			table.remove(tbData, i)
		end
	end
end

return M
