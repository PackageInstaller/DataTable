local this = {
    vm = nil,
    curShowBuffGroupId = "",
    curShowBuffGroupLevel = 0,
    curShowBuffGroupMaxLevel = 0,
};

local data = {
    buffVMList = {
        { id = "", icon = DefaultSprite, name = "", level = "", select = false }
    },
    curShowBuffTexture = DefaultSprite,
    curShowBuffName = "",
    curShowBuffDesc = "",
    showBuffPreviewBtn = false,
    showBuffUpGradeBtn = false,
    showDelBtn = false,
    showAddBtn = false,
    buffUpGradeConsumeIcon = DefaultTexture,
    buffUpGradeConsumeNum = "",
    buffUpGradeStr = "",
}

local command = {
    buffItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            this.SetBuffInfo(this.vm.data.buffVMList[index].levelGroupId)
        end
    },
    delCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetBuffInfo(this.curShowBuffGroupId, this.curShowBuffGroupLevel - 1)
        end
    },
    addCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetBuffInfo(this.curShowBuffGroupId, this.curShowBuffGroupLevel + 1)
        end
    },
    buffUpGradeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local originLevel = MiniBattle3Mgr.GetBuffLevel(this.curShowBuffGroupId)
            local upGradeLevel = this.curShowBuffGroupLevel - originLevel
            MiniBattle3Mgr.UpGradeBuffLevel(this.curShowBuffGroupId, upGradeLevel, function()
                LuaMgr.ShowLuaPanel(UIName.MiniBattle3UpGradeSuccessPopup, this.curShowBuffGroupId, upGradeLevel)
                this.Refresh()
            end)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.Refresh()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.Refresh = function()
    this.SetBuffVMList()
    this.SetBuffInfo()
end

this.SetBuffVMList = function()
    local buffLevelCfgs = ConfigMgr.Config.DualBattleBuffLevelMap
    local tempList = {}
    for k, v in pairs(buffLevelCfgs) do
        local curLevel = MiniBattle3Mgr.GetBuffLevel(k)
        local curBuffId = v.GroupId[curLevel]
        local buffInfo = MiniBattle3Mgr.GetBuffCardInfo(curBuffId)
        local item = { 
            levelGroupId = k,
            icon = buffInfo.icon,
            name = buffInfo.name,
            level = string.format(LuaMgr.GetLangText("MiniBattle3CollectViewModel_0"), curLevel, #v.GroupId),
            select = false,
        }
        table.insert(tempList, item)
    end
    table.sort(tempList, function(a, b) return a.levelGroupId < b.levelGroupId end)
    this.vm.data.buffVMList = tempList
end

this.SetBuffInfo = function(buffGroupId, level)
    if IsNullOrEmpty(buffGroupId) then
        buffGroupId = this.vm.data.buffVMList[1].levelGroupId
    end
    this.curShowBuffGroupId = buffGroupId
    local originLevel = MiniBattle3Mgr.GetBuffLevel(buffGroupId)
    if level == nil then
        level = originLevel
    end
    local buffGroupCfg = ConfigMgr.Config.DualBattleBuffLevelMap[buffGroupId]
    local maxLevel = #buffGroupCfg.GroupId
    level = math.max(1, math.min(maxLevel, level))
    this.curShowBuffGroupLevel = level
    local buffInfo = MiniBattle3Mgr.GetBuffCardInfo(buffGroupCfg.GroupId[level])
    this.vm.data.buffUpGradeStr = LuaMgr.GetLangText("MiniBattle3CollectViewModel_1") .. level
    this.vm.data.curShowBuffTexture = buffInfo.icon
    this.vm.data.curShowBuffName = buffInfo.name
    this.vm.data.curShowBuffDesc = buffInfo.desc
    local isUp = level > originLevel
    this.vm.data.showBuffPreviewBtn = isUp
    this.vm.data.showBuffUpGradeBtn = isUp
    this.vm.data.showDelBtn = level > 1
    this.vm.data.showAddBtn = level < maxLevel
    if isUp then
        local cost = ConfigMgr.Config.constants.DualBattleCoin
        local item = DataMgr.Player.items[cost]
        local itemCount = item ~= nil and item.count0 or 0;
        local costCount = 0
        for i = originLevel + 1, level do
            costCount = costCount + buffGroupCfg.Cost[i - 1]
        end
        this.vm.data.buffUpGradeConsumeIcon = GetItemHomeIcon(cost)
        this.vm.data.buffUpGradeConsumeNum = string.format("<color=%s>%d</color>", itemCount >= costCount and "#c2b49d" or "#c31f36", costCount);
    end

    local len = #this.vm.data.buffVMList
    for i = 1, len do
        this.vm.data.buffVMList[i].select = this.vm.data.buffVMList[i].levelGroupId == this.curShowBuffGroupId
    end
end

this.OnBack = function()
    LuaMgr.Back();
end

return vm({
    data = data,
    command = command,
    hook = hook
})