NewPlayerLimitSSRGoodsItem = {}
NewPlayerLimitSSRGoodsItem.__index = NewPlayerLimitSSRGoodsItem

local objs = {
    bgBtn = {path = "",type = "Button"},
    uiAnimator = {path = "",type = "UIAnimator"},
    anim = {path = "",type = "Animator"},
    canvasGroup = {path = "Group",type = "CanvasGroup"},
    heroPic = {path = "Group/HeroPic",type = "RawImage"},
    heroRare = {path = "Group/HeroRare",type = "GameObject"},
    heroRare2 = {path = "Group/HeroRare2",type = "GameObject"},
    heroLevel = {path = "Group/HeroLevel",type = "Text"},
    heroJob = {path = "Group/HeroJob",type = "Image"},
    heroZZText = {path = "Group/HeroZZ/Text",type = "Text"},
    heroName = {path = "Group/HeroName",type = "Text"},
    choice = {path = "Group/Choice",type = "GameObject"},
    upIcon = {path = "Group/UpIcon",type = "GameObject"},
    leftTimerText = {path = "Group/LeftTime/LeftTimer/LeftTimerText",type = "Text"},
    buyBtn = {path = "Group/BuyBtn",type = "Button"},
    priceText = {path = "Group/BuyBtn/Text",type = "Text"},
    hasItem = {path = "Group/HasItem",type = "GameObject"},
    hasItemBg = {path = "Group/HasItem/HasBg",type = "GameObject"},
    notHasItemBg = {path = "Group/HasItem/NotHasBg",type = "GameObject"},
}

NewPlayerLimitSSRGoodsItem.New = function(prefab, parent)
    local self = {}
    setmetatable(self, NewPlayerLimitSSRGoodsItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject:GetComponent("RectTransform");
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

function NewPlayerLimitSSRGoodsItem:SetData(index,data)
    self.index = index
    self.data = data
    self.heroPic.texture = data.heroPic
    self.heroName.text = data.name
    self.anim.enabled = false
    self.canvasGroup.alpha = 0.0
    self.uiAnimator.AnimationName = ""
    
    self.heroLevel.text = data.level
    SetActive(self.heroLevel.gameObject, data.level ~= 0)
    
    if data.job ~= nil then
        self.heroJob.sprite = data.job
    end
    SetActive(self.heroJob.gameObject, data.job ~= nil)
    
    self.leftTimerText.text = data.leftTimeStr
    SetActive(self.leftTimerText.transform.parent.parent.gameObject, data.leftTimeStr ~= "")
    
    self.heroZZText.text = data.zzStr
    SetActive(self.heroZZText.transform.parent.gameObject, data.zzStr ~= "")
    
    self.priceText.text = data.priceStr
    SetActive(self.buyBtn.gameObject, data.priceStr ~= "")

    SetActive(self.heroRare, data.isPage1)
    SetActive(self.heroRare2, not data.isPage1)
    SetActive(self.choice, data.isSelect)
    SetActive(self.upIcon, data.showUpIcon)
    SetActive(self.hasItem, data.shwoHasItem)
    SetActive(self.hasItemBg, data.hasItem)
    SetActive(self.notHasItemBg, not data.hasItem)
    SetActive(self.gameObject, data.isActive)
end

function NewPlayerLimitSSRGoodsItem:SetRewardItems()
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
        self.rewardItemTrList[i]:SetData(1, itemConfig, 1, false, Vector3(0.62, 0.62, 0.62), false)
        index = index + 1
    end
    for i = index, #self.rewardItemTrList do
        SetActive(self.rewardItemTrList[i].transform.parent.gameObject,false)
    end
end

function NewPlayerLimitSSRGoodsItem:SetTimerStr(timeStr)
    self.data.leftTimeStr = timeStr
    self.leftTimerText.text = timeStr
    SetActive(self.leftTimerText.transform.parent.parent.gameObject, timeStr ~= "")
end

function NewPlayerLimitSSRGoodsItem:Show()
    self.data.isActive = true
    SetActive(self.gameObject, true)
end

function NewPlayerLimitSSRGoodsItem:Show2()
    self.canvasGroup.alpha = 1
end

function NewPlayerLimitSSRGoodsItem:PlayAnim()
    self.uiAnimator.AnimationName = "ani_ani_NewPlayerLimitSSRAddPopup_NewPlayerLimitSSRGoodsItem"
end

function NewPlayerLimitSSRGoodsItem:Hide2()
    self.anim.enabled = false
    self.canvasGroup.alpha = 0.0
    self.uiAnimator.AnimationName = ""
end

function NewPlayerLimitSSRGoodsItem:Hide()
    self.data.isActive = false
    SetActive(self.gameObject, false)
end

function NewPlayerLimitSSRGoodsItem:Clear()
    if self.HeroCommand ~= nil then
        LuaMgr.RemoveClick(self.bgBtn,self.HeroCommand)
        self.HeroCommand = nil
    end
    self.rectTransform = nil
    self.transform = nil
    LuaMgr.DestroyImmediateGO(self.object)
    self.object = nil
end 