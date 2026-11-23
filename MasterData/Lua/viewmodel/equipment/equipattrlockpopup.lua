





local this = {
    vm = nil,equipData = nil,lockCount = nil,chooseAttrList = nil,
    materialCount = nil,equipContent = nil,equipItem = nil,isMaterial = false,
}

local data = {
    costIcon = DefaultTexture,costCount = "",lockBtnText = "",costObj = false,
    attrList = {{lock = false,attrName = "",attrValue = "",attrIcon = DefaultSprite,animName = ""}},
    costAnim = "",
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.EquipAttrLockPopup)
        end
    },
    attrCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = param + 1
            local tipStr = ""
            local lockState = this.vm.data.attrList[index].lockState
            local lockObj = this.vm.data.attrList[index].lock
            if this.lockCount + #this.chooseAttrList >= ConfigMgr.Config.equipConstants.LockLimit and not lockObj then
                tipStr = ConfigMgr.LangGlobal("16135")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tipStr)
                return
            end
            if lockState then
                tipStr = ConfigMgr.LangGlobal("16136")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tipStr)
                return
            end
            this.AddAttrList(index)
        end
    },
    lockCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.lockCount >= ConfigMgr.Config.equipConstants.LockLimit then
                tipStr = ConfigMgr.LangGlobal("16135")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tipStr)
                return
            end
            if TableIsNull(this.chooseAttrList) then
                local tipStr = ConfigMgr.LangGlobal("16134")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tipStr)
                return
            end
            if not this.isMaterial then
                local tipStr = ConfigMgr.LangGlobal("16110")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tipStr)
                return
            end
            local mas1 = string.format(ConfigMgr.LangGlobal("16119"),this.materialCount)
            local mas2 = ConfigMgr.LangGlobal("16114")
            local mas3 = ConfigMgr.LangGlobal("16138")
            local goodsId = ConfigMgr.Config.equipConstants.LockItem[1][1]
            LuaMgr.ShowPanel(UIName.ConfirmImageTextViewModel, goodsId, mas1, mas2, mas3,function()
                this.SendLockAttr()
            end,nil)
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
    this.vm.data.lockBtnText = ConfigMgr.LangGlobal("16114")
end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length <= 0 then
        return
    end
    local equipId = this.vm.behaviour.Params[0]
    this.equipData = DataMgr.Player.equipments[equipId]
    if TableIsNull(this.equipData) then
        return
    end
    this.materialCount = 0
    this.chooseAttrList = {}
    this.CreateEquip()
    this.CreateAttr()
    this.vm.data.costObj = false
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
    if not TableIsNull(this.equipData.additionalAttrs) then
        this.lockCount = 0
        local tempList,tempItem = {},nil
        local attrData = nil
        local iconSprite = nil
        local attrDes = nil
        local dataJson = json.encode(this.equipData)
        attrData = json.decode(LuaMgr.GetEquipPropertyCopy(dataJson))
        for i = 1, #this.equipData.additionalAttrs do
            if this.equipData.additionalAttrs[i].lock then
                this.lockCount = this.lockCount + 1
            end
            attrDes = ConfigMgr.Config.additionalAttrs[this.equipData.additionalAttrs[i].id]
            iconSprite = LuaMgr.GetSprite("AttributeIcon",attrDes.addAttr)
            tempItem = {lock = this.equipData.additionalAttrs[i].lock,attrName = LuaMgr.GetLangText(attrDes.NameLan),
                        attrValue = attrData[attrDes.addAttr]..attrDes.attrDisplayType,attrIcon = iconSprite,
                        lockState = this.equipData.additionalAttrs[i].lock,attrId = attrDes.id,animName = "ani_EquipAttrLockPopup_afterattritem_001"}
            table.insert(tempList,tempItem)
        end
        this.vm.data.attrList = tempList
    end
end

this.SetMaterial = function()
    local material = ConfigMgr.Config.equipConstants.LockItem
    local goods = ConfigMgr.Config.itemMap[material[1][1]]
    if TableIsNull(goods) then return end
    this.vm.data.costIcon = LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(goods.id))
    this.materialCount = 0
    if #this.chooseAttrList > 0 then
        local num = this.lockCount + #this.chooseAttrList
        for i = this.lockCount + 1, num do
            this.materialCount = this.materialCount + tonumber(material[i][2])
        end
    end
    this.vm.data.costObj = this.materialCount > 0 and this.lockCount < ConfigMgr.Config.equipConstants.LockLimit
    if this.materialCount > 0 then
        this.isMaterial = true
        local haveCount = DataHelper.GetItemCountById(goods.id)
        if haveCount < this.materialCount then
            this.isMaterial = false
            this.vm.data.costCount = "<color=#FF4747>"..this.materialCount.."</color>"
        else
            this.vm.data.costCount = this.materialCount
        end
        this.vm.data.costAnim = "ani_EquipAttrLockPopup_root_change"
    end
end

this.AddAttrList = function(index)
    local attrId = this.vm.data.attrList[index].attrId
    local attIndex = -1
    for i = 1, #this.chooseAttrList do
        if this.chooseAttrList[i] == attrId then
            attIndex = i
            break
        end
    end
    if attIndex ~= -1 then
        table.remove(this.chooseAttrList,attIndex)
        this.vm.data.attrList[index].lock = false
    else
        table.insert(this.chooseAttrList,attrId)
        this.vm.data.attrList[index].lock = true
        this.vm.data.attrList[index].animName = "ani_EquipAttrLockPopup_afterattritem_002"
    end
    this.SetMaterial()
end

this.SendLockAttr = function()
    local tempData = {}
    tempData["id"] = this.equipData.id
    tempData["attrs"] = this.chooseAttrList
    ApiMgr.Request("equipment/attr/lock",tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            if not this.equipData.locking then
                this.SendLockEquip()
            else
                this.LockComplete()
            end
        end
    end,nil,true)
end


this.SendLockEquip = function()
    local tempData = {}
    tempData["id"] = this.equipData.id
    ApiMgr.Request("equipment/lock",tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.LockComplete()
        end
    end,nil,true)
end

this.LockComplete = function()
    local tipStr = ConfigMgr.LangGlobal("16137")
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tipStr)
    this.chooseAttrList = {}
    LuaMgr.InvokeUIEventListeners(UIEventConst.EquipAttrLockEvent)
    LuaMgr.HidePanel(UIName.EquipAttrLockPopup)
end

return vm({
    data = data,
    command = command,
    hook = hook
})