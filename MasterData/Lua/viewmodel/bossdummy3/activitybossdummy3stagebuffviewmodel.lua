require("ViewModel/BossDummy3/ActivityBossDummy3BuffItem")
require("ViewModel/BossDummy3/ActivityBossDummy3DifficultyItem")

local this =
{
    vm              = nil,
    gameObject      = nil,
    buff_list       = nil,
    enemy_buff_list = nil,
    buff_item_go    = nil,
    difficulty_list = nil,
    difficulty_item = nil,
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
    this.buff_list          = UIListView.New(this.gameObject.transform:Find("root/Middle/buff_list/ui_scroll_buff/Viewport/Content").transform)
    this.enemy_buff_list    = UIListView.New(this.gameObject.transform:Find("root/Middle/enemy_buff_list/ui_scroll_buff/Viewport/Content").transform)
    this.buff_item_go       = this.gameObject.transform:Find("template/buff_item").gameObject
    this.difficulty_list    = UIListView.New(this.gameObject.transform:Find("root/Middle/tabs/ui_scroll_diff_select/ui_scroll_diff/Viewport/Content").transform)
    this.difficulty_item    = this.gameObject.transform:Find("template/level_item").gameObject
end

function this.on_before_active()
    this.vm.behaviour:UpdateTopBar("", this.OnBack)
    this.buff_list:Clear()
    this.enemy_buff_list:Clear()
    this.selected_config = nil
    
    local params    = this.vm.behaviour.Params
    local id        = params[0]
    this.set_difficulty_list(id)


    this.choose_first(id)
end

function this.on_before_deactive()
    this.selected_config = nil

    this.buff_list:Clear()
    this.enemy_buff_list:Clear()
    this.difficulty_list:Clear()

    UIListView.ClearItem("ActivityBossDummy3BuffItem")
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
        element.config              = v
        element.click_callback      = on_click_callback
        element.receive_callback    = on_receive_callback

        if BossDummy3Mgr.GetIsUnlock(v.Delay) then
            if DataMgr.Player.bossDummy3Rewards and DataMgr.Player.bossDummy3Rewards[v.Id] then
                local a = DataMgr.Player.bossDummy3Rewards[v.Id]
                if a.status == 0 then

                    element.status = 1
                    element.is_can_receive = true
                else

                    element.status = 2
                end
            else

                element.status = 1
            end
        else

            element.status = 3
        end

        local data = UIListData.GetData(this.difficulty_item, "ActivityBossDummy3DifficultyItem", element)
        table.insert(data_list, data)
    end
    this.difficulty_list:SetData(data_list, true)
end

function this.choose_first(id)
    local arr = {}
    for i, v in ipairs(ConfigMgr.Config.BossDummy3Buffs) do
        if id == v.BossDummy3Id then
            table.insert(arr, v)
        end
    end
    if #arr > 0 then
        this.on_difficulty_item_click_callback(this, arr[1].Id)
    end
end

function this.set_buff_list(listView, config,enemy)
    listView:Clear()

    local data_list = {}
    for i = 1, #config, 1 do
        local element = {}
        element.config = BossDummy3Mgr.GetBuffDescConfig(config[i])
        element.enemy = enemy
        local data = UIListData.GetData(this.buff_item_go, "ActivityBossDummy3BuffItem", element)
        table.insert(data_list, data)
    end
    listView:SetData(data_list, true)
end

function this.on_difficulty_item_click_callback(instance, id)
    for i, v in ipairs(instance.difficulty_list.itemList) do
        v.choose_go:SetActive(false)
        v.is_click = false
        if v.config.Id == id then
            v.choose_go:SetActive(true)
            v.is_click = true
            instance.selected_config = v.config
            instance.set_buff_list(instance.buff_list, v.config.BuffWin,false)
            instance.set_buff_list(instance.enemy_buff_list, v.config.BuffGroup,true)
        end
    end
end

function this.on_difficulty_item_receive_callback(instance, id)
    for i, v in ipairs(instance.difficulty_list.itemList) do
        if v.config.Id == id then
            local data = {}
            data.RewardIds = {}
            table.insert(data.RewardIds, id)

            ApiMgr.Request("boss_dummy3/get_rewards", data, true, function(result)
                local re = json.decode(result)
                if re.code == 0 then
                    local data = json.encode(re.result)
                    LuaMgr.ShowItemRewared(data)
                    instance.set_difficulty_list(v.config.BossDummy3Id)
                    instance.on_difficulty_item_click_callback(instance, id)
                    RedMgr.Singleton:SetRedState("16851_" .. tonumber(id) % 1000, BossDummy3Mgr.GetNormalLevelRewardStatus(id))
                end
            end, nil, true)

            break
        end
    end
end

function this.on_click_next_step_btn(vm, param)
    if this.selected_config == nil then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBossDummy3StageBuffViewModel_0"))
    else
        ActivityBattlePrepareMgr.SetMembers(ActivityKey.BossDummy3, this.selected_config.BossDummy3Id)
        LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.BossDummy3, "normal", table.Copy(this.selected_config))
    end
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossDummy3StageBuffViewModel)
end

function this.OnBack()
    LuaMgr.Back()
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)