require("ViewModel/Rogue/RogueBuffItem")

local this = {
    vm = nil,
    buffList = {},
    chooseBuffMap = {},
    buffScrollView = nil,
    buffItemTemplate = nil,
}

local data = {
    curScore = "",
    buffLevel="",
}

local command = {
    clearCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.chooseBuffMap = {}
            for i, v in ipairs(this.buffList) do
                v.Level = 0
                v.BuffInfo = this.GetBuffInfoByLevel(v.Id, v.Level)
            end
            this.Refresh()
        end
    },
    startCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local chooseBuffIdList = {}
            for i, v in ipairs(this.buffList) do
                if v.Level > 0 and v.BuffInfo ~= nil then
                    table.insert(chooseBuffIdList, v.BuffInfo.BuffId)
                end
            end
            RogueMgr.DefaultBuffList = chooseBuffIdList
            RogueMgr.ChooseTeamId = -1
            LuaMgr.ShowLuaPanel(UIName.RogueTeamViewModel)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.buffScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/ScrollView/ScrollView").gameObject)
        this.buffItemTemplate = vm.behaviour.transform:Find("template/BuffItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.InitBuffList()
        this.Refresh()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil
        UIScrollView.ClearItem("RogueBuffItem")
    end,
}

this.Refresh = function()
    this.SetBuffScrollView()
    this.RefreshScrollView()
end

this.InitBuffList = function()
    this.buffList = {}
    this.chooseBuffMap = {}
    local chooseBuffList = {}
    if not TableIsNull(RogueMgr.DefaultBuffList) then
        chooseBuffList = RogueMgr.DefaultBuffList
    elseif not IsNull(DataMgr.Player.Rogue.GlobalBuffIds) then
        chooseBuffList = DataMgr.Player.Rogue.GlobalBuffIds
    end
    for i, v in ipairs(chooseBuffList) do
        this.chooseBuffMap[v] = 1
    end
    
    local allBuffCfgs = ConfigMgr.Config.RogueBuffs
    for i, v in ipairs(allBuffCfgs) do
        local buffData = {
            Id = v.Id,
            Level = this.GetBuffGroupLevel(v.GroupBuff),
            MaxLevel = v.Initial
        }

        buffData.BuffInfo = this.GetBuffInfoByLevel(buffData.Id, buffData.Level)
        table.insert(this.buffList, buffData)
    end
end

this.SetBuffScrollView = function()
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local len = #this.buffList
    for i = 1, #this.buffList do
        groupData = this.buffList[i]
        groupData.index = i
        groupData.onClickAdd = this.AddBuffLevel
        groupData.onClickDel = this.DelBuffLevel
        scrollData = UIScrollData.GetData(this.buffItemTemplate, "RogueBuffItem", 1180, 85, groupData)
        table.insert(scrollDatas, scrollData)
    end

    this.buffScrollView:Clear(false)
    this.buffScrollView:SetPadding(0, 0, 0, 0)
    this.buffScrollView:SetParams(1228, 432)
    this.buffScrollView:SetData(scrollDatas, true)
end

this.RefreshScrollView = function()
    this.buffScrollView:Refresh()
    local scoreValue=this.GetTotalScore();
    this.vm.data.buffLevel=this.GetBuffLevel();
    this.vm.data.curScore =(scoreValue == 0 and "0" or string.format("%.d",math.floor(scoreValue/100))) .. "%";
end

this.GetBuffLevel=function()
    local level=0;
    for i, v in ipairs(this.buffList) do
        if v.Level > 0 then
            level=level+v.Level
        end
    end
    return level;
end

this.GetTotalScore = function()
    local totalScore = 0
    for i, v in ipairs(this.buffList) do
        totalScore = totalScore + v.BuffInfo.Score
    end
    return totalScore
end

this.AddBuffLevel = function(index)
    local buffData = this.buffList[index]
    local curLevel = buffData.Level
    if curLevel == buffData.MaxLevel then
        return
    end
    buffData.Level = curLevel + 1
    buffData.BuffInfo = this.GetBuffInfoByLevel(buffData.Id, buffData.Level)
    this.RefreshScrollView()
end

this.DelBuffLevel = function(index)
    local buffData = this.buffList[index]
    local curLevel = buffData.Level
    if curLevel == 0 then
        return
    end
    buffData.Level = curLevel - 1
    buffData.BuffInfo = this.GetBuffInfoByLevel(buffData.Id, buffData.Level)
    this.RefreshScrollView()
end

this.GetBuffGroupLevel = function(buffGroup)
    local level = 0
    if not TableIsNull(buffGroup) then
        for j, buffID in ipairs(buffGroup) do
            if this.chooseBuffMap[buffID] ~= nil then
                level = j
                break
            end
        end
    end
    return level
end

this.GetBuffInfoByLevel = function(buffGroupId, level)
    local buffInfo = nil
    local buffGroupCfg = this.GetBuffGroupConfig(buffGroupId)
    if buffGroupCfg ~= nil then
        local tempLevel = level == 0 and 1 or level
        local buffId = buffGroupCfg.GroupBuff[tempLevel]
        buffInfo = this.GetBuffNameAndDesc(buffId)
        buffInfo.Score = 0
        buffInfo.AttrStr = LuaMgr.GetLangText("RogueBuffViewModel_0")
        if level > 0 then
            buffInfo.Score = buffGroupCfg.Credit[level]
            if TableIsNull(buffGroupCfg.Percentage) or #buffGroupCfg.Percentage < level then
                buffInfo.AttrStr = ""
            else
                local addAttrNum = buffGroupCfg.Percentage[level]
                local addAttrType = buffGroupCfg.Type
                if addAttrNum ~= nil then
                    buffInfo.AttrStr = tostring(addAttrNum)
                    if addAttrType == 2 then
                        buffInfo.AttrStr = buffInfo.AttrStr .. "%"
                    end
                end
            end
        end
    end
    return buffInfo
end

this.GetBuffGroupConfig = function(buffGroupId)
    local buffGroupCfg = nil
    local buffGroupCfgs = ConfigMgr.Config.RogueBuffs
    for i, v in ipairs(buffGroupCfgs) do
        if v.Id == buffGroupId then
            buffGroupCfg = v
            break
        end
    end
    return buffGroupCfg
end

this.GetBuffNameAndDesc = function(buffId)
    local re = {
        BuffId = buffId,
        Icon = DefaultSprite,
        Desc = "",
        Name = "",
    }
    local buffConfig = ConfigMgr.Config.RogueBuffDescMap[buffId]
    if buffConfig ~= nil then
        re.Icon = LuaMgr.GetSprite("BuffIcon", buffConfig.BuffIcon)
        re.Desc = LuaMgr.GetLangText(buffConfig.BuffDesLan)
        re.Name = LuaMgr.GetLangText(buffConfig.BuffNameLan);
    end
    return re
end

return vm({
    data = data,
    command = command,
    hook = hook
})