-------------------------------------------------------------------------------
-- 海外图鉴 - 卡牌档案 - 类型节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-10-09 15:07:43
-------------------------------------------------------------------------------

local CELL_ANIM_NAME = {
    HIDE = 'IllustratedHandbookMainDialog_LabeINode_Hide',
    IDLE = 'IllustratedHandbookMainDialog_LabeINode_Idle',
    SHOW = 'IllustratedHandbookMainDialog_LabeINode_Entry',
    WAIT = 'IllustratedHandbookMainDialog_LabeINode_Wait',
}

--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustratedHandbookMainDialog.prefab > name: LabelNode
---@class IllustratedHandbookCardArchivesTypeListCell
---@field Env                           	IllustratedHandbookCardArchivesTypeListCell
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field animRoot                      	UnityEngine.RectTransform               @ 动画根节点
---@field redPointNode                  	UnityEngine.RectTransform               @ 红点节点
---@field selectPointImg                	UnityEngine.RectTransform               @ 提示点选中图
---@field normalPointImg                	UnityEngine.RectTransform               @ 提示点正常图
---@field selectNode                    	UnityEngine.RectTransform               @ 选中节点
---@field normalNode                    	UnityEngine.RectTransform               @ 正常节点
---@field selectIconImg                 	UnityEngine.RectTransform               @ 选中图标
---@field normalIconImg                 	UnityEngine.RectTransform               @ 正常图标
---@field progressTxt                   	UnityEngine.RectTransform               @ 进度文本
---@field typeTitle                     	UnityEngine.RectTransform               @ 标题文本
---@field rootNode                      	UnityEngine.RectTransform               @ 根节点
local IllustratedHandbookCardArchivesTypeListCell = Class('IllustratedHandbookCardArchivesTypeListCell')


function IllustratedHandbookCardArchivesTypeListCell:__init()
end


function IllustratedHandbookCardArchivesTypeListCell:__delete()
end


function IllustratedHandbookCardArchivesTypeListCell:Awake()
    SetButtonAction(self.rootNode, Bind(self, self.OnClickCollectTypeCellHandler_))
    self:PlayAnimByHide()
end


function IllustratedHandbookCardArchivesTypeListCell:Start()
end


function IllustratedHandbookCardArchivesTypeListCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function IllustratedHandbookCardArchivesTypeListCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function IllustratedHandbookCardArchivesTypeListCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function IllustratedHandbookCardArchivesTypeListCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function IllustratedHandbookCardArchivesTypeListCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function IllustratedHandbookCardArchivesTypeListCell:GetClickTypeCellCB()
    return self.clickCellCallback_
end
---@param callback fun(luaIndex:integer):void
function IllustratedHandbookCardArchivesTypeListCell:SetClickTypeCellCB(callback)
    self.clickCellCallback_ = callback
end


---@return boolean
function IllustratedHandbookCardArchivesTypeListCell:IsSelected()
    return checkBool(self.isSelected_)
end
---@param isSelected boolean
function IllustratedHandbookCardArchivesTypeListCell:SetSelected(isSelected)
    self.isSelected_ = checkBool(isSelected)
    self:UpdateSelectState_()
end


-------------------------------------------------
-- public

function IllustratedHandbookCardArchivesTypeListCell:PlayAnimByHide()
    CfUtils.PlayAnimation(self.animRoot, CELL_ANIM_NAME.HIDE)
end


function IllustratedHandbookCardArchivesTypeListCell:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.animRoot, CELL_ANIM_NAME.IDLE)
end


function IllustratedHandbookCardArchivesTypeListCell:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.animRoot, delayIndex, CELL_ANIM_NAME.SHOW, CELL_ANIM_NAME.WAIT)
end


function IllustratedHandbookCardArchivesTypeListCell:UpdateRedPointState()
    local isShowRedPoint = self:GetCellData().redCheckFunc()
    CfUtils.SetActive(self.redPointNode, isShowRedPoint)
end


-------------------------------------------------
-- private

function IllustratedHandbookCardArchivesTypeListCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type IllustratedHandbookCollectDojo
    local collectDojo = cellData.collectDojo

    ---@type IllustratedCollectionTypeVo
    local collectTypeVo = collectDojo.typeVo

    -- update type title
    CfUtils.FillText(self.typeTitle, tostring(collectTypeVo.label))

    -- update type icon
    CfUtils.SetUISwitchImage(self.normalIconImg, checkInt(collectTypeVo.typeId))
    CfUtils.SetUISwitchImage(self.selectIconImg, checkInt(collectTypeVo.typeId))

    -- update type progress
    local ownedNum = table.count(collectDojo.ownedMap)
    local totalNum = table.count(collectDojo.totalMap)
    local progress = totalNum > 0 and (ownedNum / totalNum) or 0
    local rateText = string.format('%.0f%%', math.floor(progress * 100))
    CfUtils.FillText(self.progressTxt, rateText)

    -- update redPoint state
    self:UpdateRedPointState()
end


function IllustratedHandbookCardArchivesTypeListCell:UpdateSelectState_()
    local isSelected = self:IsSelected()
    CfUtils.SetActive(self.selectNode, isSelected)
    CfUtils.SetActive(self.normalNode, not isSelected)
    CfUtils.SetActive(self.selectPointImg, isSelected)
    CfUtils.SetActive(self.normalPointImg, not isSelected)
end


-------------------------------------------------
-- handler

function IllustratedHandbookCardArchivesTypeListCell:OnClickCollectTypeCellHandler_()
    if self:GetClickTypeCellCB() then
        self:GetClickTypeCellCB()(self:GetLuaIndex())
    end
end


return IllustratedHandbookCardArchivesTypeListCell
