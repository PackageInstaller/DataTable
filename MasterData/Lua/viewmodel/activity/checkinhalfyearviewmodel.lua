
local this = {
    vm = nil, rareSprite = nil,iconTexture = nil,countText = nil,
    getBtnObj = nil,groupId = 809,missionId = nil,goods = nil,nameText = "",leftTime = 0
}

local data = {

}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.CheckInHalfYearViewModel)
        end
    },
    getCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            DataExHelper.EX_GetAward(this.missionId,function()
                LuaMgr.HidePanel(UIName.CheckInHalfYearViewModel)
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
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveTimer(TimerConst.CheckInHalfYearTimer)
    end,
    before_destroy = function(vm)
        this = nil
    end,
}


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
    this.countText.text = this.goods.count

    if  DataMgr.Player.quests[activityData[1].id].state == 3 then
        SetActive(this.FinishBtn,true);
        SetActive(this.FinishIcon,true);
        SetActive(this.getBtnObj,false);
    else
        SetActive(this.FinishBtn,false);
        SetActive(this.FinishIcon,false);
        SetActive(this.getBtnObj,true);
    end
    
    local variables=DataExHelper.GetDataExByTag(ActivityKey.checkInHalfYear)
    this.leftTime = variables.expireTime
    LuaMgr.AddTimer(TimerConst.CheckInHalfYearTimer, this.UpdateLeftTime, 1, -1, true)
end

this.UpdateLeftTime = function()
    if this.leftTime <= 0 then
        return
    end
    local leftTime = this.leftTime - LuaMgr.Timestamp();
    if leftTime<0 then leftTime=0 end;
    local d, h, m, s = GetTimeDHMS(leftTime)
    local timeStr = ""
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    else
        h, m, s=GetTimeHMS(leftTime)
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("2121"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
    end
    if (not IsNullOrEmpty(s)) then
        timeStr = timeStr .. string.format("%s%s", tostring(s), ConfigMgr.LangGlobal("10368"));
    end
    this.timeText.text = timeStr
end

return vm({
    data = data,
    command = command,
    hook = hook
})