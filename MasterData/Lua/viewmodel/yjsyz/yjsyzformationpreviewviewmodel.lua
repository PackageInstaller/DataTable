require("ViewModel/YJSYZ/YJSYZFormationPreviewItem")

local this =
{
    vm = nil,
    numbers = {},
    number_group_obj = nil,
    uiSpineCharacter = nil,
    team_item_go = nil,
    team_list_go = nil,
    team_list = nil,
    current_index = 1,
    min_index = 1,
    max_index = 2,
}

local data =
{
    text_point_rank = "",
    text_dungeon_name = "",
    monsterBodyPos = Vector3.zero,
    monsterBodyScale = Vector3.zero,
    monsterBodyPath = "",
    hp_bar_percent = 0.0,
    hp_bar_text = "",
}

local command =
{
    on_click_btn_fight =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_btn_fight()
        end
    },
    on_click_btn_reset =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_btn_reset()
        end
    },
    on_click_btn_prev =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_btn_prev()
        end
    },
    on_click_btn_next =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_btn_next()
        end
    },
    on_click_btn_enemy_detail =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_btn_enemy_detail()
        end
    },

}

local hook =
{
    before_awake = function(vm)
        this.vm = vm
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
    this.gameObject = this.vm.behaviour.gameObject
    this.current_index = this.min_index

    this.numbers = {}
    for i = 0, 9 do
        local e = this.gameObject.transform:Find("template/number/" .. i).gameObject
        table.insert(this.numbers, e)
    end
    this.number_group_obj = this.gameObject.transform:Find("root/Middle/Left/point/number_group").gameObject
    this.uiSpineCharacter = this.gameObject.transform:Find("root/Middle/Left/BossSpine/Body"):GetComponent("UISpineCharacter")
    this.team_item_go = this.gameObject.transform:Find("template/team").gameObject
    this.team_list_go = this.gameObject.transform:Find("root/Middle/Right/ui_scroll_team/Viewport/Content").gameObject
    this.team_list = UIListView.New(this.team_list_go.transform)

    local level_config = this.get_level_config()
    if level_config ~= nil and level_config.MonsterRes ~= nil then
        this.max_index = math.min(#level_config.MonsterRes, 5)
    end

    this.refresh_all()
end

function this.on_before_deactive()
    this.uiSpineCharacter:Clear()
    if this.team_list ~= nil then
        this.team_list:Clear()
    end
    UIListView.ClearItem("YJSYZFormationPreviewItem")
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
        this.vm.data.text_point_rank = LuaMgr.GetLangText("YJSYZFormationPreviewViewModel_0")
        return
    end

    this.vm.data.text_point_rank = LuaMgr.GetLangText("YJSYZFormationPreviewViewModel_1") .. tostring(point_rank) .. "%"
end

function this.on_click_btn_enemy_detail()
    LuaMgr.ShowLuaPanel(UIName.YJSYZEnemyDetailPanelViewModel, true)
end

function this.on_click_btn_fight()
    local floor_id = YJSYZHelper.get_current_team_tower_floor_id()
    if floor_id == "" then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("YJSYZFormationPreviewViewModel_2"))
        return
    end

    local level_config = this.get_level_config()
    if level_config == nil then
        return
    end

    ActivityBattlePrepareMgr.SetMembers(ActivityKey.YJSYZ, level_config.Dungeon)
    LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.YJSYZ)
end

function this.on_click_btn_reset()
    local team_list = YJSYZHelper.get_boss_tower_team_list()
    if team_list == nil or #team_list <= 0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("YJSYZFormationPreviewViewModel_3"))
        return
    end

    LuaMgr.ShowLuaPanel(UIName.YJSYZWarning2PopupViewModel, this.on_click_warning2_confirm)
end

function this.on_click_warning2_confirm()
    ApiMgr.Request("bossTower/resetBossTower", {}, true, function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.refresh_all()
        end
    end, nil, true)
end

function this.refresh_all()
    this.current_index = this.min_index
    this.set_numbers()
    this.set_text_point_rank()
    this.set_text_dungeon_name()
    this.set_rating()
    this.set_enemy_data(this.current_index)
    this.set_team_list()
end

function this.on_click_btn_prev()
    if this.current_index <= this.min_index then
        return
    end

    this.current_index = this.current_index - 1
    this.set_enemy_data(this.current_index)
end

function this.on_click_btn_next()
    if this.current_index >= this.max_index then
        return
    end

    this.current_index = this.current_index + 1
    this.set_enemy_data(this.current_index)
end

function this.set_enemy_data(index)
    this.current_index = index
    this.set_enemy_spine(index)
    this.set_enemp_hp(index)
    this.set_page_point(index)
end

function this.get_level_config()
    local floor_id = YJSYZHelper.get_current_team_tower_floor_id()
    if floor_id == "" then
        local floor_id_list = YJSYZHelper.get_team_floor_id_list()
        floor_id = floor_id_list[#floor_id_list]
    end

    return ConfigMgr.Config.TeamTowerFloorMap[tostring(floor_id)]
end

function this.set_enemy_spine(index)
    local level_config = this.get_level_config()
    if level_config == nil then
        this.uiSpineCharacter:Clear()
        return
    end

    local monster_res = nil
    if level_config.MonsterRes ~= nil then
        monster_res = level_config.MonsterRes[index]
    end

    if this.uiSpineCharacter ~= nil and monster_res ~= nil then
        this.uiSpineCharacter:Clear()
        local path = HeroManager.SetCharacterDrawing(this.uiSpineCharacter, monster_res, monster_res .. "01")
        if path ~= "" then
            this.vm.data.monsterBodyPath = path
        end
    end

    local x = 0
    local y = 0
    local scale = 1
    if level_config.Offset ~= nil then
        x = tonumber(level_config.Offset[1]) or 0
        y = tonumber(level_config.Offset[2]) or 0
        scale = tonumber(level_config.Offset[3]) or 1
    end

    this.vm.data.monsterBodyPos = Vector3(x, y, 0.0)
    this.vm.data.monsterBodyScale = Vector3(scale, scale, scale)
end

function this.set_enemp_hp(index)
    local level_config = this.get_level_config()
    if level_config == nil or level_config.BossHp == nil or level_config.BossHp[index] == nil then
        this.vm.data.hp_bar_percent = 0
        this.vm.data.hp_bar_text = "0.0%"
        return
    end

    local boss_hp_config = level_config.BossHp[index]
    local hex_uid = boss_hp_config[1]
    local total_hp = tonumber(boss_hp_config[2]) or 0
    local current_hp = tonumber(YJSYZHelper.get_boss_hp(hex_uid)) or 0

    local percent = 0
    if total_hp > 0 then
        percent = current_hp / total_hp
    end

    this.vm.data.hp_bar_percent = percent
    this.vm.data.hp_bar_text = string.format("%.1f%%", percent * 100)
end

function this.set_page_point(index)
    local level_config = this.get_level_config()
    local monster_count = 0
    if level_config ~= nil and level_config.MonsterRes ~= nil then
        monster_count = math.min(#level_config.MonsterRes, 5)
    end

    for i = 1, 5 do
        local point = this.vm.behaviour.transform:Find("root/Middle/Left/page_point/point" .. i)
        if point ~= nil then
            point.gameObject:SetActive(i <= monster_count)
        end
    end

    for i = 1, monster_count do
        local on = this.vm.behaviour.transform:Find("root/Middle/Left/page_point/point" .. i .. "/On")
        local off = this.vm.behaviour.transform:Find("root/Middle/Left/page_point/point" .. i .. "/Off")
        if on ~= nil then
            on.gameObject:SetActive(i == index)
        end
        if off ~= nil then
            off.gameObject:SetActive(i ~= index)
        end
    end
end

function this.set_team_list()
    if this.team_list == nil or this.team_item_go == nil then
        return
    end

    this.team_list:Clear()

    local list = YJSYZHelper.get_boss_tower_team_list()
    if list == nil then
        list = {}
    end

    local data_list = {}
    for i, v in ipairs(list) do
        local element = {}
        element.index = i
        element.score = v.score
        element.hero_list = v.hero_list
        element.buff_id = v.buff_id
        local data = UIListData.GetData(this.team_item_go, "YJSYZFormationPreviewItem", element)
        table.insert(data_list, data)
    end

    this.team_list:SetData(data_list, true)
end

function this.set_text_dungeon_name()
    local dungeon_id = YJSYZHelper.get_current_dungeon_id()
    if dungeon_id == nil or dungeon_id == "" then
        this.vm.data.text_dungeon_name = LuaMgr.GetLangText("YJSYZFormationPreviewViewModel_4")
        return
    end

    local dungeon_config = ConfigMgr.Config.dungeonMap[tostring(dungeon_id)]
    local dungeon_name = ""
    if dungeon_config ~= nil and dungeon_config.name ~= nil then
        dungeon_name = dungeon_config.name
    end

    this.vm.data.text_dungeon_name = LuaMgr.GetLangText("YJSYZFormationPreviewViewModel_5") .. dungeon_name
end

function this.set_rating()
    local rating = YJSYZHelper.get_rating()
    for i = 1, 7 do
        local rating_go = this.vm.behaviour.transform:Find("root/Middle/Left/rating/" .. i)
        if rating_go ~= nil then
            rating_go.gameObject:SetActive(i == rating)
        end
    end
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)