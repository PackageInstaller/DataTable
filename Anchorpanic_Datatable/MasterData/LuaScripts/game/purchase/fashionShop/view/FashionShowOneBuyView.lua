--[[ 
-----------------------------------------------------
@filename       : FashionShowView
@Description    : 单个皮肤展示
@date           : 2023-09-20 14:20:33
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]] module('purchase.FashionShowOneBuyView', Class.impl("game/purchase/fashionShop/view/FashionShowView"))
UIRes = UrlManager:getUIPrefabPath('purchase/FashionShowOneBuyView.prefab')

function configUI(self)
    super.configUI(self)
    self.mBtnBuy = self:getChildGO("mBtnBuy")
    self.mModelPlayer = ModelScenePlayer.new()
    self.mBtnHide = self:getChildGO("mBtnHide")
    self.mImgLeft = self:getChildGO("mImgLeft")
    self.mBtnShow = self:getChildGO("mBtnShow")
    self.mImgRight = self:getChildGO("mImgRight")
    self.mGroupAll = self:getChildGO("mGroupAll")
    self.mBtnShow3D = self:getChildGO("mBtnShow3D")
    self.mBtnCanWear = self:getChildGO("mBtnCanWear")
    self.mNodeTrans = self:getChildTrans("mNodeTrans")
    self.mBtnWearOver = self:getChildGO("mBtnWearOver")
    self.mImgShowHero = self:getChildGO("mImgShowHero")
    self.mAni = self.UIObject:GetComponent(ty.Animator)
    self.mModelClicker = self:getChildGO("mClickerArea")
    self.mDesContent = self:getChildTrans("mDesContent")
    self.mSkinShowItem = self:getChildGO("mSkinShowItem")
    self.mShowContent = self:getChildTrans("mShowContent")
    self.mImgShowHero3D = self:getChildGO("mImgShowHero3D")
    self.mDesScrollView = self:getChildTrans("mDesScrollView")
    self.mScrollViewtTrans = self:getChildTrans("mScrollView")
    self.mImgFashionShowBg = self:getChildGO("mImgFashionShowBg")
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.Image)
    self.mTxtShow = self:getChildGO("mTxtShow"):GetComponent(ty.Text)
    self.mShowContentTransR = self:getChildTrans("mShowContentTransR")
    self.mTxtModel = self:getChildGO("mTxtModel"):GetComponent(ty.Text)
    self.mTxtTopSeries = self:getChildGO("mTxtTopSeries"):GetComponent(ty.Text)
    self.mTxtSeriesName = self:getChildGO("mTxtSeriesName"):GetComponent(ty.Text)
    self.mTxtHeroSeries = self:getChildGO("mTxtHeroSeries"):GetComponent(ty.Text)
    self.mTxtFashionDsc = self:getChildGO("mTxtFashionDsc"):GetComponent(ty.Text)
    self.mTxtHeroNameLeft = self:getChildGO("mTxtHeroNameLeft"):GetComponent(ty.Text)
    self.mDesScrolSR = self:getChildGO("mDesScrollView"):GetComponent(ty.ScrollRect)
    self.mImgHideChange = self:getChildGO("mImgHideChange"):GetComponent(ty.AutoRefImage)
    self.mImgFashionShow = self:getChildGO("mImgFashionShow"):GetComponent(ty.AutoRefImage)
    self.mEventTrigger = self:getChildGO("mEventTrigger"):GetComponent(ty.LongPressOrClickEventTrigger)

    self.mBtnFashionColor = self:getChildGO("mBtnFashionColor")
    self.mBtnFColorPre = self:getChildGO("mBtnFColorPre")
    self.mGroupFColorMenu = self:getChildGO("mGroupFColorMenu")

    self.mGroupFColorUse = self:getChildGO("mGroupFColorUse")
    self.mBtnFColorWeak = self:getChildGO("mBtnFColorWeak")
    self.mBtnFColorControl = self:getChildGO("mBtnFColorControl")
    self.mFColorStateUsed = self:getChildGO("mFColorStateUsed")
    self.mGroupRight = self:getChildGO("mGroupRight")

    self.mImgDynamics = self:getChildGO("mImgDynamics")
    self.mToggleDynamics = self:getChildGO("mToggleDynamics"):GetComponent(ty.Toggle)

    self.mImgToggle = self:getChildGO("mImgToggle")
    self.mTxtDisToggle = self:getChildGO("mTxtDisToggle"):GetComponent(ty.Text)
    self.mToggleDis = self:getChildGO("mToggleDis"):GetComponent(ty.Toggle)

    self.mBtnFight = self:getChildGO("mBtnFight")

    self.mBtnSingleBuy = self:getChildGO("mBtnSingleBuy")
    self.mImgSingleCost = self:getChildGO("mImgSingleCost"):GetComponent(ty.AutoRefImage)
    self.mTxtSingleCost = self:getChildGO("mTxtSingleCost"):GetComponent(ty.Text)
    -- self.mTxtSingleUnlock = self:getChildGO("mTxtSingleUnlock"):GetComponent(ty.Text)

    self.mBtnSingleHas = self:getChildGO("mBtnSingleHas")

    
end

-- 更新是否有显示动态
function updateDynamicState(self)
    self.mImgDynamics:SetActive(false)
    self.mBtnFight:SetActive(false) --正式打开这里
    self:toggleChange()
end

function initViewText(self)
    self:setBtnLabel(self.mBtnSingleHas, 135011, "已拥有")
end

function active(self, args)
    self.mHeroTid = args.heroTid
    self.mFashionId = args.fashionId
    self.mIsShow3D = args.isShow3D
    self.mDefPairtsId = args.defPairtsId
    self.mDefInit = nil
    self.mPairtsFashionVo = args.fashionVo

    

    GameDispatcher:addEventListener(EventName.UPDATE_SKIN_SHOP_ITEM, self.updateShowState, self)
    purchase.FashionShopManager:setFashionShowVo(self.mPairtsFashionVo)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    --self:getChildGO("mGroup"):SetActive(false)
    self.mImgBg.gameObject:SetActive(false)

    -- self.mGroupFashionColor = self:getChildGO("mGroupFashionColor")
    -- self.mGroupFashionColor:SetActive(false)

   

    
    -- self.mTxtSingleUnlock.text = _TT(9)

   

    self:updateView(args)

    self.mBtnFColorPre:SetActive(false)
    self.mBtnFight:SetActive(false)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SKIN_SHOP_ITEM, self.updateShowState, self)
end

function updateShowState(self)
    self:updateView()

    self:updateFashionColorBtn()
    self:updateHeroFashionColor()
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnHide, self.onClickHideHanler)
    self:addUIEvent(self.mBtnShow3D, self.onClickOpen3DShowView, nil, true)
    self:addUIEvent(self.mBtnShow, self.onClickOpen3DShowView, nil, false)
    self:addUIEvent(self.mBtnFashionColor, self.onClickShowFashionColor)
    self:addUIEvent(self.mBtnFColorPre, self.onClickCloseFashionColor)
    self:addUIEvent(self.mBtnFColorControl, self.onClickFColorControl)
    self:addUIEvent(self.mBtnFight, self.onClickFashionFight)

    self:addUIEvent(self.mBtnSingleBuy, self.onClickSingleBuyHandler)
    -- self:addUIEvent(self.mImgLeft, self.onClickNextHandler, nil, true)
    -- self:addUIEvent(self.mImgRight, self.onClickNextHandler, nil, false)
    self:addUIEvent(self.mBtnBuy, self.onClickBuyHandler)
end

function onClickBuyHandler(self)
    --local fashionShopVo = purchase.FashionShopManager:getFashionShopVoByType(purchase.FashionShopManager:getFashionShowVo().type)
    local needMoney = self.mPairtsFashionVo:getMoneyCount()
    if self.mToggleDis.isOn and self.mPairtsFashionVo:getDiscountCost() > 0 then
        needMoney = self.mPairtsFashionVo:getDiscountCost()
    end

    if self.mPairtsFashionVo:getMoneyTid() == MoneyType.MONEY then
        recharge.sendRecharge(recharge.RechargeType.FASHION_OTHER, nil, self.mPairtsFashionVo.id)
        return
    end

    if (MoneyUtil.getMoneyCountByTid(self.mPairtsFashionVo:getMoneyTid()) < needMoney) then
        UIFactory:alertMessge(_TT(25038, props.PropsManager:getName(self.mPairtsFashionVo:getMoneyTid())), true, function()
            if self.mPairtsFashionVo:getMoneyTid() == MoneyTid.PAY_ITIANIUM_TID then
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Purchase })
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW, { moneyList = { MoneyTid.PAY_ITIANIUM_TID, MoneyTid.FASHION_TID }, ratio = sysParam.SysParamManager:getValue(SysParamType.FASHION_ICAN_CONVERSION_RATIO) })
            end
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
        return
    end

    local isUseDis = 0
    local msgStr = _TT(121194) --"是否确认购买？"
    if self.mPairtsFashionVo:getDiscountCost() > 0 then
        isUseDis = self.mToggleDis.isOn == true and 1 or 0 --是否使用打折卡
        if isUseDis == 1 then
            msgStr = _TT(121195) --"是否确认购买？（本次将消耗一张时装打折卡）"

            local count = bag.BagManager:getPropsCountByTid(PROPS_TID.FASHION_DISCOUNT_CARE)
            if count <= 0 then
                gs.Message.Show("当前仓库没有衣装特惠卡，无法使用")
                return
            end
        end
    end
    UIFactory:alertMessge(msgStr, true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_FASHION_SHOP_BUY, { id = self.mPairtsFashionVo.id, isUseDis = isUseDis })
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
end
function onClickSingleBuyHandler(self)
    recharge.sendRecharge(recharge.RechargeType.FASHION_OTHER, nil, self.mPairtsFashionVo.id)
end

function onClickShowFashionColor(self)
    --self.mBtnFColorPre:SetActive(true)
    self.mGroupFColorMenu:SetActive(true)
    self.mModelPlayer:showSiwai()
    self:resetFColorSelect(self.mDefPairtsId == nil and 0 or self.mDefPairtsId)
end

function onClickCloseFashionColor(self)
    -- self.mBtnFColorPre:SetActive(false)
    -- self.mGroupFColorMenu:SetActive(false)
end

function getHeroTid(self)
    return self.mHeroTid
end

function getFahiondId(self)
    return self.mFashionId
end

-- 获取该时装的部位配置
function getFashionColorList(self)
    local list = fashion.FashionManager:getFasionColorList(self:getHeroTid(), self:getFahiondId())
    return list
end

-- 是否有动态
function isShowDynamic(self)
    local dynamicData = hero.HeroInteractManager:getModelIsDynamic(self:getModelId())
    return not self.mIsShow3D and (dynamicData ~= nil)
end

function updateHeroFashionColor(self, msgVo)
    --if msgVo.heroTid == self:getHeroTid() and msgVo.fashionId == self:getFahiondId() then
         self:updateFColorItem()
    --end
end

-- 皮肤部位更换列表
function updateFColorItem(self)
    self:recoverFColorItem()
    local list = self:getFashionColorList()
    if not list then
        return
    end

    for i, v in ipairs(list) do
        local item = SimpleInsItem:create(self:getChildGO("mGroupFColorItem"), self.mGroupFColorMenu.transform,
            "FashionClothesTabViewGroupFColorItem")
        item:getChildGO("mImgFColorIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(v.icon), false)

        local heroId = hero.HeroManager:getHeroIdByTid(self:getHeroTid())
        local msgVo = fashion.FashionManager:getHeroFashionColor(self:getHeroTid(), self:getFahiondId())
        local unlock = table.indexof(msgVo.colorList, v.id) ~= false or v.id == 0
        item:getChildGO("mImgFColorLock"):SetActive(not unlock)

        item:getChildGO("mImgFColorSelect"):SetActive( v.id == self.mDefPairtsId == nil and 0 or self.mDefPairtsId)
        item:getChildGO("mImgFColorUse"):SetActive(false)

        table.insert(self.mFColorItemList, item)

        item:addUIEvent(nil, function()
            self.mFashionColorBaseVo = v
            self:resetFColorSelect()
            item:getChildGO("mImgFColorSelect"):SetActive(true)

            -- 当前选择的皮肤部位id
            self.mSelectColorId = v.id

            -- 替换材质球预览
            self.mModelPlayer:setMaterial(v.posList, v.materials, v.dissolves)
        end)
    end

    if self.mDefPairtsId ~= nil then
        for i = 1, #list do
            if list[i].id == self.mDefPairtsId then

                self:onClickShowFashionColor()
                self.mFashionColorBaseVo = list[i]
                self:resetFColorSelect()
                self.mFColorItemList[i]:getChildGO("mImgFColorSelect"):SetActive(true)
                self.mSelectColorId = self.mDefPairtsId
                self.mModelPlayer:setMaterial(list[i].posList, list[i].materials, list[i].dissolves)
                --self.mDefInit = true
                break
            end
        end

    end
end

-- 获取皮肤是否解锁
function getFashionIsUnLock(self)
    local heroId = hero.HeroManager:getHeroIdByTid(self:getHeroTid())
    local fashionVo, state = fashion.FashionManager:getHeroFashionVo(self:getFashionType(), heroId,
        self.mFashionVo:getFashionId())
    if (state == fashion.State.LOCK) then
        return false
    end
    return true
end

-- 取模型id
function getModelId(self)
    return self.mFashionVo.model
end

function update3DShow(self, isShow3D)
    self.mIsShow3D = isShow3D
    if isShow3D and not self.mIsFristShowModel then
        self:updateModelView(self.mFashionVo:getUIModel())
    elseif not isShow3D then
        self.mModelPlayer.m_modelView:clearModel()
    end
    self.mImgFashionShowBg:SetActive((not isShow3D))
    self:getChildGO("mImgShowHero"):SetActive((not isShow3D))
    self:getChildGO("mImgShowHero3D"):SetActive(isShow3D)
    local color1 = (self:getChildGO("mImgShowHero").activeSelf == true) and "404548ff" or "82898Cff"
    local color2 = (self:getChildGO("mImgShowHero3D").activeSelf == true) and "404548ff" or "82898Cff"
    self.mTxtShow.color = gs.ColorUtil.GetColor(color1)
    self.mTxtModel.color = gs.ColorUtil.GetColor(color2)

    self:updateDynamicState()
    self:updateFashionColorBtn()
end

-- function resetFColorSelect(self, selectIndex)
--     local list = self:getFashionColorList()
--     if not list then
--         return
--     end

--     selectIndex = self.mDefPairtsId == nil and 0 or self.mDefPairtsId
--     if self.mFColorItemList then
--         for i, item in ipairs(self.mFColorItemList) do
--             item.item:getChildGO("mImgFColorSelect"):SetActive((selectIndex and item.paritsId == selectIndex))
--         end
--     end
-- end

-- 更新皮肤部件按钮
function updateFashionColorBtn(self)
    local list = self:getFashionColorList()
    self.mBtnFashionColor:SetActive(not (list == nil) and self.mIsShow3D)
    local list = self:getFashionColorList()
    if list then
        GameDispatcher:dispatchEvent(EventName.REQ_LOOK_FASHION_COLOR, {
            heroTid = self:getHeroTid(),
            fashionId = self:getFahiondId()
        })
    end
end

-- 更新模型
function updateModelView(self, args)
    if (args) then
        if (self.mIsShow3D or self.mIsFristShowModel) then
            self:recoverModel(false)
            self.mModelPlayer:setModelData(args, false, true, 1, true, MainCityConst.ROLE_MODE_OVERVIEW, nil,
                self.mModelClicker, true, function()
                    if self.mIsFristShowModel then
                        local isFirstShow3D = self.mIsShow3D
                        self:update3DShow(isFirstShow3D)
                        self.mIsFristShowModel = false
                    end
                    self:resetFColorSelect(self.mDefPairtsId == nil and 0 or self.mDefPairtsId)

                    local data = fashion.FashionManager:getModelHarData(args)
                    if (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) and data then
                        -- 替换材质球预览
                        self.mHarFrameSn = LoopManager:addFrame(1, 1, self, function()
                            self.mModelPlayer:setMaterial(data.pos, data.materials, {})
                        end)
                    end
                end)
        end
    else
        self:recoverModel(false)
    end
end


function updateShow(self, args)
    local curFashionData = args

    self.mHeroTid = curFashionData.fashionDic[1]
    self.mFashionId = curFashionData.fashionDic[2]
    self.mDefPairtsId = curFashionData.fashionDic[3]

    self.mBtnBuy:SetActive((not curFashionData:getIsSellOut()))
  
    self.mBtnCanWear:SetActive(((curFashionData:getIsSellOut()) and (not curFashionData:getIsWear())))
    self.mBtnWearOver:SetActive((curFashionData:getIsSellOut() and (curFashionData:getIsWear())))
    local count = bag.BagManager:getPropsCountByTid(PROPS_TID.FASHION_DISCOUNT_CARE)
    --self.mImgToggle:SetActive(not curFashionData:getIsSellOut() and curFashionData:getDiscountCost() > 0 and curFashionData:getDiscount() <= 0 and count > 0)
    --self.mImgToggle:SetActive(false)
    if curFashionData:getDiscountCost() <= 0 or (curFashionData:getDiscount() > 0 and not curFashionData:getIsSellOut()) or count <= 0 then
        self.mToggleDis.isOn = false
    end
    --purchase.FashionShopManager:setFashionShowVo(args)
    self.mFashionVo = curFashionData
    -- self:setFashionSelectIndex(false)

    self.colorVo = fashion.FashionManager:getFasionColorVo(self.mPairtsFashionVo.fashionDic[1],self.mPairtsFashionVo.fashionDic[2],self.mPairtsFashionVo.fashionDic[3])
    local propsVo = props.PropsManager:getPropsConfigVo( self.colorVo.costTid)
    self.mTxtSeriesName.text = propsVo:getName()

    self.mTxtTopSeries.text = propsVo:getName()
    self.mTxtHeroSeries.text = curFashionData:getFashionSeries()
    --self.mTxtSeriesName.text = curFashionData:getFashionName()
    self.mTxtHeroNameLeft.text = curFashionData:getHeroName()
    self.mImgFashionShow:SetImg(curFashionData:getFashionShowUrl(), true)
    self.mTxtFashionDsc.text = propsVo:getDes()
    self:updateModelView(curFashionData:getFashionUIModel())
    self.mImgBg.color = gs.ColorUtil.GetColor(curFashionData:getColour())
    self:addTimer(0.01, 10, function()
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mDesContent) -- 立即刷新
        local height = self.mDesContent.rect.height <= 240 and (self.mDesContent.rect.height + 11.45) or 240
        gs.TransQuick:SizeDelta02(self.mDesScrollView, height)
        self.mDesScrolSR.vertical = self.mDesContent.rect.height > 240
        gs.TransQuick:LPosY(self.mDesContent, 0)
        if self.mDesScrolSR.vertical == true then
            self.mDesScrolSR.verticalNormalizedPosition = 1
            self:removeAllTimer()
        end
    end)
    self:updateDynamicState()
    self:updateFashionColorBtn()
end

function updateView(self,args)

    if self.mPairtsFashionVo:getMoneyTid() == MoneyType.MONEY then
        self.mImgSingleCost.gameObject:SetActive(false)
        self.mTxtSingleCost.text = "¥" .. self.mPairtsFashionVo:getMoneyCount() / 100
    else
        self.mTxtSingleCost.text = self.mPairtsFashionVo:getMoneyCount()
        self.mImgSingleCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.mPairtsFashionVo:getMoneyTid()), true)
        self.mImgSingleCost.gameObject:SetActive(true)
    end

    self.mBtnSingleHas:SetActive(self.mPairtsFashionVo:getIsSellOut())
    self.mBtnSingleBuy:SetActive(false)

    self.mBtnBuy:SetActive((not self.mPairtsFashionVo:getIsSellOut()))
    --self.mBtnBuy:SetActive(false)
    self.mImgToggle:SetActive(false)

    self.mImgFashionShowBg:SetActive((not self.mIsShow3D))

    self.mFashionVo = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, self:getHeroTid(),
        self:getFahiondId())
    self.mTxtHeroSeries.text = self.mFashionVo:getFashionSeries()

    self.colorVo = fashion.FashionManager:getFasionColorVo(self.mPairtsFashionVo.fashionDic[1],self.mPairtsFashionVo.fashionDic[2],self.mPairtsFashionVo.fashionDic[3])
    local propsVo = props.PropsManager:getPropsConfigVo(self.colorVo.costTid)
    self.mTxtSeriesName.text = propsVo:getName()
    self.mTxtTopSeries.text = propsVo:getName()
    --self.mTxtSeriesName.text = self.mFashionVo:getName()
    self.mTxtHeroNameLeft.text = self.mFashionVo:getHeroName()
    self.mImgFashionShow:SetImg(UrlManager:getPainImg(self.mFashionVo:getUrlBody()), true)
    self.mTxtFashionDsc.text = propsVo:getDes()
    self:updateModelView(self.mFashionVo:getUIModel())
    self:addTimer(0.01, 10, function()
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mDesContent) -- 立即刷新
        local height = self.mDesContent.rect.height <= 240 and (self.mDesContent.rect.height + 11.45) or 240
        gs.TransQuick:SizeDelta02(self.mDesScrollView, height)
        self.mDesScrolSR.vertical = self.mDesContent.rect.height > 240
        gs.TransQuick:LPosY(self.mDesContent, 0)
        if self.mDesScrolSR.vertical == true then
            self.mDesScrolSR.verticalNormalizedPosition = 1
            self:removeAllTimer()
        end
    end)

    local list = purchase.FashionShopManager:getCurShopList(fashionShop.ShopType.PAIRTS)
    for i, vo in ipairs(list) do
        list[i].isShow = true
    end

    local onlyList = {}
    --self.mShowId = list[1].id
    for i = 1, #list, 1 do
        if list[i].id == self.mPairtsFashionVo.id then
            table.insert(onlyList,list[i])
            self.mShowId = i
        end
    end
    --self.mPairtsFashionVo.id
    self:initDeltaList(onlyList)
end

-- function recoverFColorItem(self)
--     if self.mFColorItemList then
--         for k, v in pairs(self.mFColorItemList) do
--             v.item:poolRecover()
--         end
--     end
--     self.mFColorItemList = {}
-- end

function initDeltaList(self, list, initSelect)
    if (not self.mDeltaList) then
        self.mDeltaList = DeltaList.new()
        self.mDeltaList:setFormulaParams(155, 60)
        self.mDeltaList:setTweenParams(0.3, gs.DT.Ease.InSine)
        self.mDeltaList:setViewParams(420.5, 418.5, 200.5, 399.5, true)
        self.mDeltaList:setNode(self.mShowContent, self.mSkinShowItem, self.mEventTrigger, self.mImgLeft, self.mImgRight, false, true)
        self.mDeltaList:setData(list, initSelect, self.mScrollView, purchase.FashionPairtsShowItem,
        function(data)
            local showVo = data.itemData
            local item = data.item
            if showVo.id ~= self.mFashionVo.id then
                GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOW, showVo)
            end
        end)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
