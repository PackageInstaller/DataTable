-------------------------------------------------------------------------------
-- 海外图鉴 - 猫球列表界面 - 猫球节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-20 21:49:32
-------------------------------------------------------------------------------

---@type IllustratedHandbookComponent
local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)
---@type CatBallUtils
local CatBallUtils = import("Game.CatBall.CatBallUtils")

local CELL_ANIM_NAME = {
    HIDE = 'IllustratedHandbookMainDialog_Cell_Hide',
    IDLE = 'IllustratedHandbookMainDialog_Cell_Idle',
    SHOW = 'IllustratedHandbookMainDialog_Cell_Entry',
    WAIT = 'IllustratedHandbookMainDialog_Cell_Wait',
}

--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustbookCatballFilesNode.prefab > name: IllustbookCatballFilesNode
---@class IllustratedHandbookCatballListCell
---@field Env                           	IllustratedHandbookCatballListCell      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field rootNode                      	UnityEngine.RectTransform               @ 根节点
---@field notLockNode                   	UnityEngine.RectTransform               @ 未解锁节点
---@field notGetNode                    	UnityEngine.RectTransform               @ 未获得节点
---@field catBallAttrImg                	UnityEngine.RectTransform               @ 猫球属性图片
---@field catBallNameTxt                	UnityEngine.RectTransform               @ 猫球名字文本
---@field catBallImg                    	UnityEngine.RectTransform               @ 猫球图片
---@field qualityImg2                   	UnityEngine.RectTransform               @ 质量图片2
---@field qualityImg1                   	UnityEngine.RectTransform               @ 质量图片1
---@field animRoot                      	UnityEngine.RectTransform               @ 动画根节点
local IllustratedHandbookCatballListCell = Class('IllustratedHandbookCatballListCell')


function IllustratedHandbookCatballListCell:__init()
end


function IllustratedHandbookCatballListCell:__delete()
end


function IllustratedHandbookCatballListCell:Awake()
    SetButtonAction(self.rootNode, Bind(self, self.OnClickCollectCatBallCellHandler_))
    self:PlayAnimByHide()
end


function IllustratedHandbookCatballListCell:Start()
end


function IllustratedHandbookCatballListCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function IllustratedHandbookCatballListCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function IllustratedHandbookCatballListCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function IllustratedHandbookCatballListCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function IllustratedHandbookCatballListCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer, sender:IllustratedHandbookCatballListCell):void
function IllustratedHandbookCatballListCell:GetClickGridCellCB()
    return self.clickGridCellCallback_
end
---@param callback fun(luaIndex:integer, sender:IllustratedHandbookCatballListCell):void
function IllustratedHandbookCatballListCell:SetClickGridCellCB(callback)
    self.clickGridCellCallback_ = callback
end


-------------------------------------------------
-- public

function IllustratedHandbookCatballListCell:PlayAnimByHide()
    CfUtils.PlayAnimation(self.animRoot, CELL_ANIM_NAME.HIDE)
end


function IllustratedHandbookCatballListCell:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.animRoot, CELL_ANIM_NAME.IDLE)
end


function IllustratedHandbookCatballListCell:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.animRoot, delayIndex, CELL_ANIM_NAME.SHOW, CELL_ANIM_NAME.WAIT)
end


-------------------------------------------------
-- private

function IllustratedHandbookCatballListCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type CatBallVo
    local catBallVo = cellData.catBallVo

    -- update catBall name
    CfUtils.FillText(self.catBallNameTxt, tostring(catBallVo.name))

    -- update catBall image
    CfUtils.FillImage(self.catBallImg, tostring(catBallVo.picture))

    -- update catBall attr
    local attrIconPath = CatBallUtils.GetAttributeIcon(catBallVo.types, catBallVo.subtype)
    CfUtils.FillImage(self.catBallAttrImg, attrIconPath)

    -- update catBall rare
    local catBallRare = catBallVo.rare
    CfUtils.SetUISwitchImage(self.qualityImg1, catBallRare)
    CfUtils.SetUISwitchImage(self.qualityImg2, catBallRare)

    -- update cell state
    self:UpdateCellState_()
end


function IllustratedHandbookCatballListCell:UpdateCellState_()
    local cellData = self:GetCellData()

    ---@type CatBallVo
    local catBallVo = cellData.catBallVo
    local catBallId = checkInt(catBallVo.roleId)
    local isOwned   = illustratedHandbookComp:IsHandbookOwned(Constants.HandbookCollectionType.CAT_BALL, catBallId)
    local isUnlock  = illustratedHandbookComp:IsHandbookUnlock(Constants.HandbookCollectionType.CAT_BALL, catBallId)
    CfUtils.SetActive(self.notGetNode, not isOwned)

    CfUtils.SetActive(self.notLockNode, isOwned and not isUnlock)
end


-------------------------------------------------
-- handler

function IllustratedHandbookCatballListCell:OnClickCollectCatBallCellHandler_()
    if self:GetClickGridCellCB() then
        self:GetClickGridCellCB()(self:GetLuaIndex(), self)
    end
end


return IllustratedHandbookCatballListCell
