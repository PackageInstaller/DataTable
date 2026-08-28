-------------------------------------------------------------------------------
-- 社团 - 社团申请列表弹窗 - 成员列表节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-31 21:17:38
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubApplyForListPopup.prefab
---@class UIOverseaClubApplyListCell
---@field Env                           	UIOverseaClubApplyListCell              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field animRoot                      	UnityEngine.RectTransform               @ 动画节点
---@field applyAgreeBtn                 	UnityEngine.RectTransform               @ 申请通过按钮
---@field applyRejectBtn                	UnityEngine.RectTransform               @ 申请拒绝按钮
---@field playerPowerTxt                	UnityEngine.RectTransform               @ 玩家战力文本
---@field playerLevelTxt                	UnityEngine.RectTransform               @ 玩家等级文本
---@field playerNameTxt                 	UnityEngine.RectTransform               @ 玩家名字文本
---@field playerHeadNode                	UnityEngine.RectTransform               @ 玩家头像节点
local UIOverseaClubApplyListCell = Class('UIOverseaClubApplyListCell')


function UIOverseaClubApplyListCell:__init()
    ---@type CommonPlayerHeadNode
    self.playerHeadEnv_ = nil
end


function UIOverseaClubApplyListCell:__delete()
    self.playerHeadEnv_  = nil
end


function UIOverseaClubApplyListCell:Awake()
    self.playerHeadEnv_ = CfUtils.GetLuaScr(self.playerHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    SetButtonAction(self.applyAgreeBtn, Bind(self, self.OnClickApplyAgreenButtonHandler_))
    SetButtonAction(self.applyRejectBtn, Bind(self, self.OnClickApplyRejectButtonHandler_))
    self:PlayAnimByHide()
end


function UIOverseaClubApplyListCell:Start()
end


function UIOverseaClubApplyListCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UIOverseaClubApplyListCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UIOverseaClubApplyListCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function UIOverseaClubApplyListCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function UIOverseaClubApplyListCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function UIOverseaClubApplyListCell:GetClickAgreeCB()
    return self.clickAgreeCallback_
end
---@param callback fun(luaIndex:integer):void
function UIOverseaClubApplyListCell:SetClickAgreeCB(callback)
    self.clickAgreeCallback_ = callback
end


---@return fun(luaIndex:integer):void
function UIOverseaClubApplyListCell:GetClickRejectCB()
    return self.clickRejectCallback_
end
---@param callback fun(luaIndex:integer):void
function UIOverseaClubApplyListCell:SetClickRejectCB(callback)
    self.clickRejectCallback_ = callback
end


-------------------------------------------------
-- public

function UIOverseaClubApplyListCell:PlayAnimByHide()
    CfUtils.PlayAnimation(self.animRoot, 'UI_Common_List_Cell_Hide')
end


function UIOverseaClubApplyListCell:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.animRoot, 'UI_Common_List_Cell_Idle')
end


function UIOverseaClubApplyListCell:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.animRoot, delayIndex, 'UI_Common_List_Cell_Show')
end


-------------------------------------------------
-- private

function UIOverseaClubApplyListCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    -- update player info
    self.playerHeadEnv_:FreshAvatarFrame(cellData.playerAvatar, cellData.playerAvatarFrame)
    CfUtils.FillText(self.playerNameTxt, cellData.playerName)
    CfUtils.FillText(self.playerLevelTxt, cellData.playerLevel)
    CfUtils.FillText(self.playerPowerTxt, cellData.combat)
end


-------------------------------------------------
-- handler

function UIOverseaClubApplyListCell:OnClickApplyAgreenButtonHandler_()
    if self:GetClickAgreeCB() then
        self:GetClickAgreeCB()(self:GetLuaIndex())
    end
end


function UIOverseaClubApplyListCell:OnClickApplyRejectButtonHandler_()
    if self:GetClickRejectCB() then
        self:GetClickRejectCB()(self:GetLuaIndex())
    end
end


return UIOverseaClubApplyListCell
