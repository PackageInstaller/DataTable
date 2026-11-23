require("ViewModel/Activity/NewPlayerLimitEquipItem")
NewPlayerLimitEquipGoodsItem = {}
NewPlayerLimitEquipGoodsItem.__index = NewPlayerLimitEquipGoodsItem

local objs = {
    bgBtn = {path = "",type = "Button"},
    uiAnimator = {path = "",type = "UIAnimator"},
    anim = {path = "",type = "Animator"},
    canvasGroup = {path = "Group",type = "CanvasGroup"},
    heroPic = {path = "Group/HeroPic",type = "RawImage"},
    heroName = {path = "Group/HeroName",type = "Text"},
    equipDesc = {path = "Group/Desc/DescText",type = "Text"},
    choice = {path = "Group/Choice",type = "GameObject"},
    leftTimerText = {path = "Group/LeftTime/LeftTimer/LeftTimerText",type = "Text"},
    buyBtn = {path = "Group/BuyBtn",type = "Button"},
    priceText = {path = "Group/BuyBtn/Text",type = "Text"},
    weaponEquipItem = {path = "Group/WeaponEquipItem", type = "GameObject"},
    colorImg = {path = "Group/ColorImg", type = "GameObject"},
    iconObj = {path = "Group/Icon", type = "GameObject"},
}

NewPlayerLimitEquipGoodsItem.New = function(parent)
    local self = {}
    setmetatable(self, NewPlayerLimitEquipGoodsItem)
    self.prefabPath = "Assets/_BundleResources/UI/Activity/NewPlayerLimitEquipGoodsItem.prefab"
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath)
    LuaMgr.AddPrefabRefCount(self.prefabPath)
    self.transform = self.gameObject:GetComponent("RectTransform");
    self.transform:SetParent(parent, false);
    self.pos = Vector3(0, 0, 0);
    UITool.Parse(self.gameObject, self,objs)
    LuaMgr.SetFont(self.transform);
    self.rewardItemTrList = {}
    self.clickCommand = function()
        if self.data.onClick ~= nil then
            self.data.onClick(self.index);
        end
    end
    LuaMgr.AddClick(self.bgBtn, self.clickCommand)
    self.buyCommand = function()
        if self.data.onBuy ~= nil then
            self.data.onBuy(self.data.goodsID);
        end
    end
    LuaMgr.AddClick(self.buyBtn, self.buyCommand)
    return self
end

function NewPlayerLimitEquipGoodsItem:SetData(index,data)
    self.index = index
    self.data = data
    SetActive(self.heroPic.gameObject, data.heroPic ~= nil)
    if data.heroPic ~= nil then
        self.heroPic.texture = data.heroPic
    end
    self.heroName.text = data.name
    self.anim.enabled = false
    self.canvasGroup.alpha = 0.0
    self.uiAnimator.AnimationName = ""

    self.equipDesc.text = data.desc
    SetActive(self.equipDesc.transform.parent.gameObject, data.desc ~= "")
    
    self.leftTimerText.text = data.leftTimeStr
    SetActive(self.leftTimerText.transform.parent.parent.gameObject, data.leftTimeStr ~= "")
    
    self.priceText.text = data.priceStr
    SetActive(self.buyBtn.gameObject, data.priceStr ~= "")

    SetActive(self.choice, data.isSelect)
    if data.weaponId ~= "" then
        SetActive(self.weaponEquipItem, true)
        self.equipItem = NewPlayerLimitEquipItem.New(self.weaponEquipItem)
        self.equipItem:SetData({WeaponID = data.weaponId})
    else
        SetActive(self.weaponEquipItem, false)
    end
    SetActive(self.colorImg, data.isPage1)
    SetActive(self.iconObj, data.isPage1)
    
    SetActive(self.gameObject, data.isActive)
end

function NewPlayerLimitEquipGoodsItem:SetRewardItems()
    if self.rewardContentTr == nil then
        self.rewardContentTr = self.transform:Find("Group/ItemList"):GetComponent("RectTransform")
    end
    if self.RewardItemTemp == nil then
        self.RewardItemTemp = self.transform:Find("Group/ItemList/RewardItem").gameObject
        SetActive(self.RewardItemTemp, false)
    end
    local _cfgChargeMap= ConfigMgr.Config.charge
    local charge=_cfgChargeMap[self.data.goodsID];
    if charge == nil or charge.Reward == nil then
        return
    end

    local index = 1
    for i,v in ipairs(charge.Reward) do
        local goodsItem = nil
        if self.rewardItemTrList[i] == nil then
            local obj = LuaMgr.InstantiateGO(self.RewardItemTemp, self.rewardContentTr, false)
            SetActive(obj, true)
            self.rewardItemTrList[i] = GoodsDataItem.New(obj.transform)
        end
        SetActive(self.rewardItemTrList[i].transform.parent.gameObject,true)
        local itemConfig = ConfigMgr.Config.itemMap[v.id]
        itemConfig["count0"] = v.count
        self.rewardItemTrList[i]:SetData(1, itemConfig, 1, false, Vector3(1, 1, 1), false)
        index = index + 1
    end
    for i = index, #self.rewardItemTrList do
        SetActive(self.rewardItemTrList[i].transform.parent.gameObject,false)
    end
end

function NewPlayerLimitEquipGoodsItem:SetTimerStr(timeStr)
    self.data.leftTimeStr = timeStr
    self.leftTimerText.text = timeStr
    SetActive(self.leftTimerText.transform.parent.parent.gameObject, timeStr ~= "")
end

function NewPlayerLimitEquipGoodsItem:Show()
    self.data.isActive = true
    SetActive(self.gameObject, true)
end

function NewPlayerLimitEquipGoodsItem:Show2()
    self.canvasGroup.alpha = 1
end

function NewPlayerLimitEquipGoodsItem:PlayAnim()
    self.uiAnimator.AnimationName = "ani_ani_NewPlayerLimitSSRAddPopup_NewPlayerLimitEquipGoodsItem"
end

function NewPlayerLimitEquipGoodsItem:Hide2()
    self.anim.enabled = false
    self.canvasGroup.alpha = 0.0
    self.uiAnimator.AnimationName = ""
end

function NewPlayerLimitEquipGoodsItem:Hide()
    self.data.isActive = false
    SetActive(self.gameObject, false)
end

function NewPlayerLimitEquipGoodsItem:Clear()
    if self.HeroCommand ~= nil then
        LuaMgr.RemoveClick(self.bgBtn,self.HeroCommand)
        self.HeroCommand = nil
    end
    if not IsNullOrEmpty(self.prefabPath) then
        LuaMgr.RemovePrefabRefCount(self.prefabPath)
    end
    self.rectTransform = nil
    self.transform = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end 