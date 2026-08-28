-------------------------------------------------------------------------------
-- 社团 - 社团首页 - 成员面板
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-30 20:42:24
-------------------------------------------------------------------------------

local MemberListCellPath = 'Game.UI.Club.UIOverseaClubEntryMembersCell'
local MemberListCellName = 'Cell'

local ROOT_ANIM_NAME = {
    IDLE = 'OverseaClubMemberInformationDialog_Idle',
    SHOW = 'OverseaClubMemberInformationDialog_Entry',
}

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubMemberInformationDialog.prefab > name: OverseaClubMemberInformationDialog
---@class UIOverseaClubEntryMembersPanel
---@field Env                           	UIOverseaClubEntryMembersPanel          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 0    动画根节点
---@field memberListContent             	UnityEngine.RectTransform               	@ 1    社团成员列表容器
---@field memberList                    	SuperScrollView.LoopListView2           	@ 2    社团成员列表
---@field applyListBtnRedPoint          	UnityEngine.RectTransform               	@ 3    申请按钮红点
---@field applyListBtn                  	UnityEngine.RectTransform               	@ 4    申领列表按钮
---@field quitClubBtn                   	UnityEngine.RectTransform               	@ 5    退出社团按钮
---@field Impeach                       	UnityEngine.RectTransform               	@ 6    
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 7    
---@field redPoint                      	UnityEngine.RectTransform               	@ 8    
---@field BtnExplain                    	UnityEngine.RectTransform               	@ 9    
local UIOverseaClubEntryMembersPanel = Class('UIOverseaClubEntryMembersPanel')


function UIOverseaClubEntryMembersPanel:__init()
end


function UIOverseaClubEntryMembersPanel:__delete()
end


function UIOverseaClubEntryMembersPanel:Awake()
end


function UIOverseaClubEntryMembersPanel:Start()
    SetButtonAction(self.quitClubBtn, Bind(self, self.OnClickQuitClubButtonHandler_))
    SetButtonAction(self.applyListBtn, Bind(self, self.OnClickApplyListButtonHandler_))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickFontStyleButtonHandler_))
    SetButtonAction(self.BtnExplain, Bind(self, self.OnClickBtnExplainHandler_))

    SetListViewAction(self.memberList, Bind(self, self.OnUpdateMemberListCellHandler_), MemberListCellName)
    GameUtils.BindRedPoint(Constants.RedPointConst.ClubApplyList, self.applyListBtn, true)
    GameUtils.BindRedPoint(Constants.RedPointConst.ClubImpeach, self.Impeach, true)

    self.updateMembersEventCB_   = Events.AddListener(ClubUtils.EventName.UPDATE_MEMBERS, Bind(self, self.OnClubUpdateMembersHandler_))
    self.updateMemberJobEventCB_ = Events.AddListener(ClubUtils.EventName.UPDATE_MEMBER_JOB, Bind(self, self.OnClubUpdateMemberJobHandler_))

    if self:GetInitParams().tabSelectIndex then
        CfUtils.PlayAnimation(self.AnimRoot, ROOT_ANIM_NAME.IDLE)
        self.memberList.DisplayItemNumber = self.memberList.DisplayItemCount
    else
        CfUtils.PlayAnimation(self.AnimRoot, ROOT_ANIM_NAME.SHOW)
    end

    if self:GetOnStartCB() then
        self:GetOnStartCB()()
    end
end


function UIOverseaClubEntryMembersPanel:OnDestroy()
    self:GetInitParams().membersListX = self.memberListContent.anchoredPosition.x
    self:GetInitParams().membersListY = self.memberListContent.anchoredPosition.y
    GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.ClubApplyList)
    GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.ClubImpeach)
    Events.RemoveListener(ClubUtils.EventName.UPDATE_MEMBERS, self.updateMembersEventCB_)
    Events.RemoveListener(ClubUtils.EventName.UPDATE_MEMBER_JOB, self.updateMemberJobEventCB_)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return fun():void
function UIOverseaClubEntryMembersPanel:GetOnStartCB()
    return self.startCallback_
end
function UIOverseaClubEntryMembersPanel:SetOnStartCB(callback)
    self.startCallback_ = callback
end


---@return table
function UIOverseaClubEntryMembersPanel:GetInitParams()
    return self.initParams_
end
function UIOverseaClubEntryMembersPanel:SetInitParams(parasm)
    self.initParams_ = checkTable(parasm)
end


---@return ClubMemberDojo[]
function UIOverseaClubEntryMembersPanel:GetMemberDojoList()
    return checkTable(self.memberDojoList_)
end
function UIOverseaClubEntryMembersPanel:SetMemberDojoList(memberDojoList)
    self.memberDojoList_ = checkTable(memberDojoList)
    self:UpdateMemberListView_()
end


-------------------------------------------------
-- public

function UIOverseaClubEntryMembersPanel:RefreshPanel()
    -- switch job function
    local myMemberDojo   = ClubUtils.GetClubComp():GetHomeDojo().myselfDojo
    local isApplyManage  = ClubUtils.HasJobFunc(myMemberDojo.job, ClubUtils.JobFuncId.APPLY_MANAGE)
    CfUtils.SetActive(self.applyListBtn, isApplyManage)
    if not isApplyManage then
        ClubUtils.GetClubComp():SetApplyListRedPoint(false)
    end

    -- refresh memberList
    self:RefreshMemberList_()

    -- update applyRedPoint
    self:UpdateApplyRedPoint_()

    self:RefreshImpeachState()
end


function UIOverseaClubEntryMembersPanel:RefreshImpeachState()
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    local isCanImpeach = clubHomeDojo.isOpenImpeachment
    CfUtils.SetActive(self.Impeach, isCanImpeach)

    if isCanImpeach then
        local impeachmentState = clubHomeDojo.impeachmentDojo.impeachmentState
        if impeachmentState ~= ClubUtils.ImpeachmentState.VOTEABLE then
            local isAgreed = impeachmentState == ClubUtils.ImpeachmentState.AGREED
            CfUtils.SetButtonStyle(self.FontStyleButton, 'B18', isAgreed and localize('已弹劾') or localize('已拒绝'))
        else
            CfUtils.SetButtonStyle(self.FontStyleButton, 'B6', localize("弹劾社长"))
        end
    end
end


-------------------------------------------------
-- private

function UIOverseaClubEntryMembersPanel:RefreshMemberList_()
    local memberDojoList = {}
    for memberIndex, memberDojo in ipairs(ClubUtils.GetClubComp():GetHomeDojo().memberList) do
        memberDojoList[memberIndex] = memberDojo
    end
    ---@param aMember ClubMemberDojo
    ---@param bMember ClubMemberDojo
    table.sort(memberDojoList, function(aMember, bMember)
        local aPriority = 0
        local bPriority = 0
        -- aPriority = aPriority + (aMember.job < bMember.job and 100 or 0)
        -- bPriority = bPriority + (bMember.job < aMember.job and 100 or 0)
        aPriority = aPriority + (aMember.isOnline and 10 or 0)
        bPriority = bPriority + (bMember.isOnline and 10 or 0)
        aPriority = aPriority + (aMember.combat > bMember.combat and 1 or 0)
        bPriority = bPriority + (bMember.combat > aMember.combat and 1 or 0)
        return aPriority > bPriority
    end)
    self:SetMemberDojoList(memberDojoList)
end


function UIOverseaClubEntryMembersPanel:UpdateMemberListView_()
    local listDataLegnth = #self:GetMemberDojoList()
    GameUtils.ReloadData(self.memberList, listDataLegnth)
    if self:GetInitParams().membersListX and self:GetInitParams().membersListY then
        -- 需要先滚动到底，才能触发计算出容器真正的高度
        -- 不然会出现滚动到很靠下的位置时，高度不对而回弹到顶部
        self.memberList:MovePanelToItemIndex(listDataLegnth)
        self.memberListContent.anchoredPosition = Vector3(
            checkInt(self:GetInitParams().membersListX),
            checkInt(self:GetInitParams().membersListY)
        )
        self:GetInitParams().membersListX = nil
        self:GetInitParams().membersListY = nil
    end
end


function UIOverseaClubEntryMembersPanel:UpdateApplyRedPoint_()
    CfUtils.SetActive(self.applyListBtnRedPoint, ClubUtils.GetClubComp():HasApplyListRedPoint())
end


-------------------------------------------------
-- handler

function UIOverseaClubEntryMembersPanel:OnClickApplyListButtonHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UIOverseaClubApplyListPopup)
end

function UIOverseaClubEntryMembersPanel:OnClickFontStyleButtonHandler_()
    local clubHomeDojo    = ClubUtils.GetClubComp():GetHomeDojo()
    local impeachmentDojo = clubHomeDojo.impeachmentDojo
    if impeachmentDojo.impeachmentState ~= ClubUtils.ImpeachmentState.VOTEABLE then
        GameUtils.Toast(localize("已参与过投票"))
        return
    end

    local toImpeachmentFunc = function(isImpeachment)
        GameUtils.Request(Interfaces.OverseaClubImpeach, {isImpeachment = isImpeachment and 1 or 2}, function(request, response)
            if response.errCode == 0 then
                impeachmentDojo.impeachmentState = isImpeachment and ClubUtils.ImpeachmentState.AGREED or ClubUtils.ImpeachmentState.REFUSED
                self:RefreshImpeachState()
                GameUtils.SetRedPointNum(Constants.RedPointConst.ClubImpeach, 0)
            end
        end)
    end
    GameUtils.SecondConfirm(localize('投票后不可取消，确定弹劾当前社长吗?'), 
        function()
            toImpeachmentFunc(true)
        end,
        function()
            toImpeachmentFunc(false)
        end,
    nil, 9)
end

function UIOverseaClubEntryMembersPanel:OnClickBtnExplainHandler_()
    CfUtils.ShowModuleToast(60061)
end

function UIOverseaClubEntryMembersPanel:OnClickQuitClubButtonHandler_()
    local quitProtectCD = ClubUtils.GetParamValue(ClubUtils.ParamsId.QUIT_PROTECT_CD)
    local quitTipsText  = localize('是否退出当前社团？退出后需等待_num_小时才能加入新社团', {_num_ = quitProtectCD})
    GameUtils.SecondConfirm(quitTipsText, function()
        GameUtils.Request(Interfaces.OverseaClubQuit, {}, function(request, response)
            if checkInt(response.errCode) == 0 then
                ClubUtils.GetClubComp():CleanClubData()
                ClubUtils.GetClubComp():SetQuitTimestamp(os.time() + (quitProtectCD * 3600))
                -- goto clubList
                CfUtils.StartCoroutineWithBlocker(function()
                    Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true)  -- 显示主场景，防止一瞬间出现的天空盒
                    CoYield(CfUtils.DialogCloseAll())
                    CoYield(CfUtils.DialogOpen(Constants.UITypeIds.UIOverseaClubListDialog, nil, {UIArgs(Constants.UITypeIds.UIHomeView)}))
                end)
            end
        end)
    end)
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function UIOverseaClubEntryMembersPanel:OnUpdateMemberListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(MemberListCellName)
    local cellData = self:GetMemberDojoList()[luaIndex]
    ---@type UIOverseaClubEntryMembersCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, MemberListCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickHeadCB(Bind(self, self.OnClickMemberListCellHeadNodeCallback_))

        if listView.DisplayItemNumber < listView.DisplayItemCount then
            cellEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            cellEnv:PlayAnimByIdle()
        end
    end
    return cellNode
end


---@param luaIndex integer
---@param headNode UnityEngine.RectTransform
function UIOverseaClubEntryMembersPanel:OnClickMemberListCellHeadNodeCallback_(luaIndex, headNode)
    local memberDojo = self:GetMemberDojoList()[luaIndex]
    if checkInt(memberDojo.playerId) == checkInt(GameUtils.GetPlayerId()) then
        return
    end

    -- 直接进入 他人的 个人信息界面2D版 
    GameUtils.ShowPlayerInfo( memberDojo.playerId, nil, nil, {
        enterType = "Club",
        panelMode = true,
    })

    -- 下方为旧方案, 暂被替代:
    -- GameUtils.ShowCommonPlayerHeadOption(headNode, Constants.PlayerHeadOptionType.CLUB_MEMBER, {
    --     playerId    = memberDojo.playerId,
    --     name        = memberDojo.playerName,
    --     level       = memberDojo.playerLevel,
    --     avatar      = memberDojo.playerAvatar,
    --     avatarFrame = memberDojo.playerAvatarFrame,
    --     clubJob     = memberDojo.job,
    --     exclude     = {UIArgs(Constants.UITypeIds.UIOverseaClubHallDialog)}
    -- })
end


function UIOverseaClubEntryMembersPanel:OnClubUpdateMembersHandler_()
    self:RefreshMemberList_()
end


function UIOverseaClubEntryMembersPanel:OnClubUpdateMemberJobHandler_(eventData)
    -- self.memberList:RefreshAllShownItem()
    local changeMemberId = checkInt(eventData.memberId)
    if changeMemberId == checkInt(GameUtils.GetPlayerId()) then
        -- 自己职位变动话，刷新一下职权
        self:RefreshPanel()
    else
        self:RefreshMemberList_()
    end
end


return UIOverseaClubEntryMembersPanel
