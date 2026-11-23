VoyageCardItem = {};

VoyageCardItem.__index = VoyageCardItem;

local objs = {
    button = { path = "", type = "Button" },
    unlock = { path = "Unlock", type = "GameObject" },
    unlockImg = { path = "Unlock", type = "RawImage" },
    lock = { path = "Lock", type = "GameObject" },
};

function VoyageCardItem.New()
    local self = {};
    setmetatable(self, VoyageCardItem);
    return self;
end

function VoyageCardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        local cardData = DataMgr.Player.SailingCards[self.data.GoodsID];
        if (cardData == nil) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageCardItem_0"));
            return;
        end
        LuaMgr.ShowLuaPanel(UIName.VoyageCardInfoViewModel, self.data);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function VoyageCardItem:SetData(data)
    self.data = data.data;
    local cardData = DataMgr.Player.SailingCards[self.data.GoodsID];
    if (cardData ~= nil) then
        local path = string.format("Assets/_BundleResources/Images/Voyage/sailingGoods_%s.png", self.data.GoodsID);
        self.unlockImg.texture = LuaMgr.GetTexture(path);
        SetActive(self.unlock, true);
        SetActive(self.lock, false);
    else
        SetActive(self.unlock, false);
        SetActive(self.lock, true);
    end
end

function VoyageCardItem:Clear()
    self.data = nil;
    self.unlockImg.texture = nil;
end

function VoyageCardItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end