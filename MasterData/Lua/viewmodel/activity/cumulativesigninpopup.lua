





local this = {
    vm = nil,signinData = nil,curIndex = 0,totalLength = 0,
    characterId = nil,skinId = nil,
}

local data = {
    dayText = "",dayTipText = "",signinIntro = "",
    leftBtn = false,rightBtn = false,
    rightTipText_1 = "",rightTipText_2 = "",
    giftOne = false,
    giftTwo = false,
    giftList = {{rare = DefaultSprite,icon = DefaultTexture,name = "",already = false,id = ""},
                {rare = DefaultSprite,icon = DefaultTexture,name = "",already = false,id = ""}},
    rewardSkin = false,rewardSkinName = "",nullRoot = false,
    getBtn = false,alreadyGet = false,
    conditionsList = {{already = false,conditionsText = "",}},
    barImgList = {{nowActive = false}}
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.CumulativeSignInPopup)
        end
    },
    iconCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param)
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,this.vm.data.giftList[index].id,false,false,false)
        end
    },
    leftCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.curIndex - 1 < 1 then
                return
            end
            this.curIndex = this.curIndex - 1
            this.SetSigninData()
            this.UpdateBarImg()
        end
    },
    rightCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.curIndex + 1 > this.totalLength then
                return
            end
            this.curIndex = this.curIndex + 1
            this.SetSigninData()
            this.UpdateBarImg()
        end
    },
    gotoSkinCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if IsNullOrEmpty(this.characterId) or IsNullOrEmpty(this.skinId) then
                return
            end
            LuaMgr.HidePanel(UIName.CumulativeSignInPopup)
            LuaMgr.HidePanel(UIName.ActivitySignInMonthViewModel)
            LuaMgr.ShowLuaPanel(UIName.HeroSkinViewModel,this.characterId, this.skinId)
        end
    },
    getReward = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local tempSignin = this.signinData[this.curIndex]
            if TableIsNull(tempSignin) then
                return
            end
            DataExHelper.EX_GetAward(tempSignin.id,function()
                this.SetSigninData()
                HeroRedDataHelper.UpdateSettingRed()
                RedMgr.Singleton:RefreshOtherViewModel(UIName.SystemSettingViewModel)
                RedMgr.Singleton:RefreshOtherViewModel(UIName.ActivitySignInMonthViewModel)
            end)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
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


this.InitParameter = function()

    local redKey = DataMgr.Player.uid.."LJQD"
    if not UnityEngine.PlayerPrefs.HasKey(redKey) or PlayerPrefs.GetInt(redKey) == 0 then
        PlayerPrefs.SetInt(redKey,1)
        HeroRedDataHelper.UpdateSettingRed()
        RedMgr.Singleton:RefreshOtherViewModel(UIName.SystemSettingViewModel)
        RedMgr.Singleton:RefreshOtherViewModel(UIName.ActivitySignInMonthViewModel)
    end
    this.GetSigninData()
    this.GetCurIndex()
    this.SetBarImg()
    this.SetSigninData()
end


this.SetLanguageText = function()
    this.vm.data.dayTipText = ConfigMgr.LangGlobal("35101")
    this.vm.data.rightTipText_1 = ConfigMgr.LangGlobal("35105")
    this.vm.data.rightTipText_2 = ConfigMgr.LangGlobal("35106")
end

this.SetSigninData = function()
    if TableIsNull(this.signinData) then
        return
    end
    local tempSignin = this.signinData[this.curIndex]
    this.SetLeftData(tempSignin)
    this.SetRightData(tempSignin)
end

this.SetLeftData = function(tempSignin)
    if TableIsNull(tempSignin) then
        return
    end
    this.vm.data.signinIntro = LuaMgr.GetLangText(tempSignin.remarksLan)
    if not TableIsNull(tempSignin.conditionArgs) and #tempSignin.conditionArgs >= 2 then
        local tempList,tempItem = {},nil
        local tipStr = nil
        local isComplete = false

        tipStr = ConfigMgr.LangGlobal("35103")
        isComplete = DataMgr.Player.level >= tonumber(tempSignin.conditionArgs[1])
        tempItem = {already = isComplete,conditionsText = string.format(tipStr,DataMgr.Player.level,tempSignin.conditionArgs[1])}
        table.insert(tempList,tempItem)


        this.vm.data.dayText = string.format(ConfigMgr.LangGlobal("35102"),tempSignin.conditionArgs[2])
        tipStr = ConfigMgr.LangGlobal("35104")
        isComplete = DataMgr.Player.signCount >= tonumber(tempSignin.conditionArgs[2])
        tempItem = {already = isComplete,conditionsText = string.format(tipStr,DataMgr.Player.signCount,tempSignin.conditionArgs[2])}
        table.insert(tempList,tempItem)
        this.vm.data.conditionsList = tempList
    end
end

this.SetRightData = function(tempSignin)
    if TableIsNull(tempSignin) then
        return
    end

    local curSigninState = 1
    if DataMgr.Player.quests[tempSignin.id] ~= nil then
        curSigninState = DataMgr.Player.quests[tempSignin.id].state
    end
    if type(tempSignin.reward) ~= "function" and not TableIsNull(tempSignin.reward) then
        this.vm.data.nullRoot = false
        local rewardLength = #tempSignin.reward
        local reward = nil
        local isSkin = false
        for i = 1, rewardLength do
            reward = ConfigHelper.GetItemById(tempSignin.reward[i].id)
            if reward.type == 12 then

                isSkin = true
                break
            end
            if not TableIsNull(reward) then
                this.vm.data.giftList[i].rare = ConfigHelper.GetRareSprite(reward.rare)
                this.vm.data.giftList[i].icon = ConfigHelper.GetItemTexture(reward.id)
                this.vm.data.giftList[i].name = LuaMgr.GetLangText(reward.nameLan).."X"..tempSignin.reward[i].count
                this.vm.data.giftList[i].already = curSigninState == 3
                this.vm.data.giftList[i].id = tempSignin.reward[i].id
            end
        end
        this.vm.data.giftOne = rewardLength == 1 and (not isSkin)
        this.vm.data.giftTwo = rewardLength == 2 and (not isSkin)
        if isSkin then
            local skinData = HeroRedDataHelper.GetSkinByItemID(reward.id)
            if not TableIsNull(skinData) then
                this.characterId = skinData.characterId
                this.skinId = skinData.skinID
            end
            this.vm.data.rewardSkinName = LuaMgr.GetLangText(reward.nameLan).."X"..tempSignin.reward[1].count
        end
        this.vm.data.rewardSkin = isSkin
    else
        this.vm.data.giftOne = false
        this.vm.data.giftTwo = false
        this.vm.data.rewardSkin = false
        this.vm.data.nullRoot = true
    end
    this.vm.data.getBtn = curSigninState == 2 and type(tempSignin.reward) ~= "function"
    this.vm.data.alreadyGet = curSigninState == 3 and type(tempSignin.reward) ~= "function"
    this.vm.data.leftBtn = this.curIndex > 1
    this.vm.data.rightBtn = this.curIndex < this.totalLength
end

this.SetBarImg = function()
    local tempList,tempItem = {},nil
    for i = 1, this.totalLength do
        tempItem = {nowActive = false}
        tempItem.nowActive = i == this.curIndex
        table.insert(tempList,tempItem)
    end
    this.vm.data.barImgList = tempList
end
this.UpdateBarImg = function()
    for i = 1, #this.vm.data.barImgList do
        this.vm.data.barImgList[i].nowActive = i == this.curIndex
    end
end

this.GetSigninData = function()
    if TableIsNull(this.signinData) then
        this.signinData = DataExHelper.Check_ConfigQuestEventByText("LJQD")
    end
    this.totalLength = NumTool.GetLen(this.signinData)
end

this.GetCurIndex = function()
    this.curIndex = 1
    local tempSignin = nil
    local tempQuests = nil
    for i = 1, this.totalLength do
        tempSignin = this.signinData[i]
        if not TableIsNull(tempSignin) then
            tempQuests = DataMgr.Player.quests[tempSignin.id]
            if tempQuests ~= nil and (tempQuests.state == 1 or tempQuests.state == 2) then
                this.curIndex = i
                return
            end
        end
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})