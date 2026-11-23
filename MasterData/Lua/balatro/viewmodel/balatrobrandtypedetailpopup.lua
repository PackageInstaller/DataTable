







require("Balatro/ViewModel/BalatroBrandItem")
local this = {

    brandTypeData = nil,

    brandItems = nil
}

local objs = {
    brandItem = {path = "template/BrandItem", type = BalatroUtil.GameObject},
    closeBtn = {path = "root/Mask", type = BalatroUtil.Button},
    brandParent = {path = "root/Middle/BrandParent", type = BalatroUtil.Transform},
    des = {path = "root/Middle/Des", type = BalatroUtil.Text},
    name = {path = "root/Middle/Name", type = BalatroUtil.Text}
}

this.before_awake = function()
    LuaMgr.AddClick(this.closeBtn, this.OnClickBack)
end

this.before_active = function()
    if not this.brandTypeData then
        return
    end
    local modeBrandLen = #this.brandTypeData:GetModelIDs()
    if not this.brandItems or #this.brandItems == 0 then
        this.brandItems = {}
        for i = 1, modeBrandLen do
            local obj = BalatroBrandItem.New(this.brandItem, this.brandParent, false, i)
            table.insert(this.brandItems, obj)
        end
    end
    this.name.text = this.brandTypeData:GetName()
    this.des.text = this.brandTypeData:GetDes()
    for i = 1, modeBrandLen do
        local item = this.brandItems[i]
        if not item then
            return
        end
        local brandID = this.brandTypeData:GetModelIDs()[i]
        local brandConfig = BalatroDataMgr.GetGeneralBrandConfig(brandID)
        SetActive(item.gameObject, true)
        item:SetData(BalatroBrandItem.SizeType.Small, brandConfig.ResID)
    end
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.BalatroBrandTypeDetailPopup)
end

this.ParseParam = function(data)
    this.brandTypeData = data
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddUIEventListener(UIEventConst.BalatroIntoCalView, this.OnClickBack)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params then
            this.ParseParam(vm.behaviour.Params[0])
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickBack)
        LuaMgr.RemoveUIEventListener(UIEventConst.BalatroIntoCalView, this.OnClickBack)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)