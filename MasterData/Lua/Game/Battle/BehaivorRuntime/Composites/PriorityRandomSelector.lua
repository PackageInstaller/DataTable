--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:luqucheng
    time:2020-08-07 11:15:17
]]
import 'Game.Battle.BehaivorRuntime.Core.Composite'

local priorityRandomSelector = b3.Class("PriorityRandomSelector", b3.Composite)
b3.PriorityRandomSelector = priorityRandomSelector

function priorityRandomSelector:__init()
	b3.Composite.__init(self)

	self.name = "PriorityRandomSelector"
end

function priorityRandomSelector:tick(tick)
    local ws = Tools.splitToNum(self.properties.weights, ";")

    --用于记录序号
    local indexes = {}
    for i = 1,#self.children do
        table.insert(indexes, i)
    end
    while #ws < #self.children do
        table.insert(ws, 0)
    end
    --根据权重随机排序
    local childs = {}
    for i,v in fipairs(ws) do
        local index = self:weightRandom(ws, 1, i)
        -- print("priorityRandomSelector", index, table.toString(indexes,"indexes"))
        --读取对应的序号的子节点加入
        table.insert(childs, self.children[indexes[index]])
        table.remove(ws, index)
        table.remove(indexes, index)
    end

    
    for i = 1,table.getn(childs) do
		local v = childs[i]
        local status = v:_execute(tick)
        
		if status == b3.SUCCESS then
			return status
		end
    end
	return b3.FAILURE
end

function priorityRandomSelector:weightRandom( array, startIndex, endIndex )
    local total = 0
    for i=startIndex,endIndex do
        total = total + array[i]
    end

    local r = 0
    if Core then
        r = Core.Random() * total
    else
        r = math.random() * total
    end

    for i = startIndex, endIndex do
        local v = array[i]
        if r <= v then
            return i
        end
        r = r - v
    end

    return startIndex
end