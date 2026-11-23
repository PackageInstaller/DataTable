




require("ViewModel/WeaponMake/WeaponEquipItem")

local this = {
    vm = nil,selectCraftID = nil,callBack = nil,playerPrefsKey = nil,timeValue = nil,
    equipList = nil,equipView = nil,equipTemplate = nil,totalWidth = nil,
}

local data = {
    switch = false,switchText = "",nameText = "",tipText = "",isPreview = false,
    scrollPos = Vector2.zero
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.WeaponMakePopup)
        end
    },
    switchCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.vm.data.switch = not this.vm.data.switch
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.callBack ~= nil then
                LuaMgr.HidePanel(UIName.WeaponMakePopup)
                this.callBack()
                if this.vm.data.switch then
                    local setting = SettingHelper.ConverToSetting(169)
                    SettingHelper.SetPrefsBool(setting,false)
                    setting = SettingHelper.ConverToSetting(168)
                    SettingHelper.SetPrefsBool(setting,true)
                    UnityEngine.PlayerPrefs.SetString(this.playerPrefsKey,this.timeValue)
                else
                    local setting = SettingHelper.ConverToSetting(169)
                    SettingHelper.SetPrefsBool(setting,true)
                    setting = SettingHelper.ConverToSetting(168)
                    SettingHelper.SetPrefsBool(setting,false)
                    UnityEngine.PlayerPrefs.SetString(this.playerPrefsKey,"")
                end
            end
        end
    },
    maskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.vm.behaviour.Params.Length == 2 then
                return
            end
            LuaMgr.HidePanel(UIName.WeaponMakePopup)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.equipView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Scroll").gameObject)
        this.equipTemplate = vm.behaviour.transform:Find("template/WeaponEquipItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
        this.SetEquipView()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("WeaponEquipItem")
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()
    this.equipView:Clear(false)
end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length == 0 then return end
    this.SetLanguageText()
    this.vm.data.switch = SettingHelper.GetPrefasBool(ESetting.Msg_EquipPopup_TodayClose)
    this.selectCraftID = this.vm.behaviour.Params[0]
    if this.vm.behaviour.Params.Length > 1 then
        this.playerPrefsKey = DataMgr.Player.uid.."EquipPopup"
        this.GetDayTime()

        this.vm.data.isPreview = true
        this.vm.data.scrollPos = Vector2.zero
        this.callBack = this.vm.behaviour.Params[1]
    else
        this.vm.data.isPreview = false
        this.vm.data.scrollPos = Vector2(0,-24)
    end
    
    local cfgCraft = ConfigMgr.Config.weaponMade.Craftsman[this.selectCraftID]
    local cfgName = LuaMgr.GetLangText(cfgCraft.MasterNameLan)
    local typeName = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_253"..cfgCraft.MasterType)
    this.vm.data.nameText = cfgName.."  "..typeName
end

this.SetLanguageText = function()
    this.vm.data.switchText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2520"].NameLan)
    this.vm.data.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2521"].NameLan)
end

this.SetEquipView = function()
    this.equipView.scrollRect.horizontal = true
    this.GetEquipList()
    this.equipView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for i = 1, #this.equipList do
        groupData = {}
        groupData.item = this.equipTemplate
        groupData.index = i
        groupData.data = this.equipList[i]
        scrollData = UIScrollData.GetData(this.equipTemplate,"WeaponEquipItem",128 + 2,128,groupData)
        table.insert(scrollDatas,scrollData)
    end
    this.equipView:SetParams(this.totalWidth,140)
    this.equipView:SetPadding(0,0,0,0)
    this.equipView:SetData(scrollDatas, true)
    this.equipView.scrollRect.horizontal = #this.equipList > 5
end

this.GetEquipList = function()
    this.equipList = {}
    for i = 1, #ConfigMgr.Config.weaponMade.Weapons do
        if ConfigMgr.Config.weaponMade.Weapons[i].GroupID == this.selectCraftID then
            table.insert(this.equipList,ConfigMgr.Config.weaponMade.Weapons[i])
        end
    end
    if #this.equipList <= 5 then
        this.totalWidth = #this.equipList * 130
    else
        this.totalWidth = 675
    end
end

this.GetDayTime = function()
    local time = os.date("*t", LuaMgr.Timestamp())
    this.timeValue = time.month..time.day
end

return vm({
    data = data,
    command = command,
    hook = hook
})