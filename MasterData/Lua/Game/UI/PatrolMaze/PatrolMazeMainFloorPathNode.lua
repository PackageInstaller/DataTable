-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主界面 - 层级路径节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-03 20:04:12
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

local FloorLevelNodePath = 'Game.UI.PatrolMaze.PatrolMazeMainFloorLevelNode'
local FloorLevelNodeName = 'EventDisplayNode'

--- from: Assets/BundleResources/Prefabs/Patrol/PatrolMainDialog130201.prefab > name: Cell
---@class PatrolMazeMainFloorPathNode
---@field Env                           	PatrolMazeMainFloorPathNode             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field LineRootNode                  	UnityEngine.RectTransform               @ 路线跟节点
---@field LevelCellNode                 	UnityEngine.RectTransform               @ 层级单元节点
---@field LevelRootNode                 	UnityEngine.RectTransform               @ 层级跟节点
---@field AnimNode                      	UnityEngine.RectTransform               @ 动画节点
---@field RootNode                      	UnityEngine.RectTransform               @ 跟节点
local PatrolMazeMainFloorPathNode = Class('PatrolMazeMainFloorPathNode')


function PatrolMazeMainFloorPathNode:__init()
    ---@type UnityEngine.Transform @ 上一次显示的路线节点
    self.prevLineNode_ = nil

    ---@type PatrolMazeMainFloorLevelNode[] @ 层级单元节点列表
    self.levelNodeEnvList_ = {}
end


function PatrolMazeMainFloorPathNode:__delete()
    self.prevLineNode_     = nil
    self.levelNodeEnvList_ = nil
end


function PatrolMazeMainFloorPathNode:Awake()
    self:PlayAnimByHide()
end


function PatrolMazeMainFloorPathNode:Start()
end


function PatrolMazeMainFloorPathNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function PatrolMazeMainFloorPathNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function PatrolMazeMainFloorPathNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function PatrolMazeMainFloorPathNode:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function PatrolMazeMainFloorPathNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return PatrolMazeAreaDojo
function PatrolMazeMainFloorPathNode:GetAreaDojo()
    return self:GetCellData().areaDojo
end


---@return PatrolMazeFloorPathDojo
function PatrolMazeMainFloorPathNode:GetPathDojo()
    return self:GetCellData().pathDojo
end


---@return fun(pathNode:PatrolMazeMainFloorPathNode, levelNode:PatrolMazeMainFloorLevelNode):void
function PatrolMazeMainFloorPathNode:GetClickLevelNodeCb()
    return self.clickLevelNodeCb_
end
---@param callback fun(pathNode:PatrolMazeMainFloorPathNode, levelNode:PatrolMazeMainFloorLevelNode):void
function PatrolMazeMainFloorPathNode:SetClickLevelNodeCb(callback)
    self.clickLevelNodeCb_ = callback
end


---@return integer
function PatrolMazeMainFloorPathNode:GetClickLevelIndex()
    return checkInt(self.clicLevelIndex_)
end
---@param levelIndex integer
function PatrolMazeMainFloorPathNode:SetClickLevelIndex(levelIndex)
    self.clicLevelIndex_ = checkInt(levelIndex)
    self:UpdateClickLevelIndex_()
end


---@return PatrolMazeMainFloorLevelNode[]
function PatrolMazeMainFloorPathNode:GetLevelNodeEnvList()
    return checkTable(self.levelNodeEnvList_)
end


-------------------------------------------------
-- public

function PatrolMazeMainFloorPathNode:PlayAnimByHide()
    CfUtils.PlayAnimation(self.AnimRoot, 'UI_Common_List_Cell_Hide')
end


function PatrolMazeMainFloorPathNode:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.AnimRoot, 'UI_Common_List_Cell_Idle')
end


function PatrolMazeMainFloorPathNode:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.AnimRoot, delayIndex, 'PatrolMainDialog130201_Cell_Show')
end


-------------------------------------------------
-- private

function PatrolMazeMainFloorPathNode:UpdateCellInfo_()
    local cellData = self:GetCellData()
    local areaDojo = self:GetAreaDojo()
    local pathDojo = self:GetPathDojo()

    -- update lineNode
    CfUtils.SetActive(self.prevLineNode_, false)
    local floorPathVo  = PatrolMazeUtils.GetFloorPathVo(pathDojo.floorPathId)
    local pathLineNode = not string.isEmpty(floorPathVo.lineName) and self.LineRootNode:Find(floorPathVo.lineName) or nil
    self.prevLineNode_ = pathLineNode
    CfUtils.SetActive(self.prevLineNode_, true)

    local isCurrentFloor = self:GetLuaIndex() == areaDojo.floorPassed + 1
    CfUtils.SetCanvasGroupAlpha(self.prevLineNode_, isCurrentFloor and 1 or 0.5)

    -- update all levelNode
    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.LevelRootNode, self.LevelCellNode, floorPathVo.childNum, function(luaIndex, childNode)
        childNode.name = FloorLevelNodeName .. luaIndex
        local cellEnv   = self.levelNodeEnvList_[luaIndex]
        local levelDojo = pathDojo.levelDojoList[luaIndex]
        if not cellEnv then
            cellEnv = CfUtils.GetLuaScr(childNode, FloorLevelNodePath)
            self.levelNodeEnvList_[luaIndex] = cellEnv
        end
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData({
            areaDojo  = areaDojo, 
            pathDojo  = pathDojo, 
            levelDojo = levelDojo,
        })
        cellEnv:SetClickCellCb(Bind(self, self.OnCliCkLevelNodeCallback_))
    end)
end


function PatrolMazeMainFloorPathNode:UpdateClickLevelIndex_()
    local clickLevelIndex = self:GetClickLevelIndex()
    for levelIndex, levelNodeEnv in ipairs(self:GetLevelNodeEnvList()) do
        if clickLevelIndex > 0 then
            levelNodeEnv:SwitchSelectState(true, levelIndex == clickLevelIndex)
        else
            levelNodeEnv:SwitchSelectState(false, false)
        end
    end
end


-------------------------------------------------
-- handler

---@param levelNode PatrolMazeMainFloorLevelNode
function PatrolMazeMainFloorPathNode:OnCliCkLevelNodeCallback_(levelNode)
    if self:GetClickLevelNodeCb() then
        self:GetClickLevelNodeCb()(self, levelNode)
    end
end


return PatrolMazeMainFloorPathNode
