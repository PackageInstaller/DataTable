require("ViewModel/Activity/ActivityBattlePrepareEnemyItem")
require("ViewModel/SuiChuNaJi/ViewItem/SCNJBattlePrepareBuffItem")













ActivityBattlePrepareInfo_BossRelay = {}
ActivityBattlePrepareInfo_BossRelay.__index = ActivityBattlePrepareInfo_BossRelay

local objs = {
    damageCount = {path = "RightInfo/DamageCount", type = UITool.Text},
    recommondLevel = {path = "RightInfo/Level/Text", type = UITool.Text},
    bossBuffToggle = {path = "RightInfo/Buff/ToggleGroup/BossStrengthToggle", type = UITool.Toggle},
    playerBuffToggle = {path = "RightInfo/Buff/ToggleGroup/BuffToggle", type = UITool.Toggle},
    buffGroupPrefab = {path = "RightInfo/Buff/BuffGroupItem", type = UITool.GameObject},
    buffScrollList = {path = "RightInfo/Buff/ScrollView", type = UITool.GameObject},
    enemyItem = {path = "RightInfo/Enemys/EnemyItem", type = UITool.GameObject},
    enemysBtn = {path = "RightInfo/Enemys", type = UITool.Button},
    enemyList = {path = "RightInfo/Enemys/List", type = UITool.Transform},
    startBattleBtn = {path = "RightInfo/StartBattleBtn", type = UITool.Button},
    resetTeamBtn = {path = "RightInfo/ResetTeamBtn", type = UITool.Button}
}

function ActivityBattlePrepareInfo_BossRelay.New()

    local self = {}
    setmetatable(self, ActivityBattlePrepareInfo_BossRelay)
    return self
end

function ActivityBattlePrepareInfo_BossRelay:Init()
    UITool.Parse(self.gameObject, self, objs)
    SetActive(self.enemyItem, false)
    SetActive(self.buffGroupPrefab, false)
    self.enemyListUI = UIListView.New(self.enemyList)
    self.buffScrollListUI = UIScrollView.New(self.buffScrollList)
    self.OnClickStartBattleBtn = function()
        local selectMembers = ActivityBattlePrepareMgr.GetSelectMembers()
        self:EnterDungeon(self.dungeonConfig.id, selectMembers)
    end
    self.OnClickResetTeamBtn = function()
        local data = {}
        data.showNoAgainToggle = false
        data.content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29518")
        data.OnClickRightBtn = function()
            self:OnConfirmResetTeam()
        end
        LuaMgr.ShowLuaPanel(UIName.SCNJMsgBoxPopup, data)
    end
    self.OnClickEnemysBtn = function()
        LuaMgr.ShowLuaPanel(UIName.BattlePrepareEnemyViewModel, self.dungeonConfig, self.monsterList)
    end

    self.OnClickBossBuffToggle = function(value)
        if value == true then
            self:RefreshBossBuffList()
        end
    end
    self.OnClickPlayerBuffToggle = function(value)
        if value == true then
            self:RefreshPlayerBuffList()
        end
    end
    LuaMgr.AddClick(self.startBattleBtn, self.OnClickStartBattleBtn)
    LuaMgr.AddClick(self.resetTeamBtn, self.OnClickResetTeamBtn)
    LuaMgr.AddClick(self.enemysBtn, self.OnClickEnemysBtn)
    self.bossBuffToggle.onValueChanged:AddListener(self.OnClickBossBuffToggle)
    self.playerBuffToggle.onValueChanged:AddListener(self.OnClickPlayerBuffToggle)
    self.allServerBuffDatas = {}
end

function ActivityBattlePrepareInfo_BossRelay:SetData(dungeonConfig, activityInfo)
    SCNJData.SetOldPlayerTotalScore()
    self.dungeonConfig = dungeonConfig
    self.activityInfo = activityInfo
    self.teamData = activityInfo.paramData.data
    self.diffcultConfig = activityInfo.paramData.diffcultConfig
    self.isSweep = activityInfo.paramData.sweep
    local damage = SCNJData.GetDungeonDmage(self.teamData.DiffId, self.teamData.StageIndex)
    self.damageCount.text = SCNJData.GetScore(damage)
    self.recommondLevel.text = dungeonConfig.levelShow
    self.bossBuffToggle.isOn = true
    self.allServerBuffDatas = SCNJData.GetAllServerBuff()
    self:RefreshBossBuffList()
    self:SetEmemys()
end

function ActivityBattlePrepareInfo_BossRelay:RefreshPlayerBuffList()
    self.buffScrollListUI:Clear()
    local scrollDatas = {}
    local allDatas = self.allServerBuffDatas
    local len = math.ceil(#allDatas / 2)
    for i = 1, len do
        local data = {}
        data.buffData1 = allDatas[2 * i - 1]
        data.buffData2 = allDatas[2 * i]

        local scrollData = UIScrollData.GetData(self.buffGroupPrefab, "SCNJBattlePrepareBuffItem", 262, 44, data)
        table.insert(scrollDatas, scrollData)
    end
    self.buffScrollListUI:SetParams(262, 153)
    self.buffScrollListUI:SetData(scrollDatas, true)
end

function ActivityBattlePrepareInfo_BossRelay:RefreshBossBuffList()
    self.buffScrollListUI:Clear()
    local scrollDatas = {}
    local allDatas = {}
    local buffIDs = self.teamData.BuffGroup
    for i = 1, #buffIDs do
        local buffID = buffIDs[i]
        local config = ConfigMgr.Config.TeamRelayBuffDescMap[buffID]
        local data = table.CopyNoMeta(config)
        data.Name = LuaMgr.GetLangText(data.BuffNameLan)
        data.Desc = LuaMgr.GetLangText(data.BuffDesLan)
        table.insert(allDatas, data)
    end
    local len = math.ceil(#allDatas / 2)
    for i = 1, len do
        local data = {}
        data.buffData1 = allDatas[2 * i - 1]
        data.buffData2 = allDatas[2 * i]
        local scrollData = UIScrollData.GetData(self.buffGroupPrefab, "SCNJBattlePrepareBuffItem", 262, 44, data)
        table.insert(scrollDatas, scrollData)
    end
    self.buffScrollListUI:SetParams(262, 153)
    self.buffScrollListUI:SetData(scrollDatas, true)
end

function ActivityBattlePrepareInfo_BossRelay:OnConfirmResetTeam()
    local teamIDs = {}
    table.insert(teamIDs, tostring(self.teamData.StageIndex))
    local callback = function()
        self:RefreshTeam()
    end
    SCNJData.OnResetTeamData(self.diffcultConfig.Id, teamIDs, callback)
end

function ActivityBattlePrepareInfo_BossRelay:RefreshTeam()
    ActivityBattlePrepareMgr.SetMembers(ActivityKey.TeamRelay, self.teamData.Id)
    if self.activityInfo.resetTeamCallback ~= nil then
        self.activityInfo.resetTeamCallback()
    end
end


function ActivityBattlePrepareInfo_BossRelay:EnterDungeon(dungeonId, members)
    local len = #members
    if (len <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("MiniBattlePrepareViewModel_1"))
        return
    end
    local memberDic = {}
    local helpDic = {}
    for i = 1, len do
        local id = members[i]
        local index = tostring(i - 1)
        memberDic[index] = id
        if (PlayerAssistMgr.IsAssistMember(id)) then
            helpDic[index] = PlayerAssistMgr.GetAssistMemberUid(id)
        else
            helpDic[index] = ""
        end
    end
    local enterDungeonParams = self:GetEnterDungeonParam(dungeonId, memberDic, helpDic)
    BattlePrepareMgr._enterDungeonParams = enterDungeonParams
    LuaMgr.SceneSwitchMark({UIName.ActivityBattlePrepareViewModel})
    PlayerAreaMgr.SetAreaDungeonId("-1")
    local onSucc = function(result)
        local re = json.decode(result)
        local data = json.encode(re.result)
        LuaMgr.EnterBattle(data, -1)
    end
    ApiMgr.Request("enter_dungeon", enterDungeonParams, true, onSucc, nil, true)
end

function ActivityBattlePrepareInfo_BossRelay:GetEnterDungeonParam(dungeonId, memberDic, helpDic)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = dungeonId
    enterDungeonParams.dungeonId = dungeonId
    enterDungeonParams.members = memberDic
    enterDungeonParams.helps = helpDic
    enterDungeonParams.diffcultID = self.diffcultConfig.Id
    local dungeonID = self.teamData.Id
    if self.isSweep == true then
        dungeonID = -1
    end
    local buffIDs = table.CopyNoMeta(self.teamData.BuffGroup)
    local allServerBuff = self.allServerBuffDatas
    for i = 1, #allServerBuff do
        local buffData = allServerBuff[i]
        if buffData.BuffID ~= nil and buffData.BuffID ~= "" then
            table.insert(buffIDs, buffData.BuffID)
        end
    end


    local newHelpLevel, _, helpScore = SCNJData.GetCurHelpLevel()
    local additions = SCNJData.GetHelpAddition(newHelpLevel)
    local talentIDs = {}
    for key, value in pairs(additions) do
        table.insert(talentIDs, value.Config.id)
    end

    local buffParams = table.concat(buffIDs, ";")
    local talentParams = table.concat(talentIDs, ";")
    enterDungeonParams.extraParams = {"team_relay", SCNJConst.TeamRelayID, tostring(self.teamData.StageIndex), dungeonID, buffParams, talentParams}
    return enterDungeonParams
end


function ActivityBattlePrepareInfo_BossRelay:SetEmemys()
    self.enemyListUI:Clear()
    self:SetMonsterIdList()
    local listDatas = {}
    local monsterMap = ConfigMgr.Config.monsterMap
    for _, v in ipairs(self.monsterList) do
        local monster = monsterMap[v]
        if monster ~= nil and not monster.hideShowinfo then
            local listData = UIListData.GetData(self.enemyItem, "ActivityBattlePrepareEnemyItem", monster)
            table.insert(listDatas, listData)
            if #listDatas >= 3 then
                break
            end
        end
    end
    self.enemyListUI:SetData(listDatas)
end


function ActivityBattlePrepareInfo_BossRelay:SetMonsterIdList()
    local str = LuaMgr.UpdateMonsterIdList(self.dungeonConfig.flowScript)
    self.monsterList = json.decode(str)
end



function ActivityBattlePrepareInfo_BossRelay:Clear()
    self.bossBuffToggle.isOn = true
    self.playerBuffToggle.isOn = false
    self.buffScrollListUI:Clear()
    self.enemyListUI:Clear()
end

function ActivityBattlePrepareInfo_BossRelay:Destroy()
    self.buffScrollListUI:Clear()
    self.enemyListUI:Clear()
    UIScrollView.ClearItem("SCNJBattlePrepareBuffItem")
    UIScrollView.ClearItem("ActivityBattlePrepareEnemyItem")
    LuaMgr.Destroy(self.gameObject)
    self.gameObject = nil
end