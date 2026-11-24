require("ViewModel/YJSYZ/YJSYZRewardPopupRewardItem")

local this =
{
    vm = nil,
    current_btn_index = 1,
    reward_list = nil,
}

local objs =
{
    reward_item = { path = "template/reward_item", type = "GameObject" },

    btn_1 = { path = "root/Middle/btns/btn_1", type = "GameObject"},
    btn_1_on = { path = "root/Middle/btns/btn_1/on", type = "GameObject"},
    btn_1_off = { path = "root/Middle/btns/btn_1/off", type = "GameObject"},
    btn_2 = { path = "root/Middle/btns/btn_2", type = "GameObject"},
    btn_2_on = { path = "root/Middle/btns/btn_2/on", type = "GameObject"},
    btn_2_off = { path = "root/Middle/btns/btn_2/off", type = "GameObject"},
    btn_3 = { path = "root/Middle/btns/btn_3", type = "GameObject"},
    btn_3_on = { path = "root/Middle/btns/btn_3/on", type = "GameObject"},
    btn_3_off = { path = "root/Middle/btns/btn_3/off", type = "GameObject"},

    reward_list_go = { path = "root/Middle/ui_scroll_reward/Viewport/Content", type = "GameObject" },
}

local data =
{

}

local command =
{
    on_click_btn_1 =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_btn_1()
        end
    },

    on_click_btn_2 =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_btn_2()
        end
    },

    on_click_btn_3 =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_btn_3()
        end
    },

    on_click_back_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_back_btn()
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
        this.on_before_active()
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.on_before_deactive()
    end,
    before_destroy = function(vm)

    end
}

function this.init(vm)
    this.vm                 = vm
    this.gameObject         = this.vm.behaviour.gameObject

    UITool.Parse(this.gameObject, this, objs)
end

function this.on_before_active()
    this.gameObject = this.vm.behaviour.gameObject
    this.reward_list = UIListView.New(this.reward_list_go.transform)
    LuaMgr.AddUIEventListener(UIEventConst.YJSYZGetAward, this.on_click_receive_btn)
    this.on_click_btn_1()
end

function this.on_before_deactive()
    LuaMgr.RemoveUIEventListener(UIEventConst.YJSYZGetAward, this.on_click_receive_btn)
    if this.reward_list ~= nil then
        this.reward_list:Clear()
    end
    UIListView.ClearItem("YJSYZRewardPopupRewardItem")
end

function this.set_reward_list(arr)
    if this.reward_list == nil then
        return
    end

    this.reward_list:Clear()

    local sort_list = {}
    for _, v in ipairs(arr or {}) do
        local element = {}
        element.config = v
        element.status = DataExHelper.Check_RewardState(v.id)
        table.insert(sort_list, element)
    end

    table.sort(sort_list, function(a, b)
        local sort_a = a.status == 2 and 1 or (a.status == 3 and 3 or 2)
        local sort_b = b.status == 2 and 1 or (b.status == 3 and 3 or 2)
        if sort_a == sort_b then
            return tonumber(a.config.sort or 0) < tonumber(b.config.sort or 0)
        end
        return sort_a < sort_b
    end)

    local data_list = {}
    for _, sort_data in ipairs(sort_list) do
        local v = sort_data.config
        local element = {}

        element.config = v
        element.total = v.progress

        local state = sort_data.status
        if state == 1 then
            element.status = 1
        elseif state == 2 then
            element.status = 2
        elseif state == 3 then
            element.status = 3
        end

        local progressValue = 0
        if DataMgr.Player.quests[v.id] ~= nil then
            progressValue = DataMgr.Player.quests[v.id].progress
        end
        element.progress    = progressValue
        element.reward      = {}

        if not IsNull(v.showReward) then
            for _, v2 in ipairs(v.showReward) do
                local e = {}
                e.id        = v2.id
                e.count     = v2.count
                table.insert(element.reward, e)
            end
        end

        local go_data = UIListData.GetData(this.reward_item, "YJSYZRewardPopupRewardItem", element)
        table.insert(data_list, go_data)
    end

    this.reward_list:SetData(data_list, true)
end

function this.on_click_receive_btn()
    this.receive_all_reward()
end

function this.receive_all_reward()
    local quest_ids = this.get_all_can_receive_quest_ids()
    if #quest_ids <= 0 then
        return
    end

    local askData = { questIds = quest_ids }
    ApiMgr.Request("ex/get_award", askData, true, function(result)
        local re = json.decode(result)
        local data = json.encode(re.result)
        LuaMgr.ShowItemRewared(data)
        if this.current_btn_index == 1 then
            this.on_click_btn_1()
        elseif this.current_btn_index == 2 then
            this.on_click_btn_2()
        elseif this.current_btn_index == 3 then
            this.on_click_btn_3()
        end
        HeroRedDataHelper.CheckYJSYZRed()
    end, nil, true)
end

function this.get_all_can_receive_quest_ids()
    local ids = {}
    local reward_list = {
        YJSYZHelper.get_btn_1_reward(),
        YJSYZHelper.get_btn_2_reward(),
        YJSYZHelper.get_btn_3_reward(),
    }

    for _, list in ipairs(reward_list) do
        for _, v in ipairs(list or {}) do
            if DataExHelper.Check_RewardState(v.id) == 2 then
                table.insert(ids, v.id)
            end
        end
    end

    return ids
end

function this.set_btn_state(index)
    local btns = {
        [1] = { on = this.btn_1_on, off = this.btn_1_off },
        [2] = { on = this.btn_2_on, off = this.btn_2_off },
        [3] = { on = this.btn_3_on, off = this.btn_3_off },
    }

    for i = 1, 3 do
        local btn = btns[i]
        if btn ~= nil then
            local is_on = i == index
            if btn.on ~= nil then
                btn.on:SetActive(is_on)
            end
            if btn.off ~= nil then
                btn.off:SetActive(not is_on)
            end
        end
    end
end

function this.on_click_btn_1()
    this.current_btn_index = 1
    this.set_btn_state(1)
    this.set_reward_list(YJSYZHelper.get_btn_1_reward())
end

function this.on_click_btn_2()
    this.current_btn_index = 2
    this.set_btn_state(2)
    this.set_reward_list(YJSYZHelper.get_btn_2_reward())
end

function this.on_click_btn_3()
    this.current_btn_index = 3
    this.set_btn_state(3)
    this.set_reward_list(YJSYZHelper.get_btn_3_reward())
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.YJSYZRewardPopupViewModel)
end


return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)