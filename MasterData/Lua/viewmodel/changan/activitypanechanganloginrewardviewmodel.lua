

local this = {
    vm = nil, rareSprite = nil,iconTexture = nil,countText = nil,
    getBtnObj = nil,groupId = 801,missionId = nil,goods = nil,nameText = "",
    currenTime=nil,
}

local data = {

}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.ChanganLoginRewardViewModel)
        end
    },
    getCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            DataExHelper.EX_GetAward(this.missionId,function()
                this.InitParameter()
                local groupId=tostring(this.groupId);
                RedMgr.Singleton:UpdateClientRedData(ConfigMgr.Config.activityGroup[groupId].RedId,0);
                RedMgr.Singleton:Refresh();


            end)
        end
    },
    goodsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,this.goods.id,false,false,false)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.rareSprite = vm.behaviour.transform:Find("root/Middle/Group/Good/Rare"):GetComponent("Image")
        this.iconTexture = vm.behaviour.transform:Find("root/Middle/Group/Good/RawImage"):GetComponent("RawImage")
        this.countText = vm.behaviour.transform:Find("root/Middle/Group/Good/Count/Text"):GetComponent("Text")
        this.getBtnObj = vm.behaviour.transform:Find("root/Middle/Group/GetBtn").gameObject
        this.nameText = vm.behaviour.transform:Find("root/Middle/Group/Name/Text"):GetComponent("Text")
        this.timeText = vm.behaviour.transform:Find("root/Middle/Group/Time/timeText"):GetComponent("Text")
        this.FinishIcon = vm.behaviour.transform:Find("root/Middle/Group/Good/FinishIcon").gameObject
        this.FinishBtn = vm.behaviour.transform:Find("root/Middle/Group/FinishBtn").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
        this.InitTime();
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
    LuaMgr.RemoveTimer(TimerConst.Countdown)
    LuaMgr.AddTimer(TimerConst.Countdown,this.RefreshTime,1,-1,false)
end
this.RemoveUIEvent = function()
    LuaMgr.RemoveTimer(TimerConst.Countdown)
end


this.InitParameter = function()

    local activityData = DataExHelper.Check_ConfigQuestEventByGroupId(this.groupId)
    this.missionId = activityData[1].id
    this.goods = activityData[1].showReward[1]
    local tempData = DataMgr.Player.quests[this.missionId]
    SetActive(this.getBtnObj,tempData.state ~= 3)
    local tempConfig = ConfigMgr.Config.itemMap[this.goods.id]
    this.rareSprite.sprite = GetRareSprite(tempConfig.rare)
    this.iconTexture.texture = GetItemTexture(tempConfig.id)
    this.nameText.text = LuaMgr.GetLangText(tempConfig.nameLan)
    this.countText.text = this.goods.count;
    if  DataMgr.Player.quests[activityData[1].id].state == 3 then
        SetActive(this.FinishBtn,true);
        SetActive(this.FinishIcon,true);
        SetActive(this.getBtnObj,false);
    else
        SetActive(this.FinishBtn,false);
        SetActive(this.FinishIcon,false);
        SetActive(this.getBtnObj,true);
    end
end

this.InitTime=function ()
    this.currenTime = LuaMgr.Timestamp();
    local time=DataMgr.Player.variables["group."..this.groupId].delTime-this.currenTime;
    local timeFormat=ConfigMgr.LangGlobal("15701");
    local day=math.floor(time/86400);
    local hours=math.floor((time%86400)/3600);
    local minute=math.floor((time%3600)/60);
    local second=math.ceil((time%60));
    this.timeText.text=string.format(timeFormat,day,hours,minute,second);
end
this.RefreshTime=function ()
    this.currenTime=this.currenTime+1;
    local time=DataMgr.Player.variables["group."..this.groupId].delTime-this.currenTime;
    local timeFormat=ConfigMgr.LangGlobal("15701");
    local day=math.floor(time/86400);
    local hours=math.floor((time%86400)/3600);
    local minute=math.floor((time%3600)/60);
    local second=math.ceil((time%60));
    this.timeText.text=string.format(timeFormat,day,hours,minute,second);
end

return vm({
    data = data,
    command = command,
    hook = hook
})