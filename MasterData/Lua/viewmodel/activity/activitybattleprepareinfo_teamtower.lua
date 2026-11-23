require("ViewModel/Activity/ActivityBattlePrepareEnemyItem")
require("ViewModel/Activity/ActivityBattlePrepareTeamTowerEquippedBuffItem")
require("ViewModel/Activity/ActivityBattlePrepareInfoConditionItem")
ActivityBattlePrepareInfo_TeamTower = {}

ActivityBattlePrepareInfo_TeamTower.__index = ActivityBattlePrepareInfo_TeamTower

local colorWin = UnityEngine.Color(239 / 255, 229 / 255, 204 / 255, 1)
local colorLose = UnityEngine.Color(141 / 255, 141 / 255, 141 / 255, 1)

local monsterList = nil
local goodItems = {}
local buffItems = {}
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
    rewardListParent = {path = "RightInfo/Reward/List",type = "Transform"},
    battleCostIcon = {path = "RightInfo/StartBattle/Num/Text/Icon",type = "RawImage"},
    battleCostCount = {path = "RightInfo/StartBattle/Num/Text",type = "Text"},
    battleCostCountObj = {path = "RightInfo/StartBattle/Num",type = "GameObject"},
    startBattleBtn = {path = "RightInfo/StartBattle",type = "Button"},
    buffsParent = {path = "MiddleInfo/BuffList",type = "Transform"},
    buffItem = {path = "template/BuffItem",type = "GameObject"},
    EquipBuffBtn = {path = "MiddleInfo/Image",type = "Button"},
}

function ActivityBattlePrepareInfo_TeamTower.New()
    local obj = {}
    setmetatable(obj, ActivityBattlePrepareInfo_TeamTower)
    return obj
end

function ActivityBattlePrepareInfo_TeamTower:Init()
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
    self.OnClickEquipBuff = function()
        LuaMgr.ShowLuaPanel(UIName.TeamTowerEquipBuffPopUp);
    end
    self.StartBattle = function()
        local members = ActivityBattlePrepareMgr.GetSelectMembers();
        self:EnterBattle(members)
    end
    LuaMgr.AddClick(self.enemyBtn, self.OnClickEnemys);
    LuaMgr.AddClick(self.startBtn, self.StartBattle);
    LuaMgr.AddClick(self.winConditionBtn, self.OnClickWinCondition);
    LuaMgr.AddClick(self.loseConditionBtn, self.OnClickLoseCondition);
    LuaMgr.AddClick(self.EquipBuffBtn, self.OnClickEquipBuff);
    LuaMgr.AddUIEventListener(UIEventConst.OnTeamTowerEquipBuff,self.SetBuffs)
end

function ActivityBattlePrepareInfo_TeamTower:EnterBattle(members)
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

function ActivityBattlePrepareInfo_TeamTower:GetEnterDungeonParam(dungeonId, memberDic, helpDic)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = dungeonId;
    enterDungeonParams.dungeonId = dungeonId;
    enterDungeonParams.members = memberDic;
    enterDungeonParams.helps = helpDic;
    enterDungeonParams.extraParams = { "team_tower",TeamTowerMgr.GetCurChallengeTowerId(),TeamTowerMgr.GetTeamTowerId()};
    local levelCfg = ConfigMgr.Config.TeamTowerFloorMap[TeamTowerMgr.GetCurChallengeTowerId()]
    for i, v in ipairs(levelCfg.Buff) do
        table.insert(enterDungeonParams.extraParams, v)
    end
    for i, v in ipairs(TeamTowerMgr.equippedBuffList) do
        if not IsNullOrEmpty(v) then
            local config = ConfigMgr.Config.TeamTowerBuffPoolMap[v]
            table.insert(enterDungeonParams.extraParams, config.Key)
        end
    end
    if levelCfg.GroupID == "3" then
        local loopFloorConfig = ConfigMgr.Config.TeamTowerBuffLoopFloorMap[tostring(TeamTowerMgr.GetTeamTowerData().TowerCount - 30 + 1)]
        if loopFloorConfig ~= nil then
            for i = 1, #loopFloorConfig.Buff do
                table.insert(enterDungeonParams.extraParams,loopFloorConfig.Buff[i])
            end
        else
            local loopFloorConfig = ConfigMgr.Config.TeamTowerBuffLoopFloorMap[tostring(ConfigHelper.GetTableLength(ConfigMgr.Config.TeamTowerBuffLoopFloorMap))]
            if loopFloorConfig ~= nil then
                for i = 1, #loopFloorConfig.Buff do
                    table.insert(enterDungeonParams.extraParams,loopFloorConfig.Buff[i])
                end
            end
        end
    end
    return enterDungeonParams
end

function ActivityBattlePrepareInfo_TeamTower:SetData(dungeonConfig, activityData)
    self.dungeonConfig = dungeonConfig
    self.activityData = activityData
    self.recommendLevel.text = dungeonConfig.levelShow
    self:SetBuffs()
    self:SetConditions(LuaMgr.GetLangText(self.dungeonConfig.victoryTitleLan))
    self:SetEmemys()
    self:SetReward()
    self:SetConsume()
end

function ActivityBattlePrepareInfo_TeamTower:SetEmemys()
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

function ActivityBattlePrepareInfo_TeamTower:SetReward()
    local teamTowerConfig = ConfigMgr.Config.TeamTowerFloorMap[TeamTowerMgr.GetCurChallengeTowerId()]
    local len = 0
    if not IsNull(teamTowerConfig.Reward) then
        len = #teamTowerConfig.Reward
    end
    for i = 1, len do
        if i>#goodItems then
            table.insert(goodItems,LuaMgr.InstantiateGO(self.rewardItem, self.rewardListParent, false):GetComponent("GoodsViewModel"))
        end

        SetActive(goodItems[i].gameObject,true);
        goodItems[i]:SetData(tostring(teamTowerConfig.Reward[i].id),teamTowerConfig.Reward[i].count,1,1,true)
    end

    for i = (len+1), #goodItems do
        SetActive(goodItems[i].gameObject,false)
    end
end

function ActivityBattlePrepareInfo_TeamTower:SetMonsterIdList()
    if (monsterList == nil) then
        local str = LuaMgr.UpdateMonsterIdList(self.dungeonConfig.flowScript);
        monsterList = json.decode(str);
    end
end

function ActivityBattlePrepareInfo_TeamTower:SetWinLose(status)
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

function ActivityBattlePrepareInfo_TeamTower:SetConditions(str)
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

function ActivityBattlePrepareInfo_TeamTower:SetBuffs()
    local len = ConfigMgr.Config.TeamTowerConstants.BattleSelectBuff
    local equippedBuffIds = TeamTowerMgr.equippedBuffList;
    for i = 1, len do
        if i>#buffItems then
            table.insert(buffItems,ActivityBattlePrepareTeamTowerEquippedBuffItem.New(self.buffItem, self.buffsParent, true))
        end
        
        SetActive(buffItems[i].gameObject,true);
        if #equippedBuffIds >= i then
            buffItems[i]:SetData(equippedBuffIds[i])
        else
            buffItems[i]:SetData("")
        end
    end

    for i = (len+1), #buffItems do
        SetActive(buffItems[i].gameObject,false)
    end
end

function ActivityBattlePrepareInfo_TeamTower:SetConsume()
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
        local item = self.dungeonConfig.consumeItem[costIndex]
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
                    self.battleCostCount = string.format("<color=%s>-%s</color>", num >= item.count and "#ffffff" or "#d30320", item.count)
                end
            end
        end
    end
end

function ActivityBattlePrepareInfo_TeamTower:Clear()
    monsterList = {}
    conditionListView:Clear()
    enemyListView:Clear();
    for i, v in pairs(buffItems) do
        v:Clear()
    end
    UIListView.ClearItem("ActivityBattlePrepareInfoConditionItem")
    UIListView.ClearItem("ActivityBattlePrepareEnemyItem")
    LuaMgr.RemoveUIEventListener(UIEventConst.OnTeamTowerEquipBuff,self.SetBuffs)
end

function ActivityBattlePrepareInfo_TeamTower:Destroy()
    for i, v in pairs(buffItems) do
        v:Destroy()
    end
    self.buffItems = {}
    self.monsterList = {}
    for i, v in pairs(goodItems) do
        LuaMgr.DestroyImmediateGO(v.gameObject)
    end
    goodItems = {}
    buffItems = {}
    conditionListView:Clear()
    enemyListView:Clear();
    UIListView.ClearItem("ActivityBattlePrepareInfoConditionItem")
    UIListView.ClearItem("ActivityBattlePrepareEnemyItem")
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end