




UICollectorCardItem = {}
UICollectorCardItem.__index = UICollectorCardItem
local PREFAB_PATH = "Assets/_BundleResources/UI/CollectorPractice/UICollectorCardItem.prefab";

function UICollectorCardItem.New(parent, scale)
    local self = {}
    setmetatable(self, UICollectorCardItem)
    self.gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
    LuaMgr.AddPrefabRefCount(PREFAB_PATH);
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent);
    self.transform.localScale = scale
    self.transform.localPosition = Vector3.zero;
    self.transform.anchoredPosition = Vector2.zero;
    self.transform.localRotation = Quaternion.Euler(0, 0, 0);
    local uiLink = self.gameObject:GetComponent("UILink");
    self.aniRoot = uiLink:Get("root"):GetComponent("Animator");
    self.rectRoot = uiLink:Get("root"):GetComponent("RectTransform");
    self.aniRoot.enabled = false;
    self.goLock = uiLink:Get("goLock");
    self.rawImageCard = uiLink:Get("rawImageCard"):GetComponent("RawImage");
    self.textName = uiLink:Get("textName"):GetComponent("Text");
    self.imgJb = uiLink:Get("imgJb"):GetComponent("Image");

    self.goItem = uiLink:Get("goItem");
    self.rectLayout = uiLink:Get("rectLayout"):GetComponent("RectTransform");
    self.cardList = {}

    table.insert(self.cardList, self.goItem);

    uiLink:AddClickEvent("btnClick", function()
        if self.fun ~= nil then
            self.fun(self.data);
        end
    end)

    return self
end

function UICollectorCardItem:Destroy()
    if self.gameObject ~= nil then
        LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil
        self.transform = nil
        self.aniRoot = nil;
        self.goLock = nil;
        self.rawImageCard = nil;
        self.textName = nil;

        self.goItem = nil;
        self.rectLayout = nil;
        self.cardList = nil;
    end
end

function UICollectorCardItem:ShowAim(groupIndex)
    if not self.gameObject.activeSelf then
        return;
    end

    self.coroutine = coroutine_runner.start(
        function()
            SetActive(self.aniRoot.gameObject, false)
            coroutine_runner.wait(0.1 * (groupIndex - 1))
            SetActive(self.aniRoot.gameObject, true)
            self.aniRoot.enabled = false;
            self.aniRoot.enabled = true;
            self.aniRoot:Rebind();
            self.aniRoot:Play("ani_TrammelChildItem");
            coroutine_runner.wait(3)
            self.aniRoot.enabled = false;
            self.coroutine = nil
        end)
end

function UICollectorCardItem:ShowGetCardItemAnim()
    if not self.gameObject.activeSelf then
        return;
    end
    self.aniRoot.enabled = true;
    self.aniRoot:Play("ani_UICollectorCardItem_root",0,0);

end

function UICollectorCardItem:SetData(data, fun,isGallery)
    self.fun = fun;
    self.data = data;
    self.rawImageCard.texture = LuaMgr.GetTexture("Assets/_BundleResources/Images/CollectorGallery/" ..
    data.RelicsId .. ".png");
    SetActive(self.goLock, not data.Achieve);

    if not data.Achieve then
local len = data.ActivateType == 1 and #data.ActivateParam1 or 0;
        for i = 1, len do
            if i > #self.cardList then
                table.insert(self.cardList, LuaMgr.InstantiateGO(self.goItem, self.rectLayout, false))
            end

            SetActive(self.cardList[i], true);
            local count = PlayerItemMgr.GetItemCountById(data.ActivateParam1[i][1])
            local isOne = false;
            if #data.ActivateParam1[i] >= 2 then
                local strNum = data.ActivateParam1[i][2];
                isOne = count >= (tonumber(strNum))
            else
                print("is nil " .. data.ActivateParam1[i][1])
            end

            SetActive(self.cardList[i].transform:Find("goIsOn").gameObject, isOne);
        end

        for i = len + 1, #self.cardList do
            SetActive(self.cardList[i], false);
        end
    end

    SetActive(self.rawImageCard.gameObject, data.Achieve);
    self.textName.text = LuaMgr.GetLangText(data.NameLan)

    self.imgJb.sprite = LuaMgr.GetSprite("CollectorMainScene", "ui_sx_dt_bg_ka_" .. data.OriginsID);
end

function UICollectorCardItem:InitUI(data)
    for i = 1, #self.cardList do
        SetActive(self.cardList[i], false);
    end

    self.data = data;
    self.rawImageCard.texture = LuaMgr.GetTexture("Assets/_BundleResources/Images/CollectorGallery/" ..
    data.RelicsId .. ".png");
    SetActive(self.goLock, false);
    SetActive(self.rawImageCard.gameObject, true);
    self.textName.text = LuaMgr.GetLangText(data.NameLan)
    self.textTitle.text = LuaMgr.GetLangText(ConfigMgr.Config.OriginsTalentMap[data.OriginsID].OtNameLan)
end

function UICollectorCardItem:Clear()
    self.data = nil
    self.aniRoot.enabled = false;

    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine);
        self.coroutine = nil;
        SetActive(self.aniRoot.gameObject, true)
        self.rectRoot.localPosition = Vector3.zero;
    end

    SetActive(self.gameObject, false)
end