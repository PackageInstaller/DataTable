require("ViewModel/SuiChuNaJi/ViewItem/SCNJBuffLevelUpItem")
local objs = {
    buffItem = {path = "template/BuffItem", type = UITool.GameObject},
    upBeforeProgress = {path = "root/Middle/Group/ProgressGroup/UpBeforeProgress", type = UITool.Text},
    upAfterProgress = {path = "root/Middle/Group/ProgressGroup/UpAfterProgress", type = UITool.Text},
    itemParent = {path = "root/Middle/Group/ProgressUnlockGroup/ItemParent", type = UITool.Transform},
    processObj = {path = "root/Middle/Group/ProgressUnlockGroup", type = UITool.GameObject},
    buffGroupObj = {path = "root/Middle/Group/BuffGroup", type = UITool.GameObject},
    buffScrollView = {path = "root/Middle/Group/BuffGroup/BuffScrollView", type = UITool.GameObject},
    maskCloseBtn = {path = "root/Mask", type = UITool.Button}
}

local this = {}

this.before_awake = function()
    this.buffScrollViewUI = UIScrollView.New(this.buffScrollView)
end

this.before_active = function()
    this.upBeforeProgress.text = string.format("<size=36>%d</size> (%.0f%%)", this.oldProcessData.hotLevel, this.oldProcessData.hotExp / SCNJConst.HotExpPercentBase * 100)
    this.upAfterProgress.text = string.format("<color=#71823C><size=36>%d</size></color> (%.0f%%)", this.curProcessData.hotLevel, this.curProcessData.hotExp / SCNJConst.HotExpPercentBase * 100)

    SetActive(this.processObj, this.tipConfigData.Reward ~= nil and #this.tipConfigData.Reward > 0)
    SetActive(this.buffGroupObj, this.tipConfigData.BuffGroup ~= nil and #this.tipConfigData.BuffGroup > 0)
    if this.goodsItems == nil then
        this.goodsItems = {}
    end
    if this.tipConfigData.Reward ~= nil then
        for i = 1, #this.goodsItems do
            local goodsItem = this.goodsItems[i]
            SetActive(goodsItem.gameObject, false)
        end
        for i = 1, #this.tipConfigData.Reward do
            local goodsItem = this.goodsItems[i]
            if goodsItem == nil then
                goodsItem = GoodsDataItem.New(this.itemParent)
                table.insert(this.goodsItems, i, goodsItem)
            else
                SetActive(goodsItem.gameObject, true)
            end
            local reward = this.tipConfigData.Reward[i]
            local itemConfig = ConfigMgr.Config.itemMap[reward.id]
            if itemConfig ~= nil then
                local itemData = table.Copy(itemConfig)
                itemData.count0 = reward.count
                goodsItem:SetData(1, itemData, 1, false, Vector3(reward.scale, reward.scale, 1), false)
                goodsItem:SetCount(nil, Vector2(-10, 10), Vector3.one)
                goodsItem:SetIconBg(false)
            end
        end
    end
    if this.tipConfigData.BuffGroup ~= nil then
        this.buffScrollViewUI:Clear()
        local allDatas = this.GetBuffUnionDatas()
        local scrollDatas = {}
        local itemWidth, itemHeight = 156.4, 102.5
        for i = 1, #allDatas do
            local data = allDatas[i]
            local scrollData = UIScrollData.GetData(this.buffItem, "SCNJBuffLevelUpItem", itemWidth, itemHeight, data)
            table.insert(scrollDatas, scrollData)
        end
        local totalWidth = math.min(itemWidth * #allDatas, 477.8)
        this.buffScrollViewUI:SetParams(totalWidth, itemHeight + 5)
        this.buffScrollViewUI:SetData(scrollDatas, true)
    end
end

this.GetBuffUnionDatas = function()
    local oldBuffs = this.tipConfigData.prefixBuff
    local newBuffs = this.tipConfigData.BuffGroup
    local tempBuffIDs = {}
    if oldBuffs ~= nil then
        for i = 1, #oldBuffs do
            table.insert(tempBuffIDs, oldBuffs[i])
        end
    end
    for i = 1, #newBuffs do
        table.insert(tempBuffIDs, newBuffs[i])
    end
    local tempBuffDic = {}
    for i = 1, #tempBuffIDs do
        local buffID = tempBuffIDs[i]
        local buffConfig = ConfigMgr.Config.TeamRelayBuffDescMap[buffID]
        local buffGroup = type(buffConfig.Param) == "table" and buffConfig.Param[1] or buffConfig.BuffId
        local tempBuffGroup = tempBuffDic[buffGroup]
        if tempBuffGroup == nil then
            tempBuffGroup = {}
            tempBuffDic[buffGroup] = tempBuffGroup
        end
        table.insert(tempBuffGroup, buffConfig)
    end
    local datas = {}
    for key, groupDatas in pairs(tempBuffDic) do
        if #groupDatas == 0 or #groupDatas > 2 then
            LuaDebug.error("91 this.GetBuffUnionDatas Buff配置不合法" .. key)
            break
        end
        local data = {}
        local buffLevel1 = tonumber(groupDatas[1].Param[2]) or 0
        if #groupDatas == 2 then
            local buffLevel2 = tonumber(groupDatas[2].Param[2]) or 0
            if buffLevel1 < buffLevel2 then
                data.BuffConfig = groupDatas[2]
                data.BeforeLevel = buffLevel1
                data.AfterLevel = buffLevel2
            else
                data.BuffConfig = groupDatas[1]
                data.BeforeLevel = buffLevel2
                data.AfterLevel = buffLevel1
            end
        else
            data.BuffConfig = groupDatas[1]
            data.BeforeLevel = buffLevel1
        end
        if data.BuffConfig ~= nil then
            data.BuffIcon = data.BuffConfig.BuffIcon
            data.Name = LuaMgr.GetLangText(data.BuffConfig.BuffName)
            data.Desc = LuaMgr.GetLangText(data.BuffConfig.BuffDesLan)
        else

        end
        table.insert(datas, data)
    end
    return datas
end

this.OnClickCloseBtn = function()
    LuaMgr.HidePanel(UIName.SCNDungeonProgressPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.maskCloseBtn, this.OnClickCloseBtn)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.oldProcessData = vm.behaviour.Params[0]
        this.curProcessData = vm.behaviour.Params[1]
        this.tipConfigData = vm.behaviour.Params[2]
        this.before_active()
    end,
    before_deactive = function(vm)
        UIScrollView.ClearItem("SCNJBuffLevelUpItem")
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClickCloseBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)