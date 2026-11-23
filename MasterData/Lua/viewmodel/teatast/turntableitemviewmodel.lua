
TurnTableItem = {};
TurnTableItem.__index = TurnTableItem
function TurnTableItem.New(parent)
    local self = {}
    setmetatable(self, TurnTableItem)
    self.gameObject = LuaMgr.GetPrefab(
    "Assets/_BundleResources/UI/Home/TeaRoomNewTurnTableGame/TurnTableItem.prefab");
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent, false);
    local uiLink = self.gameObject:GetComponent("UILink");
    self.goBGSelect = uiLink:Get("goBGSelect");
    self.goIcon = uiLink:Get("goIcon");
    self.goSpecialImgIcon = uiLink:Get("goSpecialImgIcon");
    self.goIconSelect = uiLink:Get("goIconSelect");
    self.goSpecialIconSelect = uiLink:Get("goSpecialIconSelect");
    self.goFinish = uiLink:Get("goFinish");
    self.goSpecialGoods = uiLink:Get("goIconBg");
    self.textLevelName = uiLink:Get("textLevelName"):GetComponent("Text");
    self.btnClick = uiLink:Get("btnClick"):GetComponent("Button");
    self.rawImageicon= uiLink:Get("rawImageicon"):GetComponent("RawImage");
    self.isSpecial = false;
    self.select = false;
    self.ClickLevelFun = nil;
    self.levelId = "";
    self.specialGood=false;
    uiLink:AddClickEvent("btnClick", function()
        self.ClickLevelFun(self);
    end)
    return self
end

function TurnTableItem:SetSelectThis(select)
    if self.isSpecial then
        SetActive(self.goBGSelect, select);
        SetActive(self.goSpecialIconSelect, select);
        if select then
            self.textLevelName.color = UnityEngine.Color(255 / 255, 253 / 255, 221 / 255, 255 / 255);
        else
            self.textLevelName.color = UnityEngine.Color(27 / 255, 36 / 255, 27 / 255, 255 / 255);
        end
    else
        SetActive(self.goBGSelect, select);
        SetActive(self.goIconSelect, select);
        if select then
            self.textLevelName.color = UnityEngine.Color(255 / 255, 253 / 255, 221 / 255, 255 / 255);

        else
            self.textLevelName.color = UnityEngine.Color(27 / 255, 36 / 255, 27 / 255, 255 / 255);
        end
    end
end

function TurnTableItem:SetSpecial(special)
    SetActive(self.goIcon, not special);
    SetActive(self.goSpecialImgIcon,special);
    SetActive(self.goSpecialIconSelect,false);
    SetActive(self.goIconSelect,false);
end

function TurnTableItem:SetData(levelName, clickLevel, special, levelIdString, isFinish,isSpecialGood,specialGoodID)
    self:SetSelectThis(false);
    self.textLevelName.text = levelName;
    self.ClickLevelFun = clickLevel;
    self.isSpecial = special;
    self.levelId = levelIdString;
    self.specialGood=isSpecialGood;
    if isSpecialGood then
        self.goSpecialGoods:GetComponent("Image").sprite = LuaMgr.GetSprite("Backpack", "ui_ty_daoju_yuan" .. ConfigHelper.GetItemById(specialGoodID).rare)
        self.rawImageicon.texture=LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/ItemIcons/itemicon_home_%s.png", specialGoodID))
    end

    self:SetSpecial(special)
    self:SetFinish(isFinish);
end

function TurnTableItem:SetFinish(finish)
    self:SetSelectThis(false);
    SetActive(self.goFinish, finish);
    if (not finish)and self.specialGood then
        SetActive(self.goSpecialGoods,true)
    else
        SetActive(self.goSpecialGoods,false)
    end
end

function TurnTableItem:Clear()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil
    self.transform = nil
    self.goBGSelect = nil;
    self.goIcon = nil;
    self.goSpecialImgIcon = nil;
    self.goIconSelect = nil;
    self.goSpecialIconSelect = nil;
    self.goFinish = nil;
    self.imgGoodsItem = nil;
    self.textLevelName = nil;
    self.btnClick = nil;
    self.goSpecialGoods = nil;
    self.rawImageicon=nil;
end