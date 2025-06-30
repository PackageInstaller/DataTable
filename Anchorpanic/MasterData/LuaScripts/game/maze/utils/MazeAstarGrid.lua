module("maze.MazeAstarGrid", Class.impl())

function ctor(self)
    self:__init()
end

function __init(self)
    self.row = nil
    self.col = nil

    self.f = nil
    self.g = nil
    self.h = nil

    -- 消耗成本
    self.mCostMultiplier = 1
    -- 是否在开放列表中
    self.open = false
    -- 父节点
    self.parent = nil
    -- 是否可走
    self.canWalk = true
    -- 邻近节点
    self:setNearGridList(nil)
end

function setNearGridList(self, nearList)
    self.mNearList = nearList
end

function getNearGridList(self)
    return self.mNearList
end

function setCostMultiplier(self, cost)
    self.mCostMultiplier = cost
end

function getCostMultiplier(self)
    return self.mCostMultiplier
end

function onRecover(self)
    self:__init()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
