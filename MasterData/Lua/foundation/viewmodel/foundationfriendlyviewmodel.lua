require("Foundation/ViewModel/FoundationFriendlyItem")

local this = {
    friendlyList = {},
    friendlySVPos = Vector2(0,-173),
}

local objs = {
    maskBtn = { path = "root/Mask", type = "Button" },
    friendlyItem = { path = "template/FriendlyItem", type = "GameObject" },
    friendlySV = { path = "root/Middle/Friendly/ScrollView", type = "Transform" },
    friendlyContent = { path = "root/Middle/Friendly/ScrollView/Viewport/Content", type = "RectTransform" },
    tips = { path = "root/Middle/Friendly/Tips", type = "Text" },
}


this.SetFriendlyList = function(data)
    local friendly;
    local index = 1;
    for k, v in pairs(data) do
        friendly = this.friendlyList[index];
        if (friendly == nil) then
            friendly = FoundationFriendlyItem.New(this.friendlyItem, this.friendlyContent);
            this.friendlyList[index] = friendly;
        end
        friendly:SetData({characterId=k, count=v});
        index = index + 1;
    end
    local len = #this.friendlyList;
    for i = index, len do
        friendly = this.friendlyList[i];
        if (friendly ~= nil) then
            friendly:Clear();
        end
    end
    if (index - 1 > 6) then
        this.friendlySVPos.y = -173;
    else
        this.friendlySVPos.y = -245;
    end
    this.friendlySV.anchoredPosition = this.friendlySVPos;
    local maxHG = ConfigMgr.Config.constants.MaxPrestigeByWorkPerWeek;
    this.tips.text = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6801"].NameLan), maxHG);
end


this.DestroyFriendlyList = function()
    local len = #this.friendlyList;
    for i = 1, len do
        this.friendlyList[i]:Destroy();
    end
    this.friendlyList = {};
end


this.OnClickMask = function()
    LuaMgr.HidePanel(UIName.FoundationFriendlyViewModel);
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
        
        local data = vm.behaviour.Params[0];
        this.SetFriendlyList(data);
    end,
    before_deactive = function(vm)
        
    end,
    before_destroy = function(vm)
        this.DestroyFriendlyList();
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})