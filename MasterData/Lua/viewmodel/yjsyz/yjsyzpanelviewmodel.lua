local this =
{
    vm = nil,
    numbers = {},
    number_group_obj = nil,
}

local data =
{
    text_time = "",
    text_point_rank = "",
    text_dungeon_name = "",
    text_collect = "",
}

local command =
{
    on_click_fight_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_fight_btn()
        end
    },
    on_click_assist_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_assist_btn()
        end
    },
    on_click_enemy_detail_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_enemy_detail_btn()
        end
    },
    on_click_collection_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_collection_btn()
        end
    },
    on_click_reward_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_reward_btn()
        end
    },
    on_click_rank_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_rank_btn()
        end
    },

}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.YJSYZPanelViewModel)
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

function this.on_before_active()
    this.vm.behaviour:UpdateTopBar("", this.OnBack)
    this.gameObject = this.vm.behaviour.gameObject

    this.numbers = {}
    for i = 0, 9 do
        local e = this.gameObject.transform:Find("template/number/" .. i).gameObject
        table.insert(this.numbers, e)
    end
    this.number_group_obj = this.gameObject.transform:Find("root/Middle/point/number_group").gameObject

    this.set_text_time()
    this.set_numbers()
    this.set_text_point_rank()
    this.set_text_dungeon_name()
    this.set_text_collect()

    LuaMgr.RemoveTimer(TimerConst.YJSYZPanelTimer)
    LuaMgr.AddTimer(TimerConst.YJSYZPanelTimer, this.set_text_time, 60, -1, true)

    HeroRedDataHelper.CheckYJSYZRed()
end

function this.on_before_deactive()
    LuaMgr.RemoveTimer(TimerConst.YJSYZPanelTimer)
end

function this.set_numbers()
    local num = YJSYZHelper.get_max_score()

    if this.number_group_obj == nil or this.numbers == nil then
        return
    end

    local parent = this.number_group_obj.transform
    for i = parent.childCount - 1, 0, -1 do
        LuaMgr.DestroyImmediateGO(parent:GetChild(i).gameObject)
    end

    local num_str = tostring(num or 0)
    for i = 1, string.len(num_str) do
        local char = string.sub(num_str, i, i)
        local number = tonumber(char)
        if number ~= nil and this.numbers[number + 1] ~= nil then
            local obj = LuaMgr.InstantiateGO(this.numbers[number + 1], parent, false)
            obj.transform:SetSiblingIndex(i - 1)
            obj:SetActive(true)
        end
    end
end

function this.set_text_point_rank()
    local point_rank = YJSYZHelper.get_rank()
    if point_rank <= 0 then
        this.vm.data.text_point_rank = LuaMgr.GetLangText("YJSYZPanelViewModel_0")
        return
    end

    this.vm.data.text_point_rank = LuaMgr.GetLangText("YJSYZPanelViewModel_1") .. tostring(point_rank) .. "%"
end

function this.set_text_time()
    this.vm.data.text_time = YJSYZHelper.get_time_left_str()
end

function this.set_text_dungeon_name()
    local dungeon_id = YJSYZHelper.get_current_dungeon_id()
    if dungeon_id == "" or dungeon_id == nil then
        this.vm.data.text_dungeon_name = LuaMgr.GetLangText("YJSYZPanelViewModel_2")
        return
    end

    local dungeon_config = ConfigMgr.Config.dungeonMap[tostring(dungeon_id)]
    local dungeon_name = ""
    if dungeon_config ~= nil and dungeon_config.name ~= nil then
        dungeon_name = dungeon_config.name
    end

    this.vm.data.text_dungeon_name = LuaMgr.GetLangText("YJSYZPanelViewModel_3") .. dungeon_name
end

function this.set_text_collect()
    local finishMedalCount1 = DataExHelper.GetMedalFinishCount("5170")
    local medalList1 = DataExHelper.GetMedalList("5170")
    local totalFinishMedalCount = finishMedalCount1
    local medalList = {}
    for _, value in pairs(medalList1) do
        table.insert(medalList, value)
    end

    this.vm.data.text_collect = LuaMgr.GetLangText("YJSYZPanelViewModel_4") .. "(" .. tostring(totalFinishMedalCount) .. "/" .. tostring(#medalList) .. ")"
end

function this.on_click_fight_btn()
    LuaMgr.ShowLuaPanel(UIName.YJSYZFormationPreviewViewModel)
end

function this.on_click_assist_btn()
    LuaMgr.ShowLuaPanel(UIName.YJSYZAssistPopupViewModel)
end

function this.on_click_enemy_detail_btn()
    LuaMgr.ShowLuaPanel(UIName.YJSYZEnemyDetailPanelViewModel)
end

function this.on_click_collection_btn()
    LuaMgr.ShowLuaPanel(UIName.YJSYZCollectPopupViewModel)
end

function this.on_click_reward_btn()
    LuaMgr.ShowLuaPanel(UIName.YJSYZRewardPopupViewModel)
end

function this.on_click_rank_btn()
    if DataMgr.Player.guildData == nil or DataMgr.Player.guildData.guildId == "" then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("YJSYZPanelViewModel_6"))
        return
    end

    if YJSYZHelper.has_rank_data_cache() then
        LuaMgr.ShowLuaPanel(UIName.YJSYZGuildRankingPanelViewModel)
        return
    end

    ApiMgr.Request("bossTower/getRankList", {}, true, function(result)
        local re = json.decode(result)
        if re.code == 0 then
            YJSYZHelper.set_rank_data(re.result.List)
            LuaMgr.ShowLuaPanel(UIName.YJSYZGuildRankingPanelViewModel)
        end
    end, nil, true)
end

function this.OnBack()
    if this.entry ~= nil and DataExHelper.CommonActivityCheck(ActivityKey.YJSYZ) then
        LuaMgr.Back(ActivityKey.YJSYZ)
    else
        LuaMgr.Back()
    end
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)