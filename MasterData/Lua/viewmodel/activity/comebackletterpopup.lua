





local this = {
    vm = nil,rewardContent = nil,rewardData = nil,mission = nil,middleAnim = nil,
}

local data = {
    letterText = "",getReward = false,alreadyGet = false,animName = "",
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.ComeBackLetterPopup)
        end
    },
    getRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            DataExHelper.EX_ComeBackComplete(this.mission.id,"backLetter",
            function()
                LuaMgr.InvokeUIEventListeners(UIEventConst.ComeBackLetterRedPoint)
                LuaMgr.HidePanel(UIName.ComeBackLetterPopup)
            end)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.rewardContent = vm.behaviour.transform:Find("root/Middle/RewardList")
        this.middleAnim = vm.behaviour.transform:Find("root/Middle"):GetComponent("Animator")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this.ClearRewardData()
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()
    LuaMgr.RemoveTimer(TimerConst.ComeBackLetterAnim)
end


this.InitParameter = function()
    if not DataExHelper.Check_ComeBackActivity() then
        return
    end
    this.SetLanguageText()
    
    this.mission = nil
    for key,value in pairs(ConfigMgr.Config.BackPlayerTaskMap) do
        if value.tab == "backLetter" and value.type == "454" then
            this.mission = value
            break
        end
    end
    local tempData = DataMgr.Player.backPlayerMissions[this.mission.tab][this.mission.id]
    this.vm.data.alreadyGet = TableIsNull(tempData) or tempData.completed
    this.vm.data.getReward = not TableIsNull(tempData) and not tempData.completed
    
    this.SetReward()
    this.vm.data.animName = "ani_ComeBackLetterPopup_enter"
    LuaMgr.RemoveTimer(TimerConst.ComeBackLetterAnim)
    LuaMgr.AddTimer(TimerConst.ComeBackLetterAnim,function()
        this.middleAnim:Play("ani_ComeBackLetterPopup_middleLoop",0,0)
    end,0.78,1,false)
end


this.SetLanguageText = function()
    this.vm.data.letterText = ConfigMgr.LangGlobal("10910")
end


this.SetReward = function()
    if not TableIsNull(this.mission.rewards) then
        if TableIsNull(this.rewardData) then
            this.rewardData = {}
        end
        local itemConfig,tempItem = nil,nil
        for i = 1, #this.mission.rewards do
            if this.rewardData[i] == nil then
                tempItem = GoodsDataItem.New(this.rewardContent)
                itemConfig = table.Copy(ConfigMgr.Config.itemMap[this.mission.rewards[i].itemId])
                itemConfig["count0"] = this.mission.rewards[i].count
                tempItem:SetData(i,itemConfig,1,false,Vector3(0.8,0.8,0.8),false)
                table.insert(this.rewardData,tempItem)
            end
        end
    end
end

this.ClearRewardData = function()
    for i = #this.rewardData,1,-1 do
        this.rewardData[i]:Clear()
    end
    this.rewardData = nil
end

return vm({
    data = data,
    command = command,
    hook = hook
})