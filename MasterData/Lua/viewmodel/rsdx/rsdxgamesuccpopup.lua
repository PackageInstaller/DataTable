local objs = {
    rewardItem = {path = "template/ItemParent", type = UITool.GameObject},
    leftBtn = {path = "root/Middle/ButtonGroup/LeftBtn", type = UITool.Button},
    rightBtn = {path = "root/Middle/ButtonGroup/RightBtn", type = UITool.Button},
    rewardParent = {path = "root/Middle/RewardParent", type = UITool.Transform},
    remainStepTxt = {path = "root/Middle/RemainStep", type = UITool.Text}
}

local this = {

    rewardItems = {},

    rewardItemPool = {}
}

this.before_awake = function()
end

this.before_active = function()
    this.RefreshReward()
    this.remainStepTxt.text = tostring(this.remainStep)
end

this.RefreshReward = function()
    local datas = this.rewardData
    local status = CommonRewardItem.Status.None
    if RSDXMgr.CheckGameIsComplete(this.curPassID) then
        status = CommonRewardItem.Status.Got
    end
    for i = 1, #datas do
        local data = table.CopyNoMeta(datas[i])
        data.status = status
        local rewardItem = this.GetRewardItem()
        SetActive(rewardItem.gameObject, true)
        rewardItem.gameObject.transform:SetAsLastSibling()
        rewardItem:SetData1(data)
        table.insert(this.rewardItems, rewardItem)
    end
end

this.GetRewardItem = function()
    local rewardItem = nil
    if #this.rewardItemPool > 0 then
        rewardItem = table.remove(this.rewardItemPool)
    else
        local obj = LuaMgr.InstantiateGO(this.rewardItem, this.rewardParent, false)
        rewardItem = CommonRewardItem.New(obj, true, 0.55)
    end
    return rewardItem
end

this.RecycleAllRewardItem = function()
    for i = 1, #this.rewardItems do
        local rewardItem = this.rewardItems[i]
        SetActive(rewardItem.gameObject, false)
        table.insert(this.rewardItemPool, rewardItem)
    end
    this.rewardItems = {}
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.RSDXGameSuccPopup)
end

this.OnClickLeft = function()
    this.OnClickBack()
    if this.data.OnClickLeft then
        this.data.OnClickLeft()
    end
end

this.OnClickRight = function()
    local passEventData = RSDXMgr.GetEventDataByPassID(this.data.NextPassID)
    if passEventData and passEventData.openDate > 0 and passEventData.closeDate > 0 then
        if LuaMgr.Timestamp() < passEventData.openDate then
            local lockInfo = os.date("%Y/%m/%d %H:%M", passEventData.openDate)
            local tipsContent = string.format(ConfigMgr.LangGlobal("31158"), lockInfo)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
    end
    this.OnClickBack()
    if this.data.OnClickRight then
        this.data.OnClickRight(this.data.NextPassID)
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.leftBtn, this.OnClickLeft)
        LuaMgr.AddClick(this.rightBtn, this.OnClickRight)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length == 0 then
            return
        end
        local paramData = vm.behaviour.Params[0]
        this.remainStep = paramData.RemainStep
        this.rewardData = paramData.RewardData
        this.curPassID = paramData.PassID
        this.data = paramData
        SetActive(this.rightBtn.gameObject, paramData.OnlyLeftBtn == false)
        this.before_active()
    end,
    before_deactive = function(vm)
        this.RecycleAllRewardItem()
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.leftBtn, this.OnClickLeft)
        LuaMgr.RemoveClick(this.rightBtn, this.OnClickRight)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)