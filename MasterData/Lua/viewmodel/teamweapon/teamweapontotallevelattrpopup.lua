local this = {
    vm = nil,
}

local data = {
    attrList = {
        {
            attrIcon = DefaultSprite,
            name = "",
            value_1 = "",
            value_2 = "",
            groupActive = false,
        }
    }
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamWeaponTotalLevelAttrPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.SetData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if this.coroutine_key ~= nil then
            coroutine_runner.stop(this.coroutine_key)
        end
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.SetData = function()
    local totalLevel = TeamWeaponMgr.GetWeaponTotalLevel()
    local teamWeaponDatas = DataMgr.Player.TeamWeapons
    local allAttrStatusMap = DataMgr.Player.TeamWeaponAttribute
    local allAttrList = ConfigMgr.Config.TeamWeaponAllAttributes
    local talentMap = ConfigMgr.Config.talentBankMap
    local tempList = {}
    local attrValueMap = {}
    for i, v in ipairs(allAttrList) do
        local attrId = v.Attribute
        if totalLevel >= v.Level and allAttrStatusMap[tostring(v.Level)] ~= nil then
            local attrName, attrValue, attrType, iconName = ConfigHelper.GetAttrNameStr(attrId)
            if attrValueMap[attrId] == nil then
                attrValueMap[attrId] = {
                    attrId = attrId,
                    name = attrName,
                    iconName = iconName,
                    value = attrValue,
                }
            else
                attrValueMap[attrId].value = tonumber(attrValueMap[attrId].value)  + tonumber(attrValue)
            end
        end
    end
    for k, v in pairs(attrValueMap) do
        local attrData = {
            attrId = v.attrId,
            name = v.name,
            attrIcon = LuaMgr.GetSprite("AttributeIcon", v.iconName),
            value_1 = "",
            value_2 = tostring(v.value),
            groupActive = false,
        }
        table.insert(tempList, attrData)
    end
    this.vm.data.attrList = tempList

    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    this.coroutine_key = coroutine_runner.start(function()
        for i = 1, #this.vm.data.attrList do
            this.vm.data.attrList[i].groupActive = true
            coroutine_runner.wait(0.05)
        end
    end)
end

return vm(
        {
            data = data,
            command = command,
            hook = hook
        }
)