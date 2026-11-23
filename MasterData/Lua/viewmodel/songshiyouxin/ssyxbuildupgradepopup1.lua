require("ViewModel/SongShiYouXin/ViewItem/SSYXProductItem")
require("ViewModel/SongShiYouXin/ViewItem/UpgradeBuildPreviewItem")
require("ViewModel/SongShiYouXin/ViewItem/SSYXMakeMatItem")
local objs = {
    matPrefab = {path = "template/MatPrefab", type = UITool.GameObject},
    buildIcon = {path = "root/Middle/BuildIcon", type = UITool.Image},
    buildName = {path = "root/Middle/_TitleBG/BuildName", type = UITool.Text},
    upBeforeLevel = {path = "root/Middle/ProductGroup/PreviewGroup/LevelGroup/UpBeforeLevel", type = UITool.Text},
    upAfterLevel = {path = "root/Middle/ProductGroup/PreviewGroup/LevelGroup/UpAfterLevel", type = UITool.Text},
    matParent = {path = "root/Middle/MatGroup/MatParent", type = UITool.Transform},
    maskBtn = {path = "root/Mask", type = UITool.Button},
    closeBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    upgradeBtn = {path = "root/Middle/UpgradeBtn", type = UITool.Button},
    needCount = {path = "root/Middle/UpgradeBtn/NeedCount", type = UITool.GameObject},

    productItemObj = {path = "root/Middle/ProductGroup/PreviewGroup/ProductItem", type = UITool.GameObject},
    employeeObj = {path = "root/Middle/ProductGroup/PreviewGroup/ProductItem/EmployeeObj", type = UITool.GameObject},
    addProductCountObj = {path = "root/Middle/ProductGroup/PreviewGroup/ProductItem/AddProductCountObj", type = UITool.GameObject},


    previewGroupObj = {path = "root/Middle/ProductGroup/PreviewGroup/PreviewGroup", type = UITool.GameObject}

}

local this = {

    matItemCache = {},

    newProductItems = {},

    matItems = {},

    previewItems = {},

    commonItemCountIcon = nil
}

this.BatchInitNode = function()
    for i = 1, 4 do
        local itemName = "PreviewItem" .. i
        local path = "root/Middle/ProductGroup/PreviewGroup/PreviewGroup/" .. itemName
        objs[itemName] = {path = path, type = UITool.GameObject}
    end
    for i = 1, 2 do
        local itemName = "ProductItem" .. i
        local path = "root/Middle/ProductGroup/PreviewGroup/ProductItem/" .. itemName
        objs[itemName] = {path = path, type = UITool.GameObject}
    end
    UITool.Parse(this.vmBehaviour.gameObject, this, objs)
    for i = 1, 4 do
        local itemName = "PreviewItem" .. i
        local obj = this[itemName]
        this.previewItems[i] = UpgradeBuildPreviewItem.New(obj)
    end
    for i = 1, 2 do
        local itemName = "ProductItem" .. i
        local obj = this[itemName]
        this.newProductItems[i] = SSYXProductItem.New(obj)
        SetActive(obj, false)
    end
    this.commonItemCountIcon = CommonItemCountIcon.New(this.needCount)
end

this.before_awake = function()
    SetActive(this.productItemObj, false)
    SetActive(this.previewGroupObj, false)
end

this.before_active = function()
    this.RefreshUI()
end

this.RefreshUI = function()
    local spriteName = string.format("%d_Light", this.buildData.ID)
    this.buildIcon.sprite = LuaMgr.GetSprite(SSYXConst.BuildAtlaName, spriteName)
    this.buildName.text = LuaMgr.GetLangText(this.buildData.Config.NameLan)
    local levelText = LuaMgr.GetLangText(SSYXConst.LanText.LanText31)
    this.upBeforeLevel.text = string.format(levelText, this.buildData.Level)
    this.upAfterLevel.text = string.format(levelText, this.buildData.Level + 1)
    SetActive(this.productItemObj, false)
    SetActive(this.previewGroupObj, false)
    if this.buildData.ID == SSYXConst.BuildID.YinHang then
        SetActive(this.previewGroupObj, true)
        this.RefreshMainBuildUpData()
    else
        SetActive(this.productItemObj, true)
        this.RefreshProductBuildUpData()
    end
    local consumeData = SSYXData.GetBuildUpgradeItems(this.buildData.ID, this.buildData.Level)
    this.matCountIsEnough = true
    this.currencyIsEnough = true
    for i = 1, #consumeData do
        local data = consumeData[i]
        if data.IsInBag == false then
            local item = this.GetMatItem()
            SetActive(item.gameObject, true)
            local needCount = data.NeedCount
            local ownerNum = data.OwnerCount
            if ownerNum >= needCount then
                data.NumText = string.format("%d/%d", ownerNum, needCount)
            else
                this.matCountIsEnough = false
                data.NumText = string.format("<color=#C33D20>%d</color>/%d", ownerNum, needCount)
            end
            item:SetData(data)
        else
            data.id = data.ID
            local subCount = SSYXData.GetTechSubConsumeCount(data.NeedCount)
            data.count = data.NeedCount - subCount
            this.commonItemCountIcon:SetData(data)
            if DataHelper.GetItemCountById(data.id) < data.count then
                this.currencyIsEnough = false
            end
        end
    end
end

this.RefreshMainBuildUpData = function()
    local allDatas = this.GetMainBuildUpDatas()
    for i = 1, #this.previewItems do
        local item = this.previewItems[i]
        local data = allDatas[i]
        if data ~= nil and data.Name ~= nil then
            SetActive(item.gameObject, true)
            item:SetData(data)
        else
            SetActive(item.gameObject, false)
        end
    end
end

this.RefreshProductBuildUpData = function()
    local curLevel = this.buildData.Level
    local nextLevel = curLevel + 1
    if this.buildData.Config.EmploymentQuantity and this.buildData.Config.EmploymentQuantity[nextLevel] ~= 0 then
        SetActive(this.employeeObj, true)
    else
        SetActive(this.employeeObj, false)
    end

    SetActive(this.addProductCountObj, false)
    if this.buildData.OutputConfig.MaxOutputNum then
        local curLevelData = this.buildData.OutputConfig.MaxOutputNum[curLevel]
        local nextLevelData = this.buildData.OutputConfig.MaxOutputNum[nextLevel]
        if curLevelData < nextLevelData then
            SetActive(this.addProductCountObj, true)
        end
    end

    SetActive(this.newProductItems[1].gameObject, false)
    local nextUnlockCount = 0
    local curUnlockCount = 0
    for i = 1, #this.buildData.Config.UnlookOutput do
        local data = this.buildData.Config.UnlookOutput[i]
        if i <= nextLevel and data > 0 then
            nextUnlockCount = nextUnlockCount + 1
        end
        if i <= curLevel and data > 0 then
            curUnlockCount = curUnlockCount + 1
        end
    end
    if nextUnlockCount > curUnlockCount and this.buildData.OutputConfig.ContentProductionTool and type(this.buildData.OutputConfig.ContentProductionTool[nextUnlockCount]) == "table" then
        SetActive(this.newProductItems[1].gameObject, false)
        local nextItemConfig = this.buildData.OutputConfig.ContentProductionTool[nextUnlockCount]
        if #nextItemConfig > 1 then
            local itemConfig = nextItemConfig[1]
            local data = table.CopyNoMeta(itemConfig)
            data.NumText = ""
            this.newProductItems[1]:SetData(data)
            SetActive(this.newProductItems[1].gameObject, true)
        end
    end
end

this.OnClickCloseBtn = function()
    LuaMgr.HidePanel(UIName.SSYXBuildUpgradePopup1)
end

this.OnClickUpgradeBtn = function()
    if this.matCountIsEnough == false then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText34)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end

    if this.currencyIsEnough == false then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText35)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("SSYXData.UseItem 请求错误:" .. res.code)
            return
        end
        if this.onUpgradeSucc ~= nil then
            this.onUpgradeSucc()
        end
        this.OnClickCloseBtn()
    end
    local data = {}
    data.BuildId = this.buildData.ID
    ApiMgr.Request("operateBuild/buildLevelUp", data, true, onSucc, nil, true)
end

this.GetMatItem = function()
    local matItem = table.remove(this.matItemCache)
    if matItem == nil then
        local obj = LuaMgr.Instantiate(this.matPrefab, this.matParent, false)
        matItem = SSYXMakeMatItem.New(obj)
    end
    table.insert(this.matItems, matItem)
    return matItem
end

this.RecycleAllMatItem = function()
    for i = 1, #this.matItems do
        local matItem = this.matItems[i]
        matItem:Clear()
        SetActive(matItem.gameObject, false)
        table.insert(this.matItemCache, matItem)
    end
    this.matItems = {}
end

this.GetMainBuildUpDatas = function()
    local rewardUpBeforeData = SSYXData.GetPreviewDataByLevel(this.buildData.Level, 1)
    local rewardUpAfterData = SSYXData.GetPreviewDataByLevel(this.buildData.Level + 1, 1)
    local datas = {}


    local data1 = {}
    data1.Name = nil
    local lanStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27113")
    local hour = math.floor(ConfigMgr.Config.OperateConstants.MaximumDailyIdleTime / 3600)
    data1.UpBeforeAttr = string.format(lanStr, hour)
    data1.UpAfterAttr = ""
    table.insert(datas, data1)


    local data2 = {}
    if rewardUpBeforeData ~= nil and rewardUpAfterData ~= nil then
        data2.Name = rewardUpBeforeData.Name
        local lanStr = LuaMgr.GetLangText(SSYXConst.LanText.LanText9)
        data2.UpBeforeAttr = string.format(lanStr, rewardUpBeforeData.UnitOut)
        data2.UpAfterAttr = string.format(lanStr, rewardUpAfterData.UnitOut)
        table.insert(datas, data2)
    end


    local data3 = {}
    local rewardUpBeforeData = SSYXData.GetPreviewDataByLevel(this.buildData.Level, 2)
    local rewardUpAfterData = SSYXData.GetPreviewDataByLevel(this.buildData.Level + 1, 2)

    local data4 = {}
    if rewardUpBeforeData ~= nil and rewardUpAfterData ~= nil then
        data3.Name = rewardUpBeforeData.Name
        local lanStr = LuaMgr.GetLangText(SSYXConst.LanText.LanText9)
        data3.UpBeforeAttr = string.format(lanStr, rewardUpBeforeData.UnitOut)
        data3.UpAfterAttr = string.format(lanStr, rewardUpAfterData.UnitOut)
        table.insert(datas, data3)

        data4.Name = ""
        local lanStr = LuaMgr.GetLangText(SSYXConst.LanText.LanText33)
        data4.UpBeforeAttr = string.format(lanStr, rewardUpBeforeData.HangingTime)
        data4.UpAfterAttr = string.format(lanStr, rewardUpAfterData.UnitOut)
        table.insert(datas, data4)
    end
    return datas
end

this.GetProductBuildUpDatas = function()
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vmBehaviour = vm.behaviour
        this.BatchInitNode()
        this.before_awake()
        LuaMgr.AddClick(this.maskBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.upgradeBtn, this.OnClickUpgradeBtn)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        local data = vm.behaviour.Params[0]
        this.productDatas = data.ProductDatas
        this.buildData = data.BuildData
        this.onUpgradeSucc = data.OnUpgradeCallback
        this.before_active()
    end,
    before_deactive = function(vm)
        this.RecycleAllMatItem()
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.upgradeBtn, this.OnClickUpgradeBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)