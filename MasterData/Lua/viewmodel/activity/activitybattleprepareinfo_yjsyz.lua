require("ViewModel/Activity/ActivityBattlePrepareEnemyItem")
require("ViewModel/Activity/ActivityBattlePrepareHeroItem")
require("ViewModel/Activity/ActivityBattlePrepareBossTowerEquippedBuffItem")
require("ViewModel/Activity/ActivityBattlePrepareInfoConditionItem")
ActivityBattlePrepareInfo_YJSYZ = {}

ActivityBattlePrepareInfo_YJSYZ.__index = ActivityBattlePrepareInfo_YJSYZ

local colorWin = UnityEngine.Color(239 / 255, 229 / 255, 204 / 255, 1)
local colorLose = UnityEngine.Color(141 / 255, 141 / 255, 141 / 255, 1)

local monsterList = nil
local goodItems = {}
local buffItems = {}
local winLoseStatus = true;
local battleTurnEnd = 0;
local enemyListView = nil;
local conditionListView = nil;
local heroListView = nil;
local objs =
{
    enemyItem = {path = "template/EnemyItem",type = "GameObject"},
    heroItem = {path = "template/HeroItem",type = "GameObject"},

    ConditionItem = {path = "template/ConditionItem",type = "GameObject"},

    maxScore = {path = "RightInfo/MaxScore/Text",type = "Text"},
    winConditionBtn = {path = "RightInfo/Condition/Win",type = "Button"},
    winConditionText = {path = "RightInfo/Condition/Win/Text",type = "Text"},
    loseConditionBtn = {path = "RightInfo/Condition/Lose",type = "Button"},
    loseConditionText = {path = "RightInfo/Condition/Lose/Text",type = "Text"},
    conditionScrollRect = {path = "RightInfo/Condition/ScrollView/Viewport/Content",type = "Transform"},
    enemyListParent = {path = "RightInfo/Enemy/List",type = "Transform"},
    enemyBtn = {path = "RightInfo/Enemy",type = "Button"},
    startBtn = {path = "RightInfo/StartBattle",type = "Button"},
    heroListParent = {path = "RightInfo/Heros/List",type = "Transform"},



    startBattleBtn = {path = "RightInfo/StartBattle",type = "Button"},
    buffsParent = {path = "MiddleInfo/BuffList",type = "Transform"},
    buffItem = {path = "template/BuffItem",type = "GameObject"},
    EquipBuffBtn = {path = "MiddleInfo/Buff/Image",type = "Button"},
    isLock = {path = "MiddleInfo/Lock",type = "GameObject"},
}
local this
function ActivityBattlePrepareInfo_YJSYZ.New()
    local obj = {}
    setmetatable(obj, ActivityBattlePrepareInfo_YJSYZ)
    this = obj
    return obj
end

function ActivityBattlePrepareInfo_YJSYZ:Init()
    UITool.Parse(self.gameObject, self, objs)
    monsterList = nil
    winLoseStatus = true;
    battleTurnEnd = 0;
    enemyListView = UIListView.New(self.enemyListParent);
    heroListView = UIListView.New(self.heroListParent);
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
        local bossTowerTeam = YJSYZHelper.GetBossTowerTeam()
        if bossTowerTeam.Lock then
            return
        end
        LuaMgr.ShowLuaPanel(UIName.YJSYZChooseBuffPanelViewModel);
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

end

function ActivityBattlePrepareInfo_YJSYZ:EnterBattle(members)
    if IsNullOrEmpty(YJSYZHelper.GetBossTowerBuffID()) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_31225"));
        return
    end

    local len = #members;
    if (len <= 3) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_31227"));
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

    local dungeonActorConfig = ConfigHelper.GetDungeonActorConfig(self.dungeonConfig.id)
    if IsNull(dungeonActorConfig)  then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("MiniBattlePrepareViewModel_1"));
        return ;
    end

    ApiMgr.Request("bossTower/saveMember", {Members=memberDic,Helps = helpDic,DungeonActorId=dungeonActorConfig.Id} , true, function(result)

        ApiMgr.Request("enter_dungeon", enterDungeonParams, true, function(result)
            local re = json.decode(result);
            local data = json.encode(re.result);
            LuaMgr.EnterBattle(data, -1);
        end, function(code)

        end, true);

    end, function(code)

    end, true);
end

function ActivityBattlePrepareInfo_YJSYZ:GetEnterDungeonParam(dungeonId, memberDic, helpDic)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = dungeonId;
    enterDungeonParams.dungeonId = dungeonId;
    enterDungeonParams.members = memberDic;
    enterDungeonParams.helps = helpDic;
    enterDungeonParams.extraParams = { YJSYZHelper.key, YJSYZHelper.GetCurChallengeTowerId(), YJSYZHelper.GetBossTowerId(), "NEED_SEND_MONSTERHPMAP", YJSYZHelper.GetBossTowerLockBuffID()};

    return enterDungeonParams
end

function ActivityBattlePrepareInfo_YJSYZ:SetData(dungeonConfig, activityData)
    self.dungeonConfig = dungeonConfig
    self.activityData = activityData

    local bossTowerData = YJSYZHelper.get_boss_tower_data()
    self.maxScore.text = bossTowerData.MaxScore or 0
    self:SetBuffs()
    self:SetConditions(LuaMgr.GetLangText(self.dungeonConfig.victoryTitleLan))
    self:SetEmemys()
    self:SetHeros()

end

function ActivityBattlePrepareInfo_YJSYZ:SetEmemys()
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

function ActivityBattlePrepareInfo_YJSYZ:SetHeros()


    heroListView:Clear();
    local heroList = {}
    if ConfigMgr.Config.BossTowerRecommendedMap[self.dungeonConfig.id] then
        heroList = ConfigMgr.Config.BossTowerRecommendedMap[self.dungeonConfig.id].RecommedndedRole
    end
    local listData;
    local listDatas = {};
    local characterMap = ConfigMgr.Config.characterTable;
    for _, v in ipairs(heroList) do
        local character = characterMap[v];
        if character ~= nil then
            listData = UIListData.GetData(self.heroItem, "ActivityBattlePrepareHeroItem", character);
            table.insert(listDatas, listData);
            if (#listDatas >= 3) then
                break ;
            end
        end
    end
    heroListView:SetData(listDatas);
end

function ActivityBattlePrepareInfo_YJSYZ:SetMonsterIdList()
    if (monsterList == nil) then
        local str = LuaMgr.UpdateMonsterIdList(self.dungeonConfig.flowScript);
        monsterList = json.decode(str);
    end
end

function ActivityBattlePrepareInfo_YJSYZ:SetWinLose(status)
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

function ActivityBattlePrepareInfo_YJSYZ:SetConditions(str)
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
































function ActivityBattlePrepareInfo_YJSYZ.SetBuffs()
    SetActive(this.isLock, false)

    local buff_id = YJSYZHelper.GetBossTowerBuffID()
    if IsNullOrEmpty(buff_id) then
        return
    end

    local bossTowerTeam = YJSYZHelper.GetBossTowerTeam()
    SetActive(this.isLock, bossTowerTeam.Lock)

    local len = 1;
    for i = 1, len do
        if i>#buffItems then
            table.insert(buffItems,ActivityBattlePrepareBossTowerEquippedBuffItem.New(this.buffItem, this.buffsParent, true))
        end
        SetActive(buffItems[i].gameObject,true);
        buffItems[i]:SetData(buff_id)
    end

    for i = (len+1), #buffItems do
        SetActive(buffItems[i].gameObject,false)
    end
end


function ActivityBattlePrepareInfo_YJSYZ:Clear()
    monsterList = {}
    conditionListView:Clear()
    enemyListView:Clear();
    heroListView:Clear();
    for i, v in pairs(buffItems) do
        v:Clear()
    end
    UIListView.ClearItem("ActivityBattlePrepareInfoConditionItem")
    UIListView.ClearItem("ActivityBattlePrepareEnemyItem")
    UIListView.ClearItem("ActivityBattlePrepareHeroItem")

end

function ActivityBattlePrepareInfo_YJSYZ:Destroy()
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
    heroListView:Clear();
    UIListView.ClearItem("ActivityBattlePrepareInfoConditionItem")
    UIListView.ClearItem("ActivityBattlePrepareEnemyItem")
    UIListView.ClearItem("ActivityBattlePrepareHeroItem")

    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end