





local this = {
    vm = nil,
    rewardUIRoot = nil,numUIRoot = nil,
    groupId = nil,activityData = nil,questEvents = nil,
}

local data = {
    timeText = "",introText = "",introTitleText = "",
    skinList = {{heroPic = DefaultTexture,skinName = "",heroName = "",mask = false}},
    progressText_1 = "",progressText_2 = "",sliderValue = Vector2.zero,
    horizontalPosition = 0.0,rewardHorizontalPosition = 0.0
}

local command = {
    skinItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            HeroParameter.SaveActivityKey(ActivityKey.HighSpec)
            local shopParam = "gift_4001002_"..this.vm.data.skinList[index].chargeId
            LuaMgr.ShowLuaPanel(UIName.MainShopViewModel,shopParam)
        end
    },
    rewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param)
            local eventId = this.questEvents[index].id
            if IsNullOrEmpty(eventId) then return end
            if DataMgr.Player.quests[eventId] == nil then return end
            if DataMgr.Player.quests[eventId].state == 2 then
                DataExHelper.EX_GetAward(eventId,function()
                    this.SetRewardProgress()
                    RedMgr.Singleton:UpdateClientRedData("17850",ActivityMgr.ActivityCanFinish(ActivityKey.HighSpec) and 1 or 0)
                    RedMgr.Singleton:Refresh()
                end)
            else
                local goodsId = this.questEvents[index].reward[1].id
                LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,goodsId,false,false,false,0,0);
            end
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitGetView()
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
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.SetLanguageText = function()
    this.vm.data.introTitleText = ConfigMgr.LangGlobal("30250")
    this.vm.data.introText = ConfigMgr.LangGlobal("30251")
end


this.InitParameter = function()
    this.groupId = ActivityMgr.groupKeyList[ActivityKey.HighSpec]
    if IsNullOrEmpty(this.groupId) then return end

    if not ActivityMgr.ActivityRuning(ActivityKey.HighSpec) then
        return
    end

    this.activityData = DataMgr.Player.variables[this.groupId]
    

    local typeId = tonumber(string.sub(this.groupId,7))
    this.questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(typeId)
    if TableIsNull(this.questEvents) then return end
    
    this.SetTime()
    this.SetSkinView()
    this.SetRewardProgress()
end


this.SetTime = function()
    local time = this.activityData.delTime - LuaMgr.Timestamp()
    local d, h, m = GetTimeDHM(time)
    local timeStr = ""
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr..string.format("%s%s", d, ConfigMgr.LangGlobal("10365"))
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr..string.format("%s%s", h, ConfigMgr.LangGlobal("10366"))
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr..string.format("%s%s", m, ConfigMgr.LangGlobal("10367"))
    end
    this.vm.data.timeText = ConfigMgr.LangGlobal("7032")..timeStr
end

this.SetSkinView = function()
    this.vm.data.horizontalPosition = 0.0
    local highSkin = ConfigMgr.Config.CharacterHighSkinMap
    if TableIsNull(highSkin) then
        return
    end
    local tempData,tempList = nil,{}
    local skinConfig = nil
    for _,value in pairs(highSkin) do
        skinConfig = ConfigHelper.GetHeroSkinConfig(value.skinID)
        if not TableIsNull(skinConfig) then
            tempData = {heroPic = DefaultTexture,skinName = "",heroName = "",mask = false}
            tempData.heroPic = ConfigHelper.GetHeroCard(skinConfig.characterId,value.skinID)
            tempData.skinName = LuaMgr.GetLangText(skinConfig.skinNamelan)
            tempData.heroName = ConfigHelper.GetGoodsPriceStr(value.ChargeId)
            tempData.mask = DataHelper.IsContainsSkin(skinConfig.characterId,value.skinID)
            tempData.skinId = value.skinID
            tempData.chargeId = value.ChargeId
            tempData.maskState = DataHelper.IsContainsSkin(skinConfig.characterId,value.skinID) and 1 or 2
            table.insert(tempList,tempData)
        end
    end
    table.sort(tempList,function(a,b)
        if a.maskState ~= b.maskState then
            return a.maskState > b.maskState
        else
            return a.skinId > b.skinId
        end
    end)
    this.vm.data.skinList = tempList
end

this.SetRewardProgress = function()
    local length = #this.questEvents
    local quests = nil
    local canGetCount = 0
    local alreadyGetCount = 0
    for i = 1, length do
        quests = DataMgr.Player.quests[this.questEvents[i].id]
        if not TableIsNull(quests) then

            SetActive(this.rewardUIRoot[i].canGet,quests.state == 2)

            SetActive(this.rewardUIRoot[i].alreadyGet,quests.state == 3)
            this.rewardUIRoot[i].countText.text = this.questEvents[i].reward[1].count
            this.rewardUIRoot[i].icon.texture = ConfigHelper.GetItemTexture(this.questEvents[i].reward[1].id)
            
            SetActive(this.numUIRoot[i].canGet,quests.state == 2)
            this.numUIRoot[i].numText.text = i
            if quests.state == 2 then
                canGetCount = canGetCount + 1
            elseif quests.state == 3 then
                alreadyGetCount = alreadyGetCount + 1
            end
        end
    end
    local totalCount = canGetCount + alreadyGetCount
    if totalCount == 1 then
        this.vm.data.sliderValue = Vector2(48,8)
    elseif totalCount == length then
        this.vm.data.sliderValue = Vector2(757,8)
    else
        local nowWidth = 48 + (totalCount - 1) * 133
        this.vm.data.sliderValue = Vector2(nowWidth,8)
    end
    this.vm.data.progressText_1 = tostring(DataMgr.Player.FreeHighSkin)
    this.vm.data.progressText_2 = string.format(ConfigMgr.LangGlobal("30252"),DataMgr.Player.FreeHighSkin,length)


    this.vm.data.rewardHorizontalPosition = alreadyGetCount >= 5 and 1.0 or 0.0
end

this.InitGetView = function()

    local rewardContent = this.vm.behaviour.transform:Find("root/Middle/RewardList/Scroll/Viewport/Content"):GetComponent("RectTransform")
    local node = {
        icon = {path = "Icon",type = "RawImage"},
        canGet = {path = "CanGet",type = "GameObject"},
        alreadyGet = {path = "AlreadyGet",type = "GameObject"},
        countText = {path = "Count/Text",type = "Text"},
    }
    if TableIsNull(this.rewardUIRoot) then
        this.rewardUIRoot = {}
    end
    local object,objectName,tempNode = nil,"",{}
    local length = rewardContent.childCount - 1
    for i = 1, length do
        objectName = "RewardItem"..i
        object = rewardContent:Find(objectName).gameObject
        tempNode = {}
        UITool.Parse(object,tempNode,node)
        table.insert(this.rewardUIRoot,i,tempNode)
    end
    

    rewardContent = this.vm.behaviour.transform:Find("root/Middle/RewardList/Scroll/Viewport/Content/Slider"):GetComponent("RectTransform")
    node = {
        canGet = {path = "CanGet",type = "GameObject"},
        numText = {path = "Text",type = "Text"},
    }
    if TableIsNull(this.numUIRoot) then
        this.numUIRoot = {}
    end
    object,objectName,tempNode = nil,"",{}
    length = rewardContent.childCount - 1
    for i = 1, length do
        objectName = "Num"..i
        object = rewardContent:Find(objectName).gameObject
        tempNode = {}
        UITool.Parse(object,tempNode,node)
        table.insert(this.numUIRoot,i,tempNode)
    end
    
    rewardContent,node,object,objectName,tempNode = nil,nil,nil,nil,nil
end

return vm({
    data = data,
    command = command,
    hook = hook
})