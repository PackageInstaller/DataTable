require("ViewModel/Activity/ActivityBattlePrepareEnemyItem")
require("ViewModel/Activity/SeasonSLGBossBattlePrepareBuffItem")
require("SeasonSLG/SeasonSLGMapMgr")
ActivityBattlePrepareInfo_SeasonSLGBoss = {}
ActivityBattlePrepareInfo_SeasonSLGBoss.__index = ActivityBattlePrepareInfo_SeasonSLGBoss

local objs = {
    damageCount = {path = "RightInfo/DamageCount", type = UITool.Text},
    damageCountObj = {path = "RightInfo/DamageCount", type = UITool.GameObject},
    recommondLevel = {path = "RightInfo/Level/Text", type = UITool.Text},
    bossBuffToggle = {path = "RightInfo/Buff/ToggleGroup/BossStrengthToggle", type = UITool.Toggle},
    playerBuffToggle = {path = "RightInfo/Buff/ToggleGroup/BuffToggle", type = UITool.Toggle},
    buffGroupPrefab = {path = "RightInfo/Buff/BuffGroupItem", type = UITool.GameObject},
    buffScrollList = {path = "RightInfo/Buff/ScrollView", type = UITool.GameObject},
    enemyItem = {path = "RightInfo/Enemys/EnemyItem", type = UITool.GameObject},
    enemysBtn = {path = "RightInfo/Enemys", type = UITool.Button},
    enemyList = {path = "RightInfo/Enemys/List", type = UITool.Transform},
    startBattleBtn = {path = "RightInfo/StartBattleBtn", type = UITool.Button},
    resetTeamBtn = {path = "RightInfo/ResetTeamBtn", type = UITool.Button},
    txtPower = {path = "RightInfo/power/txtPower", type = "Text"},
}

function ActivityBattlePrepareInfo_SeasonSLGBoss.New()
    local self = {}
    setmetatable(self, ActivityBattlePrepareInfo_SeasonSLGBoss)
    return self
end

function ActivityBattlePrepareInfo_SeasonSLGBoss:Init()
    UITool.Parse(self.gameObject, self, objs)
    SetActive(self.enemyItem, false)
    self.enemyListUI = UIListView.New(self.enemyList)
    self.buffScrollListUI = UIScrollView.New(self.buffScrollList)
    self.OnClickStartBattleBtn = function()
        local selectMembers = ActivityBattlePrepareMgr.GetSelectMembers()
        self:EnterDungeon(self.dungeonConfig.id, selectMembers)
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

    LuaMgr.AddClick(self.enemysBtn, self.OnClickEnemysBtn)
    self.bossBuffToggle.onValueChanged:AddListener(self.OnClickBossBuffToggle)
    self.playerBuffToggle.onValueChanged:AddListener(self.OnClickPlayerBuffToggle)
    self.allServerBuffDatas = SeasonSLGMapMgr.GetBoss2ChallengeBuffs()
end

function ActivityBattlePrepareInfo_SeasonSLGBoss:SetData(dungeonConfig, activityInfo)
    SCNJData.SetOldPlayerTotalScore()
    self.activityInfo = activityInfo;
    self.GridId = activityInfo.GridId
    self.eventDungeonConfig = ConfigMgr.Config.SeasonalGridBOSSDungeonMap[activityInfo.eventId];
    self.dungeonConfig = dungeonConfig
    self.activityInfo = activityInfo
    self.isSweep = false












    SetActive(self.damageCountObj, false)
    self.recommondLevel.text = dungeonConfig.levelShow
    self.bossBuffToggle.isOn = true
    self.allServerBuffDatas = {  }
    self:RefreshBossBuffList()
    self:SetEmemys()
    self.txtPower.text = tostring(self.eventDungeonConfig.DifficultyLevel)
end

function ActivityBattlePrepareInfo_SeasonSLGBoss:RefreshPlayerBuffList()
    self.buffScrollListUI:Clear()
    local scrollDatas = {}
    local allDatas = self.allServerBuffDatas
    local len = math.ceil(#allDatas / 2)
    for i = 1, len do
        local data = {}
        data.buffData1 = allDatas[2 * i - 1]
        data.buffData2 = allDatas[2 * i]

        local scrollData = UIScrollData.GetData(self.buffGroupPrefab, "SeasonSLGBossBattlePrepareBuffItem", 262, 44, data)
        table.insert(scrollDatas, scrollData)
    end
    self.buffScrollListUI:SetParams(262, 153)
    self.buffScrollListUI:SetData(scrollDatas, true)
end

function ActivityBattlePrepareInfo_SeasonSLGBoss:RefreshBossBuffList()
    self.buffScrollListUI:Clear()
    local scrollDatas = {}
    local allDatas = {}
    local buffIDs = self.eventDungeonConfig.BuffGroup
    for i = 1, #buffIDs do
        local buffID = buffIDs[i]
        local config = ConfigMgr.Config.SeasonalBuffMap[buffID]
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
        local scrollData = UIScrollData.GetData(self.buffGroupPrefab, "SeasonSLGBossBattlePrepareBuffItem", 262, 44, data)
        table.insert(scrollDatas, scrollData)
    end
    self.buffScrollListUI:SetParams(262, 153)
    self.buffScrollListUI:SetData(scrollDatas, true)
end



function ActivityBattlePrepareInfo_SeasonSLGBoss:CheckCostEnough()
    local costItem = self.eventDungeonConfig.Consume[1]
    return DataHelper.GetItemCountById(costItem.id) >= costItem.count
end

function ActivityBattlePrepareInfo_SeasonSLGBoss:EnterDungeon(dungeonId, members)
    if not self:CheckCostEnough() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBattlePrepareInfo_SeasonSLG_1"))
        return
    end
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

    local curSeasonal = SeasonSLGMapMgr.GetCurSeasonCfgData()
    ApiMgr.Request("seasonal/freeUseActor", {Members=memberDic,DungeonActorId=curSeasonal.ActorId} , true, function(result)

        ApiMgr.Request("enter_dungeon", enterDungeonParams, true, function(result)
            local re = json.decode(result);
            local data = json.encode(re.result);
            LuaMgr.EnterBattle(data, -1);
        end, function(code)
        end, true);

    end, function(code)

    end, true);
end

function ActivityBattlePrepareInfo_SeasonSLGBoss:GetEnterDungeonParam(dungeonId, memberDic, helpDic)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = dungeonId
    enterDungeonParams.dungeonId = dungeonId
    enterDungeonParams.members = memberDic
    enterDungeonParams.helps = helpDic
    enterDungeonParams.extraParams = {"seasonal",tostring(self.GridId),tostring(self.activityInfo.eventType),self.activityInfo.bossId,self.activityInfo.dungeonGroupId,self.activityInfo.eventId,self.activityInfo.timeEventType,dungeonId,""}
    table.insert(enterDungeonParams.extraParams,"ordinary")
    local allBuff = {}
    for _, buffData in ipairs(SeasonSLGMapMgr.GetActiveSeasonalBuff() or {}) do
        if not IsNullOrEmpty(buffData.BuffId) then
            table.insert(allBuff,buffData.BuffId)
        end
    end
    SeasonSLGMapMgr.GetAllMisinterBuff(allBuff)
    BattlePrepareMgr.SetDungeonBuff(enterDungeonParams, allBuff)
    return enterDungeonParams
end


function ActivityBattlePrepareInfo_SeasonSLGBoss:SetEmemys()
    self.enemyListUI:Clear()
    self:SetMonsterIdList()
    local listDatas = {}
    for _, v in ipairs(self.monsterList) do
        local monster = v
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


function ActivityBattlePrepareInfo_SeasonSLGBoss:SetMonsterIdList()
    self.monsterList = ConfigHelper.GetEnemyList(self.dungeonConfig.id)
end



function ActivityBattlePrepareInfo_SeasonSLGBoss:Clear()
    self.bossBuffToggle.isOn = true
    self.playerBuffToggle.isOn = false
    self.buffScrollListUI:Clear()
    self.enemyListUI:Clear()
    LuaMgr.RemoveClick(self.startBattleBtn, self.OnClickStartBattleBtn)

    LuaMgr.RemoveClick(self.enemysBtn, self.OnClickEnemysBtn)
end

function ActivityBattlePrepareInfo_SeasonSLGBoss:Destroy()
    self.buffScrollListUI:Clear()
    self.enemyListUI:Clear()
    UIScrollView.ClearItem("SeasonSLGBossBattlePrepareBuffItem")
    UIScrollView.ClearItem("ActivityBattlePrepareEnemyItem")
    LuaMgr.Destroy(self.gameObject)
    self.gameObject = nil
end