require("ViewModel/SongShiYouXin/ViewItem/SSYXOrderItem")
require("ViewModel/SongShiYouXin/ViewItem/SSYXMakeMatItem")
local objs = {
    canGetObj = {path = "root/Middle/Group/FreeRewardItem/CanGetBG", type = UITool.GameObject},
    noGetObj = {path = "root/Middle/Group/FreeRewardItem/NoGetBG", type = UITool.GameObject},
    getGiftBtn = {path = "root/Middle/Group/FreeRewardItem/GiftPrarent", type = UITool.Button},
    progress = {path = "root/Middle/Group/FreeRewardItem/Progress", type = UITool.Image},
    downTime = {path = "root/Middle/Group/FreeRewardItem/DownTime", type = UITool.Text},
    previewObj = {path = "root/Middle/Group/FreeRewardItem/PreviewObj", type = UITool.GameObject},
    selectFlag = {path = "root/Middle/Group/FreeRewardItem/CanGetBG/SelectFlag", type = UITool.GameObject},
    selectFlagNoGet = {path = "root/Middle/Group/FreeRewardItem/NoGetBG/SelectFlag", type = UITool.GameObject},
    characterParent = {path = "root/Middle/CharacterParent", type = UITool.Transform}
}

local this = {

    orderItems = {},

    previewItems = {},
    previewRewardDatas = {}
}

this.BatchInitNode = function()
    for i = 1, 4 do
        local orderObjName = "OrderItemObj" .. i
        local path = string.format("root/Middle/Group/%s", orderObjName)
        objs[orderObjName] = {path = path, type = UITool.GameObject}
    end

    for i = 1, 3 do
        local giftIconName = "Gift" .. i
        local path = string.format("root/Middle/Group/FreeRewardItem/GiftPrarent/%s", giftIconName)
        objs[giftIconName] = {path = path, type = UITool.GameObject}

        local giftIconName = "GiftGotObj" .. i
        local path1 = string.format("%s/GotObj", path)
        objs[giftIconName] = {path = path1, type = UITool.GameObject}

        local giftBtnName = "GiftBtn" .. i
        local path2 = string.format("root/Middle/Group/FreeRewardItem/%s", giftBtnName)
        objs[giftBtnName] = {path = path2, type = UITool.Button}

        local smallGiftIconName = "SmallGiftCanGetObj" .. i
        local path3 = string.format("%s/CanGetFlag", path2)
        objs[smallGiftIconName] = {path = path3, type = UITool.GameObject}

        local giftGoalCount = "GiftGoalCount" .. i
        local path4 = string.format("%s/OrderCount", path2)
        objs[giftGoalCount] = {path = path4, type = UITool.Text}
    end

    for i = 1, 2 do
        local matItemName = "MatItem" .. i
        local path = string.format("root/Middle/Group/FreeRewardItem/PreviewObj/%s", matItemName)
        objs[matItemName] = {path = path, type = UITool.GameObject}
    end
    UITool.Parse(this.vmBehaviour.gameObject, this, objs)
    for i = 1, 4 do
        local orderObjName = "OrderItemObj" .. i
        local orderItem = SSYXOrderItem.New(this[orderObjName])
        this.orderItems[i] = orderItem
    end
    for i = 1, 3 do
        local giftBtnName = "GiftBtn" .. i
        local func = function()
            this.OnClickGiftByIndex(i)
        end
        local btn = this[giftBtnName]
        LuaMgr.AddClick(btn, func)
    end
    for i = 1, 2 do
        local matItemName = "MatItem" .. i
        this.previewItems[i] = SSYXMakeMatItem.New(this[matItemName])
    end
end

this.before_awake = function()
    SetActive(this.previewObj, false)
    SetActive(this.selectFlag, false)
    SetActive(this.selectFlagNoGet, false)
end

this.before_active = function()
    this.selectPreviewIndex = 1
    this.previewRewardDatas = SSYXData.GetOrderNumDatas()
    this.RefreshPreviewReward()
    this.RefreshOrderList()
    LuaMgr.AddTimer(TimerConst.SSYXOrderRewardTimer, this.RefreshRewardTimer, 1, -1, true)
    LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay, this.RefreshPreviewReward)
    LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay, this.RefreshPreviewReward)
end


this.RefreshOrderList = function()
    local orderDatas = SSYXData.GetAllOrderDatas()
    if #orderDatas ~= #this.orderItems then
        LuaDebug.error("this.RefreshOrderList 90 数据和UI数量不一致")
        return
    end
    for i = 1, #orderDatas do
        local orderData = orderDatas[i]
        local orderItem = this.orderItems[i]
        orderData.OnFastComplateBtn = this.OnClickFastComplateBtn
        orderItem:SetData(orderData)
    end
end



this.RefreshPreviewReward = function()
    this.previewRewardDatas = SSYXData.GetOrderNumDatas()
    this.RefreshOrderList()
    this.OnClickGiftByIndex(this.selectPreviewIndex)
    local firstPreviewData = this.previewRewardDatas[1]
    local curCount, maxCount = SSYXData.GetOrderNum()
    curCount = curCount - firstPreviewData.OrderCount
    curCount = math.max(curCount, 0)
    this.progress.fillAmount = curCount / (maxCount - firstPreviewData.OrderCount)
    for i = 1, 3 do
        local data = this.previewRewardDatas[i]
        local smallGiftIconName = "SmallGiftCanGetObj" .. i
        SetActive(this[smallGiftIconName], data.Status == CommonRewardItem.Status.CanGet)

        local giftGoalCount = "GiftGoalCount" .. i
        this[giftGoalCount].text = tostring(data.OrderCount)
    end
end

this.OnClickGiftByIndex = function(index)
    SetActive(this.previewObj, false)
    SetActive(this.selectFlag, false)
    SetActive(this.selectFlagNoGet, false)
    for i = 1, 3 do
        local giftIconName = "Gift" .. i
        SetActive(this[giftIconName], i == index)
    end
    local data = this.previewRewardDatas[index]
    SetActive(this.canGetObj, data.Status == CommonRewardItem.Status.CanGet)
    SetActive(this.noGetObj, data.Status == CommonRewardItem.Status.None)
    SetActive(this.selectFlag, data.Status == CommonRewardItem.Status.CanGet)
    SetActive(this.gotObj, data.Status == CommonRewardItem.Status.Got)
    local giftIconName = "GiftGotObj" .. index
    SetActive(this[giftIconName], data.Status == CommonRewardItem.Status.Got)
    this.selectPreviewIndex = index
end

this.OnClickGetGiftBtn = function()
    local data = this.previewRewardDatas[this.selectPreviewIndex]
    if data.Status == CommonRewardItem.Status.CanGet then
        SetActive(this.previewObj, false)
        SetActive(this.selectFlag, false)
        SetActive(this.selectFlagNoGet, false)
        local onSucc = function(result)
            local res = json.decode(result)
            if res.code ~= nil and res.code ~= 0 then
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
            LuaMgr.ShowLuaPanel(UIName.SSYXShowRewardPopup, datas)
            this.RefreshPreviewReward()
        end
        local data = {}
        data.Idx = this.selectPreviewIndex - 1
        ApiMgr.Request("operateOrder/order_reward", data, true, onSucc, nil, true)
    else
        local isVisible = this.previewObj.activeSelf == false
        SetActive(this.previewObj, isVisible)
        SetActive(this.selectFlag, isVisible)
        SetActive(this.selectFlagNoGet, isVisible)
        for i = 1, 2 do
            local data = data.Reward[i]
            if data == nil then
                SetActive(this.previewItems[i].gameObject, false)
            else
                data.NumText = tostring(data.Count)
                this.previewItems[i]:SetData(data)
                SetActive(this.previewItems[i].gameObject, true)
            end
        end
    end
end


this.SetCommonChacter = function()
    if this.character ~= nil then
        return
    end
    local characterId = "V0076"
    this.character = CS.Laigu.Tools.SpineCharacter.Create(characterId, characterId .. "001", this.characterParent)
    if this.character ~= nil then
        this.character:Play("house_idle", true, nil)
    end
end



this.OnClickFastComplateBtn = function(item)
    local data = {}
    data.FastType = 1
    data.OrderID = item.data.ID
    data.MsgBoxTitle = LuaMgr.GetLangText(SSYXConst.LanText.LanText41)
    local curTime = LuaMgr.Timestamp()
    data.NeedTime = item.data.EndTime - curTime
    data.ConfirmCallback = this.RefreshOrderList
    LuaMgr.ShowLuaPanel(UIName.SSYXProduceFastPopup, data)
end

this.RefreshRewardTimer = function()
    local remainTime = TimeToNext4AM()
    if remainTime >= 0 then
        local h, m, s = GetTimeHMS(remainTime)
        this.downTime.text = string.format("%02d:%02d:%02d", h, m, s)
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vmBehaviour = vm.behaviour
        this.BatchInitNode()
        this.before_awake()
        LuaMgr.AddClick(this.getGiftBtn, this.OnClickGetGiftBtn)
        LuaMgr.AddUIEventListener(UIEventConst.SSYXOrderRefresh, this.RefreshPreviewReward)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        if vm.behaviour.Params.Length > 0 then
            this.buildData = vm.behaviour.Params[0]
        else
            this.buildData = SSYXData.GetBuildDataByID(SSYXConst.BuildID.ShangCheng)
        end
        this.before_active()
    end,
    before_deactive = function(vm)
        for i = 1, 4 do
            this.orderItems[i]:Clear()
        end
        LuaMgr.RemoveTimer(TimerConst.SSYXOrderRewardTimer)
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay, this.RefreshPreviewReward)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.getGiftBtn, this.OnClickGetGiftBtn)
        LuaMgr.RemoveUIEventListener(UIEventConst.SSYXOrderRefresh, this.RefreshPreviewReward)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)