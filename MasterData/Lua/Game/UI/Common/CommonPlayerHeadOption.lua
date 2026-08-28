-------------------------------------------------------------------------------
-- 通用玩家头像操作弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-03 18:05:32
-------------------------------------------------------------------------------

local BUTTON_TYPE = {
    --              = personal
    VIEW_INFO       = 101,  -- 查看信息
    CHAT_PRIVATE    = 102,  -- 私聊
    --              = friend
    FRIEND_ADD      = 201,  -- 添加好友
    FRIEND_REMOVE   = 202,  -- 移除好友
    --              = club
    CLUB_KICKOUT    = 301,  -- 踢出社团
    CLUB_ASSIGN_JOB = 302,  -- 社团任命
}

local SECOND_MENU_ANIM = {
    LEFT  = 'CommonPlayerHeadOption_SecondMenu_Entry_L',
    RIGHT = 'CommonPlayerHeadOption_SecondMenu_Entry_R',
}

--- @type CommonTipsBoard
local CommonTipsBoard = import('Game.UI.Common.CommonTipsBoard')
---@type FriendComponent
local friendComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.FriendComponent)
local UIModule = CS.Engine.UI.UIModule

--- from: Assets/BundleResources/Prefabs/Common/CommonPlayerHeadOption.prefab
---@class CommonPlayerHeadOption : CommonTipsBoard
---@field Env                           	CommonPlayerHeadOption                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ClickClose                    	UnityEngine.RectTransform               @ 空白点击关闭
---@field SecondMenuOptionBtn           	UnityEngine.RectTransform               @ 二级菜单网格按钮
---@field SecondMenuGridNode            	UnityEngine.RectTransform               @ 二级菜单网格节点
---@field SecondMenuNode                	UnityEngine.RectTransform               @ 二级菜单节点
---@field FirstMenuGridOptionBtn        	UnityEngine.RectTransform               @ 一级菜单网格按钮
---@field FirstMenuGridNode             	UnityEngine.RectTransform               @ 一级菜单网格节点
---@field PlayerLevelTxt                	UnityEngine.RectTransform               @ 玩家等级文本
---@field PlayerNameTxt                 	UnityEngine.RectTransform               @ 玩家名字文本
---@field PlayerHeadNode                	UnityEngine.RectTransform               @ 玩家头像节点
---@field FirstMenuNode                 	UnityEngine.RectTransform               @ 一级菜单节点
local CommonPlayerHeadOption = Class('CommonPlayerHeadOption', CommonTipsBoard)


function CommonPlayerHeadOption:__init()
    CommonTipsBoard.__init(self)
    ---@type CommonPlayerHeadNode
    self.playerHeadEnv_ = nil
end


function CommonPlayerHeadOption:__delete()
    CommonTipsBoard.__delete(self)
    self.playerHeadEnv_ = nil
end


function CommonPlayerHeadOption:Awake()
    -- CommonTipsBoard.Awake(self)
    self.playerHeadEnv_ = CfUtils.GetLuaScr(self.PlayerHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    self.closeTipsBoardEventCB_ = Events.AddListener(Constants.EventNames.CLOSE_COMMON_TIPS_BOARD, Bind(self, self.OncloseTipsBoardHandler_))
    SetButtonAction(self.ClickClose, Bind(self, self.OnClickCloseButtonHandler_))
    CfUtils.SetActive(self.FirstMenuGridOptionBtn, false)
    CfUtils.SetActive(self.SecondMenuOptionBtn, false)
end


function CommonPlayerHeadOption:Start()
    -- CommonTipsBoard.Start(self)
end


function CommonPlayerHeadOption:OnDestroy()
    Events.RemoveListener(Constants.EventNames.CLOSE_COMMON_TIPS_BOARD, self.closeTipsBoardEventCB_)
    CommonTipsBoard.OnDestroy(self)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return Constants.PlayerHeadOptionType
function CommonPlayerHeadOption:GetOptionType()
    return checkInt(self.optionType_)
end


---@return table
function CommonPlayerHeadOption:GetOptionArgs()
    return checkTable(self.optionArgs_)
end


-------------------------------------------------
-- public

function CommonPlayerHeadOption:Close()
    self:DestroySelf()
end


---@param optionType Constants.PlayerHeadOptionType @ 操作类型
---@param optionArgs table | nil @ 自定义参数
function CommonPlayerHeadOption:RefreshOptionType(optionType, optionArgs)
    self.optionType_ = checkInt(optionType)
    self.optionArgs_ = checkTable(optionArgs)

    -- update playerInfo
    CfUtils.FillText(self.PlayerNameTxt, tostring(optionArgs.name))
    CfUtils.FillText(self.PlayerLevelTxt, tostring(optionArgs.level))
    self.playerHeadEnv_:FreshAvatarFrame(optionArgs.avatar, optionArgs.avatarFrame)

    -- check sync friendList
    local isNeedSyncFriendList = false
    if (optionType == Constants.PlayerHeadOptionType.CLUB_MEMBER or 
        optionType == Constants.PlayerHeadOptionType.Common or
        optionType == Constants.PlayerHeadOptionType.CHAT) then
        isNeedSyncFriendList = true
    end

    -- update menuGridView
    if isNeedSyncFriendList and not friendComp:HasFriendList() then
        friendComp:SyncFriendList(function()
            self:UpdateMenuGridView_()
        end)
    else
        self:UpdateMenuGridView_()
    end
end


-------------------------------------------------
-- private

function CommonPlayerHeadOption:UpdateMenuGridView_()
    local optionType = self:GetOptionType()
    local optionArgs = self:GetOptionArgs()

    local buttonDataList = {}
    local optionPlayerId = checkInt(optionArgs.playerId)
    local myselfPlayerId = checkInt(GameUtils.GetPlayerId())

    ------------------------------------------------- [社团成员]
    if optionType == Constants.PlayerHeadOptionType.CLUB_MEMBER then
        table.insert(buttonDataList, {buttonType = BUTTON_TYPE.VIEW_INFO})

        if friendComp:IsFriend(optionPlayerId) then
            table.insert(buttonDataList, {buttonType = BUTTON_TYPE.FRIEND_REMOVE})
            table.insert(buttonDataList, {buttonType = BUTTON_TYPE.CHAT_PRIVATE})
        else
            table.insert(buttonDataList, {buttonType = BUTTON_TYPE.FRIEND_ADD})
        end

        local myMemberDojo = ClubUtils.GetClubComp():GetHomeDojo().myselfDojo
        if ClubUtils.HasJobFunc(myMemberDojo.job, ClubUtils.JobFuncId.KICKOUT_MEMBER) then
            table.insert(buttonDataList, {buttonType = BUTTON_TYPE.CLUB_KICKOUT})
        end
        if ClubUtils.HasJobFunc(myMemberDojo.job, ClubUtils.JobFuncId.JOB_MANAGER) then
            local subButtonDataList = {}
            -- 只可以任命比自己底的职位，并且排除他当前的职位
            local myClubJob = checkInt(myMemberDojo.job)
            local optionJob = checkInt(optionArgs.clubJob)
            for _, jobType in pairs(ClubUtils.JobType) do
                if myClubJob < jobType and optionJob ~= jobType then
                    table.insert(subButtonDataList, {buttonType = BUTTON_TYPE.CLUB_ASSIGN_JOB, job = jobType})
                end
            end
            -- 如果是会长，额外多一条转让会长
            if myClubJob == ClubUtils.JobType.CHAIRMAN then
                table.insert(subButtonDataList, {buttonType = BUTTON_TYPE.CLUB_ASSIGN_JOB, job = ClubUtils.JobType.CHAIRMAN})
            end
            table.sort(subButtonDataList, function(aSubButtonData, bSubButtonData)
                local aJboType = checkInt(aSubButtonData.job)
                local bJobType = checkInt(bSubButtonData.job)
                return aJboType > bJobType
            end)
            table.insert(buttonDataList, {buttonType = BUTTON_TYPE.CLUB_ASSIGN_JOB, subButtonDataList = subButtonDataList})
        end

    ------------------------------------------------- [通用类型]
    elseif optionType == Constants.PlayerHeadOptionType.Common then
        table.insert(buttonDataList, {buttonType = BUTTON_TYPE.VIEW_INFO})
        if friendComp:IsFriend(optionPlayerId) then
            table.insert(buttonDataList, {buttonType = BUTTON_TYPE.FRIEND_REMOVE})
            table.insert(buttonDataList, {buttonType = BUTTON_TYPE.CHAT_PRIVATE})
        else
            table.insert(buttonDataList, {buttonType = BUTTON_TYPE.FRIEND_ADD})
        end
    ------------------------------------------------- [聊天]
    elseif optionType == Constants.PlayerHeadOptionType.CHAT then
        if friendComp:IsFriend(optionPlayerId) then
            table.insert(buttonDataList, {buttonType = BUTTON_TYPE.FRIEND_REMOVE})
        else
            table.insert(buttonDataList, {buttonType = BUTTON_TYPE.FRIEND_ADD})
        end
    ------------------------------------------------- [未指定类型]
    else
        table.insert(buttonDataList, {buttonType = BUTTON_TYPE.VIEW_INFO})
    end

    -- build firstMenu
    self:BuildMenuGridView_(self.FirstMenuGridNode, self.FirstMenuGridOptionBtn, buttonDataList)
end


---@param menuParent UnityEngine.RectTransform
---@param menuButton UnityEngine.RectTransform
---@param buttonDataList table[]
function CommonPlayerHeadOption:BuildMenuGridView_(menuParent, menuButton, buttonDataList)
    if isNull(menuParent) then return end
    if isNull(menuButton) then return end
    -- clean menuParent
    for childIndex = menuParent.childCount - 1, 1, -1 do
        CfUtils.SafeDelete(menuParent:GetChild(childIndex).gameObject)
    end
    -- update menuButtons
    for buttonIndex, buttonData in ipairs(buttonDataList or {}) do
        local menuBtnObj  = menuParent.gameObject:AddChild(menuButton.gameObject)
        local menuBtnTxt  = menuBtnObj.transform:Find('TextDesc')
        menuBtnObj.name   = string.fmt('menuButton_%1', buttonIndex)
        buttonData.sender = menuBtnObj
        buttonData.index  = buttonIndex
        CfUtils.FillText(menuBtnTxt, self:BuildMenuButtonName_(buttonData))
        SetButtonAction(menuBtnObj, Bind(self, self.OnClickMenuButtonHandler_, buttonData))
        CfUtils.SetActive(menuBtnObj, true)
    end
end


---@param buttonData table
---@return string
function CommonPlayerHeadOption:BuildMenuButtonName_(buttonData)
    local buttonType  = checkInt(buttonData.buttonType)
    local btnNameDict = {
        [BUTTON_TYPE.VIEW_INFO]       = localize('查看信息'),
        [BUTTON_TYPE.CHAT_PRIVATE]    = localize('私聊'),
        [BUTTON_TYPE.FRIEND_ADD]      = localize('添加好友'),
        [BUTTON_TYPE.FRIEND_REMOVE]   = localize('移除好友'),
        [BUTTON_TYPE.CLUB_KICKOUT]    = localize('踢出社团'),
        [BUTTON_TYPE.CLUB_ASSIGN_JOB] = localize('任命'),
    }
    local buttonName = tostring(btnNameDict[checkInt(buttonType)])
    if buttonData.job then
        buttonName = tostring(ClubUtils.GetJobVo(buttonData.job).jobName)
        if buttonData.job == ClubUtils.JobType.CHAIRMAN then
            buttonName = localize('转让_job_', {_job_ = buttonName})
        end
    end
    return buttonName
end


function CommonPlayerHeadOption:ShowSecondMenuPanel_(targetNode, isLeft)
    self.SecondMenuNode.anchoredPosition3D = CfUtils.GetUITargetPos(targetNode, nil, nil, 0, 0, 0, 0.5)
    CfUtils.PlayAnimation(self.SecondMenuNode, isLeft and SECOND_MENU_ANIM.LEFT or SECOND_MENU_ANIM.RIGHT)
    CfUtils.SetActive(self.SecondMenuNode, true)
end


-------------------------------------------------
-- handler

function CommonPlayerHeadOption:OnClickCloseButtonHandler_()
    self:Close()
end


function CommonPlayerHeadOption:OncloseTipsBoardHandler_(eventData)
    if eventData and eventData.name == 'CommonPlayerHeadOption' then
        self:Close()
    end
end


---@param buttonData table
function CommonPlayerHeadOption:OnClickMenuButtonHandler_(buttonData)
    CfUtils.SetActive(self.SecondMenuNode, false)

    if buttonData.subButtonDataList then
        self:BuildMenuGridView_(self.SecondMenuGridNode, self.SecondMenuOptionBtn, buttonData.subButtonDataList)
        self:ShowSecondMenuPanel_(buttonData.sender, buttonData.index%2 == 1)
        return
    end

    local isAutoClose    = true
    local menuButtonType = checkInt(buttonData.buttonType)
    local optionPlayerId = checkInt(self:GetOptionArgs().playerId)
    local myselfPlayerId = checkInt(GameUtils.GetPlayerId())
    -------------------------------------------------
    -- 查看信息
    if menuButtonType == BUTTON_TYPE.VIEW_INFO then
        GameUtils.ShowPlayerInfo(optionPlayerId, self:GetOptionArgs().exclude or {})

    -------------------------------------------------
    -- 好友私聊
    elseif menuButtonType == BUTTON_TYPE.CHAT_PRIVATE then
        local friendData    = friendComp:GetFriendInfo(optionPlayerId)
        local ChatConstants = import('Game.OverseaChat.ChatConstants')
        CfUtils.DialogOpen(Constants.UITypeIds.OverseaChatMainDialog, {type = ChatConstants.Channels.Private, data = friendData})

    -------------------------------------------------
    -- 添加好友
    elseif menuButtonType == BUTTON_TYPE.FRIEND_ADD then
        friendComp:AddFriend(optionPlayerId)

    -------------------------------------------------
    -- 删除好友
    elseif menuButtonType == BUTTON_TYPE.FRIEND_REMOVE then
        friendComp:DelFriend(optionPlayerId,function() Events.Broadcast("CommonPlayerHead_DelFriend") end)

    -------------------------------------------------
    -- 踢出社团
    elseif menuButtonType == BUTTON_TYPE.CLUB_KICKOUT then
        local requestData = {memberId = optionPlayerId}
        GameUtils.Request(Interfaces.OverseaClubKickout, requestData, function(request, response)
            if checkInt(response.errCode) == 0 then
                local responseData   = checkTable(response.data)
                local clubMemberDojo = ClubUtils.GetClubComp():ClubMemberFind(requestData.memberId)
                ClubUtils.GetClubComp():ClubMemberRemove(requestData.memberId)
                GameUtils.Toast(localize('已将【_name_】踢出社团', {
                    _name_ = clubMemberDojo and clubMemberDojo.playerName or ''
                }))
            end
        end)

    -------------------------------------------------
    -- 社团任命
    elseif menuButtonType == BUTTON_TYPE.CLUB_ASSIGN_JOB then
        local clubJobId   = checkInt(buttonData.job)
        local clubJobVo   = ClubUtils.GetJobVo(clubJobId)
        local clubJobName = tostring(clubJobVo.jobName)
        local memberDojo  = ClubUtils.GetClubComp():ClubMemberFind(optionPlayerId)
        local memberName  = memberDojo and memberDojo.playerName or ''
        local toAssignJob = function()
            local requestData = {memberId = optionPlayerId, job = clubJobId}
            GameUtils.Request(Interfaces.OverseaClubAssignJob, requestData, function(request, response)
                if checkInt(response.errCode) == 0 then
                    local responseData = checkTable(response.data)
                    if clubJobId == ClubUtils.JobType.CHAIRMAN then
                        -- 转让会长
                        ClubUtils.GetClubComp():ClubMemberChangeJob(myselfPlayerId, ClubUtils.JobType.MEMBER)
                    end
                    ClubUtils.GetClubComp():ClubMemberChangeJob(requestData.memberId, requestData.job)
                    GameUtils.Toast(localize('已将【_name_】任命为【_job_】', {_name_ = memberName, _job_ = clubJobName}))
                end
            end)
        end
        if clubJobId == ClubUtils.JobType.CHAIRMAN then
            local secondTips = localize('是否将_job_转让给【_name_】', {_name_ = memberName, _job_ = clubJobName})
            GameUtils.SecondConfirm(secondTips, function() 
                toAssignJob()
            end)
        elseif clubJobId ~= ClubUtils.JobType.MEMBER then
            local clubJobMemberMax = checkInt(clubJobVo.jobMember)
            local clubJomMemberNow = ClubUtils.GetClubComp():ClubMembersJobFind(clubJobId)
            if clubJomMemberNow >= clubJobMemberMax then
                GameUtils.Toast(localize('_job_职位已满员', {_job_ = clubJobName}))
            else
                toAssignJob()
            end
        else
            toAssignJob()
        end
    
    end

    if isAutoClose then
        self:Close()
    end
end

return CommonPlayerHeadOption
