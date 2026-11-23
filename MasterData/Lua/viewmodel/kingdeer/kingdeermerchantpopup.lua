






require("ViewModel/KingDeer/KingDeerMerchantGoodsItem")
local objs = {
    goodsPrefab = {path = "template/GoodsItem", type = UITool.GameObject},
    goodsParentTrans = {path = "root/Middle/GoodsParent", type = UITool.Transform},
    closeBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    maskBtn = {path = "root/Mask", type = UITool.Button},
    downTimeTxt = {path = "root/Middle/TimeGroup/DownTimeTxt", type = UITool.Text}
}

local this = {

    goodsItems = {}
}

this.before_awake = function()
end

this.before_active = function()
    this.RefreshUI()
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.KingDeerMerchantPopup)
end

this.RefreshUI = function()
    local datas, refreshTime = KingDeerData.GetRandomShopData()
    this.refreshTime = refreshTime
    if datas == nil then
        return
    end
    for i = 1, #datas do
        if #datas ~= #this.goodsItems then
            local item = KingDeerMerchantGoodsItem.New(this.goodsPrefab, this.goodsParentTrans, i)
            table.insert(this.goodsItems, item)
        else
            break
        end
    end
    for i = 1, #datas do
        local item = this.goodsItems[i]
        local data = datas[i]
        item:SetData(data)
    end
    LuaMgr.AddTimer(TimerConst.KingDeerRandomShop, this.RefreshDownTime, 1, -1, true)
end

this.RefreshDownTime = function()
    local remainTime = this.refreshTime - LuaMgr.Timestamp()
    if remainTime >= 0 then
        local hour, minute, seconds = GetTimeHMS2(remainTime)
        local timeStr = string.format("%d:%0d:%0d", hour, minute, seconds)
        this.downTimeTxt.text = timeStr
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.closeBtn, this.OnClickBack)
        LuaMgr.AddClick(this.maskBtn, this.OnClickBack)
        this.before_awake()
    end,
    before_active = function(vm)
        this.before_active()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.KingDeerRandomShop)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickBack)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickBack)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)