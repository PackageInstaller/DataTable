





local this = {
    vm = nil,equipData = nil,equipJob = nil,callback = nil,attrConfig = nil,
    targetCount = nil,chooseAttrList = nil,chooseMaxCount = nil,
    equipContent = nil,equipItem = nil,
}

local data = {
    targetText = "",startBtnText = "",settingText = "",stopText = "",
    numText_1 = "",numText_2 = "",numText_3 = "",attrScrollPos = 0.0,
    toggle_1 = false,toggle_2 = false,toggle_3 = false,
    attrList = {{choose = false,attrName = ""}}
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.EquipTargetAttrPopup)
        end
    },
    attrCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = param + 1
            this.AddAttrList(index)
        end
    },
    toggleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local num = tonumber(param)
            if this.targetCount == num then return end
            if this.chooseMaxCount < num then
                local tipStr = ConfigMgr.LangGlobal("16140")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tipStr)
                return
            end
            this.targetCount = num
            this.UpdateToggle()
        end
    },
    startCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local length = ConfigHelper.GetTableLength(this.chooseAttrList)
            local tipStr = ""
            if length <= 0 then
                tipStr = ConfigMgr.LangGlobal("16134")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tipStr)
                return
            end
            if length < this.targetCount then
                tipStr = ConfigMgr.LangGlobal("16139")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tipStr)
                return
            end
            HeroParameter.SaveAttrTarget(this.chooseAttrList,this.targetCount)
            this.callback()
            LuaMgr.HidePanel(UIName.EquipTargetAttrPopup)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.equipContent = vm.behaviour.transform:Find("root/Middle/Equip")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.SetLanguageText()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        if this.equipItem ~= nil then
            this.equipItem:Clear()
            this.equipItem = nil
        end
        this.vm.data.attrList = {}
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.SetLanguageText = function()
    this.vm.data.targetText = ConfigMgr.LangGlobal("16120")
    this.vm.data.startBtnText = ConfigMgr.LangGlobal("16126")
    this.vm.data.settingText = ConfigMgr.LangGlobal("16121")
    this.vm.data.stopText = ConfigMgr.LangGlobal("16122")
    this.vm.data.numText_1 = ConfigMgr.LangGlobal("16123")
    this.vm.data.numText_2 = ConfigMgr.LangGlobal("16124")
    this.vm.data.numText_3 = ConfigMgr.LangGlobal("16125")
end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length <= 0 then
        return
    end
    local equipId = this.vm.behaviour.Params[0]
    this.equipData = DataMgr.Player.equipments[equipId]
    if TableIsNull(this.equipData) then return end
    
    this.callback = this.vm.behaviour.Params[1]
    if this.callback == nil then return end

    this.targetCount = 1
    this.chooseMaxCount = this.GetCanRefineAttrCount()
    this.chooseAttrList = {}
    this.UpdateToggle()
    
    this.equipJob = ConfigMgr.Config.equipments[this.equipData.equipmentId].job
    this.GetJobAttr()
    this.CreateAttr()
    this.CreateEquip()
end

this.UpdateToggle = function()
    this.vm.data.toggle_1 = this.targetCount == 1
    this.vm.data.toggle_2 = this.targetCount == 2
    this.vm.data.toggle_3 = this.targetCount == 3
end

this.CreateEquip = function()
    if this.equipItem == nil then
        this.equipItem = GoodsDataItem.New(this.equipContent)
    end
    local config = ConfigMgr.Config.equipments[this.equipData.equipmentId]
    local tempEquip = table.Copy(this.equipData)
    tempEquip.rare = config.rare
    this.equipItem:SetData(1, tempEquip, 2, false, Vector3.one)
end

this.CreateAttr = function()
    if TableIsNull(this.attrConfig) then return end
    local tempList,tempItem = {},nil
    local name = ""
    for i = 1, #this.attrConfig do
        if this.attrConfig[i].addAttr == "Hp_PERCENT" or this.attrConfig[i].addAttr == "Atk_PERCENT" then
            name = LuaMgr.GetLangText(this.attrConfig[i].NameLan)..ConfigMgr.LangGlobal("16108")
        else
            name = LuaMgr.GetLangText(this.attrConfig[i].NameLan)
        end
        tempItem = {choose = false,attrName = name,attrId = this.attrConfig[i].id}
        table.insert(tempList,tempItem)
    end
    this.vm.data.attrList = tempList
    this.vm.data.attrScrollPos = 1.0
end

this.AddAttrList = function(index)
    local attrId = this.vm.data.attrList[index].attrId
    if this.chooseAttrList[attrId] ~= nil then
        this.chooseAttrList[attrId] = nil
        this.vm.data.attrList[index].choose = false
    else
        this.chooseAttrList[attrId] = attrId
        this.vm.data.attrList[index].choose = true
    end
end

this.GetCanRefineAttrCount = function()
    local count = 0
    for i = 1, #this.equipData.additionalAttrs do
        if not this.equipData.additionalAttrs[i].lock then
            count = count + 1
        end
    end
    return count
end

this.GetJobAttr = function()
    this.attrConfig = {}
    for key,value in pairs(ConfigMgr.Config.additionalAttrs) do
        for i = 1, #value.job do
            if value.job[i] == this.equipJob then
                table.insert(this.attrConfig,value)
                break
            end
        end
    end
    table.sort(this.attrConfig,function(a, b) return a.id < b.id end)
end

return vm({
    data = data,
    command = command,
    hook = hook
})