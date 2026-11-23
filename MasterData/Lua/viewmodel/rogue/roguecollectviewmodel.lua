require("ViewModel/Rogue/Rogue_BuffGroupItem")
require("ViewModel/Rogue/Rogue_BuffEventItem")
require("ViewModel/Rogue/Rogue_BagBuffTypeItem")

local this = {
    vm = nil,
    type = 1;
    eventItemObj = nil,
    eventUIList = {},
    scrollWidth = 972,
    buffUIScrollView = {},
    buffItemObj = nil;
    buffGroupObj = nil;
    buffTypeUIList = {},
    buffTypeItemObj = nil,
    curBuffType = nil;
    buffList = {},
eventShowType = 0
};

local data = {
    progressStr = "",
    buffPageIsOn = false,
    eventPageIsOn = false,
    buffInfoIsOn = false,
    imgRare = DefaultSprite,
    imgBuff = DefaultSprite,
    txtBuffName = "",
    txtBuffDes = "",
    eventShowType_All = false,
    eventShowType_Unlock = false,
    eventShowType_Lock = false,
}

local command = {
    buffTypeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SwitchType(1)
        end
    },
    eventTypeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SwitchType(2)
        end
    },
    eventShowTypeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local typeIndex = param
            this.eventShowType = tonumber(typeIndex)
            this.SetEventList()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.eventItemObj = vm.behaviour.transform:Find("template/EventItem").gameObject
        this.buffItemObj = vm.behaviour.transform:Find("template/BuffItem").gameObject
        this.buffGroupObj = vm.behaviour.transform:Find("template/BuffGroupItem").gameObject
        this.buffTypeItemObj = vm.behaviour.transform:Find("template/BuffTypeItem").gameObject
        this.eventUIList = UIListView.New(vm.behaviour.transform:Find("root/Middle/rect/goEventPanel/EventScrollView/Viewport/Content"));
        this.buffUIScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/rect/goBuffPanel/BuffScrollView").gameObject);
        this.buffTypeUIList = UIListView.New(vm.behaviour.transform:Find("root/Middle/rect/goBuffPanel/TopScrollView/Viewport/tranTopContent"));
        RedMgr.Singleton:RegisterViewModel(UIName.RogueCollectViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.type = nil;
            this.scrollWidth = LuaMgr.GetScreenWidth() - 307 - 369
            this.ParseData()
        end
    end,
    before_deactive = function(vm)
        if this.eventUIList ~= nil then
            this.eventUIList:Clear()
        end
        if this.buffUIScrollView ~= nil then
            this.buffUIScrollView:Clear(true)
        end
    end,
    before_destroy = function()
        UIScrollView.ClearItem("Rogue_BuffGroupItem");
        UIListView.ClearItem("Rogue_BuffEventItem")
        UIListView.ClearItem("Rogue_BagBuffTypeItem")
    end
}

this.ParseData = function()
    this.InitAllBuffIds()
    this.SwitchType(1)
end

this.InitAllBuffIds = function()
    this.buffIds = {}
    local rogueBuffDescMap = ConfigMgr.Config.RogueBuffDescMap
    for k, v in pairs(rogueBuffDescMap) do
        if v.Handbook > 0 then
            table.insert(this.buffIds, k)
        end
    end
end

this.SwitchType = function(index)
    if this.type == index then
        return
    end
    this.type = index
    this.SetButtonState(index)
    if this.type == 1 then
        this.curBuffType = 1
        this.SetBuffPanel()
    else
        this.eventShowType = 0
        this.SetEventPanel()
    end
end

this.SetButtonState = function(index)
    this.vm.data.buffPageIsOn = index == 1
    this.vm.data.eventPageIsOn = index == 2
    this.vm.data.buffInfoIsOn = false
end

this.SetEventPanel = function()
    this.InitEventList()
    this.SetEventList()
end

this.InitEventList = function()
    local eventHandbookCfgs = ConfigMgr.Config.RogueEventHandBooks
    this.eventList = {}
    local unlockEventCount = 0
    for i, v in ipairs(eventHandbookCfgs) do
        local eventItem = {
            id = v.Id,
            name = LuaMgr.GetLangText(v.NameLan),
            desc = LuaMgr.GetLangText(v.DescLan),
            icon = LuaMgr.GetTexture(string.format("Images/Rogue/%s.png", v.Icon)),
            status = this.GetEventStatus(v.Id, v.EventId),
            callback = this.OnClickEvent,
        }
        table.insert(this.eventList, eventItem)
        if eventItem.status ~= 0 then
            unlockEventCount = unlockEventCount + 1
        end
    end
    table.sort(this.eventList, function(a, b)
        return a.status > b.status
    end)
    this.vm.data.progressStr = string.format(LuaMgr.GetLangText("RogueCollectViewModel_0"), unlockEventCount, #this.eventList)
end

this.SetEventList = function()
    this.vm.data.eventShowType_All = this.eventShowType == 0
    this.vm.data.eventShowType_Unlock = this.eventShowType == 1
    this.vm.data.eventShowType_Lock = this.eventShowType == 2
    this.eventUIList:Clear()
    local list = {}
    for i, v in pairs(this.eventList) do
        if this.eventShowType == 0 or (this.eventShowType == 1 and (v.status == 1 or v.status == 2)) or (this.eventShowType == 2 and v.status == 0) then
            local cardItem = {
                index = i,
                data = v
            }
            local cardData = UIListData.GetData(this.eventItemObj, "Rogue_BuffEventItem", cardItem)
            table.insert(list, cardData)
        end
    end
    this.eventUIList:SetData(list)
end

this.OnClickEvent = function(eventId)
    local eventData = nil
    for i, v in ipairs(this.eventList) do
        if v.id == eventId then
            eventData = v
            break
        end
    end
    if eventData ~= nil and eventData.status == 2 then
        local eventIds = { eventData.id }
        RogueMgr.OnAskGetEventReward(eventIds, function()
            this.SetEventPanel()
        end)
    end
end


this.GetEventStatus = function(id, eventIds)
    local handEventRecords = DataMgr.Player.RogueHandbookRecords
    local eventRecords = DataMgr.Player.RogueEventRecords
    if not IsNull(handEventRecords) and handEventRecords[tostring(id)] ~= nil then
        return 1
    else
        if IsNull(eventRecords) then
            return 0
        else
            for i, v in ipairs(eventIds) do
                if eventRecords[v] ~= nil then
                    return 2
                end
            end
            return 0
        end
    end
end

this.SetBuffPanel = function()
    this.SetBuffTypeList()
    this.SwitchBuffType()
end

this.SetBuffTypeList = function()
    this.buffTypeUIList:Clear()
    local list = {}

    for i = 1, 8, 1 do
        local topItem = {
            type = i;
            isOn = i == this.curBuffType;
            callBack = this.BuffTypeCallBack
        }
        local topData = UIListData.GetData(this.buffTypeItemObj, "Rogue_BagBuffTypeItem", topItem)
        table.insert(list, topData)
    end
    this.buffTypeUIList:SetData(list)
end

this.BuffTypeCallBack = function(type)
    if this.curBuffType == type then
        return
    end ;
    this.curBuffType = type;
    for i, v in ipairs(this.buffTypeUIList.itemList) do
        v:SetSelect(i == type)
    end
    this.SwitchBuffType()
end

this.SwitchBuffType = function()

    local buffGenre = this.curBuffType - 1;
    this.buffList = RogueMgr.GetBuffListByGenreBuff(this.buffIds, buffGenre)
    this.SetBuffList()
    local unlockBuffCount = 0
    for i, v in ipairs(this.buffList) do
        if DataMgr.Player.RogueBuffRecords[v.Id] ~= nil then
            unlockBuffCount = unlockBuffCount + 1
        end
    end
    this.vm.data.progressStr = string.format(LuaMgr.GetLangText("RogueCollectViewModel_1"), unlockBuffCount, #this.buffList)
end

this.SetBuffList = function()
    this.buffUIScrollView:Clear(false)
    this.vm.data.buffInfoIsOn = false
    local groupCount = math.floor(this.scrollWidth / 144)
    if #this.buffList > 0 then
        this.buffIndex = nil;
        local scrollDatas = {}
        local len = #this.buffList
        for i = 1, len, groupCount do
            local buffGroupData = {}
            for j = 0, groupCount - 1 do
                local index = i + j
                if index <= #this.buffList then
                    local buffCfg = this.buffList[index]
                    local buffItem = {
                        prefab = this.buffItemObj,
                        data = {
                            index = index,
                            rare = buffCfg.BuffQuality,
                            icon = buffCfg.BuffIcon,
                            name = LuaMgr.GetLangText(buffCfg.BuffNameLan),
                            isOn = index == this.buffIndex,
                            isLock = DataMgr.Player.RogueBuffRecords[buffCfg.Id] == nil,
                            callBack = this.BuffCallBack,
                        },
                    }
                    table.insert(buffGroupData, buffItem)
                end
            end
            local scrollData = UIScrollData.GetData(this.buffGroupObj, "Rogue_BuffGroupItem", this.scrollWidth, 180, buffGroupData)
            table.insert(scrollDatas, scrollData)
        end
        this.buffUIScrollView:SetParams(this.scrollWidth, 500);
        this.buffUIScrollView:SetData(scrollDatas, true)
        this.BuffCallBack(1)
    end
end

this.BuffCallBack = function(index)
    if this.buffIndex ~= nil and this.buffIndex == index then
        return ;
    end
    this.buffIndex = index;
    for _, v in pairs(this.buffUIScrollView.itemMap) do
        v:SetSelect(this.buffIndex)
    end
    local curBuffInfo = this.buffList[this.buffIndex]
    this.SetBuffDetailInfo(curBuffInfo)
end

this.SetBuffDetailInfo = function(buffInfo)
    this.vm.data.imgRare = LuaMgr.GetSprite("Rogue", "ui_xhyt_csqzxbfd_0" .. buffInfo.BuffQuality)
    this.vm.data.imgBuff = LuaMgr.GetSprite("BuffIcon", buffInfo.BuffIcon)
    this.vm.data.txtBuffName = LuaMgr.GetLangText(buffInfo.BuffNameLan)
    this.vm.data.txtBuffDes = LuaMgr.GetLangText(buffInfo.BuffDesLan)
    this.vm.data.buffInfoIsOn = true
end

return vm({
    data = data,
    command = command,
    hook = hook
})