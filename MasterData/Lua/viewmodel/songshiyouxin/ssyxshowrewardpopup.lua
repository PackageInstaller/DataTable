require("ViewModel/SongShiYouXin/ViewItem/SSYXRewardItem")
local objs = {
    itemPrefab = {path = "template/Item", type = UITool.GameObject},
    rewardItemParent = {path = "root/Middle/Mask/ItemParent", type = UITool.Transform},
    maskBtn = {path = "root/Middle/Mask", type = UITool.Button}
}

local this = {

    rewardItems = {},

    rewardItemsCache = {}
}

this.before_awake = function()
    this.rewardItems = {}
    this.rewardItemsCache = {}
end

this.before_active = function()
    for i = 1, #this.itemDatas do
        local data = this.itemDatas[i]
        if data.ID ~= SSYXConst.GamePropsID1 and data.ID ~= SSYXConst.GamePropsID2 then
            local item = this.GetRewardItem()
            SetActive(item.gameObject, true)
            item:SetData(data)
        end
    end
end

this.GetRewardItem = function()
    local item = table.remove(this.rewardItemsCache)
    if item == nil then
        local obj = LuaMgr.InstantiateGO(this.itemPrefab, this.rewardItemParent, false)
        item = SSYXRewardItem.New(obj)
    end
    table.insert(this.rewardItems, item)
    return item
end

this.RecycleAllRewardItem = function()
    for i = 1, #this.rewardItems do
        local item = this.rewardItems[i]
        item:Clear()
        SetActive(item.gameObject, false)
        table.insert(this.rewardItemsCache, item)
    end
    this.rewardItems = {}
end

this.OnClickMaskBtn = function()
    LuaMgr.HidePanel(UIName.SSYXShowRewardPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.maskBtn, this.OnClickMaskBtn)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length == 0 then
            return
        end
        this.itemDatas = vm.behaviour.Params[0]
        this.before_active()
    end,
    before_deactive = function(vm)
        this.RecycleAllRewardItem()
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMaskBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)