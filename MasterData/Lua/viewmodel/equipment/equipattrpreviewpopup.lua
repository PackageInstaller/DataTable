





local this = {
    vm = nil,equipData = nil,attrConfig = nil,equipContent = nil,equipItem = nil,
}

local data = {
    attrScrollPos = 0.0,
    attrList = {{choose = false,attrName = ""}}
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.EquipAttrPreviewPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.equipContent = vm.behaviour.transform:Find("root/Middle/Equip")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
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


this.InitParameter = function()
    if this.vm.behaviour.Params.Length <= 0 then
        return
    end
    local equipId = this.vm.behaviour.Params[0]
    this.equipData = DataMgr.Player.equipments[equipId]
    if TableIsNull(this.equipData) then return end
    
    this.GetPreviewAttr()
    this.CreateAttr()
    this.CreateEquip()
end

this.GetPreviewAttr = function()
    local equipCfg = ConfigMgr.Config.equipments[this.equipData.equipmentId]
    this.attrConfig = {}
    for key,value in pairs(ConfigMgr.Config.additionalAttrs) do
        for i = 1, #value.job do
            if value.job[i] == equipCfg.job and 
                    ((equipCfg.rare == 2 and value.Rweight > 0) or
                    (equipCfg.rare == 3 and value.SRweight > 0) or
                    (equipCfg.rare == 4 and value.SSRweight > 0) or
                    (equipCfg.rare == 5 and value.URweight > 0)) then
                table.insert(this.attrConfig,value)
                break
            end
        end
    end
    table.sort(this.attrConfig,function(a, b) return a.id < b.id end)
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

this.CreateEquip = function()
    if this.equipItem == nil then
        this.equipItem = GoodsDataItem.New(this.equipContent)
    end
    local config = ConfigMgr.Config.equipments[this.equipData.equipmentId]
    local tempEquip = table.Copy(this.equipData)
    tempEquip.rare = config.rare
    this.equipItem:SetData(1, tempEquip, 2, false, Vector3.one)
end

return vm({
    data = data,
    command = command,
    hook = hook
})