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
    self.mSelectFightProps = {}
end

function configUI(self)

    self.mChildViewDic[fashionShop.ShopType.COMBO] = self:getChildGO("mChildViewCombo")
    self.mChildViewDic[fashionShop.ShopType.SCENE] = self:getChildGO("mChildViewScene")
    self.mChildViewDic[fashionShop.ShopType.PAIRTS] = self:getChildGO("mChildViewPairts")
    self.mChildViewDic[fashionShop.ShopType.NOMAL] = self:getChildGO("mChildViewNomal")
    self.mChildViewDic[fashionShop.ShopType.PAINTING] = self:getChildGO("mChildViewPainting")
    self.mChildViewDic[fashionShop.ShopType.FIGHTSKIN] = self:getChildGO("mChildViewFightSkin")

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
    self.SceneGroup = self:getChildGO("SceneGroup")
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

    ---------------------------Painting---------------------------
    self.mPaintingLyScroller = self:getChildGO("mPaintingLyScroller"):GetComponent(ty.LyScroller)
    self.mPaintingLyScroller:SetItemRender(purchase.FashionPaintingItem)

    ---------------------------fight---------------------------
    self.mFightLyScroller = self:getChildGO("mFightLyScroller"):GetComponent(ty.LyScroller)
    self.mFightLyScroller:SetItemRender(purchase.FashionFightItem)

    self.mIconSelectFight = self:getChildGO("mIconSelectFight"):GetComponent(ty.AutoRefImage)
    self.mTxtSelectFightName = self:getChildGO("mTxtSelectFightName"):GetComponent(ty.Text)
    self.mSelectFightPropsContent = self:getChildTrans("mSelectFightPropsContent")
    self.mBtnFightBuy = self:getChildGO("mBtnFightBuy")
    -- self.mTxtFightCost = self:getChildGO("mTxtFightCost"):GetComponent(ty.Text)
    self.mImgIconFightMoney = self:getChildGO("mImgIconFightMoney"):GetComponent(ty.AutoRefImage)
    self.mTxtFightMoney = self:getChildGO("mTxtFightMoney"):GetComponent(ty.Text)

    self.mImgFightScale = self:getChildGO("mImgFightScale")
    self.mTxtFightScleValue = self:getChildGO("mTxtFightScleValue"):GetComponent(ty.Text)
    self.mTxtFightSale = self:getChildGO("mTxtFightSale"):GetComponent(ty.Text)
    self.mBtnFightPre = self:getChildGO("mBtnFightPre")
    self.mTxtFightPre = self:getChildGO("mTxtFightPre"):GetComponent(ty.Text)

    self.mBtnSetting = self:getChildGO("mBtnSetting")

end

function active(self, args)
    super.active(self, args)

    self.SceneGroup.gameObject:SetActive(false)

    MoneyManager:setMoneyTidList({MoneyTid.PAY_ITIANIUM_TID, MoneyTid.FASHION_TID})

    GameDispatcher:addEventListener(EventName.UPDATE_SELECT_FASHION_COMBO, self.onUpdateComboSelect, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SELECT_FASHION_SCENE, self.onUpdateSceneSelect, self)

    GameDispatcher:addEventListener(EventName.UPDATE_SELECT_FASHION_FIGHT, self.onUpdateFightSelect, self)
    GameDispatcher:addEventListener(EventName.UPDATE_FASHION_COMBO_VIEW, self.showPanel, self)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)

    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    GameDispatcher:removeEventListener(EventName.UPDATE_SELECT_FASHION_COMBO, self.onUpdateComboSelect, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SELECT_FASHION_SCENE, self.onUpdateSceneSelect, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SELECT_FASHION_FIGHT, self.onUpdateFightSelect, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FASHION_COMBO_VIEW, self.showPanel, self)
    self:clearSubShopItem()

    self:clearSelectComboProps()
    self:clearSelectFightProps()
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

    if self.mPaintingLyScroller then
        self.mPaintingLyScroller:CleanAllItem()
    end
    if self.mFightLyScroller then
        self.mFightLyScroller:CleanAllItem()
    end
end

function initViewText(self)
    self:setBtnLabel(self.mBtnFight, 50095)
    self:setBtnLabel(self.mBtnFight_Combo, 50095)
    self:setBtnLabel(self.mBtnSetting, 153008)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnComboBuy, self.onComboBuy)
    self:addUIEvent(self.mBtnSceneBuy, self.onSceneBuy)

    self:addUIEvent(self.mIconSelectHeroHeadBtn, self.onShowSingleHero)
    self:addUIEvent(self.mBtnFight, self.onBigHostelTrial)
    self:addUIEvent(self.mBtnFight_Combo, self.onBigHostelTrial)

    self:addUIEvent(self.mBtnFightPre, self.onFightPre)
    self:addUIEvent(self.mBtnFightBuy, self.onFightBuy)
    self:addUIEvent(self.mBtnSetting, self.onSetting)
end

function onFightPre(self)
    --self.selectSkinId = self.mFightSkinId
    GameDispatcher:dispatchEvent(EventName.OPEN_FIGHT_SKIN_PRE_VIEW, self.mFightSkinId)
end

function onBigHostelTrial(self)
    UIFactory:alertMessge(_TT(50090), true, function()
        if self.selectSceneConfigVo.heroTid == nil then
            local sceneConfigVo = purchase.FashionShopManager:getFashionSceneData(self.selectSceneConfigVo.skinId[1],
                self.selectSceneConfigVo.skinId[2])
            GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_SCENE, {
                model_id = sceneConfigVo.modelId,
                heroTid = self.selectSceneConfigVo.skinId[1],
                main_type = BigHostelConst.SceneUI_Type.TRIAL
            })
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_SCENE, {
                model_id = self.selectSceneConfigVo.modelId,
                heroTid = self.selectSceneConfigVo.heroTid,
                main_type = BigHostelConst.SceneUI_Type.TRIAL
            })
        end

    end, _TT(1), nil, true, nil, _TT(2))
end

function onShowSingleHero(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_ONE_VIEW, {
        heroTid = self.curSelectSceneData.fashionDic[1],
        fashionId = self.curSelectSceneData.fashionDic[2],
        isShow3D = true
    })
end

function onComboBuy(self)
    recharge.sendRecharge(recharge.RechargeType.FASHION_COMBO, nil, self.mComboId)
end

function onSceneBuy(self)
    recharge.sendRecharge(recharge.RechargeType.FASHION_OTHER, nil, self.mSceneId)
end

function onSetting(self)
     GameDispatcher:dispatchEvent(EventName.OPEN_FIGHT_SKIN_PANEL)
end

function onFightBuy(self)
    if self.selectFightInfo:getMoneyTid() == MoneyType.MONEY then
        recharge.sendRecharge(recharge.RechargeType.FASHION_OTHER, nil, self.mFightId)
    else
        local needMoney = self.selectFightInfo:getMoneyCount()
        if (MoneyUtil.getMoneyCountByTid(self.selectFightInfo:getMoneyTid()) < needMoney) then
            UIFactory:alertMessge(_TT(25038, props.PropsManager:getName(self.selectFightInfo:getMoneyTid())), true,
                function()
                    if self.selectFightInfo:getMoneyTid() == MoneyTid.PAY_ITIANIUM_TID then
                        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
                            linkId = LinkCode.Purchase
                        })
                    else
                        GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW, {
                            moneyList = {MoneyTid.PAY_ITIANIUM_TID, MoneyTid.FASHION_TID},
                            ratio = sysParam.SysParamManager:getValue(SysParamType.FASHION_ICAN_CONVERSION_RATIO)
                        })
                    end
      
                end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
            return
        end
        local msgStr = _TT(121194)

        UIFactory:alertMessge(msgStr, true, function()
            GameDispatcher:dispatchEvent(EventName.REQ_FASHION_SHOP_BUY, {
                id = self.selectFightInfo.id,
                isUseDis = 0
            })
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)

    end

    -- recharge.sendRecharge(recharge.RechargeType.FASHION_OTHER, nil, self.mFightId)
end

function showPanel(self)
    self:clearSubShopItem()
    local list = purchase.getFashionShopComboList()
    for k, v in ipairs(list) do
        if funcopen.FuncOpenManager:isOpen(v.funcId, false) then
            local item = SimpleInsItem:create(self.mShopTabChildItem, self.mGroupTabItem, "mFashionShopSub")
            item:getChildGO("mTxtNomal"):GetComponent(ty.Text).text = _TT(v.nomalLanId)
            item:getChildGO("mTxtSelect"):GetComponent(ty.Text).text = _TT(v.nomalLanId)
            -- self:setBtnLabel(item:getChildGO("onClickChildItem"), v.nomalLanId)
            item:addUIEvent("mBtnClick", function()
                self:onClickChildItem(v.page)
            end)
            self.mSubViewItem[v.page] = item
        end
    end

    -- self:updateComboView()
    -- self:updateSceneView()
    -- self:updatePairtsView()
    -- self:updateNomalView()

    self.mLastIndex = purchase.FashionShopManager:getDefOpenFashionType()
    if self.mLastIndex == nil then
        local comboList = purchase.FashionShopManager:getComboShopList()
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FASHION_COMBO, false) and
            (comboList and #comboList > 0) then
            self:onClickChildItem(fashionShop.ShopType.COMBO)
        else
            self:onClickChildItem(fashionShop.ShopType.NOMAL)
        end
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

    if self.mPaintingLyScroller then
        self.mPaintingLyScroller:CleanAllItem()
    end

    if self.mFightLyScroller then
        self.mFightLyScroller:CleanAllItem()
    end

    if index == fashionShop.ShopType.COMBO then
        self:updateComboView()
    elseif index == fashionShop.ShopType.SCENE then
        self:updateSceneView()
    elseif index == fashionShop.ShopType.PAIRTS then
        self:updatePairtsView()
    elseif index == fashionShop.ShopType.NOMAL then
        self:updateNomalView()
    elseif index == fashionShop.ShopType.PAINTING then
        self:updatePaintingView()
    elseif index == fashionShop.ShopType.FIGHTSKIN then
        self:updateFightView()
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
    else
        self.mChildViewDic[fashionShop.ShopType.COMBO]:SetActive(false)
    end
end

function updateFightView(self)
    self.mFightList = purchase.FashionShopManager:getFashionFightSkin()

    table.sort(self.mFightList, function(vo1, vo2)
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

    if self.mFightLyScroller.Count <= 0 then
        self.mFightLyScroller.DataProvider = self.mFightList
    else
        self.mFightLyScroller:ReplaceAllDataProvider(self.mFightList)
    end

    if self.selectSkinId then
        for i = 1, #self.mFightList, 1 do
            if self.mFightList[i].id == self.selectSkinId then
                self:onUpdateFightSelect(self.mFightList[i])
            end
        end
    else
        if self.mFightList[1] then
            self:onUpdateFightSelect(self.mFightList[1])
        end
    end

    self.mChildViewDic[fashionShop.ShopType.FIGHTSKIN]:SetActive(not table.empty(self.mFightList))
end

function updateSceneView(self)
    self.mSceneList = purchase.FashionShopManager:getCurShopList(fashionShop.ShopType.SCENE)
    table.sort(self.mSceneList, function(vo1, vo2)
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
    else
        self.mChildViewDic[fashionShop.ShopType.SCENE]:SetActive(false)
    end
    -- self.mSceneLyScroller:JumpToTop()

end

function onUpdateComboSelect(self, selectData)
    self.mComboId = selectData.id
    for i = 1, #self.mComboList, 1 do
        self.mComboList[i].isSelect = self.mComboList[i].id == selectData.id
    end

    self.mComboLyScroller:ReplaceAllDataProvider(self.mComboList)

    self.mIconSelectCombo:SetImg(UrlManager:getFashionComboPath(selectData.configVo.img), false)

    -- self.mIconSelectCombo:SetImg(UrlManager:getIconPath(selectData.configVo.img))
    self.mTxtSelectComboName.text = _TT(selectData.configVo.name)
    self.mTxtComboCost.text = selectData.cost / 100
    self.mImgScale.gameObject:SetActive(selectData.configVo.scaleOff > 0)
    self.mTxtScleValue.text = string.format("%.1f", selectData.configVo.scaleOff / 100)

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

function onUpdateFightSelect(self, selectData)
    self.mFightId = selectData.id
    self.mFightSkinId = selectData.fashionDic[1]
    for i = 1, #self.mFightList, 1 do
        self.mFightList[i].isSelect = self.mFightList[i].id == selectData.id
    end

    self.mFightLyScroller:ReplaceAllDataProvider(self.mFightList)

    local configVo = role.RoleManager:getFightSkinDataById(selectData.fashionDic[1])
    self.mIconSelectFight:SetImg(UrlManager:getIconPath(configVo.icon), false)

    self.mBtnFightBuy:SetActive(not purchase.FashionShopManager:getFashionSceneOrPairtsIsBuy(selectData.id))
    local payType = selectData:getMoneyTid()
    local textColor = (MoneyUtil.getMoneyCountByTid(selectData:getMoneyTid()) >= selectData:getMoneyCount()) and
                          "000000ff" or "D53529ff"
    if payType == MoneyType.MONEY then
        self.mImgIconFightMoney.gameObject:SetActive(false)
        self.mTxtFightMoney.text = HtmlUtil:color("¥" .. selectData:getMoneyCount() / 100, "000000ff")
    else
        self.mImgIconFightMoney.gameObject:SetActive(true)
        self.mImgIconFightMoney:SetImg(MoneyUtil.getMoneyIconUrlByTid(selectData:getMoneyTid()), true)
        self.mTxtFightMoney.text = HtmlUtil:color(selectData:getMoneyCount(), textColor)
    end

    -- if purchase.FashionShopManager:getFashionSceneOrPairtsIsBuy(selectData.id) then
    --     self.mImgIconFightMoney.gameObject:SetActive(false)
    --     self.mTxtFightMoney.text = _TT(153008)
    -- end
    -- end

    -- self.mIconSelectCombo:SetImg(UrlManager:getIconPath(selectData.configVo.img))
    self.mTxtSelectFightName.text = _TT(configVo.resName)
    -- self.mTxtFightCost.text = selectData.cost / 100
    -- self.mImgScale.gameObject:SetActive(selectData.configVo.scaleOff > 0)
    -- self.mTxtScleValue.text = string.format("%.1f", selectData.configVo.scaleOff / 100)
    self.mImgFightScale.gameObject:SetActive(false)
    self:clearSelectFightProps()
    local goodsList = configVo.unlockList
    for i = 1, #configVo.unlockList, 1 do
        local propsGrid = PropsGrid:createByData({
            tid = configVo.unlockList[i],
            num = 1,
            parent = self.mSelectFightPropsContent,
            scale = 0.55,
            showUseInTip = true
        })
        table.insert(self.mSelectFightProps, propsGrid)
        propsGrid:setHasRec(purchase.FashionShopManager:getFashionSceneOrPairtsIsBuy(selectData.id))
    end

    self.mBtnFightBuy:SetActive(not purchase.FashionShopManager:getFashionSceneOrPairtsIsBuy(selectData.id))
    self.mBtnSetting:SetActive(purchase.FashionShopManager:getFashionSceneOrPairtsIsBuy(selectData.id))
    self.selectFightInfo = selectData
end

function onUpdateSceneSelect(self, selectData)
    self.mSceneId = selectData.id
    for i = 1, #self.mSceneList, 1 do
        self.mSceneList[i].isSelect = self.mSceneList[i].id == selectData.id
    end
    self.mSceneLyScroller:ReplaceAllDataProvider(self.mSceneList)

    self.SceneGroup.gameObject:SetActive(true)
    self.mIconSelectScene:SetImg(UrlManager:getFashionComboPath(selectData.configChildVo.img))

    local propsVo = props.PropsManager:getPropsConfigVo(selectData.configChildVo.itemId)

    self.mTxtSelectSceneName.text = propsVo:getName()
    self.mTxtSceneCost.text = selectData:getMoneyCount() / 100

    local heroVo = hero.HeroManager:getHeroConfigVo(selectData.configChildVo.heroTid)
    self.mTxtSelectSceneHeroName.text = heroVo.name

    local fashionData = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, selectData.fashionDic[1],
        selectData.fashionDic[2])
    self.mIconSelectHeroHead:SetImg(UrlManager:getHeroHeadUrlByModel(fashionData.model), false)

    local isHave = fashion.FashionManager:getHeroFashionHaveInfo(fashion.Type.CLOTHES, selectData.fashionDic[1],
        selectData.fashionDic[2])
    self.mImgHeroHeadHas:SetActive(isHave)
    self.mBtnSceneBuy:SetActive(not purchase.FashionShopManager:getFashionSceneOrPairtsIsBuy(selectData.id))

    self.curSelectSceneData = selectData

    self.selectSceneConfigVo = selectData.configChildVo

    self.mImgSceneScale.gameObject:SetActive(false)
    -- self.mTxtSceneScleValue.text = selectData.configChildVo.scaleOff .. "%"
end

function clearSelectComboProps(self)
    for i = 1, #self.mSelectComboProps, 1 do
        self.mSelectComboProps[i]:poolRecover()
    end
    self.mSelectComboProps = {}
end

function clearSelectFightProps(self)
    for i = 1, #self.mSelectFightProps, 1 do
        self.mSelectFightProps[i]:poolRecover()
    end
    self.mSelectFightProps = {}
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

    self.mChildViewDic[fashionShop.ShopType.PAIRTS]:SetActive(not table.empty(list))
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

    self.mChildViewDic[fashionShop.ShopType.NOMAL]:SetActive(not table.empty(list))
end

function updatePaintingView(self)
    local list = purchase.FashionShopManager:getPaintingList()
    if RefMgr:getSpecialConfig() and sdk.ChannelData:getIsChannelHarmonious(sdk.ChannelData.HAR_LEVEL_2) then
        -- 渠道部分插画不上架
        for i = #list, 1, -1 do
            if list[i].id == 50002 or list[i].id == 50005 then
                table.remove(list, i)
            end
        end
    end

    if self.mPaintingLyScroller.Count <= 0 then
        self.mPaintingLyScroller.DataProvider = list
    else
        self.mPaintingLyScroller:ReplaceAllDataProvider(list)
    end

    self.mChildViewDic[fashionShop.ShopType.PAINTING]:SetActive(not table.empty(list))
end

return _M
