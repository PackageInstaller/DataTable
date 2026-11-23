







require("ViewModel/Dispatch/DispatchZoneItem")
require("ViewModel/Dispatch/ListViewItem/DispatchHeroItem")
local objs = {
    heroItemTemplete = {path = "template/CharacterHead", type = UITool.GameObject},
    onekeyGetBtn = {path = "root/Left/OnekeyGetBtn", type = UITool.Button},
    onekeyCallBtn = {path = "root/Left/OnekeyCallBtn", type = UITool.Button},
    onekeyDispatchBtn = {path = "root/Left/OnekeyDispatchBtn", type = UITool.Button},
    newPictureBtn = {path = "root/Right/NewPictureBtn", type = UITool.Button},
    randomAwardBtn = {path = "root/Middle/EasterEggBtn", type = UITool.Button},
    remainJoinNum = {path = "root/Left/RemainJoinCount", type = UITool.Text},
    dispatchSuccObj = {path = "root/Middle/DispatchSuccObj", type = UITool.GameObject},
    dispatchSuccObjBG = {path = "root/Middle/DispatchSuccObjBG", type = UITool.GameObject},
    dispatchedHeroList = {path = "root/Middle/DispatchSuccObj/ScrollView", type = UITool.GameObject},
    busDispatchTime = {path = "root/Middle/DispatchSuccObj/DispatchTime", type = UITool.Text},
    animatorRoot = {path = "root", type = UITool.Animator},
    animatorEasterEgg = {path = "root/Middle/EasterEggBtn", type = UITool.Animator}
}

local this = {}
this = {
    areaCount = 6,

    zoneUIItems = {},
    TimerID = TimerConst.DispatchEnd + 9,
    newStoryAniName = "ani_DispatchMainViewModel_root_NewPictureBtn",
    dispatchSuccAniName = "ani_DispatchMainViewModel_root_DispatchSuccObj",
    rootAnimName = "ani_DispatchMainViewModel_root"
}

this.before_awake = function()
    RedMgr.Singleton:RegisterViewModel(UIName.DispatchMainViewModel)
    DispatchData.Init()
    this.dispatchedHeroListView = UIScrollView.New(this.dispatchedHeroList)
end

this.before_active = function()
    SetActive(this.newPictureBtn.gameObject, false)
    SetActive(this.dispatchSuccObj, false)
    SetActive(this.dispatchSuccObjBG, false)
    this.animatorRoot:Play(this.rootAnimName)
    if this.succTweenSeq ~= nil then
        this.succTweenSeq:Kill()
    end
    SetActive(this.randomAwardBtn.gameObject, false)
    local datas = DispatchData.GetAllDatas()
    for key, value in pairs(datas) do
        this.zoneUIItems[value.index]:SetData(value)
        this.zoneUIItems[value.index]:SetSelected(false)
    end
    this.SetBtnVisible()
    this.SetRandomAward()
    DispatchData.CheckRedPoint(false, true, true)
end

this.RefreshZoneItemTimer = function()
    this.RefreshZoneItem()
end


this.RefreshZoneItem = function(params)
    this.allZoneDatas = DispatchData.GetAllDatas()
    local datas = this.allZoneDatas
    for key, value in pairs(datas) do
        this.zoneUIItems[value.index]:SetData(value)
    end
    this.SetBtnVisible()
    if params ~= nil and params.Length > 0 then
        local param1 = params[0]
        this.OnStrongholdStatus(param1)
    end
    DispatchData.CheckRedPoint(false, true, true)
end

this.OnStrongholdStatus = function(data)
    if data == nil then
        return
    end
    local status = data.status
    local storyID = data.storyID
    this.newStoryID = nil
    if status == DispatchData.StatusChangeType.GetRewardSucc and storyID ~= nil and storyID ~= "" then
        this.newStoryID = data.storyID
        SetActive(this.newPictureBtn.gameObject, true)
        this.animatorRoot:Play(this.newStoryAniName)
    elseif status == DispatchData.StatusChangeType.DispatchSucc then
        local heroList = data.heroList
        local dispatchTime = data.dispatchTime
        this.busDispatchTime.text = tostring(math.floor(dispatchTime / 3600))
        this.dispatchedHeroListView:Clear()
        local allDatas = heroList
        local scrollDatas = {}
        local datasLen = #allDatas
        this.tempHeroDic = {}
        for i = 1, datasLen do
            local data = allDatas[i]
            local tempData = UIScrollData.GetData(this.heroItemTemplete, "DispatchHeroItem", 94.4, 94.4, data)
            table.insert(scrollDatas, tempData)
        end
        this.dispatchedHeroListView:SetParams(519, 94.4)
        this.dispatchedHeroListView:SetData(scrollDatas, true)
        this.dispatchSuccObj.transform.localPosition = Vector3(10000, 0)
        SetActive(this.dispatchSuccObj, true)
        SetActive(this.dispatchSuccObjBG, true)
        this.animatorRoot:Play(this.dispatchSuccAniName)

        local callBack = function()
            SetActive(this.dispatchSuccObjBG, false)
            SetActive(this.dispatchSuccObj, false)
        end
        this.succTweenSeq = DOTWeen:Sequence()
        local during = 2
        this.succTweenSeq:AppendInterval(during):OnComplete(callBack)
    end
end

this.SetBtnVisible = function()
    SetActive(this.onekeyGetBtn.gameObject, false)
    SetActive(this.onekeyDispatchBtn.gameObject, false)
    SetActive(this.onekeyCallBtn.gameObject, false)
    local maxCount = ConfigMgr.Config.DispatchConstants.DispatchDailyLimit
    local remainCount = maxCount - (DataMgr.Player.dailyCount.dispatchRegular or 0)
    if DispatchData.ExistStatusStronghold(DispatchData.StrongholdStatus.DispatchWait, 1) and remainCount > 0 then
        SetActive(this.onekeyDispatchBtn.gameObject, true)
    elseif DispatchData.ExistStatusStronghold(DispatchData.StrongholdStatus.DispatchEnd, 1) then
        SetActive(this.onekeyGetBtn.gameObject, true)
    elseif DispatchData.ExistStatusStronghold(DispatchData.StrongholdStatus.Dispatching, -1) then
        SetActive(this.onekeyCallBtn.gameObject, true)
    end
    this.remainJoinNum.text = string.format("%d/%d", remainCount, maxCount)
end

this.SetRandomAward = function()
    local randomAwardIndex = DispatchData.GetRandomAwardIndex()
    SetActive(this.randomAwardBtn.gameObject, randomAwardIndex ~= nil)
end

this.OnTimerRandomAward = function()
    if this.randomAwardBtn.gameObject.activeSelf then
        SetActive(this.randomAwardBtn.gameObject, false)
        LuaMgr.RemoveTimer(TimerConst.DispatchRandomAward)
    end
end



this.ClickZoneItem = function(item)
    local data = item.data
    if data == nil then
        return
    end
    if data.isUnlock == false then
        local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22316")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
        return
    end
    if data.isComplete then
        local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22315")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
        return
    end
    if this.lastZoneItem ~= nil then
        this.lastZoneItem:SetSelected(false)
    end
    this.lastZoneItem = item
    this.lastZoneItem:SetSelected(true)
    local tempData = {}
    tempData.zoneGroup = data.config.Group
    tempData.closeCallback = this.OnCloseSubPanel
    LuaMgr.ShowLuaPanel(UIName.DispatchViewModel, tempData)
end

this.OnClickOnekeyGet = function()
    LuaMgr.ShowLuaPanel(UIName.DispatchStatusPopup, DispatchData.StrongholdStatus.DispatchEnd)
end

this.OnClickOnekeyCall = function()
    local data = {}
    data.clickCallbacks = {}
    data.btnTextStrs = {}
    data.clickCallbacks[ConfirmCommonPanel.BtnType.Confirm] = this.ConfirmCallback
    data.contentStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23716")
    LuaMgr.ShowLuaPanel(UIName.ConfirmCommonPanel, ConfirmCommonPanel.MsgBoxType.ImageButton, data)
end

this.ConfirmCallback = function()
    local allDatas = DispatchData.GetAllDatas()
    local datasLen = #allDatas
    local data = {}
    data.Ids = {}
    for i = 1, datasLen do
        local strongholdData = allDatas[i]
        if strongholdData.status == DispatchData.StrongholdStatus.Dispatching then
            table.insert(data.Ids, strongholdData.id)
        end
    end
    if #data.Ids == 0 then
        return
    end
    local callback = function(result)
        local res = json.decode(result)
        if res.code ~= 0 then
            return
        end
        DispatchData.RefreshDispatchedHero()
        LuaMgr.InvokeUIEventListeners(UIEventConst.DispatchStatusChange)
    end
    ApiMgr.Request("dispatchRegular/cancel", data, true, callback, nil, true)
end

this.OnClickOnekeyDispatch = function()
    if this.allZoneDatas == nil then
        this.allZoneDatas = DispatchData.GetAllDatas()
    end
    local allDatas = this.allZoneDatas
    local datasLen = #allDatas
    local allDispatchBeforeDatas = {}
    local needPointHeroIDs = {}
    DispatchData.ClearAutoDispatchData()
    for i = 1, datasLen do
        local data = {}
        data.strongholdData = allDatas[i]
        if data.strongholdData.status == DispatchData.StrongholdStatus.DispatchWait then
            local _, _, needHeroID, _ = DispatchData.GetConditionByStronghold(data.strongholdData)
            if needHeroID ~= nil and needHeroID ~= "" then
                needPointHeroIDs[data.strongholdData.id] = needHeroID
            end
        end
    end
    for i = 1, datasLen do
        local data = {}
        data.strongholdData = allDatas[i]
        if data.strongholdData.status == DispatchData.StrongholdStatus.DispatchWait then
            data.heroList = DispatchData.ChooseHeroList(data.strongholdData, needPointHeroIDs)
            if #data.heroList > 0 and this.CheckHeroListBaseCond(data) then
                table.insert(allDispatchBeforeDatas, data)
            end
        end
    end
    if #allDispatchBeforeDatas == 0 then
        local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23718")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
        return
    end
    DispatchData.SaveArchives()
    LuaMgr.ShowLuaPanel(UIName.DispatchStatusPopup, DispatchData.StrongholdStatus.DispatchWait, allDispatchBeforeDatas)
end


this.CheckHeroListBaseCond = function(data)
    local baseCond = data.strongholdData.curTaskConfig.BaseCond
    local tempIsFull = true
    for key, condCfg in pairs(baseCond) do
        local isFull = DispatchData.CheckBaseCondition(data.heroList, condCfg)
        if isFull == false then
            tempIsFull = false
            break
        end
    end
    return tempIsFull
end

this.OnClickNewPicture = function()
    SetActive(this.newPictureBtn.gameObject, false)
    if not FeatureManager.IsLock("30097") then
        LuaMgr.ShowLuaPanel(UIName.DispatchStoryViewModel, this.newStoryID)
        this.newStoryID = nil
    end
end

this.OnClickRandomAward = function()
    local data = {}
    local onsuccess = function(result)
        local res = json.decode(result)
        if res.code ~= 0 then
            return
        end
        local reward = json.encode(res.result)
        LuaMgr.ShowItemRewared(reward)
        SetActive(this.randomAwardBtn.gameObject, false)
        DispatchData.GetRandomAward()
        LuaMgr.RemoveTimer(TimerConst.DispatchRandomAward)
    end
    ApiMgr.Request("dispatchRegular/randomReward", data, true, onsuccess, nil, true)
end

this.OnCloseSubPanel = function()
    if this.lastZoneItem ~= nil then
        this.lastZoneItem:SetSelected(false)
    end
    this.lastZoneItem = nil
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        RedMgr.Singleton:RegisterViewModel(UIName.DispatchMainViewModel)
        for i = 1, this.areaCount do
            local tempData = {}
            tempData.path = "root/Middle/ZoneGroup/ZoneBtn" .. i
            tempData.type = UITool.GameObject
            objs["zoneBtn" .. i] = tempData
        end
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.zoneUIItems = {}
        for i = 1, this.areaCount do
            local zoneUIItem = DispatchZoneItem.New(this["zoneBtn" .. i], i, this.ClickZoneItem)
            this.zoneUIItems[i] = zoneUIItem
        end
        this.before_awake()
        LuaMgr.AddClick(this.onekeyGetBtn, this.OnClickOnekeyGet)
        LuaMgr.AddClick(this.onekeyCallBtn, this.OnClickOnekeyCall)
        LuaMgr.AddClick(this.onekeyDispatchBtn, this.OnClickOnekeyDispatch)
        LuaMgr.AddClick(this.newPictureBtn, this.OnClickNewPicture)
        LuaMgr.AddClick(this.randomAwardBtn, this.OnClickRandomAward)

        LuaMgr.AddUIEventListener(UIEventConst.DispatchStatusChange, this.RefreshZoneItem)
    end,
    before_active = function(vm)
        LuaMgr.AddTimer(this.TimerID, this.RefreshZoneItemTimer, 2, -1, false)
        LuaMgr.AddTimer(TimerConst.DispatchRandomAward, this.OnTimerRandomAward, 300, 1, false)
        this.before_active()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(this.TimerID)
        LuaMgr.RemoveTimer(TimerConst.DispatchRandomAward)
    end,
    before_destroy = function(vm)
        DispatchData.SaveArchives()
        LuaMgr.RemoveClick(this.onekeyGetBtn, this.OnClickOnekeyGet)
        LuaMgr.RemoveClick(this.onekeyCallBtn, this.OnClickOnekeyCall)
        LuaMgr.RemoveClick(this.onekeyDispatchBtn, this.OnClickOnekeyDispatch)
        LuaMgr.RemoveClick(this.newPictureBtn, this.OnClickNewPicture)
        LuaMgr.RemoveClick(this.randomAwardBtn, this.OnClickRandomAward)

        LuaMgr.RemoveUIEventListener(UIEventConst.DispatchStatusChange, this.RefreshZoneItem)
        for key, value in pairs(this.zoneUIItems) do
            value:Clear()
        end
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)