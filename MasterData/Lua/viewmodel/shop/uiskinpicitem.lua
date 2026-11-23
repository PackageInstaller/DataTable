UISkinPicItem = {}
UISkinPicItem.__index = UISkinPicItem
local PREFAB_PATH = "Assets/_BundleResources/UI/Shop/UISkinPicItem.prefab";


function UISkinPicItem.New(parent,scale)
    local self = {}
    setmetatable(self, UISkinPicItem)
    self.gameObject= LuaMgr.GetPrefab(PREFAB_PATH)
    LuaMgr.AddPrefabRefCount(PREFAB_PATH);
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent);
    self.transform.localScale =scale
    self.transform.localPosition=Vector3.zero;
    self.transform.anchoredPosition=Vector2.zero;
    self.transform.localRotation=Quaternion.Euler(0, 0, 0);
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.root = uiLink:Get("root");
    self.goNotHave = uiLink:Get("goNotHave");
    self.picSkin = uiLink:Get("picSkin"):GetComponent("RawImage");
    self.imgType = uiLink:Get("imgType"):GetComponent("Image");
    self.btnEffectIcon = uiLink:Get("btnEffectIcon");
    self.btnVoiceIcon = uiLink:Get("btnVoiceIcon");
    self.btnQIcon = uiLink:Get("btnQIcon");
    self.goHighVoiceIcon = uiLink:Get("goHighVoiceIcon");
    self.goHighAnimIcon = uiLink:Get("goHighAnimIcon");
    self.goHighBgIcon = uiLink:Get("goHighBgIcon");
    self.textSkinName = uiLink:Get("textSkinName"):GetComponent("Text");
    self.textName = uiLink:Get("textName"):GetComponent("Text");
    self.goCanBuy = uiLink:Get("goCanBuy");
    
    uiLink:SetClickEvent(function()
        if  self.fun~=nil then
            self.fun(self)
        end
    end)
    
    return self
end

function UISkinPicItem:Destroy()
    if self.gameObject~=nil then
        LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil
        self.transform = nil
        self.root = nil;
        self.goNotHave = nil;
        self.picSkin = nil;
        self.imgType = nil;
        self.btnEffectIcon = nil;
        self.btnVoiceIcon = nil;
        self.btnQIcon = nil;
        self.goHighVoiceIcon = nil;
        self.goHighAnimIcon = nil;
        self.goHighBgIcon = nil;
        self.textSkinName = nil;
        self.textName = nil;
        self.goCanBuy = nil;
    end
end

function UISkinPicItem:SetData(data,fun)
    self.fun=fun;
    self.character=data.character;
    self.data=data;
    self.characterId=data.characterId;
    self.skinID=data.skinData.skinID
    
    self.picSkin.texture = LuaMgr.GetTexture(HeroManager.GetCharacterCard(data.characterId, data.skinData.skinID))
    self.textSkinName.text = LuaMgr.GetLangText(data.skinData.skinNamelan)
    self.textName.text = LuaMgr.GetLangText(data.character.namelan)
    

    if data.skinData.skinLOGO == nil or data.skinData.skinLOGO == 0 then
        SetActive( self.imgType.gameObject,false)
    else
        SetActive( self.imgType.gameObject,true)
        self.imgType.sprite = LuaMgr.GetSprite("SkinLogo","SkinLogo_"..data.skinData.skinLOGO)
    end
    
    local charge=HeroRedDataHelper.GetChargeById(data.skinData.goodsID)
    local timeBool = false
    if charge ~= nil then
        timeBool = (charge.StartTime == 0 or charge.EndTime == 0) or (LuaMgr.Timestamp() > charge.StartTime and LuaMgr.Timestamp() < charge.EndTime)
    end
    SetActive(self.goCanBuy,charge ~= nil and timeBool)
    SetActive(self.goNotHave, (data.skinData.skinLOGO ~= 102 and not data.isGetHave) or (data.skinData.skinLOGO == 102 and not data.isGetHave));
    

    local showEffect=DataHelper.SettingSkinLogo(data.skinData.resLOGO,"effects")
    SetActive(self.btnEffectIcon,showEffect)
    local showQspine=DataHelper.SettingSkinLogo(data.skinData.resLOGO,"Qspine")
    SetActive(self.btnQIcon,showQspine)
    local showLines=DataHelper.SettingSkinLogo(data.skinData.resLOGO,"lines");
    SetActive(self.btnVoiceIcon,showLines)

    local isHighSkin = not IsNull(data.skinData.highskin) and data.skinData.highskin > 0
    SetActive(self.goHighVoiceIcon,isHighSkin)
    SetActive(self.goHighAnimIcon,isHighSkin)
    SetActive(self.goHighBgIcon,isHighSkin)
end

function UISkinPicItem:Clear()
    self.fun=nil;
    self.data=nil;
    SetActive(self.gameObject,false)
end

