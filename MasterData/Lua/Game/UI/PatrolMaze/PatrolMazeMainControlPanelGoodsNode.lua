-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主界面 - 控制面板 - 道具节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-17 11:52:32
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

--- from: Assets/BundleResources/Prefabs/Patrol/PartolBtnLeftNode130201.prefab > name: Cell
---@class PatrolMazeMainControlPanelGoodsNode
---@field Env                           	PatrolMazeMainControlPanelGoodsNode     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field SelectImg                     	UnityEngine.RectTransform               @ 选中图片
---@field GoodNode                      	UnityEngine.RectTransform               @ 道具节点
---@field RootNode                      	UnityEngine.RectTransform               @ 根节点
local PatrolMazeMainControlPanelGoodsNode = Class('PatrolMazeMainControlPanelGoodsNode')


function PatrolMazeMainControlPanelGoodsNode:__init()
    ---@type GoodNodeMB
    self.goodsNodeEnv_ = nil
end


function PatrolMazeMainControlPanelGoodsNode:__delete()
    self.goodsNodeEnv_ = nil
end


function PatrolMazeMainControlPanelGoodsNode:Awake()
    self.goodsNodeEnv_ = CfUtils.GetLuaScr(self.GoodNode, Constants.UILuaTablePath.GoodNodeMB)
    self.goodsNodeEnv_:SetClickCallback(Bind(self, self.OnClickGoodsNodeHandler_))
end


function PatrolMazeMainControlPanelGoodsNode:Start()
end


function PatrolMazeMainControlPanelGoodsNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function PatrolMazeMainControlPanelGoodsNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function PatrolMazeMainControlPanelGoodsNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function PatrolMazeMainControlPanelGoodsNode:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function PatrolMazeMainControlPanelGoodsNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function PatrolMazeMainControlPanelGoodsNode:GetClickCellCB()
    return self.clickCellCallback_
end
---@param callback fun(luaIndex:integer):void
function PatrolMazeMainControlPanelGoodsNode:SetClickCellCB(callback)
    self.clickCellCallback_ = callback
end


-------------------------------------------------
-- public

function PatrolMazeMainControlPanelGoodsNode:UpdateSelectStatus(isSelect)
    CfUtils.SetActive(self.SelectImg, isSelect)
end


function PatrolMazeMainControlPanelGoodsNode:UpdateGoodsNum()
    self:SetCellData(self:GetCellData())
end


-------------------------------------------------
-- private

function PatrolMazeMainControlPanelGoodsNode:UpdateCellInfo_()
    local cellData = self:GetCellData()
    local goodsId  = checkInt(cellData.goodsId)

    ---@type PatrolMazeAreaDojo
    local mapAreaDojo = cellData.mapAreaDojo

    self.goodsNodeEnv_:Reload({goodsId = goodsId, isShowNoX = true})
end


-------------------------------------------------
-- handler

function PatrolMazeMainControlPanelGoodsNode:OnClickGoodsNodeHandler_()
    if self:GetClickCellCB() then
        self:GetClickCellCB()(self:GetLuaIndex())
    end
end


return PatrolMazeMainControlPanelGoodsNode
