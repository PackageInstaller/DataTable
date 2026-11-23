




UIShopSkinItem = {}
UIShopSkinItem.__index = UIShopSkinItem
local PREFAB_PATH = "Assets/_BundleResources/UI/Shop/UIShopSkinItem.prefab"

UIShopSkinItem.New = function(parent)
    local self = {}
    setmetatable(self, UIShopSkinItem)
    self.gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
    LuaMgr.AddPrefabRefCount(PREFAB_PATH)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent)
    self.transform.localScale = Vector3.one
    self.transform.localPosition = Vector3.zero
    local uiLink = self.gameObject:GetComponent("UILink")
    self.btnClick = uiLink:Get("btnClick"):GetComponent("Button")
    self.btnClick2 = uiLink:Get("btnClick2"):GetComponent("Button")
    self.rawImageSkin = uiLink:Get("rawImageSkin"):GetComponent("RawImage")


    self.goDiscount = uiLink:Get("goDiscount")
    self.textDisCountValue = uiLink:Get("textDisCountValue"):GetComponent("Text")

    self.textSkinName = uiLink:Get("textSkinName"):GetComponent("Text")
    self.textHeroName = uiLink:Get("textHeroName"):GetComponent("Text")




    self.goHasGot = uiLink:Get("goHasGot")
    self.goZheZhao = uiLink:Get("goZheZhao")
    self.goRemainTime = uiLink:Get("goRemainTime")
    self.textTime = uiLink:Get("textTime"):GetComponent("Text")
    self.gray = uiLink:Get("goDiscount"):GetComponent("Laigu.Tools.UITools.UIGray")
    self.textMianFei = uiLink:Get("textMianFei")

    self.goOnePrice = uiLink:Get("goOnePrice")
    self.textOnePrice = uiLink:Get("textOnePrice"):GetComponent("Text")
    self.rawImageOne = uiLink:Get("rawImageOne"):GetComponent("RawImage")
    self.textDiscount = uiLink:Get("textDiscount"):GetComponent("Text")

    self.goTwoPrice = uiLink:Get("goTwoPrice")
    self.textTwoPrice1 = uiLink:Get("textTwoPrice1"):GetComponent("Text")
    self.rawImageTwo = uiLink:Get("rawImageTwo"):GetComponent("RawImage")
    self.textTwoPrice2 = uiLink:Get("textTwoPrice2"):GetComponent("Text")
    self.textDes = uiLink:Get("textDes"):GetComponent("Text")

    uiLink:AddClickEvent(
        "btnClick",
        function()
            self:OnClickSkin()
        end
    )
    uiLink:AddClickEvent(
        "btnClick2",
        function()
            self:OnClickSkin()
        end
    )

    return self
end

function UIShopSkinItem:Destroy()
    if self.gameObject ~= nil then
        LuaMgr.RemovePrefabRefCount(PREFAB_PATH)
        LuaMgr.DestroyImmediateGO(self.gameObject)
        self.gameObject = nil
        self.transform = nil
        self.btnClick = nil
        self.btnClick2 = nil
        self.rawImageSkin = nil


        self.goDiscount = nil
        self.textDisCountValue = nil
        self.textSkinName = nil
        self.textHeroName = nil




        self.goHasGot = nil
        self.goZheZhao = nil
        self.goRemainTime = nil
        self.textTime = nil
        self.goOnePrice = nil
        self.textOnePrice = nil
        self.rawImageOne = nil
        self.goTwoPrice = nil
        self.textTwoPrice1 = nil
        self.rawImageTwo = nil
        self.textTwoPrice2 = nil
        self.textDiscount = nil
        self.textDes = nil
    end
end

function UIShopSkinItem:SetData(charge, isClick, index)
    self.data = charge
    self.isClick = isClick
    local skinData = HeroRedDataHelper.GetSkinByItemID(charge.Reward[1].id)
    if nil == skinData then
        LuaDebug.error("策划检查下棋子皮肤表和物品表的映射 ：" .. charge.Reward[1].id)
        return
    end

    self.characterId = skinData.characterId
    self.skinID = skinData.skinID


    local character = ConfigMgr.Config.characterTable[skinData.characterId]
    if nil == character then
        print("character is nil, " .. skinData.characterId)
        return
    end

    SetActive(self.goOnePrice, false)
    SetActive(self.goTwoPrice, false)
    SetActive(self.textMianFei, false)


    local hasGot = HeroRedDataHelper.CheckSkinIDById(skinData.characterId, skinData.skinID)
    self.getSort = hasGot and 1 or 0


    local skinPath = CS.Laigu.ViewModel.Hero.HeroManager.GetCharacterCard(skinData.characterId, skinData.skinID)
    self.rawImageSkin.texture = LuaMgr.GetTexture(skinPath)


    local priceIconPath = "Assets/_BundleResources/Images/ItemIcons/itemicon_home_" .. charge.Cost.id .. ".png"





    self:SetOffShelvesInfo(index)

    local discount = tonumber(charge.Discount)
    SetActive(self.goDiscount, discount < 1)





    SetActive(self.goZheZhao, hasGot)
    if self.gray.Interactable ~= nil then
        self.gray.Interactable = not hasGot
    end
    SetActive(self.goHasGot, hasGot)

    self.textDisCountValue.text = math.floor(charge.Discount * 100) .. "%"
    self.textSkinName.text = LuaMgr.GetLangText(skinData.skinNamelan)
    self.textHeroName.text = LuaMgr.GetLangText(character.namelan)

    if hasGot then
        return
    end

    local tempPrice = 0
    if not IsNullOrEmpty(self.data.ChargeGroup) and not IsNullOrEmpty(self.data.Cost.id) then
        self.rawImageTwo.texture = LuaMgr.GetTexture(priceIconPath)
        self.textTwoPrice1.text = self.data.Cost.count
        local chargeChanel = ConfigHelper.GetChargeChannel(charge.ChargeGroup)
        self.textTwoPrice2.text = chargeChanel.CurrencySymbol .. " " .. chargeChanel.PriceShow
        SetActive(self.goTwoPrice, true)
    else
        if not IsNullOrEmpty(self.data.ChargeGroup) then
            local chargeChanel = ConfigHelper.GetChargeChannel(charge.ChargeGroup)
            self.textOnePrice.text = chargeChanel.CurrencySymbol .. " " .. chargeChanel.PriceShow
            self.textOnePrice.transform.anchoredPosition = Vector2(0, 3)
            SetActive(self.rawImageOne.gameObject, false)
            SetActive(self.goOnePrice, true)
        elseif not IsNullOrEmpty(self.data.Cost.id) then
            if self.data.Cost.count == 0 then
                SetActive(self.textMianFei, true)
            else
                self.textOnePrice.transform.anchoredPosition = Vector2(19, 3)
                SetActive(self.rawImageOne.gameObject, true)
                self.textOnePrice.text = self.data.Cost.count
                self.rawImageOne.texture = LuaMgr.GetTexture(priceIconPath)
                SetActive(self.textMianFei, false)
            end
            SetActive(self.goOnePrice, self.data.Cost.count > 0)
        end
        if discount < 1 then
            self.textDiscount.text = charge.OriginalPrice
        end
        SetActive(self.textDiscount.gameObject, discount < 1)
    end



















end

function UIShopSkinItem:OnClickSkin()
    if not self.isClick then
        return
    end

    ComData.skipJump = 1
    if FeatureManager.IsLock("1011") then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1011"))
    else
        DataReportMgr.NetClickGoodsAndPage(self.data.Reward[1].id, ShopType.Skin, ShopType.Skin)

        LuaMgr.ShowLuaPanel(UIName.HeroSkinViewModel, self.characterId, self.skinID)
    end
end


function UIShopSkinItem:SetOffShelvesInfo(index)
    local data = self.data
    local curTimestamp = LuaMgr.Timestamp()
    local isShowLabel = data.StartTime ~= nil and data.StartTime > 0 and data.EndTime ~= nil and curTimestamp < data.EndTime
    if isShowLabel == true then

        if curTimestamp < data.EndTime - 30 * 24 * 3600 then
            isShowLabel = false
        end
    end
    if isShowLabel == true then
        SetActive(self.goRemainTime, true)
        self.textTime.text = HeroRedDataHelper.GetRemianTime(data)
        self.textDes.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22670")
        self.timeTextStrMS = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7605")
        self.timeTextStrS = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_104004")
        if curTimestamp > data.EndTime - 3600 then
            self.RefreshDownTime = function()
                self:RefreshOffShelvesDownTime()
            end
            self.timerID = TimerConst.ShopSkinDownTime * 100 + (index or 0)
            LuaMgr.AddTimer(self.timerID, self.RefreshDownTime, 1, -1, true)
        end
    else
        SetActive(self.goRemainTime, false)
    end
end

function UIShopSkinItem:RefreshOffShelvesDownTime()
    local curTimestamp = LuaMgr.Timestamp()
    if curTimestamp > self.data.EndTime then
        LuaMgr.RemoveTimer(self.timerID)
        SetActive(self.gameObject, false)
        return
    end
    local remainSecond = self.data.EndTime - curTimestamp
    local hour, minute, seconds = GetTimeHMS2(remainSecond)
    if remainSecond >= 60 then
        self.textTime.text  = string.format(self.timeTextStrMS, tostring(minute), tostring(seconds))
    else
        self.textTime.text  = string.format(self.timeTextStrS, seconds)
    end
end

function UIShopSkinItem:Clear()
    self.data = nil
    LuaMgr.RemoveTimer(self.timerID)
    SetActive(self.gameObject, false)
end