




require("ViewModel/Terminal/HeroGroupModel")
require("ViewModel/Terminal/HeroItemModel")
require("ViewModel/Terminal/MonsterGroupModel")
require("ViewModel/Terminal/MonsterTitleModel")
require("ViewModel/Terminal/MonsterItemModel")
require("ViewModel/Terminal/EquipGroupModel")
require("ViewModel/Terminal/EquipItemModel")
require("ViewModel/Terminal/CGTitleModel")
require("ViewModel/Terminal/CGGroupModel")
require("ViewModel/Terminal/CGItemModel")

local this = {
    vm = nil,
    curLabel = 0,
    animator = nil,
    labelType = { hero = 1, monster = 2, equip = 3, cg = 4 },
    curCount = 0,
    allCount = 0,
    scrollIsReset = true,
    scrollView = nil,
    itemTemplate = nil,
    groupTemplate = nil,
    tableInsert = table.insert,
    tableSort = table.sort,
    toNumber = tonumber,
    tableRemove = table.remove,
    totalWidth = 0,
    columnCount = 0,
    spaceX = 0,
    heroData = nil,
    m_activeConfig = nil,
    m_allConfig = nil,
    e_activeConfig = nil,
    e_allConfig = nil,
    c_activeConfig = nil,
    c_allConfig = nil,
    screenMap = nil,
    screenMapConfig = nil,
}

local data = {
    heroChoose = false,
    monsterChoose = false,
    equipChoose = false,
    cgChoose = false,
    cgRedPoint = false,
    countText = "",
    collectCheckmark = false,
    relicsShow = false,
    relicsCheckmark = false,
    emptyState = false,
    screenShow = false,
}

local command = {
    heroCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curLabel == this.labelType.hero then return end
            HeroParameter.EmptyTerminalMapParam()
            this.curLabel = this.labelType.hero
            this.SwitchLabel()
        end
    },
    monsterCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curLabel == this.labelType.monster then return end
            HeroParameter.EmptyTerminalMapParam()
            HeroParameter.EmptyTerminalMapList()
            this.scrollIsReset = true
            this.curLabel = this.labelType.monster
            this.SwitchLabel()
        end
    },
    equipCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curLabel == this.labelType.equip then return end
            HeroParameter.EmptyTerminalMapParam()
            HeroParameter.EmptyTerminalMapList()
            this.scrollIsReset = true
            this.curLabel = this.labelType.equip
            this.SwitchLabel()
        end
    },
    cgCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curLabel == this.labelType.cg then return end
            HeroParameter.EmptyTerminalMapParam()
            this.scrollIsReset = true
            this.curLabel = this.labelType.cg
            this.SwitchLabel()
        end
    },
    collectCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.scrollView.scrollRect:StopMovement()
            this.animator:Play("UI_CollectionMapPanel_01", 0, 0)
            this.vm.data.collectCheckmark = not this.vm.data.collectCheckmark
            this.scrollIsReset = true
            this.UpdateViewData()
        end
    },
    relicsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.relicsCheckmark = not this.vm.data.relicsCheckmark
            this.SwitchIconType()
        end
    },
    screenCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.CollectionScreenViewModel, this.screenMap, function(screenData)
                this.screenMap = screenData
                this.UpdateViewData()
            end)
        end
    },
    skinCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.MainShopPicPanel)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.animator = this.vm.behaviour.transform:Find("root/Middle"):GetComponent("Animator")
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/ScrollView").gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
        this.scrollView:Clear(false)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("HeroGroupModel")
        UIScrollView.ClearItem("MonsterGroupModel")
        UIScrollView.ClearItem("MonsterTitleModel")
        UIScrollView.ClearItem("EquipGroupModel")
        UIScrollView.ClearItem("CGGroupModel")
        UIScrollView.ClearItem("CGTitleModel")
        this = nil
    end,
}

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.CollectionAvatarClick, this.HeroClickEvent)
    LuaMgr.AddUIEventListener(UIEventConst.CollectionCGClick, this.CGClickEvent)
    LuaMgr.AddUIEventListener(UIEventConst.CGNetRewardRefush, this.UpdateCGConfig)
    LuaMgr.AddUIEventListener(UIEventConst.MonsterItemClick, this.MonsterClickEvent)
    LuaMgr.AddUIEventListener(UIEventConst.EquipItemClick, this.EquipClickEvent)
end
this.RemoveUIEvent = function()
    this.heroData = nil
    this.m_allConfig = nil
    this.m_activeConfig = nil
    this.e_allConfig = nil
    this.e_activeConfig = nil
    this.c_allConfig = nil
    this.c_activeConfig = nil
    this.screenMap = nil
    LuaMgr.RemoveUIEventListener(UIEventConst.CollectionAvatarClick, this.HeroClickEvent)
    LuaMgr.RemoveUIEventListener(UIEventConst.CollectionCGClick, this.CGClickEvent)
    LuaMgr.RemoveUIEventListener(UIEventConst.CGNetRewardRefush, this.UpdateCGConfig)
    LuaMgr.RemoveUIEventListener(UIEventConst.MonsterItemClick, this.MonsterClickEvent)
    LuaMgr.RemoveUIEventListener(UIEventConst.EquipItemClick, this.EquipClickEvent)
end


this.InitParameter = function()
    this.screenMap = nil
    this.screenMapConfig = nil
    this.curLabel = HeroParameter.label == nil and this.labelType.hero or HeroParameter.label
    this.SwitchLabel()
    this.InitCGRedPoint()
end

this.InitCGRedPoint = function()
    this.vm.data.cgRedPoint = PlayerCharacterMgr.CheckCGMap() > 0
end

this.SetHeroViewData = function()
    this.itemTemplate = this.vm.behaviour.transform:Find("template/HeroItem").gameObject
    this.groupTemplate = this.vm.behaviour.transform:Find("template/HeroGroup").gameObject
    this.curCount = 0
    this.scrollView:Clear(false)
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local tempList = this.GetHeroConfig()
    local index = 1
    this.heroData = {}
    while (index <= #tempList) do
        groupData = {}
        groupData.item = this.itemTemplate
        groupData.spaceX = this.spaceX
        groupData.hero = {}
        for i = 1, this.columnCount do
            if tempList[index + i - 1] ~= nil then
                if DataMgr.Player.characters[tempList[index + i - 1]] ~= nil then
                    this.curCount = this.curCount + 1
                end
                this.tableInsert(groupData.hero,
                    { id = tempList[index + i - 1], isRelics = this.vm.data.relicsCheckmark })
            end
        end
        this.tableInsert(this.heroData, groupData.hero)
        scrollData = UIScrollData.GetData(this.groupTemplate, "HeroGroupModel", this.totalWidth, 185 + 10, groupData)
        this.tableInsert(scrollDatas, scrollData)
        index = index + this.columnCount
    end
    this.scrollView:SetParams(this.totalWidth, 610)
    this.scrollView:SetData(scrollDatas, this.scrollIsReset)
end

this.SetMonsterViewData = function()
    this.itemTemplate = this.vm.behaviour.transform:Find("template/MonsterItem").gameObject
    this.groupTemplate = this.vm.behaviour.transform:Find("template/MonsterGroup").gameObject
    this.scrollView:Clear(false)
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    this.GetMonsterConfig()
    this.curCount = this.screenMap == nil and #this.m_activeConfig or #this.screenMapConfig
    local index = 1
    if (this.screenMap ~= nil) then
        while (index <= this.curCount) do
            groupData = {}
            groupData.item = this.itemTemplate
            groupData.spaceX = this.spaceX
            groupData.monster = {}
            for i = 1, this.columnCount do
                if this.screenMapConfig[index + i - 1] ~= nil then
                    this.tableInsert(groupData.monster, this.screenMapConfig[index + i - 1])
                end
            end
            scrollData = UIScrollData.GetData(this.groupTemplate, "MonsterGroupModel", this.totalWidth, 182 + 5,
                groupData)
            this.tableInsert(scrollDatas, scrollData)
            index = index + this.columnCount
        end
    elseif this.vm.data.collectCheckmark then
        while (index <= this.curCount) do
            groupData = {}
            groupData.item = this.itemTemplate
            groupData.spaceX = this.spaceX
            groupData.monster = {}
            for i = 1, this.columnCount do
                if this.m_activeConfig[index + i - 1] ~= nil then
                    this.tableInsert(groupData.monster, this.m_activeConfig[index + i - 1])
                end
            end
            scrollData = UIScrollData.GetData(this.groupTemplate, "MonsterGroupModel", this.totalWidth, 182 + 5,
                groupData)
            this.tableInsert(scrollDatas, scrollData)
            index = index + this.columnCount
        end
    else
        local titleTemplate = this.vm.behaviour.transform:Find("template/MonsterTitle").gameObject
        for i = #this.m_allConfig, 1, -1 do
            index = 1
            groupData = {}
            groupData.item = titleTemplate
            groupData.titleStr = ""
            if i - 1 == 0 then groupData.titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2202"].NameLan) end
            if i - 1 == 1 then groupData.titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2201"].NameLan) end
            if i - 1 == 2 then groupData.titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2200"].NameLan) end
            if i - 1 == 3 then groupData.titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2203"].NameLan) end
            if i - 1 == 4 then groupData.titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2199"].NameLan) end
            scrollData = UIScrollData.GetData(titleTemplate, "MonsterTitleModel", this.totalWidth, 44 + 5, groupData)
            this.tableInsert(scrollDatas, scrollData)
            while (index <= #this.m_allConfig[i]) do
                groupData = {}
                groupData.item = this.itemTemplate
                groupData.spaceX = this.spaceX
                groupData.monster = {}
                for j = 1, this.columnCount do
                    if this.m_allConfig[i][index + j - 1] ~= nil then
                        this.tableInsert(groupData.monster, this.m_allConfig[i][index + j - 1])
                    end
                end
                scrollData = UIScrollData.GetData(this.groupTemplate, "MonsterGroupModel", this.totalWidth, 182 + 5,
                    groupData)
                this.tableInsert(scrollDatas, scrollData)
                index = index + this.columnCount
            end
        end
    end
    this.scrollView:SetParams(this.totalWidth, 610)
    this.scrollView:SetData(scrollDatas, this.scrollIsReset)
end

this.SetEquipViewData = function()
    this.itemTemplate = this.vm.behaviour.transform:Find("template/EquipItem").gameObject
    this.groupTemplate = this.vm.behaviour.transform:Find("template/EquipGroup").gameObject
    this.scrollView:Clear(false)
    this.GetEquipConfig()
    this.curCount = #this.e_activeConfig
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local index = 1
    if this.vm.data.collectCheckmark then
        while (index <= this.curCount) do
            groupData = {}
            groupData.item = this.itemTemplate
            groupData.spaceX = this.spaceX
            groupData.equip = {}
            for i = 1, this.columnCount do
                if this.e_activeConfig[index + i - 1] ~= nil then
                    this.tableInsert(groupData.equip, this.e_activeConfig[index + i - 1])
                end
            end
            scrollData = UIScrollData.GetData(this.groupTemplate, "EquipGroupModel", this.totalWidth, 128 + 10, groupData)
            this.tableInsert(scrollDatas, scrollData)
            index = index + this.columnCount
        end
    else
        local titleTemplate = this.vm.behaviour.transform:Find("template/MonsterTitle").gameObject
        for i = #this.e_allConfig, 2, -1 do
            index = 1
            groupData = {}
            groupData.item = titleTemplate
            groupData.titleStr = ""
            if i == 2 then groupData.titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["12102"].NameLan) end
            if i == 3 then groupData.titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["12101"].NameLan) end
            if i == 4 then groupData.titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["12100"].NameLan) end
            if i == 5 then groupData.titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["12103"].NameLan) end
            scrollData = UIScrollData.GetData(titleTemplate, "MonsterTitleModel", this.totalWidth, 44 + 5, groupData)
            this.tableInsert(scrollDatas, scrollData)
            while (index <= #this.e_allConfig[i]) do
                groupData = {}
                groupData.item = this.itemTemplate
                groupData.spaceX = this.spaceX
                groupData.equip = {}
                for j = 1, this.columnCount do
                    if this.e_allConfig[i][index + j - 1] ~= nil then
                        this.tableInsert(groupData.equip, this.e_allConfig[i][index + j - 1])
                    end
                end
                scrollData = UIScrollData.GetData(this.groupTemplate, "EquipGroupModel", this.totalWidth, 128 + 10,
                    groupData)
                this.tableInsert(scrollDatas, scrollData)
                index = index + this.columnCount
            end
        end
    end
    this.scrollView:SetParams(this.totalWidth, 610)
    this.scrollView:SetData(scrollDatas, this.scrollIsReset)
end

this.SetCGViewData = function()
    this.itemTemplate = this.vm.behaviour.transform:Find("template/CGItem").gameObject
    this.groupTemplate = this.vm.behaviour.transform:Find("template/CGGroup").gameObject
    this.scrollView:Clear(false)
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    this.GetCGConfig()
    this.allCount = 0
    for i = 1, #this.c_allConfig do
        this.allCount = this.allCount + #this.c_allConfig[i]
    end
    this.curCount = #this.c_activeConfig
    local index = 1
    if this.vm.data.collectCheckmark then
        while (index <= this.curCount) do
            groupData = {}
            groupData.item = this.itemTemplate
            groupData.spaceX = this.spaceX
            groupData.cg = {}
            for i = 1, this.columnCount do
                if this.c_activeConfig[index + i - 1] ~= nil then
                    this.tableInsert(groupData.cg, this.c_activeConfig[index + i - 1])
                end
            end
            scrollData = UIScrollData.GetData(this.groupTemplate, "CGGroupModel", this.totalWidth, 200 + 15, groupData)
            this.tableInsert(scrollDatas, scrollData)
            index = index + this.columnCount
        end
    else
        local titleTemplate = this.vm.behaviour.transform:Find("template/CGTitle").gameObject
        for i = 1, #this.c_allConfig do
            index = 1
            groupData = {}
            groupData.item = titleTemplate
            groupData.titleStr = this.c_allConfig[i][1].source
            scrollData = UIScrollData.GetData(titleTemplate, "CGTitleModel", this.totalWidth, 44 + 10, groupData)
            this.tableInsert(scrollDatas, scrollData)
            while (index <= #this.c_allConfig[i]) do
                groupData = {}
                groupData.item = this.itemTemplate
                groupData.spaceX = this.spaceX
                groupData.cg = {}
                for j = 1, this.columnCount do
                    if this.c_allConfig[i][index + j - 1] ~= nil then
                        this.tableInsert(groupData.cg, this.c_allConfig[i][index + j - 1])
                    end
                end
                scrollData = UIScrollData.GetData(this.groupTemplate, "CGGroupModel", this.totalWidth, 200 + 15,
                    groupData)
                this.tableInsert(scrollDatas, scrollData)
                index = index + this.columnCount
            end
        end
    end
    this.scrollView:SetParams(this.totalWidth, 610)
    this.scrollView:SetData(scrollDatas, this.scrollIsReset)
end


this.SwitchLabel = function()
    this.scrollView.scrollRect:StopMovement()
    this.animator:Play("UI_CollectionMapPanel_01", 0, 0)

    this.vm.data.collectCheckmark = HeroParameter.label == nil and false or HeroParameter.collect
    this.vm.data.relicsShow = ConfigMgr.Config.constants.ArtifactsHidden ~= 1 and this.curLabel == this.labelType.hero
    this.vm.data.relicsCheckmark = HeroParameter.label == nil and false or HeroParameter.relics
    this.vm.data.screenShow = this.curLabel == this.labelType.monster

    this.vm.data.heroChoose = this.curLabel == this.labelType.hero

    this.vm.data.monsterChoose = this.curLabel == this.labelType.monster

    this.vm.data.equipChoose = this.curLabel == this.labelType.equip

    this.vm.data.cgChoose = this.curLabel == this.labelType.cg

    this.UpdateScreenSize()
    this.UpdateViewData()
    this.UpdateCountText()
end


this.SwitchIconType = function()
    for i = 1, #this.heroData do
        for j = 1, #this.heroData[i] do
            this.heroData[i][j].isRelics = this.vm.data.relicsCheckmark
        end
    end
    this.scrollView:Refresh()
end

this.UpdateViewData = function()
    local labelStr = nil
    if this.curLabel == this.labelType.hero then
        labelStr = "character"
        this.SetHeroViewData()
        this.vm.data.emptyState = this.vm.data.collectCheckmark and #this.GetHeroConfig() == 0
    elseif this.curLabel == this.labelType.monster then
        labelStr = "monster"
        this.SetMonsterViewData()
        this.vm.data.emptyState = (this.vm.data.collectCheckmark and #this.m_activeConfig == 0) or
            (this.screenMap ~= nil and #this.screenMapConfig == 0)
    elseif this.curLabel == this.labelType.equip then
        labelStr = "equip"
        this.SetEquipViewData()
        this.vm.data.emptyState = this.vm.data.collectCheckmark and #this.e_activeConfig == 0
    elseif this.curLabel == this.labelType.cg then
        labelStr = "cg"
        this.SetCGViewData()
        this.vm.data.emptyState = this.vm.data.collectCheckmark and #this.c_activeConfig == 0
    end
    this.vm.behaviour:UpdateTopBar(labelStr, this.OnBack)
end

this.UpdateScreenSize = function()
    this.totalWidth = 924 + LuaMgr.GetScreenAddWidth()
    if this.curLabel == this.labelType.hero then
        this.columnCount = math.floor(this.totalWidth / 160)
        this.spaceX = math.floor((this.totalWidth - (this.columnCount * 160)) / this.columnCount)
    elseif this.curLabel == this.labelType.monster then
        this.columnCount = math.floor(this.totalWidth / 156)
        this.spaceX = math.floor((this.totalWidth - (this.columnCount * 156)) / this.columnCount)
    elseif this.curLabel == this.labelType.equip then
        this.columnCount = math.floor(this.totalWidth / 128)
        this.spaceX = math.floor((this.totalWidth - (this.columnCount * 128)) / this.columnCount)
    elseif this.curLabel == this.labelType.cg then
        this.columnCount = LuaMgr.GetScreenAddWidth() <= 0 and 3 or math.floor(this.totalWidth / 312)
        this.spaceX = LuaMgr.GetScreenAddWidth() <= 0 and 0 or
            math.floor((this.totalWidth - (this.columnCount * 312)) / this.columnCount)
    end
end

this.UpdateCountText = function()
    this.vm.data.countText = LuaMgr.GetLangText("TerminalMapViewModel_0") .. this.curCount .. "</color>/" ..
        this.allCount
end

this.GetHeroConfig = function()
    this.allCount = 0
    local tempList = {}
    local sysTime = LuaMgr.Timestamp();
    for key, value in pairs(ConfigMgr.Config.characterTable) do
        if value.CharacterType == 1 and ConfigCharacterMgr.IsShow2(key, sysTime) then
            this.allCount = this.allCount + 1
            if this.vm.data.collectCheckmark then
                if DataMgr.Player.characters[key] ~= nil then
                    this.tableInsert(tempList, key)
                end
            else
                this.tableInsert(tempList, key)
            end
        end
    end
    this.tableSort(tempList, this.SortHero)
    return tempList
end

this.GetMonsterConfig = function()

    if this.m_activeConfig == nil then
        this.m_activeConfig = {}
        for key, value in pairs(ConfigMgr.Config.MonsterFileMap) do
            if FeatureManager.UnifyVerControls("monsterfile", value.AttributionType) then
                if this.MonsterWhetherActivate(value.MonsterSkin, value.Unlock) and this.ScreenMonster(value) then
                    value.unLock = true
                    this.tableInsert(this.m_activeConfig, value)
                end
            end
        end
        this.tableSort(this.m_activeConfig, this.SortMonster)
    end
    if this.m_allConfig == nil then
        this.m_allConfig = {}
        for key, value in pairs(ConfigMgr.Config.MonsterFileMap) do
            if FeatureManager.UnifyVerControls("monsterfile", value.AttributionType) and this.ScreenMonster(value) then
                if this.m_allConfig[value.Type + 1] == nil then
                    this.m_allConfig[value.Type + 1] = {}
                end
                value.unLock = this.MonsterWhetherActivate(value.MonsterSkin, value.Unlock)
                this.tableInsert(this.m_allConfig[value.Type + 1], value)
            end
        end
        for i = 1, #this.m_allConfig do
            this.tableSort(this.m_allConfig[i], this.SortMonster)
        end
    end
    this.allCount = 0
    for i = 1, #this.m_allConfig do
        for j = 1, #this.m_allConfig[i] do
            this.allCount = this.allCount + 1
        end
    end
    this.screenMapConfig = {}
    if (this.screenMap ~= nil) then
        for k, v in ipairs(this.m_activeConfig) do
            if (this.ScreenMonster(v)) then
                this.tableInsert(this.screenMapConfig, v)
            end
        end
    end
end
this.MonsterWhetherActivate = function(monsterSkin, conditions)
    local isActivate = false
    for i = 1, #conditions do
if conditions[i][1] == "1" then
            isActivate = this.toNumber(conditions[i][2]) <= DataMgr.Player.level
            return isActivate
        end
if conditions[i][1] == "2" then
            isActivate = DataMgr.Player.completedAreaEvents[conditions[i][2]] ~= nil
            return isActivate
        end
if conditions[i][1] == "3" then
            isActivate = DataMgr.Player.dungeonRecords[conditions[i][2]] ~= nil
            return isActivate
        end
if conditions[i][1] == "4" then
            local config = ConfigMgr.Config.monsterMap[monsterSkin]
            if config ~= nil then
                isActivate = DataMgr.Player.monsterModels[config.monsterModel] ~= nil
                return isActivate
            else
                return false
            end
        end
    end
    return isActivate
end

this.ScreenMonster = function(config)
    if (this.screenMap == nil) then
        return true
    end
    local monsterConfig = ConfigMgr.Config.monsterMap[config.MonsterSkin]
    local sameJob = this.screenMap.job == nil or this.screenMap.job == 0 or this.screenMap.job == monsterConfig.job
    local sameType = this.screenMap.type == nil or this.screenMap.type == 0 or this.screenMap.type == config.Type + 1
    local sameDamageType = this.screenMap.damageType == nil or this.screenMap.damageType == 0 or
        this.screenMap.damageType == config.DamageType
    local sameWeaknessType = this.screenMap.weaknessType == nil or this.screenMap.weaknessType == 0 or
        this.screenMap.weaknessType == config.WeaknessType
    local sameSpecialType = this.screenMap.specialType == nil or this.screenMap.specialType == 0
    if (sameSpecialType == false) then
        if config.SpecialEffect ~= "" and config.SpecialEffect ~= nil then
            local tagTab = NumTool.split(config.SpecialEffect, ",")
            for i = 1, #tagTab do
                if (this.screenMap.specialType == tonumber(tagTab[i])) then
                    sameSpecialType = true
                    break
                end
            end
        end
    end

    return sameJob and sameType and sameDamageType and sameWeaknessType and sameSpecialType
end

this.GetEquipConfig = function()
    this.allCount = ConfigHelper.GetTableLength(ConfigMgr.Config.equipments)
    if this.e_activeConfig == nil then
        this.e_activeConfig = {}
        for key, value in pairs(ConfigMgr.Config.equipments) do
            if DataMgr.Player.equipmentFiles[key] ~= nil then
                this.tableInsert(this.e_activeConfig, value)
            end
        end
        this.tableSort(this.e_activeConfig, this.SortEquip)
    end
    if this.e_allConfig == nil then
        this.e_allConfig = {}
        this.tableInsert(this.e_allConfig, {})
        for key, value in pairs(ConfigMgr.Config.equipments) do
            if this.e_allConfig[value.rare] == nil then
                this.e_allConfig[value.rare] = {}
            end
            this.tableInsert(this.e_allConfig[value.rare], value)
        end
        for i = 1, #this.e_allConfig do
            this.tableSort(this.e_allConfig[i], this.SortEquip)
        end
    end
end

this.GetCGConfig = function()
    if this.c_activeConfig == nil then
        this.c_activeConfig = {}
        local tempData = nil
        for i = 1, #ConfigMgr.Config.collectCGs do
            local isBanned = FeatureManager.UnifyVerControls("collectCG", ConfigMgr.Config.collectCGs[i].attributionType)
            if ConfigMgr.Config.collectCGs[i].collectOFF == 0 and isBanned then
                tempData = DataMgr.Player.collectCGMap[ConfigMgr.Config.collectCGs[i].id]
                if tempData.unlock or tempData.current >= tempData.target then
                    this.tableInsert(this.c_activeConfig, ConfigMgr.Config.collectCGs[i])
                end
            end
        end
    end
    if this.c_allConfig == nil then
        this.c_allConfig = {}
        local typeNum = 0
        for i = 1, #ConfigMgr.Config.collectCGs do
            local isBanned = FeatureManager.UnifyVerControls("collectCG", ConfigMgr.Config.collectCGs[i].attributionType)
            if ConfigMgr.Config.collectCGs[i].collectOFF == 0 and isBanned then
                typeNum = ConfigMgr.Config.collectCGs[i].source
                if this.c_allConfig[typeNum] == nil then
                    this.c_allConfig[typeNum] = {}
                end
                this.tableInsert(this.c_allConfig[typeNum], ConfigMgr.Config.collectCGs[i])
            end
        end
        local tempList, index = {}, 1
        for key, value in pairs(this.c_allConfig) do
            tempList[index] = value
            index = index + 1
        end
        this.c_allConfig = tempList
        this.tableSort(this.c_allConfig, this.SortCG)
        tempList, index = nil, nil
    end
end

this.HeroClickEvent = function(args)
    if HeroParameter.paramBool == false then
        local index = 0
        local itemList = {}
        local dataList = this.GetHeroConfig()
        for i = 1, #dataList do
            if DataMgr.Player.characters[dataList[i]] ~= nil then
                this.tableInsert(itemList, dataList[i])
            end
        end
        for i = 1, #itemList do
            if itemList[i] == args[0] then
                index = i
            end
        end
        HeroParameter.SaveListParam(nil, nil, nil, nil, index, itemList)
        itemList, index, dataList = nil, nil, nil
    else
        for i = 1, #HeroParameter.characterList do
            if HeroParameter.characterList[i] == args[0] then
                HeroParameter.characterIndex = i
            end
        end
    end
    this.scrollIsReset = false
    HeroParameter.SaveTerminalMapParam(this.curLabel, this.vm.data.relicsCheckmark, this.vm.data.collectCheckmark)
    HeroRedDataHelper.InitArchivesRedData(args[0])
    LuaMgr.ShowLuaPanel(UIName.HeroArchivesViewModel)
end

this.CGClickEvent = function(args)
    local cgId = args[0]
    for i = 1, #this.c_activeConfig do
        if this.c_activeConfig[i].id == cgId then
            LuaMgr.ShowLuaPanel(UIName.CGMapViewModel, i, this.c_activeConfig)
            break
        end
    end
end

this.MonsterClickEvent = function(args)
    if HeroParameter.terminalMapList == nil then
        local index = 0
        local tempList = {}
        for i = 1, #this.m_activeConfig do
            this.tableInsert(tempList, this.m_activeConfig[i].Id)
            if this.m_activeConfig[i].Id == args[0] then
                index = i
            end
        end
        HeroParameter.SaveTerminalMapList(tempList, index)
        tempList, index = nil, nil
    else
        for i = 1, #HeroParameter.terminalMapList do
            if HeroParameter.terminalMapList[i] == args[0] then
                HeroParameter.terminalMapIndex = i
                break
            end
        end
    end
    LuaMgr.ShowLuaPanel(UIName.MonsterMapViewModel)
end

this.EquipClickEvent = function(args)
    if HeroParameter.terminalMapList == nil then
        local index = 0
        local tempList = {}
        for i = 1, #this.e_activeConfig do
            this.tableInsert(tempList, this.e_activeConfig[i].id)
            if this.e_activeConfig[i].id == args[0] then
                index = i
            end
        end
        HeroParameter.SaveTerminalMapList(tempList, index)
        tempList, index = nil, nil
    else
        for i = 1, #HeroParameter.terminalMapList do
            if HeroParameter.terminalMapList[i] == args[0] then
                HeroParameter.terminalMapIndex = i
                break
            end
        end
    end
    LuaMgr.ShowLuaPanel(UIName.EquipMapViewModel)
end

this.UpdateCGConfig = function(args)
    if this.curLabel == this.labelType.cg then
        local type = args[0]
        if type == true then
            this.c_allConfig = nil
            this.c_activeConfig = nil
            this.GetCGConfig()
        end
        this.scrollView:Refresh()
        this.InitCGRedPoint()
    end
end

this.SortHero = function(item1, item2)
    return item1 < item2
end
this.SortMonster = function(item1, item2)
    return item1.Sequence < item2.Sequence
end
this.SortEquip = function(item1, item2)
    if item1.rare == item2.rare then
        return item1.id > item2.id
    else
        return item1.rare > item2.rare
    end
end
this.SortCG = function(item1, item2)
    if item1[1].source ~= item2[1].source then
        return item1[1].source < item2[1].source
    end
end

this.OnBack = function()
    HeroParameter.EmptyTerminalMapParam()
    HeroParameter.EmptyListParam()
    LuaMgr.Back()
end

return vm({
    data = data,
    command = command,
    hook = hook
})