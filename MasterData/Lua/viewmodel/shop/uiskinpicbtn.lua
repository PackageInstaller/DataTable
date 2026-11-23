UISkinPicBtn = {}
UISkinPicBtn.__index = UISkinPicBtn

function UISkinPicBtn.New(prefab, parent)
    local self = {}
    setmetatable(self, UISkinPicBtn)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.root = uiLink:Get("root");
    self.goLock = uiLink:Get("goLock");
    self.goIsOn = uiLink:Get("goIsOn");
    self.imgLock = uiLink:Get("imgLock"):GetComponent("Image");
    self.imgTypeLock = uiLink:Get("imgTypeLock"):GetComponent("Image");
    self.imgIsOn = uiLink:Get("imgIsOn"):GetComponent("Image");
    self.imgTypeIsOn = uiLink:Get("imgTypeIsOn"):GetComponent("Image");

    uiLink:SetClickEvent(function()
        if self.fun~=nil and not self.isChoose then
            self.fun(self.type)
        end
    end)
    
    return self
end

function UISkinPicBtn:Destroy()
    self.gameObject = nil
    self.transform = nil
    self.root = nil;
    self.goLock = nil;
    self.goIsOn = nil;
    self.imgLock = nil;
    self.imgTypeLock = nil;
    self.imgIsOn = nil;
    self.imgTypeIsOn = nil;
end

function UISkinPicBtn:SetData(type,isChoose,fun)
    self.type = type;
    self.fun = fun;
    self.isChoose=isChoose;

    SetActive( self.goLock, not isChoose)
    SetActive( self.goIsOn,  isChoose)
    self.imgLock.sprite=LuaMgr.GetSprite("Shop","ui_shop_pftj_lock_"..type)
    self.imgTypeLock.sprite =LuaMgr.GetSprite("Shop","ui_shop_pftj_typelock_"..type)
    self.imgIsOn.sprite=LuaMgr.GetSprite("Shop","ui_shop_pftj_isOn_"..type)
    self.imgTypeIsOn.sprite =LuaMgr.GetSprite("Shop","ui_shop_pftj_typeisOn_"..type)
end

function UISkinPicBtn:Clear()
    SetActive(self.gameObject,false)
end