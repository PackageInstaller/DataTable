





local this = {
    vm = nil,nullStr = nil,cardData = nil,
}

local data = {
    titleText = "",tipText = "",
    attrList = {{zz = false,attrIcon = DefaultSprite,attrName = "",attrValue = "",level = "",zzText = "",
                 notAttr = false,notAttrText = "",lock = false,}},
    brilliantText = "",brilliantActive = false,brilliantNotAttr = false,brilliantNotAttrText = "",
    brilliantAttr = {{active = false,notActive = false,bAttrIcon = DefaultSprite,bAttrName = "",bAttrValue = ""}}
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.AddAttributePopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.attrList = {}
        this.vm.data.brilliantAttr = {}
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length <= 0 then
        return
    end
    this.cardData = this.vm.behaviour.Params[0]
    if TableIsNull(this.cardData) then
        return
    end
    this.nullStr = ConfigMgr.LangGlobal("17310")
    this.vm.data.titleText = this.cardData.name..ConfigMgr.LangGlobal("17309")
    this.vm.data.tipText = string.format(ConfigMgr.LangGlobal("17302"),this.cardData.jobName)
    this.vm.data.brilliantText = ConfigMgr.LangGlobal("22605")
    this.vm.data.brilliantNotAttrText = this.nullStr
    this.SetAttrData()
    this.SetBrilliantAttrData()
end

this.SetAttrData = function()
    if TableIsNull(this.cardData.attr) then return end
    this.vm.data.attrList = {}
    local tempData,tempList = nil,{}
    local attrName,attrValue,attrType,iconName = nil,nil,nil,nil
    local attr = nil
    local typeKey = nil
    for i = 1, #this.cardData.attr do
        tempData = {zz = i > 1,attrIcon = DefaultSprite,attrName = "",attrValue = "",level = "",zzText = "",
                    notAttr = false,notAttrText = this.nullStr,lock = false,}
        if this.cardData.attr[i] ~= "" then
            attr = ConfigMgr.Config.talentBankMap[this.cardData.attr[i]]
            if not TableIsNull(attr) and attr.type == 2 then
                attrName,attrValue,attrType,iconName = ConfigHelper.GetAttrNameStr(attr.id)
                tempData.attrIcon = LuaMgr.GetSprite("AttributeIcon",iconName)
                tempData.attrName = attrName
                tempData.attrValue = "+"..attrValue..attrType
            end
            tempData.notAttr = false
        else
            tempData.notAttr = true
        end
        if i == 1 then
            tempData.zzText = ""
            typeKey = this.cardData.id.."_level_"..this.cardData.needLevel
            tempData.lock = DataMgr.Player.jobExtraAttr[typeKey] == nil

            tempData.level = "lv."..this.cardData.needLevel
        else
            tempData.level = ""
            if this.cardData.star == 0 then
                tempData.lock = true
            else
                if this.cardData.state ~= 2 and this.cardData.state ~= 4 and this.cardData.state ~= 3 then
                    tempData.lock = true
                else
                    if tempData.notAttr then
                        typeKey = this.cardData.id.."_star_"..i - 2
                        tempData.lock = i - 1 > this.cardData.star or DataMgr.Player.jobExtraAttr[typeKey] == nil
                    else
                        typeKey = this.cardData.id.."_star_"..i - 1
                        tempData.lock = DataMgr.Player.jobExtraAttr[typeKey] == nil
                    end
                end
            end
            tempData.zzText = HeroMgr.GetNumStr(math.abs(i - 1))
        end
        table.insert(tempList,tempData)
    end
    this.vm.data.attrList = tempList
end

this.SetBrilliantAttrData = function()
    if TableIsNull(this.cardData.attr) then return end
    
    local nowRare = HeroMgr.GetHeroNowRare(this.cardData.id)
    local tempKey_1 = this.cardData.id.."_level_"..this.cardData.needLevel
    local tempKey_2 = this.cardData.id.."_brilliant_1"

    local isActive = DataMgr.Player.jobExtraAttr[tempKey_1] ~= nil and DataMgr.Player.jobExtraAttr[tempKey_2] ~= nil and nowRare >= 5
    this.vm.data.brilliantActive = isActive
    
    if nowRare >= 5 then nowRare = 4 end
    local brilliantKey = this.cardData.id..nowRare
    local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
    this.vm.data.brilliantNotAttr = TableIsNull(brilliant) or #this.cardData.attr <= 7

    this.vm.data.brilliantAttr = {}
    if not this.vm.data.brilliantNotAttr then
        local tempData,tempList = nil,{}
        local attrName,attrValue,attrType,iconName = nil,nil,nil,nil
        local attr = nil
        local length = #this.cardData.attr
        for i = 8, length do
            tempData = {active = isActive,notActive = not isActive,bAttrIcon = DefaultSprite,bAttrName = "",bAttrValue = ""}
            attr = ConfigMgr.Config.talentBankMap[this.cardData.attr[i]]
            if not TableIsNull(attr) and attr.type == 2 then
                attrName,attrValue,attrType,iconName = ConfigHelper.GetAttrNameStr(attr.id)
                tempData.bAttrIcon = LuaMgr.GetSprite("AttributeIcon",iconName)
                tempData.bAttrName = attrName
                tempData.bAttrValue = "+"..attrValue..attrType
                table.insert(tempList,tempData)
            end
        end
        this.vm.data.brilliantAttr = tempList
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})