local this =
{
    vm                      = nil,
    cache                   = nil,
    gameObject              = nil,
    text_bonus              = nil,
    text_high_score_desc    = nil,
    text_high_score         = nil,
    text_time               = nil,
    img_progress            = nil,

    enable_group            = nil,
    reward_group            = nil,
    current_select_tab      = nil,
    spine_character_group   = nil,
    
    current_select_diff      = nil,
}

local data =
{
    tabs =
    {
        {
            id          = "111",
            name        = "133",
            score       = 0,
            is_status_1 = false,
            is_status_2 = false,
            red_id      = "",
            showLink    = true,
        },
        {
            id          = "111",
            name        = "233",
            score       = 0,
            is_status_1 = false,
            is_status_2 = false,
            red_id      = "",
            showLink    = true,
        }
    },

    difficult =
    {
        {
            id          = "111",
            name        = "133",
            select      = true,
            score       = 0,
            optionDesc  = "",
            lock        = false,
            delay       = 0,
            icon        = DefaultSprite,
            textColor   = UnityEngine.Color.white,
            outLineColor= UnityEngine.Color.white,
        },
        {
            id          = "111",
            name        = "233",
            select      = false,
            score       = 0,
            optionDesc  = "",
            lock        = false,
            delay       = 0,
            icon        = DefaultSprite,
            textColor   = UnityEngine.Color.white,
            outLineColor= UnityEngine.Color.white,
        }
    },

    buffs = 
    {
        {
            id = "", 
            icon = DefaultSprite, 
            name = ""



        }
    },

    heros =
    {
        {
            id          = "12312",
            icon        = DefaultTexture,
            rare        = DefaultSprite,
            job         = DefaultSprite,
            desc        = "",
            value       = "",
        }
    },
    
    optionDesc = "",
    challengeLeft = "",
    endtime = "",
}

local command =
{
    on_click_tab_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_tab_btn(vm, param)
            this.set_default_diff()
        end
    },

    on_click_diff_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_diff_btn(vm, param,false)
        end
    },

    on_click_challenge_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_challenge_btn(vm, param)
        end
    },

    on_click_all_score_reward_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_all_score_reward_btn(vm, param)
        end
    },

    on_click_hero_item_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_hero_item_btn(vm, param)
        end
    },

    on_click_reward_status_1_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_reward_status_1_btn(vm, param)
        end
    },

    on_click_reward_status_2_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_reward_status_2_btn(vm, param)
        end
    },

    on_click_reward_status_3_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_reward_status_3_btn(vm, param)
        end
    },
    
    on_click_buff =
    {        
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_buff(vm, param)
        end
    }
}

local hook =
{
    before_awake = function(vm)
        this.init(vm)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        print("before_active")
        if vm.behaviour.Params.Length > 0 then
            this.entry = vm.behaviour.Params[0]
        else
            this.entry = nil
        end

        if (RedMgr.Singleton:CheckRedCondition("17860")) then
            RedMgr.Singleton:FrushRedCondition("17860")
        end
        LuaMgr.AddUIEventListener(UIEventConst.BossDummy5RedRefresh, this.UpdateRed)
        this.UpdateRed()
        this.on_before_active()
    end,
    after_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        print("after_active")
        this.on_after_active()
        LuaMgr.RemoveUIEventListener(UIEventConst.BossDummy5RedRefresh, this.UpdateRed);
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        print("before_deactive")
        this.on_before_deactive()
    end,
    before_destroy = function(vm)
        this.on_before_destroy()
    end
}

local EventBossConfigMap = nil
local api_get_reward_url = "event_boss/get_rewards"

function this.init(vm)
    this.vm         = vm
    this.gameObject = this.vm.behaviour.gameObject

    local uiLink                = this.gameObject:GetComponent("UILink")

    this.text_high_score_desc   = uiLink:Get("textHighScoreDesc"):GetComponent("Text")
    this.text_high_score        = uiLink:Get("textHighScore"):GetComponent("Text")
    this.text_time              = uiLink:Get("textTime"):GetComponent("Text")


    this.spine_character_group = {}
    for i = 1, 4 do
        table.insert(this.spine_character_group, this.vm.behaviour.transform:Find("root/Middle/EnableGroup/Character" .. tostring(i)).gameObject)
    end

    this.enable_group           = this.vm.behaviour.transform:Find("root/Middle/EnableGroup").gameObject
    this.reward_group = {}





    if EventBossConfigMap == nil then
        EventBossConfigMap = {}
        for _, v in ipairs(ConfigMgr.Config.BossDummy3s) do
            if v.ActivityGroup == BossDummy5Mgr.activityGroupId then
                EventBossConfigMap[v.Id] = v
            end
        end
    end
end

function this.on_before_active()
    this.vm.behaviour:UpdateTopBar("", this.OnBack)
    this.enable_group:SetActive(false)

    this.init_cache()
    this.set_tab()

    LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay, this.on_heart_beat)
    LuaMgr.AddUIEventListener(UIEventConst.HeartBeat, this.on_heart_beat)

    RedMgr.Singleton:RegisterViewModel(UIName.BossDummy5ViewModel)

    RedMgr.Singleton:FrushRedCondition("15113")
    HeroRedDataHelper.SetBossDummyRed()
    RedMgr.Singleton:Refresh()
end

function this.on_after_active()
    if HeroParameter.BossDummy_Select_Tab ~= nil then
        this.current_select_tab = nil
        this.on_click_tab_btn(this.vm, HeroParameter.BossDummy_Select_Tab)

    elseif this.current_select_tab ~= nil then
        local a = this.current_select_tab
        this.current_select_tab = nil
        this.on_click_tab_btn(this.vm, a)

    else
        this.current_select_tab = nil
        this.on_click_tab_btn(this.vm, 0)

    end

    if HeroParameter.BossDummy_Select_Diff ~= nil then
        this.current_select_tab = nil
        this.on_click_diff_btn(this.vm, HeroParameter.BossDummy_Select_Diff,true)

    elseif this.current_select_diff ~= nil then
        local a = this.current_select_diff
        this.current_select_diff = nil
        this.on_click_diff_btn(this.vm, a,true)
    else
        this.set_default_diff()
    end
    
    local config = ConfigMgr.Config.activityGroup["4092"]
    this.vm.data.endtime = string.format(LuaMgr.GetLangText("BossDummy5ViewModel_0"),config.endTime)
    
    LuaMgr.NextFrame(function()

        this.tab_animators = {}
        local tabGroup = this.vm.behaviour.transform:Find("root/Middle/ui_scroll_tab/Viewport/Content")
        if tabGroup then
            for i = 0, tabGroup.childCount - 1 do
                local tabItem = tabGroup:GetChild(i)
                if tabItem then
                    local animator = tabItem:GetComponent("Animator")
                    if animator then
                        table.insert(this.tab_animators, animator)
                    end
                end
            end
        end
    end,10);
end

function this.on_before_deactive()
    for i = 1, 4 do
        this.spine_character_group[i].transform:Find("Body"):GetComponent("UISpineCharacter"):Clear()
    end

    LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay, this.on_heart_beat)
    LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.on_heart_beat)

    RedMgr.Singleton:RemoveViewModel(UIName.ActivityBossDummy5ViewModel)

    HeroParameter.BossDummy_Select_Tab = this.current_select_tab

    this.cache = nil
    this.current_select_tab = nil
    this.current_select_diff = nil
end

function this.on_before_destroy()
    this.spine_character_group = nil
end

this.UpdateRed = function()
    local missionRed = BossDummy5Mgr.CheckMissionRed()
    RedMgr.Singleton:UpdateClientRedData("17861", missionRed)
    RedMgr.Singleton:Refresh();
end

function this.init_cache()
    this.cache = nil
    this.cache = {}

    this.cache.tab_data = {}

    for _, v in ipairs(ConfigMgr.Config.BossDummy3s) do
        if v.ActivityGroup == BossDummy5Mgr.activityGroupId then
            local e = DataMgr.Player.bossDummy3Records[tostring(v.Id)]
            local data = {}

            data.id     = tostring(v.Id)
            data.name   = LuaMgr.GetLangText(v.NameLan)
            data.score  = e == nil and 0 or e.maxDamage

            table.insert(this.cache.tab_data, data)
        end
    end
end

function this.set_tab()
    local data_list = {}
    for _, tab in ipairs(this.cache.tab_data) do
        table.insert(data_list, {
            id          = tab.id,
            name        = tab.name,
            score       = tab.score,
            is_status_1 = false,
            is_status_2 = true,
            red_id      = "16301_" .. tab.id,
            showLink    = _ ~= ConfigHelper.GetTableLength(this.cache.tab_data)
        })
    end
    this.vm.data.tabs = data_list
end

function this.set_diffs(id)
    local data_list = {}
    local config = EventBossConfigMap[id];
    for _, v in ipairs(config.EnemyOption) do
        local levelConfig = BossDummy5Mgr.GetLevelConfig(v)
        if levelConfig ~= nil then
            local dungeonConfig = ConfigMgr.Config.dungeonMap[levelConfig.DungeonId];
            local textColor = UnityEngine.Color(179 / 255, 114 / 255, 66 / 255, 1)
            local outLineColor = UnityEngine.Color(241 / 255, 233 / 255, 187 / 255, 1)
            if _ == 5 then
                textColor = UnityEngine.Color(245 / 255, 242 / 255, 232 / 255, 1)
                outLineColor = UnityEngine.Color(115 / 255, 61 / 255, 47 / 255, 1)
            end
            table.insert(data_list, {
                id          = levelConfig.Id,
                name        = tostring(dungeonConfig.levelShow),
                select      = false,
                score       = 0,
                optionDesc  = LuaMgr.GetLangText(levelConfig.OptionDescLan),
                lock        = not BossDummy5Mgr.GetIsUnlock(levelConfig.Delay),
                delay       = levelConfig.Delay,
                icon        = LuaMgr.GetSprite("BossDummy5Icon", "ui_mf_zjm_db_0" .. tostring(_)),
                textColor   = textColor,
                outLineColor= outLineColor,
            })
        end
    end
    this.vm.data.difficult = data_list
end

function this.set_default_diff()
    this.current_select_diff = nil
    local data = this.cache.tab_data[this.current_select_tab + 1]
    local plotConfig = BossDummy5Mgr.GetPlotConfig(data.id)
    if DataMgr.Player.bossDummy3Records[data.id] ~= nil then
        local diff = DataMgr.Player.bossDummy3Records[data.id].enemyOption
        local index = 0;
        for i, v in ipairs(plotConfig.EnemyOption) do
            if v == diff then
                index = i
                break
            end
        end
        this.on_click_diff_btn(this.vm, index - 1,true)
    else
        this.on_click_diff_btn(this.vm, 0,true)
    end
end

function this.set_text_high_score(name, score)
    this.text_high_score_desc.text  = LuaMgr.GetLangText("ActivityBossDummyViewModel_0") .. tostring(name) .. LuaMgr.GetLangText("ActivityBossDummyViewModel_1") .. LuaMgr.GetLangText("ActivityBossDummyViewModel_2")
    this.text_high_score.text       = tostring(score)
end

function this.set_buffs(id)
    local buffConfig = BossDummy5Mgr.GetLevelConfig(id)
    local tempList = {}
    if buffConfig then
        for i, v in ipairs(buffConfig.BuffGroup) do
            local buffDescConfig = BossDummy5Mgr.GetBuffDescConfig(v)
            if buffDescConfig then
                table.insert(tempList,
                        {
                            id = v,
                            name = LuaMgr.GetLangText(buffDescConfig.BuffNameLan),
                            icon = LuaMgr.GetSprite("BuffIcon", buffDescConfig.BuffIcon),
                        })
            end
        end
    end
    this.vm.data.buffs = tempList;
end

function this.set_buff_data(id, list, type, data_list)

end

function this.set_heros(id)
    local buffConfig = BossDummy5Mgr.GetLevelConfig(id)
    if buffConfig then
        local data_list = {}

        for _, v in ipairs(buffConfig.ReCommend) do
            local data = {}

            data.id     = v
            data.icon   = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(data.id))
            data.rare   = LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..ConfigMgr.Config.characterTable[data.id].rare)
            data.job    = LuaMgr.GetSprite("JobIcon", "job_" .. ConfigMgr.Config.characterTable[data.id].job)
            data.desc   = string.gsub(ConfigMgr.LangGlobal(buffConfig.RecommendBuffIcon[_][2]),' ','\n')


            table.insert(data_list, data)
        end

        this.vm.data.heros = data_list
    end
end

function this.set_spine(id)
    for i = 1, 4 do
        this.spine_character_group[i].transform:Find("Body"):GetComponent("UISpineCharacter"):Clear()
    end

    local config = EventBossConfigMap[id]
    if config then
        for i = 1, 4 do
            if config.BossPreview ~= nil and i <= #config.BossPreview then
                this.spine_character_group[i]:SetActive(true)
                local path = HeroManager.GetCharacterDrawing(config.BossPreview[i], config.BossPreview[i] .. "01")
                if path ~= "" then
                    this.spine_character_group[i].transform:Find("Body"):GetComponent("DrawingAdjustTool").Sprite = path
                end
                local x = tonumber(config.Offset[3 * (i - 1) + 1])
                local y = tonumber(config.Offset[3 * (i - 1) + 2])
                local scale = tonumber(config.Offset[3 * (i - 1) + 3])
                this.spine_character_group[i].transform.localPosition = Vector3(x, y, 0.0)
                this.spine_character_group[i].transform.localScale = Vector3(scale, scale, scale)
            else
                this.spine_character_group[i]:SetActive(false)
            end
        end
    end
end

function this.set_reward_group(id)
    local config = EventBossConfigMap[id]

    if config then
        local reward_group_id = config.RewardGroup
        local reward_group_configs = {}
        for _, v in ipairs(ConfigMgr.Config.EventBossRewards) do
            if v.Group == reward_group_id then
                table.insert(reward_group_configs, v)
            end
        end

        local current_score = 0;
        if DataMgr.Player.EventBosses[tostring(id)] ~= nil then
            current_score = DataMgr.Player.EventBosses[tostring(id)].Damage
        end
        
        for i, v in ipairs(reward_group_configs) do
            if current_score < v.Credit then

                this.set_reward_status(this.reward_group[i], 1, v.Credit)

            elseif current_score >= v.Credit then
                if DataMgr.Player.EventBosses[tostring(id)].RewardRecords[tostring(v.Id)] == nil then

                    this.set_reward_status(this.reward_group[i], 2, v.Credit)
                else

                    this.set_reward_status(this.reward_group[i], 3, v.Credit)
                end
            end
        end

        local progress = 0.0
        for i = 2, 6 do
            if current_score < reward_group_configs[i].Credit then
                break
            else
                progress = progress + 0.2
            end
        end
        this.img_progress.fillAmount = progress
    end
end

function this.set_reward_status(go, status, score)
    for i = 1, 3 do
        local status_go = go.transform:Find("status" .. tostring(i)).gameObject
        if status == i then
            status_go:SetActive(true)
            status_go.transform:Find("textscore").gameObject:GetComponent("Text").text = tostring(score)
        else
            status_go:SetActive(false)
        end
    end
end

function this.set_text_time(id)
    local config = EventBossConfigMap[id]

    if config then
        local activity_group_config = ConfigMgr.Config.activityGroup["3080"]
        local start_time_str        = activity_group_config.startTime
        local end_time_str          = this.add_hours(start_time_str, config.ChallengeTime)
        this.text_time.text         = LuaMgr.GetLangText("ActivityBossDummyViewModel_3") .. end_time_str
    end
end

function this.add_hours(time_str, hour)

    local year, month, day, hour0, min, sec = time_str:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")


    year, month, day, hour0, min, sec = tonumber(year), tonumber(month), tonumber(day), tonumber(hour0), tonumber(min), tonumber(sec)


    local time_table = {
        year = year,
        month = month,
        day = day,
        hour = hour0,
        min = min,
        sec = sec,
    }


    local timestamp = os.time(time_table)
    timestamp = timestamp + hour * 3600
    local new_time = os.date("*t", timestamp)


    local formatted = string.format(LuaMgr.GetLangText("ActivityBossDummyViewModel_4"), new_time.year, new_time.month, new_time.day, new_time.hour, new_time.min)
    return formatted
end

function this.is_now_in_time_range(endtime)

    local function parse_time(timestr)
        local year, month, day, hour, min, sec = timestr:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
        return os.time({
            year = tonumber(year),
            month = tonumber(month),
            day = tonumber(day),
            hour = tonumber(hour),
            min = tonumber(min),
            sec = tonumber(sec)
        })
    end

    local end_timestamp = parse_time(endtime)
    local now_timestamp = os.time()

    return now_timestamp <= end_timestamp
end

function this.on_heart_beat()
    local is_pass = true
    for k, v in pairs(DataMgr.Player.EventBosses) do
        if EventBossConfigMap[k] ~= nil then
            local is_find = false
            for _, v2 in ipairs(this.vm.data.tabs) do
                if v2.id == k then
                    is_find = true
                    break
                end
            end
            if not is_find then
                is_pass = false
                break
            end
        end
    end


    if not is_pass then
        this.enable_group:SetActive(false)
        this.init_cache()
        this.set_tab()

        this.current_select_tab = nil
        if #this.vm.data.tabs > 0 then
            this.on_click_tab_btn(this.vm, 0)
        end
    end
end


function this.on_click_diff_btn(vm, param,refresh)
    if param ~= this.current_select_diff or refresh then

        local index = param + 1
        if index <= #this.vm.data.difficult then
            index = param + 1

        elseif #this.vm.data.difficult > 0 then
            index = 1

        else
            index = nil
        end

        if index ~= nil and index > 0 then
            local data = this.vm.data.difficult[index]
            if data.lock then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,BossDummy5Mgr.GetDelayTimeText(data.delay))
            else
                this.enable_group:SetActive(true)

                this.current_select_diff = index - 1
                for i, diff in ipairs(this.vm.data.difficult) do
                    if i == index then
                        diff.select = true
                    else
                        diff.select = false
                    end
                end
                
                this.vm.data.optionDesc = data.optionDesc
                this.set_heros(data.id)
                this.set_buffs(data.id)
            end
        end
    end
end

function this.on_click_tab_btn(vm, param)
    if param ~= this.current_select_tab then
        this.enable_group:SetActive(false)
        
        local index = param + 1
        if index <= #this.vm.data.tabs then
            index = param + 1

        elseif #this.vm.data.tabs > 0 then
            index = 1

        else
            index = nil

        end

        if index ~= nil and index > 0 then
            this.enable_group:SetActive(true)

            this.current_select_tab = index - 1
            for i, tab in ipairs(this.vm.data.tabs) do
                if i == index then
                    tab.is_status_1 = true
                    tab.is_status_2 = false
                else
                    tab.is_status_1 = false
                    tab.is_status_2 = true
                end
            end

            local data = this.cache.tab_data[index]
            local config = BossDummy5Mgr.GetPlotConfig(data.id)
            local diff = config.EnemyOption[1]
            if this.tab_animators and #this.tab_animators >= index then
                this.tab_animators[index]:Play("ani_ActivityBossDummy5Panel_tab_item", 0, 0)
            end
            this.vm.data.challengeLeft = string.format(LuaMgr.GetLangText("BossDummy4ViewModel_7"),
                    BossDummy5Mgr.GetMainDungeonDailyEffectCount(data.id), ConfigMgr.Config.constants.BossDummy3BossLimit)

            this.set_heros(diff)
            this.set_buffs(diff)
            this.set_text_high_score(data.name, data.score)
            this.set_spine(data.id)
            this.set_diffs(data.id)
        end
    end
end

function this.on_click_challenge_btn(vm, param)
    local activity_group_config = ConfigMgr.Config.activityGroup[tostring(BossDummy5Mgr.activityGroupId)]
    if activity_group_config.endTimeUnix < LuaMgr.Timestamp() then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBossDummyViewModel_5"))
        return
    end

    local id = this.vm.data.difficult[this.current_select_diff + 1].id
    local buffConfig = BossDummy5Mgr.GetLevelConfig(id)
    ActivityBattlePrepareMgr.SetMembers(ActivityKey.BossDummy5, buffConfig.BossDummy3Id)
    BossDummy5Mgr.SetFilterMembersMap(buffConfig.BossDummy3Id);
    
    
    LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.BossDummy5, "boss", buffConfig)


















end

function this.on_click_all_score_reward_btn(vm, param)
    LuaMgr.ShowLuaPanel(UIName.BossDummy5RewardPopup);
end

function this.on_click_hero_item_btn(vm, param)
    local index     = param + 1
    local id = this.vm.data.difficult[this.current_select_diff + 1].id
    local buffConfig = BossDummy5Mgr.GetLevelConfig(id)
    LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3BonusDescPopupViewModel, buffConfig, index)
end

function this.on_click_reward_status_1_btn(vm, param)
    local id = this.cache.tab_data[this.current_select_tab + 1].id
    local config = EventBossConfigMap[id]

    if config then
        local reward_group_id = config.RewardGroup
        local reward_group_configs = {}
        for _, v in ipairs(ConfigMgr.Config.EventBossRewards) do
            if v.Group == reward_group_id then
                table.insert(reward_group_configs, v)
            end
        end

        local reward_group_config = reward_group_configs[math.floor(tonumber(param))]
        LuaMgr.ShowLuaPanel(UIName.ActivityBossDummyRewardPreviewViewModel, reward_group_config.Group, reward_group_config.Credit, true)
    end
end

function this.on_click_reward_status_2_btn(vm, param)
    local id = this.cache.tab_data[this.current_select_tab + 1].id
    local config = EventBossConfigMap[id]

    if config then
        local reward_group_id = config.RewardGroup
        local reward_group_configs = {}
        for _, v in ipairs(ConfigMgr.Config.EventBossRewards) do
            if v.Group == reward_group_id then
                table.insert(reward_group_configs, v)
            end
        end

        local reward_group_config = reward_group_configs[math.floor(tonumber(param))]

        local data = {}
        data.BossId = id
        data.RewardIds = {}
        table.insert(data.RewardIds, reward_group_config.Id)

        ApiMgr.Request(api_get_reward_url, data, true, function(result)
            local re = json.decode(result)
            if re.code == 0 then
                local data = json.encode(re.result)
                LuaMgr.ShowItemRewared(data)
                this.set_reward_group(id)
                HeroRedDataHelper.SetBossDummyRed()
                RedMgr.Singleton:Refresh()
            end
        end, nil, true)
    end
end

function this.on_click_buff(vm, param)
    LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3BuffDescPopupViewModel, this.vm.data.buffs[param + 1].id);
end

function this.on_click_reward_status_3_btn(vm, param)
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBossDummyViewModel_6"))
end

function this.OnBack()
    if this.entry ~= nil and DataExHelper.CommonActivityCheck(ActivityKey.EventBoss) then
        LuaMgr.Back(ActivityKey.EventBoss)
    else
        LuaMgr.Back()
    end
end

return vm
(
        {
            data    = data,
            command = command,
            hook    = hook
        }
)