
UIPracticeShopItem = {}
UIPracticeShopItem.__index = UIPracticeShopItem
local ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_"
function UIPracticeShopItem.New(prefab, parent)
    local self = {};
    setmetatable(self, UIPracticeShopItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.animator = self.gameObject:GetComponent("Animator")
    self.goCommonItem = uiLink:Get("goCommonItem");
    self.goChipItem = uiLink:Get("goChipItem");
    self.goTips1 = uiLink:Get("goTips1");
    self.goTips2 = uiLink:Get("goTips2");
    self.goTips3 = uiLink:Get("goTips3");
    self.goDiscount = uiLink:Get("goDiscount");
    self.goAllBuyed = uiLink:Get("goAllBuyed");
    self.goCommonBuyMask = uiLink:Get("goCommonBuyMask");
    self.goChipBuyMask = uiLink:Get("goChipBuyMask");
    self.textCanBuyNum = uiLink:Get("textCanBuyNum"):GetComponent("Text");
    self.textCount = uiLink:Get("textCount"):GetComponent("Text");
    self.textName = uiLink:Get("textName"):GetComponent("Text");
    self.textCommonPrice = uiLink:Get("textCommonPrice"):GetComponent("Text");
    self.textChipName = uiLink:Get("textChipName"):GetComponent("Text");
    self.textIsOnTitle = uiLink:Get("textIsOnTitle"):GetComponent("Text");
    self.textChipPrice = uiLink:Get("textChipPrice"):GetComponent("Text");
    self.textDiscount = uiLink:Get("textDiscount"):GetComponent("Text");
    self.imgRare = uiLink:Get("imgRare"):GetComponent("Image");
    self.rawImageIcon = uiLink:Get("rawImageIcon"):GetComponent("RawImage");
    self.rawImageCommonIcon = uiLink:Get("rawImageCommonIcon"):GetComponent("RawImage");
    self.rawImageChipIcon = uiLink:Get("rawImageChipIcon"):GetComponent("RawImage");
    self.btnClick = uiLink:Get("btnClick"):GetComponent("Button");
    self.rectButtonBlock = uiLink:Get("rectButtonBlock"):GetComponent("RectTransform");
    self.data = nil;
    uiLink:AddClickEvent("btnClick", function()
        if self.data.fun ~= nil then
            local goods = {
                RefreshCount = self.data.limitCount,
                Id =  tostring(self.data.group).."001",
                Hot = false,
                Item = self.data.item[1].id,
                Stack = self.data.item[1].count,
                Price = self.data.price,
                Currency = self.data.currency,
                NameLan = "shoplan_goods_namedlan_100100802"
            }
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeShopBuyTipViewModel, goods,
                ConfigMgr.Config.RandShopMap[self.data.tabId].Kind, function()
                self.data.fun(self.data.tabId,self.data.smallTabId);
            end, self.data.tabId)
        end
    end)
    return self
end




















function UIPracticeShopItem:SetData(data)
    SetActive(self.gameObject,true);
    self.animator:Play("UI_CollectorPracticeShop_PracticeShopItem", 0, 1);
    self.data = data;
    local item = ConfigHelper.GetItemById(self.data.item[1].id);
if item.type == 20 or item.type == 25 or item.type == 26 then
        SetActive(self.goCommonItem, false);
        SetActive(self.goChipItem, true);
        SetActive(self.goCommonBuyMask, false);
if self.data.allBuyed then
            SetActive(self.goAllBuyed, true);
            SetActive(self.goChipBuyMask, true);
            SetActive(self.rectButtonBlock.gameObject, true);
        else
            SetActive(self.goAllBuyed, false);
            SetActive(self.goChipBuyMask, false);
            SetActive(self.rectButtonBlock.gameObject, false);
        end

if CollectorPracticeMgr.ItemIdToCard[self.data.item[1].id] == nil then
            CollectorPracticeMgr.InitItemIdToCard();
        end
        self.textIsOnTitle.text = LuaMgr.GetLangText(CollectorPracticeMgr.ItemIdToCard[self.data.item[1].id].NameLan)
        self.textChipName.text = LuaMgr.GetLangText(ConfigHelper.GetItemById(self.data.item[1].id).nameLan)
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


        self.rawImageChipIcon.texture = LuaMgr.GetTexture(ITEM_ICON_PATH .. self.data.currency .. ".png");
        self.textChipPrice.text = tostring(self.data.price);

else
        SetActive(self.goCommonItem, true);
        SetActive(self.goChipItem, false);
        SetActive(self.goChipBuyMask, false);
        local allBuyed = false
if self.data.allBuyed then
            SetActive(self.goAllBuyed, true);
            SetActive(self.goCommonBuyMask, true);
            SetActive(self.rectButtonBlock, true);
        else
            SetActive(self.goAllBuyed, false);
            SetActive(self.goCommonBuyMask, false);
            SetActive(self.rectButtonBlock, false);
        end

        self.textName.text = LuaMgr.GetLangText(item.nameLan);
        self.imgRare.sprite = LuaMgr.GetSprite("ItemRare", "itemRare" .. item.rare);
        self.rawImageCommonIcon.texture = LuaMgr.GetTexture(ITEM_ICON_PATH .. item.id .. ".png");
        self.textCount.text = "X" .. self.data.item[1].count;
self.textCanBuyNum.text = "";


        self.rawImageCommonIcon.texture = LuaMgr.GetTexture(ITEM_ICON_PATH .. self.data.currency .. ".png");
        self.textCommonPrice.text = tostring(self.data.price);

    end
end

function UIPracticeShopItem:ShowAnimation()
    self.animator:Play("UI_CollectorPracticeShop_PracticeShopItem", 0, 0);
end

function UIPracticeShopItem:Clear()
    SetActive(self.gameObject, false);
end

function UIPracticeShopItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.transform = nil
    self.goCommonItem = nil;
    self.goChipItem = nil;
    self.goTips1 = nil;
    self.goTips2 = nil;
    self.goTips3 = nil;
    self.goDiscount = nil;
    self.goAllBuyed = nil;
    self.goCommonBuyMask = nil;
    self.goChipBuyMask = nil;
    self.textCanBuyNum = nil;
    self.textCount = nil;
    self.textName = nil;
    self.textCommonPrice = nil;
    self.textChipName = nil;
    self.textIsOnTitle = nil;
    self.textChipPrice = nil;
    self.textDiscount = nil;
    self.imgRare = nil;
    self.rawImageIcon = nil;
    self.rawImageCommonIcon = nil;
    self.rawImageChipIcon = nil;
    self.btnClick = nil;
    self.rectButtonBlock = nil;
end