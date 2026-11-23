





local this = {
    vm = nil,bangScrollIndex = 0,
    rewardNodeH = nil,rewardNodeV = nil,
    rewardListH = nil,rewardListV = nil,
    rewardMaskListH = nil,rewardMaskListV = nil,
    gridNodeList = nil,gridAnimNode = {},
    isTime = false,animIndex = nil,
    randomRange = nil,material = nil,
    bangScrollId = nil,bangScrollCount = 0,
    leftAnim = nil,rightAnim = nil,
}

local data = {
    introText = "",complete = DefaultTexture,timeText = "",
    materialIcon = DefaultTexture,materialCount = "",
    oneBtnText = "",leftObj = false,rightObj = false,
    missionRed = false,
}

local command = {
    leftCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.bangScrollIndex > 1 then
                this.bangScrollIndex = this.bangScrollIndex - 1
                this.SetSwitchBtn()
                local tempConfig = this.GetBangScrollConfig()
                if TableIsNull(tempConfig) then
                    return
                end
                this.bangScrollId = tempConfig[1].Type
                this.SetActivityInfo(tempConfig)
                this.GetRandomRange()
                if this.bangScrollIndex + 1 >= this.bangScrollCount then
                    this.leftAnim:Play("ani_TurnOverGridPanel_Btn",0,0)
                    this.rightAnim:Play("ani_TurnOverGridPanel_Btn2",0,0)
                end
            end
        end
    },
    rightCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.bangScrollIndex < this.bangScrollCount then
                this.bangScrollIndex = this.bangScrollIndex + 1
                this.SetSwitchBtn()
                local tempConfig = this.GetBangScrollConfig()
                if TableIsNull(tempConfig) then
                    return
                end
                this.bangScrollId = tempConfig[1].Type
                this.SetActivityInfo(tempConfig)
                this.GetRandomRange()
                if this.bangScrollIndex - 1 <= 1 then
                    this.leftAnim:Play("ani_TurnOverGridPanel_Btn",0,0)
                    this.rightAnim:Play("ani_TurnOverGridPanel_Btn2",0,0)
                end
            end
        end
    },
    missionCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.isTime then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("15901"))
                return
            end
            LuaMgr.ShowLuaPanel(UIName.TurnOverMissionPopup,this.UpdateMaterial)
        end
    },
    oneBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.isTime then
                AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/climb_click-001.mp3")
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("15901"))
                return
            end
            if TableIsNull(this.randomRange) then
                AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/climb_click-001.mp3")
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("26503"))
                return
            end
            DataHelper.ConditionCheck(this.material.id,this.material.count,this.ExploreGrid)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.rewardNodeH = vm.behaviour.transform:Find("root/Middle/GridBg/Complete/RewardH"):GetComponent("Transform")
        this.rewardNodeV = vm.behaviour.transform:Find("root/Middle/GridBg/Complete/RewardV"):GetComponent("Transform")
        this.leftAnim = vm.behaviour.transform:Find("root/Middle/Left"):GetComponent("Animator")
        this.rightAnim = vm.behaviour.transform:Find("root/Middle/Right"):GetComponent("Animator")
        this.bgmComp = vm.behaviour.transform:GetComponent("UIPanelSound")
        this.bgmComp.bgmPath = "Assets/_BundleResources/Audio/Bgm/Bgm_Active_HangHaiBOSS_01.mp3"
        this.GetGridNode()
        this.GetRewardMaskNode()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.SetLanguageText()
        this.SetActivityTime()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
        this.ClearReward()
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
    this.vm.data.introText = ConfigMgr.LangGlobal("26501")
    this.vm.data.oneBtnText = ConfigMgr.LangGlobal("26502")
end

this.SetActivityTime = function()
    this.isTime = false
    local groupId = ActivityMgr.groupKeyList[ActivityKey.NewCelebration]
    local activityData = DataMgr.Player.variables[groupId]
    if activityData == nil then
        return
    end
    local endTime = activityData.delTime
    local surplusTime = endTime - LuaMgr.Timestamp()
    if surplusTime <= 0 then
        this.isTime = false
    else
        this.isTime = true
        local timeFormat = ConfigMgr.LangGlobal("10908")
        local d,h,m = GetTimeDHM2(surplusTime)
        local timeStr = string.format(timeFormat,d,h,m)
        local timeTipStr = ConfigMgr.LangGlobal("26504")
        this.vm.data.timeText = string.format(timeTipStr,timeStr)
    end
end


this.InitParameter = function()
    if not this.isTime then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("15901"))
        return
    end
    this.bangScrollCount = math.ceil(ConfigHelper.GetTableLength(ConfigMgr.Config.BangScrollMap) / 10)
    this.GetCurrentIndex()
    this.SetMaterial()
    this.SetSwitchBtn()
    this.leftAnim:Play("ani_TurnOverGridPanel_Btn",0,0)
    this.rightAnim:Play("ani_TurnOverGridPanel_Btn2",0,0)
    this.vm.data.missionRed = HeroRedDataHelper.GetTurnOverMissionRed() > 0
end

this.GetCurrentIndex = function()
    local tempConfig = nil
    for i = 1, this.bangScrollCount do
        this.bangScrollIndex = i
        tempConfig = this.GetBangScrollConfig()
        if not TableIsNull(tempConfig) then
            this.bangScrollId = tempConfig[1].Type
        end
        if not IsNullOrEmpty(this.bangScrollId) then
            if DataMgr.Player.BangScrollMap[this.bangScrollId] == nil then
                break
            else
                if NumTool.GetLen(DataMgr.Player.BangScrollMap[this.bangScrollId].ScrollGrids) < 16 then
                    break
                end
            end
        end
    end
    this.SetActivityInfo(tempConfig)
    this.GetRandomRange()
end

this.SetActivityInfo = function(bangScroll)
    local path = Path.TurnOverGridBg..this.bangScrollId..".png"
    this.vm.data.complete = LuaMgr.GetTexture(path)
    if this.rewardNodeH == nil or this.rewardNodeV == nil then
        return
    end
    if this.rewardListH == nil then
        this.rewardListH = {}
    end
    if this.rewardListV == nil then
        this.rewardListV = {}
    end
    local itemConfig = nil
    local id,count = nil,nil
    local index = 0
    for i = 1, #bangScroll do
        id = bangScroll[i].Reward[1].id
        count = bangScroll[i].Reward[1].count
        itemConfig = table.Copy(ConfigMgr.Config.itemMap[id])
        if TableIsNull(itemConfig) then return end
        itemConfig["count0"] = count
        if i < 6 then
            if #this.rewardListV < i then
                table.insert(this.rewardListV,GoodsDataItem.New(this.rewardNodeV))
            end
            this.rewardListV[i]:SetData(i,itemConfig,1,false,Vector3(0.7,0.7,0.7),false)
        else
            index = i - 5
            if #this.rewardListH < index then
                table.insert(this.rewardListH,GoodsDataItem.New(this.rewardNodeH))
            end
            this.rewardListH[index]:SetData(index,itemConfig,1,false,Vector3(0.7,0.7,0.7),false)
        end
    end
    this.SetRewardMask(bangScroll)
end

this.SetRewardMask = function(bangScroll)
    if TableIsNull(bangScroll) then
        return
    end
    local index = 0
    for i = 1, #bangScroll do
        if i < 6 then
            SetActive(this.rewardMaskListV[i],this.GetRewardLines(bangScroll[i].Id))
        else
            index = i - 5
            SetActive(this.rewardMaskListH[index],this.GetRewardLines(bangScroll[i].Id))
        end
    end
end


this.GetRandomRange = function()
    this.randomRange = {}
    for i = 1, #this.gridNodeList do
        SetActive(this.gridAnimNode[i].effect,false)
        if DataMgr.Player.BangScrollMap[this.bangScrollId] == nil or
                DataMgr.Player.BangScrollMap[this.bangScrollId].ScrollGrids[tostring(i)] == nil then
            table.insert(this.randomRange,i)
            this.gridNodeList[i].enabled = true
        else
            this.gridNodeList[i].enabled = false
        end
        this.gridAnimNode[i].anim:Play("ani_TurnOverGridPanel_Complete_0",0,0)
    end
end

this.UpdateMaterial = function()
    this.SetMaterial()
    this.vm.data.missionRed = HeroRedDataHelper.GetTurnOverMissionRed() > 0
end

this.SetMaterial = function()
    if TableIsNull(ConfigMgr.Config.BangGameConstants) then
        return
    end
    this.material = ConfigMgr.Config.BangGameConstants.ScrollCost[1]
    if TableIsNull(this.material) then
        return
    end
    this.vm.data.materialIcon = LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(this.material.id))
    local countStr = nil
    local haveCount = DataHelper.GetItemCountById(this.material.id)
    if haveCount >= this.material.count then
        countStr = this.material.count
    else
        countStr = "<color=#FF4343>"..this.material.count.."</color>"
    end
    this.vm.data.materialCount = countStr
end

this.SetSwitchBtn = function()
    this.vm.data.leftObj = this.bangScrollIndex > 1
    this.vm.data.rightObj = this.bangScrollIndex < this.bangScrollCount
end

this.ExploreGrid = function()
    if IsNullOrEmpty(this.bangScrollId) then
        return
    end
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    local index = this.randomRange[math.random(1, #this.randomRange)]
    this.animIndex = index
    ApiMgr.Request("bang/puzzle", { Id = this.bangScrollId,Numbers = { index }}, true, this.ExploreGridResponse, nil, true, true);
end

this.ExploreGridResponse = function(result)
    local re = json.decode(result)
    if re.code == 0 then
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."DaQin/DQ_YP_12.mp3")
        this.GetRandomRange()
        this.SetMaterial()
        if this.animIndex ~= nil then
            this.gridNodeList[this.animIndex].enabled = true
            this.gridAnimNode[this.animIndex].anim:Play("ani_TurnOverGridPanel_Complete",0,0)
            SetActive(this.gridAnimNode[this.animIndex].effect,true)
        end
        if type(re.result.Rewards) ~= "function" and not TableIsNull(re.result.Rewards) then
            local rewards = json.encode(re.result.Rewards)
            LuaMgr.ShowItemRewared(rewards)
            local tempConfig = this.GetBangScrollConfig()
            this.SetRewardMask(tempConfig)
        end
    end
end

this.GetRewardLines = function(id)
    if DataMgr.Player.BangScrollMap[this.bangScrollId] == nil then
        return false
    else
        if DataMgr.Player.BangScrollMap[this.bangScrollId].GetLines[tostring(id)] ~= nil then
            return true
        end
    end
    return false
end

this.GetBangScrollConfig = function()
    local tempList = {}
    local minIndex = (this.bangScrollIndex - 1) * 10
    local maxIndex = this.bangScrollIndex * 10
    for _,value in pairs(ConfigMgr.Config.BangScrollMap) do
        if value.Id > minIndex and value.Id <= maxIndex then
            table.insert(tempList,value)
        end
    end
    table.sort(tempList, function(a, b)
        return a.Id < b.Id
    end)
    return tempList
end

this.ClearReward = function()
    if not TableIsNull(this.rewardListV) then
        for i = 1, #this.rewardListV do
            this.rewardListV[i]:Clear()
        end
        this.rewardListV = nil
    end
    if not TableIsNull(this.rewardListH) then
        for i = 1, #this.rewardListH do
            this.rewardListH[i]:Clear()
        end
        this.rewardListH = nil
    end
end

this.GetGridNode = function()
    this.gridNodeList = {}
    this.gridAnimNode = {}
    local parentTran = this.vm.behaviour.transform:Find("root/Middle/GridBg/Complete/Grid"):GetComponent("Transform")
    local object = nil
    local animator = nil
    local effectNode = nil
    local image = nil
    for i = 1, parentTran.childCount do
        object = parentTran:Find(i).gameObject
        image = object:GetComponent("Image")
        table.insert(this.gridNodeList,image)
        animator = object:GetComponent("Animator")
        effectNode = object.transform:Find("UI_Effect_TurnOver").gameObject
        table.insert(this.gridAnimNode,{anim = animator,effect = effectNode})
    end
    parentTran,object,animator,effectNode,image = nil,nil,nil,nil,nil
end

this.GetRewardMaskNode = function()
    local parentTran = this.vm.behaviour.transform:Find("root/Middle/GridBg/Complete/MaskH"):GetComponent("Transform")
    local object = nil
    local name = "Mask"
    this.rewardMaskListH = {}
    for i = 1, parentTran.childCount do
        object = parentTran:Find(name..i).gameObject
        table.insert(this.rewardMaskListH,object)
    end
    parentTran = this.vm.behaviour.transform:Find("root/Middle/GridBg/Complete/MaskV"):GetComponent("Transform")
    this.rewardMaskListV = {}
    for i = 1, parentTran.childCount do
        object = parentTran:Find(name..i).gameObject
        table.insert(this.rewardMaskListV,object)
    end
    parentTran,object,name = nil,nil,nil
end

return vm({
    data = data,
    command = command,
    hook = hook
})