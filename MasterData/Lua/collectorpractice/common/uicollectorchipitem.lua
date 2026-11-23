




UICollectorChipItem = {}
UICollectorChipItem.__index = UICollectorChipItem
local PREFAB_PATH = "Assets/_BundleResources/UI/CollectorPractice/UICollectorChipItem.prefab";

function UICollectorChipItem.New(parent)
    local self = {}
    setmetatable(self, UICollectorChipItem)
    self.gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
    LuaMgr.AddPrefabRefCount(PREFAB_PATH);
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent);
    self.transform.localScale = Vector3.one;
    self.transform.localPosition = Vector3.zero;
    self.transform.anchoredPosition = Vector2.zero;
    self.transform.localRotation = Quaternion.Euler(0, 0, 0);
    local uiLink = self.gameObject:GetComponent("UILink");
    self.goIsOn = uiLink:Get("goIsOn");
    self.goLock = uiLink:Get("goLock");
    self.goIsOnTitle = uiLink:Get("goIsOnTitle");
    self.textIsOnTitle = uiLink:Get("textIsOnTitle"):GetComponent("Text");
    self.textName = uiLink:Get("textName"):GetComponent("Text");
    self.textDes = uiLink:Get("textDes"):GetComponent("Text");
    self.goTips1 = uiLink:Get("goTips1")
    self.goTips2 = uiLink:Get("goTips2")
    self.goTips3 = uiLink:Get("goTips3")
    self.goTipsEffect1=uiLink:Get("goTipsEffect1")
    self.goTipsEffect2=uiLink:Get("goTipsEffect2")
    self.goTipsEffect3=uiLink:Get("goTipsEffect3")
    self.btnClick = uiLink:Get("btnClick")
    self.goUIEffect = uiLink:Get("goUIEffect")
    self.imgIsOn=uiLink:Get("goIsOn"):GetComponent("Image");
    self.imgIsOnTitle=uiLink:Get("goIsOnTitle"):GetComponent("Image");
    self.clickParm = nil;
    self.animator=self.gameObject:GetComponent("Animator")
    self.rawImageEffect=uiLink:Get("rawImageEffect"):GetComponent(typeof(CS.Laigu.Tools.UITools.UIRangeEffect));
    self.root=uiLink:Get("root")
    self.UIgoUIEffectdiss=uiLink:Get("UIgoUIEffectdiss")
    uiLink:AddClickEvent("btnClick", function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.NeedCloseEffect);
LuaMgr.ShowLuaPanel(UIName.CollectorPracticeGalleryTipViewModel, self.clickParm, 1,self.item.id)
    end)

    return self
end

function UICollectorChipItem:Destroy()
    if self.gameObject ~= nil then
        LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil
        self.transform = nil
        self.goIsOn = nil;
        self.goLock = nil;
        self.textName = nil;
        self.textDes = nil;
        self.goIsOnTitle = nil;
        self.textIsOnTitle = nil;
        self.goTips1 = nil;
        self.goTips2 = nil;
        self.goTips3 = nil;
        self.btnClick = nil;
        self.rawImageEffect=nil;
        self.root=nil;
        self.UIgoUIEffectdiss=nil;
    end
end

function UICollectorChipItem:SetData(data, achieve,isGallery)
    SetActive(self.gameObject,true);
    self.data = data;

    local item = ConfigMgr.Config.itemMap[data[1]];
    self.item=item;
    SetActive(self.goTipsEffect1, false);
    SetActive(self.goTipsEffect2, false);
    SetActive(self.goTipsEffect3, false);
    SetActive(self.UIgoUIEffectdiss, false)
    self.rawImageEffect.rawImage.color=UnityEngine.Color(255/255.0,255/255.0,255/255.0,0);
    SetActive(self.root,true);
    if item.type == 20 then
        SetActive(self.goTips1, true);
        SetActive(self.goTips2, false);
        SetActive(self.goTips3, false);
        if isGallery then
local co = coroutine_runner.start(function()
                coroutine_runner.wait(0.9)
                SetActive(self.goTipsEffect1, true);
            end)
        end
    elseif item.type == 25 then
        SetActive(self.goTips1, false);
        SetActive(self.goTips2, true);
        SetActive(self.goTips3, false);
        if isGallery then
local co = coroutine_runner.start(function()
                coroutine_runner.wait(0.9)
                SetActive(self.goTipsEffect2, true);
            end)
        end
    elseif item.type == 26 then
        SetActive(self.goTips1, false);
        SetActive(self.goTips2, false);
        SetActive(self.goTips3, true);
        if isGallery then
local co = coroutine_runner.start(function()
                coroutine_runner.wait(0.9)
                SetActive(self.goTipsEffect3, true);
            end)
        end
    end

    local count = PlayerItemMgr.GetItemCountById(data[1])
    local isOne = count >= (tonumber(data[2])) or achieve;
    SetActive(self.goIsOn, isOne)
    SetActive(self.goLock, not isOne)
    SetActive(self.goIsOnTitle,not isGallery)

    

    if item == nil then
        self.textName.text = data[1]
        self.textDes.text  = data[1];
        return
    end

    self.textName.text = LuaMgr.GetLangText(item.nameLan);
    self.textDes.text  = LuaMgr.GetLangText(item.nameLan);
if CollectorPracticeMgr.ItemIdToCard[item.id]==nil then
        CollectorPracticeMgr.InitItemIdToCard();
    end
    self.textIsOnTitle.text = LuaMgr.GetLangText(CollectorPracticeMgr.ItemIdToCard[item.id].NameLan)
SetActive(self.btnClick.gameObject, false);
end

function UICollectorChipItem:SetEffect(effectState)
    SetActive(self.goUIEffect, effectState)
end

function UICollectorChipItem:SetData2(data,openEffect)
    self.data = data;
    SetActive(self.goIsOn, true)
    SetActive(self.goLock, false)
    SetActive(self.goIsOnTitle, false)
    SetActive(self.goUIEffect, openEffect)
    SetActive(self.root,true);
    local item = ConfigMgr.Config.itemMap[data.id];
    self.item=item;
    if item == nil then
        self.textName.text = data[1]
        self.textDes.text  = data[1];
        return
    end

    if item.type == 20 then
        SetActive(self.goTips1, true);
        SetActive(self.goTips2, false);
        SetActive(self.goTips3, false);
    elseif item.type == 25 then
        SetActive(self.goTips1, false);
        SetActive(self.goTips2, true);
        SetActive(self.goTips3, false);
    elseif item.type == 26 then
        SetActive(self.goTips1, false);
        SetActive(self.goTips2, false);
        SetActive(self.goTips3, true);
    end

    self.textName.text         = LuaMgr.GetLangText(item.nameLan);
    self.textDes.text          = LuaMgr.GetLangText(item.nameLan);

if CollectorPracticeMgr.ItemIdToCard[data.id]==nil then
        CollectorPracticeMgr.InitItemIdToCard();
    end
    self.clickParm=CollectorPracticeMgr.ItemIdToCard[data.id];
    SetActive(self.goIsOnTitle, true)
    self.textIsOnTitle.text = LuaMgr.GetLangText(CollectorPracticeMgr.ItemIdToCard[data.id].NameLan)
    















end



function UICollectorChipItem:ResetAnimation()
    SetActive(self.root,true);
    SetActive(self.UIgoUIEffectdiss,false);
    self.rawImageEffect.rawImage.color=UnityEngine.Color(255/255.0,255/255.0,255/255.0,0);
end


function UICollectorChipItem:ShowDissolveAnimation()
    SetActive(self.UIgoUIEffectdiss,true);
    self.rawImageEffect:RunRangeEffect(function ()
        SetActive(self.root,false);
        self.rawImageEffect.rawImage.color=UnityEngine.Color(255/255.0,255/255.0,255/255.0,1);
    end,0.7,nil,nil);
    
end

function UICollectorChipItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end