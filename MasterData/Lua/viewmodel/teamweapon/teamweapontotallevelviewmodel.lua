local this = {
    vm = nil,
    curUnlockAttrIndex = "",
}

local data = {
    totalLevelStr = "",
    lineSizeDelta1 = Vector2.zero,
    lineSizeDelta2 = Vector2.zero,
    contentSizeDelta = Vector2.zero,
    upAttrList = {
        {
            attrId = "",
            attrIcon = DefaultSprite,
            attrDesc = "",
            level_1 = "",
            level_2 = "",
            level_3 = "",
            isCanClick = false,
            isLock = false,
            nodeAlpha = 1.0,
            effectActive_1 = false,
            effectActive_2 = false,
        }
    },
    downAttrList = {
        {
            attrId = "",
            level = 0,
            attrIcon = DefaultSprite,
            attrDesc = "",
            level_1 = "",
            level_2 = "",
            level_3 = "",
            isCanClick = false,
            isLock = false,
            nodeAlpha = 1.0,
            effectActive_1 = false,
            effectActive_2 = false,
        }
    },
}

local command = {
    totalAttrCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.TeamWeaponTotalLevelAttrPopup)
        end
    },
    upAttrNodeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            local attrData = this.vm.data.upAttrList[index]
            this.OnClickAttrItem(attrData)
        end
    },
    downAttrNodeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            local attrData = this.vm.data.downAttrList[index]
            this.OnClickAttrItem(attrData)
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
        this.curUnlockAttrIndex = ""
        this.SetData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil
    end
}

this.SetData = function()
    local totalLevel = TeamWeaponMgr.GetWeaponTotalLevel()
    local teamWeaponDatas = DataMgr.Player.TeamWeapons
    local allAttrStatusMap = DataMgr.Player.TeamWeaponAttribute
    local allAttrList = ConfigMgr.Config.TeamWeaponAllAttributes
    local talentMap = ConfigMgr.Config.talentBankMap

    local unLockCount = 0
    local upList = {}
    local downList = {}
    for i, v in ipairs(allAttrList) do
        local attrName, attrValue, attrType, iconName = ConfigHelper.GetAttrNameStr(v.Attribute)
        local attrData = {
            index = i,
            attrId = v.Attribute,
            level = v.Level,
            attrIcon = LuaMgr.GetSprite("AttributeIcon", iconName),
            attrDesc = string.format("%s+%d", attrName, attrValue),
            level_1 = tostring(math.max(v.Level - 10, 0)),
            level_2 = tostring(v.Level),
            level_3 = tostring(v.Level + 10),
            isCanClick = totalLevel >= v.Level and allAttrStatusMap[tostring(v.Level)] == nil,
            isLock = totalLevel < v.Level,
            nodeAlpha = totalLevel < v.Level and 0.6 or 1.0
        }
        attrData.effectActive_1 = attrData.isCanClick
        attrData.effectActive_2 = attrData.index == this.curUnlockAttrIndex
        if not attrData.isLock then
            unLockCount = unLockCount + 1
        end
        if i % 2 == 1 then
            table.insert(upList, attrData)
        else
            table.insert(downList, attrData)
        end
    end
    this.vm.data.upAttrList = upList
    this.vm.data.downAttrList = downList
    local nodeCount = #upList + #downList
    this.vm.data.lineSizeDelta1 = Vector2(unLockCount * 183, 16)
    this.vm.data.lineSizeDelta2 = Vector2(nodeCount * 183, 16)
    this.vm.data.contentSizeDelta = Vector2(math.max(1280, 250 + nodeCount * 183), 500)
    this.vm.data.totalLevelStr = tostring(totalLevel)
end

this.OnClickAttrItem = function(attrData)
    if attrData.isLock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TeamWeaponTotalLevelViewModel_0"))
        return
    end
    if attrData.isCanClick then
        this.curUnlockAttrIndex = attrData.index
        TeamWeaponMgr.UnlockTotalLevelAttrApi(attrData.level, this.SetData)
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})