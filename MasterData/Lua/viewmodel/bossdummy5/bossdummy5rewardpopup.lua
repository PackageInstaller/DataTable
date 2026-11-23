require("ViewModel/BossDummy5/BossDummy5RewardPopupItem")

local this = {
    vm = nil,
}

local data = {
    text_score = "1",
    allCanGetRewardIds = {},
    data_list = {},
}

local objs = {
    score_list_go = { path = "root/Middle/ui_scroll_reward/Viewport/Content", type = "GameObject" },
    item_go = { path = "root/template/reward_item", type = "GameObject" },
    totalScoreRewardCheckMark = { path = "root/Middle/toggleGroup/reward1/Background/Checkmark", type = "GameObject" },
    singleScoreRewardCheckMark = { path = "root/Middle/toggleGroup/reward2/Background/Checkmark", type = "GameObject" },
    totalScoreRewardToggle = { path = "root/Middle/toggleGroup/reward1", type = "Toggle" },
}

local command = {
    on_click_back_btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_back_btn()
        end
    },

    on_click_all_receive_btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_all_receive_btn()
        end
    },

    on_click_receive_btn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_receive_btn()
        end
    },

    on_click_switch_toggle = {
        type = XLuaCommandType.Bool,
        execute = function(vm, isOn, param)
            if isOn then
                this.set_score_list(tonumber(param))
            end
        end
    },
}

local hook = {
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

    this.score_list = UIListView.New(this.score_list_go.transform)
    this.totalScoreRewardToggle.isOn = true;
    this.set_score_list(0);
end

function this.on_before_deactive()
    this.score_list:Clear()
    UIListView.ClearItem("BossDummy5RewardPopupItem")
end

function this.set_score_list(index)
    this.score_list:Clear()
    data.data_list = {}
    data.allCanGetRewardIds = {}
    local arr = {}
    local event = 0;
    if index == 0 then
        event = 810;
        SetActive(this.totalScoreRewardCheckMark,true)
        SetActive(this.singleScoreRewardCheckMark,false)
        this.vm.data.text_score = LuaMgr.GetLangText("BossDummy5RewardPopup_0") .. tostring(BossDummy5Mgr.GetBossDummy5TotalScore())
    elseif index == 1 then
        event = 842;
        SetActive(this.totalScoreRewardCheckMark,false)
        SetActive(this.singleScoreRewardCheckMark,true)
        this.vm.data.text_score = LuaMgr.GetLangText("BossDummy5RewardPopup_1") .. tostring(BossDummy5Mgr.GetBossDummy5TotalHighestScore())
    end
    for i, v in ipairs(DataExHelper.Check_ConfigQuestEventByEventType(4092,event)) do
        table.insert(arr, v)
    end
    table.sort(arr, function(a, b)
        return tonumber(a.id) < tonumber(b.id)
    end)

    local function f(config)
        print(config.Id)
    end

    for i, v in ipairs(arr) do
        local element = {}
        element.config = v
        element.score = v.progress
        element.callback = this.OnClickItemCallback

        local state = DataExHelper.Check_RewardState(v.id)
        if state == 1 then
            element.status = 1
            element.sort = 2
        elseif state == 2 then
            element.status = 2
            element.sort = 3
            table.insert(data.allCanGetRewardIds, v.id)
        elseif state == 3 then
            element.status = 3
            element.sort = 1
        end

        local progressValue = 0
        if DataMgr.Player.quests[v.id] ~= nil then
            progressValue = DataMgr.Player.quests[v.id].progress
        end
        element.progress = progressValue
        element.reward = {}
        for _, v2 in ipairs(v.showReward) do
            local e = {}
            e.id = v2.id
            e.count = v2.count
            e.callback = f
            table.insert(element.reward, e)
        end
        local goData = UIListData.GetData(this.item_go, "BossDummy5RewardPopupItem", element)
        table.insert(data.data_list, goData)
    end
    table.sort(data.data_list, function(a, b)
        if a.data.sort ~= b.data.sort then
            return a.data.sort > b.data.sort
        else
            return tonumber(a.data.config.id) < tonumber(b.data.config.id)
        end
        return 
    end)
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
    this.receive_reward(data.allCanGetRewardIds)
end

function this.receive_reward(ids)
    print(#ids)
    if #ids <= 0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_25705"))
        return ;
    end
    local askData = { questIds = ids }
    ApiMgr.Request("ex/get_award", askData, true, function(result)
        local re = json.decode(result)
        local data = json.encode(re.result)
        LuaMgr.ShowItemRewared(data)
        this.totalScoreRewardToggle.isOn = true;
        this.set_score_list(0);
        LuaMgr.InvokeUIEventListeners(UIEventConst.BossDummy5RedRefresh)
    end, nil, true)
end

function this.on_click_goto(id)
    LuaMgr.HidePanel(UIName.BossDummy5RewardPopup)













end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.BossDummy5RewardPopup)
end

return vm(
        {
            data = data,
            command = command,
            hook = hook
        }
)