
UICollectorEventOptionItem = {};
UICollectorEventOptionItem.__index = UICollectorEventOptionItem
UICollectorEventOptionItem.normalColor=UnityEngine.Color(237/255.0,230/255.0,218/255.0,1);
UICollectorEventOptionItem.grayColor=UnityEngine.Color(238/255.0,236/255.0,233/255.0,1);
function UICollectorEventOptionItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UICollectorEventOptionItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.goGrayBGImage = uiLink:Get("goGrayBGImage");
    self.goNormalBGImage = uiLink:Get("goNormalBGImage");
    self.goDiceImage = uiLink:Get("goDiceImage");
    self.btnClick=uiLink:Get("btnClick"):GetComponent("Button");
    self.textSecondText = uiLink:Get("textSecondText"):GetComponent("Text");
    self.textNoDiceText = uiLink:Get("textNoDiceText"):GetComponent("Text");
    self.textDiceText = uiLink:Get("textDiceText"):GetComponent("Text");
    self.fun=nil;
    self.id=0;
    uiLink:AddClickEvent("btnClick",function()
        if  self.fun~=nil then
            self.fun(self);
        end
    end)
    return self
end

function UICollectorEventOptionItem:SetData(index,isGray,isDice,firstText,secondText,fun)
    self.id=index;
    SetActive(self.gameObject,true);
if isGray then
SetActive(self.goDiceImage,false);
SetActive(self.textDiceText.gameObject,false);
SetActive(self.textNoDiceText.gameObject,true);
SetActive(self.goNormalBGImage,false);
SetActive(self.goGrayBGImage,true);
        self.textNoDiceText.text=firstText;
        self.textNoDiceText.color=UICollectorEventOptionItem.grayColor;
        self.textSecondText.text=secondText;
elseif isDice then
SetActive(self.goDiceImage,true);
SetActive(self.textDiceText.gameObject,true);
SetActive(self.textNoDiceText.gameObject,false);
SetActive(self.goGrayBGImage,false);
SetActive(self.goNormalBGImage,true);
        self.textNoDiceText.text=firstText;
        self.textDiceText.text = firstText;
        self.textNoDiceText.color=UICollectorEventOptionItem.normalColor;
        self.textSecondText.text=secondText;
else
SetActive(self.goDiceImage,false);
SetActive(self.textNoDiceText.gameObject,true);
SetActive(self.goGrayBGImage,false);
SetActive(self.goNormalBGImage,true);
SetActive(self.textDiceText.gameObject,false);
        self.textNoDiceText.text=firstText;
        self.textNoDiceText.color=UICollectorEventOptionItem.normalColor;
        self.textSecondText.text=secondText;
    end
    self.fun=fun;
end

function UICollectorEventOptionItem:Hide()
    SetActive(self.gameObject,false);
end

function UICollectorEventOptionItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil
    self.transform = nil
    self.goGrayBGImage = nil;
    self.goNormalBGImage = nil;
    self.goDiceImage = nil;
    self.textSecondText = nil;
    self.textNoDiceText = nil;
    self.textDiceText = nil;
end