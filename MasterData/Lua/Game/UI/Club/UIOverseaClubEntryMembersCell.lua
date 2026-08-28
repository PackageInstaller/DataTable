-------------------------------------------------------------------------------
-- 社团 - 社团首页 - 成员列表节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-31 21:17:38
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubMemberInformationDialog.prefab
---@class UIOverseaClubEntryMembersCell
---@field Env                           	UIOverseaClubEntryMembersCell           
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field animRoot                      	UnityEngine.RectTransform               @ 动画根节点
---@field onlineStateTxt                	UnityEngine.RectTransform               @ 在线状态文本
---@field onlineStateImg                	UnityEngine.RectTransform               @ 在线状态图标
---@field memberDonationTxt             	UnityEngine.RectTransform               @ 成员捐献文本
---@field memberPowerTxt                	UnityEngine.RectTransform               @ 成员战力文本
---@field memberJobTxt                  	UnityEngine.RectTransform               @ 成员职位文本
---@field memberLevelTxt                	UnityEngine.RectTransform               @ 成员等级文本
---@field memberNameTxt                 	UnityEngine.RectTransform               @ 成员名字文本
---@field memberHeadNode                	UnityEngine.RectTransform               @ 成员头像节点
---@field myselfImg                     	UnityEngine.RectTransform               @ 自己标识图片
local UIOverseaClubEntryMembersCell = Class('UIOverseaClubEntryMembersCell')


function UIOverseaClubEntryMembersCell:__init()
    ---@type CommonPlayerHeadNode
    self.playerHeadEnv_ = nil
    ---@type integer
    self.myselfPlayerId_ = 0
end


function UIOverseaClubEntryMembersCell:__delete()
    self.playerHeadEnv_  = nil
    self.myselfPlayerId_ = nil
end


function UIOverseaClubEntryMembersCell:Awake()
    self.myselfPlayerId_ = checkInt(GameUtils.GetPlayerId())
    self.playerHeadEnv_  = CfUtils.GetLuaScr(self.memberHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    self.playerHeadEnv_:SetCallBack(Bind(self, self.OnClickMemberHeadNodeHandler_))
    self:PlayAnimByHide()
end


function UIOverseaClubEntryMembersCell:Start()
end


function UIOverseaClubEntryMembersCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UIOverseaClubEntryMembersCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UIOverseaClubEntryMembersCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return ClubMemberDojo
function UIOverseaClubEntryMembersCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData ClubMemberDojo
function UIOverseaClubEntryMembersCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer, headNode:UnityEngine.RectTransform):void
function UIOverseaClubEntryMembersCell:GetClickHeadCB()
    return self.clickHeadCallback_
end
---@param callback fun(luaIndex:integer, headNode:UnityEngine.RectTransform):void
function UIOverseaClubEntryMembersCell:SetClickHeadCB(callback)
    self.clickHeadCallback_ = callback
end


-------------------------------------------------
-- public

function UIOverseaClubEntryMembersCell:PlayAnimByHide()
    CfUtils.PlayAnimation(self.animRoot, 'UI_Common_List_Cell_Hide')
end


function UIOverseaClubEntryMembersCell:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.animRoot, 'UI_Common_List_Cell_Idle')
end


function UIOverseaClubEntryMembersCell:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.animRoot, delayIndex, 'UI_Common_List_Cell_Show')
end


-------------------------------------------------
-- private

function UIOverseaClubEntryMembersCell:UpdateCellInfo_()
    local memberDojo = self:GetCellData()

    -- update myself mark
    local isMyself = self.myselfPlayerId_ == checkInt(memberDojo.playerId)
    CfUtils.SetActive(self.myselfImg, isMyself)

    -- update player info
    self.playerHeadEnv_:FreshAvatarFrame(memberDojo.playerAvatar, memberDojo.playerAvatarFrame)
    CfUtils.FillText(self.memberNameTxt, memberDojo.playerName)
    CfUtils.FillText(self.memberLevelTxt, memberDojo.playerLevel)
    CfUtils.FillText(self.memberPowerTxt, memberDojo.combat)
    CfUtils.FillText(self.memberJobTxt, ClubUtils.GetJobVo(memberDojo.job).jobName)
    CfUtils.FillText(self.memberDonationTxt, string.fmt('%1/%2', memberDojo.weekPoint, memberDojo.playerPoint))

    -- update online state
    local isOnline = memberDojo.isOnline
    CfUtils.SetUISwitchImage(self.onlineStateImg, isOnline and 2 or 1)
    CfUtils.SetUISwitchText(self.onlineStateTxt, isOnline and 2 or 1)
    if isOnline then
        CfUtils.FillText(self.onlineStateTxt, localize('在线'))
    else
        local offlineTime = CfUtils.GetTimeHMS10(memberDojo.lastExitTime)
        CfUtils.FillText(self.onlineStateTxt, localize('_time_前', {_time_ = offlineTime}))
    end
end


-------------------------------------------------
-- handler

function UIOverseaClubEntryMembersCell:OnClickMemberHeadNodeHandler_()
    if self:GetClickHeadCB() then
        self:GetClickHeadCB()(self:GetLuaIndex(), self.memberHeadNode)
    end
end


return UIOverseaClubEntryMembersCell
