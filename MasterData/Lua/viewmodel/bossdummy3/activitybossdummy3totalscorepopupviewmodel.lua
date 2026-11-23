require("ViewModel/BossDummy3/ActivityBossDummy3TotalScorePopupItem")

local this =
{
    vm = nil,
}

local data = 
{
    text_score = "1",
    allCanGetRewardIds = {},
    data_list = {},
}

local objs =
{
    score_list_go   = { path = "root/Middle/ui_scroll_reward/Viewport/Content", type = "GameObject" },
    item_go         = { path = "root/template/reward_item", type = "GameObject" },
}

local command =
{
    on_click_back_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_back_btn()
        end
    },

    on_click_all_receive_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_all_receive_btn()
        end
    },

    on_click_receive_btn = 
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_receive_btn()
        end
    },
}

local hook =
{
    before_awake = function(vm)
        this.vm = vm
        this.gameObject = this.vm.behaviour.gameObject
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

function this.on_before_active()
    UITool.Parse(this.gameObject, this, objs)
    this.vm.data.text_score = tostring(BossDummy3Mgr.GetBossDummy3TotalScore())
    this.score_list         = UIListView.New(this.score_list_go.transform)
    this.set_score_list()
end

function this.on_before_deactive()
    this.score_list:Clear()
    UIListView.ClearItem("ActivityBossDummy3TotalScorePopupItem")
end

function this.set_score_list()
    this.score_list:Clear()
    data.data_list = {}
    data.allCanGetRewardIds = {}
    local arr = {}
    for i, v in ipairs(DataExHelper.Check_ConfigQuestEventByGroupId(4090)) do
        if v.eventType == 810 then
            table.insert(arr, v)
        end
    end
    table.sort(arr, function (a, b)
        return tonumber(a.id) < tonumber(b.id)
    end)

    local function f(config)
        print(config.Id)
    end

    for i, v in ipairs(arr) do
        local element = {}
        element.config  = v
        element.score   = v.progress
        element.callback = this.OnClickItemCallback
        
        local state = DataExHelper.Check_RewardState(v.id)
        if state == 1 then
            element.status = 1
        elseif state == 2 then
            element.status = 2
            table.insert(data.allCanGetRewardIds,v.id)
        elseif state == 3 then
            element.status = 3
        end

        local progressValue = 0
        if DataMgr.Player.quests[v.id] ~= nil then
            progressValue = DataMgr.Player.quests[v.id].progress
        end
        element.progress    = progressValue
        element.reward      = {}
        for _, v2 in ipairs(v.showReward) do
            local e = {}
            e.id        = v2.id
            e.count     = v2.count
            e.callback  = f
            table.insert(element.reward, e)
        end
        local goData = UIListData.GetData(this.item_go, "ActivityBossDummy3TotalScorePopupItem", element)
        table.insert(data.data_list, goData)
    end
    this.score_list:SetData(data.data_list, true)
end

this.OnClickItemCallback = function(element)
    print("on click item")
    if element.status == 1 then
        this.on_click_goto(element.config.id)
    elseif element.status == 2 then
        this.on_click_receive_btn(element.config.id)
    end
end

function this.on_click_all_receive_btn()
    this.receive_reward(data.allCanGetRewardIds)
end

function this.on_click_receive_btn(id)
    this.receive_reward({id})
end

function this.receive_reward(ids)
    print(#ids)
    if #ids <= 0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_25705"))
        return;
    end
    local askData = {questIds = ids}
    ApiMgr.Request("ex/get_award", askData, true, function(result)
        local re = json.decode(result)
        local data = json.encode(re.result)
        LuaMgr.ShowItemRewared(data)
        this.set_score_list()
        RedMgr.Singleton:SetRedState("16851_6", BossDummy3Mgr.GetTotalScoreRewardStatus())
    end, nil, true)
end

function this.on_click_goto(id)
    LuaMgr.HidePanel(UIName.ActivityBossDummy3TotalScorePopupViewModel)
    LuaMgr.ShowLuaPanel(UIName.ActivityBossDummy3StageBossBuffViewModel, "1005")
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossDummy3TotalScorePopupViewModel)
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)