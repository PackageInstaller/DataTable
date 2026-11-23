require("CollectorPractice/ViewModel/YXTwoBuffGroupViewModel")
require("CollectorPractice/ViewModel/YXTwoBuffItemViewModel")
local this = {
    vm = nil,labelEnum = {buff = "buff",event = "event",novel = "novel"},curLabel = nil,

    nowSelectType=-1,
    buttonIndexToType={},
    buttonIndex=-1,
    buffConfig = nil,buffType = nil,
    buffGroupIndex = nil,buffIndex = nil,
    buffScroll = nil,buffGroup = nil,buffTemplate = nil,
    buffCompletedCount = nil,
    rewardCountFormat = "%d<color=#BBB09A><size=20>/%d</size></color>",
    eventCountFormat = "%d<color=#262429><size=20>/%d</size></color>",
}

local data = {
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
    
    buffTypeList = {{normal = false,normalImg = DefaultSprite,choose = false,chooseImg = DefaultSprite}}
}

local command = {
    buffTypeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = param + 1
            local buffType=this.buttonIndexToType[index];
            if buffType == this.buffType then return end
            if this.buffType > 0 then
                this.vm.data.buffTypeList[this.buttonIndex].choose = false
            end
            this.buffType = buffType
            this.buttonIndex=index;
            local str = ConfigMgr.LangGlobal("718"..tostring(3+buffType-1))
            this.vm.data.infoTypeText = str
            this.vm.data.buffTypeIntro = string.format(ConfigMgr.LangGlobal("7199"),str)
            this.vm.data.buffTypeList[index].choose = true
            this.SetBuffView()
            this.buffIndex = -1
            this.buffGroupIndex = -1
            this.ChooseBuff(1,1)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.buffGroup = this.vm.behaviour.transform:Find("template/BuffGroup").gameObject
        this.buffTemplate = this.vm.behaviour.transform:Find("template/BuffItem").gameObject
        this.buffScroll = UIScrollView.New(vm.behaviour.transform:Find("root/_Middle/BuffRoot/BuffView/Scroll").gameObject)
        this.curLabel = this.labelEnum.buff;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.SetLanguageText()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.buffScroll:Clear(false)
        this.buffConfig = nil
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

end
this.RemoveUIEvent = function()

end


this.InitParameter = function()
    this.curLabel = this.labelEnum.buff
    this.buffCompletedCount = 0
    this.buffType = -1
    this.buttonIndex=-1;
    this.nowSelectType=-1;
    this.buttonIndexToType={};
    this.GetBuffConfig()
    this.SetBuffType()
    command.buffTypeCommand.execute(nil,0)
end


this.SetLanguageText = function()
    this.vm.data.buffLabelText = ConfigMgr.LangGlobal("7196")
end


this.SetBuffType = function()
    local tempItem,tempList = {},{}
    local length = #CollectorPracticeMgrVersion2.ReawrdTypeBuffMap
for i = 1, length do
if not TableIsNull(this.buffConfig[i]) then
            tempItem = {normal = true,normalImg = nil,choose = false,chooseImg = nil}
            tempItem.normalImg = LuaMgr.GetSprite("CollectorBuffTypeIcon","ui_sx_sj_buficon_"..i.."_1")
            tempItem.chooseImg = LuaMgr.GetSprite("CollectorBuffTypeIcon","ui_sx_sj_buficon_"..i.."_2")
            table.insert(tempList,tempItem)
            this.buttonIndexToType[#tempList]=i;
        end
    end
    this.vm.data.buffTypeList = tempList
end


this.SetBuffView = function()
    this.buffScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local index = 1
    local length = #this.buffConfig[this.buffType].buff
    local tempBuff = nil
    while(index <= length) do
        groupData = {}
        groupData.item = this.buffTemplate
        groupData.spaceX = 35
        groupData.buff = {}
        groupData.fun = this.ChooseBuff
        for i = 1, 4 do
            if this.buffConfig[this.buffType].buff[index + i - 1] ~= nil then
                tempBuff = this.buffConfig[this.buffType].buff[index + i - 1]
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



this.GetBuffConfig = function()
    if not TableIsNull(this.buffConfig) then return end
    this.buffConfig = {}
    local tempBuff = nil
    for index, value in ipairs(DataMgr.Player.practiceStage2.buffs) do
        tempBuff = table.Copy(CollectorPracticeMgrVersion2.GetBuffValueById(value))
        tempBuff.choose = false
        tempBuff.lock = false;
        if TableIsNull(this.buffConfig[tempBuff.Type[2]]) then
            this.buffConfig[tempBuff.Type[2]] = {}
            this.buffConfig[tempBuff.Type[2]].buff = {}
        end
        table.insert(this.buffConfig[tempBuff.Type[2]].buff,tempBuff)
    end
    for i = 1, 7,1 do
        if this.buffConfig[i]~=nil then
            table.sort(this.buffConfig[i].buff,this.BuffSort)
        end
    end
end

this.BuffSort = function(item1,item2)
    if item1.lock == item2.lock then
        return item1.Type[1] > item2.Type[1]
    else
        return not item1.lock and item2.lock
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})