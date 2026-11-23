VoyageMailItem = {};

VoyageMailItem.__index = VoyageMailItem;

local color = UnityEngine.Color(1,1,1,1);
local maskColor = UnityEngine.Color(136/255,136/255,136/255,1);

local objs = {
    lockGO = { path = "Lock", type = "GameObject" },
    lockBtn = { path = "Lock", type = "Button" },
    lockMsg = { path = "Lock/Msg", type = "Text" },
    lockItems = { path = "Lock/Items/Viewport/Content", type = "RectTransform" },
    redDot = { path = "Lock/RedDot", type = "GameObject" },
    normalGO = { path = "Normal", type = "GameObject" },
    normalBtn = { path = "Normal", type = "Button" },
    normalImg = { path = "Normal", type = "RawImage" },
    selectGO = { path = "Select", type = "GameObject" },
    selectImg = { path = "Select", type = "RawImage" },
}

function VoyageMailItem.New(gameObject, parent, config)
    local self = {};
    setmetatable(self, VoyageMailItem);
    self.gameObject = LuaMgr.InstantiateGO(gameObject, parent, false);
    self.transform = self.gameObject:GetComponent("RectTransform");
    UITool.Parse(self.gameObject, self, objs);
    self.config = config;
    self.itemList = nil;
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageMailSelect, self);
    end
    LuaMgr.AddClick(self.lockBtn, self.OnClickItem);
    LuaMgr.AddClick(self.normalBtn, self.OnClickItem);
    return self;
end

function VoyageMailItem:SetPosition(index)
    index = index - 1;
    local row = math.floor(index / 2);
    local col = index % 2;
    self.transform.localPosition = Vector3(col * (382 - 43), row * (-232 + 27), 0);
end

function VoyageMailItem:SetData()
    SetActive(self.lockGO, false);
    SetActive(self.normalGO, false);
    SetActive(self.selectGO, false);
    self.normalImg.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/Voyage/%s.png", self.config.CardNormal));
    self.selectImg.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/Voyage/%s.png", self.config.CardPick));
    local mailData = DataMgr.Player.SailingMails[self.config.MailID];
    if (mailData.Status == 0 or mailData.Status == 1) then
        self.lockMsg.text = LuaMgr.GetLangText(self.config.MailLockLan);
        self:SetItems();
        SetActive(self.lockGO, true);
        SetActive(self.redDot, mailData.Status == 1);
    else
        SetActive(self.normalGO, true);
    end
end

function VoyageMailItem:SetItems()
    local item;
    local itemData;
    local rewardItem;
    local rewardItems = self.config.RewardItems;
    local len = #rewardItems;
    self.itemList = {};
    self.lockItems.sizeDelta = Vector2(70 * len, 70);
    self.lockItems.anchoredPosition = Vector2.zero;
    local startX = -70 * len * 0.5 - 35;
    for i = 1, len do
        item = self.itemList[i];
        if (item == nil) then
            item = GoodsDataItem.New(self.lockItems);
            startX = startX + 70;
            item.transform.anchoredPosition = Vector2(startX, 0);
            self.itemList[i] = item;
        end
        rewardItem = rewardItems[i];
        itemData = table.Copy(ConfigMgr.Config.itemMap[rewardItem.id]);
        itemData.count0 = rewardItem.count;
        item:SetData(1, itemData, 1, false, Vector3(0.56, 0.56, 1));
        item:SetIconBg(false);
    end
    local rlen = #self.itemList;
    for i = len + 1, rlen do
        self.itemList[i]:Hide();
    end
end

function VoyageMailItem:SetMask(status)
    self.normalImg.color = status and maskColor or color;
end

function VoyageMailItem:Select(status)
    local mailData = DataMgr.Player.SailingMails[self.config.MailID];
    if (mailData.Status == 0 or mailData.Status == 1) then 
        return false; 
    end
    SetActive(self.lockGO, false);
    if (status) then
        SetActive(self.normalGO, false);
        SetActive(self.selectGO, true);
        self.transform:SetAsLastSibling();
    else
        SetActive(self.normalGO, true);
        SetActive(self.selectGO, false);
    end
    return true;
end

function VoyageMailItem:Clear()
    self.normalImg.texture = nil;
    self.selectImg.texture = nil;
end

function VoyageMailItem:Destroy()
    self.config = nil;
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.lockBtn, self.OnClickItem);
        LuaMgr.RemoveClick(self.normalBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    if (self.itemList ~= nil) then
        local len = #self.itemList;
        for i = 1, len do
            self.itemList[i]:Clear();
        end
        self.itemList = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end