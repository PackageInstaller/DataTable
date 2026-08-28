-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主界面 - 控制面板 - 效果节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-17 11:52:32
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

--- from: Assets/BundleResources/Prefabs/Patrol/PartolBtnLeftNode130201.prefab > name: Cell
---@class PatrolMazeMainControlPanelBuffNode
---@field Env                           	PatrolMazeMainControlPanelBuffNode      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BuffDescrTxt                  	UnityEngine.RectTransform               @ 效果描述 文本
---@field BuffNameTxt                   	UnityEngine.RectTransform               @ 效果名字 文本
---@field BuffIconImg                   	UnityEngine.RectTransform               @ 效果图标 图片
---@field RareBgImg                     	UnityEngine.RectTransform               @ 品质背景
---@field GoodsBgImg                    	UnityEngine.RectTransform               @ 道具背景
---@field AnimRoot                      	UnityEngine.RectTransform               @ 动画节点
---@field RootNode                      	UnityEngine.RectTransform               @ 根节点
local PatrolMazeMainControlPanelBuffNode = Class('PatrolMazeMainControlPanelBuffNode')


function PatrolMazeMainControlPanelBuffNode:__init()
end


function PatrolMazeMainControlPanelBuffNode:__delete()
end


function PatrolMazeMainControlPanelBuffNode:Awake()
end


function PatrolMazeMainControlPanelBuffNode:Start()
end


function PatrolMazeMainControlPanelBuffNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function PatrolMazeMainControlPanelBuffNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function PatrolMazeMainControlPanelBuffNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function PatrolMazeMainControlPanelBuffNode:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function PatrolMazeMainControlPanelBuffNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


-------------------------------------------------
-- private

function PatrolMazeMainControlPanelBuffNode:UpdateCellInfo_()
    local cellData = self:GetCellData()
    local buffType = checkInt(cellData.buffType)
    local buffId   = checkInt(cellData.buffId)
    
    ---@type PatrolMazeRelicVo | PatrolMazeCurseVo | PatrolMazeGoodsVo
    local buffVo = nil
    if buffType == 1 then
        buffVo = PatrolMazeUtils.GetMazeRelicVo(buffId)
        CfUtils.SetActive(self.RareBgImg, true)
        CfUtils.SetActive(self.GoodsBgImg, false)
    elseif buffType == 2 then
        buffVo = PatrolMazeUtils.GetMazeCurseVo(buffId)
        CfUtils.SetActive(self.RareBgImg, true)
        CfUtils.SetActive(self.GoodsBgImg, false)
    elseif buffType == 3 then
        buffVo = PatrolMazeUtils.GetMazeGoodsVo(buffId)
        CfUtils.SetActive(self.RareBgImg, false)
        CfUtils.SetActive(self.GoodsBgImg, true)
    end

    if buffVo then
        CfUtils.FillText(self.BuffNameTxt, buffVo.name)
        CfUtils.FillText(self.BuffDescrTxt, buffVo.descr)
        CfUtils.FillImage(self.BuffIconImg, buffVo.iconPath)
        CfUtils.SetUISwitchImage(self.RareBgImg, buffVo.quality)
        CfUtils.SetUISwitchImage(self.GoodsBgImg, buffVo.quality)
    end
end


return PatrolMazeMainControlPanelBuffNode
