local objs = {
    maskBtn = {path = "root/Middle/Mask", type = UITool.Button},
    name = {path = "root/Middle/Goods/Name/Text", type = UITool.Text},
    desc = {path = "root/Middle/Goods/Desc/Viewport/Content/Text", type = UITool.Text},
    goodsItem = {path = "root/Middle/Goods/Item/Item/GoodsItem", type = UITool.GoodsViewModel},
    iconSprite = {path = "root/Middle/Goods/Item/Item/IconSprite", type = UITool.Image}
}

local this = {}

this.before_awake = function()
end

this.before_active = function()
    this.name.text = this.itemData.Name
    this.desc.text = this.itemData.Desc
    SetActive(this.iconSprite.gameObject, this.itemData.IsInBag == false)
    SetActive(this.goodsItem.gameObject, this.itemData.IsInBag == true)
    if this.itemData.IsInBag == true then
        this.goodsItem:SetData(this.itemData.ID, -1, 1, 1, true)
    else
        this.iconSprite.sprite = LuaMgr.GetSprite(SSYXConst.ItemAtlaName, this.itemData.Icon)
    end
end

this.OnClickMaskBtn = function()
    LuaMgr.HidePanel(UIName.SSYXGoodsTipsPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.maskBtn, this.OnClickMaskBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length == 0 then
            return
        end
        this.itemData = vm.behaviour.Params[0]
        this.before_active()
    end,
    before_deactive = function(vm)
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