-------------------------------------------------------------------------------
-- 社团 - 社团列表界面 - 社团列表节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-21 14:58:25
-------------------------------------------------------------------------------

local APPLY_STYLE_DEFINE = {
    APPLY   = {styleId = Constants.ButtonFontStyle.B6,  text = localize('申请加入')},
    APPLIED = {styleId = Constants.ButtonFontStyle.B18, text = localize('已申请')},
}

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubListDialog.prefab > name: Cell
---@class UIOverseaClubListClubCell
---@field Env                           	UIOverseaClubListClubCell               
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field animRoot                      	UnityEngine.RectTransform               	@ 0    动画节点
---@field applyDescr                    	UnityEngine.RectTransform               	@ 1    申请描述
---@field applyBtn                      	Game.Native.Common.FontStyleButton      	@ 2    申请按钮
---@field powerNum                      	UnityEngine.RectTransform               	@ 3    社团总战力
---@field memberNum                     	UnityEngine.RectTransform               	@ 4    成员数量
---@field clubLevel                     	UnityEngine.RectTransform               	@ 5    社团等级
---@field masterName                    	UnityEngine.RectTransform               	@ 6    社长名字
---@field clubName                      	UnityEngine.RectTransform               	@ 7    社团名字
---@field clubHead                      	UnityEngine.RectTransform               	@ 8    社团头像
---@field inforTipsArea                 	UnityEngine.RectTransform               	@ 9    信息介绍区域
local UIOverseaClubListClubCell = Class('UIOverseaClubListClubCell')


function UIOverseaClubListClubCell:__init()
end


function UIOverseaClubListClubCell:__delete()
end


function UIOverseaClubListClubCell:Awake()
    SetButtonAction(self.applyBtn, Bind(self, self.OnClickApplyButtonHandler_))
    SetButtonAction(self.inforTipsArea, Bind(self, self.OnClickInfoTipsAreaHandler_))
    self:PlayAnimByHide()
end


function UIOverseaClubListClubCell:Start()
end


function UIOverseaClubListClubCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UIOverseaClubListClubCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UIOverseaClubListClubCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return ClubListUnitDojo
function UIOverseaClubListClubCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData ClubListUnitDojo
function UIOverseaClubListClubCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function UIOverseaClubListClubCell:GetClickApplyCB()
    return self.clickApplyCallback_
end
---@param callback fun(luaIndex:integer):void
function UIOverseaClubListClubCell:SetClickApplyCB(callback)
    self.clickApplyCallback_ = callback
end


---@return fun(luaIndex:integer):void
function UIOverseaClubListClubCell:GetClickInfoTipsCB()
    return self.clickInfoTipsCallback_
end
---@param callback fun(luaIndex:integer):void
function UIOverseaClubListClubCell:SetClickInfoTipsCB(callback)
    self.clickInfoTipsCallback_ = callback
end


---@return boolean
function UIOverseaClubListClubCell:IsApplied()
    return checkBool(self.isApplied_)
end
---@param isApplied boolean
function UIOverseaClubListClubCell:SetApplied(isApplied)
    self.isApplied_ = checkBool(isApplied)
    self:UpdateApplyButton_()
end


-------------------------------------------------
-- public

function UIOverseaClubListClubCell:PlayAnimByHide()
    CfUtils.PlayAnimation(self.animRoot, 'UI_Common_List_Cell_Hide')
end


function UIOverseaClubListClubCell:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.animRoot, 'UI_Common_List_Cell_Idle')
end


function UIOverseaClubListClubCell:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.animRoot, delayIndex, 'UI_Common_List_Cell_Show')
end


-------------------------------------------------
-- private

function UIOverseaClubListClubCell:UpdateCellInfo_()
    local unitDojo = self:GetCellData()

    -- update infos
    local clubLevelVo = ClubUtils.GetLevelVo(unitDojo.level)
    local clubHeadVo  = ClubUtils.GetClubHeadVo(unitDojo.avatar)
    CfUtils.FillText(self.clubName, unitDojo.name)
    CfUtils.FillText(self.clubLevel, unitDojo.level)
    CfUtils.FillText(self.powerNum, unitDojo.powers)
    CfUtils.FillText(self.masterName, unitDojo.chairmanName)
    CfUtils.FillImage(self.clubHead, clubHeadVo.photoPath)
    CfUtils.FillText(self.memberNum, string.fmt('%1/%2', unitDojo.members, clubLevelVo.members))
    
    -- update apply descr
    local applyLevel = unitDojo.applyLevel
    local isFreeType = unitDojo.applyType == ClubUtils.ApplyType.FREE
    if isFreeType then
        CfUtils.FillText(self.applyDescr, localize('_num_级以上，自由加入', {_num_ = applyLevel}))
    else
        CfUtils.FillText(self.applyDescr, localize('_num_级以上，需要审核', {_num_ = applyLevel}))
    end

    -- update apply button
    self:SetApplied(unitDojo.isApplied)
end


function UIOverseaClubListClubCell:UpdateApplyButton_()
    local styleDefine = self:IsApplied() and APPLY_STYLE_DEFINE.APPLIED or APPLY_STYLE_DEFINE.APPLY
    self.applyBtn:ResetFontStyle(styleDefine.styleId, styleDefine.text)
end


-------------------------------------------------
-- handler

function UIOverseaClubListClubCell:OnClickApplyButtonHandler_()
    if self:GetClickApplyCB() then
        self:GetClickApplyCB()(self:GetLuaIndex())
    end
end


function UIOverseaClubListClubCell:OnClickInfoTipsAreaHandler_()
    if self:GetClickInfoTipsCB() then
        self:GetClickInfoTipsCB()(self:GetLuaIndex())
    end
end


return UIOverseaClubListClubCell
