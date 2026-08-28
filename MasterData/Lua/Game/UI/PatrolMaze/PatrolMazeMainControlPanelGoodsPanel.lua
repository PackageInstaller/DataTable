-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主界面 - 控制面板 - 道具信息面板
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-18 14:48:35
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

--- from: Assets/BundleResources/Prefabs/Patrol/PartolBtnLeftNode130201.prefab > name: RightGroup
---@class PatrolMazeMainControlPanelGoodsPanel
---@field Env                           	PatrolMazeMainControlPanelGoodsPanel    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field GoodsUseBtn                   	UnityEngine.RectTransform               @ 道具使用按钮
---@field GoodsDescrTxt                 	UnityEngine.RectTransform               @ 道具描述文本
---@field GoodsNumTxt                   	UnityEngine.RectTransform               @ 道具数量文本
---@field GoodsIconImg                  	UnityEngine.RectTransform               @ 道具图标图片
---@field GoodsRareImg                  	UnityEngine.RectTransform               @ 道具品质图片
---@field GoodsNameTxt                  	UnityEngine.RectTransform               @ 道具名字文本
---@field RootNode                      	UnityEngine.RectTransform               @ 根节点
local PatrolMazeMainControlPanelGoodsPanel = Class('PatrolMazeMainControlPanelGoodsPanel')


function PatrolMazeMainControlPanelGoodsPanel:__init()
    ---@type PatrolMazeAreaDojo @ 当前所在区域dojo
    self.mapAreaDojo_ = nil
end


function PatrolMazeMainControlPanelGoodsPanel:__delete()
    self.mapAreaDojo_ = nil
end


function PatrolMazeMainControlPanelGoodsPanel:Awake()
    SetButtonAction(self.GoodsUseBtn, Bind(self, self.OnClickGoodsUseButtonHandler_))
end


function PatrolMazeMainControlPanelGoodsPanel:Start()
end


function PatrolMazeMainControlPanelGoodsPanel:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return PatrolMazeMainDialog
function PatrolMazeMainControlPanelGoodsPanel:GetMainDialog()
    return self.mainDialog_
end
function PatrolMazeMainControlPanelGoodsPanel:SetMainDialog(mainDialog)
    self.mainDialog_  = mainDialog
    self.mapAreaDojo_ = self:GetMainDialog():GetMapAreaDojo()
end


---@return fun(index:integer):void
function PatrolMazeMainControlPanelGoodsPanel:GetSelectIndex()
    return checkInt(self.selectIndex_)
end
function PatrolMazeMainControlPanelGoodsPanel:SetSelectIndex(selectIndex)
    self.selectIndex_ = checkInt(selectIndex)
    self:UpdateMazeGoodsInfo_()
end


---@return fun(index:integer):void
function PatrolMazeMainControlPanelGoodsPanel:GetGoodsUseCb()
    return self.goodsUseCb_
end
function PatrolMazeMainControlPanelGoodsPanel:SetGoodsUseCb(callback)
    self.goodsUseCb_ = callback
end


-------------------------------------------------
-- private

function PatrolMazeMainControlPanelGoodsPanel:UpdateMazeGoodsInfo_()
    local mazeGoodsId  = checkInt(self.mapAreaDojo_.mazeBackpackList[self:GetSelectIndex()])
    local mazeGoodsVo  = PatrolMazeUtils.GetMazeGoodsVo(mazeGoodsId)
    local mazeGoodsNum = self.mapAreaDojo_:GetBackpackGoodsNum(mazeGoodsId)
    
    CfUtils.FillText(self.GoodsNumTxt, string.fmt('x%1', mazeGoodsNum))
    CfUtils.FillText(self.GoodsNameTxt, mazeGoodsVo.name)
    CfUtils.FillText(self.GoodsDescrTxt, mazeGoodsVo.descr)
    CfUtils.FillImage(self.GoodsIconImg, mazeGoodsVo.iconPath)
    CfUtils.SetUISwitchImage(self.GoodsRareImg, mazeGoodsVo.quality)
end


-------------------------------------------------
-- handler

function PatrolMazeMainControlPanelGoodsPanel:OnClickGoodsUseButtonHandler_()
    if self:GetGoodsUseCb() then
        self:GetGoodsUseCb()(self:GetSelectIndex())
    end
end


return PatrolMazeMainControlPanelGoodsPanel
