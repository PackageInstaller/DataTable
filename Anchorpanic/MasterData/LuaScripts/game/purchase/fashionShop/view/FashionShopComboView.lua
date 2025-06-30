module("purchase.FashionShopComboView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("purchase/FashionShopComboView.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mSubViewItem = {}
    self.mChildViewDic = {}

    self.mSelectComboProps = {}
end

function configUI(self)

    self.mChildViewDic[fashionShop.ShopType.COMBO] = self:getChildGO("mChildViewCombo")
    self.mChildViewDic[fashionShop.ShopType.SCENE] = self:getChildGO("mChildViewScene")
    self.mChildViewDic[fashionShop.ShopType.PAIRTS] = self:getChildGO("mChildViewPairts")
    self.mChildViewDic[fashionShop.ShopType.NOMAL] = self:getChildGO("mChildViewNomal")

    self.mGroupTabItem = self:getChildTrans("mGroupTabItem")
    self.mShopTabChildItem = self:getChildGO("mShopTabChildItem")

    ---------------------------combo---------------------------
    self.mComboLyScroller = self:getChildGO("mComboLyScroller"):GetComponent(ty.LyScroller)
    self.mComboLyScroller:SetItemRender(purchase.FashionComboItem)

    self.mIconSelectCombo = self:getChildGO("mIconSelectCombo"):GetComponent(ty.AutoRefImage)
    self.mTxtSelectComboName = self:getChildGO("mTxtSelectComboName"):GetComponent(ty.Text)
    self.mSelectComboPropsContent = self:getChildTrans("mSelectComboPropsContent")
    self.mBtnComboBuy = self:getChildGO("mBtnComboBuy")
    self.mTxtComboCost = self:getChildGO("mTxtComboCost"):GetComponent(ty.Text)
    self.mImgScale = self:getChildGO("mImgScale")
    self.mTxtScleValue = self:getChildGO("mTxtScleValue"):GetComponent(ty.Text)
    self.mTxtSale = self:getChildGO("mTxtSale"):GetComponent(ty.Text)
    ---------------------------Scene---------------------------
    self.mSceneLyScroller = self:getChildGO("mSceneLyScroller"):GetComponent(ty.LyScroller)
    self.mSceneLyScroller:SetItemRender(purchase.FashionSceneItem)

    self.mIconSelectScene = self:getChildGO("mIconSelectScene"):GetComponent(ty.AutoRefImage)
    self.mTxtSelectSceneName = self:getChildGO("mTxtSelectSceneName"):GetComponent(ty.Text)

    self.mTxtSelectSceneHeroName = self:getChildGO("mTxtSelectSceneHeroName"):GetComponent(ty.Text)
    self.mSelectScenePropsContent = self:getChildTrans("mSelectScenePropsContent")
    self.mBtnSceneBuy = self:getChildGO("mBtnSceneBuy")
    self.mTxtSceneCost = self:getChildGO("mTxtSceneCost"):GetComponent(ty.Text)
    self.mImgSceneScale = self:getChildGO("mImgSceneScale")
    self.mTxtSceneScleValue = self:getChildGO("mTxtSceneScleValue"):GetComponent(ty.Text)
    self.mTxtSceneSale = self:getChildGO("mTxtSceneSale"):GetComponent(ty.Text)

    self.mIconSelectHeroHead = self:getChildGO("mIconSelectHeroHead"):GetComponent(ty.AutoRefImage)
    self.mIconSelectHeroHeadBtn = self.mIconSelectHeroHead.gameObject
    self.mImgHeroHeadHas = self:getChildGO("mImgHeroHeadHas")
    ---------------------------Pairts---------------------------
    self.mPairtsLyScroller = self:getChildGO("mPairtsLyScroller"):GetComponent(ty.LyScroller)
    self.mPairtsLyScroller:SetItemRender(purchase.FashionPairtsItem)
    ---------------------------Nomal---------------------------
    self.mLyNomalScroller = self:getChildGO("mNomalLyScroller"):GetComponent(ty.LyScroller)
    self.mLyNomalScroller:SetItemRender(purchase.FashionShopItem)

    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnFight_Combo = self:getChildGO("mBtnFight_Combo")
end

function active(self, args)
    super.active(self, args)

    MoneyManager:setMoneyTidList({MoneyTid.PAY_ITIANIUM_TID})

    GameDispatcher:addEventListener(EventName.UPDATE_SELECT_FASHION_COMBO, self.onUpdateComboSelect, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SELECT_FASHION_SCENE, self.onUpdateSceneSelect, self)
    GameDispatcher:addEventListener(EventName.UPDATE_FASHION_COMBO_VIEW, self.showPanel, self)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)

    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    GameDispatcher:removeEventListener(EventName.UPDATE_SELECT_FASHION_COMBO, self.onUpdateComboSelect, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SELECT_FASHION_SCENE, self.onUpdateSceneSelect, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FASHION_COMBO_VIEW, self.showPanel, self)
    self:clearSubShopItem()

    self:clearSelectComboProps()
    if self.mLyNomalScroller then
        self.mLyNomalScroller:CleanAllItem()
    end
    if self.mPairtsLyScroller then
        self.mPairtsLyScroller:CleanAllItem()
    end

    if self.mComboLyScroller then
        self.mComboLyScroller:CleanAllItem()
    end

    if self.mSceneLyScroller then
        self.mSceneLyScroller:CleanAllItem()
    end
end

function initViewText(self)
    self:setBtnLabel(self.mBtnFight, 50095)
    self:setBtnLabel(self.mBtnFight_Combo, 50095)

end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnComboBuy, self.onComboBuy)
    self:addUIEvent(self.mBtnSceneBuy, self.onSceneBuy)
    self:addUIEvent(self.mIconSelectHeroHeadBtn, self.onShowSingleHero)
    self:addUIEvent(self.mBtnFight, self.onBigHostelTrial)
    self:addUIEvent(self.mBtnFight_Combo, self.onBigHostelTrial)
end

function onBigHostelTrial(self)
    UIFactory:alertMessge(_TT(50090), true, function()
        if self.selectSceneConfigVo.heroTid == nil then
            local heroVo = hero.HeroManager:getHeroConfigVo(self.selectSceneConfigVo.skinId[1])
            local sceneConfigVo = purchase.FashionShopManager:getFashionSceneData(self.selectSceneConfigVo.skinId[1], self.selectSceneConfigVo.skinId[2])
            GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_SCENE, {model_id = sceneConfigVo.modelId, heroConfigVo = heroVo, main_type = BigHostelConst.SceneUI_Type.TRIAL})
        else
            local heroVo = hero.HeroManager:getHeroConfigVo(self.selectSceneConfigVo.heroTid)
            GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_SCENE, {model_id = self.selectSceneConfigVo.modelId, heroConfigVo = heroVo, main_type = BigHostelConst.SceneUI_Type.TRIAL})
        end

    end, _TT(1), nil, true, nil, _TT(2))
end

function onShowSingleHero(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_ONE_VIEW, {heroTid = self.curSelectSceneData.fashionDic[1],
    fashionId = self.curSelectSceneData.fashionDic[2], isShow3D = true})
end

function onComboBuy(self)
    recharge.sendRecharge(recharge.RechargeType.FASHION_COMBO, nil, self.mComboId)
end

function onSceneBuy(self)
    recharge.sendRecharge(recharge.RechargeType.FASHION_OTHER, nil, self.mSceneId)
end

function showPanel(self)
    self:clearSubShopItem()
    local list = purchase.getFashionShopComboList()
    for k, v in ipairs(list) do
        local item = SimpleInsItem:create(self.mShopTabChildItem, self.mGroupTabItem, "mFashionShopSub")
        item:getChildGO("mTxtNomal"):GetComponent(ty.Text).text = _TT(v.nomalLanId)
        item:getChildGO("mTxtSelect"):GetComponent(ty.Text).text = _TT(v.nomalLanId)
        -- self:setBtnLabel(item:getChildGO("onClickChildItem"), v.nomalLanId)
        item:addUIEvent("mBtnClick", function()
            self:onClickChildItem(v.page)
        end)
        self.mSubViewItem[v.page] = item
    end

    -- self:updateComboView()
    -- self:updateSceneView()
    -- self:updatePairtsView()
    -- self:updateNomalView()

    self.mLastIndex = purchase.FashionShopManager:getDefOpenFashionType()
    if self.mLastIndex == nil then
        self:onClickChildItem(fashionShop.ShopType.COMBO)
    else
        self:onClickChildItem(self.mLastIndex)
    end

end

function clearSubShopItem(self)
    for k, v in pairs(self.mSubViewItem) do
        v:poolRecover()
    end
    self.mSubViewItem = {}
end

function onClickChildItem(self, index)
    for k, v in pairs(self.mSubViewItem) do
        v:getChildGO("mBtnNomal"):SetActive(k ~= index)
        v:getChildGO("mBtnSelect"):SetActive(k == index)
    end

    self.mLastIndex = index
    purchase.FashionShopManager:setDefOpenFashionType(index)
    -- 保存当前打开的tab页签，下次打开时会自动打开这个tab页签，而不是默认的tab页签，比如：打开时装商店，默认打开的是普通皮肤，但是如果上次打开的是时装商店，那么下次打开时装商店时，会自动打开时装商店，而不是普通皮肤

    self:updateSubView(index)
end

function updateSubView(self, index)
    for k, v in pairs(self.mChildViewDic) do
        self.mChildViewDic[k]:SetActive(k == index)
    end

    if self.mLyNomalScroller then
        self.mLyNomalScroller:CleanAllItem()
    end
    if self.mPairtsLyScroller then
        self.mPairtsLyScroller:CleanAllItem()
    end

    if self.mComboLyScroller then
        self.mComboLyScroller:CleanAllItem()
    end

    if self.mSceneLyScroller then
        self.mSceneLyScroller:CleanAllItem()
    end

    if index == fashionShop.ShopType.COMBO then
        self:updateComboView()
    elseif index == fashionShop.ShopType.SCENE then
        self:updateSceneView()
    elseif index == fashionShop.ShopType.PAIRTS then
        self:updatePairtsView()
    elseif index == fashionShop.ShopType.NOMAL then
        self:updateNomalView()
    end
    -- self:updateComboView()
    -- self:updateSceneView()
    -- self:updatePairtsView()
    -- self:updateNomalView()
end

function updateComboView(self)

    self.mComboList = purchase.FashionShopManager:getComboShopList()

    if self.mComboLyScroller.Count <= 0 then
        self.mComboLyScroller.DataProvider = self.mComboList
    else
        self.mComboLyScroller:ReplaceAllDataProvider(self.mComboList)
    end

    if self.mComboList[1] then
        self:onUpdateComboSelect(self.mComboList[1])
    end
end

function updateSceneView(self)
    self.mSceneList = purchase.FashionShopManager:getCurShopList(fashionShop.ShopType.SCENE)
    for i = 1, #self.mSceneList do
        self.mSceneList[i].configChildVo = purchase.FashionShopManager:getFashionSceneData(
        self.mSceneList[i].fashionDic[1], self.mSceneList[i].fashionDic[2])
    end

    if self.mSceneLyScroller.Count <= 0 then
        self.mSceneLyScroller.DataProvider = self.mSceneList
    else
        self.mSceneLyScroller:ReplaceAllDataProvider(self.mSceneList)
    end

    if self.mSceneList[1] then
        self:onUpdateSceneSelect(self.mSceneList[1])
    end
    --self.mSceneLyScroller:JumpToTop()

end

function onUpdateComboSelect(self, selectData)
    self.mComboId = selectData.id
    for i = 1, #self.mComboList, 1 do
        self.mComboList[i].isSelect = self.mComboList[i].id == selectData.id
    end

    self.mComboLyScroller:ReplaceAllDataProvider(self.mComboList)

    if (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) then
        self.mIconSelectCombo:SetImg(UrlManager:getIconPath("fashionCombo_Har/"..selectData.configVo.img), false)
        --self.mImgIcon:SetImg(UrlManager:getIconPath("fashionCombo_Har/"..param.configVo.icon)  , true)
    else
        self.mIconSelectCombo:SetImg(UrlManager:getIconPath("fashionCombo/"..selectData.configVo.img), false)
    end

    --self.mIconSelectCombo:SetImg(UrlManager:getIconPath(selectData.configVo.img))
    self.mTxtSelectComboName.text = _TT(selectData.configVo.name)
    self.mTxtComboCost.text = selectData.cost / 100
    self.mImgScale.gameObject:SetActive(selectData.configVo.scaleOff > 0)
    self.mTxtScleValue.text = selectData.configVo.scaleOff / 100

    self:clearSelectComboProps()
    local goodsList = selectData.configVo.goodsList
    for i = 1, #selectData.configVo.itemList, 1 do
        local propsGrid = PropsGrid:createByData({
            tid = selectData.configVo.itemList[i],
            num = 1,
            parent = self.mSelectComboPropsContent,
            scale = 0.55,
            showUseInTip = true
        })
        table.insert(self.mSelectComboProps, propsGrid)
        propsGrid:setHasRec(purchase.FashionShopManager:getFashionSceneOrPairtsIsBuy(goodsList[i]))
    end

    self.mBtnComboBuy:SetActive(not purchase.FashionShopManager:getComboIsBuy(selectData.id))

    self.selectSceneConfigVo = selectData.configVo
end

function onUpdateSceneSelect(self, selectData)
    self.mSceneId = selectData.id
    for i = 1, #self.mSceneList, 1 do
        self.mSceneList[i].isSelect = self.mSceneList[i].id == selectData.id
    end
    self.mSceneLyScroller:ReplaceAllDataProvider(self.mSceneList)

    self.mIconSelectScene:SetImg(UrlManager:getIconPath(selectData.configChildVo.img))

    local propsVo = props.PropsManager:getPropsConfigVo(selectData.configChildVo.itemId)

    self.mTxtSelectSceneName.text = propsVo:getName()
    self.mTxtSceneCost.text = selectData:getMoneyCount() / 100

    local heroVo = hero.HeroManager:getHeroConfigVo(selectData.configChildVo.heroTid)
    self.mTxtSelectSceneHeroName.text = heroVo.name

    local fashionData = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, selectData.fashionDic[1], selectData.fashionDic[2])
    self.mIconSelectHeroHead:SetImg(UrlManager:getHeroHeadUrlByModel(fashionData.model), false)

    local isHave = fashion.FashionManager:getHeroFashionHaveInfo(fashion.Type.CLOTHES, selectData.fashionDic[1],
    selectData.fashionDic[2])
    self.mImgHeroHeadHas:SetActive(isHave)
    self.mBtnSceneBuy:SetActive(not purchase.FashionShopManager:getFashionSceneOrPairtsIsBuy(selectData.id))

    self.curSelectSceneData = selectData

    self.selectSceneConfigVo = selectData.configChildVo

    self.mImgSceneScale.gameObject:SetActive(false)
    --self.mTxtSceneScleValue.text = selectData.configChildVo.scaleOff .. "%"
end

function clearSelectComboProps(self)
    for i = 1, #self.mSelectComboProps, 1 do
        self.mSelectComboProps[i]:poolRecover()
    end
    self.mSelectComboProps = {}
end

function updatePairtsView(self)
    local list = purchase.FashionShopManager:getCurShopList(fashionShop.ShopType.PAIRTS)
    table.sort(list, function(vo1, vo2)
        local v1 = vo1:getIsSellOut() and 0 or 1
        local v2 = vo2:getIsSellOut() and 0 or 1
        if v1 > v2 then
            return true
        elseif v1 < v2 then
            return false
        else
            return vo1.sort < vo2.sort
        end
    end)

    for i, vo in ipairs(list) do
        list[i].isShow = false
        list[i].tweenId = i
    end
    if self.mPairtsLyScroller.Count <= 0 then
        self.mPairtsLyScroller.DataProvider = list
    else
        self.mPairtsLyScroller:ReplaceAllDataProvider(list)
    end
end

function updateNomalView(self)
    local list = purchase.FashionShopManager:getCurShopList(fashionShop.ShopType.NOMAL)
    table.sort(list, function(vo1, vo2)
        local v1 = vo1:getIsSellOut() and 0 or 1
        local v2 = vo2:getIsSellOut() and 0 or 1
        if v1 > v2 then
            return true
        elseif v1 < v2 then
            return false
        else
            return vo1.sort < vo2.sort
        end
    end)

    for i, vo in ipairs(list) do
        list[i].isShow = false
        list[i].tweenId = i
    end
    if self.mLyNomalScroller.Count <= 0 then
        self.mLyNomalScroller.DataProvider = list
    else
        self.mLyNomalScroller:ReplaceAllDataProvider(list)
    end
end

return _M
