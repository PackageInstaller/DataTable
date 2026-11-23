require("ViewModel/BossDummy3/ActivityBossDummy3HeroItem")
require("ViewModel/BossDummy3/ActivityBossDummy3BuffItem")
require("ViewModel/BossDummy5/ActivityBossDummy5RateItem")
require("ViewModel/BossDummy5/BossDummy5BuffDescItem")

local this = {
    vm = nil,
    gameObject = nil,

    listHeight = {
        offset_x = 10,
        width = 512,
        height = 4
    }
}

local objs = {
    text_score_count = { path = "root/Middle/score_count/desc/Text", type = "Text" },

    left_enemy_buff_go = { path = "root/Middle/tab_enemy_buff/buff_list/ui_scroll_buff/Viewport/Content", type = "GameObject" },

    hero_list_go = { path = "root/Middle/ui_scroll_heros/Content", type = "GameObject" },
    text_rate = { path = "root/Middle/rate/text_val", type = "Text" },
    text_rate_uianimation = { path = "root/Middle/rate/text_val", type = "UIAnimator" },
    text_highest_score = { path = "root/Middle/highest_score/Text", type = "Text" },
    tab_rate_go = { path = "root/Middle/tabs/tab_rate", type = "GameObject" },
    tab_buff_go = { path = "root/Middle/tabs/tab_buff", type = "GameObject" },
    rate_list_go = { path = "root/Middle/tabs/tab_rate/status_1/ui_scroll_rate_select/ui_scroll_rate/Viewport/Content", type = "GameObject" },
    buff_desc_list_go = { path = "root/Middle/tabs/tab_buff/status_1/ui_scroll_buff_select/ui_scroll_buff/Viewport/Content", type = "GameObject" },
    rate_scroll_rect = { path = "root/Middle/tabs/tab_rate/status_1/ui_scroll_rate_select/ui_scroll_rate", type = "ScrollRect" },
    buff_desc_scroll_rect = { path = "root/Middle/tabs/tab_buff/status_1/ui_scroll_buff_select/ui_scroll_buff", type = "ScrollRect" },
    hero_item_go = { path = "template/hero_item", type = "GameObject" },
    rate_item_go = { path = "template/rate_item", type = "GameObject" },
    buff_item_go = { path = "template/buff_item", type = "GameObject" },
    buff_desc_item_go = { path = "template/buff_desc_item", type = "GameObject" },
}

local data = {

}

local command = {
    on_click_next_step_btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_next_step_btn(vm, param)
        end
    },

    on_click_rate_btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_rate_btn()
        end
    },

    on_click_buff_btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_buff_btn()
        end
    },

    on_click_back_btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_back_btn()
        end
    }
}

local hook = {
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
    this.vm = vm
    this.gameObject = this.vm.behaviour.gameObject

    UITool.Parse(this.gameObject, this, objs)
end

function this.on_before_active()
    this.vm.behaviour:UpdateTopBar("", this.OnBack)
    this.selected_buff = nil
    this.selected_config = nil

    local params = this.vm.behaviour.Params
    local id = params[0]
    for i, v in ipairs(ConfigMgr.Config.BossDummy3s) do
        if v.Id == id then
            this.config = v
            break
        end
    end

    this.id = id

    this.hero_list = UIListView.New(this.hero_list_go.transform)
    this.hero_list:Clear()

    this.left_enemy_buff_list = UIListView.New(this.left_enemy_buff_go.transform)
    this.left_enemy_buff_list:Clear()

    this.rate_list = UIListView.New(this.rate_list_go.transform)
    this.rate_list:Clear()

    this.buff_desc_list = UIListView.New(this.buff_desc_list_go.transform)
    this.buff_desc_list:Clear()

    this.set_text_score_count()
    this.set_left_enemy_buff_list()
    this.set_text_rate(0)
    this.set_text_highest_score()
    this.set_tabs()
    this.set_rate_list(id)
    this.choose_rate()
    this.set_hero_list()
    this.set_buff_desc_list()
end

function this.on_before_deactive()
    this.selected_buff = nil
    this.selected_config = nil

    if this.hero_list ~= nil then
        this.hero_list:Clear()
    end

    if this.left_enemy_buff_list ~= nil then
        this.left_enemy_buff_list:Clear()
    end

    if this.rate_list ~= nil then
        this.rate_list:Clear()
    end

    if this.buff_desc_list ~= nil then
        this.buff_desc_list:Clear()
    end

    UIListView.ClearItem("ActivityBossDummy3HeroItem")
    UIListView.ClearItem("ActivityBossDummy3BuffItem")
    UIListView.ClearItem("ActivityBossDummy5RateItem")
    UIListView.ClearItem("BossDummy5BuffDescItem")
end

function this.set_text_score_count()
    local s = string.format(LuaMgr.GetLangText("BossDummy5BuffViewModel_0"), BossDummy5Mgr.GetMainDungeonDailyEffectCount(this.id), ConfigMgr.Config.constants.BossDummy3BossLimit)
    this.text_score_count.text = s
end

function this.set_left_enemy_buff_list()
    this.left_enemy_buff_list:Clear()

    if this.selected_config ~= nil then
        local data_list = {}
        for i = 1, #this.selected_config.BuffGroup, 1 do
            local element = {}
            element.config = BossDummy5Mgr.GetBuffDescConfig(this.selected_config.BuffGroup[i])
            element.enemy = true

            local data = UIListData.GetData(this.buff_item_go, "ActivityBossDummy3BuffItem", element)
            table.insert(data_list, data)
        end

        this.left_enemy_buff_list:SetData(data_list, true)
    end
end

function this.set_hero_list()
    this.hero_list:Clear()

    if this.selected_config == nil then
        return
    end

    local data_list = {}
    for i = 1, #this.selected_config.ReCommend, 1 do
        local element = {}
        element.config = table.Copy(this.selected_config)
        element.index = i

        local data = UIListData.GetData(this.hero_item_go, "ActivityBossDummy3HeroItem", element)
        table.insert(data_list, data)
    end

    this.hero_list:SetData(data_list, true)
end

function this.set_text_rate(rate)
    this.text_rate.text = tostring(rate + 100) .. "%"
    this.text_rate_uianimation.AnimationName = "ani_BossDummy5BuffPanel_text_val_001"
end

function this.set_text_highest_score()
    this.text_highest_score.text = LuaMgr.GetLangText("ActivityBossDummy3StageBossBuffViewModel_0") .. tostring(BossDummy5Mgr.GetDungeonMaxScore(this.id))
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
        element.config = v
        element.callback = f
        element.islock = BossDummy5Mgr.CheckPlotLevelIsLock(v.Id)

        local levelStatus = BossDummy5Mgr.GetPlotLevelStatus(v.Id)
        if levelStatus == 0 or levelStatus == 2 then
            element.status = 3
        elseif element.islock or levelStatus == 3 then
            element.status = 2
        else
            element.status = levelStatus
        end

        local data = UIListData.GetData(this.rate_item_go, "ActivityBossDummy5RateItem", element)
        table.insert(data_list, data)
    end
    table.sort(data_list, function(a, b)
        if a.data.islock and b.data.islock then
            return a.data.config.Id < b.data.config.Id
        elseif (not a.data.islock and not b.data.islock) then
            return a.data.config.Id > b.data.config.Id
        else
            return not a.data.islock
        end
    end)
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
            instance.set_text_rate(math.floor(v.config.Credit / 100))
            instance.set_left_enemy_buff_list()
            BossDummy5Mgr.SavePlotChoosedLevel(instance.id, id)
        end
    end
end

function this.set_buff_desc_list()
    this.buff_desc_list:Clear()
    this.listHeight.height = 4

    if this.selected_config ~= nil then
        local function f(id)
            this.on_buff_desc_item_click_callback(this, id)
        end

        local data_list = {}
        local buffGroup = this.selected_config.BossBuffGroup
        for i = 1, #buffGroup, 1 do
            local element = {}
            element.config = BossDummy5Mgr.GetBuffDescConfig(buffGroup[i])
            element.callback = f
            element.listHeight = this.listHeight
            local data = UIListData.GetData(this.buff_desc_item_go, "BossDummy5BuffDescItem", element)
            table.insert(data_list, data)
        end
        this.buff_desc_list:SetData(data_list, true)
    end
    this.buff_desc_list_go.transform.sizeDelta = Vector2(this.listHeight.width + this.listHeight.offset_x, this.listHeight.height)

    local lastChoosedBuff = BossDummy5Mgr.GetPlotChoosedBuff(this.id)
    if lastChoosedBuff ~= nil then
        this.on_buff_desc_item_click_callback(this, lastChoosedBuff)
        for i, v in ipairs(this.buff_desc_list.itemList) do
            if v.config.Id == lastChoosedBuff then
                LuaMgr.DragTargetToViewPortOnCenter(this.buff_desc_scroll_rect, v.transform:GetComponent("RectTransform"), nil, 0.5)
                break
            end
        end
    end
end

function this.on_buff_desc_item_click_callback(instance, id)
    for i, v in ipairs(instance.buff_desc_list.itemList) do
        v.chooseGo:SetActive(false)
        if v.config.Id == id then
            v.chooseGo:SetActive(true)
            instance.selected_buff = id
            BossDummy5Mgr.SavePlotChoosedBuff(instance.id, id)
        end
    end
end

function this.choose_rate()
    local lastRateId = BossDummy5Mgr.GetPlotChoosedLevel(this.id)
    if lastRateId ~= nil then
        this.on_rate_item_click_callback(this, lastRateId)
        for i, v in ipairs(this.rate_list.itemList) do
            if v.config.Id == lastRateId then
                LuaMgr.DragTargetToViewPortOnCenter(this.rate_scroll_rect, v.transform:GetComponent("RectTransform"), nil, 0.5)
                break
            end
        end
    else
        local chooseId = this.rate_list.itemList[1].config.Id
        if IsNullOrEmpty(chooseId) then
            local arr = {}
            for i, v in ipairs(ConfigMgr.Config.BossDummy3Buffs) do
                if v.BossDummy3Id == this.id then
                    table.insert(arr, v)
                end
            end
            chooseId = arr[1].Id
        end
        this.on_rate_item_click_callback(this, chooseId)
    end
end

function this.on_click_rate_btn()
    this.tab_rate_go.transform:Find("status_1").gameObject:SetActive(true)
    this.tab_rate_go.transform:Find("status_2").gameObject:SetActive(false)
    this.tab_buff_go.transform:Find("status_1").gameObject:SetActive(false)
    this.tab_buff_go.transform:Find("status_2").gameObject:SetActive(true)
end

function this.on_click_buff_btn()
    this.tab_rate_go.transform:Find("status_1").gameObject:SetActive(false)
    this.tab_rate_go.transform:Find("status_2").gameObject:SetActive(true)
    this.tab_buff_go.transform:Find("status_1").gameObject:SetActive(true)
    this.tab_buff_go.transform:Find("status_2").gameObject:SetActive(false)
end

function this.on_click_next_step_btn(vm, param)
    if this.selected_config == nil then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBossDummy3StageBossBuffViewModel_2"))
    elseif this.selected_buff == nil and math.abs(LuaMgr.Timestamp() - PlayerPrefs.GetInt(DataMgr.Player.uid .. "BossDummy3_NoBuffPopup_TimeStamp")) >= 86400 then
        LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3NoBuffPopupViewModel, table.Copy(this.selected_config), this.on_click_buff_btn, ActivityKey.BossDummy5)
    else
        ActivityBattlePrepareMgr.SetMembers(ActivityKey.BossDummy5, this.selected_config.BossDummy3Id)
        LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.BossDummy5, "boss", table.Copy(this.selected_config), this.selected_buff)
    end
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.BossDummy5BuffViewModel)
end

function this.OnBack()
    LuaMgr.Back()
end

return vm(
        {
            data = data,
            command = command,
            hook = hook
        }
)