GoodsItem = {};

GoodsItem.__index = GoodsItem;

local objs = {
    ui_button = { path = "", type = "Button" },
    ui_item = { path = "Item", type = "Transform" },
    ui_itemImg = { path = "Item", type = "Image" },
    ui_icon = { path = "Item/Icon", type = "RawImage" },
    ui_count = { path = "Item/Count", type = "GameObject" },
    ui_countText = { path = "Item/Count/Text", type = "Text" },
}

local function OnClick(self)
    if (not self.isClick) then return; end
    
    local item = ConfigMgr.Config.itemMap[self.id];
    if (item ~= nil) then
        if (item.type == 9) then
            LuaMgr.ShowPanel(UIName.WeaponTipsViewModel, self.id);
        else
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, self.id);
        end
    end
end

GoodsItem.New = function(parent)
    local self = {};
    setmetatable(self, GoodsItem);
    self.gameObject = LuaMgr.GetPrefab("UI/Common/GoodsItem2.prefab");
    self.transform = self.gameObject.transform;
    self.transform:SetParent(parent, false);
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.ui_button, function()
        OnClick(self);
    end);
    return self;
end

function GoodsItem:SetData(id, count, showType, scale, isClick)
    self.id = id;
    self.isClick = isClick;
    local config = ConfigMgr.Config.itemMap[id];
    if (config ~= nil) then
        self.ui_itemImg.sprite = LuaMgr.GetSprite("ItemRare", "itemRare" .. config.rare);
        self.ui_icon.texture = LuaMgr.GetTexture("Images/ItemIcons/itemicon_" .. id ..".png");
        if (showType == ItemShowType.NONE) then
            self.ui_count:SetActive(false);
        else
            self.ui_countText.text = tostring(count);
            self.ui_count:SetActive(count >= 0);
        end
        self.ui_item.localScale = Vector3(scale, scale, 1);
        local size = math.floor(128 * scale);
        self.transform.sizeDelta = Vector2(size, size);
    end
end

function GoodsItem:Clear()
    if (self.gameObject ~= nil) then
        self.gameObject:SetActive(false);
    end
end

function GoodsItem:Destroy()
    self.transform = nil;
    if (self.gameObject ~= nil) then
        LuaMgr.DestroyGO(self.gameObject);
        self.gameObject = nil;
    end
end