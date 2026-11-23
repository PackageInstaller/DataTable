local this = 
{
    vm                      = nil,
selected_color          = UnityEngine.Color(126.0 / 255.0, 29.0 / 255.0, 9 / 255.0),
unselected_color        = UnityEngine.Color(255.0 / 255.0, 255.0 / 255.0, 250.0 / 255.0),
    gameObject              = nil,
    text_monster_name       = nil,
    text_score              = nil,
    text_close_time         = nil,
    btn_lineup_recommend    = nil,
    img_monster             = nil,
    templist                = nil,
    select_target_index     = nil,
    tweener                 = nil,
    spine_character         = nil,
    btn_get_reward          = nil,
    cache                   = nil,
}

local data = 
{
    target_data_list = 
    {
        {
            id              = "8022401",
            name            = "Test1",
            is_selected     = false,
            is_waiting      = false,
            is_open         = false,
            text_color      = this.unselected_color,
            status_str      = "",
            open_time_str   = "",
            close_time_str  = "",
            max_damage      = 22243242,
            score           = 22,
            red_id          = "",
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
            level       = "120",
            staricon    = DefaultSprite,
            star        = ""
        }
    },

    rewards =
    {
        {
            id          = "",
            rare        = DefaultSprite,
            icon        = DefaultTexture,
            count       = "24",
            progress    = "80%",
            finished    = false,
            unfinished  = false,
        }
    },

    is_open_enable_group    = false,
    is_open_disable_group   = false,
    is_open_hero_group      = true,
    is_close_hero_group     = false,
disable_group_text      = "",
    ranking                 = "",
    monster_texture         = DefaultTexture,
    reward_list_anchordPos  = Vector2(0, 0),
    bodypath                = "",
}

local command = 
{
    target_btn =
    {
        type = XLuaCommandType.Bool,
        execute = function(vm, isOn, param)
            this.on_target_btn(vm, isOn, param, false)
        end
    },

    on_click_skill_item_btn = 
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_skill_item_btn(vm, param)
        end
    },

    on_click_lineup_recommend_btn = 
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_lineup_recommend_btn(vm, param)
        end
    },

    on_click_reward_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_reward_btn(vm, param)
        end
    },

    on_click_ranking_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_ranking_btn(vm, param)
        end
    },

    on_click_challenge_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_challenge_btn(vm, param)
        end
    },

    on_click_get_reward_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_get_reward_btn(vm, param)
        end
    },

    on_click_rule_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_rule_btn(vm, param)
        end
    },

    onClickBackButton = 
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if DataExHelper.Check_BossChallenge() then
                LuaMgr.Back("BossChallenge")
            else
                LuaMgr.Back()
            end
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

local challenge_boss_map = nil
local api_get_rank_url = "challenge_boss/get_rank"
local api_get_reward_url = "challenge_boss/get_rank_rewards"

function this.init(vm)
    this.vm                     = vm
    this.gameObject             = this.vm.behaviour.gameObject

    local uiLink                = this.gameObject:GetComponent("UILink")
    this.text_monster_name      = uiLink:Get("textMonsterName"):GetComponent("Text")
    this.text_score             = uiLink:Get("textScore"):GetComponent("Text")
    this.text_close_time        = uiLink:Get("textCloseTime"):GetComponent("Text")
    this.btn_lineup_recommend   = uiLink:Get("btnLineupRecommend"):GetComponent("RectTransform")
    this.img_monster            = uiLink:Get("imgMonster"):GetComponent("RawImage")
    this.spine_character        = this.vm.behaviour.transform:Find("root/Middle/Character/Body"):GetComponent("UISpineCharacter")
    this.btn_get_reward         = this.vm.behaviour.transform:Find("root/Middle/ui_button_reward/ui_button_get_reward").gameObject
    this.black_fx               = this.vm.behaviour.transform:Find("root/Middle/fx_black").gameObject

    if challenge_boss_map == nil then
        challenge_boss_map = {}
        for _, v in ipairs(ConfigMgr.Config.ChallengeBosses) do
            challenge_boss_map[v.Id] = v
        end
    end
end

function this.on_before_active()
    this.select_target_index    = nil
    this.init_cache()

    this.vm.behaviour:UpdateTopBar("", this.OnBack)
    this.init_target_data_list()
    this.set_time()

    LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay, this.on_heart_beat)
    LuaMgr.AddUIEventListener(UIEventConst.HeartBeat, this.on_heart_beat)

    LuaMgr.RemoveTimer(TimerConst.ActivityBossChallengeViewModelTimer1)
    LuaMgr.AddTimer(TimerConst.ActivityBossChallengeViewModelTimer1, this.on_timer1, 10.0, -1, false)

    RedMgr.Singleton:RegisterViewModel(UIName.ActivityBossChallengeViewModel)
    RedMgr.Singleton:Refresh()
end

function this.on_after_active()
    local params = this.vm.behaviour.Params

    if #this.vm.data.target_data_list > 0 then
        if params ~= nil 
            and params.Length > 0 
            and (params[0] == "ActivityBossChallengeEntryViewModel" or params[0] == "MainPageViewModel") then
            local has_select = false
            for i, target_data in ipairs(this.vm.data.target_data_list) do
                if target_data.is_waiting == false then
                    this.vm.data.target_data_list[i].is_selected = true
                    this.on_target_btn(this.vm, true, i - 1, true)
                    has_select = true
                    break
                end
            end


            if has_select == false then
                local index = #this.vm.data.target_data_list
                this.vm.data.target_data_list[index].is_selected = true
                this.on_target_btn(this.vm, true, index - 1, true)
            end

        elseif this.select_target_index ~= nil then
            this.vm.data.target_data_list[this.select_target_index].is_selected = true
            this.on_target_btn(this.vm, true, this.select_target_index - 1, true)
            
        elseif HeroParameter.SelectTargetIndex ~= nil then
            this.vm.data.target_data_list[HeroParameter.SelectTargetIndex].is_selected = true
            this.on_target_btn(this.vm, true, HeroParameter.SelectTargetIndex - 1, true)

        else
            this.vm.data.target_data_list[1].is_selected = true
            this.on_target_btn(this.vm, true, 0, true)
        end
    end

    if HeroParameter.Last_BossChallenge_Timestamp == nil then
        HeroParameter.Last_BossChallenge_Timestamp = DataMgr.Player.ChallengeBossLast.Timestamp
    else
        if DataMgr.Player.ChallengeBossLast.Timestamp > HeroParameter.Last_BossChallenge_Timestamp then
            HeroParameter.Last_BossChallenge_Timestamp = DataMgr.Player.ChallengeBossLast.Timestamp
            local data = {}

            data.id         = DataMgr.Player.ChallengeBossLast.Id
            data.score      = DataMgr.Player.ChallengeBossLast.Score
            data.damage     = DataMgr.Player.ChallengeBossLast.Damage
            data.round      = DataMgr.Player.ChallengeBossLast.Round
            data.hero_count = DataMgr.Player.ChallengeBossLast.CharactersNum

            LuaMgr.ShowLuaPanel(UIName.ActivityBossChallengeBattleScorePopupViewModel, data);
        end
    end
end

function this.on_before_deactive()
    if this.tweener ~= nil then
        this.tweener:Kill()
    end
    this.tweener = nil
    HeroParameter.SelectTargetIndex = this.select_target_index

    LuaMgr.RemoveTimer(TimerConst.ActivityBossChallengeViewModelTimer1)
    LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay, this.on_heart_beat)
    LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.on_heart_beat)

    if this.spine_character ~= nil then
        this.spine_character:Clear()
    end

    HeroRedDataHelper.SetBossChallengeRed()

    RedMgr.Singleton:RemoveViewModel(UIName.ActivityBossChallengeViewModel)

    this.cache = nil
end

function this.on_before_destroy()
    this.spine_character    = nil
    this.btn_get_reward     = nil
end

function this.on_target_btn(vm, isOn, param, force_refresh)
    local index = param + 1
    if isOn then
        this.vm.data.target_data_list[index].text_color = this.selected_color
        if this.select_target_index == nil or this.select_target_index ~= index or force_refresh then
            local target_data = this.vm.data.target_data_list[index]
            this.select_target_index = index
            this.set_target_data(target_data)
            if this.cache == nil then
                this.init_cache()
            end
            this.set_hero_data(this.cache[target_data.id].hero_data_cache, target_data.id)
            this.set_reward_data(target_data.max_damage, target_data.id)
            this.set_player_prefs_data(target_data.challenge_time,target_data.id)
            this.play_black_fx()
        end
    else
        this.vm.data.target_data_list[index].text_color = this.unselected_color
    end
end

function this.init_target_data_list()
    local config_data = {}
    for _, v in ipairs(ConfigMgr.Config.ChallengeBosses) do
        table.insert(config_data, v)
    end
    table.sort(config_data, function(lhs, rhs) return lhs.Order < rhs.Order end)

    local data_list = {}
    for i, v in ipairs(config_data) do
        local element = {}

        element.id                      = v.Id
        element.name                    = LuaMgr.GetLangText(ConfigMgr.Config.monsterMap[v.Id].NameLan)
        element.is_selected             = false
        element.is_waiting              = false
        element.is_open                 = false
        element.text_color              = this.unselected_color
        element.status_str              = ""
        element.open_time_str           = ""
        element.close_time_str          = ""
        element.max_damage              = 0
        element.score                   = 0
        element.hero_data               = {}
        element.challenge_time          = 0
        element.red_id                  = "15011_" .. v.Id

        table.insert(data_list, element)
    end

    local target_data_list = data_list
    this.vm.data.target_data_list = target_data_list

    if this.select_target_index ~= nil then
        data_list[this.select_target_index].is_selected = true
        data_list[this.select_target_index].text_color = this.selected_color
    end
end

function this.init_cache()
    this.cache                  = {}
    for _, v in ipairs(ConfigMgr.Config.ChallengeBosses) do
        this.cache[v.Id] = 
        {
            hero_data_cache         = {},
            rank_data_cache         = {rank = 0, total = 0},   
            last_request_timestamp  = 0, 
        }
    end
end

function this.set_target_data(target_data)
    print("this.set_target_data")
    if target_data ~= nil then
        local challenge_config = challenge_boss_map[target_data.id]

        this.text_monster_name.text     = target_data.name
        this.set_score(target_data.score, target_data.id)

        this.text_close_time.text       = target_data.close_time_str



        if this.spine_character ~= nil then
            this.spine_character:Clear()
        end

        local path = HeroManager.SetCharacterDrawing(this.spine_character, challenge_config.BossRes, challenge_config.BossRes .. "01")
        if path ~= "" then
            this.vm.data.bodypath = path
        end

        this.btn_get_reward:SetActive(false)
        local rewards = DataMgr.Player.ChallengeBossRankRewards
        for i, v in ipairs(rewards) do
            if v.BossId == target_data.id and v.Status == 0 then
                this.btn_get_reward:SetActive(true)
                break
            end
        end

        this.vm.data.skills = {}
        this.templist = {}
        local monster_data = ConfigMgr.Config.monsterMap[target_data.id]
        if monster_data ~= nil then
            this.set_skill_data(monster_data.id, monster_data.skills, 1)
            this.set_skill_data(monster_data.id, monster_data.passiveskills, 2)
            table.sort(this.templist, function(a, b) return a.skillData.order < b.skillData.order end)
            this.vm.data.skills = this.templist
        end

        this.vm.data.is_open_enable_group = not target_data.is_waiting
        this.vm.data.is_open_disable_group = target_data.is_waiting

        if target_data.is_waiting then
            this.vm.data.disable_group_text = target_data.open_time_str
        end

        local data = 
        {
            bossId = target_data.id
        }

        if target_data.is_open == true then

            local last_request_timestamp = this.cache[target_data.id].last_request_timestamp
            if last_request_timestamp + 3 >= LuaMgr.Timestamp() then
                this.set_hero_data(this.cache[target_data.id].hero_data_cache, target_data.id)
                local rank_data_cache = this.cache[target_data.id].rank_data_cache
                this.set_rank(rank_data_cache.rank, rank_data_cache.total, target_data.id)
            else
                print("Send Request " .. target_data.id)
                ApiMgr.Request(api_get_rank_url, data, true, function(result)
                    local re = json.decode(result)
                    if re.code == 0 then
                        this.set_hero_data_and_rank(re.result, target_data.id)
                    end
                end, nil, true)
            end
        else
            this.set_rank(0, 0, target_data.id)
        end
    else
        this.vm.data.is_open_enable_group = false
        this.vm.data.is_open_disable_group = false
    end
end

function this.set_skill_data(id, list, type)
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
                table.insert(this.templist, skillItem)
        end
    end
end

function this.set_hero_data_and_rank(result, boss_id)
    if result.TeamInfo ~= nil and #result.TeamInfo > 0 then
        local hero_data = {}
        if result.TeamInfo[1].Characters ~= nil and type(result.TeamInfo[1].Characters) == "table" then
            for _, v in ipairs(result.TeamInfo[1].Characters) do
                local element = {}
                element.id      = v.Id
                element.level   = v.Level
                element.star    = v.Star
                table.insert(hero_data, element)
            end
        end
        this.set_hero_data(hero_data, boss_id)
    else

        local hero_data = {}
        local config = ConfigMgr.Config.Recommends
        for _, v in ipairs(config) do
            if v.BelongBoss == boss_id then
                for _, v2 in ipairs(v.RecommendShow) do
                    local element = {}
                    element.id      = v2[1]
                    element.star    = tonumber(v2[2])
                    element.level   = v2[3]
element.use002  = true
                    table.insert(hero_data, element)
                end
                break
            end
        end
        this.set_hero_data(hero_data, boss_id)
    end

    this.set_rank(result.Rank, result.Total, boss_id)

    if this.cache[boss_id] == nil then
        this.cache[boss_id] = {}
    end
    this.cache[boss_id].last_request_timestamp = LuaMgr.Timestamp()
end

function this.set_hero_data(hero_data, boss_id)
    if hero_data == nil or #hero_data == 0 then
        this.vm.data.is_open_hero_group = false
        this.vm.data.is_close_hero_group = true
    else
        this.vm.data.is_open_hero_group = true
        this.vm.data.is_close_hero_group = false

        local templist = {}

        for _, data in ipairs(hero_data) do
            local element = {}

            if data.id ~= nil and data.id ~= "" then
                element.id      = data.id
                
                if data.use002 then
                    element.icon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(data.id, data.id .. "002"))
                else
                    element.icon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(data.id))
                end

                element.rare    = LuaMgr.GetSprite("CommonRes","ui_ty_kp_pz_"..ConfigMgr.Config.characterTable[data.id].rare)
                element.job     = LuaMgr.GetSprite("JobIcon", "job_" .. ConfigMgr.Config.characterTable[data.id].job)
                element.level   = tostring(data.level)

                local zzStr = data.star > 0 and "<color=#262429>%s</color>" or "<color=#aca9a3>%s</color>"
                if data.star == 0 then
                    element.staricon = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz2")
                    element.star = string.format(zzStr, tostring(HeroMgr.GetNumStr(1)))
                else
                    element.staricon = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_zz1")
                    element.star = string.format(zzStr, tostring(HeroMgr.GetNumStr(data.star)))
                end

                table.insert(templist, element)
            end
        end

        local pos = this.btn_lineup_recommend.anchoredPosition
        this.btn_lineup_recommend.anchoredPosition = Vector2(60.0 + 70 * (#templist - 1), -12.0)

        this.vm.data.heros = templist
    end
    this.cache[boss_id].hero_data_cache = hero_data
end 

function this.set_rank(rank, total, boss_id)
    if rank == 0 then
        this.vm.data.ranking = LuaMgr.GetLangText("ActivityBossChallengeViewModel_1")
    else
        local cfg = nil
        for i, v in ipairs(ConfigMgr.Config.ChallengeBosses) do
            if v.Id == boss_id then
                cfg = v
                break
            end
        end
        if cfg ~= nil then
            for i, v in ipairs(cfg.RankShow) do

                if total < 100 then
                    this.vm.data.ranking = ConfigMgr.LangGlobal(tostring(v[1]))
                    break 
                else

                    local left  = tonumber(v[2])
                    local right = tonumber(v[3])
                    local ratio = math.floor(rank / total * 100)

                    if ratio >= left and ratio <= right then
                        this.vm.data.ranking = ConfigMgr.LangGlobal(tostring(v[1]))
                        break
                    end
                end
            end
        end
    end
    this.cache[boss_id].rank_data_cache = {rank = rank, total = total}
end

function this.set_score(score, boss_id)
    if score <= 0 then
        this.text_score.text = LuaMgr.GetLangText("ActivityBossChallengeViewModel_11")
    else
        this.text_score.text = tostring(score)
    end
end

function this.set_reward_data(damage, boss_id)
    local templist = {}

    local config = nil

    for i, v in ipairs(ConfigMgr.Config.ChallengeBosses) do
        if v.Id == boss_id then
            config = v
            break
        end
    end

    local finished_count = 0
    if config ~= nil then
        for i, data in ipairs(config.BossRewards) do
            local progress          = data[1]
            local damage_require    = tonumber(data[1]) * 0.01 * config.Hp
            local id                = data[2]
            local count             = data[3]
            local element =         
            {
                id          = tostring(id),
                rare        = ConfigHelper.GetRareSprite(ConfigMgr.Config.itemMap[tostring(id)].rare),
                icon        = ConfigHelper.GetItemTexture(tostring(id)),
                count       = tostring(count),
                progress    = tostring(math.floor(tonumber(progress)) .. LuaMgr.GetLangText("ActivityBossChallengeViewModel_10")),
                finished    = false,
                unfinished  = false,
            }
            if damage >= tonumber(damage_require) then
                element.finished = true
                finished_count = finished_count + 1
            else
                element.unfinished = true
            end
            table.insert(templist, element)
        end
    end
    this.vm.data.rewards = templist

    local pos = Vector2(-56 * (finished_count), -26)

    this.vm.data.reward_list_anchordPos = pos
    if this.tweener~=nil then
        this.tweener:Kill()
    end
    this.tweener=DOTWeen.To(function() return Vector2(0,-26) end, function(vector)
        this.vm.data.reward_list_anchordPos = vector
    end, pos, 0.5)

    
end

function this.set_player_prefs_data(challenge_time, boss_id)
    UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid .. "BossChallenge_15011_" .. boss_id, challenge_time)
    HeroRedDataHelper.SetBossChallengeRed()
    RedMgr.Singleton:Refresh()
end

function this.set_time()
    local challenge_bosses = DataMgr.Player.ChallengeBosses
    local current_timestamp = LuaMgr.Timestamp()

    for i, target_data in ipairs(this.vm.data.target_data_list) do
        if challenge_bosses[target_data.id] ~= nil then

            local challenge_boss_data = challenge_bosses[target_data.id]
            if current_timestamp < challenge_boss_data.ChallengeTime then
                target_data.is_waiting = false
                local str = this.convert_seconds(challenge_boss_data.ChallengeTime - current_timestamp)
                str = str .. LuaMgr.GetLangText("ActivityBossChallengeViewModel_2")
                target_data.close_time_str = str
                target_data.status_str = LuaMgr.GetLangText("ActivityBossChallengeViewModel_3")
            else
                target_data.is_waiting = true
                
                local seconds = math.max(challenge_boss_data.NextResetTime - current_timestamp, 0)

                if seconds >= 25 * 86400 then 
                    target_data.open_time_str = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_104011")
                else
                    local str = this.convert_seconds(seconds)
                    str = str .. LuaMgr.GetLangText("ActivityBossChallengeViewModel_4")
                    target_data.open_time_str = str
                end
                target_data.status_str = LuaMgr.GetLangText("ActivityBossChallengeViewModel_5")
            end

            target_data.is_open         = true
            target_data.score           = DataMgr.Player.ChallengeBosses[target_data.id].Score
            target_data.max_damage      = DataMgr.Player.ChallengeBosses[target_data.id].Damage
            target_data.challenge_time  = challenge_boss_data.ChallengeTime
        else

            target_data.is_waiting  = true
            target_data.is_open     = false

            local group_id = challenge_boss_map[target_data.id].GroupId
            local activity_group_config = ConfigMgr.Config.activityGroup[tostring(group_id)]
            local start_time_str = activity_group_config.startTime

            local start_timestamp = this.convert_to_timestamp(start_time_str) + challenge_boss_map[target_data.id].StartTime * 3600
            local str = this.convert_seconds(math.max(start_timestamp - current_timestamp, 0))
            str = str .. LuaMgr.GetLangText("ActivityBossChallengeViewModel_6")
            target_data.open_time_str = str
            target_data.status_str = LuaMgr.GetLangText("ActivityBossChallengeViewModel_7")
        end
    end

    if this.select_target_index ~= nil then
        this.vm.data.disable_group_text = this.vm.data.target_data_list[this.select_target_index].open_time_str
    end
end


function this.update_current_select_target_status()
    if this.select_target_index == nil 
        or this.select_target_index <= 0 
        or this.select_target_index > #this.vm.data.target_data_list then
        return
    end

    local target_data = this.vm.data.target_data_list[this.select_target_index]
    if target_data.is_waiting == true then
        local challenge_bosses = DataMgr.Player.ChallengeBosses
        local current_timestamp = LuaMgr.Timestamp()
        if challenge_bosses[target_data.id] ~= nil then
            local challenge_boss_data = challenge_bosses[target_data.id]
            local seconds = math.max(challenge_boss_data.NextResetTime - current_timestamp, 0)
            if seconds == 0 then
                local data = {}
                data.DeviceID = LuaMgr.GetToken()
                ApiMgr.Request("heartbeat",data,true,function(result)
                end,nil,true)
            end
        end
    end
end

function this.convert_seconds(seconds)

    local days = math.floor(seconds / 86400)

    local hours = math.floor((seconds % 86400) / 3600)

    local minutes = math.floor((seconds % 3600) / 60)

    return string.format(LuaMgr.GetLangText("ActivityBossChallengeViewModel_8"), days, hours, minutes)
end

function this.convert_to_timestamp(str)
    local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
    local year, month, day, hour, min, sec = str:match(pattern)


    local time_table = {
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(min),
        sec = tonumber(sec)
    }
    

    local local_timestamp = os.time(time_table)
    

    local utc_timestamp = os.time(os.date("!*t", local_timestamp))
    

    local utc_plus_8_timestamp = utc_timestamp + (8 * 3600)

    return utc_plus_8_timestamp
end

function this.play_black_fx()
    this.black_fx:SetActive(false)
    this.black_fx:SetActive(true)
end

function this.on_heart_beat()
    this.init_target_data_list()
    this.set_time()

    if this.select_target_index ~= nil 
        and this.vm.data.target_data_list 
        and #this.vm.data.target_data_list > 0 then
        local target_data = this.vm.data.target_data_list[this.select_target_index]
        this.vm.data.target_data_list[this.select_target_index].text_color = this.selected_color
        this.set_target_data(target_data)
        this.set_hero_data(this.cache[target_data.id].hero_data_cache, target_data.id)
    end
end

function this.on_timer1()
    this.set_time()
    this.update_current_select_target_status()
end

function this.on_click_skill_item_btn(vm, param)
    print("this.on_click_skill_item_btn(vm, param)")







end

function this.on_click_lineup_recommend_btn(vm, param)
    print("this.on_click_lineup_recommend_btn(vm, param)")

    if this.select_target_index == nil 
        or this.select_target_index <= 0 
        or this.select_target_index > #this.vm.data.target_data_list then
        return
    end

    local target_data = this.vm.data.target_data_list[this.select_target_index]
    local bossId = target_data.id

    local data = 
    {
        bossId = bossId
    }

    ApiMgr.Request(api_get_rank_url, data, true, function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.set_hero_data_and_rank(re.result, bossId)

            if re.result.TeamInfo ~= nil and #re.result.TeamInfo > 0 then
                local data_list = {}

                for _, v in ipairs(re.result.TeamInfo) do
                    local element = {}

                    local hero_data = {}
                    if v.Characters ~= nil and type(v.Characters) == "table" then
                        for _, v2 in ipairs(v.Characters) do
                            local e = {}
                            e.id    = v2.Id
                            e.level = v2.Level
                            e.star  = v2.Star
                            table.insert(hero_data, e)
                        end
                    end
                    element.hero_data = hero_data

                    table.insert(data_list, element)
                end
                LuaMgr.ShowLuaPanel(UIName.ActivityBossChallengeLineupRecommendPopupViewModel, data_list)

            else

                local data_list = {}
                local config = ConfigMgr.Config.Recommends
                for _, v in ipairs(config) do
                    if v.BelongBoss == bossId then
                        local element = {}
                        local hero_data = {}
                        for _, v2 in ipairs(v.RecommendShow) do
                            local e = {}
                            e.id      = v2[1]
                            e.star    = tonumber(v2[2])
                            e.level   = v2[3]
e.use002  = true
                            table.insert(hero_data, e)
                        end
                        element.hero_data = hero_data
                        table.insert(data_list, element)
                    end
                end
                LuaMgr.ShowLuaPanel(UIName.ActivityBossChallengeLineupRecommendPopupViewModel, data_list)
            end
        end
    end, nil, true)
end

function this.on_click_reward_btn(vm, param)
    print("this.on_click_reward_btn(vm, param)")

    local target_data = this.vm.data.target_data_list[this.select_target_index]
    local bossId = target_data.id

    local data = 
    {
        bossId = bossId
    }

    if target_data.is_open == false then
        LuaMgr.ShowLuaPanel(UIName.ActivityBossChallengeRewardPreviewPopupViewModel, bossId, 0, 0)
    else
        ApiMgr.Request(api_get_rank_url, data, true, function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.set_hero_data_and_rank(re.result, bossId)

                local current_rank = re.result.Rank
                local total = re.result.Total

                LuaMgr.ShowLuaPanel(UIName.ActivityBossChallengeRewardPreviewPopupViewModel, bossId, current_rank, total)
            end
        end, nil, true)
    end    
end

function this.on_click_ranking_btn(vm, param)
    print("this.on_click_ranking_btn(vm, param)")













































end

function this.on_click_challenge_btn(vm, param)
    print("this.on_click_challenge_btn(vm, param)")
    if this.select_target_index ~= nil and this.select_target_index <= #this.vm.data.target_data_list then
        local config_id = this.vm.data.target_data_list[this.select_target_index].id
        local dungeonId = challenge_boss_map[config_id].LevelId

        LuaMgr.HidePanel(UIName.ActivityBossChallengeViewModel)
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()

        enterDungeonParams.eventId      = config_id.Id
        enterDungeonParams.dungeonId    = dungeonId
        enterDungeonParams.extraParams  = {}
        table.insert(enterDungeonParams.extraParams, "challenge_boss")
        table.insert(enterDungeonParams.extraParams, config_id)

        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    end
end

function this.on_click_get_reward_btn(vm, param)
    print("this.on_click_get_reward_btn")
    ApiMgr.Request(api_get_reward_url, {}, true, function(result)
        local re = json.decode(result)
        if re.code == 0 then
            print("Get Reward Success!")
            this.btn_get_reward:SetActive(false)
            local data = json.encode(re.result)
            LuaMgr.ShowItemRewared(data)
            HeroRedDataHelper.SetBossChallengeRed()
            RedMgr.Singleton:Refresh()
        end
    end, nil, true)
end

function this.on_click_rule_btn(vm, param)
    print("this.on_click_rule_btn")
    LuaMgr.ShowLuaPanel(UIName.ActivityBossChallengeRulePopupViewModel)
end

function this.OnBack()
    if DataExHelper.Check_BossChallenge() then
        LuaMgr.Back("BossChallenge")
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