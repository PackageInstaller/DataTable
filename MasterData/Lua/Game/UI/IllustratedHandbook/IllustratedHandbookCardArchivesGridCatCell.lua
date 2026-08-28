-------------------------------------------------------------------------------
-- 海外图鉴 - 卡牌档案 - 猫种节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-26 03:08:56
-------------------------------------------------------------------------------

---@type IllustratedHandbookComponent
local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)

local CELL_ANIM_NAME = {
    HIDE = 'IllustratedHandbookMainDialog_Cell_Hide',
    IDLE = 'IllustratedHandbookMainDialog_Cell_Idle',
    SHOW = 'IllustratedHandbookMainDialog_Cell_Entry',
    WAIT = 'IllustratedHandbookMainDialog_Cell_Wait',
}

--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustratedHandbookArchivesCatCell.prefab > name: IllustratedHandbookArchivesCatCell
---@class IllustratedHandbookCardArchivesGridCatCell
---@field Env                           	IllustratedHandbookCardArchivesGridCatCell
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field animRoot                      	UnityEngine.RectTransform               @ 动画根节点
---@field notLockNode                   	UnityEngine.RectTransform               @ 未解锁节点
---@field notGetNode                    	UnityEngine.RectTransform               @ 未获得节点
---@field catImg                        	UnityEngine.RectTransform               @ 猫种图片
---@field nameTxt                       	UnityEngine.RectTransform               @ 名字文本
---@field rootNode                      	UnityEngine.RectTransform               @ 根节点
local IllustratedHandbookCardArchivesGridCatCell = Class('IllustratedHandbookCardArchivesGridCatCell')


function IllustratedHandbookCardArchivesGridCatCell:__init()
end


function IllustratedHandbookCardArchivesGridCatCell:__delete()
end


function IllustratedHandbookCardArchivesGridCatCell:Awake()
    SetButtonAction(self.rootNode, Bind(self, self.OnClickCollectRoleCellHandler_))
    self:PlayAnimByHide()
end


function IllustratedHandbookCardArchivesGridCatCell:Start()
end


function IllustratedHandbookCardArchivesGridCatCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function IllustratedHandbookCardArchivesGridCatCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function IllustratedHandbookCardArchivesGridCatCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function IllustratedHandbookCardArchivesGridCatCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function IllustratedHandbookCardArchivesGridCatCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function IllustratedHandbookCardArchivesGridCatCell:GetClickGridCellCB()
    return self.clickGridCellCallback_
end
---@param callback fun(luaIndex:integer):void
function IllustratedHandbookCardArchivesGridCatCell:SetClickGridCellCB(callback)
    self.clickGridCellCallback_ = callback
end


-------------------------------------------------
-- public

function IllustratedHandbookCardArchivesGridCatCell:PlayAnimByHide()
    CfUtils.PlayAnimation(self.animRoot, CELL_ANIM_NAME.HIDE)
end


function IllustratedHandbookCardArchivesGridCatCell:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.animRoot, CELL_ANIM_NAME.IDLE)
end


function IllustratedHandbookCardArchivesGridCatCell:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.animRoot, delayIndex, CELL_ANIM_NAME.SHOW, CELL_ANIM_NAME.WAIT)
end


-------------------------------------------------
-- private

function IllustratedHandbookCardArchivesGridCatCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type CatTypeVo
    local typeVo = cellData.typeVo

    -- update type name
    CfUtils.FillText(self.nameTxt, tostring(typeVo.name))

    -- update type image
    CfUtils.FillImage(self.catImg, tostring(typeVo.collectionBook))

    -- update cell state
    self:UpdateCellState_()
end


function IllustratedHandbookCardArchivesGridCatCell:UpdateCellState_()
    local cellData = self:GetCellData()

    ---@type CatTypeVo
    local typeVo   = cellData.typeVo
    local typeId   = checkInt(typeVo.catTypeId)
    local isOwned  = illustratedHandbookComp:IsHandbookOwned(Constants.HandbookCollectionType.CAT, typeId)
    local isUnlock = illustratedHandbookComp:IsHandbookUnlock(Constants.HandbookCollectionType.CAT, typeId)
    CfUtils.SetActive(self.notGetNode, not isOwned)

    CfUtils.SetActive(self.notLockNode, isOwned and not isUnlock)
end


-------------------------------------------------
-- handler

function IllustratedHandbookCardArchivesGridCatCell:OnClickCollectRoleCellHandler_()
    if self:GetClickGridCellCB() then
        self:GetClickGridCellCB()(self:GetLuaIndex())
    end
end


return IllustratedHandbookCardArchivesGridCatCell
