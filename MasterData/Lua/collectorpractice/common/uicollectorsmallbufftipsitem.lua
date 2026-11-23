UICollectorSmallBuffTipsItem = {}

UICollectorSmallBuffTipsItem.__index = UICollectorSmallBuffTipsItem
function UICollectorSmallBuffTipsItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UICollectorSmallBuffTipsItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.imgBuffIcon = uiLink:Get("imgBuffIcon"):GetComponent("Image");
    self.goBuffFrame = uiLink:Get("goBuffFrame");
    self.goDebuffFrame = uiLink:Get("goDebuffFrame");
    self.btnClick = uiLink:Get("btnClick"):GetComponent("Button");
    self.rectGroup = uiLink:Get("rectGroup"):GetComponent("RectTransform");
    uiLink:AddClickEvent("btnClick", function()
self.data.fun(self);
    end)
    return self
end

function UICollectorSmallBuffTipsItem:SetData(data)
    SetActive(self.gameObject,true);
    self.data = data
    local buffConfig = json.decode(LuaMgr.GetBuffDes(self.data.Buffid))
    if buffConfig ~= nil and buffConfig ~= "" then
        self.imgBuffIcon.sprite = LuaMgr.GetSprite("BuffIcon", buffConfig.BuffIcon)
    end
    self:SetBuffType(self.data.Type)
end

function UICollectorSmallBuffTipsItem:SetBuffType(type)
    if type==1 then
        SetActive(self.goBuffFrame,true);
        SetActive(self.goDebuffFrame,false);
    elseif type==2 then
        SetActive(self.goBuffFrame,false);
        SetActive(self.goDebuffFrame,true);
    end
end
function UICollectorSmallBuffTipsItem:Hide()
    SetActive(self.gameObject,false);
end
function UICollectorSmallBuffTipsItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil
    self.transform = nil
    self.imgBuffIcon = nil;
    self.goBuffFrame = nil;
    self.goDebuffFrame = nil;
    self.btnClick = nil;
    self.rectGroup = nil;
end