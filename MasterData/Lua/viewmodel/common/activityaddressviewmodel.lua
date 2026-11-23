




local this = {vm = nil}
local nameBool = false
local nameInputField = nil
local phoneBool = false
local phoneInputField = nil
local addressBool = false
local addressInputField = nil
local activityData = nil
local infoData = nil
local data = {
    name = "",nameTip = "",nameTipRoot = Vector3.zero,
    phone = "",phoneTip = "",phoneTipRoot = Vector3.zero,
    address = "",addressTip = "",addressTipRoot = Vector3.zero,
    timeTip = "",tip0 = "",tip1 = "",
}

local command = {
    maskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.ActivityAddressViewModel)
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
if activityData.time < LuaMgr.Timestamp() then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7023"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
                LuaMgr.HidePanel(UIName.ActivityAddressViewModel)
                return
            end
            this.AddressOnValueChanged(addressInputField.text)
            if nameBool and phoneBool and addressBool then
                this.SendInfoData()
                return
            end
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        nameInputField = vm.behaviour.transform:Find("root/_Middle/NameInputField"):GetComponent("InputField")
        nameInputField.onEndEdit:AddListener(this.NameOnValueChanged)
        phoneInputField = vm.behaviour.transform:Find("root/_Middle/PhoneInputField"):GetComponent("InputField")
        phoneInputField.onEndEdit:AddListener(this.PhoneOnValueChanged)
        addressInputField = vm.behaviour.transform:Find("root/_Middle/AddressInputField"):GetComponent("InputField")
        addressInputField.onEndEdit:AddListener(this.AddressOnValueChanged)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end


        this.SetLanguageText()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
}

this.SetLanguageText = function()
    this.vm.data.name = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7010"].NameLan)
    this.vm.data.nameTipRoot = Vector3.zero
    
    this.vm.data.phone = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7011"].NameLan)
    this.vm.data.phoneTip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7019"].NameLan)
    this.vm.data.phoneTipRoot = Vector3.zero
    
    this.vm.data.address = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7012"].NameLan)
    this.vm.data.addressTipRoot = Vector3.zero
    
    this.vm.data.tip0 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7013"].NameLan)
    this.vm.data.tip1 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7015"].NameLan)
end

this.InitParameter = function()
    activityData = this.vm.behaviour.Params[0]
    if activityData.addinfo == "" then
        nameInputField.text = ""
        phoneInputField.text = ""
        addressInputField.text = ""
    else
        infoData = json.decode(activityData.addinfo)
        nameInputField.text = infoData.name
        phoneInputField.text = infoData.phone
        addressInputField.text = infoData.address
    end
    local strFormat = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7014"].NameLan)
    this.vm.data.timeTip = os.date(strFormat,activityData.time)
end

this.NameOnValueChanged = function(str)
    local length = NumTool.GetStringLength(str)
    if length == 0 then
        this.vm.data.nameTip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7002"].NameLan)
        this.vm.data.nameTipRoot = Vector3.one
        nameBool = false
    else
        if length > ConfigMgr.Config.constants.NameLength then
            local strFormat = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7000"].NameLan)
            local tipStr = string.format(strFormat,ConfigMgr.Config.constants.NameLength)
            this.vm.data.nameTip = tipStr
            this.vm.data.nameTipRoot = Vector3.one
            nameBool = false
        else
            nameBool = true
            this.vm.data.nameTipRoot = Vector3.zero
        end
    end
end

this.PhoneOnValueChanged = function(str)
    this.NameOnValueChanged(nameInputField.text)
    local phoneStr = string.match(str,"[1][3-9]%d%d%d%d%d%d%d%d%d")
    if phoneStr == nil or phoneStr ~= str then
        this.vm.data.phoneTipRoot = Vector3.one
        phoneBool = false
    else
        phoneBool = true
        this.vm.data.phoneTipRoot = Vector3.zero
    end
end

this.AddressOnValueChanged = function(str)
    this.PhoneOnValueChanged(phoneInputField.text)
    local length = NumTool.GetStringLength(str)
    if length == 0 then
        this.vm.data.addressTip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7001"].NameLan)
        this.vm.data.addressTipRoot = Vector3.one
        addressBool = false
    else
        if length > ConfigMgr.Config.constants.AddressLength then
            local strFormat = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7003"].NameLan)
            local tipStr = string.format(strFormat,ConfigMgr.Config.constants.AddressLength)
            this.vm.data.addressTip = tipStr
            this.vm.data.addressTipRoot = Vector3.one
            addressBool = false
        else
            addressBool = true
            this.vm.data.addressTipRoot = Vector3.zero
        end
    end
end
this.SendInfoData = function()
if infoData ~= nil then
        local nameEqual = nameInputField.text == infoData.name
        local phoneEqual = phoneInputField.text == infoData.phone
        local addressEqual = addressInputField.text == infoData.address
        if nameEqual and phoneEqual and addressEqual then
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7027"].NameLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
            LuaMgr.HidePanel(UIName.ActivityAddressViewModel)
            return
        end
    end
    local tempData = {}
    tempData["name"] = nameInputField.text
    tempData["phone"] = phoneInputField.text
    tempData["address"] = addressInputField.text
    tempData = json.encode(tempData)
    local sendData = {}
    sendData["ActKey"] = activityData.ActKey
    sendData["Addr"] = tempData
    ApiMgr.Request("collection/filladdr",sendData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7027"].NameLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
            LuaMgr.HidePanel(UIName.ActivityAddressViewModel)
        end
    end,nil,true)
end
return vm({
    data = data,
    command = command,
    hook = hook
})