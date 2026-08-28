-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主界面 - 宝箱节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-04-28 12:01:07
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/Patrol/PatrolMainChestCell130201.prefab > name: PatrolMainChestCell130201
---@class PatrolMazeMainChestCell
---@field Env                           	PatrolMazeMainChestCell                 
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field ScoreSlider                   	UnityEngine.RectTransform               	@ 1    分数进度条
---@field EndPointImg                   	UnityEngine.RectTransform               	@ 2    重点圆点图
---@field ChestBtn                      	UnityEngine.RectTransform               	@ 3    宝箱按钮
---@field ChestIcon                     	UnityEngine.RectTransform               	@ 4    宝箱图标
---@field ChestIconBlack                	UnityEngine.RectTransform               	@ 5    宝箱图标阴影
---@field ScoreTxt                      	UnityEngine.RectTransform               	@ 6    分数文本
---@field GetNode                       	UnityEngine.RectTransform               	@ 7    已获得节点
---@field CanReciveUIFX                 	UnityEngine.RectTransform               	@ 8    能获得特效
local PatrolMazeMainChestCell = Class('PatrolMazeMainChestCell')


function PatrolMazeMainChestCell:__init()
end


function PatrolMazeMainChestCell:__delete()
end


function PatrolMazeMainChestCell:Awake()
end


function PatrolMazeMainChestCell:Start()
    SetButtonAction(self.ChestBtn, Bind(self, self.OnClickChestButtonHandler_))
end


function PatrolMazeMainChestCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function PatrolMazeMainChestCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function PatrolMazeMainChestCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function PatrolMazeMainChestCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function PatrolMazeMainChestCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function PatrolMazeMainChestCell:GetClickChestCB()
    return self.clickChestCallback_
end
---@param callback fun(luaIndex:integer):void
function PatrolMazeMainChestCell:SetClickChestCB(callback)
    self.clickChestCallback_ = callback
end


---@return number
function PatrolMazeMainChestCell:GetScorePercent()
    return checkNumber(self.scorePercent_)
end
---@param percent number
function PatrolMazeMainChestCell:SetScorePercent(percent)
    self.scorePercent_ = checkNumber(percent)
    self:UpdateProgressInfo_()
end


-------------------------------------------------
-- public

function PatrolMazeMainChestCell:UpdateCellState()
    local cellData = self:GetCellData()

    ---@type PatrolMazeFloorRewardVo
    local rewardVo = checkTable(cellData.rewardVo)

    ---@type PatrolMazeAreaDojo
    local mapAreaDojo = checkTable(cellData.mapAreaDojo)
    
    local hasDrawn = mapAreaDojo:HasFloorRewardDrawn(rewardVo.rewardId)
    CfUtils.SetActive(self.GetNode, hasDrawn)
    
    local isPercentFull = self:GetScorePercent() >= 1
    CfUtils.SetActive(self.CanReciveUIFX, not hasDrawn and isPercentFull)
end


-------------------------------------------------
-- private

function PatrolMazeMainChestCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type PatrolMazeFloorRewardVo
    local rewardVo = checkTable(cellData.rewardVo)
    CfUtils.FillText(self.ScoreTxt, checkInt(rewardVo.scoreNum))

    local iconPath = rewardVo.chestIcon
    CfUtils.FillImage(self.ChestIcon, iconPath)
    CfUtils.FillImage(self.ChestIconBlack, iconPath)

    -- update view
    self:UpdateProgressInfo_()
end


function PatrolMazeMainChestCell:UpdateProgressInfo_()
    CfUtils.SetSliderPercent(self.ScoreSlider, self:GetScorePercent())

    local isPercentFull = self:GetScorePercent() >= 1
    CfUtils.SetUISwitchImage(self.EndPointImg, isPercentFull and 2 or 1)

    self:UpdateCellState()
end


-------------------------------------------------
-- handler

function PatrolMazeMainChestCell:OnClickChestButtonHandler_()
    if self:GetClickChestCB() then
        self:GetClickChestCB()(self:GetLuaIndex(), self.ChestBtn)
    end
end


return PatrolMazeMainChestCell
