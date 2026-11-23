FoundationComposeChoiceItem = {};

FoundationComposeChoiceItem.__index = FoundationComposeChoiceItem;

local objs = {
    light = { path = "Light", type = "GameObject" },
    name = { path = "Name", type = "Text" },
    itemBg = { path = "Item", type = "Image" },
    itemIcon = { path = "Item/Icon", type = "RawImage" },
    count = { path = "Count", type = "Text" },
    selectGO = { path = "Select", type = "GameObject" },
    selectBtn = { path = "Select", type = "Button" },
    cancelGO = { path = "Cancel", type = "GameObject" },
    cancelBtn = { path = "Cancel", type = "Button" },
}

function FoundationComposeChoiceItem.New(prefab, parent)
    local self = {};
    setmetatable(self, FoundationComposeChoiceItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.transform = self.gameObject:GetComponent("RectTransform");
    LuaMgr.SetFont(self.transform);
    self.OnClickSelect = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationComposeChoice, self.data.id, true);
    end
    self.OnClickCancel = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationComposeChoice, self.data.id, false);
    end
    LuaMgr.AddClick(self.selectBtn, self.OnClickSelect);
    LuaMgr.AddClick(self.cancelBtn, self.OnClickCancel);
    return self;
end

function FoundationComposeChoiceItem:SetData(data)
    self.data = data;
    local itemConfig = ConfigItemMgr.GetItemById(data.id);
    if (itemConfig ~= nil) then
        self.name.text = LuaMgr.GetLangText(itemConfig.nameLan);
        self.itemBg.sprite = LuaMgr.GetSprite("ItemRare", "itemRare" .. itemConfig.rare);
        self.itemIcon.texture = GetItemTexture(data.id);
    end
    local itemCount = PlayerItemMgr.GetItemCountById(data.id);
    if (data.count > itemCount) then
        self.count.text = string.format("<color=#ff0000>%d</color>/%d", itemCount, data.count);
    else
        self.count.text = string.format("%d/%d", itemCount, data.count);
    end
    SetActive(self.gameObject, true);
end

function FoundationComposeChoiceItem:Choice(callback)
    if self.data==nil then return end;
    local status = callback(self.data.id);
    SetActive(self.light, status);
    SetActive(self.selectGO, not status);
    SetActive(self.cancelGO, status);
end

function FoundationComposeChoiceItem:Clear()
    self.data = nil;
    self.itemBg.sprite = nil;
    self.itemIcon.texture = nil;
    SetActive(self.gameObject, false);
end

function FoundationComposeChoiceItem:Destroy()
    if (self.OnClickSelect ~= nil) then
        LuaMgr.RemoveClick(self.selectBtn, self.OnClickSelect);
        self.OnClickSelect = nil;
    end
    if (self.OnClickCancel ~= nil) then
        LuaMgr.RemoveClick(self.cancelBtn, self.OnClickCancel);
        self.OnClickCancel = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end