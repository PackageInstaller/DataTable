require("ViewModel/SongShiYouXin/ViewItem/CreateBuildTargetItem")
require("ViewModel/SongShiYouXin/ViewItem/SSYXMakeMatItem")
require("ViewModel/SongShiYouXin/ViewItem/SSYXRewardItem")
local objs = {
    createBuildTargetItem = {path = "template/CreateBuildTargetItem", type = UITool.GameObject},
    bankRewardItem = {path = "template/GoodsItem", type = UITool.GameObject},
    buildName = {path = "root/Middle/BuildName", type = UITool.Text},
    buildLevel = {path = "root/Middle/BuildLevel", type = UITool.Text},
    buildIcon = {path = "root/Middle/BuildIcon", type = UITool.Image},
    buildIconRect = {path = "root/Middle/BuildIcon", type = UITool.RectTransform},
    upgradeBtn = {path = "root/Middle/UpgradeBtn", type = UITool.Button},
    needMatObj = {path = "root/Middle/NeedMatObj", type = UITool.GameObject},
    needCount = {path = "root/Middle/UpgradeBtn/Layout/NeedCount", type = UITool.GameObject},

    upgradeTips = {path = "root/Middle/UpgradeTips", type = UITool.Text},
    obj1001 = {path = "root/Right/Obj_1001", type = UITool.GameObject},
    finishProgressText = {path = "root/Right/Obj_1001/FinishProgressText", type = UITool.Text},
    finishProgress = {path = "root/Right/Obj_1001/FinishProgress/Fill", type = UITool.Image},
    targetListObj = {path = "root/Right/Obj_1001/TargetList", type = UITool.GameObject},


    obj1002 = {path = "root/Right/Obj_1002", type = UITool.GameObject},
    rewardItemParent = {path = "root/Right/Obj_1002/ItemParent", type = UITool.Transform},
    getRewardBtn = {path = "root/Right/Obj_1002/GetRewardBtn", type = UITool.Button},
    totalTime = {path = "root/Right/Obj_1002/TotalTime", type = UITool.Text}

}

local this = {

    needItems = {},

    bankRewardItems = {},

    bankRewardItemsCache = {}
}

this.before_awake = function()
    this.targetListUI = UIScrollView.New(this.targetListObj)
    this.commonItemCountIcon = CommonItemCountIcon.New(this.needCount)
    this.bankRewardItems = {}
    this.bankRewardItemsCache = {}
end

this.before_active = function()
    SetActive(this.needMatObj, false)
    SetActive(this["obj1001"], false)
    SetActive(this["obj1002"], false)
    SetActive(this["obj" .. this.buildData.ID], true)
    this.RefreshUI()
    this.SetUpgradeMatVisible(true)
end

this.RefreshUI = function()
    SSYXData.RefreshBuildDataByID(this.buildData.ID)
    this.buildName.text = LuaMgr.GetLangText(this.buildData.Config.NameLan)
    this.buildLevel.text = string.format("lv.%d", this.buildData.Level)
    local spriteName = string.format("%d_Light", this.buildData.ID)
    this.buildIcon.sprite = LuaMgr.GetSprite(SSYXConst.BuildAtlaName, spriteName)
    local x = this.buildIconRect.anchoredPosition.x
    local y = SSYXConst.BuildPosY[this.buildData.ID]
    this.buildIconRect.anchoredPosition = Vector2(x, y)
    SetActive(this.needMatObj, false)
    if this.buildData.ID == SSYXConst.BuildID.HuiGuan then
        this.RefreshTagetList()
    elseif this.buildData.ID == SSYXConst.BuildID.YinHang then
        this.OnRequestBackData()
    end

    this.SetUpgradeMatVisible(this.buildData.Level < this.buildData.Config.LevelCap)
end

this.RefreshTagetList = function()
    local allDatas, finishCount, maxCount = SSYXData.GetBuildTaskDatas(this.buildData.ID, this.buildData.Level)
    this.finishCount = finishCount
    this.maxCount = maxCount
    this.finishProgressText.text = string.format("%d/%d", this.finishCount, this.maxCount)
    this.finishProgress.fillAmount = this.finishCount / this.maxCount

    local scrollDatas = {}
    local itemWidth = 480
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.OnClickGotoBtn = this.OnTargetGotoPage
        local scrollData = UIScrollData.GetData(this.createBuildTargetItem, "CreateBuildTargetItem", itemWidth, 40, data)
        table.insert(scrollDatas, scrollData)
    end
    this.targetListUI:SetParams(itemWidth, 439)
    this.targetListUI:SetData(scrollDatas, true)
end



this.OnTargetGotoPage = function(item)
    FeatureManager.GotoViewModel(item.data.skipPage)
end


this.OnRequestBackData = function()
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("SSYXData.UseItem 请求错误:" .. res.code)
            return
        end
        this.SetUpgradeMatVisible(true)
        this.RefreshBankRewardList(res.result)
        this.RefreshBankUI()
    end
    local data = {}
    data.BuildId = SSYXConst.BuildID.YinHang
    ApiMgr.Request("operateBuild/idleBuildRewardView", data, true, onSucc, nil, true)
    this.RefreshBankUI()
end

this.RefreshBankUI = function()
    local textDatas = {}
    local lanStr = LuaMgr.GetLangText(SSYXConst.LanText.LanText9)
    for i = 1, 3 do
        local rewardUpData = SSYXData.GetPreviewDataByLevel(this.buildData.Level, i)
        if rewardUpData ~= nil then
            textDatas[i] = string.format(lanStr, rewardUpData.UnitOut)
        end
    end
    for i = 1, 3 do
        local matRewardEfficiencyName = "Efficiency" .. i
        local textData = textDatas[i]
        local matRewardItemName = "MatRewardItemName" .. i
        local obj = this[matRewardItemName]
        if textData then
            this[matRewardEfficiencyName].text = textData
            SetActive(obj, true)
        else
            SetActive(obj, false)
        end
    end
    local curTime = LuaMgr.Timestamp()
    local startTime = this.buildData.ServerData.IdleTime
    local deltaTime = curTime - startTime
    if deltaTime < 0 then
        return
    end
    local d, h, _ = GetTimeDHM2(deltaTime)
    if d > 0 then
        local langText = LuaMgr.GetLangText(SSYXConst.LanText.LanText43)
        this.totalTime.text = string.format(langText, d, h)
    else
        local h, m, s = GetTimeHMS2(deltaTime)
        local langText = LuaMgr.GetLangText(SSYXConst.LanText.LanText44)
        this.totalTime.text = string.format(langText, h)
    end
end

this.RefreshBankRewardList = function(data)
    local datas = {}
    for key, value in pairs(data.Rewards) do
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
    for key, value in pairs(data.BagRewards) do
        local data = {}
        data.ID = key
        data.Count = value
        data.IsInBag = true
        data.NeedSetRare = true
        local config = ConfigMgr.Config.itemMap[data.ID]
        data.Name = LuaMgr.GetLangText(config.nameLan)
        data.Desc = LuaMgr.GetLangText(config.DescriptionLan)
        table.insert(datas, data)
    end
    this.bankRewardDatas = datas
    this.RecycleAllBankRewardItem()
    for i = 1, #datas do
        local item = this.GetBankRewardItem()
        SetActive(item.gameObject, true)
        local data = datas[i]
        item:SetData(data)
    end
    SetActive(this.getRewardBtn.gameObject, #datas > 0)
end

this.GetBankRewardItem = function()
    local item = table.remove(this.bankRewardItemsCache)
    if item == nil then
        local obj = LuaMgr.InstantiateGO(this.bankRewardItem, this.rewardItemParent, false)
        item = SSYXRewardItem.New(obj)
    end
    table.insert(this.bankRewardItems, item)
    return item
end

this.RecycleAllBankRewardItem = function()
    for i = 1, #this.bankRewardItems do
        local item = this.bankRewardItems[i]
        item:Clear()
        SetActive(item.gameObject, false)
        table.insert(this.bankRewardItemsCache, item)
    end
    this.bankRewardItems = {}
end



this.OnClickUpgradeBtn = function()
    if this.buildData.Level >= this.buildData.Config.LevelCap then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText8)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    if this.buildData.ID == SSYXConst.BuildID.HuiGuan and this.buildData.IsCompleteAllTask == false then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText7)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local enoughConsume = this.buildData.CanUpgrade
    if enoughConsume == false then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText6)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local uiName = ""
    if this.buildData.ID == SSYXConst.BuildID.HuiGuan then
        uiName = UIName.SSYXBuildUpgradePopup2
    else
        uiName = UIName.SSYXBuildUpgradePopup1
    end
    local data = {}
    data.BuildData = this.buildData
    data.OnUpgradeCallback = this.RefreshUI
    LuaMgr.ShowLuaPanel(uiName, data)
end

this.OnClickGetRewardBtn = function()
    if #this.bankRewardDatas == 0 then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText45)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("SSYXData.UseItem 请求错误:" .. res.code)
            return
        end
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
        for key, value in pairs(res.result.BagRewards.Items) do
            local data = {}
            data.ID = value.id
            data.Count = value.count
            data.IsInBag = true
            local config = ConfigMgr.Config.itemMap[data.ID]
            data.Name = LuaMgr.GetLangText(config.nameLan)
            data.Desc = LuaMgr.GetLangText(config.DescriptionLan)
            table.insert(datas, data)
        end
        LuaMgr.ShowLuaPanel(UIName.SSYXShowRewardPopup, datas)
        this.OnRequestBackData()
    end
    local data = {}
    data.BuildId = SSYXConst.BuildID.YinHang
    ApiMgr.Request("operateBuild/idleBuildReward", data, true, onSucc, nil, true)
end

this.SetUpgradeMatVisible = function(visible)
    if visible == true then
        local itemDatas = SSYXData.GetBuildUpgradeItems(this.buildData.ID, this.buildData.Level)
        local index = 1
        for i = 1, #itemDatas do
            local data = itemDatas[i]
            if data.IsInBag == false then
                local needCount = data.NeedCount
                local ownerNum = data.OwnerCount
                if ownerNum >= needCount then
                    data.NumText = string.format("%d/%d", ownerNum, needCount)
                else
                    data.NumText = string.format("<color=#C33D20>%d</color>/%d", ownerNum, needCount)
                end
                this.needItems[index]:SetData(data)
                SetActive(this.needItems[index].gameObject, true)
                index = index + 1
            else
                data.id = data.ID
                local subCount = SSYXData.GetTechSubConsumeCount(data.NeedCount)
                data.count = data.NeedCount - subCount
                this.commonItemCountIcon:SetData(data)
            end
        end
    end
    SetActive(this.commonItemCountIcon.gameObject, this.buildData.Level < this.buildData.Config.LevelCap)
    SetActive(this.needMatObj, this.buildData.Level < this.buildData.Config.LevelCap)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        for i = 1, 2 do
            local matObjName = "MatItemObj" .. i
            local path = string.format("root/Middle/NeedMatObj/%s", matObjName)
            objs[matObjName] = {path = path, type = UITool.GameObject}
        end
        for i = 1, 3 do
            local matRewardItemName = "MatRewardItemName" .. i
            local itemPath = string.format("root/Right/Obj_1002/MatGroup/MatItem%d", i)
            objs[matRewardItemName] = {path = itemPath, type = UITool.GameObject}

            local efficiencyName = "Efficiency" .. i
            local efficiencyPath = itemPath .. "/Effect"
            objs[efficiencyName] = {path = efficiencyPath, type = UITool.Text}
        end
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        for i = 1, 2 do
            local matObjName = "MatItemObj" .. i
            local matItem = SSYXMakeMatItem.New(this[matObjName])
            SetActive(matItem.gameObject, false)
            this.needItems[i] = matItem
        end

        this.before_awake()
        LuaMgr.AddClick(this.upgradeBtn, this.OnClickUpgradeBtn)
        LuaMgr.AddClick(this.getRewardBtn, this.OnClickGetRewardBtn)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        if this.topBarComp == nil then
            local topBarObj = UnityEngine.GameObject.Find("UIRoot(Clone)/Fixed/TopBarPanel(Clone)")
            this.topBarComp = topBarObj:GetComponent("TopBarViewModel")
        end
        this.buildData = vm.behaviour.Params[0]
        this.yinhangName = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30025")
        if this.buildData.ID == SSYXConst.BuildID.YinHang then
            local func = function()
                this.topBarComp.BackName:Set(this.yinhangName)
            end
            this.tween = DOTWeen:Sequence()
            this.tween:AppendInterval(0.3):OnComplete(func)
        end
        this.before_active()
    end,
    before_deactive = function(vm)
        this.RecycleAllBankRewardItem()
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.upgradeBtn, this.OnClickUpgradeBtn)
        LuaMgr.RemoveClick(this.getRewardBtn, this.OnClickGetRewardBtn)
        UIScrollView.ClearItem("CreateBuildTargetItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)