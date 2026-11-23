UITrammelsItem = {}
UITrammelsItem.__index = UITrammelsItem
function UITrammelsItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UITrammelsItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.imgTagIcon = uiLink:Get("imgTagIcon"):GetComponent("Image");
    self.textTagIconName = uiLink:Get("textTagIconName"):GetComponent("Text");
    self.textTagIconIntro = uiLink:Get("textTagIconIntro"):GetComponent("Text");
    self.goLock = uiLink:Get("goLock");
    return self
end

function UITrammelsItem:Destroy()
    self.gameObject = nil
    self.transform = nil
    self.imgTagIcon = nil;
    self.textTagIconName = nil;
    self.textTagIconIntro = nil;
    self.goLock = nil;
end

function UITrammelsItem:SetData(data)
    SetActive(self.goLock,data.isLock)
    local ot = data.OriginsData;
    local teleten = ConfigMgr.Config.talentBankMap
    self.imgTagIcon.sprite = LuaMgr.GetSprite("CollectorHome", ot.OriginsID);
    self.textTagIconName.text = LuaMgr.GetLangText(ot.OtNameLan);
    self.textTagIconIntro.text = LuaMgr.GetLangText(teleten[ot.TalentId[1]].DescriptionLan)
end

function UITrammelsItem:Clear()
    SetActive(self.gameObject, false);
end