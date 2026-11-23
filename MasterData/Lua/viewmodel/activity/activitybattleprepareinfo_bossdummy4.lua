require("ViewModel/BossDummy3/ActivityBossDummy3BuffItem")
require("ViewModel/Activity/ActivityBattlePrepareEnemyItem")
require("ViewModel/Activity/ActivityBattlePrepareBossDummy3RewardItem")

ActivityBattlePrepareInfo_BossDummy4 = {}

ActivityBattlePrepareInfo_BossDummy4.__index = ActivityBattlePrepareInfo_BossDummy4

local objs = 
{
    level = { path = "RightInfo/Level/Text", type = "Text" },


    stage_normal_go             = { path = "RightInfo/stage_normal", type = "GameObject" },
    text_test_level             = { path = "RightInfo/stage_normal/TestLevel/Level", type = "Text" },
    buff_item_go                = { path = "template/buff_item", type = "GameObject" },
    normal_enemy_buff_list_go   = { path = "RightInfo/stage_normal/buff_info/stage_buff_info/enemy_buff_list/ui_scroll_buff/Viewport/Content", type = "GameObject" },
    reward_item_go              = { path = "template/reward_item", type = "GameObject" },
    reward_list_go              = { path = "RightInfo/stage_normal/Reward/List", type = "GameObject" },
    btn_normal_start            = { path = "RightInfo/stage_normal/Start", type = "Button" },


    stage_boss_go               = { path = "RightInfo/stage_boss", type = "GameObject" },
    text_highest_score          = { path = "RightInfo/stage_boss/TestScore/Score", type = "Text" },
    text_today_count            = { path = "RightInfo/stage_boss/text_count", type = "Text" },
    text_rate                   = { path = "RightInfo/stage_boss/Line/text_rate", type = "Text" },
    tab_enemy_buff_go           = { path = "RightInfo/stage_boss/tabs/tab_enemy_buff", type = "GameObject" },
    tab_buff_go                 = { path = "RightInfo/stage_boss/tabs/tab_buff", type = "GameObject" },
    boss_buffInfo_go            = { path = "RightInfo/stage_boss/tabs/tab_buff/status_1/buffInfo", type = "GameObject" },
    boss_buff_name              = { path = "RightInfo/stage_boss/tabs/tab_buff/status_1/buffInfo/Name", type = "Text" },
    boss_buff_icon              = { path = "RightInfo/stage_boss/tabs/tab_buff/status_1/buffInfo/Image (1)/buffIcon", type = "Image" },
    boss_buff_desc              = { path = "RightInfo/stage_boss/tabs/tab_buff/status_1/buffInfo/ui_scroll_buff/Viewport/Content", type = "Text" },
    boss_enemy_buff_list_go     = { path = "RightInfo/stage_boss/tabs/tab_enemy_buff/status_1/ui_scroll_buff/Viewport/Content", type = "GameObject" },
    no_choose_img_go            = { path = "RightInfo/stage_boss/tabs/no_choose_img", type = "GameObject" },
    btn_boss_start              = { path = "RightInfo/stage_boss/StartBattle", type = "Button" },
    btn_boss_delegate           = { path = "RightInfo/stage_boss/DelegateBattle", type = "Button" },

    text_level                  = { path = "RightInfo/Level/Text", type = "Text"},
    tips_go                     = { path = "MiddleInfo/Tips", type = "GameObject"},
    text_tips                   = { path = "MiddleInfo/Tips/Text", type = "Text"},
    enemyItem                   = { path = "RightInfo/Enemys/EnemyItem", type = "GameObject" },
    enemysBtn                   = { path = "RightInfo/Enemys", type = "Button" },
    enemysListTF                = { path = "RightInfo/Enemys/List", type = "Transform" },
}

function ActivityBattlePrepareInfo_BossDummy4.New()
    local obj = {}
    setmetatable(obj, ActivityBattlePrepareInfo_BossDummy4)
    return obj
end

function ActivityBattlePrepareInfo_BossDummy4:Init()
    UITool.Parse(self.gameObject, self, objs)

    self.monsterList = nil
    self.enemysListView = UIListView.New(self.enemysListTF)
    self.OnClickEnemys = function()
        LuaMgr.ShowLuaPanel(UIName.BattlePrepareEnemyViewModel, self.dungeonConfig, self.monsterList);
    end
    LuaMgr.AddClick(self.enemysBtn, self.OnClickEnemys)
    SetActive(self.enemyItem, false)
end

function ActivityBattlePrepareInfo_BossDummy4:SetData(dungeonConfig, activityData)
    self.dungeonConfig = dungeonConfig
    self.activityData = activityData

    if not self.activityData.is_boss then
        self.stage_normal_go:SetActive(true)
        self.stage_boss_go:SetActive(false)
        self:set_stage_normal()
    else
        self.stage_normal_go:SetActive(false)
        self.stage_boss_go:SetActive(true)
        self:set_stage_boss()
    end

    self.text_level.text = self.dungeonConfig.levelShow
    self:SetTips()
    self:SetEmemys()
    SetActive(self.gameObject, true)
end

function ActivityBattlePrepareInfo_BossDummy4:set_stage_normal()
    self.text_test_level.text   = LuaMgr.GetLangText(self.activityData.config.OptionDescLan)
    self.enemy_buff_list        = UIListView.New(self.normal_enemy_buff_list_go.transform)
    
    self.enemy_buff_list:Clear()
    self:set_stage_normal_buff_list(self.enemy_buff_list, self.activityData.config.BuffGroup,true)

    self:set_reward()
    self:set_normal_btn_start_battle()
end

function ActivityBattlePrepareInfo_BossDummy4:set_stage_normal_buff_list(listView, config, enemy)
    listView:Clear()

    local data_list = {}
    for i = 1, #config, 1 do
        local element = {}
        element.config  = BossDummy4Mgr.GetBuffDescConfig(config[i])
        element.enemy   = enemy

        if not enemy and DataMgr.Player.bossDummy3Rewards[self.activityData.config.Id] ~= nil then
            element.show_choose = true
        end

        local data = UIListData.GetData(self.buff_item_go, "ActivityBossDummy3BuffItem", element)
        table.insert(data_list, data)
    end
    listView:SetData(data_list, true)
end

function ActivityBattlePrepareInfo_BossDummy4:set_reward()
    self.reward_list = UIListView.New(self.reward_list_go.transform)

    local data_list = {}

    for i = 1, #self.activityData.config.Reward, 1 do
        if i > 3 then
            break
        end
        local element = {}
        element.id      = self.activityData.config.Reward[i].id
        element.count   = self.activityData.config.Reward[i].count
        if DataMgr.Player.bossDummy3Rewards[self.activityData.config.Id] ~= nil then
            element.receive = true
        else
            element.receive = false
        end

        local data = UIListData.GetData(self.reward_item_go, "ActivityBattlePrepareBossDummy3RewardItem", element)
        table.insert(data_list, data)
    end
    
    self.reward_list:SetData(data_list, true)
end

function ActivityBattlePrepareInfo_BossDummy4:set_normal_btn_start_battle()
    local instance = self

    local function a()
        local selectMembers = ActivityBattlePrepareMgr.GetSelectMembers();
        instance:EnterDungeon(instance.dungeonConfig.id, selectMembers);
    end

    LuaMgr.RemoveClick(self.btn_normal_start, a)
    LuaMgr.AddClick(self.btn_normal_start, a)
end

function ActivityBattlePrepareInfo_BossDummy4:set_stage_boss()
    self.text_highest_score.text    = tostring(BossDummy4Mgr.GetDungeonMaxScore(self.activityData.plotCfg.Id))
    self.text_today_count.text      = LuaMgr.GetLangText("ActivityBattlePrepareInfo_BossDummy3_0") .. string.format("<color=#B47240>%s</color>/%s",
            tostring(BossDummy4Mgr.GetMainDungeonDailyEffectCount(self.activityData.plotCfg.Id)),  ConfigMgr.Config.constants.BossDummy3BossLimit)
    self.text_rate.text             = tostring(math.floor(self.activityData.config.Credit / 100) + 100) .. "%"

    self.boss_enemy_buff_list       = UIListView.New(self.boss_enemy_buff_list_go.transform)
    self:set_tabs()
    self:set_boss_btn_start_battle()
    self:set_boss_btn_delegate_battle()
end

function ActivityBattlePrepareInfo_BossDummy4:set_tabs()
    self.tab_enemy_buff_go.transform:Find("status_1").gameObject:SetActive(false)
    self.tab_enemy_buff_go.transform:Find("status_2").gameObject:SetActive(true)
    self.tab_buff_go.transform:Find("status_1").gameObject:SetActive(false)
    self.tab_buff_go.transform:Find("status_2").gameObject:SetActive(true)

    local instance = self
    local function a()
        instance.no_choose_img_go:SetActive(false)
        instance.tab_enemy_buff_go.transform:Find("status_1").gameObject:SetActive(true)
        instance.tab_enemy_buff_go.transform:Find("status_2").gameObject:SetActive(false)
        instance.tab_buff_go.transform:Find("status_1").gameObject:SetActive(false)
        instance.tab_buff_go.transform:Find("status_2").gameObject:SetActive(true)
    end
    local function b()
        instance.no_choose_img_go:SetActive(instance.activityData.selected_buff == nil)
        instance.tab_enemy_buff_go.transform:Find("status_1").gameObject:SetActive(false)
        instance.tab_enemy_buff_go.transform:Find("status_2").gameObject:SetActive(true)
        instance.tab_buff_go.transform:Find("status_1").gameObject:SetActive(true)
        instance.tab_buff_go.transform:Find("status_2").gameObject:SetActive(false)
    end
    if self.activityData.selected_buff ~= nil then
        local selected_buff_cfg = BossDummy4Mgr.GetBuffDescConfig(self.activityData.selected_buff)
        self.boss_buff_name.text = LuaMgr.GetLangText(selected_buff_cfg.BuffName)
        self.boss_buff_icon.sprite = LuaMgr.GetSprite("BuffIcon", selected_buff_cfg.BuffIcon)
        self.boss_buff_desc.text = LuaMgr.GetLangText(selected_buff_cfg.BuffDes)
        SetActive(self.boss_buffInfo_go, true)
    else
        SetActive(self.boss_buffInfo_go, false)
    end
    self:set_stage_boss_buff_list(self.boss_enemy_buff_list, self.activityData.config.BuffGroup,true)

    LuaMgr.RemoveClick(self.tab_enemy_buff_go:GetComponent("Button"), a)
    LuaMgr.AddClick(self.tab_enemy_buff_go:GetComponent("Button"), a)
    LuaMgr.RemoveClick(self.tab_buff_go:GetComponent("Button"), b)
    LuaMgr.AddClick(self.tab_buff_go:GetComponent("Button"), b)

    a()
end

function ActivityBattlePrepareInfo_BossDummy4:set_boss_btn_start_battle()
    local instance = self

    local function b()
        local selectMembers = ActivityBattlePrepareMgr.GetSelectMembers();
        instance:EnterDungeon(instance.dungeonConfig.id, selectMembers);
    end

    local function a()
        if BossDummy4Mgr.GetMainDungeonDailyEffectCount(self.activityData.plotCfg.Id) <= 0 then
            LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3NoScorePopupViewModel, b)
        else
            local selectMembers = ActivityBattlePrepareMgr.GetSelectMembers();
            instance:EnterDungeon(instance.dungeonConfig.id, selectMembers);
        end
    end

    LuaMgr.RemoveClick(self.btn_boss_start, a)
    LuaMgr.AddClick(self.btn_boss_start, a)
end

function ActivityBattlePrepareInfo_BossDummy4:set_boss_btn_delegate_battle()
    local instance = self
    local function onBossDelegateClick()
        local todayEffectScoreCount = BossDummy4Mgr.GetMainDungeonDailyEffectCount(self.activityData.plotCfg.Id)
        local isRatePassed = BossDummy4Mgr.GetLevelScoreRatePassStatus(instance.activityData.config.Id)


        if not isRatePassed then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBattlePrepareInfo_BossDummy3_1"))
            return
        end
        
        if BossDummy4Mgr.GetDungeonMaxScore(self.activityData.plotCfg.Id) <= 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_25708"))
            return
        end
        
        if todayEffectScoreCount <= 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBattlePrepareInfo_BossDummy3_2"))
            return
        end
        
        instance:openDelegateBattlePopup()
    end

    local isLocked = BossDummy4Mgr.GetMainDungeonDailyEffectCount(self.activityData.plotCfg.Id) <= 0
            or not BossDummy4Mgr.GetLevelScoreRatePassStatus(instance.activityData.config.Id)
            or BossDummy4Mgr.GetDungeonMaxScore(self.activityData.plotCfg.Id) <= 0
    self.btn_boss_delegate.gameObject.transform:Find("LockBg").gameObject:SetActive(isLocked)
    
    LuaMgr.RemoveClick(self.btn_boss_delegate, onBossDelegateClick)
    LuaMgr.AddClick(self.btn_boss_delegate, onBossDelegateClick)
end

function ActivityBattlePrepareInfo_BossDummy4:openDelegateBattlePopup()
    LuaMgr.ShowLuaPanel(
            UIName.ActivityBossDummy4DelegateBattlePopupViewModel,
            self.dungeonConfig,
            self.activityData,
            function()
                self:set_stage_boss()
            end
    )
end

function ActivityBattlePrepareInfo_BossDummy4:set_stage_boss_buff_list(listView, config,enemy)
    listView:Clear()

    local data_list = {}
    for i = 1, #config, 1 do
        local element = {}
        element.config = BossDummy4Mgr.GetBuffDescConfig(config[i])
        element.enemy = enemy
        local data = UIListData.GetData(self.buff_item_go, "ActivityBossDummy3BuffItem", element)
        table.insert(data_list, data)
    end
    listView:SetData(data_list, true)
end


function ActivityBattlePrepareInfo_BossDummy4:SetEmemys()
    self.enemysListView:Clear();
    self:SetMonsterIdList();
    local listData;
    local listDatas = {};
    local monsterMap = ConfigMgr.Config.monsterMap;
    for _, v in ipairs(self.monsterList) do
        local monster = monsterMap[v];
        if (monster ~= nil and not monster.hideShowinfo) then
            listData = UIListData.GetData(self.enemyItem, "ActivityBattlePrepareEnemyItem", monster);
            table.insert(listDatas, listData);
            if (#listDatas >= 3) then
                break ;
            end
        end
    end
    self.enemysListView:SetData(listDatas);
end


function ActivityBattlePrepareInfo_BossDummy4:SetMonsterIdList()
    if (self.monsterList == nil) then
        local str = LuaMgr.UpdateMonsterIdList(self.dungeonConfig.flowScript);
        self.monsterList = json.decode(str);
    end
end

function ActivityBattlePrepareInfo_BossDummy4:SetTips()
    if not IsNullOrEmpty(self.activityData.config.LockDescLan) then
        self.tips_go:SetActive(true)
        self.text_tips.text = LuaMgr.GetLangText(self.activityData.config.LockDescLan)
    else
        self.tips_go:SetActive(false)
    end
end

function ActivityBattlePrepareInfo_BossDummy4:EnterDungeon(dungeonId, members)
    local len = #members;
    if (len <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("MiniBattlePrepareViewModel_1"));
        return
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
    local enterDungeonParams        = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId      = dungeonId
    enterDungeonParams.dungeonId    = dungeonId
    enterDungeonParams.members      = memberDic
    enterDungeonParams.helps        = helpDic

    enterDungeonParams.extraParams = { "boss_dummy3", self.activityData.config.Id }
    local buff_str = ""
    if self.activityData.selected_buff ~= nil then
        buff_str = self.activityData.selected_buff
    end
    table.insert(enterDungeonParams.extraParams, buff_str)

    BossDummy4Mgr.SaveHighestScore(self.activityData.config.BossDummy3Id)
    BossDummy4Mgr.SaveBestLevel(self.activityData.config.BossDummy3Id)

    BattlePrepareMgr._enterDungeonParams = enterDungeonParams
    LuaMgr.SceneSwitchMark({ UIName.ActivityBattlePrepareViewModel })
    PlayerAreaMgr.SetAreaDungeonId("-1")
    ApiMgr.Request("enter_dungeon", enterDungeonParams, true, function(result)
        local re    = json.decode(result)
        local data  = json.encode(re.result)
        LuaMgr.EnterBattle(data, -1)
    end, function(code)
    end, true);
end

function ActivityBattlePrepareInfo_BossDummy4:Clear()
    LuaMgr.RemoveClick(self.enemysBtn, self.OnClickEnemys)
    self.btn_normal_start.onClick:RemoveAllListeners()
    self.btn_boss_start.onClick:RemoveAllListeners()

    if self.buff_list ~= nil then
        self.buff_list:Clear()
    end
    if self.enemy_buff_list ~= nil then
        self.enemy_buff_list:Clear()
    end
    if self.enemysListView ~= nil then
        self.enemysListView:Clear()
    end
    if self.reward_list ~= nil then
        self.reward_list:Clear()
    end
    if self.boss_enemy_buff_list ~= nil then
        self.boss_enemy_buff_list:Clear()
    end

    UIListView.ClearItem("ActivityBossDummy3BuffItem")
    UIListView.ClearItem("ActivityBattlePrepareEnemyItem")
    UIListView.ClearItem("ActivityBattlePrepareBossDummy3RewardItem")

    self.enemyItem = nil
    self.enemysListTF = nil
    self.monsterList = nil    
end

function ActivityBattlePrepareInfo_BossDummy4:Destroy()
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end