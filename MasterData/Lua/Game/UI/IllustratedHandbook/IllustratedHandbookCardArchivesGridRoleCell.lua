-------------------------------------------------------------------------------
-- 海外图鉴 - 卡牌档案 - 角色节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-26 03:08:56
-------------------------------------------------------------------------------

---@type IllustratedHandbookComponent
local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()

local CELL_ANIM_NAME = {
    HIDE = 'IllustratedHandbookMainDialog_Cell_Hide',
    IDLE = 'IllustratedHandbookMainDialog_Cell_Idle',
    SHOW = 'IllustratedHandbookMainDialog_Cell_Entry',
    WAIT = 'IllustratedHandbookMainDialog_Cell_Wait',
}

--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustratedHandbookMainDialog.prefab
---@class IllustratedHandbookCardArchivesGridRoleCell
---@field Env                           	IllustratedHandbookCardArchivesGridRoleCell
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field animRoot                      	UnityEngine.RectTransform               @ 动画根节点
---@field notLockNode                   	UnityEngine.RectTransform               @ 未解锁节点
---@field notGetNode                    	UnityEngine.RectTransform               @ 未获得节点
---@field attributeImg                  	UnityEngine.RectTransform               @ 属性图片
---@field careerImg                     	UnityEngine.RectTransform               @ 职业图标
---@field campImg                       	UnityEngine.RectTransform               @ 阵营图标
---@field campShadow                    	UnityEngine.RectTransform               @ 阵营阴影
---@field qualityImg2                   	UnityEngine.RectTransform               @ 品质图片2
---@field qualityImg1                   	UnityEngine.RectTransform               @ 品质图片1
---@field roleImg                       	UnityEngine.RectTransform               @ 角色形象
---@field cardNameTxt                   	UnityEngine.RectTransform               @ 卡牌名字
---@field roleNameTxt                   	UnityEngine.RectTransform               @ 角色名字
---@field rootNode                      	UnityEngine.RectTransform               @ 根节点
local IllustratedHandbookCardArchivesGridRoleCell = Class('IllustratedHandbookCardArchivesGridRoleCell')


function IllustratedHandbookCardArchivesGridRoleCell:__init()
end


function IllustratedHandbookCardArchivesGridRoleCell:__delete()
end


function IllustratedHandbookCardArchivesGridRoleCell:Awake()
    SetButtonAction(self.rootNode, Bind(self, self.OnClickCollectRoleCellHandler_))
    self:PlayAnimByHide()
end


function IllustratedHandbookCardArchivesGridRoleCell:Start()
end


function IllustratedHandbookCardArchivesGridRoleCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function IllustratedHandbookCardArchivesGridRoleCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function IllustratedHandbookCardArchivesGridRoleCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function IllustratedHandbookCardArchivesGridRoleCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function IllustratedHandbookCardArchivesGridRoleCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function IllustratedHandbookCardArchivesGridRoleCell:GetClickGridCellCB()
    return self.clickGridCellCallback_
end
---@param callback fun(luaIndex:integer):void
function IllustratedHandbookCardArchivesGridRoleCell:SetClickGridCellCB(callback)
    self.clickGridCellCallback_ = callback
end


-------------------------------------------------
-- public

function IllustratedHandbookCardArchivesGridRoleCell:PlayAnimByHide()
    CfUtils.PlayAnimation(self.animRoot, CELL_ANIM_NAME.HIDE)
end


function IllustratedHandbookCardArchivesGridRoleCell:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.animRoot, CELL_ANIM_NAME.IDLE)
end


function IllustratedHandbookCardArchivesGridRoleCell:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.animRoot, delayIndex, CELL_ANIM_NAME.SHOW, CELL_ANIM_NAME.WAIT)
end


-------------------------------------------------
-- private

function IllustratedHandbookCardArchivesGridRoleCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type CardVo
    local cardVo = cellData.cardVo

    -- update card name
    ---@type RolesVo
    local roleVo = cardConfMgr:GetRolesVo(cardVo.characterId) or {}
    CfUtils.FillText(self.roleNameTxt, tostring(roleVo.name))
    CfUtils.FillText(self.cardNameTxt, tostring(cardVo.name))

    -- update card image
    ---@type CardSkinVo
    local skinVo = cardConfMgr:GetCardSkinBySkinId(cardVo.defaultSkin)
    if skinVo then
        local drawPath = tostring(skinVo.cardHeadList)
        if CfUtils.IsBundleResourceExist(drawPath) then
            CfUtils.FillImage(self.roleImg, drawPath)
        else
            CfUtils.ResetImage(self.roleImg)
        end
        CfUtils.SetActive(self.roleImg, true)
    else
        CfUtils.SetActive(self.roleImg, false)
    end

    -- update card rare
    local cardRare = checkInt(cardVo.rare)
    CfUtils.SetUISwitchImage(self.qualityImg1, cardRare)
    CfUtils.SetUISwitchImage(self.qualityImg2, cardRare)
    
    -- update career icon
    local cardCareer = checkInt(cardVo.career)
    local cardAttr   = checkInt(cardVo.attributeType)
    local racePath   = CardUtils.GetCardRaceIconPath(cardVo.race)
    local jobPath    = CardUtils.GetCardJobIconPath(cardCareer)
    CfUtils.FillImage(self.campImg, racePath)
    CfUtils.FillImage(self.campShadow, racePath)
    CfUtils.FillImage(self.careerImg, jobPath)
    CfUtils.SetUISwitchImage(self.attributeImg, cardAttr)

    -- update cell state
    self:UpdateCellState_()
end


function IllustratedHandbookCardArchivesGridRoleCell:UpdateCellState_()
    local cellData = self:GetCellData()

    ---@type CardVo
    local cardVo   = cellData.cardVo
    local cardId   = checkInt(cardVo.roleId)
    local isOwned  = illustratedHandbookComp:IsHandbookOwned(Constants.HandbookCollectionType.ROLE, cardId)
    local isUnlock = illustratedHandbookComp:IsHandbookUnlock(Constants.HandbookCollectionType.ROLE, cardId)
    CfUtils.SetActive(self.notGetNode, not isOwned)

    CfUtils.SetActive(self.notLockNode, isOwned and not isUnlock)
end


-------------------------------------------------
-- handler

function IllustratedHandbookCardArchivesGridRoleCell:OnClickCollectRoleCellHandler_()
    if self:GetClickGridCellCB() then
        self:GetClickGridCellCB()(self:GetLuaIndex())
    end
end


return IllustratedHandbookCardArchivesGridRoleCell
