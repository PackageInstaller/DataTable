require("ViewModel/BossDummy3/ActivityBossDummy3HeroItem")
require("ViewModel/BossDummy3/ActivityBossDummy3BuffItem")
require("ViewModel/BossDummy3/ActivityBossDummy3RateItem")
require("ViewModel/BossDummy3/ActivityBossDummy3BuffItem2")

local this =
{
    vm              = nil,
    gameObject      = nil,
}

local objs =
{
    text_score_count        = { path = "root/Middle/score_count/desc/Text", type = "Text" },

    tab_left_buff_go        = { path = "root/Middle/tab/tab_buff", type = "GameObject" },
    buff_list_go            = { path = "root/Middle/tab/tab_buff/buff_list/ui_scroll_buff/Viewport/Content", type = "GameObject" },
    no_buff_img_go          = { path = "root/Middle/tab/tab_buff/buff_list/no_buff_img", type = "GameObject" },
    text_buff_count         = { path = "root/Middle/tab/tab_buff/buff_count/desc/Text", type = "Text" },

    tab_left_enemy_buff_go  = { path = "root/Middle/tab/tab_enemy_buff", type = "GameObject" },
    left_enemy_buff_go      = { path = "root/Middle/tab/tab_enemy_buff/buff_list/ui_scroll_buff/Viewport/Content", type = "GameObject" },
    
    hero_list_go        = { path = "root/Middle/ui_scroll_heros/Content", type = "GameObject" },
    text_rate           = { path = "root/Middle/rate/text_val", type = "Text" },
    text_highest_score  = { path = "root/Middle/highest_score/Text", type = "Text" },
    tab_rate_go         = { path = "root/Middle/tabs/tab_rate", type = "GameObject" },
    tab_buff_go         = { path = "root/Middle/tabs/tab_buff", type = "GameObject" },
    rate_list_go        = { path = "root/Middle/tabs/tab_rate/status_1/ui_scroll_rate_select/ui_scroll_rate/Viewport/Content", type = "GameObject" },
    buff_list_2_go      = { path = "root/Middle/tabs/tab_buff/status_1/ui_scroll_buff_select/ui_scroll_buff/Viewport/Content", type = "GameObject" },
    rate_scroll_rect    = { path = "root/Middle/tabs/tab_rate/status_1/ui_scroll_rate_select/ui_scroll_rate", type = "ScrollRect" },
    hero_item_go        = { path = "template/hero_item", type = "GameObject" },
    rate_item_go        = { path = "template/rate_item", type = "GameObject" },
    buff_item_go        = { path = "template/buff_item", type = "GameObject" },
    buff_item_2_go      = { path = "template/buff_item_2", type = "GameObject" },
}

local data = 
{

}

local command =
{
    on_click_next_step_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_next_step_btn(vm, param)
        end
    },

    on_click_rate_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_rate_btn()
        end
    },

    on_click_buff_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_buff_btn()
        end
    },

    on_click_back_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_back_btn()
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
        this.on_before_active()
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then 
            return 
        end
        this.on_before_deactive()
    end, 
}

function this.init(vm)
    this.vm                 = vm
    this.gameObject         = this.vm.behaviour.gameObject

    UITool.Parse(this.gameObject, this, objs)
end

function this.on_before_active()
    this.vm.behaviour:UpdateTopBar("", this.OnBack)
    this.selected_buff      = {}
    this.selected_config    = nil

    local params    = this.vm.behaviour.Params
    local id        = params[0]
    for i, v in ipairs(ConfigMgr.Config.BossDummy3s) do
        if v.Id == id then
            this.config = v
            break
        end
    end

    this.id = id

    this.tab_left_buff_go:SetActive(false)
    this.tab_left_enemy_buff_go:SetActive(false)

    this.hero_list = UIListView.New(this.hero_list_go.transform)
    this.hero_list:Clear()

    this.left_buff_list = UIListView.New(this.buff_list_go.transform)
    this.left_buff_list:Clear()

    this.left_enemy_buff_list = UIListView.New(this.left_enemy_buff_go.transform)
    this.left_enemy_buff_list:Clear()

    this.rate_list = UIListView.New(this.rate_list_go.transform)
    this.rate_list:Clear()

    this.buff_list_2 = UIListView.New(this.buff_list_2_go.transform)
    this.buff_list_2:Clear()

    this.set_text_score_count()
    this.set_text_buff_count()
    this.set_left_buff_list()
    this.set_left_enemy_buff_list()
    this.set_text_rate(0)
    this.set_text_highest_score()
    this.set_tabs()
    this.set_rate_list(id)
    this.set_buff_list_2()
    this.set_buff_list_by_cache()
    this.choose_rate()
end

function this.on_before_deactive()
    this.selected_buff      = {}
    this.selected_config    = nil

    if this.hero_list ~= nil then
        this.hero_list:Clear()
    end

    if this.left_buff_list ~= nil then
        this.left_buff_list:Clear()
    end

    if this.left_enemy_buff_list ~= nil then
        this.left_enemy_buff_list:Clear()
    end

    if this.rate_list ~= nil then
        this.rate_list:Clear()
    end

    if this.buff_list_2 ~= nil then
        this.buff_list_2:Clear()
    end

    UIListView.ClearItem("ActivityBossDummy3HeroItem")
    UIListView.ClearItem("ActivityBossDummy3BuffItem")
    UIListView.ClearItem("ActivityBossDummy3RateItem")
    UIListView.ClearItem("ActivityBossDummy3BuffItem2")
end

function this.set_text_score_count()
    local s = string.format("<color=#B47240>%s</color>/%s", tostring(BossDummy3Mgr.GetBossDummy3TodayEffectScoreCount()), tostring(BossDummy3Mgr.GetBossDummy3TodayLimitScoreCount()))
    this.text_score_count.text = s
end

function this.set_text_buff_count()
    local s = string.format("<color=#B47240>%s</color>/%s", tostring(#this.selected_buff), tostring(BossDummy3Mgr.GetBossDummy3StageBossMaxBuffCount()))
    this.text_buff_count.text = s
end

function this.set_left_buff_list()
    this.left_buff_list:Clear()
    if #this.selected_buff == 0 then
        this.no_buff_img_go:SetActive(true)
    else
        this.no_buff_img_go:SetActive(false)

        local data_list = {}
        for i = 1, #this.selected_buff, 1 do
            local element = {}
            element.config = BossDummy3Mgr.GetBuffDescConfig(this.selected_buff[i])
            
            local data = UIListData.GetData(this.buff_item_go, "ActivityBossDummy3BuffItem", element)
            table.insert(data_list, data)
        end

        this.left_buff_list:SetData(data_list, true)
    end
    this.set_text_buff_count()
end

function this.set_left_enemy_buff_list()
    this.left_enemy_buff_list:Clear()

    if this.selected_config ~= nil then
        local data_list = {}
        for i = 1, #this.selected_config.BuffGroup, 1 do
            local element = {}
            element.config = BossDummy3Mgr.GetBuffDescConfig(this.selected_config.BuffGroup[i])
            
            local data = UIListData.GetData(this.buff_item_go, "ActivityBossDummy3BuffItem", element)
            table.insert(data_list, data)
        end

        this.left_enemy_buff_list:SetData(data_list, true)
    end
end

function this.set_hero_list(config)
    this.hero_list:Clear()

    local data_list = {}

    for i = 1, #config.ReCommend, 1 do
        local element = {}
        element.config = config
        element.index = i

        local data = UIListData.GetData(this.hero_item_go, "ActivityBossDummy3HeroItem", element)
        table.insert(data_list, data)
    end

    this.hero_list:SetData(data_list, true)
end

function this.set_text_rate(rate)
    this.text_rate.text = tostring(rate + 100) .. "%"
end

function this.set_text_highest_score()
    this.text_highest_score.text = LuaMgr.GetLangText("ActivityBossDummy3StageBossBuffViewModel_0") .. tostring(BossDummy3Mgr.GetBossDummy3HighestScore())
end

function this.set_tabs()
    this.tab_rate_go.transform:Find("status_1").gameObject:SetActive(false)
    this.tab_rate_go.transform:Find("status_2").gameObject:SetActive(true)
    this.tab_buff_go.transform:Find("status_1").gameObject:SetActive(false)
    this.tab_buff_go.transform:Find("status_2").gameObject:SetActive(true)

    this.on_click_rate_btn()
end

function this.set_rate_list(id)
    this.rate_list:Clear()
    local arr = {}
    for i, v in ipairs(ConfigMgr.Config.BossDummy3Buffs) do
        if v.BossDummy3Id == id then
            table.insert(arr, v)
        end
    end

    local function f(id)
        this.on_rate_item_click_callback(this, id)
    end

    local data_list = {}
    for i, v in ipairs(arr) do
        local element = {}
        element.config      = v

        if BossDummy3Mgr.GetIsUnlock(v.Delay) then
            if DataMgr.Player.bossDummy3Rewards ~= nil and DataMgr.Player.bossDummy3Rewards[v.Id] then

                element.status = 3
            else

                element.status = 1
            end
        else

            element.status = 2
        end
        
        element.callback    = f

        local data = UIListData.GetData(this.rate_item_go, "ActivityBossDummy3RateItem", element)
        table.insert(data_list, data)
    end
    this.rate_list:SetData(data_list, true)
end

function this.on_rate_item_click_callback(instance, id)
    for i, v in ipairs(instance.rate_list.itemList) do
        v.choose_go:SetActive(false)
        v.is_click = false
        if v.config.Id == id then
            v.choose_go:SetActive(true)
            v.is_click = true
            instance.selected_config = v.config
            instance.set_hero_list(v.config)
            instance.set_text_rate(math.floor(v.config.Credit / 100))
            instance.set_left_enemy_buff_list()
            BossDummy3Mgr.SaveLastBossRateId(id)
        end
    end
end

function this.set_buff_list_2()
    this.buff_list_2:Clear()
    local arr = BossDummy3Mgr.GetOwnedBuffList()

    local function f(id)
        this.on_buff_item_2_click_callback(this, id)
    end

    local data_list = {}    
    for i, v in ipairs(arr) do
        local element = {}
        element.config      = BossDummy3Mgr.GetBuffDescConfig(v)
        element.callback    = f

        local data = UIListData.GetData(this.buff_item_2_go, "ActivityBossDummy3BuffItem2", element)
        table.insert(data_list, data)
    end
    this.buff_list_2:SetData(data_list, true)
end

function this.on_buff_item_2_click_callback(instance, id)
    local is_in_list = false
    local index = -1
    for i, v in ipairs(instance.selected_buff) do
        if id == v then
            index = i
            is_in_list = true
            break
        end
    end
    if is_in_list then
        table.remove(instance.selected_buff, index)
    else
        if #instance.selected_buff + 1 > BossDummy3Mgr.GetBossDummy3StageBossMaxBuffCount() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBossDummy3StageBossBuffViewModel_1"))
            return
        end
        table.insert(instance.selected_buff, id)
    end
    for i, v in ipairs(instance.buff_list_2.itemList) do
        if v.config.Id == id then
            v.choose_go:SetActive(not is_in_list)
            v.gameObject:GetComponent("Animator"):Play("ani_ActivityBossDummy3StageBossBuffPanel_buff_item_2_02", 0, 0)
            break
        end
    end
    instance.set_left_buff_list()
    BossDummy3Mgr.SaveCacheSelectedBuffList(instance.selected_buff)
end

function this.choose_rate()
    local lastRateId = BossDummy3Mgr.GetLastBossRateId()
    if lastRateId ~= nil then
        this.on_rate_item_click_callback(this, lastRateId)
        for i, v in ipairs(this.rate_list.itemList) do
            if v.config.Id == lastRateId then
                LuaMgr.DragTargetToViewPortOnCenter(this.rate_scroll_rect,v.transform:GetComponent("RectTransform"),nil, 0.5)
                break
            end
        end
    else
        local arr = {}
        for i, v in ipairs(ConfigMgr.Config.BossDummy3Buffs) do
            if v.BossDummy3Id == this.id then
                table.insert(arr, v)
            end
        end
        this.on_rate_item_click_callback(this, arr[1].Id)
    end
end

function this.on_click_rate_btn()
    this.tab_rate_go.transform:Find("status_1").gameObject:SetActive(true)
    this.tab_rate_go.transform:Find("status_2").gameObject:SetActive(false)
    this.tab_buff_go.transform:Find("status_1").gameObject:SetActive(false)
    this.tab_buff_go.transform:Find("status_2").gameObject:SetActive(true)
    this.tab_left_buff_go:SetActive(false)
    this.tab_left_enemy_buff_go:SetActive(true)
end

function this.on_click_buff_btn()
    this.tab_rate_go.transform:Find("status_1").gameObject:SetActive(false)
    this.tab_rate_go.transform:Find("status_2").gameObject:SetActive(true)
    this.tab_buff_go.transform:Find("status_1").gameObject:SetActive(true)
    this.tab_buff_go.transform:Find("status_2").gameObject:SetActive(false)
    this.tab_left_buff_go:SetActive(true)
    this.tab_left_enemy_buff_go:SetActive(false)
end

function this.on_click_next_step_btn(vm, param)
    if this.selected_config == nil then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBossDummy3StageBossBuffViewModel_2"))
    elseif #this.selected_buff == 0 and math.abs(LuaMgr.Timestamp() - PlayerPrefs.GetInt(DataMgr.Player.uid .. "BossDummy3_NoBuffPopup_TimeStamp")) >= 86400 then
        LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3NoBuffPopupViewModel, table.Copy(this.selected_config),this.on_click_buff_btn, ActivityKey.BossDummy3)
    else
        ActivityBattlePrepareMgr.SetMembers(ActivityKey.BossDummy3, this.selected_config.BossDummy3Id)
        LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.BossDummy3, "boss", table.Copy(this.selected_config), table.Copy(this.selected_buff))
    end
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossDummy3StageBossBuffViewModel)
end

function this.OnBack()
    LuaMgr.Back()
end

function this.set_buff_list_by_cache()
    for i,v in ipairs(BossDummy3Mgr.GetCacheSelectedBuffList()) do
        this.on_buff_item_2_click_callback(this,v)
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