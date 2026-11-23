



require("ViewModel/Activity/SignIn7DaysItem")
require("ViewModel/Activity/SignIn7DaysGoodsItem")
local this = {
    vm = nil,groupId = nil, activityData = nil, activityConfig = nil, 
    questEvents = nil,

    signInScrollOne = nil,
    signInTemplateOnt = nil,





    tipGoodsList = nil,
    tipsGoodContentOne = nil,
}

local data = {
    phaseOne = false,

    timeText = "",
}

local command = {
    jumpCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.DHShopViewModel,ActivityKey.checkIn7Days);
        end
    },
}


local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.tipsGoodContentOne = this.vm.behaviour.transform:Find("root/Middle/Phase/Tips/GoodsList"):GetComponent("RectTransform")
        this.signInTemplateOnt = this.vm.behaviour.transform:Find("template/SignInItemOne").gameObject
        this.goodsItemObj=this.vm.behaviour.transform:Find("template/GoodsItem").gameObject;
        this.signInScrollOne =  UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Phase/SignInScroll").gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("SignIn7DaysItem")
        UIListView.ClearItem("SignIn7DaysGoodsItem")
        this.ClearReward()
        this = nil
    end,
}



this.InitParameter = function()
    this.activityData=DataExHelper.GetDataExByTag(ActivityKey.checkIn7Days);
    if this.activityData == nil or this.TimeExpired()  then
        return
    end
    this.SetActivityTime()
    this.questEvents = DataExHelper.Check_ConfigQuestEventByText("checkIn7DaysText")
    if TableIsNull(this.questEvents) then
        return
    end
    table.sort(this.questEvents,this.QuestSort)
    this.CreateSignInItem()
    this.CreateTipGoodsItem()
    
end




this.SetActivityTime = function()
    local startTimeStr = ""
    local delayTimeStr = ""
    if this.activityData ~= nil then
        startTimeStr = os.date(LuaMgr.GetLangText("SignIn7DaysActivityViewModel_0"),this.activityData.startTime)
        delayTimeStr = os.date(LuaMgr.GetLangText("SignIn7DaysActivityViewModel_1"),this.activityData.delTime)
    end
    local tipStr = ConfigMgr.LangGlobal("15014")
    local timeStr = string.format("%s-%s",startTimeStr,delayTimeStr)
    this.vm.data.timeText = tipStr..timeStr
end


this.CreateSignInItem = function()
    this.signInScrollOne:Clear()
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local state = 0
    for i,v in ipairs(this.questEvents) do
        if DataMgr.Player.quests[v.id]~=nil then
            state = DataMgr.Player.quests[v.id].state
        end
        groupData = {
            index=i,
            state=state,
            dayName=LuaMgr.GetLangText(v.remarksLan),
            items=v.reward,
            callBack=this.ItemCallback;
            goodsItemObj=this.goodsItemObj
        }
        scrollData = UIScrollData.GetData(this.signInTemplateOnt,"SignIn7DaysItem",148 - 10,332,groupData)
        table.insert(scrollDatas,scrollData)
    end
    this.signInScrollOne:SetParams(976.8,355)
    this.signInScrollOne:SetPadding(0,15,0,0)
    this.signInScrollOne:SetData(scrollDatas, true)
   
end

this.ItemCallback=function(index)
    local questId=this.questEvents[index].id
    DataExHelper.EX_GetAward(questId,function()
        table.sort(this.questEvents,this.QuestSort)
        this.CreateSignInItem()
        HeroRedDataHelper.CheckIn7DaysRed();
        RedMgr.Singleton:Refresh();
    end)
end

this.CreateTipGoodsItem = function()
    local content = nil
    content = this.tipsGoodContentOne
    if TableIsNull(this.tipGoodsList) then
        this.tipGoodsList = {}
    end
    local itemConfig = nil
    local id,count = nil,nil
    local index = 1
    for i = 1, #this.questEvents do
        if i == 1 or i == 3 or i == 5 or i == 7 then
            local rewardList=this.questEvents[i].reward;
            if not IsNull(rewardList) and #rewardList>0 then
                local reward=#rewardList>1 and rewardList[2] or rewardList[1];
                id = reward.id
                count = reward.count
                itemConfig = table.Copy(ConfigMgr.Config.itemMap[id])
                if TableIsNull(itemConfig) then return end
                if #this.tipGoodsList < index then
                    table.insert(this.tipGoodsList,GoodsDataItem.New(content))
                end
                itemConfig["count0"] = count
                this.tipGoodsList[index]:SetData(index,itemConfig,1,false,Vector3(0.6,0.6,0.6),false)
                index = index + 1
            end
        end
    end
end

this.ClearReward = function()
    if TableIsNull(this.tipGoodsList) then return end
    for i = 1, #this.tipGoodsList do
        this.tipGoodsList[i]:Clear()
    end
    this.tipGoodsList = nil
end


this.TimeExpired = function()
    local nowTime = LuaMgr.Timestamp()
    local isExpired = false
    if nowTime < this.activityData.startTime or nowTime >= this.activityData.delTime then
        isExpired = true
    end
    return isExpired
end

this.QuestSort = function(item1,item2)
    return item1.progress < item2.progress
end

return vm({
    data = data,
    command = command,
    hook = hook
})