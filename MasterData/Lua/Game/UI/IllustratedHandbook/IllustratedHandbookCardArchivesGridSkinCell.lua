-------------------------------------------------------------------------------
-- 海外图鉴 - 卡牌档案 - 皮肤节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-26 03:08:56
-------------------------------------------------------------------------------

---@type IllustratedHandbookComponent
local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)
---@type CardProgressionConstants
local CardProgressionConstants = import('Game.CardProgression.CardProgressionConstants')

local CELL_ANIM_NAME = {
    HIDE = 'IllustratedHandbookMainDialog_Cell_Hide',
    IDLE = 'IllustratedHandbookMainDialog_Cell_Idle',
    SHOW = 'IllustratedHandbookMainDialog_Cell_Entry',
    WAIT = 'IllustratedHandbookMainDialog_Cell_Wait',
}

--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustratedHandbookArchivesSkinCell.prefab > name: IllustratedHandbookArchivesSkinCell
---@class IllustratedHandbookCardArchivesGridSkinCell
---@field Env                           	IllustratedHandbookCardArchivesGridSkinCell
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field animRoot                      	UnityEngine.RectTransform               	@ 0    动画根节点
---@field notLockNode                   	UnityEngine.RectTransform               	@ 1    未解锁节点
---@field notGetNode                    	UnityEngine.RectTransform               	@ 2    未获得节点
---@field brandImg                      	UnityEngine.RectTransform               	@ 3    限定标签图
---@field rareLineImg                   	UnityEngine.RectTransform               	@ 4    品质线图片
---@field rareImg                       	UnityEngine.RectTransform               	@ 5    品质图片
---@field skinImg                       	UnityEngine.RectTransform               	@ 6    皮肤图片
---@field skinNameTxt                   	UnityEngine.RectTransform               	@ 7    皮肤名字
---@field rootNode                      	UnityEngine.RectTransform               	@ 8    根节点
---@field UIFX_Skin_Up                  	UnityEngine.RectTransform               	@ 9    
---@field UIFX_Skin_Down                	UnityEngine.RectTransform               	@ 10   
local IllustratedHandbookCardArchivesGridSkinCell = Class('IllustratedHandbookCardArchivesGridSkinCell')


function IllustratedHandbookCardArchivesGridSkinCell:__init()
end


function IllustratedHandbookCardArchivesGridSkinCell:__delete()
end


function IllustratedHandbookCardArchivesGridSkinCell:Awake()
    SetButtonAction(self.rootNode, Bind(self, self.OnClickCollectRoleCellHandler_))
    self:PlayAnimByHide()
end


function IllustratedHandbookCardArchivesGridSkinCell:Start()
end


function IllustratedHandbookCardArchivesGridSkinCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function IllustratedHandbookCardArchivesGridSkinCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function IllustratedHandbookCardArchivesGridSkinCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function IllustratedHandbookCardArchivesGridSkinCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function IllustratedHandbookCardArchivesGridSkinCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function IllustratedHandbookCardArchivesGridSkinCell:GetClickGridCellCB()
    return self.clickGridCellCallback_
end
---@param callback fun(luaIndex:integer):void
function IllustratedHandbookCardArchivesGridSkinCell:SetClickGridCellCB(callback)
    self.clickGridCellCallback_ = callback
end


-------------------------------------------------
-- public

function IllustratedHandbookCardArchivesGridSkinCell:PlayAnimByHide()
    CfUtils.PlayAnimation(self.animRoot, CELL_ANIM_NAME.HIDE)
end


function IllustratedHandbookCardArchivesGridSkinCell:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.animRoot, CELL_ANIM_NAME.IDLE)
end


function IllustratedHandbookCardArchivesGridSkinCell:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.animRoot, delayIndex, CELL_ANIM_NAME.SHOW, CELL_ANIM_NAME.WAIT)
end


-------------------------------------------------
-- private

function IllustratedHandbookCardArchivesGridSkinCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type CardSkinVo
    local skinVo = cellData.skinVo or {}

    -- update skin name
    CfUtils.FillText(self.skinNameTxt, tostring(skinVo.name))
    
    -- update skin image
    local drawPath = tostring(skinVo.cardHeadList)
    if CfUtils.IsBundleResourceExist(drawPath) then
        CfUtils.FillImage(self.skinImg, drawPath)
    else
        CfUtils.ResetImage(self.skinImg)
    end
    CardUtils.RefreshCardSkinEffectHead(skinVo, self.skinImg, self.UIFX_Skin_Up, self.UIFX_Skin_Down)
    
    -- update skin rare
    local skinRare = skinVo:GetRare()
    CfUtils.SetUISwitchImage(self.rareImg, skinRare)
    CfUtils.SetUISwitchImage(self.rareLineImg, skinRare)

    -- update skin brand
    if string.isEmpty(skinVo.version) then
        CfUtils.SetActive(self.brandImg, false)
    else
        CfUtils.SetActive(self.brandImg, true)
        CfUtils.FillImage(self.brandImg, skinVo.version)
    end

    -- update cell state
    self:UpdateCellState_()
end


function IllustratedHandbookCardArchivesGridSkinCell:UpdateCellState_()
    local cellData = self:GetCellData()

    ---@type CardSkinVo
    local skinVo   = cellData.skinVo
    local skinId   = checkInt(skinVo.skinId)
    local isOwned  = illustratedHandbookComp:IsHandbookOwned(Constants.HandbookCollectionType.SKIN, skinId)
    local isUnlock = illustratedHandbookComp:IsHandbookUnlock(Constants.HandbookCollectionType.SKIN, skinId)
    CfUtils.SetActive(self.notGetNode, not isOwned)

    CfUtils.SetActive(self.notLockNode, isOwned and not isUnlock)
end


-------------------------------------------------
-- handler

function IllustratedHandbookCardArchivesGridSkinCell:OnClickCollectRoleCellHandler_()
    if self:GetClickGridCellCB() then
        self:GetClickGridCellCB()(self:GetLuaIndex())
    end
end


return IllustratedHandbookCardArchivesGridSkinCell
