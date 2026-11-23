




UICollectorBuildingTipsItem = {}
UICollectorBuildingTipsItem.__index = UICollectorBuildingTipsItem

function UICollectorBuildingTipsItem.New(parent,prefab)
    local self = {}
    setmetatable(self, UICollectorBuildingTipsItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent);
    self.transform.localRotation = Quaternion.Euler(0, 0, 0);
    local uiLink = self.gameObject:GetComponent("UILink");
    self.goIsOn = uiLink:Get("goIsOn")
    self.uiGoodsItem = uiLink:Get("uiGoodsItem"):GetComponent("GoodsViewModel");
    self.textName = uiLink:Get("textName"):GetComponent("Text");
    self.goBuildTipsType = uiLink:Get("goBuildTipsType")
    self.goBuildIconType = uiLink:Get("goBuildIconType")
    self.goBuildRewardType = uiLink:Get("goBuildRewardType")
    self.imgBuildTipsType = uiLink:Get("goBuildTipsType"):GetComponent("Image")
    self.imgBuildIconType = uiLink:Get("goBuildIconType"):GetComponent("Image")
    self.imgBuildRewardType = uiLink:Get("goBuildRewardType"):GetComponent("Image")
    return self
end

function UICollectorBuildingTipsItem:Destroy()
    if self.gameObject ~= nil then
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil
        self.transform = nil
        self.rawImage = nil;
        self.btnClick = nil;
        self.goIsOn = nil;
        self.uiGoodsItem = nil;
        self.textName = nil;
        self.goBuildTipsType = nil;
        self.goBuildIconType = nil;
        self.goBuildRewardType = nil;
        self.imgBuildTipsType = nil;
        self.imgBuildIconType = nil;
        self.imgBuildRewardType = nil;
    end
end

function UICollectorBuildingTipsItem:SetData(index, cIndex, show, tabId, pos)
    self.allIndex = index;
    self.columnIndex = cIndex;
    self.pos = pos;
    self.internEventKV = ConfigMgr.Config.InternEventKV[tabId];

    self:SetTips(show)
    self.transform.localPosition = Vector3.zero;
self.transform.anchoredPosition = Vector2(pos[1]+14, pos[2]+85.4);
    self.transform.localScale = Vector3(0.8, 0.8, 0.8);


    self.textName.text = LuaMgr.GetLangText(self.internEventKV.EventNameLan);

    local tagIcon = self.internEventKV.TagIcon
SetActive(self.goBuildIconType, true);
SetActive(self.goBuildRewardType, true);
if tagIcon == 1 then
        self.imgBuildTipsType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gq_2");
        self.imgBuildIconType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gqtb_1");
        self.imgBuildRewardType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gq_5");
    elseif tagIcon == 2 then
        self.imgBuildTipsType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gq_1");
        self.imgBuildIconType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gqtb_3");
        self.imgBuildRewardType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gq_4");
    elseif tagIcon == 3 then
        self.imgBuildTipsType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gq_1");
        self.imgBuildIconType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gqtb_2");
        self.imgBuildRewardType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gq_4");
    elseif tagIcon == 4 then
        self.imgBuildTipsType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gq_1");
        self.imgBuildIconType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gqtb_4");
        self.imgBuildRewardType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gq_4");
    elseif tagIcon == 5 then
        self.imgBuildTipsType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gq_3");
        SetActive(self.goBuildIconType, false);
        self.imgBuildRewardType.sprite = LuaMgr.GetSprite("CollectorBuildingTips", "ui_sx_dt_gq_4");
    end

    if type(self.internEventKV.ItemIcon) == "table" and #self.internEventKV.ItemIcon > 0 then
        self.uiGoodsItem:SetData(self.internEventKV.ItemIcon[1].id, self.internEventKV.ItemIcon[1].count, 1, 0.35, true)
        SetActive(self.uiGoodsItem.gameObject, true);
    else
        SetActive(self.uiGoodsItem.gameObject, false);
        SetActive(self.goBuildRewardType, false);
    end

end

function UICollectorBuildingTipsItem:SetTips(show)

    if type(self.internEventKV.ItemIcon) == "table" and #self.internEventKV.ItemIcon > 0 then
        self.uiGoodsItem:SetData(self.internEventKV.ItemIcon[1].id, self.internEventKV.ItemIcon[1].count, 1, 0.35, true)
        SetActive(self.uiGoodsItem.gameObject, true);
    else
        SetActive(self.uiGoodsItem.gameObject, false);
        SetActive(self.goBuildRewardType, false);
    end

    SetActive(self.gameObject, show)

end

function UICollectorBuildingTipsItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

function UICollectorBuildingTipsItem:Hide()
    SetActive(self.gameObject, false)
end