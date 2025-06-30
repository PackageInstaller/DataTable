--[[   
    小阵型
]]
module('fightUI.FightSmallFormatView', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
    super.initData(self, rootGo)
    self.m_grids = {}
    for k, v in pairs(self.m_childTrans) do
        local gridId = tonumber(k)
        if gridId then
            self.m_grids[gridId] = v
        end
    end
    self.m_flagGrids = {}
end

function setItemPrefabPath(self, prefabPath)
    self.m_itemPrefabPath = prefabPath
end

function setScaleX(self, scaleX)
    self.m_itemScaleX = scaleX
end

function removeFlag(self, gridId)
    local flagData = self.m_flagGrids[gridId]
    if flagData then
        flagData:destroy()
        -- gs.GameObject.Destroy(flagData[1])
        self.m_flagGrids[gridId] = nil
    end
end

function closeAllFlag(self)
    for k, flagData in pairs(self.m_flagGrids) do
        flagData.m_go:SetActiveLocal(false)
    end
end

-- 普通状态
function setNorFlag(self, gridId)
    local item = self:getGridItem(gridId)
    item:setNorFlag(true)
end

-- 死亡状态
function setDisableFlag(self, gridId)
    local item = self:getGridItem(gridId)
    item:setDeadFlag(true)
end

-- 设置攻击者状态
function setAttackFlag(self, gridId)
    local item = self:getGridItem(gridId)
    item:setAttackFlag(true)
end

-- 受击者状态
function setTargetFlag(self, gridId)
    local item = self:getGridItem(gridId)
    item:setTargetFlag(true)
end

function setNoHpFlag(self,gridId,isDed)
    local item = self:getGridItem(gridId)
    item:setNoHp(true,isDed)
end

-- 取对应的格子
function getGridItem(self, gridId)
    local parent = self.m_grids[gridId]
    if not parent then return end
    local flagData = self.m_flagGrids[gridId]
    if flagData then
        flagData.m_go:SetActiveLocal(true)
        return flagData
    end

    local item = fightUI.FightSmallFormatItem.new()
    item:setup(self.m_itemPrefabPath)
    item:addOnParent(parent)
    self.m_flagGrids[gridId] = item
    if self.m_itemScaleX ~= nil then
        gs.TransQuick:ScaleX(item.m_trans, self.m_itemScaleX)
    end
    return item
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
