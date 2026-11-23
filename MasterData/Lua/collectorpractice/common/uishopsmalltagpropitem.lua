
UIShopSmallTagPropItem = {}
UIShopSmallTagPropItem.__index = UIShopSmallTagPropItem


function UIShopSmallTagPropItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UIShopSmallTagPropItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.goSmallTagPropLight = uiLink:Get("goSmallTagPropLight");
    self.goSmallTagPropDark = uiLink:Get("goSmallTagPropDark");
    self.imgIconLight = uiLink:Get("imgIconLight"):GetComponent("Image");
    self.imgIconDark = uiLink:Get("imgIconDark"):GetComponent("Image");
    uiLink:AddClickEvent("goSmallTagPropDark", function()
        if self.fun ~= nil then
            self.fun(self.shopId,self.OriginsID);
        end
    end)
    return self
end

function UIShopSmallTagPropItem:SetData(shopId,OriginsID,clickAction)
    SetActive(self.gameObject, true);
    self.OriginsID=OriginsID;
    self.shopId=shopId;
    self.fun=clickAction;
    self.imgIconLight.sprite = LuaMgr.GetSprite("CollectorShop",
    OriginsID);
    self.imgIconDark.sprite = LuaMgr.GetSprite("CollectorShop",
    OriginsID);
end
function UIShopSmallTagPropItem:SetSelect(Select)
    SetActive(self.goSmallTagPropLight,Select);
    SetActive(self.goSmallTagPropDark,not Select);
end
function UIShopSmallTagPropItem:Clear()
    SetActive(self.gameObject, false);
end

function UIShopSmallTagPropItem:Destroy()
    self.gameObject = nil
    self.transform = nil
    self.goSmallTagPropLight = nil;
    self.goSmallTagPropDark = nil;
    self.imgIconLight = nil;
    self.imgIconDark = nil;
end