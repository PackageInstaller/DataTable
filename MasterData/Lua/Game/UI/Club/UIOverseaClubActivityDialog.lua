-------------------------------------------------------------------------------
-- 社团 - 社团活动界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-13 19:37:03
-------------------------------------------------------------------------------

local CountdownTimerName = 'UIOverseaClubActivityDialog_CountdownTimerName'
local EntryListCellPath  = 'Game.UI.Club.UIOverseaClubActivityEntryCell'
local EntryListCellName  = 'Cell'

local ActivityEntryCell  = import('Game.UI.Club.UIOverseaClubActivityEntryCell')
---@type ClubGVGUtils
local ClubGVGUtils       = import('Game.UI.Club.GVG.ClubGVGUtils')

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubActivityDialog.prefab > name: OverseaClubActivityDialog
---@class UIOverseaClubActivityDialog
---@field Env                           	UIOverseaClubActivityDialog             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field EntryListView                 	SuperScrollView.LoopListView2           	@ 1    入口列表
local UIOverseaClubActivityDialog = Class('UIOverseaClubActivityDialog')


function UIOverseaClubActivityDialog:__init()
end


function UIOverseaClubActivityDialog:__delete()
end


function UIOverseaClubActivityDialog:Awake()
    SetListViewAction(self.EntryListView, Bind(self, self.OnUpdateEntryListCellHandler_), EntryListCellName)
end


function UIOverseaClubActivityDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)

        self:InitEntryListData_()
        self:UpdateEntryListView_()
        self:StartEntryCountdown_()
    end)
end


function UIOverseaClubActivityDialog:OnFinalize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}

        -- remove redPoint callback
        for _, entryData in ipairs(self:GetEntryDataList()) do
            if entryData.redPoint then
                GameUtils.RemoveRedPointCallBack(entryData.redPoint)
            end
        end

        self:CancelEntryCountdown_()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return table[]
function UIOverseaClubActivityDialog:GetEntryDataList()
    return checkTable(self.entryDataList_)
end


-------------------------------------------------
-- private

function UIOverseaClubActivityDialog:InitEntryListData_()
    local clubHomeDojo  = ClubUtils.GetClubComp():GetHomeDojo()
    self.entryDataList_ = {}

    -- check boss entry
    if clubHomeDojo:IsOpenedBossEntry() then
        table.insert(self.entryDataList_, {
            entryType = ClubUtils.ActivityEntryType.BOSS,
            entryName = localize('特训'),
            isOpening = clubHomeDojo:IsBossEntryOpening(),
            systemId  = Constants.SystemToggleIds.Id4004,
            startTime = clubHomeDojo.bossStartTime,
            endedTime = clubHomeDojo.bossEndTime,
            clickCb   = Bind(self, self.OnClickBossEntryCallback_),
            redPoint  = Constants.RedPointConst.ClubBoss,
            redBindCb = function(cellEnv)
                ---@param redPointDojo RedPointDojo
                GameUtils.BindRedPoint(Constants.RedPointConst.ClubBoss, true, true, nil, function(redPointDojo)
                    cellEnv:SetShowRedPoint(redPointDojo.pointNum > 0)
                end)
            end,
            bossData = {
                leftTimes = clubHomeDojo.bossLeftTimes,
            },
        })
    end

    -- check car entry
    if clubHomeDojo:IsOpenedCarEntry() then
        table.insert(self.entryDataList_, {
            entryType = ClubUtils.ActivityEntryType.CAT_CAR,
            entryName = localize('喵车'),
            systemId  = Constants.SystemToggleIds.Id4005,
            isOpening = clubHomeDojo:IsCarEntryOpening(),
            startTime = clubHomeDojo.carStartTime,
            endedTime = clubHomeDojo.carEndTime,
            clickCb   = Bind(self, self.OnClickCatCarEntryCallback_),
            redBindCb = function(cellEnv)
                ---@param redPointDojo RedPointDojo
                GameUtils.BindRedPoint(Constants.RedPointConst.ClubCatCar, true, true, nil, function(redPointDojo)
                    cellEnv:SetShowRedPoint(redPointDojo.pointNum > 0)
                end)
            end,
        })
    end

    -- check gvg entry
    if clubHomeDojo:IsOpenedGvgEntry() then
        local myMemberDojo = ClubUtils.GetClubComp():GetHomeDojo().myselfDojo
        table.insert(self.entryDataList_, {
            entryType = ClubUtils.ActivityEntryType.GVG,
            entryName = localize('社团GVG'),
            systemId  = Constants.SystemToggleIds.Id4006,
            isOpening = clubHomeDojo:IsGvgEntryOpening(),
            startTime = clubHomeDojo.gvgStartTime,
            endedTime = clubHomeDojo.gvgEndTime,
            isShowRank = clubHomeDojo.gvgScheduleId > 1,
            clickCb   = Bind(self, self.OnClickGVGEntryCallback_),
            gvgData = {
                applyStartTime  = clubHomeDojo.gvgApplyStartTime,
                applyEndTime    = clubHomeDojo.gvgApplyEndTime,
                battleEnterTime = clubHomeDojo.gvgBattleEnterTime,
                battleStartTime = clubHomeDojo.gvgBattleStartTime,
                isOperateApply  = ClubUtils.HasJobFunc(myMemberDojo.job, ClubUtils.JobFuncId.GVG_APPLY),
            },
            redBindCb = function(cellEnv)
                ---@param redPointDojo RedPointDojo
                GameUtils.BindRedPoint(Constants.RedPointConst.ClubGVG, true, true, nil, function(redPointDojo)
                    cellEnv:SetShowRedPoint(redPointDojo.pointNum > 0)
                end)
            end,
        })
    end

    -- to be continue
    table.insert(self.entryDataList_, {isEmpty = true})
end


function UIOverseaClubActivityDialog:UpdateEntryListView_()
    local listDataLength = #self:GetEntryDataList()
    GameUtils.ReloadData(self.EntryListView, listDataLength)
end


function UIOverseaClubActivityDialog:StartEntryCountdown_()
    self:CancelEntryCountdown_()
    CfUtils.TimerAppend(CountdownTimerName, 1, function()
        -- FIXME 按理说吧，应该要有倒计时结束后的刷新处理。等策划提出需求再做吧
        Events.Broadcast(ClubUtils.EventName.ACTIVITY_ENTRY_COUNTDOWN)
    end)
end


function UIOverseaClubActivityDialog:CancelEntryCountdown_()
    CfUtils.TimerRemove(CountdownTimerName)
end


-------------------------------------------------
-- handler

---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function UIOverseaClubActivityDialog:OnUpdateEntryListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(EntryListCellName)
    local cellData = self:GetEntryDataList()[luaIndex]
    ---@type UIOverseaClubActivityEntryCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, EntryListCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickEntryCB(Bind(self, self.OnClickTaskCellDrawButtonCallback_))
        -- bind redPoint
        if cellData.redBindCb then
            cellData.redBindCb(cellEnv)
        else
            cellEnv:SetShowRedPoint(false)
        end
    end
    return cellNode
end


---@param luaIndex integer @ start at 1
---@param cellState integer
function UIOverseaClubActivityDialog:OnClickTaskCellDrawButtonCallback_(luaIndex, cellState)
    local cellData = self:GetEntryDataList()[luaIndex]
    if cellData.clickCb then
        cellData.clickCb(luaIndex, cellData, cellState)
    else
        GameUtils.Toast('跟我读：' .. luaIndex)
    end
end


---@param luaIndex integer
---@param cellData table
---@param cellState integer
function UIOverseaClubActivityDialog:OnClickBossEntryCallback_(luaIndex, cellData, cellState)
    CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubBossMainDialog, nil, {
        UIArgs(Constants.UITypeIds.UIOverseaClubHallDialog),
        UIArgs(Constants.UITypeIds.UIOverseaClubActivityDialog)
    })
end


---@param luaIndex integer
---@param cellData table
---@param cellState integer
function UIOverseaClubActivityDialog:OnClickCatCarEntryCallback_(luaIndex, cellData, cellState)
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    if not clubHomeDojo:IsCarEntryOpening() then
        GameUtils.Toast(localize('活动未开启'))
        return
    end
    ---@type OverseaClubCatCarUtils
    local CatCarUtils = import('Game.UI.Club.CatCar.OverseaClubCatCarUtils')
    CatCarUtils:CatCatEntry()
end


---@param luaIndex integer
---@param cellData table
---@param cellState integer
function UIOverseaClubActivityDialog:OnClickGVGEntryCallback_(luaIndex, cellData, cellState)
    if not ClubGVGUtils.CheckIsCanEnterGVG() then
        return
    end
    
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()

    ------------------------------------------------- [报名阶段]
    if cellState == ActivityEntryCell.EntryCellState.GVG_APPLY then
        if clubHomeDojo:IsGvgApplied() then
            GameUtils.Toast(localize('当前已报名，请等待活动开启'))
        else
            if cellData.gvgData.isOperateApply then
                local needMemberCount   = ClubGVGUtils.GetParamValue(ClubGVGUtils.Constants.ParamsId.ApplyMemberCount)
                local needActivityPoint = ClubGVGUtils.GetParamValue(ClubGVGUtils.Constants.ParamsId.ApplyActivityPoint)
                if #clubHomeDojo.memberList < needMemberCount then
                    GameUtils.Toast(localize('社团人数小于_num_人，暂不可报名', {_num_ = needMemberCount}))
                    return
                end
                if clubHomeDojo.gvgActivityPoint < needActivityPoint then
                    GameUtils.Toast(localize('社团周活跃度不足_num_，暂不可报名', {_num_ = needActivityPoint}))
                    return
                end
                
                CfUtils.DialogOpen(Constants.UITypeIds.ClubGVGGroupEnrollListPopup, nil, {
                    UIArgs(Constants.UITypeIds.UIOverseaClubActivityDialog)
                })

            else
                GameUtils.Toast(localize('请通知社长报名'))
            end
        end

    ------------------------------------------------- [GVG准备阶段]
    elseif cellState == ActivityEntryCell.EntryCellState.GVG_READY then
        GameUtils.Toast(localize('当前已报名，请等待活动开启'))

    ------------------------------------------------- [GVG未参加]
    elseif cellState == ActivityEntryCell.EntryCellState.GVG_ABSENT then
        GameUtils.Toast(localize('本轮未报名，敬请期待下一轮'))

    ------------------------------------------------- [ 战前预览 | 站中阶段 ]
    elseif cellState == ActivityEntryCell.EntryCellState.GVG_PREVIEW or cellState == ActivityEntryCell.EntryCellState.OPENING then
        if clubHomeDojo:IsGvgSingEnable(GameUtils.GetPlayerId()) then
            ClubGVGUtils.EnterScene()
        else
            GameUtils.Toast(localize('活跃度不足，未能参与'))
        end

    else
        CfUtils.ShowModuleToast(Constants.SystemToggleIds.Id400601)
    end
end


return UIOverseaClubActivityDialog
