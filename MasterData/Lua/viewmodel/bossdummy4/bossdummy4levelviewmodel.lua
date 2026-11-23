require("ViewModel/BossDummy4/BossDummy4BuffDescItem")
require("ViewModel/BossDummy3/ActivityBossDummy3HeroItem")
require("ViewModel/BossDummy3/ActivityBossDummy3DifficultyItem")

local this = {
    vm = nil,
    gameObject = nil,
    buff_content = nil,
    buff_list = nil,
    buff_item = nil,
    hero_list = nil,
    hero_item = nil,
    difficulty_list = nil,
    difficulty_item = nil,

    listHeight = {
        offset_x = 8,
        width = 528,
        height = 5
    }
}

local data = {
    showDifficultTips = false,
}

local command = {
    on_click_next_step_btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_next_step_btn(vm, param)
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
    this.buff_content = this.gameObject.transform:Find("root/Middle/buff_list/ui_scroll_buff/Viewport/Content").transform
    this.buff_list = UIListView.New(this.buff_content)
    this.buff_item = this.gameObject.transform:Find("template/buff_item").gameObject
    this.hero_list = UIListView.New(this.gameObject.transform:Find("root/Middle/ui_scroll_heros/Content").transform)
    this.hero_item = this.gameObject.transform:Find("template/hero_item").gameObject
    this.difficulty_list = UIListView.New(this.gameObject.transform:Find("root/Middle/tabs/ui_scroll_diff_select/ui_scroll_diff/Viewport/Content").transform)
    this.difficulty_item = this.gameObject.transform:Find("template/level_item").gameObject
end

function this.on_before_active()
    this.vm.behaviour:UpdateTopBar("", this.OnBack)
    this.buff_list:Clear()
    this.selected_config = nil

    local params = this.vm.behaviour.Params
    local id = params[0]
    this.set_difficulty_list(id)


    this.choose_first(id)
    this.set_hero_list()
end

function this.on_before_deactive()
    this.selected_config = nil

    this.buff_list:Clear()
    this.difficulty_list:Clear()

    UIListView.ClearItem("BossDummy4BuffDescItem")
    UIListView.ClearItem("ActivityBossDummy3HeroItem")
    UIListView.ClearItem("ActivityBossDummy3DifficultyItem")
end

function this.set_difficulty_list(id)
    this.difficulty_list:Clear()
    local arr = {}
    for i, v in ipairs(ConfigMgr.Config.BossDummy3Buffs) do
        if id == v.BossDummy3Id then
            table.insert(arr, v)
        end
    end

    local function on_click_callback(id)
        this.on_difficulty_item_click_callback(this, id)
    end

    local function on_receive_callback(id)
        this.on_difficulty_item_receive_callback(this, id)
    end

    local data_list = {}
    for i, v in ipairs(arr) do
        local element = {}
        element.config = v
        element.click_callback = on_click_callback
        element.receive_callback = on_receive_callback

        local levelStatus = BossDummy4Mgr.GetPlotLevelStatus(v.Id)
        element.sort = levelStatus
        if levelStatus == 0 then

            element.status = 1
            element.is_can_receive = true
        else
            element.status = levelStatus
        end

        local data = UIListData.GetData(this.difficulty_item, "ActivityBossDummy3DifficultyItem", element)
        table.insert(data_list, data)
    end
    table.sort(data_list, function(a, b)
        if a.data.sort == b.data.sort then
            return a.data.config.Id < b.data.config.Id
        else
            return a.data.sort < b.data.sort
        end
    end)
    this.difficulty_list:SetData(data_list, true)
end

function this.choose_first(id)
    local chooseId = this.difficulty_list.itemList[1].config.Id
    if IsNullOrEmpty(chooseId) then
        local arr = {}
        for i, v in ipairs(ConfigMgr.Config.BossDummy3Buffs) do
            if id == v.BossDummy3Id then
                table.insert(arr, v)
            end
        end
        chooseId = arr[1].Id
    end
    this.on_difficulty_item_click_callback(this, chooseId)
end

function this.set_buff_list(config)
    this.buff_list:Clear()
    this.listHeight.height = 5
    local data_list = {}
    for i = 1, #config.BuffGroup, 1 do
        local element = {}
        element.config = BossDummy4Mgr.GetBuffDescConfig(config.BuffGroup[i])
        element.listHeight = this.listHeight
        local data = UIListData.GetData(this.buff_item, "BossDummy4BuffDescItem", element)
        table.insert(data_list, data)
    end
    this.buff_list:SetData(data_list, true)
    this.buff_content.sizeDelta = Vector2(this.listHeight.width + this.listHeight.offset_x, this.listHeight.height)
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

        local data = UIListData.GetData(this.hero_item, "ActivityBossDummy3HeroItem", element)
        table.insert(data_list, data)
    end
    this.hero_list:SetData(data_list, true)
end

function this.on_difficulty_item_click_callback(instance, id)
    for i, v in ipairs(instance.difficulty_list.itemList) do
        v.choose_go:SetActive(false)
        v.is_click = false
        if v.config.Id == id then
            v.choose_go:SetActive(true)
            v.is_click = true
            this.vm.data.showDifficultTips = v.config.OptionDiff == "1" 
            instance.selected_config = v.config
            instance.set_buff_list(v.config)
        end
    end
end

function this.on_difficulty_item_receive_callback(instance, id)
    local data = {}
    local canGetLevelIds = {}
    for i, v in ipairs(instance.difficulty_list.itemList) do
        if v.is_can_receive then
            table.insert(canGetLevelIds, v.config.Id)
        end
    end
    if #canGetLevelIds > 0 then
        data.RewardIds = canGetLevelIds
        ApiMgr.Request("boss_dummy3/get_rewards", data, true, function(result)
            local re = json.decode(result)
            if re.code == 0 then
                local data = json.encode(re.result)
                LuaMgr.ShowItemRewared(data)
                local levelCfg = BossDummy4Mgr.GetLevelConfig(id)
                instance.set_difficulty_list(levelCfg.BossDummy3Id)
                instance.on_difficulty_item_click_callback(instance, id)
            end
        end, nil, true)
    end
end

function this.on_click_next_step_btn(vm, param)
    if this.selected_config == nil then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBossDummy3StageBuffViewModel_0"))
    else
        ActivityBattlePrepareMgr.SetMembers(ActivityKey.BossDummy3, this.selected_config.BossDummy3Id)
        LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.BossDummy4, "normal", table.Copy(this.selected_config))
    end
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.BossDummy4LevelViewModel)
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