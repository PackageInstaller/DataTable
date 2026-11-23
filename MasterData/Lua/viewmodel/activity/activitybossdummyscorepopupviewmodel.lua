require("ViewModel/Activity/ActivityBossDummyScorePopupRewardItem")

local this =
{
    vm = nil,
}

local data =
{
    rewards =
    {
        {
            id              = "1233",
            text_desc       = "1231",
        }
    },

    text_score = "123123",
}

local command = 
{
    on_click_btn_all_receive =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_btn_all_receive()
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
        print("before_active")
        this.on_before_active()
    end,














    before_destroy = function(vm)
        this.on_before_destroy()
    end
}

local api_get_reward_url = "event_boss/get_total_rewards"

function this.init(vm)
    this.vm = vm
    this.listView   = UIListView.New(vm.behaviour.transform:Find("root/Middle/ui_scroll_reward/Viewport/Content").transform)
    this.itemObj    = vm.behaviour.transform:Find("root/template/reward_item").gameObject
end

function this.on_before_active()
    this.set_list()
    this.set_text_score()
end

function this.on_before_destroy()
    this.listView:Clear()
    UIListView.ClearItem("ActivityBossDummyScorePopupRewardItem")
end

function this.set_list()
    this.listView:Clear()
    local score = ActivityMgr.GetEventBossesTotalScore()

    local data_list = {}

    for i, v in ipairs(ConfigMgr.Config.EventBossCreditRewards) do
        local element = {}
        element.config = v
        element.callback = this.on_click_btn_receive

        if score < v.Credit then
            element.status = 1
        else
            if DataMgr.Player.EventBossTotalRewards[tostring(v.Id)] == nil then
                element.status = 2
            else
                element.status = 3
            end
        end
        
        local data = UIListData.GetData(this.itemObj, "ActivityBossDummyScorePopupRewardItem", element)
        table.insert(data_list, data)
    end

    this.listView:SetData(data_list, true)
end

function this.set_text_score()
    local score = ActivityMgr.GetEventBossesTotalScore()
    this.vm.data.text_score = tostring(score)
end

function this.on_click_btn_receive(config)
    if config then
        local data = {}
        data.RewardIds = {}
        table.insert(data.RewardIds, config.Id)

        ApiMgr.Request(api_get_reward_url, data, true, function(result)
        local re = json.decode(result)
        if re.code == 0 then
            local data = json.encode(re.result)
            LuaMgr.ShowItemRewared(data)
            this.set_list()
            HeroRedDataHelper.SetBossDummyRed()
            RedMgr.Singleton:Refresh()
        end
    end, nil, true)
    end
end

function this.on_click_btn_all_receive()
    local score = ActivityMgr.GetEventBossesTotalScore()
    local ids = {}
    for i, v in ipairs(ConfigMgr.Config.EventBossCreditRewards) do
        if score >= v.Credit and DataMgr.Player.EventBossTotalRewards[tostring(v.Id)] == nil then
            table.insert(ids, v.Id)
        end
    end
    if #ids > 0 then
        local data = {}
        data.RewardIds = ids

        ApiMgr.Request(api_get_reward_url, data, true, function(result)
        local re = json.decode(result)
            if re.code == 0 then
                local data = json.encode(re.result)
                LuaMgr.ShowItemRewared(data)
                this.set_list()
                HeroRedDataHelper.SetBossDummyRed()
                RedMgr.Singleton:Refresh()
            end
        end, nil, true)
    else
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityBossDummyScorePopupViewModel_0"))
    end
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossDummyScorePopupViewModel)
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)