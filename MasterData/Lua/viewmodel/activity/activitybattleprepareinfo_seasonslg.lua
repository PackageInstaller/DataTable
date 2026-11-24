require("ViewModel/Activity/ActivityBattlePrepareEnemyItem")
require("ViewModel/Activity/ActivityBattlePrepareTeamTowerEquippedBuffItem")
require("ViewModel/Activity/ActivityBattlePrepareInfoConditionItem")
require("SeasonSLG/SeasonSLGMapMgr")
require("SeasonSLG/SeasonSLGCombatPowerMgr")
ActivityBattlePrepareInfo_SeasonSLG = {}

ActivityBattlePrepareInfo_SeasonSLG.__index = ActivityBattlePrepareInfo_SeasonSLG

local colorWin = UnityEngine.Color(239 / 255, 229 / 255, 204 / 255, 1)
local colorLose = UnityEngine.Color(141 / 255, 141 / 255, 141 / 255, 1)

local monsterList = nil
local goodItems = {}
local winLoseStatus = true;
local battleTurnEnd = 0;
local enemyListView = nil;
local conditionListView = nil;
local easyModel = false

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
    rewardListParent = {path = "RightInfo/Reward/List",type = "Transform"},
    battleCostIcon = {path = "RightInfo/StartBattle/Num/Text/Icon",type = "RawImage"},
    battleCostCount = {path = "RightInfo/StartBattle/Num/Text",type = "Text"},
    battleCostCountObj = {path = "RightInfo/StartBattle/Num",type = "GameObject"},
    startBattleBtn = {path = "RightInfo/StartBattle",type = "Button"},
    easyModelBtn = {path = "MiddleInfo/modelInfo/SwitchModelToggle", type = "Button"},
    easyModelImg = {path = "MiddleInfo/modelInfo/SwitchModelToggle/Image_easy", type = "GameObject"},
    diffModelImg = {path = "MiddleInfo/modelInfo/SwitchModelToggle/Image_diff", type = "GameObject"},
    easyModelHelpBtn = {path = "MiddleInfo/modelInfo/help", type = "Button"},
    txtPower = {path = "RightInfo/power/txtPower", type = "Text"},
    goTeamPower = {path = "RightInfo/teamPower", type = "GameObject"},
    txtTeamPower = {path = "RightInfo/teamPower/txtPower", type = "Text"},
}

function ActivityBattlePrepareInfo_SeasonSLG.New()
    local obj = {}
    setmetatable(obj, ActivityBattlePrepareInfo_SeasonSLG)
    return obj
end

function ActivityBattlePrepareInfo_SeasonSLG:Init()
    UITool.Parse(self.gameObject, self, objs)
    monsterList = nil
    winLoseStatus = true;
    battleTurnEnd = 0;
    enemyListView = UIListView.New(self.enemyListParent);
    conditionListView = UIListView.New(self.conditionScrollRect);
    easyModel = SettingHelper.GetPrefasBool(ESetting.SeasonEasyMode)
    SetActive(self.diffModelImg,not easyModel)
    SetActive(self.easyModelImg,easyModel)
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
    self.OnModelValueChange = function()
        easyModel = not easyModel;
        SettingHelper.SetPrefsBool(ESetting.SeasonEasyMode, easyModel)
        SetActive(self.diffModelImg, not easyModel)
        SetActive(self.easyModelImg, easyModel)
    end
    self.OnClickHelp = function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ActivityBattlePrepareInfo_SeasonSLG_0"));
    end
    self.StartBattle = function()
        if not self:CheckCostEnough() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ActivityBattlePrepareInfo_SeasonSLG_1"))
            return
        end
        local members = ActivityBattlePrepareMgr.GetSelectMembers();
        if tonumber(self.eventDungeonConfig.DifficultyLevel) <= SeasonSLGMapMgr.Constants().SeasonalBattlePower then
            if SeasonSLGMapMgr.CheckBlockEventsCanFastBattle(self.GridId,self.eventDungeonConfig.Id,self.eventDungeonConfig.DungeonBattle,self.activityInfo.eventType == "11") then
                self:EnterBattleQuickBattle(members)
                return;
            end
        end
        self:EnterBattle(members)
    end
    self.UpdateData = function()
        self:SetConsume()
    end
    LuaMgr.AddClick(self.enemyBtn, self.OnClickEnemys);
    LuaMgr.AddClick(self.startBtn, self.StartBattle);
    LuaMgr.AddClick(self.winConditionBtn, self.OnClickWinCondition);
    LuaMgr.AddClick(self.loseConditionBtn, self.OnClickLoseCondition);
    LuaMgr.AddClick(self.easyModelBtn, self.OnModelValueChange);
    LuaMgr.AddClick(self.easyModelHelpBtn, self.OnClickHelp);
    LuaMgr.RemoveDataEventListener(self.UpdateData);
    LuaMgr.AddDataEventListener(self.UpdateData);
end

function ActivityBattlePrepareInfo_SeasonSLG:EnterBattle(members)
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

function ActivityBattlePrepareInfo_SeasonSLG:EnterBattleQuickBattle(members)
    local len = #members;
    if (len <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("MiniBattlePrepareViewModel_1"));
        return;
    end

    local characters = {};
    local characterPower = 0;
    for i = 1, len do
        local id = members[i];
        if not IsNullOrEmpty(id) then
            local power = SeasonSLGCombatPowerMgr.GetCharacterPower(id);
            characters[id] = power;
            characterPower = characterPower + power;
        end
    end

    local teamPower = characterPower
        + SeasonSLGCombatPowerMgr.GetTechPower()
        + SeasonSLGCombatPowerMgr.GetCoResearchPower()
        + SeasonSLGCombatPowerMgr.GetFieldPower();

    local dungeonPower = tonumber(self.eventDungeonConfig.DifficultyLevel) or 0;

    local battleRate = dungeonPower > 0 and math.floor(teamPower / dungeonPower * 100) or 0;
    local data = {
        GridId = tostring(self.GridId),
        BattleRate = battleRate,
        Characters = characters,
    };
    if tostring(self.activityInfo.eventType) == "11" then
        data.WorldAttackId = self.eventDungeonConfig.Id
    else
        data.EventDungeonId = self.eventDungeonConfig.Id
    end
    ApiMgr.Request("seasonal/quick/battle", data, true, function(result)

        local battleResult = self:GetBattleResult(battleRate);
        local resultData = {
            dungeonId = self.dungeonConfig.id,
            result = battleResult,
            leftPower = teamPower,
            rightPower = dungeonPower,
            DungeonIcon = self.eventDungeonConfig.DungeonIcon or self.eventDungeonConfig.SeasonalMonsterModel,
            reward = result
        };
        LuaMgr.Back();
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGQuickBattleResultPopup, resultData);
    end, nil, true);
end


function ActivityBattlePrepareInfo_SeasonSLG:GetBattleResult(battleRate)
    local rank = SeasonSLGMapMgr.Constants().SeasonalBattleRank;
    if rank ~= nil then
        for i = 1, #rank do
            local low = rank[i][1] or 0;
            local high = rank[i][2] or 0;
            if battleRate > low and battleRate <= high then
                return i - 1;
            end
        end
    end
    if battleRate > 100 then
        return 3;
    end
    return 0;
end


function ActivityBattlePrepareInfo_SeasonSLG:RefreshTeamPower()
    local members = ActivityBattlePrepareMgr.GetSelectMembers();
    local teamPower = 0;
    for i = 1, #members do
        local id = members[i];
        if not IsNullOrEmpty(id) then
            teamPower = teamPower + SeasonSLGCombatPowerMgr.GetCharacterPower(id);
        end
    end
    teamPower = teamPower
        + SeasonSLGCombatPowerMgr.GetTechPower()
        + SeasonSLGCombatPowerMgr.GetCoResearchPower()
        + SeasonSLGCombatPowerMgr.GetFieldPower();
    self.txtTeamPower.text = tostring(teamPower);
end

function ActivityBattlePrepareInfo_SeasonSLG:GetEnterDungeonParam(dungeonId, memberDic, helpDic)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = dungeonId;
    enterDungeonParams.dungeonId = dungeonId;
    enterDungeonParams.members = memberDic;
    enterDungeonParams.helps = helpDic;
    if tostring(self.activityInfo.eventType) == "1" then
        enterDungeonParams.extraParams = {"seasonal",tostring(self.GridId),tostring(self.activityInfo.eventType),self.activityInfo.storyId,self.activityInfo.select,"",self.activityInfo.timeEventType,dungeonId};
    elseif tostring(self.activityInfo.eventType) == "11" then
        local pram0 = self.activityInfo.extramData.BattleKey or ""
        local pram1 = tostring(self.activityInfo.extramData.GridIndex) or ""
        local pram2 = tostring(self.activityInfo.extramData.EventType) or ""
        local pram3 = self.activityInfo.extramData.SeasonalTimedEvent or ""
        local pram4 = self.activityInfo.extramData.DungeonID or ""
        local pram5 = self.activityInfo.extramData.SeasonalGridWorldAttackID or ""
        local pram6 = self.activityInfo.extramData.BattleTag or ""
        enterDungeonParams.extraParams = {pram0,pram1,pram2,pram3,pram4,pram5,pram6,""};
    else
        enterDungeonParams.extraParams = {"seasonal",tostring(self.GridId),tostring(self.activityInfo.eventType),"","",self.activityInfo.eventId,self.activityInfo.timeEventType,dungeonId};
    end
    local eventDungeonConfig = self.eventDungeonConfig;

    local allBuff = {}
    if easyModel then
        table.insert(enterDungeonParams.extraParams,"easy")
        if not IsNull(eventDungeonConfig.EasyDungeonBuffId) then
            local progressDungeonBuffIDs = ConfigHelper.GetDungeonBuffIDs(eventDungeonConfig.EasyDungeonBuffId)
            for i, v in pairs(progressDungeonBuffIDs) do
                table.insert(allBuff,v)
            end
        end
    else
        table.insert(enterDungeonParams.extraParams,"ordinary")





    end

    for _, buffData in ipairs(SeasonSLGMapMgr.GetActiveSeasonalBuff() or {}) do
        if not IsNullOrEmpty(buffData.BuffId) then
            table.insert(allBuff,buffData.BuffId)
        end
    end

    SeasonSLGMapMgr.GetAllMisinterBuff(allBuff)

    BattlePrepareMgr.SetDungeonBuff(enterDungeonParams,allBuff)

    return enterDungeonParams
end

function ActivityBattlePrepareInfo_SeasonSLG:SetData(dungeonConfig,activityInfo)
    easyModel = SettingHelper.GetPrefasBool(ESetting.SeasonEasyMode)
    self.activityInfo = activityInfo;
    self.GridId = activityInfo.GridId
    self.eventDungeonConfig = ConfigMgr.Config.SeasonalEventDungeonMap[activityInfo.eventId];
    if tostring(activityInfo.eventType) == "8" then
        self.eventDungeonConfig = ConfigMgr.Config.SeasonalGridWorldDungeonMap[activityInfo.eventId];
    elseif tostring(activityInfo.eventType) == "11" then
        self.eventDungeonConfig = ConfigMgr.Config.SeasonalGridWorldAttackMap[activityInfo.eventId];
    end
    self.dungeonConfig = dungeonConfig
    self.recommendLevel.text = dungeonConfig.levelShow
    self:SetConditions(LuaMgr.GetLangText(self.dungeonConfig.victoryTitleLan))
    self:SetEmemys()
    self:SetReward()
    self:SetConsume()
    self.txtPower.text = tostring(self.eventDungeonConfig.DifficultyLevel)

    HeroParameter.isSeasonalQuickBattle = SeasonSLGMapMgr.CheckBlockEventsCanFastBattle(self.GridId,self.eventDungeonConfig.Id,self.eventDungeonConfig.DungeonBattle,self.activityInfo.eventType == "11")
    SetActive(self.goTeamPower,HeroParameter.isSeasonalQuickBattle)
    self:RefreshTeamPower()
end

function ActivityBattlePrepareInfo_SeasonSLG:SetEmemys()
    enemyListView:Clear();
    self:SetMonsterIdList();
    local listData;
    local listDatas = {};
    for _, v in ipairs(monsterList) do
        local monster = v
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

function ActivityBattlePrepareInfo_SeasonSLG:SetReward()
    local len = 0
    local dungeonRecord = DataMgr.Player.dungeonRecords[self.eventDungeonConfig.Dungeon]
    local completed = dungeonRecord ~= nil and not IsNullOrEmpty(dungeonRecord.historyRating)
    local items = NumTool.split(self.dungeonConfig.fixedDropShow, ';');
    if not IsNull(items) then
        len = #items
    end
    for i = 1, len do
        if i <= 3 then
            if i>#goodItems then
                table.insert(goodItems,LuaMgr.InstantiateGO(self.rewardItem, self.rewardListParent, false):GetComponent("GoodsViewModel"))
            end
            SetActive(goodItems[i].gameObject,true);
            goodItems[i]:SetData(tostring(items[i]),0,0,1,true)
        end
    end

    for i = (len+1), #goodItems do
        SetActive(goodItems[i].gameObject,false)
    end
end

function ActivityBattlePrepareInfo_SeasonSLG:SetMonsterIdList()
    monsterList = ConfigHelper.GetEnemyList(self.dungeonConfig.id)
    if (monsterList == nil) then
        local str = LuaMgr.UpdateMonsterIdList(self.dungeonConfig.flowScript);
        monsterList = json.decode(str);
    end
end

function ActivityBattlePrepareInfo_SeasonSLG:SetWinLose(status)
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

function ActivityBattlePrepareInfo_SeasonSLG:SetConditions(str)
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

function ActivityBattlePrepareInfo_SeasonSLG:CheckCostEnough()
    local num = 0
    num = tonumber(self.dungeonConfig.levelNum)
    if num > 0 then
        local count = 0
        local dungeon = DataMgr.Player.dungeonRecords[self.dungeonConfig.id]
        if dungeon ~= nil then
            count = dungeon.completeCount
        end

        num = num - count
        if num <= 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("BattlePrepareViewModel_6"))
            return false
        end
    end
    if not IsNull(self.dungeonConfig.consumeItem) and #self.dungeonConfig.consumeItem > 0 then

        local costIndex=1;
        local records = DataMgr.Player.dungeonRecords[self.dungeonConfig.id]
        if records~=nil then
            costIndex=costIndex+records.completeCount;
            if costIndex>#self.dungeonConfig.consumeItem then
                costIndex=#self.dungeonConfig.consumeItem;
            end
        end
        local item = SeasonSLGEventMgr.GetBlockCostItem(tostring(self.GridId))
        if self.activityInfo.eventType == "11" and self.eventDungeonConfig ~= nil then
            item = self.eventDungeonConfig.SeasonalMonsterCost[1]
        end
        if item ~= nil then
            local config = ConfigMgr.Config.itemMap[item.id]
            if config ~= nil then
                if item.count==0 then
                    return true
                else
                    if item.id == "101" then
                        num = DataMgr.Player.stamina
                    else
                        local itemData = DataMgr.Player.items[item.id]
                        if itemData ~= nil then
                            num = itemData.count0
                        end
                    end
                    return num >= item.count
                end
            end
        end
    end
    return false
end

function ActivityBattlePrepareInfo_SeasonSLG:SetConsume()
    local num = 0
    num = tonumber(self.dungeonConfig.levelNum)
    if num > 0 then
        local count = 0
        local dungeon = DataMgr.Player.dungeonRecords[self.dungeonConfig.id]
        if dungeon ~= nil then
            count = dungeon.completeCount
        end

        num = num - count
        if num <= 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("BattlePrepareViewModel_6"))
            return
        end
    end
    if not IsNull(self.dungeonConfig.consumeItem) and #self.dungeonConfig.consumeItem > 0 then

        local costIndex=1;
        local records = DataMgr.Player.dungeonRecords[self.dungeonConfig.id]
        if records~=nil then
            costIndex=costIndex+records.completeCount;
            if costIndex>#self.dungeonConfig.consumeItem then
                costIndex=#self.dungeonConfig.consumeItem;
            end
        end
        local item = SeasonSLGEventMgr.GetBlockCostItem(tostring(self.GridId))
        if self.activityInfo.eventType == "11" and self.eventDungeonConfig ~= nil then
            item = self.eventDungeonConfig.SeasonalMonsterCost[1]
        end
        if item ~= nil then
            local config = ConfigMgr.Config.itemMap[item.id]
            if config ~= nil then
                self.battleCostIcon.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png", config.id))
                if item.count==0 then
                    SetActive(self.battleCostCountObj,false)
                else
                    SetActive(self.battleCostCountObj,true)
                    if item.id == "101" then
                        num = DataMgr.Player.stamina
                    else
                        local itemData = DataMgr.Player.items[item.id]
                        if itemData ~= nil then
                            num = itemData.count0
                        end
                    end
                    self.battleCostCount.text = string.format("<color=%s>-%s</color>", num >= item.count and "#ffffff" or "#d30320", item.count)
                end
            end
        end
    end
end

function ActivityBattlePrepareInfo_SeasonSLG:Clear()
    monsterList = {}
    conditionListView:Clear()
    enemyListView:Clear();
    UIListView.ClearItem("ActivityBattlePrepareInfoConditionItem")
    UIListView.ClearItem("ActivityBattlePrepareEnemyItem")
    LuaMgr.RemoveClick(self.enemyBtn, self.OnClickEnemys);
    LuaMgr.RemoveClick(self.startBtn, self.StartBattle);
    LuaMgr.RemoveClick(self.winConditionBtn, self.OnClickWinCondition);
    LuaMgr.RemoveClick(self.loseConditionBtn, self.OnClickLoseCondition);
    LuaMgr.RemoveClick(self.easyModelBtn, self.OnModelValueChange);
    LuaMgr.RemoveClick(self.easyModelHelpBtn, self.OnClickHelp);
    LuaMgr.RemoveDataEventListener(self.UpdateData);
end

function ActivityBattlePrepareInfo_SeasonSLG:Destroy()
    self.monsterList = {}
    for i, v in pairs(goodItems) do
        LuaMgr.DestroyImmediateGO(v.gameObject)
    end
    goodItems = {}
    conditionListView:Clear()
    enemyListView:Clear();
    UIListView.ClearItem("ActivityBattlePrepareInfoConditionItem")
    UIListView.ClearItem("ActivityBattlePrepareEnemyItem")
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end