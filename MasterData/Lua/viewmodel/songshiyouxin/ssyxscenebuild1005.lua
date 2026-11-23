require("ViewModel/SongShiYouXin/ViewItem/TechnologyItem")
require("ViewModel/SongShiYouXin/ViewItem/SSYXMakeMatItem")
local objs = {
    bgScrollView = {path = "root/BgScrollView", type = UITool.OnDragBehaviour},
    treeScrollView = {path = "root/Middle/TreeScrollView", type = UITool.OnDragBehaviour},
    technologyCount = {path = "root/Left/TitleGroup/TechnologyCount", type = UITool.Text},
    upgradeGroupObj = {path = "root/Right/UpgradeGroup", type = UITool.GameObject},
    upgradeBtn = {path = "root/Right/UpgradeBtn", type = UITool.Button},
    confirmUpgradeBtn = {path = "root/Right/UpgradeGroup/ConfirmUpgradeBtn", type = UITool.Button},
    icon = {path = "root/Right/UpgradeGroup/Icon", type = UITool.Image},
    desc = {path = "root/Right/UpgradeGroup/Desc", type = UITool.Text},
    desc1 = {path = "root/Right/UpgradeGroup/Desc1", type = UITool.Text},
    level = {path = "root/Right/UpgradeGroup/Level", type = UITool.Text},
    upgradeBtnText = {path = "root/Right/UpgradeBtn/Text", type = UITool.Text},
    confirmUpgradeBtnText = {path = "root/Right/UpgradeGroup/ConfirmUpgradeBtn/Text", type = UITool.Text}
}

local this = {
    treeNodeCount = 13,

    treeNodeItems = {},

    lastSelectItem = nil,

    upgradeMatItems = {}
}

this.before_awake = function()
end

this.before_active = function()
    SetActive(this.upgradeGroupObj, false)
    this.bgScrollView.onPointerUp = this.OnPointerUp
    this.treeScrollView.onPointerUp = this.OnPointerUp
    this.RefreshTechItem()
end

this.RefreshTechItem = function()
    local allDatas, unlockCount = SSYXData.GetAllTechDatas()
    this.unlockCount = unlockCount
    this.techDatas = allDatas
    this.technologyCount.text = string.format("%d/%d", this.unlockCount, #this.techDatas)
    for i = 1, #allDatas do
        local item = this.treeNodeItems[i]
        local data = allDatas[i]
        data.IsSelect = false
        data.OnSelectTechnology = this.OnSelectItem
        item:SetData(data)
        item:SetSelected(false)
        if this.lastSelectItem == nil or this.lastSelectItem.data.ID == data.ID then
            this.OnSelectItem(item)
        end
    end
end



this.OnSelectItem = function(item)
    if this.lastSelectItem ~= nil then
        this.lastSelectItem:SetSelected(false)
    end
    this.lastSelectItem = item
    this.lastSelectItem:SetSelected(true)
    SetActive(this.confirmUpgradeBtn.gameObject, true)
    if this.lastSelectItem.data.IsUnlock == false then
        this.upgradeBtnText.text = LuaMgr.GetLangText(SSYXConst.LanText.LanText17)
        this.confirmUpgradeBtnText.text = LuaMgr.GetLangText(SSYXConst.LanText.LanText19)
    else
        local data = this.lastSelectItem.data
        this.upgradeBtnText.text = LuaMgr.GetLangText(SSYXConst.LanText.LanText18)
        if data.Level >= data.Config.MaxLevel then
            SetActive(this.confirmUpgradeBtn.gameObject, false)
        else
            this.confirmUpgradeBtnText.text = LuaMgr.GetLangText(SSYXConst.LanText.LanText20)
        end
    end
    if this.upgradeGroupObj.activeSelf == true then
        local tempData = this.lastSelectItem.data
        local datas, canUp = SSYXData.GetTechUpgradeConsume(tempData.ID)
        if this.lastSelectItem.data.IsUnlock == true then
            this.upgradeMatDatas = datas
        else
            local datas1, _ = SSYXData.GetTechUnlockConsume(tempData.ID)
            this.unlockMatDatas = datas1
        end
        if canUp == true then
            this.RefreshUpgradePanel()
        end
    end
end

this.OnClickUpgradeBtn = function()
    local tempData = this.lastSelectItem.data
    local datas, canUp = SSYXData.GetTechUpgradeConsume(tempData.ID)
    if this.lastSelectItem.data.IsUnlock == true then
        this.upgradeMatDatas = datas
    else
        local datas1, _ = SSYXData.GetTechUnlockConsume(tempData.ID)
        this.unlockMatDatas = datas1
    end
    SetActive(this.upgradeGroupObj, canUp == true)
    if canUp == false then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText24)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    this.RefreshUpgradePanel()
end

this.RefreshUpgradePanel = function()
    this.technologyCount.text = string.format("%d/%d", this.unlockCount, #this.techDatas)
    local tempData = this.lastSelectItem.data
    this.icon.sprite = LuaMgr.GetSprite(SSYXConst.TechAtlaName, tempData.Config.Icon)
    this.desc.text = LuaMgr.GetLangText(tempData.Config.NameLan)
    local lanStr = LuaMgr.GetLangText(tempData.Config.DescriptionLan)
    local param = tempData.Config.Parameter[tempData.Level] or 0
    this.desc1.text = string.format(lanStr, math.floor(param / 100))
    if tempData.IsUnlock == false then
        this.level.text = string.format("%d/%d", 0, tempData.Config.MaxLevel)
        for i = 1, 2 do
            local matData = this.unlockMatDatas[i]
            local item = this.upgradeMatItems[i]
            if matData ~= nil then
                local needCount = matData.Count
                local ownerNum = matData.OwnerCount
                if ownerNum >= needCount then
                    matData.NumText = string.format("%d/%d", ownerNum, needCount)
                else
                    matData.NumText = string.format("<color=#C33D20>%d</color>/%d", ownerNum, needCount)
                end
                item:SetData(matData)
                SetActive(item.gameObject, true)
            else
                SetActive(item.gameObject, false)
            end
        end
    else
        this.level.text = string.format("%d/%d", tempData.Level, tempData.Config.MaxLevel)
        for i = 1, 2 do
            local matData = this.upgradeMatDatas[i]
            local item = this.upgradeMatItems[i]
            if matData ~= nil then
                local needCount = matData.Count
                local ownerNum = matData.OwnerCount
                if ownerNum >= needCount then
                    matData.NumText = string.format("%d/%d", ownerNum, needCount)
                else
                    matData.NumText = string.format("<color=#C33D20>%d</color>/%d", ownerNum, needCount)
                end
                item:SetData(matData)
                SetActive(item.gameObject, true)
            else
                SetActive(item.gameObject, false)
            end
        end
    end
end

this.OnClickConfirmUpgradeBtn = function()
    if this.lastSelectItem.data.IsUnlock == false then
        this.OnUnlockTech()
        return
    elseif this.lastSelectItem.data.CanUpgrade == false then
        local tipsContent = LuaMgr.GetLangText(this.lastSelectItem.data.UpgredeDesc)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local matEnough = true
    for key, value in pairs(this.upgradeMatDatas) do
        if value.OwnerCount < value.Count then
            matEnough = false
            break
        end
    end
    if matEnough == false then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText34)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            return
        end
        this.RefreshTechItem()
    end
    local data = {}
    data.Id = this.lastSelectItem.data.ID
    ApiMgr.Request("operateBuild/techTreeLevelUp", data, true, onSucc, nil, true)
end

this.OnUnlockTech = function()
    local matEnough = true
    for key, value in pairs(this.unlockMatDatas) do
        if value.OwnerCount < value.Count then
            matEnough = false
            break
        end
    end
    if matEnough == false then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText34)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            return
        end
        this.RefreshTechItem()
        SetActive(this.upgradeGroupObj, false)
    end
    local data = {}
    data.Id = this.lastSelectItem.data.ID
    ApiMgr.Request("operateBuild/techTree", data, true, onSucc, nil, true)
end

this.OnPointerUp = function(screenPos, eventData)
    SetActive(this.upgradeGroupObj, false)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        for i = 1, this.treeNodeCount do
            local name = "Item" .. i
            local path = "root/Middle/TreeScrollView/Viewport/Content/" .. name
            objs[name] = {path = path, type = UITool.GameObject}
        end

        for i = 1, 2 do
            local name = "MatItemObj" .. i
            local path = "root/Right/UpgradeGroup/NeedMat/" .. name
            objs[name] = {path = path, type = UITool.GameObject}
        end
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        for i = 1, this.treeNodeCount do
            local name = "Item" .. i
            local obj = this[name]
            this.treeNodeItems[i] = TechnologyItem.New(obj)
        end
        for i = 1, 2 do
            local name = "MatItemObj" .. i
            local obj = this[name]
            this.upgradeMatItems[i] = SSYXMakeMatItem.New(obj)
        end
        LuaMgr.AddClick(this.upgradeBtn, this.OnClickUpgradeBtn)
        LuaMgr.AddClick(this.confirmUpgradeBtn, this.OnClickConfirmUpgradeBtn)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.upgradeBtn, this.OnClickUpgradeBtn)
        LuaMgr.RemoveClick(this.confirmUpgradeBtn, this.OnClickConfirmUpgradeBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)