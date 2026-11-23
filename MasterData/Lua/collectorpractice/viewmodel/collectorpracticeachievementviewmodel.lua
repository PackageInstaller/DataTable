




require("CollectorPractice/ViewModel/YXTwoBuffGroupViewModel")
require("CollectorPractice/ViewModel/YXTwoBuffItemViewModel")
require("CollectorPractice/ViewModel/YXTwoEventItemViewModel")
require("CollectorPractice/ViewModel/YXTwoNovelItemViewModel")

local this = {
    vm = nil,labelEnum = {buff = "buff",event = "event",novel = "novel"},curLabel = nil,

    buffConfig = nil,buffTypeIndex = nil,
    buffGroupIndex = nil,buffIndex = nil,
    buffScroll = nil,buffGroup = nil,buffTemplate = nil,
    buffCompletedCount = nil,
    buffAnimator=nil,

    eventConfig = nil,eventIndex = nil,
    eventScroll = nil,eventTemplate = nil,
    eventCompletedCount = nil,

    novelConfig = nil,novelCompletedCount = nil,
    novelScroll = nil,novelTemplate = nil,
    rewardCountFormat = "%d<color=#BBB09A><size=20>/%d</size></color>",
    eventCountFormat = "%d<color=#262429><size=20>/%d</size></color>",
}

local data = {
    buffRoot = false,eventRoot = false,novelRoot = false,
    buffLabelText = "",eventLabelText = "",novelLabelText = "",
    
    allEventText = "",
    buffTypeIntro = "",buffAllCount = "",
    infoTypeText = "",
    buffType_1 = false,buffType_2 = false,
    buffNameText = "",buffIntroText = "",
    buffIcon = DefaultSprite,
    buffDemand = false,demandBuffIcon = DefaultSprite,
    demandCount = "",buffIntroPost = Vector2.zero,
    
    rewardText = "",rewardCanGet = false,
    
    eventName = "",eventReward = false,rewardTipText = "",
    eventSprite = DefaultSprite,goodRare = DefaultSprite,
    goodIcon = DefaultTexture,rewardCount = "",
    nowRewardRedId="",
    buffTypeList = {{normal = false,normalImg = DefaultSprite,choose = false,chooseImg = DefaultSprite,redId=""}}
}

local command = {
    labelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if IsNullOrEmpty(param) then return end
            if param == this.curLabel then return end
            this.curLabel = param
            this.SwitchView()
        end
    },
    buffTypeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = param + 1
            if index == this.buffTypeIndex then return end
            if this.buffTypeIndex > 0 then
                this.vm.data.buffTypeList[this.buffTypeIndex].choose = false
            end
            this.buffTypeIndex = index
            this.vm.data.nowRewardRedId="1313_SelectType"..tostring(index);
            RedMgr.Singleton:Refresh();
            local str = this.buffConfig[this.buffTypeIndex].typeStr
            this.vm.data.infoTypeText = str
            this.vm.data.buffTypeIntro = string.format(ConfigMgr.LangGlobal("7199"),str)
            this.vm.data.buffTypeList[this.buffTypeIndex].choose = true
            this.SetBuffView()
            this.buffIndex = -1
            this.buffGroupIndex = -1
            this.ChooseBuff(1,1)
            this.CalculateReward()
            this.buffAnimator:Play("ani_CollectorPracticeAchievementPanel_BuffRoot",0,0);
        end
    },
    rewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeRewardPopup,"YX2BUFF","701",this.buffTypeIndex)
        end 
    },
    eventRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.GetEventReward()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.CollectorPracticeAchievementViewModel);
        this.buffGroup = this.vm.behaviour.transform:Find("template/BuffGroup").gameObject
        this.buffTemplate = this.vm.behaviour.transform:Find("template/BuffItem").gameObject
        this.buffScroll = UIScrollView.New(vm.behaviour.transform:Find("root/_Middle/BuffRoot/BuffView/Scroll").gameObject)
        this.buffAnimator=vm.behaviour.transform:Find("root/_Middle/BuffRoot/BuffView"):GetComponent("Animator");
        this.eventTemplate = this.vm.behaviour.transform:Find("template/EventItem").gameObject
        this.eventScroll = UIScrollView.New(vm.behaviour.transform:Find("root/_Middle/EventRoot/EventView/Scroll").gameObject)
        
        this.novelTemplate = this.vm.behaviour.transform:Find("template/NovelItem").gameObject
        this.novelScroll = UIScrollView.New(vm.behaviour.transform:Find("root/_Middle/NovelRoot/Scroll").gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.SetLanguageText()
        this.InitParameter()
        CollectorPracticeMgrVersion2.CalculateCollect()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.buffScroll:Clear(false)
        this.eventScroll:Clear(false)
        this.novelScroll:Clear(false)
        this.buffConfig = nil
        this.eventConfig = nil
        this.novelConfig = nil
        this.vm.data.buffTypeList = {}
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("YXTwoBuffGroupViewModel")
        UIScrollView.ClearItem("YXTwoEventItemViewModel")
        UIScrollView.ClearItem("YXTwoNovelItemViewModel")
        this = nil
    end,
}

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.YXTwoMissionGetReward, this.GetBuffMissionReward)
end
this.RemoveUIEvent = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.YXTwoMissionGetReward, this.GetBuffMissionReward)
end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length <= 0 then
        this.curLabel = this.labelEnum.buff
    else
        this.curLabel = this.vm.behaviour.Params[0]
    end
    this.SwitchView()
end


this.SetLanguageText = function()
    this.vm.data.buffLabelText = ConfigMgr.LangGlobal("7196")
    this.vm.data.eventLabelText = ConfigMgr.LangGlobal("7197")
    this.vm.data.novelLabelText = ConfigMgr.LangGlobal("7198")
    this.vm.data.rewardTipText = ConfigMgr.LangGlobal("7203")
end

this.SwitchView = function()
    if this.curLabel == this.labelEnum.buff then
        this.buffTypeIndex = -1
        this.GetBuffConfig()
        this.SetBuffType()
        this.CalculateBuff()
        command.buffTypeCommand.execute(nil,0)
    elseif this.curLabel == this.labelEnum.event then
        this.eventIndex = -1
        this.GetEventConfig()
        this.SetEventView()
        this.ChooseEvent(1)
        this.vm.data.allEventText = ConfigMgr.LangGlobal("7202")
        this.CalculateReward()
    elseif this.curLabel == this.labelEnum.novel then
        this.novelCompletedCount = 0
        this.GetNovelConfig()
        this.SetNovelView()
        this.vm.data.allEventText = ConfigMgr.LangGlobal("7204")
        this.CalculateReward()
    end
    this.vm.data.buffRoot = this.curLabel == this.labelEnum.buff
    this.vm.data.eventRoot = this.curLabel == this.labelEnum.event
    this.vm.data.novelRoot = this.curLabel == this.labelEnum.novel
end


this.SetBuffType = function()
    local tempItem,tempList = {},{}
    local length = #this.buffConfig
    for i = 1, length do
        tempItem = {normal = true,normalImg = nil,choose = false,chooseImg = nil}
        tempItem.normalImg = LuaMgr.GetSprite("CollectorBuffTypeIcon","ui_sx_sj_buficon_"..i.."_1")
        tempItem.chooseImg = LuaMgr.GetSprite("CollectorBuffTypeIcon","ui_sx_sj_buficon_"..i.."_2")
        tempItem.redId="1313_Type"..tostring(i);
        table.insert(tempList,tempItem)
    end
    this.vm.data.buffTypeList = tempList
end


this.SetBuffView = function()
    this.buffScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local index = 1
    local length = #this.buffConfig[this.buffTypeIndex].buff
    local tempBuff = nil
    while(index <= length) do
        groupData = {}
        groupData.item = this.buffTemplate
        groupData.spaceX = 35
        groupData.buff = {}
        groupData.fun = this.ChooseBuff
        for i = 1, 4 do
            if this.buffConfig[this.buffTypeIndex].buff[index + i - 1] ~= nil then
                tempBuff = this.buffConfig[this.buffTypeIndex].buff[index + i - 1]
                tempBuff.choose = false
                table.insert(groupData.buff,tempBuff)
            end
        end
        scrollData = UIScrollData.GetData(this.buffGroup,"YXTwoBuffGroupViewModel",744,198,groupData)
        table.insert(scrollDatas,scrollData)
        index = index + 4
    end
    this.buffScroll:SetParams(744,435)
    this.buffScroll:SetData(scrollDatas,true)
end

this.ChooseBuff = function(groupIndex,index)
    if groupIndex == nil or index == nil then return end
    if groupIndex == this.buffGroupIndex and index == this.buffIndex then return end
    if this.buffGroupIndex > 0 and this.buffIndex > 0 then
        if this.buffScroll.itemMap[this.buffGroupIndex] ~= nil then
            SetActive(this.buffScroll.itemMap[this.buffGroupIndex].itemList[this.buffIndex].choose,false)
        end
        this.buffScroll.dataList[this.buffGroupIndex].data.buff[this.buffIndex].choose = false
    end
    this.buffGroupIndex = groupIndex
    this.buffIndex = index
    SetActive(this.buffScroll.itemMap[this.buffGroupIndex].itemList[this.buffIndex].choose,true)
    this.buffScroll.dataList[this.buffGroupIndex].data.buff[this.buffIndex].choose = true
    local config = this.buffScroll.dataList[this.buffGroupIndex].data.buff[this.buffIndex]
    this.vm.data.buffType_1 = config.Type[1] == 1
    this.vm.data.buffType_2 = config.Type[1] == 2
    local icon = LuaMgr.GetSprite("BuffIcon",config.BuffIcon)
    this.vm.data.buffIcon = icon
    this.vm.data.buffNameText = config.lock and ConfigMgr.LangGlobal("7207") or LuaMgr.GetLangText(config.BuffNameLan)
    this.vm.data.buffIntroText = config.lock and ConfigMgr.LangGlobal("7207") or LuaMgr.GetLangText(config.BuffDesLan)
    if config.Type[3] > 0 then
        this.vm.data.demandBuffIcon = icon
        this.vm.data.demandCount = config.Type[3]
    end
    this.vm.data.buffDemand = config.Type[3] > 0
    this.vm.data.buffIntroPost = config.Type[3] > 0 and Vector2(-13.1,-131) or Vector2(-13.1,-90)
end


this.SetEventView = function()
    this.eventScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for i = 1, #this.eventConfig do
        groupData = {}
        groupData.index = i
        groupData.data = this.eventConfig[i]
        groupData.fun = this.ChooseEvent
        groupData.choose = false
        scrollData = UIScrollData.GetData(this.eventTemplate,"YXTwoEventItemViewModel",268,64 + 8,groupData)
        table.insert(scrollDatas,scrollData)
    end
    this.eventScroll:SetParams(326,588)
    this.eventScroll:SetPadding(0,0,-6,0)
    this.eventScroll:SetData(scrollDatas,true)
end

this.ChooseEvent = function(index)
    if index == this.eventIndex then return end
    if this.eventIndex > 0 then
        if this.eventScroll.itemMap[this.eventIndex] ~= nil then
            SetActive(this.eventScroll.itemMap[this.eventIndex].choose,false)
        end
        this.eventScroll.dataList[this.eventIndex].data.choose = false
    end
    this.eventIndex = index
    SetActive(this.eventScroll.itemMap[this.eventIndex].choose,true)
    this.eventScroll.dataList[this.eventIndex].data.choose = true
    
    local eventData = this.eventConfig[this.eventIndex]
    local config = ConfigMgr.Config.missionMap[eventData.id]
    if not TableIsNull(config) then
        local target = MissionHelper.GetTargetCount(eventData.id)
        local tempLock = not eventData.completed and eventData.current < target
        this.vm.data.eventName = tempLock and ConfigMgr.LangGlobal("7207") or LuaMgr.GetLangText(config.NameLan)
        local event = ConfigMgr.Config.YX2EventMap[config.condition1[1].ElementID]
        if not TableIsNull(event) then
            this.vm.data.eventSprite = LuaMgr.GetSprite("CollectorEventVersion2",event.EventPic)
        end
        if not eventData.completed then
            local goods = ConfigMgr.Config.itemMap[config.rewards[1].itemId]
            this.vm.data.goodRare = GetRareSprite(goods.rare)
            this.vm.data.goodIcon = GetItemTexture(goods.id)
            this.vm.data.rewardCount = config.rewards[1].count
        end
    end
    this.vm.data.eventReward = not eventData.completed
end


this.SetNovelView = function()
    this.novelScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local state = false
    for i = 1, #this.novelConfig do
        groupData = {}
        groupData.data = this.novelConfig[i]
        state = this.NovelIsLock(this.novelConfig[i].NarrativesID)
        if not state then
            this.novelCompletedCount = this.novelCompletedCount + 1
        end
        groupData.state = state
        scrollData = UIScrollData.GetData(this.novelTemplate,"YXTwoNovelItemViewModel",400,360,groupData)
        table.insert(scrollDatas,scrollData)
    end
    this.novelScroll:SetParams(1119,410)
    this.novelScroll:SetPadding(0,10,0,0)
    this.novelScroll:SetData(scrollDatas,true)
end

this.CalculateBuff = function()
    local haveCount = 0
    local allCount = #ConfigMgr.Config.YX2Buffs
    if not TableIsNull(DataMgr.Player.practiceStage2.longBuffs) then
        haveCount = #DataMgr.Player.practiceStage2.longBuffs
    end
    this.vm.data.buffAllCount = string.format(ConfigMgr.LangGlobal("7200"),haveCount,allCount)
end

this.CalculateReward = function()
    local allCount = 0
    if this.curLabel == this.labelEnum.buff then
        this.buffCompletedCount = 0
        local tempData = DataMgr.Player.missions["YX2BUFF"]["701"]
        if TableIsNull(tempData) then return end
        local canGet = 0
        local tempConfig = nil
        for key,value in pairs(tempData) do
            tempConfig = ConfigMgr.Config.missionMap[key]
            if not TableIsNull(tempConfig) then
                if tonumber(tempConfig.condition1[1].ElementID) == this.buffTypeIndex then
                    allCount = allCount + 1
                    if value.completed then
                        this.buffCompletedCount = this.buffCompletedCount + 1
                    else
                        if value.current >= MissionHelper.GetTargetCount(value.id) then
                            canGet = canGet + 1
                        end
                    end
                end
            end
        end
        this.vm.data.rewardCanGet = canGet > 0
        this.vm.data.rewardText = string.format(this.rewardCountFormat,this.buffCompletedCount,allCount)
    elseif this.curLabel == this.labelEnum.event then
        allCount = #this.eventConfig
        this.eventCompletedCount = 0
        for i = 1, allCount do
            if this.eventConfig[i].completed then
                this.eventCompletedCount = this.eventCompletedCount + 1
            end
        end
        this.vm.data.rewardText = string.format(this.eventCountFormat,this.eventCompletedCount,allCount)
    elseif this.curLabel == this.labelEnum.novel then
        allCount = #this.novelConfig
        this.vm.data.rewardText = string.format(this.eventCountFormat,this.novelCompletedCount,allCount)
    end
end

this.GetBuffMissionReward = function()
    this.CalculateReward()
end

this.GetEventReward = function()
    local eventData = this.eventConfig[this.eventIndex]
    local config = ConfigMgr.Config.missionMap[eventData.id]
    if TableIsNull(config) then return end
    local target = MissionHelper.GetTargetCount(eventData.id)
    local tempLock = not eventData.completed and eventData.current < target
    if tempLock then
        LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,config.rewards[1].itemId,false,false,false,0,0);
    else
        local tempData = {}
        tempData.Tab = ""
        tempData.MissionID = eventData.id
        ApiMgr.Request("complete_mission",tempData,true,function(result)
            local re = json.decode(result)
            local resultData = json.encode(re.result)
            LuaMgr.ShowItemRewared(resultData,nil)
            this.vm.data.eventReward = false
            this.eventConfig[this.eventIndex].completed = true
            this.CalculateReward()
            HeroRedDataHelper.RefreshCollectorAchievementVersion2Red();
            for index, value in ipairs(this.eventScroll.screenList) do
                value:RefreshRed();
            end
        end,nil,true)
    end
end

this.NovelIsLock = function(novelId)
    local len = #DataMgr.Player.completedChapters
    for i = 1, len do
        if (DataMgr.Player.completedChapters[i] == novelId) then
            return false
        end
    end
    return true
end


this.GetBuffConfig = function()
    if not TableIsNull(this.buffConfig) then return end
    this.buffConfig = {}
    local LangIndex = 3
    local tempBuff = nil
    for i = 1, #ConfigMgr.Config.YX2Buffs do
        tempBuff = table.Copy(ConfigMgr.Config.YX2Buffs[i])
        tempBuff.choose = false
        tempBuff.lock = this.GetBuffLock(tempBuff.Id)
        if TableIsNull(this.buffConfig[tempBuff.Type[2]]) then
            this.buffConfig[tempBuff.Type[2]] = {}
            this.buffConfig[tempBuff.Type[2]].buff = {}
            this.buffConfig[tempBuff.Type[2]].typeStr = ConfigMgr.LangGlobal("718"..LangIndex)
            LangIndex = LangIndex + 1
        end
        table.insert(this.buffConfig[tempBuff.Type[2]].buff,tempBuff)
    end
    for i = 1, #this.buffConfig do
        table.sort(this.buffConfig[i].buff,this.BuffSort)
    end
end
this.GetBuffLock = function(id)
    if not IsNullOrEmpty(id) then
        if not TableIsNull(DataMgr.Player.practiceStage2.longBuffs) then
            for i = 1, #DataMgr.Player.practiceStage2.longBuffs do
                if DataMgr.Player.practiceStage2.longBuffs[i] == id then
                    return false
                end
            end
        end
    end
    return true
end
this.BuffSort = function(item1,item2)
    if item1.lock == item2.lock then
        return item1.Type[1] > item2.Type[1]
    else
        return not item1.lock and item2.lock
    end
end


this.GetEventConfig = function()
    if not TableIsNull(this.eventConfig) then return end
    this.eventConfig = {}
    local tempData = DataMgr.Player.missions["YX2Event"]["701"]
    if TableIsNull(tempData) then return end
    for key,value in pairs(tempData) do
        table.insert(this.eventConfig,value)
    end
    table.sort(this.eventConfig,this.EventSort)
end
this.EventSort = function(item1,item2)
    if item1.completed == item2.completed then
        return item1.id < item2.id
    else
        return item1.completed and not item2.completed
    end
end


this.GetNovelConfig = function()
    if not TableIsNull(this.novelConfig) then return end
    this.novelConfig = {}
    for key,value in pairs(ConfigMgr.Config.YX2NarrativeMap) do
        table.insert(this.novelConfig,value)
    end
    table.sort(this.novelConfig,this.NovelSort)
end
this.NovelSort = function(item1,item2)
    return item1.Id < item2.Id
end
return vm({
    data = data,
    command = command,
    hook = hook
})