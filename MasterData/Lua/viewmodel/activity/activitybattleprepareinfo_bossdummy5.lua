require("ViewModel/Activity/ActivityBattlePrepareEnemyItem")
require("ViewModel/Activity/ActivityBattlePrepareTeamTowerEquippedBuffItem")
require("ViewModel/Activity/ActivityBattlePrepareInfoConditionItem")
ActivityBattlePrepareInfo_BossDummy5 = {}

ActivityBattlePrepareInfo_BossDummy5.__index = ActivityBattlePrepareInfo_BossDummy5

local colorWin = UnityEngine.Color(239 / 255, 229 / 255, 204 / 255, 1)
local colorLose = UnityEngine.Color(141 / 255, 141 / 255, 141 / 255, 1)

local monsterList = nil
local winLoseStatus = true;
local battleTurnEnd = 0;
local enemyListView = nil;
local conditionListView = nil;

local objs =
{
    enemyItem = {path = "template/EnemyItem",type = "GameObject"},
    rewardItem = {path = "template/GoodsItem",type = "GameObject"},
    ConditionItem = {path = "template/ConditionItem",type = "GameObject"},
    recommendLevel = {path = "RightInfo/Level/Text",type = "Text"},
    winConditionBtn = {path = "RightInfo/Condition/Win",type = "Button"},
    winConditionText = {path = "RightInfo/Condition/Win/Text",type = "Text"},
    loseConditionBtn = {path = "RightInfo/Condition/Lose",type = "Button"},
    loseConditionText = {path = "RightInfo/Condition/Lose/Text",type = "Text"},
    conditionScrollRect = {path = "RightInfo/Condition/ScrollView/Viewport/Content",type = "Transform"},
    enemyListParent = {path = "RightInfo/Enemy/List",type = "Transform"},
    enemyBtn = {path = "RightInfo/Enemy",type = "Button"},
    startBtn = {path = "RightInfo/StartBattle",type = "Button"},
    text_rate = { path = "RightInfo/Line1/text_rate", type = "Text" },
    text_highest_score = { path = "RightInfo/TestScore/Score", type = "Text" },
    text_today_count = { path = "RightInfo/text_count", type = "Text" },
    btn_boss_start = { path = "RightInfo/StartBattle", type = "Button" },
    btn_boss_delegate = { path = "RightInfo/DelegateBattle", type = "Button" },
}

function ActivityBattlePrepareInfo_BossDummy5.New()
    local obj = {}
    setmetatable(obj, ActivityBattlePrepareInfo_BossDummy5)
    return obj
end

function ActivityBattlePrepareInfo_BossDummy5:Init()
    UITool.Parse(self.gameObject, self, objs)
    monsterList = nil
    winLoseStatus = true;
    battleTurnEnd = 0;
    enemyListView = UIListView.New(self.enemyListParent);
    conditionListView = UIListView.New(self.conditionScrollRect);
    self.winConditionText.color = colorWin
    self.loseConditionText.color = colorLose

    self.OnClickEnemys = function()
        LuaMgr.ShowLuaPanel(UIName.BattlePrepareEnemyViewModel, self.dungeonConfig, monsterList);
    end
    self.OnClickWinCondition = function()
        self:SetWinLose(true)
    end
    self.OnClickLoseCondition = function()
        self:SetWinLose(false)
    end
    LuaMgr.AddClick(self.enemyBtn, self.OnClickEnemys);
    LuaMgr.AddClick(self.winConditionBtn, self.OnClickWinCondition);
    LuaMgr.AddClick(self.loseConditionBtn, self.OnClickLoseCondition);
end

function ActivityBattlePrepareInfo_BossDummy5:EnterBattle(members)
    local len = #members;
    if (len <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("MiniBattlePrepareViewModel_1"));
        return ;
    end
    local memberDic = {};
    local helpDic = {};
    for i = 1, len do
        local id = members[i];
        local index = tostring(i - 1);
        memberDic[index] = id;
        if (PlayerAssistMgr.IsAssistMember(id)) then
            helpDic[index] = PlayerAssistMgr.GetAssistMemberUid(id);
        else
            helpDic[index] = "";
        end
    end
    local enterDungeonParams = self:GetEnterDungeonParam(self.dungeonConfig.id, memberDic, helpDic)
    BattlePrepareMgr._enterDungeonParams = enterDungeonParams
    LuaMgr.SceneSwitchMark({ UIName.ActivityBattlePrepareViewModel });
    PlayerAreaMgr.SetAreaDungeonId("-1");
    ApiMgr.Request("enter_dungeon", enterDungeonParams, true, function(result)
        local re = json.decode(result);
        local data = json.encode(re.result);
        LuaMgr.EnterBattle(data, -1);
    end, function(code)
    end, true);

end

function ActivityBattlePrepareInfo_BossDummy5:GetEnterDungeonParam(dungeonId, memberDic, helpDic)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = dungeonId;
    enterDungeonParams.dungeonId = dungeonId;
    enterDungeonParams.members = memberDic;
    enterDungeonParams.helps = helpDic;
    enterDungeonParams.extraParams = {};
    
    table.insert(enterDungeonParams.extraParams, "boss_dummy3")
    table.insert(enterDungeonParams.extraParams, self.activityData.config.Id)
    
    local talentIds = {};
    if not TableIsNull(self.activityData.config.RecommendTalentBank) then
        for i, v in pairs(memberDic) do
            for _, hId in pairs(self.activityData.config.ReCommend) do
                if(v == hId) then
                    for tIndex, id in ipairs(self.activityData.config.RecommendTalentBank[_]) do
                        if talentIds[hId] == nil then
                            talentIds[hId] = {}
                        end
                        table.insert(talentIds[hId],id)
                    end
                end
            end
        end
        for i, v in pairs(helpDic) do
            for _, hId in pairs(self.activityData.config.ReCommend) do
                if(v == hId) then
                    for tIndex, id in ipairs(self.activityData.config.RecommendTalentBank[_]) do
                        if talentIds[hId] == nil then
                            talentIds[hId] = {}
                        end
                        table.insert(talentIds[hId],id)
                    end
                end
            end
        end
    end

    local buff_str = json.encode(talentIds)
    table.insert(enterDungeonParams.extraParams, self.activityData.config.BossDummy3Id)
    table.insert(enterDungeonParams.extraParams, tostring(BossDummy5Mgr.GetBossDummy5HighestScore(self.activityData.config.BossDummy3Id)))
    table.insert(enterDungeonParams.extraParams, buff_str)
    table.insert(enterDungeonParams.extraParams, self.activityData.config.DungeonId)
    return enterDungeonParams
end

function ActivityBattlePrepareInfo_BossDummy5:SetData(dungeonConfig, activityData)
    self.dungeonConfig = dungeonConfig
    self.activityData = activityData
    self.recommendLevel.text = dungeonConfig.levelShow
    self:SetConditions(LuaMgr.GetLangText(self.dungeonConfig.victoryTitleLan))
    self:SetEmemys()
    self:set_boss_btn_start_battle()
    self:set_boss_btn_delegate_battle()
    self.text_highest_score.text = tostring(BossDummy5Mgr.GetBossDummy5HighestScore(self.activityData.config.BossDummy3Id))
    self.text_rate.text = LuaMgr.GetLangText(self.activityData.config.OptionDescLan)
    self.text_today_count.text = string.format(LuaMgr.GetLangText("BossDummy4ViewModel_7"),
            BossDummy5Mgr.GetMainDungeonDailyEffectCount(self.activityData.config.BossDummy3Id), ConfigMgr.Config.constants.BossDummy3BossLimit)
end

function ActivityBattlePrepareInfo_BossDummy5:set_boss_btn_delegate_battle()
    local instance = self
    local function onBossDelegateClick()
        local todayEffectScoreCount = BossDummy5Mgr.GetMainDungeonDailyEffectCount(self.activityData.config.BossDummy3Id)
        local isRatePassed = BossDummy5Mgr.GetLevelScoreRatePassStatus(instance.activityData.config.Id)


        if not isRatePassed then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBattlePrepareInfo_BossDummy3_1"))
            return
        end

        if BossDummy5Mgr.GetBossDummy5HighestScore(self.activityData.config.BossDummy3Id) <= 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_25708"))
            return
        end

        if todayEffectScoreCount <= 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBattlePrepareInfo_BossDummy3_2"))
            return
        end

        instance:openDelegateBattlePopup()
    end

    local isUnLocked = BossDummy5Mgr.GetMainDungeonDailyEffectCount(self.activityData.config.BossDummy3Id) > 0
            and BossDummy5Mgr.GetLevelScoreRatePassStatus(instance.activityData.config.Id)
            and BossDummy5Mgr.GetBossDummy5HighestScore(self.activityData.config.BossDummy3Id) > 0
    self.btn_boss_delegate.gameObject.transform:Find("LockBg").gameObject:SetActive(not isUnLocked)

    LuaMgr.RemoveClick(self.btn_boss_delegate, onBossDelegateClick)
    LuaMgr.AddClick(self.btn_boss_delegate, onBossDelegateClick)
end

function ActivityBattlePrepareInfo_BossDummy5:openDelegateBattlePopup()
    LuaMgr.ShowLuaPanel(
            UIName.ActivityBossDummy5DelegateBattlePopupViewModel,
            self.dungeonConfig,
            self.activityData,
            function()
                self:set_stage_boss()
            end
    )
end

function ActivityBattlePrepareInfo_BossDummy5:set_stage_boss()
    self.text_highest_score.text    = tostring(BossDummy5Mgr.GetDungeonMaxScore(self.activityData.plotCfg.Id))
    self.text_today_count.text      = LuaMgr.GetLangText("ActivityBattlePrepareInfo_BossDummy3_0") .. string.format("<color=#B47240>%s</color>/%s",
            tostring(BossDummy5Mgr.GetMainDungeonDailyEffectCount(self.activityData.plotCfg.Id)),  ConfigMgr.Config.constants.BossDummy3BossLimit)
    self.text_rate.text             = LuaMgr.GetLangText(self.activityData.config.OptionDescLan)
    self:set_boss_btn_start_battle()
    self:set_boss_btn_delegate_battle()
end

function ActivityBattlePrepareInfo_BossDummy5:set_boss_btn_start_battle()
    local instance = self

    local function b()
        local selectMembers = ActivityBattlePrepareMgr.GetSelectMembers();
        instance:EnterBattle(selectMembers);
    end

    local function a()
        local activity_group_config = ConfigMgr.Config.activityGroup[tostring(BossDummy5Mgr.activityGroupId)]
        if activity_group_config.endTimeUnix < LuaMgr.Timestamp() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBossDummyViewModel_5"))
            return
        end
        if BossDummy5Mgr.GetMainDungeonDailyEffectCount(self.activityData.config.BossDummy3Id) <= 0 then
            LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3NoScorePopupViewModel, b)
        else
            local selectMembers = ActivityBattlePrepareMgr.GetSelectMembers();
            instance:EnterBattle(selectMembers);
        end
    end

    LuaMgr.RemoveClick(self.btn_boss_start, a)
    LuaMgr.AddClick(self.btn_boss_start, a)
end

function ActivityBattlePrepareInfo_BossDummy5:SetEmemys()
    enemyListView:Clear();
    self:SetMonsterIdList();
    local listData;
    local listDatas = {};
    local monsterMap = ConfigMgr.Config.monsterMap;
    for _, v in ipairs(monsterList) do
        local monster = monsterMap[v];
        if (monster ~= nil and not monster.hideShowinfo) then
            listData = UIListData.GetData(self.enemyItem, "ActivityBattlePrepareEnemyItem", monster);
            table.insert(listDatas, listData);
            if (#listDatas >= 3) then
                break ;
            end
        end
    end
    enemyListView:SetData(listDatas);
end

function ActivityBattlePrepareInfo_BossDummy5:SetMonsterIdList()
    if (monsterList == nil) then
        local str = LuaMgr.UpdateMonsterIdList(self.dungeonConfig.flowScript);
        monsterList = json.decode(str);
    end
end

function ActivityBattlePrepareInfo_BossDummy5:SetWinLose(status)
    if winLoseStatus == status then
        return
    end
    winLoseStatus = status
    if winLoseStatus then
        self.winConditionText.color = colorWin
        self.loseConditionText.color = colorLose
    else
        self.loseConditionText.color = colorWin
        self.winConditionText.color = colorLose
    end

    self:SetConditions(LuaMgr.GetLangText(self.dungeonConfig.victoryTitleLan))
end

function ActivityBattlePrepareInfo_BossDummy5:SetConditions(str)
    conditionListView:Clear()
    if not winLoseStatus and battleTurnEnd > 0 then
        str = str .. "1_" .. string.format(LuaMgr.GetLangText('LangGlobalLan_LangGlobal_name_5068'),battleTurnEnd)
    end
    local strs = NumTool.split(str, ';')
    local listData;
    local listDatas = {};
    for i, item in ipairs(strs) do
        if IsNullOrEmpty(item) then
            break
        end
        local temps = NumTool.split(item, '_')
        if temps[1] == (winLoseStatus and "0" or "1") then
            local conditionData = {
                content = temps[2],
                bgRes = LuaMgr.GetSprite("AreaMapRes", winLoseStatus and "ui_zqzb_tjdi01" or "ui_zqzb_tjdi02")
            }
            listData = UIListData.GetData(self.ConditionItem, "ActivityBattlePrepareInfoConditionItem", conditionData);
            table.insert(listDatas, listData)
        end
    end
    conditionListView:SetData(listDatas);
end


function ActivityBattlePrepareInfo_BossDummy5:Clear()
    monsterList = {}
    conditionListView:Clear()
    enemyListView:Clear();
    UIListView.ClearItem("ActivityBattlePrepareInfoConditionItem")
    UIListView.ClearItem("ActivityBattlePrepareEnemyItem")
end

function ActivityBattlePrepareInfo_BossDummy5:Destroy()
    self.buffItems = {}
    self.monsterList = {}
    conditionListView:Clear()
    enemyListView:Clear();
    UIListView.ClearItem("ActivityBattlePrepareInfoConditionItem")
    UIListView.ClearItem("ActivityBattlePrepareEnemyItem")
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end