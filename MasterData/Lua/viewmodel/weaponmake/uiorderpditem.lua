UIOrderPdItem = {}
UIOrderPdItem.__index = UIOrderPdItem

function UIOrderPdItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UIOrderPdItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.root = uiLink:Get("root");
    self.goRedPoint = uiLink:Get("goRedPoint");
    self.imgZhezhao = uiLink:Get("goZhezhao"):GetComponent("Image");
    self.imgEnterCrafts= uiLink:Get("btnEnterCrafts"):GetComponent("Image");
    self.rawImage = uiLink:Get("rawImage"):GetComponent("RawImage");

    uiLink:AddClickEvent("btnEnterCrafts", function()
        if self.fun~=nil then
            self.fun(self.orderType)
        end
    end)
    
    return self
end

function UIOrderPdItem:SetData(key,isChoose,data,fun)
    self.data=data;
    self.fun=fun;
    self.orderType=key;
    self.Order=0;
    
    SetActive(self.imgZhezhao.gameObject,not isChoose);

    local crderItem = ConfigMgr.Config.weaponMade.OrdersType[key];
    if crderItem~=nil then
        self.Order=crderItem.Order;
        local itemPath = ConfigHelper.GetItemIconPath(crderItem.SpendItems);
        self.rawImage.texture = LuaMgr.GetTexture(itemPath);
    end

    self.imgEnterCrafts.sprite=LuaMgr.GetSprite("WeaponMake","ui_wqzz_tab_"..key);
    self.imgZhezhao.sprite=LuaMgr.GetSprite("WeaponMake","ui_wqzz_tab_zhezhao_"..key);
end

function UIOrderPdItem:Clear()
    self.data=nil;
    self.fun=nil;
    self.orderType=nil;
    SetActive(self.gameObject,false)
end

function UIOrderPdItem:Destroy()
    self.gameObject = nil
    self.transform = nil
    self.root = nil;
    self.goRedPoint = nil;
    self.imgZhezhao = nil;
    self.imgEnterCrafts = nil;
    self.rawImage = nil;
end