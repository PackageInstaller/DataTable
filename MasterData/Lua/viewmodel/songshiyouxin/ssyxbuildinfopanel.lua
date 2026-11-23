require("ViewModel/SongShiYouXin/ViewItem/SSYXEmployingItem")
require("ViewModel/SongShiYouXin/ViewItem/BuildMakeItem")
local objs = {
    makeItem = {path = "template/MakeItem", type = UITool.GameObject},
    exitMaskBtn = {path = "root/_BG", type = UITool.Button},
    makingItemIcon = {path = "root/Left/Group/MakingItem/Item/Icon", type = UITool.Image},
    makingNoneFlag = {path = "root/Left/Group/MakingItem/Item/NoneFlag", type = UITool.GameObject},
    makingGetBtn = {path = "root/Left/Group/MakingItem/Item/GetBtn", type = UITool.Button},
    makingProgressObj = {path = "root/Left/Group/MakingItem/ProgressGroup", type = UITool.GameObject},
    makingProgress = {path = "root/Left/Group/MakingItem/ProgressGroup/FillBG/Fill", type = UITool.Image},
    makingDownTime = {path = "root/Left/Group/MakingItem/ProgressGroup/DownTime", type = UITool.Text},
    makingFastBtn = {path = "root/Left/Group/MakingItem/ProgressGroup/FastFinishBtn", type = UITool.Button},
    buildName = {path = "root/Middle/Group/BuildName", type = UITool.Text},
    buildLevel = {path = "root/Middle/Group/BuildLevel", type = UITool.Text},
    buildIcon = {path = "root/Middle/Group/BuildIcon", type = UITool.Image},
    buildIconRect = {path = "root/Middle/Group/BuildIcon", type = UITool.RectTransform},
    lastBuildBtn = {path = "root/Middle/Group/LastBuildBtn", type = UITool.Button},
    nextBuildBtn = {path = "root/Middle/Group/NextBuildBtn", type = UITool.Button},
    upgradeBtn = {path = "root/Middle/Group/UpgradeBtn", type = UITool.Button},
    employBtn = {path = "root/Middle/Group/EmployBtn", type = UITool.Button},
    makeProductListObj = {path = "root/Right/Group/MakeProductList", type = UITool.GameObject}
}

local this = {

    employingItems = {},
    allProductDatas = {},
    buildDatas = {},
    currentBuildIndex = -1,
    buildData = {}
}

this.before_awake = function()
    this.makeProductListUI = UIScrollView.New(this.makeProductListObj)
end

this.before_active = function()
    local _, allCreatedDatas = SSYXData.GetAllBuildData(SSYXConst.HungSceneIndex, DataMgr.Player.uid, true)
    this.buildDatas = allCreatedDatas
    this.currentBuildIndex = -1
    for i = 1, #this.buildDatas do
        local data = this.buildDatas[i]
        if data.ID == this.paramData.ID then
            this.currentBuildIndex = i
            break
        end
    end
    if this.currentBuildIndex ~= -1 then
        this.buildData = this.buildDatas[this.currentBuildIndex] or this.paramData
        this.lastBuildBtn.interactable = #this.buildDatas > 1 and this.currentBuildIndex > 1
        this.nextBuildBtn.interactable = #this.buildDatas > 1 and this.currentBuildIndex < #this.buildDatas
        this.RefreshUI(true)
        this.OnGetProduceReward()
    end
end

this.RefreshUI = function(isInit)
    local _, allCreatedDatas = SSYXData.GetAllBuildData(SSYXConst.HungSceneIndex, DataMgr.Player.uid, true)
    this.buildDatas = allCreatedDatas
    this.allProductDatas = SSYXData.GetProductDatas(this.buildData.ID)
    this.RefreshMakeProductList()
    this.RefreshEmployeeList()
    this.RefreshProduce()
    this.buildLevel.text = string.format("Lv.%d", this.buildData.Level)
    this.buildName.text = LuaMgr.GetLangText(this.buildData.Config.NameLan)
    local spriteName = string.format("%d_Light", this.buildData.ID)
    this.buildIcon.sprite = LuaMgr.GetSprite(SSYXConst.BuildAtlaName, spriteName)
    local x = this.buildIconRect.anchoredPosition.x
    local y = SSYXConst.BuildPosY[this.buildData.ID]
    this.buildIconRect.anchoredPosition = Vector2(x, y)
end

this.RefreshMakeProductList = function()
    this.makeProductListUI:Clear()
    local scrollDatas = {}
    local allDatas = this.allProductDatas
    local itemWidth = 390
    local makingObjTextLan = "LangGlobalLan_LangGlobal_name_30027"
    local makeBtnTextLan = "LangGlobalLan_LangGlobal_name_30026"
    if this.buildData.Config.Type == SSYXConst.SceneBuildType.CombineMatProduce then
        makingObjTextLan = "LangGlobalLan_LangGlobal_name_30023"
        makeBtnTextLan = "LangGlobalLan_LangGlobal_name_30022"
    end
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.MakeCallback = this.OnMakeCallback
        data.makingObjText = makingObjTextLan
        data.makeBtnText = makeBtnTextLan
        local scrollData = UIScrollData.GetData(this.makeItem, "BuildMakeItem", itemWidth, 183, data)
        table.insert(scrollDatas, scrollData)
    end
    this.makeProductListUI:SetParams(390, 566)
    this.makeProductListUI:SetData(scrollDatas, true)
end



this.OnMakeCallback = function(item)
    if item.data.MakingOther == true then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText49)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    if this.employingDatas == nil then
        this.employingDatas = SSYXData.GetEmployingDatas(this.buildData.ID)
    end
    if #this.employingDatas == 0 then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText46)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local data = {}
    data.BuildID = this.buildData.ID
    data.ItemData = item.data
    data.SelectID = item.data.Index
    data.ConfirmCallback = this.RefreshUI
    LuaMgr.ShowLuaPanel(UIName.SSYXProducePopup, data)
end

this.RefreshProduce = function()
    local isMaking = SSYXData.GetIsMaking(this.buildData)
    SetActive(this.makingItemIcon.gameObject, isMaking)
    SetActive(this.makingNoneFlag, isMaking == false)
    SetActive(this.makingProgressObj, isMaking)
    SetActive(this.makingGetBtn.gameObject, false)
    LuaMgr.RemoveTimer(TimerConst.SSYXProduceDownTimer)
    if isMaking == false then
        return
    end
    local makingIndex = this.buildData.ServerData.ProduceChoose
    local makingData = this.allProductDatas[makingIndex + 1]
    local config = SSYXData.GetItemConfig(makingData.ContentProduction.ID)
    this.makingItemIcon.sprite = LuaMgr.GetSprite(SSYXConst.ItemAtlaName, config.Icon)
    LuaMgr.AddTimer(TimerConst.SSYXProduceDownTimer, this.OnRefreshProduceTimer, 1, -1, true)
end

this.OnRefreshProduceTimer = function()
    local makingIndex = this.buildData.ServerData.ProduceChoose
    local makingData = this.allProductDatas[makingIndex + 1]
    local curTime = LuaMgr.Timestamp()
    local totalTime = makingData.OutputTime * this.buildData.ServerData.ProduceCount
    local remainProductTime = makingData.OutputTime * (this.buildData.ServerData.ProduceCount - 1)
    remainProductTime = math.max(remainProductTime, 0)
    local extraCdAdd = this.buildData.ServerData.ExtraCdAdd ~= nil and this.buildData.ServerData.ExtraCdAdd / 10000 or 0
    local singleSubTime = math.floor(makingData.OutputTime * extraCdAdd)
    local totalSubTime = this.buildData.ServerData.ProduceCount * singleSubTime
    local remainTime = makingData.OutputTime + this.buildData.ServerData.ProduceTime - curTime + remainProductTime - totalSubTime
    this.singleNeedTime = makingData.OutputTime
    if remainTime < 0 then
        LuaMgr.RemoveTimer(TimerConst.SSYXProduceDownTimer)
        SetActive(this.makingProgressObj, false)
        SetActive(this.makingGetBtn.gameObject, true)
        return
    end
    this.makingProgress.fillAmount = (totalTime - remainTime) / totalTime
    local h, m, s = GetTimeHMS2(remainTime)
    if h > 0 then
        this.makingDownTime.text = string.format("%02d:%02d:%02d", h, m, s)
    else
        this.makingDownTime.text = string.format("%02d:%02d", m, s)
    end
end

this.OnGetProduceReward = function()
    if SSYXData.GetIsMaking(this.buildData) == false then
        return
    end
    local makingIndex = this.buildData.ServerData.ProduceChoose
    local makingData = this.allProductDatas[makingIndex + 1]
    local curTime = LuaMgr.Timestamp()
    local remainProductTime = makingData.OutputTime * (this.buildData.ServerData.ProduceCount - 1)
    remainProductTime = math.max(remainProductTime, 0)
    local extraCdAdd = this.buildData.ServerData.ExtraCdAdd ~= nil and this.buildData.ServerData.ExtraCdAdd / 10000 or 0
    local singleSubTime = math.floor(makingData.OutputTime * extraCdAdd)
    local totalSubTime = this.buildData.ServerData.ProduceCount * singleSubTime
    local remainTime = makingData.OutputTime + this.buildData.ServerData.ProduceTime - curTime + remainProductTime - totalSubTime
    if remainTime >= 0 then
        return
    end
    local data = {}
    data.BuildIds = {}
    table.insert(data.BuildIds, this.buildData.ID)
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            return
        end
        SetActive(this.makingGetBtn.gameObject, false)
        local datas = {}
        for key, value in pairs(res.result.Rewards) do
            local data = {}
            data.ID = key
            data.Count = value
            data.IsInBag = false
            local config = SSYXData.GetItemConfig(data.ID)
            data.Icon = config.Icon
            data.Name = LuaMgr.GetLangText(config.NameLan)
            data.Desc = LuaMgr.GetLangText(config.DescriptionLan)
            table.insert(datas, data)
        end
        LuaMgr.ShowLuaPanel(UIName.SSYXShowRewardPopup, datas)
        this.RefreshUI()
    end
    ApiMgr.Request("operateBuild/produceReward", data, true, onSucc, nil, true)
end

this.RefreshEmployeeList = function()
    this.employingDatas = SSYXData.GetEmployingDatas(this.buildData.ID)
    local datas = {}
    local curUnlockNum = this.EmployeeGridIsUnlock()
    for i = 1, 3 do
        local data = {}
        data.Index = i
        data.EmployingData = this.employingDatas[i]
        data.IsEmploying = data.EmployingData ~= nil
        data.IsUnlock = i <= curUnlockNum
        data.OnClickGridCallback = this.OnClickGridCallback
        table.insert(datas, data)
    end
    this.employeeDatas = datas
    for i = 1, 3 do
        this.employingItems[i]:SetData(datas[i])
    end
end

this.EmployeeGridIsUnlock = function()
    local curUnlockNum = 0
    local employmentQuantity = this.buildData.Config.EmploymentQuantity
    for i = 1, this.buildData.Level do
        curUnlockNum = curUnlockNum + employmentQuantity[i]
    end
    return curUnlockNum
end

this.ProductGridIsUnlock = function()
    local curUnlockNum = 0
    local employmentQuantity = this.buildData.Config.UnlookOutput
    for i = 1, this.buildData.Level do
        curUnlockNum = curUnlockNum + employmentQuantity[i]
    end
    return curUnlockNum
end

this.GetProductUnlockDesc = function(tempIndex)
    local employmentQuantity = this.buildData.Config.UnlookOutput
    local curUnlockNum = 0
    for i = 1, #employmentQuantity do
        local tempNum = employmentQuantity[i]
        if i > this.buildData.Level then
            local nextTotalNum = curUnlockNum + tempNum
            if tempIndex <= nextTotalNum then
                return string.format(LuaMgr.GetLangText(SSYXConst.LanText.LanText25), i)
            end
        end
        curUnlockNum = curUnlockNum + tempNum
    end
    LuaDebug.error("GetProductUnlockDesc 数据错误")
    return ""
end

this.OnClickMakingFastBtn = function()
    if this.buildData.Config.Type == SSYXConst.SceneBuildType.BaseMatProduce and SSYXData.CheckTechIsUnlock(SSYXConst.TechID.BaseMatProduct) == false then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText47)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    elseif this.buildData.Config.Type == SSYXConst.SceneBuildType.CombineMatProduce and SSYXData.CheckTechIsUnlock(SSYXConst.TechID.CombineMatProduct) == false then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText48)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local data = {}
    data.FastType = 0
    data.BuildData = this.buildData
    data.BuildID = this.buildData.ID
    data.MsgBoxTitle = LuaMgr.GetLangText(SSYXConst.LanText.LanText42)
    data.ConfirmCallback = this.RefreshUI
    data.NeedTime = this.singleNeedTime or 1
    LuaMgr.ShowLuaPanel(UIName.SSYXProduceFastPopup, data)
end

this.OnClickLastBuildBtn = function()
    local tempIndex = this.currentBuildIndex - 1
    if tempIndex < 1 then
        return
    elseif tempIndex == 1 then
        this.lastBuildBtn.interactable = false
    end
    this.nextBuildBtn.interactable = true
    this.currentBuildIndex = tempIndex
    this.buildData = this.buildDatas[this.currentBuildIndex]
    this.RefreshUI()
    this.OnGetProduceReward()
end

this.OnClickNextBuildBtn = function()
    local tempIndex = this.currentBuildIndex + 1
    if tempIndex > #this.buildDatas then
        return
    elseif tempIndex == #this.buildDatas then
        this.nextBuildBtn.interactable = false
    end
    this.lastBuildBtn.interactable = true
    this.currentBuildIndex = tempIndex
    this.buildData = this.buildDatas[this.currentBuildIndex]
    this.RefreshUI()
    this.OnGetProduceReward()
end

this.OnClickUpgradeBtn = function()
    if this.buildData.Level >= this.buildData.Config.LevelCap then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText8)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local data = {}
    data.ProductDatas = SSYXData.GetProductDatas(this.buildData.ID)
    data.BuildData = this.buildData
    data.OnUpgradeCallback = this.RefreshUI
    LuaMgr.ShowLuaPanel(UIName.SSYXBuildUpgradePopup1, data)
end

this.OnClickEmployBtn = function()
    this.OpenEmployeeList(1)
end

this.OnClickMakingGetBtn = function()
    this.OnGetProduceReward()
end

this.OpenEmployeeList = function(index)
    local data = {}
    data.EmployeeDatas = this.employeeDatas
    data.BuildData = this.buildData
    data.Index = index
    LuaMgr.ShowLuaPanel(UIName.SSYXEmployPopup, data)
end



this.OnClickGridCallback = function(item)
    this.OpenEmployeeList(item.data.Index)
end

this.OnClickExitMaskBtn = function()
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        for i = 1, 3 do
            local employingObjName = "EmployeeItem" .. i
            local path = string.format("root/Left/Group/EmployeeGroup/%s", employingObjName)
            objs[employingObjName] = {path = path, type = UITool.GameObject}
        end
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        for i = 1, 3 do
            local employingObjName = "EmployeeItem" .. i
            local employingItem = SSYXEmployingItem.New(this[employingObjName])
            this.employingItems[i] = employingItem
        end
        this.before_awake()
        LuaMgr.AddClick(this.makingFastBtn, this.OnClickMakingFastBtn)
        LuaMgr.AddClick(this.lastBuildBtn, this.OnClickLastBuildBtn)
        LuaMgr.AddClick(this.nextBuildBtn, this.OnClickNextBuildBtn)
        LuaMgr.AddClick(this.upgradeBtn, this.OnClickUpgradeBtn)
        LuaMgr.AddClick(this.employBtn, this.OnClickEmployBtn)
        LuaMgr.AddClick(this.makingGetBtn, this.OnClickMakingGetBtn)
        LuaMgr.AddClick(this.exitMaskBtn, this.OnClickExitMaskBtn)
        LuaMgr.AddUIEventListener(UIEventConst.SSYXSelectEmployeeSucc, this.RefreshUI)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length == 0 then
            return
        end
        this.paramData = vm.behaviour.Params[0]
        this.before_active()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.SSYXProduceDownTimer)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.makingFastBtn, this.OnClickMakingFastBtn)
        LuaMgr.RemoveClick(this.lastBuildBtn, this.OnClickLastBuildBtn)
        LuaMgr.RemoveClick(this.nextBuildBtn, this.OnClickNextBuildBtn)
        LuaMgr.RemoveClick(this.upgradeBtn, this.OnClickUpgradeBtn)
        LuaMgr.RemoveClick(this.employBtn, this.OnClickEmployBtn)
        LuaMgr.RemoveClick(this.makingGetBtn, this.OnClickMakingGetBtn)
        LuaMgr.RemoveClick(this.exitMaskBtn, this.OnClickExitMaskBtn)
        LuaMgr.RemoveUIEventListener(UIEventConst.SSYXSelectEmployeeSucc, this.RefreshUI)
        UIScrollView.ClearItem("BuildMakeItem")
        UIScrollView.ClearItem("SSYXEmployingItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)