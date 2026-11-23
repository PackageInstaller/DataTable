local this = {
    cardData = nil,
};

local objs = {
    maskBtn = { path = "root/Mask", type = "Button" },
    card = { path = "root/Middle/CardInfo/Card", type = "RawImage" },
    name = { path = "root/Middle/CardInfo/Name", type = "Text" },
    content = { path = "root/Middle/CardInfo/ScrollView/Viewport/Content", type = "UIText" },
    path = { path = "root/Middle/CardInfo/Path/Text", type = "Text" },
};


this.SetData = function()
    local path = string.format("Assets/_BundleResources/Images/Voyage/sailingGoods_%s.png", this.cardData.GoodsID);
    this.card.texture = LuaMgr.GetTexture(path);
    this.name.text = LuaMgr.GetLangText(this.cardData.NameLan);
    this.content.text = LuaMgr.GetLangText(this.cardData.DesLan);
    this.path.text = LuaMgr.GetLangText("VoyageCardInfoViewModel_1");
end


this.OnClickMask = function()
    LuaMgr.HidePanel(UIName.VoyageCardInfoViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.cardData = vm.behaviour.Params[0];
        this.SetData();
    end,
    before_deactive = function(vm)
        this.card.texture = nil;
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})