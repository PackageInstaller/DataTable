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
        },
        {
            id          = "111",
            name        = "233",
            score       = 0,
            is_status_1 = false,
            is_status_2 = false,
            red_id      = "",
        }
    },

    skills = {{ skillData = {id = "", icon = DefaultTexture, iconColor = normalColor, level = "", sname = "", isLevel = false,
    isLock = false, isName = false, scale = Vector3.one, typeSp = DefaultSprite, isType = false,
    isEx = false, isShow = false, isClick = false}}},

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
}

local command = 
{
    on_click_tab_btn = 
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_tab_btn(vm, param)
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
        this.on_before_active()
    end,
    after_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        print("after_active")
        this.on_after_active()
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
    this.text_bonus             = uiLink:Get("textBonus"):GetComponent("Text")
    this.text_high_score_desc   = uiLink:Get("textHighScoreDesc"):GetComponent("Text")
    this.text_high_score        = uiLink:Get("textHighScore"):GetComponent("Text")
    this.text_time              = uiLink:Get("textTime"):GetComponent("Text")
    this.img_progress           = uiLink:Get("imgProgress"):GetComponent("Image")

    this.spine_character_group = {}
    for i = 1, 4 do
        table.insert(this.spine_character_group, this.vm.behaviour.transform:Find("root/Middle/EnableGroup/Character" .. tostring(i)).gameObject)
    end

    this.enable_group           = this.vm.behaviour.transform:Find("root/Middle/EnableGroup").gameObject
    this.reward_group = {}
    for i = 1, 6 do
        local go = this.vm.behaviour.transform:Find("root/Middle/EnableGroup/groupReward/reward" .. tostring(i)).gameObject
        table.insert(this.reward_group, go)
    end

    if EventBossConfigMap == nil then
        EventBossConfigMap = {}
        for _, v in ipairs(ConfigMgr.Config.EventBosses) do
            EventBossConfigMap[v.Id] = v
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

    RedMgr.Singleton:RegisterViewModel(UIName.ActivityBossDummyViewModel)

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
end

function this.on_before_deactive()
    for i = 1, 4 do
        this.spine_character_group[i].transform:Find("Body"):GetComponent("UISpineCharacter"):Clear()
    end

    LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay, this.on_heart_beat)
    LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.on_heart_beat)

    RedMgr.Singleton:RemoveViewModel(UIName.ActivityBossDummyViewModel)

    HeroParameter.BossDummy_Select_Tab = this.current_select_tab
    HeroParameter.BossDummy_Select_Diff = this.current_select_diff
    
    this.cache = nil
    this.current_select_tab = nil
end

function this.on_before_destroy()
    this.spine_character_group = nil
end

function this.init_cache()
    this.cache = nil
    this.cache = {}

    this.cache.tab_data = {}

    for _, v in ipairs(ConfigMgr.Config.EventBosses) do
        if DataMgr.Player.EventBosses[tostring(v.Id)] ~= nil then
            local e = DataMgr.Player.EventBosses[tostring(v.Id)]
            local data = {}
            
            data.id     = tostring(v.Id)
            data.name   = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[v.DungeonId].NameLan)
            data.score  = e.Damage

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
        })
    end
    this.vm.data.tabs = data_list
end

function this.set_text_high_score(name, score)
    this.text_high_score_desc.text  = LuaMgr.GetLangText("ActivityBossDummyViewModel_0") .. tostring(name) .. LuaMgr.GetLangText("ActivityBossDummyViewModel_1") .. LuaMgr.GetLangText("ActivityBossDummyViewModel_2")
    this.text_high_score.text       = tostring(score)
end

function this.set_text_bonus(id)
    local config = EventBossConfigMap[id]

    if config then
        local s_all = ""
        for i, v in ipairs(config.Condition1desc) do
            local e = config.Condition[i]
            local s = string.format(ConfigMgr.LangGlobal(v), tostring(e[4]))
            s_all = s_all .. s .. "\n"
        end
        s_all = string.gsub(s_all, "\n$", "")

        this.text_bonus.text = s_all
    end
end

function this.set_skills(id)
    local monster_data = ConfigMgr.Config.monsterMap[id]
    if monster_data then
        local data_list = {}

        this.set_skill_data(monster_data.id, monster_data.skills, 1, data_list)
        this.set_skill_data(monster_data.id, monster_data.passiveskills, 2, data_list)
        table.sort(data_list, function(a, b) return a.skillData.order < b.skillData.order end)

        this.vm.data.skills = data_list
    end
end

function this.set_skill_data(id, list, type, data_list)
    for i, item in ipairs(list) do
        if not ConfigSkillMgr.SkillShouldHide(item[1] .. item[2], type) then
            local skillItem = {
                skillData = 
                {
                    type        = SkillType.Monster,
                    targetId    = id,
                    isClick     = true,
                    showType    = SkillShowType.Normal,
                    typeBool    = false,
                    scale       = Vector3(0.4375, 0.4375, 1),
                    isShow      = true,
                }
            }
            SkillHelper.SetSkill
            (
                skillItem.skillData, 
                item[1], 
                item[2], 
                type, 
                UnityEngine.Color.white,
                false,
                false,
                false
            )
            skillItem.skillData.skillType = type
            skillItem.skillData.isType = false
            table.insert(data_list, skillItem)
        end
    end
end

function this.set_heros(id)
    local config = EventBossConfigMap[id]

    if config then
        local data_list = {}

        for _, v in ipairs(config.Recommend) do
            local data = {}

            data.id     = v[1]
            data.icon   = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(data.id))
            data.rare   = LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..ConfigMgr.Config.characterTable[data.id].rare)
            data.job    = LuaMgr.GetSprite("JobIcon", "job_" .. ConfigMgr.Config.characterTable[data.id].job)
            data.desc   = LuaMgr.GetLangText(ConfigMgr.Config.attrDesMap[v[2]].NameLan)
            data.value  = "+" .. tostring(v[3]) .. "%"

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
                local path = HeroManager.SetCharacterDrawing(this.spine_character_group[i].transform:Find("Body"):GetComponent("UISpineCharacter"), config.BossPreview[i], config.BossPreview[i] .. "01")
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

        local current_score = DataMgr.Player.EventBosses[tostring(id)].Damage
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
    
            this.set_heros(data.id)
            this.set_skills(data.id)
            this.set_text_bonus(data.id)
            this.set_text_high_score(data.name, data.score)
            this.set_text_time(data.id)
            this.set_reward_group(data.id)
            this.set_spine(data.id)
        end
    end
end

function this.on_click_challenge_btn(vm, param)
    local activity_group_config = ConfigMgr.Config.activityGroup["3080"]
    if not this.is_now_in_time_range(activity_group_config.endTime) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBossDummyViewModel_5"))
        return
    end

    local id = this.cache.tab_data[this.current_select_tab + 1].id
    local config = EventBossConfigMap[id]

    if config then
        local dungeonId = config.DungeonId

        LuaMgr.HidePanel(UIName.ActivityBossDummyViewModel)
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()

        enterDungeonParams.eventId      = config.Id
        enterDungeonParams.dungeonId    = dungeonId
        enterDungeonParams.extraParams  = {}
        table.insert(enterDungeonParams.extraParams, "event_boss")
        table.insert(enterDungeonParams.extraParams, config.Id)
        table.insert(enterDungeonParams.extraParams, id)
        table.insert(enterDungeonParams.extraParams, tostring(ActivityMgr.GetEventBossesTotalScore()))

        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    end
end

function this.on_click_all_score_reward_btn(vm, param)
    LuaMgr.ShowLuaPanel(UIName.ActivityBossDummyScorePopupViewModel)
end

function this.on_click_hero_item_btn(vm, param)
    local index     = param + 1
    local heroid    = this.vm.data.heros[index].id
    local id        = this.cache.tab_data[this.current_select_tab + 1].id
    local config    = EventBossConfigMap[id]

    LuaMgr.ShowLuaPanel(UIName.ActivityBossDummyBonusPreviewViewModel, heroid, config)
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