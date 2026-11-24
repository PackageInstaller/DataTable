require("ViewModel/YJSYZ/YJSYZEnemyDetailEnhancedBuffItem")

local this =
{
    vm = nil,
}

local team_floor_id_list = {}
local buff_id_list = {}
local selectEnemyIndex = -1
local current_index = 1
local min_index = 1
local max_index = 10
local enemyIndex


local skillIndex
local skillList = {}

local normalColor = UnityEngine.Color(193 / 255, 192 / 255, 192 / 255)
local selectColor = UnityEngine.Color(38 / 255, 36 / 255, 41 / 255)

local CHARACTER_FORDER_PATH = "Assets/_BundleResources/Character/"

local objs =
{
    enhanced_buff_item_go = { path = "template/enhanced_buff", type = "GameObject" },
    enhanced_buff_list_go = { path = "root/Middle/Group/ui_scroll_enhanced_buff/Viewport/Content", type = "GameObject" },
}

local data = {
    enemyIcon = DefaultTexture,
    enemyBorder = DefaultSprite,
    enemyType = DefaultSprite,
    isEnemyType = false,
    enemyName = "",
    enemyZYIcon = DefaultSprite,

    groupSize = Vector2.zero,
    isHorizontal = false,


    enemyDatas = {{id = "", icon = DefaultTexture, border = DefaultSprite, type = DefaultSprite, isType = false,
                      name = "", isLight = false, color = UnityEngine.Color(1,1,1,1), isShow = false}},
    skills = {{ skillData = {id = "", icon = DefaultTexture, iconColor = normalColor, level = "", sname = "", isLevel = false,
                             isLock = false, isName = false, scale = Vector3.one, typeSp = DefaultSprite, isType = false,
                             isEx = false, isShow = false, isClick = false}}},
    page_text = "",
}

local command = {
    backCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.Back()
        end
    },
    enemyItemCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.SelectEnemy(param)
        end
    },
    on_click_btn_prev={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.on_click_btn_prev()
        end
    },
    on_click_btn_next={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.on_click_btn_next()
        end
    }
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.gameObject = this.vm.behaviour.gameObject
        UITool.Parse(this.gameObject, this, objs)
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
    this.vm.behaviour:UpdateTopBar("", this.OnBack)

    this.enhanced_buff_list = UIListView.New(this.enhanced_buff_list_go.transform)

    team_floor_id_list = YJSYZHelper.get_team_floor_id_list()
    max_index = #team_floor_id_list
    current_index = min_index
    selectEnemyIndex = -1

    this.set_data(current_index)
    local addWidth = LuaMgr.GetScreenAddWidth()
    this.vm.data.groupSize = Vector2(926 + (addWidth > 200 and 200 or addWidth), 419)
end

function this.on_before_deactive()
    if this.enhanced_buff_list ~= nil then
        this.enhanced_buff_list:Clear()
    end
    UIListView.ClearItem("YJSYZEnemyDetailEnhancedBuffItem")
    LuaMgr.RemoveTimer(TimerConst.BattlePrepareEnemys)


    LuaMgr.RemoveTimer(TimerConst.BattlePrepareEnemySkillDelay)
end

function this.on_click_btn_prev()
    if current_index <= min_index then
        return
    end
    current_index = current_index - 1
    this.set_data(current_index)
end

function this.on_click_btn_next()
    if current_index >= max_index then
        return
    end
    current_index = current_index + 1
    this.set_data(current_index)
end

function this.set_data(index)
    this.SetEnemys(index)
    selectEnemyIndex = -1
    this.SelectEnemy(0)
    this.set_buff_id_list(index)
    this.set_page_text(index)
end

function this.set_page_text(index)
    local team_floor_id = team_floor_id_list[index]
    local name = ""
    if team_floor_id ~= nil then
        local team_floor_config = ConfigMgr.Config.TeamTowerFloorMap[tostring(team_floor_id)]
        if team_floor_config ~= nil then
            local dungeon_config = ConfigMgr.Config.dungeonMap[tostring(team_floor_config.Dungeon)]
            if dungeon_config ~= nil and dungeon_config.name ~= nil then
                name = dungeon_config.name
            end
        end
    end

    this.vm.data.page_text = name
    return
end

function this.set_buff_id_list(index)
    buff_id_list = {}
    if this.enhanced_buff_list ~= nil then
        this.enhanced_buff_list:Clear()
    end

    local team_floor_id = team_floor_id_list[index]
    if team_floor_id == nil then
        return
    end

    buff_id_list = YJSYZHelper.get_dungeon_buff_data_list(team_floor_id)
    local data_list = {}
    for _, buff_data in ipairs(buff_id_list) do
        local element = {}
        element.buff_icon = buff_data.buff_icon
        element.buff_name_lan = buff_data.buff_name_lan
        element.buff_des_lan = buff_data.buff_des_lan
        local data = UIListData.GetData(this.enhanced_buff_item_go, "YJSYZEnemyDetailEnhancedBuffItem", element)
        table.insert(data_list, data)
    end

    if this.enhanced_buff_list ~= nil then
        this.enhanced_buff_list:SetData(data_list, true)
    end
end

this.SelectEnemy = function(index)
    if #this.vm.data.enemyDatas < 0 or selectEnemyIndex == index then
        return
    end
    local enemyData = this.vm.data.enemyDatas[index + 1]
    if enemyData == nil then
        return
    end

    if selectEnemyIndex ~= -1 then
        this.vm.data.enemyDatas[selectEnemyIndex + 1].isLight = false
        this.vm.data.enemyDatas[selectEnemyIndex + 1].color = normalColor
        selectEnemyIndex = -1
    end
    selectEnemyIndex = index
    this.vm.data.enemyDatas[selectEnemyIndex + 1].isLight = true
    this.vm.data.enemyDatas[selectEnemyIndex + 1].color = selectColor
    local monster = ConfigMgr.Config.monsterMap[this.vm.data.enemyDatas[selectEnemyIndex + 1].id]

    if monster == nil then
        return
    end

    this.SetInfo(monster)



    this.SetSkills(monster.id, monster.skills, 1, true);
    this.SetSkills(monster.id, monster.passiveskills, 2);
    if #this.vm.data.skills > 0 then
        skillIndex = 0
        this.vm.data.isHorizontal = false
        LuaMgr.AddTimer(TimerConst.BattlePrepareEnemySkillDelay, this.OnSkillDelay, 0.1, -1, true)
    end
end

this.OnSkillDelay = function()
    if skillIndex < #this.vm.data.skills then
        this.vm.data.skills[skillIndex + 1].skillData.isShow = true
        skillIndex = skillIndex + 1
        if skillIndex >= #this.vm.data.skills then
            this.vm.data.isHorizontal = true
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareEnemySkillDelay)
        end
    end
end

this.SetInfo = function(monster)
    local selectEnemyData = this.vm.data.enemyDatas[selectEnemyIndex + 1]
    this.vm.data.enemyIcon = selectEnemyData.icon
    this.vm.data.enemyBorder = selectEnemyData.border
    this.vm.data.enemyType = selectEnemyData.type
    this.vm.data.isEnemyType = selectEnemyData.isType
    this.vm.data.enemyName = selectEnemyData.name
    this.vm.data.enemyZYIcon = LuaMgr.GetSprite("JobIcon", "job_".. monster.job)

end


this.SetTags = function(tag)
    local tempList = {}
    if tag == nil or tag == "" then
        return
    end

    local tags = NumTool.split(tag, ';')
    for i, v in ipairs(tags) do
        local tagData = {
            content = string.format("<color=%s>%s</color>", "#c1c0c0", LuaMgr.GetLangText(v)),
            isShow = false
        }
        table.insert(tempList, tagData)
    end

    this.vm.data.tagDatas = tempList
    if #tempList > 0 then
        tagIndex = 0
        LuaMgr.AddTimer(TimerConst.BattlePrepareEnemyTagDelay, this.OnTagDelay, 0.1, -1, true)
    end
end

this.OnTagDelay = function()
    if tagIndex < #this.vm.data.tagDatas then
        this.vm.data.tagDatas[tagIndex + 1].isShow = true
        tagIndex = tagIndex + 1
        if tagIndex >= #this.vm.data.tagDatas then
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareEnemyTagDelay)
        end
    end
end


this.SetAttributes = function(attrRank)
    local tempList = {}
    local mainAttr = HeroMgr.GetMainAttrList()
    for index, attr in ipairs(mainAttr) do
        local attributeData = {
            name = LuaMgr.GetLangText(attr.NameLan),
            isShow = false
        }
        if #attrRank >= index then
            attributeData.evaluate = attrRank[index]
        else
            attributeData.evaluate = ""
        end
        table.insert(tempList, attributeData)
    end
    this.vm.data.attributeDatas = tempList
    if #tempList > 0 then
        attributeIndex = 0
        LuaMgr.AddTimer(TimerConst.BattlePrepareEnemyAttributeDelay, this.OnAttributeDelay, 0.1, -1, true)
    end
end

this.OnAttributeDelay = function()
    if attributeIndex < #this.vm.data.attributeDatas then
        this.vm.data.attributeDatas[attributeIndex + 1].isShow = true
        attributeIndex = attributeIndex + 1
        if attributeIndex >= #this.vm.data.attributeDatas then
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareEnemyAttributeDelay)
        end
    end
end


this.SetSkills = function(id, list, type, clear)
    if clear then
        skillList = {}
    end
    local tempList = skillList
    for i, item in ipairs(list) do
        if not ConfigSkillMgr.SkillShouldHide(item[1] .. item[2], type) then
            local skillItem = {
                skillData = {
                    type = SkillType.Monster,
                    targetId = id,
                    isClick = true,
                    showType = SkillShowType.BattlePrepare,
                    typeBool = false,
                    scale = Vector3(0.64, 0.64, 1),
                    isShow = false
                }
            }
            SkillHelper.SetSkill(skillItem.skillData, item[1], item[2], type, UnityEngine.Color.white, true, false, false)
            table.insert(tempList, skillItem)
        end
    end
    table.sort(tempList, function(a, b) return a.skillData.order < b.skillData.order end)
    this.vm.data.skills = tempList
    skillList = tempList
end

this.SetEnemys = function(index)
    local team_floor_id = team_floor_id_list[index]
    if team_floor_id == nil then
        this.vm.data.enemyDatas = {}
        return
    end

    local team_floor_config = ConfigMgr.Config.TeamTowerFloorMap[tostring(team_floor_id)]
    if team_floor_config == nil then
        this.vm.data.enemyDatas = {}
        return
    end

    local dungeon_id = team_floor_config.Dungeon
    local dungeonConfig = ConfigMgr.Config.dungeonMap[tostring(dungeon_id)]
    if dungeonConfig == nil then
        this.vm.data.enemyDatas = {}
        return
    end

    local str = LuaMgr.UpdateMonsterIdList(dungeonConfig.flowScript)
    local monsterConfigTable = json.decode(str) or {}

    local tempList = {}
    for i, v in ipairs(monsterConfigTable) do
        local monster = ConfigMgr.Config.monsterMap[v]
        if monster ~= nil and not monster.hideShowinfo then
            local enemyData = {
                id = monster.id,
                name = LuaMgr.GetLangText(monster.NameLan),
                icon = LuaMgr.GetTexture(CHARACTER_FORDER_PATH .. monster.monsterModel .. "/Avatar/" .. monster.monsterSkin .. ".png"),
                border = LuaMgr.GetSprite("CommonRes", monster.type == 2 and "ui_ty_txk_guaiwu_hong" or "ui_ty_txk_guaiwu_bai"),
                color = normalColor,
                isShow = false,
                isLight = false
            }
            if monster.type == 0 then
                enemyData.isType = false
            elseif monster.type == 1 then
                enemyData.type = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_zj")
                enemyData.isType = true
            elseif monster.type == 2 then
                enemyData.type = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_boss")
                enemyData.isType = true
            elseif monster.type == 3 then
                enemyData.type = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_jy")
                enemyData.isType = true
            end
            table.insert(tempList, enemyData)
        end
    end
    this.vm.data.enemyDatas = tempList
    if #tempList > 0 then
        enemyIndex = 0
        LuaMgr.RemoveTimer(TimerConst.BattlePrepareEnemys)
        LuaMgr.AddTimer(TimerConst.BattlePrepareEnemys, this.OnEnemys, 0.1)
    end
end

this.OnEnemys = function()
    if enemyIndex < #this.vm.data.enemyDatas then
        this.vm.data.enemyDatas[enemyIndex + 1].isShow = true
        enemyIndex = enemyIndex + 1
        if enemyIndex >= #this.vm.data.enemyDatas then
            LuaMgr.RemoveTimer(TimerConst.BattlePrepareEnemys)
        end
    end
end

function this.OnBack()
    LuaMgr.Back()
end

return vm({
    data = data,
    command = command,
    hook = hook
})