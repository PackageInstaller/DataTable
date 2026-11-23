require("ViewModel/SuiChuNaJi/ViewItem/SCNJBuffLevelUpItem")
require("ViewModel/SuiChuNaJi/ViewItem/SCNJTeamItem")
local objs = {
    buffItem = {path = "template/BuffItem", type = UITool.GameObject},
    teamItem = {path = "template/TeamItem", type = UITool.GameObject},
    totalFireworkNum = {path = "root/Middle/LeftBG/TotalFireworkNum", type = UITool.Text},
    diffcultText = {path = "root/Middle/LeftBG/DiffcultText", type = UITool.Text},
    buffScrollView = {path = "root/Middle/LeftBG/BuffScrollView", type = UITool.GameObject},
    resetTeamBtn = {path = "root/Middle/LeftBG/ResetTeamBtn", type = UITool.Button},
    fastThroughBtn = {path = "root/Middle/Right/FastThroughBtn", type = UITool.Button},
    fireBoomBtn = {path = "root/Middle/Right/FireBoomBtn", type = UITool.Button},
    fireCount = {path = "root/Middle/Right/FireBoomBtn/FireCount", type = UITool.Text},
    teamScrollView = {path = "root/Middle/Right/TeamScrollView", type = UITool.GameObject},
    fireBoomBtnText = {path = "root/Middle/Right/FireBoomBtn/FireBoomBtnText", type = UITool.Text}
}

local this = {}

this.before_awake = function()
    this.buffScrollViewUI = UIScrollView.New(this.buffScrollView)
    this.teamScrollViewUI = UIScrollView.New(this.teamScrollView)
end

this.before_active = function()
    this.Refresh()
end

this.Refresh = function()
    local totalDamage = SCNJData.GetDungeonGroupTotalDamage(this.paramsData.Config.Id)
    this.totalFireworkNum.text = tostring(totalDamage)
    this.diffcultText.text = string.format("%s%%", this.paramsData.Config.DiffDesc)
    local dailyCount, maxCount = SCNJData.GetChallengeCount()
    local challengeCountLan = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29606")
    this.fireCount.text = string.format(challengeCountLan, dailyCount, maxCount)
    this.RefreshTeamList()
    this.RefreshBuffList()
end

this.RefreshTeamList = function()
    this.teamScrollViewUI:Clear()
    local allDatas = SCNJData.GetDungeonTeamDatas(this.paramsData.DungeonDic)
    this.dungeonTeamDatas = allDatas
    local scrollDatas = {}
    local isAllFinishDungeon = true
    local teamNumLanStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29542")
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.IsSelected = false
        data.TeamName = string.format(teamNumLanStr, i)
        data.OnSelectTeam = this.OnSelectTeam
        local isAllThroughTeam = data.TeamData == nil
        if isAllThroughTeam then
            isAllFinishDungeon = false
        end
    end
    SetActive(this.fastThroughBtn.gameObject, isAllFinishDungeon == true)
    local hasEmptyTeamData = false
    local firstEmptyIndex = nil
    for i = 1, #allDatas do
        local data = allDatas[i]
        if data.IsShow == true then
            if data.TeamData == nil then
                hasEmptyTeamData = true
                firstEmptyIndex = i
                break
            end
        end
    end
    if hasEmptyTeamData then
        allDatas[firstEmptyIndex].IsSelected = true
    else
        for i = 1, #allDatas do
            if allDatas[i].IsShow == true then
                allDatas[i].IsSelected = true
                break
            end
        end
    end
    for i = 1, #allDatas do
        local data = allDatas[i]
        if data.IsShow == true then
            local scrollData = UIScrollData.GetData(this.teamItem, "SCNJTeamItem", 634, 140, data)
            table.insert(scrollDatas, scrollData)
        end
    end

    this.teamScrollViewUI:SetParams(634, 455)
    this.teamScrollViewUI:SetData(scrollDatas, true)
end

this.RefreshBuffList = function()
    this.buffScrollViewUI:Clear()
    local allDatas = SCNJData.GetAllServerBuff()
    local scrollDatas = {}
    local itemWidth = 97
    for i = 1, #allDatas do
        local data = allDatas[i]
        local scrollData = UIScrollData.GetData(this.buffItem, "SCNJBuffLevelUpItem", itemWidth, 134, data)
        table.insert(scrollDatas, scrollData)
    end
    local scrollWidth = #allDatas * itemWidth
    scrollWidth = math.max(scrollWidth, 392)
    this.buffScrollViewUI:SetParams(scrollWidth, 134)
    this.buffScrollViewUI:SetData(scrollDatas, true)
end



this.OnSelectTeam = function(item)
    if this.lastSelectItem ~= nil then
        this.lastSelectItem:SetSelected(false)
    end
    local lanStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29541")
    this.fireBoomBtnText.text = string.format(lanStr, NumTool.GetMaxNum(item.data.StageIndex))
    this.lastSelectItem = item
    this.lastSelectItem:SetSelected(true)
end

this.OnClickResetTeamBtn = function()
    local data = {}
    data.showNoAgainToggle = false
    data.content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29517")
    data.OnClickRightBtn = function()
        this.OnConfirmResetTeam()
    end
    LuaMgr.ShowLuaPanel(UIName.SCNJMsgBoxPopup, data)
end

this.OnConfirmResetTeam = function()
    local dungeonTeamDatas = this.dungeonTeamDatas
    local teamIDs = {}
    for key, data in pairs(dungeonTeamDatas) do
        if data.TeamData ~= nil then
            table.insert(teamIDs, tostring(data.StageIndex))
        end
    end
    SCNJData.OnResetTeamData(this.paramsData.Config.Id, teamIDs, this.Refresh)
end

this.OnClickFastThroughBtn = function()
    if SCNJData.CheckActivityRunning() == false then
        return
    end
    local data = {}
    local totalDamage = SCNJData.GetDungeonGroupTotalDamage(this.paramsData.Config.Id, true)
    data.maxScore = SCNJData.GetScore(math.floor(totalDamage / 3))
    data.OnConfirmCallback = function(selectCount)
        this.OnConfirmFastThrough(selectCount)
    end
    LuaMgr.ShowLuaPanel(UIName.SCNJFastThroughPopup, data)
end

this.OnConfirmFastThrough = function(selectCount)
    if SCNJData.CheckActivityRunning() == false then
        return
    end
    SCNJData.SetTempTeamIndex(this.lastSelectItem.data.StageIndex)
    ActivityBattlePrepareMgr.SetMembers(ActivityKey.TeamRelay, this.lastSelectItem.data.Id)
    local enterDungeonParams = this.GetEnterDungeonParam(this.lastSelectItem.data.DungeonId)
    enterDungeonParams.count = selectCount
    local onSuccess = function(result)
        local totalDamage = SCNJData.GetDungeonGroupTotalDamage(this.paramsData.Config.Id, true)
        local data = {}
        data.fastThroughCount = selectCount
        data.averageScore = SCNJData.GetScore(math.floor(totalDamage / 3))
        LuaMgr.ShowLuaPanel(UIName.SCNJFastThroughFinishPanel, data)
    end
    ApiMgr.Request("enter_leave_dungeon", enterDungeonParams, true, onSuccess, nil, true, true)
end

this.GetEnterDungeonParam = function(dungeonId)
    local teamData = this.lastSelectItem.data
    local teamIndex = math.random(1, 3)
    local memberDic, helpDic = SCNJData.GetLockMembersAndHelps(teamData.Id, teamIndex)

    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = dungeonId
    enterDungeonParams.dungeonId = dungeonId
    enterDungeonParams.members = memberDic
    enterDungeonParams.helps = helpDic
    enterDungeonParams.diffcultID = this.paramsData.Config.Id
    local dungeonID = "-1"
    local buffIDs = table.CopyNoMeta(teamData.BuffGroup)
    local allServerBuff = SCNJData.GetAllServerBuff()
    for i = 1, #allServerBuff do
        local buffData = allServerBuff[i]
        if buffData.BuffID ~= nil and buffData.BuffID ~= "" then
            table.insert(buffIDs, buffData.BuffID)
        end
    end
    local buffParams = table.concat(buffIDs, ";")
    enterDungeonParams.extraParams = {"team_relay", SCNJConst.TeamRelayID, tostring(teamIndex), dungeonID, buffParams}
    return enterDungeonParams
end

this.OnClickFireBoomBtn = function()
    if SCNJData.CheckActivityRunning() == false then
        return
    end
    local dailyCount, maxCount = SCNJData.GetChallengeCount()
    local nowstamp = LuaMgr.Timestamp()
    local nowDate = DateTool.UnixToDateTime(nowstamp, 1)
    local archiveKey = SCNJData.GetNoAgainTipsKey()
    local isNoNeedTips = SCNJData.GetArchiveByKey(archiveKey) == nowDate.Day
    if dailyCount >= maxCount and isNoNeedTips == false then
        local data = {}
        data.showNoAgainToggle = true
        data.content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29519")
        data.noAgainTipsKey = archiveKey
        data.OnClickRightBtn = this.IntoBattlePrepare
        LuaMgr.ShowLuaPanel(UIName.SCNJMsgBoxPopup, data)
    else
        this.IntoBattlePrepare()
    end
end

this.IntoBattlePrepare = function()
    local tempData = {}
    tempData.data = this.lastSelectItem.data
    tempData.diffcultConfig = this.paramsData.Config
    tempData.sweep = false
    SCNJData.SetTempTeamIndex(tempData.data.StageIndex)
    ActivityBattlePrepareMgr.SetMembers(ActivityKey.TeamRelay, tempData.data.Id)
    LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.TeamRelay, tempData)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.resetTeamBtn, this.OnClickResetTeamBtn)
        LuaMgr.AddClick(this.fastThroughBtn, this.OnClickFastThroughBtn)
        LuaMgr.AddClick(this.fireBoomBtn, this.OnClickFireBoomBtn)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length < 1 then
            return
        end
        this.paramsData = vm.behaviour.Params[0].data
        this.battleDifficult = this.paramsData.Config.DiffDesc
        this.before_active()
    end,
    before_deactive = function(vm)
        UIScrollView.ClearItem("SCNJBuffLevelUpItem")
    end,
    before_destroy = function(vm)
        LuaMgr.AddClick(this.resetTeamBtn, this.OnClickResetTeamBtn)
        LuaMgr.AddClick(this.fastThroughBtn, this.OnClickFastThroughBtn)
        LuaMgr.AddClick(this.fireBoomBtn, this.OnClickFireBoomBtn)
        UIScrollView.ClearItem("SCNJTeamItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)