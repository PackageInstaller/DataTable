local MemoryStoryLineNode = class("MemoryStoryLineNode", import("model.vo.BaseVO"))

function MemoryStoryLineNode:bindConfigTable()
	return pg.memory_storyline
end

function MemoryStoryLineNode:GetColumn()
	return self:getConfig("column")
end

function MemoryStoryLineNode:GetRow()
	return self:getConfig("row")
end

function MemoryStoryLineNode:GetIcon()
	return self:getConfig("icon")
end

function MemoryStoryLineNode:GetLinkEvent()
	return self:getConfig("link_event")
end

function MemoryStoryLineNode:GetName()
	return self:getConfig("name")
end

function MemoryStoryLineNode:GetNations()
	return self:getConfig("shipnation")
end

function MemoryStoryLineNode:GetDesc()
	return self:getConfig("description")
end

function MemoryStoryLineNode:GetChapter()
	return self:getConfig("chapter")
end

function MemoryStoryLineNode:GetBGM()
	return self:getConfig("bgm")
end

function MemoryStoryLineNode:GetMemoryID()
	return self:getConfig("memory_id")
end

function MemoryStoryLineNode:GetWorldID()
	return self:getConfig("world_id")
end

function MemoryStoryLineNode:IsMemoryBlock()
	return self:getConfig("memory_lock") == 1
end

MemoryStoryLineNode.MARK_NAME = {
	"mark_blue",
	"mark_red",
	"mark_golden"
}

function MemoryStoryLineNode:GetMark()
	return MemoryStoryLineNode.MARK_NAME[self:getConfig("sort")]
end

return MemoryStoryLineNode
