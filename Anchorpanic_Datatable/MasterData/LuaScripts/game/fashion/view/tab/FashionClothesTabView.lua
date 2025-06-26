module("fashion.FashionClothesTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("fashion/tab/FashionClothesTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mCurFashionConfigVo = nil
    self.mIsShow3D = true
end

function configUI(self)
    self.mBtnLast = self:getChildGO("mBtnLast")
    self.mBtnNext = self:getChildGO("mBtnNext")
    self.mBtnWeak = self:getChildGO("mBtnWeak")
    self.mBtnControl = self:getChildGO("mBtnControl")
    self.mBtnBackList = self:getChildGO("mBtnBackList")
    self.mDesContent = self:getChildTrans("mDesContent")
    self.mShowContent = self:getChildTrans("mShowContent")
    self.mScrollViewtTrans = self:getChildTrans("mScrollView")
    self.mDesScrollView = self:getChildTrans("mDesScrollView")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgControl = self.mBtnControl:GetComponent(ty.AutoRefImage)
    self.mTxtTopSeries = self:getChildGO("mTxtTopSeries"):GetComponent(ty.Text)
    self.mTxtSeriesName = self:getChildGO("mTxtSeriesName"):GetComponent(ty.Text)
    self.mTxtHeroSeries = self:getChildGO("mTxtHeroSeries"):GetComponent(ty.Text)
    self.mTxtFashionDsc = self:getChildGO("mTxtFashionDsc"):GetComponent(ty.Text)
    self.mDesScrolSR = self:getChildGO("mDesScrollView"):GetComponent(ty.ScrollRect)
    self.mTxtHeroNameLeft = self:getChildGO("mTxtHeroNameLeft"):GetComponent(ty.Text)
    self.mImgHeroIcon = self:getChildGO("mImgHeroIcon"):GetComponent(ty.AutoRefImage)
    self.mEventTrigger = self:getChildGO("mEventTrigger"):GetComponent(ty.LongPressOrClickEventTrigger)
    -- 时装展示item
    self.mFashionItem = self:getChildGO("mFashionItem")
    self.mClickerArea = self:getChildGO("mClickerArea")
    self.mModelPlayer = ModelScenePlayer.new()

    self.mImgFashionShow = self:getChildGO("mImgFashionShow"):GetComponent(ty.AutoRefImage)
    self.mImgFashionShowBg = self:getChildGO("mImgFashionShowBg")
    self.mBtnShow = self:getChildGO("mBtnShow")
    self.mBtnShow3D = self:getChildGO("mBtnShow3D")
    self.mImgShowHero = self:getChildGO("mImgShowHero")
    self.mImgShowHero3D = self:getChildGO("mImgShowHero3D")
    self.mTxtShow = self:getChildGO("mTxtShow"):GetComponent(ty.Text)
    self.mTxtModel = self:getChildGO("mTxtModel"):GetComponent(ty.Text)

    self.mGroupFashionColor = self:getChildGO("mGroupFashionColor")
    self.mBtnFashionColor = self:getChildGO("mBtnFashionColor")
    self.mBtnFColorPre = self:getChildGO("mBtnFColorPre")
    self.mGroupFColorMenu = self:getChildGO("mGroupFColorMenu")

    self.mImgHideChange = self:getChildGO("mImgHideChange"):GetComponent(ty.AutoRefImage)
    self.mBtnHide = self:getChildGO("mBtnHide")
    self.mGroupUI = self:getChildGO("mGroupUI")

    self.mGroupContent = self:getChildGO("mGroupContent")
    self.mGroupFColorUse = self:getChildGO("mGroupFColorUse")
    self.mBtnFColorWeak = self:getChildGO("mBtnFColorWeak")
    self.mBtnFColorControl = self:getChildGO("mBtnFColorControl")
    self.mFColorStateUsed = self:getChildGO("mFColorStateUsed")

    self.mImgDynamics = self:getChildGO("mImgDynamics")
    self.mToggleDynamics = self:getChildGO("mToggleDynamics"):GetComponent(ty.Toggle)

    self.mBtnBigHostel = self:getChildGO("mBtnBigHostel")
end

function active(self, args)
    super.active(self, args)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_FASHION_PANEL, self.onUpdatePanelHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.updateShopHero, self)
    GameDispatcher:addEventListener(EventName.UPDATE_HERO_FASHION_COLOR, self.updateHeroFashionColor, self)
    hero.HeroManager:addEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.updateShopHero, self)
    hero.HeroFlagManager:addEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.updateBackListBubble, self)
    local heroId = fashion.FashionManager:getHeroId()
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    if not self.mCurFashionConfigVo then
        if (args and args.fashionId) then
            self.mCurFashionConfigVo = fashion.FashionManager:getHeroFashionConfigVo(self:getFashionType(), heroVo.tid, args.fashionId)
        else
            local wearingFashionVo = fashion.FashionManager:getHeroWearingFashionVo(self:getFashionType(), heroId)
            if (wearingFashionVo) then
                self.mCurFashionConfigVo = fashion.FashionManager:getHeroFashionConfigVo(self:getFashionType(), heroVo.tid, wearingFashionVo.fashionId)
            else
                self.mCurFashionConfigVo = fashion.FashionManager:getHeroFashionConfigVoBySort(self:getFashionType(), heroVo.tid, 1)
            end
        end
    end
    self:__updateView()
    self:update3DShow(true)

    local function onToggle()
        self:toggleChange()
    end
    self.mToggleDynamics.onValueChanged:AddListener(onToggle)
    -- self.mBtnLast:SetActive(hero.HeroManager:getPanelShowLastHeroId(heroId) ~= nil)
    -- self.mBtnNext:SetActive(hero.HeroManager:getPanelShowNextHeroId(heroId) ~= nil)
end

function deActive(self)
    super.deActive(self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FASHION_PANEL, self.onUpdatePanelHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.updateShopHero, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HERO_FASHION_COLOR, self.updateHeroFashionColor, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.updateShopHero, self)
    hero.HeroFlagManager:removeEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.updateBackListBubble, self)
    self:recoverModel(true)
    if (self.mDeltaList) then
        self.mDeltaList:destroy()
        self.mDeltaList = nil
    end
    RedPointManager:remove(self.mBtnBackList.transform)
    self:onClickCloseFashionColor()
    self:recoverFColorItem()
    self:clearSpine()
end

function initViewText(self)
    -- self:setBtnLabel(self.mBtnHide, 280, "隐藏UI")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnControl, self.onClickControlHandler)
    self:addUIEvent(self.mBtnHide, self.onClickHideHanler)
    self:addUIEvent(self.mBtnWeak, self.onClickControlHandler)
    self:addUIEvent(self.mBtnBackList, self.onClickBackListHandler)
    self:addUIEvent(self.mBtnShow3D, self.onClickOpen3DShowView, nil, true)
    self:addUIEvent(self.mBtnShow, self.onClickOpen3DShowView, nil, false)
    self:addUIEvent(self.mBtnFashionColor, self.onClickShowFashionColor)
    self:addUIEvent(self.mBtnFColorPre, self.onClickCloseFashionColor)
    self:addUIEvent(self.mBtnFColorWeak, self.onClickFColorWear)
    self:addUIEvent(self.mBtnFColorControl, self.onClickFColorControl)
    self:addUIEvent(self.mBtnBigHostel, self.onClickBigHostel)

    -- self:addUIEvent(self.mBtnNext, self.onClickNextOrLast, nil, true)
    -- self:addUIEvent(self.mBtnLast, self.onClickNextOrLast, nil, false)
end

function onClickHideHanler(self)
    if self.mGroupUI.activeSelf == true then
        self.mGroupUI:SetActive(false)
        -- self:setBtnLabel(self.mBtnHide, 281, "显示UI")
        self.mImgHideChange:SetImg(UrlManager:getPackPath("mainui/mainui_6.png"), true)
    else
        self.mGroupUI:SetActive(true)
        -- self:setBtnLabel(self.mBtnHide, 280, "隐藏UI")
        self.mImgHideChange:SetImg(UrlManager:getPackPath("mainui/mainui_7.png"), true)
    end
    -- self.base_childGos["mGroupTop"]:SetActive(self.mGroupUI.activeSelf == true)
end

function onClickShowFashionColor(self)
    self.mBtnFColorPre:SetActive(true)
    self.mGroupFColorMenu:SetActive(true)
    self.mModelPlayer:showSiwai()
end

function onClickCloseFashionColor(self)
    self.mBtnFColorPre:SetActive(false)
    self.mGroupFColorMenu:SetActive(false)
    self.mGroupContent:SetActive(true)
    self.mGroupFColorUse:SetActive(false)
end

function toggleChange(self)
    local isOn = self.mToggleDynamics.isOn
    if not isOn or not self:isShowDynamic() then
        self:clearSpine()
    else
        self:updateShowSpine()
    end
end

-- 更新显示模型或spine
function updateShowSpine(self)
    self:clearSpine()
    local modelId = self:getModelId()
    if not modelId then
        return
    end

    local onLoadSpineFinish = function(go)
        self.mSpineGo = go

        local spineBgTrans = self.mSpineGo.transform:Find("mGroup/mImgBg")
        spineBgTrans.gameObject:SetActive(false)

        self.mImgFashionShow.gameObject:SetActive(false)
        gs.TransQuick:SetParentOrg(self.mSpineGo.transform, self.mImgFashionShowBg.transform)
    end
    self.mSpineLoadSn = gs.ResMgr:LoadGOAysn(string.format("arts/fx/spine/%s/spine_%s.prefab", modelId, modelId), onLoadSpineFinish)
end

function clearSpine(self)
    if self.mSpineLoadSn and self.mSpineLoadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.mSpineLoadSn)
        self.mSpineLoadSn = nil
    end
    if self.mSpineGo then
        gs.GameObject.Destroy(self.mSpineGo)
        self.mSpineGo = nil
    end
    self.mImgFashionShow.gameObject:SetActive(true)
end

function onClickBigHostel(self)
    local showId = fashion.FashionManager:getHeroId()
    local heroVo = hero.HeroManager:getHeroVo(showId)
    local heroConfigVo = hero.HeroManager:getHeroConfigVo(heroVo.tid)

    GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_SCENE, {model_id = self.mCurFashionConfigVo:getHostelModel(), heroConfigVo = heroConfigVo})
end

-- 跳转来源
function onClickFColorControl(self)
    if self.mFashionColorBaseVo and self.mFashionColorBaseVo.uicode ~= 0 then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = self.mFashionColorBaseVo.uicode})
    else
        gs.Message.Show(_TT(84505))
    end
end

-- 穿戴皮肤部位
function onClickFColorWear(self)
    if not self:getFashionIsUnLock() then
        gs.Message.Show(_TT(84504))
        -- gs.Message.Show("需要获得该时装后才可使用")
        return
    end

    self:onClickCloseFashionColor()

    local heroId = fashion.FashionManager:getHeroId()
    GameDispatcher:dispatchEvent(EventName.REQ_WEAR_FASHION_COLOR, {heroId = heroId, fashionId = self.mCurFashionConfigVo.fashionId, colorId = self.mSelectColorId})
end

function onClickOpen3DShowView(self, isShow3D)
    if self.mIsShow3D == isShow3D then
        return
    end
    self:update3DShow(isShow3D)
end

function updateHeroFashionColor(self, msgVo)
    local heroVo = hero.HeroManager:getHeroVo(fashion.FashionManager:getHeroId())
    if msgVo.heroTid == heroVo.tid and msgVo.fashionId == self.mCurFashionConfigVo.fashionId then
        self:updateFColorItem()
    end
end

-- 皮肤部位更换列表
function updateFColorItem(self)
    self:recoverFColorItem()
    local list = self:getFashionColorList()
    if not list then
        return
    end

    for i, v in ipairs(list) do
        local item = SimpleInsItem:create(self:getChildGO("mGroupFColorItem"), self.mGroupFColorMenu.transform, "FashionClothesTabViewGroupFColorItem")
        item:getChildGO("mImgFColorIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(v.icon), false)
        local heroVo = hero.HeroManager:getHeroVo(fashion.FashionManager:getHeroId())
        local msgVo = fashion.FashionManager:getHeroFashionColor(heroVo.tid, self.mCurFashionConfigVo.fashionId)
        local unlock = table.indexof(msgVo.colorList, v.id) ~= false or v.id == 0
        local isWear = msgVo.colorId == v.id
        item:getChildGO("mImgFColorLock"):SetActive(not unlock)
        item:getChildGO("mImgFColorSelect"):SetActive(false)
        item:getChildGO("mImgFColorUse"):SetActive(isWear)
        table.insert(self.mFColorItemList, item)

        item:addUIEvent(nil, function()
            self.mFashionColorBaseVo = v
            self:resetFColorSelect()
            item:getChildGO("mImgFColorSelect"):SetActive(true)

            if self:getFashionIsUnLock() then
                self.mGroupContent:SetActive(false)
                self.mGroupFColorUse:SetActive(true)
            end

            self.mBtnFColorWeak:SetActive(unlock and not isWear)
            self.mBtnFColorControl:SetActive(not unlock and not isWear)
            self.mFColorStateUsed:SetActive(isWear)

            -- 当前选择的皮肤部位id
            self.mSelectColorId = v.id

            -- 替换材质球预览
            self.mModelPlayer:setMaterial(v.posList, v.materials, v.dissolves)
        end)
    end
end

function recoverFColorItem(self)
    if self.mFColorItemList then
        for k, v in pairs(self.mFColorItemList) do
            v:poolRecover()
        end
    end
    self.mFColorItemList = {}
end

-- 获取皮肤是否解锁
function getFashionIsUnLock(self)
    local fashionVo, state = fashion.FashionManager:getHeroFashionVo(self:getFashionType(), fashion.FashionManager:getHeroId(), self.mCurFashionConfigVo.fashionId)
    if (state == fashion.State.LOCK) then
        return false
    end
    return true
end

function resetFColorSelect(self)
    for i, item in ipairs(self.mFColorItemList) do
        item:getChildGO("mImgFColorSelect"):SetActive(false)
    end
end

function updateBigHostelBtn(self)
    local heroVo = hero.HeroManager:getHeroVo(fashion.FashionManager:getHeroId())
    local sceneData = purchase.FashionShopManager:getFashionSceneDataByModelId(heroVo.tid, self.mCurFashionConfigVo:getHostelModel())
    self.mBtnBigHostel:SetActive(sceneData ~= nil)
end

-- 更新是否有显示动态
function updateDynamicState(self)
    self.mImgDynamics:SetActive(self:isShowDynamic())
    self:toggleChange()
end

-- 是否有动态
function isShowDynamic(self)
    local fashionVo, state = fashion.FashionManager:getHeroFashionVo(self:getFashionType(), fashion.FashionManager:getHeroId(), self.mCurFashionConfigVo.fashionId)
    local dynamicData = hero.HeroInteractManager:getModelIsDynamic(self:getModelId())
    return not self.mIsShow3D and (dynamicData ~= nil and (state ~= fashion.State.LOCK))
end

-- 取模型id
function getModelId(self)
    return self.mCurFashionConfigVo.model
end

function update3DShow(self, isShow3D)
    self.mIsShow3D = isShow3D
    if isShow3D then
        self.mImgFashionShowBg.gameObject:SetActive(false)
    else
        -- self.mModelPlayer.m_modelView:clearModel()
        self.mImgFashionShowBg.gameObject:SetActive(true)
    end
    self:updateModelView()
    self.mImgShowHero:SetActive((not isShow3D))
    self.mImgShowHero3D:SetActive(isShow3D)
    local color1 = (self.mImgShowHero.activeSelf == true) and "404548ff" or "82898Cff"
    local color2 = (self.mImgShowHero3D.activeSelf == true) and "404548ff" or "82898Cff"
    self.mTxtShow.color = gs.ColorUtil.GetColor(color1)
    self.mTxtModel.color = gs.ColorUtil.GetColor(color2)

    local list = self:getFashionColorList()
    self.mGroupFashionColor:SetActive(not (list == nil) and isShow3D)

    self:updateDynamicState()
    self:updateBigHostelBtn()
end

function getFashionType(self)
    return fashion.Type.CLOTHES
end

-- 更新模型
function updateModelView(self)
    self:updateFashionInfo()
    if not self.mCurFashionConfigVo then
        return
    end
    self:recoverModel(false)
    if self.mIsShow3D then
        self.mModelPlayer:setModelData(self.mCurFashionConfigVo:getUIModel(), false, true, 1, true, MainCityConst.ROLE_MODE_OVERVIEW, nil, self.mClickerArea, true, function()

            local data = fashion.FashionManager:getModelHarData(self.mCurFashionConfigVo:getUIModel())
            if (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) and data then
                -- 替换材质球预览
                self.mHarFrameSn = LoopManager:addFrame(1, 1, self, function()
                    self.mModelPlayer:setMaterial(data.pos, data.materials, {})
                end)
            end
        end)
    else
        self.mImgFashionShow:SetImg(UrlManager:getPainImg(self.mCurFashionConfigVo:getUrlBody()), true)
    end
    local list = self:getFashionColorList()
    if list then
        local heroVo = hero.HeroManager:getHeroVo(fashion.FashionManager:getHeroId())
        GameDispatcher:dispatchEvent(EventName.REQ_LOOK_FASHION_COLOR, {heroTid = heroVo.tid, fashionId = self.mCurFashionConfigVo.fashionId})
    end
end

function recoverModel(self, isResetMaincity)
    self.mModelPlayer:reset(isResetMaincity)
    if self.mHarFrameSn then
        LoopManager:removeFrameByIndex(self.mHarFrameSn)
        self.mHarFrameSn = nil
    end
end

function updateFashionInfo(self)
    self.mTxtTopSeries.text = self.mCurFashionConfigVo:getName()
    self.mTxtHeroSeries.text = self.mCurFashionConfigVo:getFashionSeries()
    self.mTxtSeriesName.text = self.mCurFashionConfigVo:getName()
    self.mTxtHeroNameLeft.text = self.mCurFashionConfigVo:getHeroName()
    self.mTxtFashionDsc.text = self.mCurFashionConfigVo:getFashionDsc()
    self:addTimer(0.01, 10, function()
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mDesContent) -- 立即刷新
        local height = self.mDesContent.rect.height <= 240 and (self.mDesContent.rect.height + 11.45) or 240
        gs.TransQuick:SizeDelta02(self.mDesScrollView, height)
        self.mDesScrolSR.vertical = self.mDesContent.rect.height >= 240
        gs.TransQuick:LPosY(self.mDesContent, 0)
        if self.mDesScrolSR.vertical == true then
            self.mDesScrolSR.verticalNormalizedPosition = 1
            self:removeAllTimer()
        end
    end)

    local list = self:getFashionColorList()
    self.mGroupFashionColor:SetActive(not (list == nil) and self.mIsShow3D)
    self:updateDynamicState()
    self:updateBigHostelBtn()
end

-- 获取该时装的部位配置
function getFashionColorList(self)
    local heroVo = hero.HeroManager:getHeroVo(fashion.FashionManager:getHeroId())
    local list = fashion.FashionManager:getFasionColorList(heroVo.tid, self.mCurFashionConfigVo.fashionId)
    return list
end

--function getFashionSource(self, sortIndex)
--    local heroVo = hero.HeroManager:getHeroVo(fashion.FashionManager:getHeroId())
--    local fashionConfigVo = fashion.FashionManager:getHeroFashionConfigVoBySort(self:getFashionType(), heroVo.tid, sortIndex)
--    return UrlManager:getFashionClothesUrl(fashionConfigVo.model)
--end

function onClickNextOrLast(self, isNext)
    local heroId = hero.HeroManager:getPanelShowNextHeroId(hero.HeroManager:getPanelShowHeroId())
    if not isNext then
        heroId = hero.HeroManager:getPanelShowLastHeroId(hero.HeroManager:getPanelShowHeroId())
    end
    hero.HeroManager:setPanelShowHeroId(heroId)
end

function onClickControlHandler(self)
    local curFashionId = self.mCurFashionConfigVo.fashionId
    local _, state = fashion.FashionManager:getHeroFashionVo(self:getFashionType(), fashion.FashionManager:getHeroId(), curFashionId)
    if (state == fashion.State.LOCK) then
        if (bag.BagManager:getPropsCountByTid(self.mCurFashionConfigVo.costTid) > 0) then
            local heroVo = hero.HeroManager:getHeroVo(fashion.FashionManager:getHeroId())
            GameDispatcher:dispatchEvent(EventName.REQ_HERO_FASHION_UNLOCK, {fashionType = self:getFashionType(), heroTid = heroVo.tid, fashionId = curFashionId})
        else
            local fashionShopVo = purchase.FashionShopManager:getFashionShopVoByModel(self.mCurFashionConfigVo.model)
            if fashionShopVo then
                -- GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_VIEW, fashionShopVo)
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.HeroFashionShow, param = fashionShopVo})
                --local linkId = fashionShopVo.type == fashionShop.ShopType.NOMAL and LinkCode.FashionShop or LinkCode.FashionCionShop
                --GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = linkId })
            else
                local propsConfigVo = props.PropsManager:getPropsConfigVo(self.mCurFashionConfigVo.costTid)
                TipsFactory:propsTips({propsVo = propsConfigVo, isShowUseBtn = true}, {rectTransform = nil})
            end
        end
    elseif (state == fashion.State.UNLOCK) then
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_WEAR_FASHION, {fashionType = self:getFashionType(), heroId = fashion.FashionManager:getHeroId(), fashionId = curFashionId})
    end
end

function onBagUpdateHandler(self, args)
    self:__updateView()
end

function onUpdatePanelHandler(self, args)
    if (args.heroId and args.heroId == fashion.FashionManager:getHeroId()) then
        if (args.fashionType == self:getFashionType() and args.fashionId == self.mCurFashionConfigVo.fashionId) then
            self:__updateView()
        end
    else
        self:__updateView()
    end
end

function __updateView(self)
    self:updateFashionShowView()
    self:updateBackListBubble()
end

function updateShopHero(self, args)
    local heroid = 0
    if args and args.heroId then
        heroid = args.heroId
    else
        heroid = hero.HeroManager:getPanelShowHeroId()
    end
    fashion.FashionManager:setHeroId(heroid)
    -- self.mBtnLast:SetActive(hero.HeroManager:getPanelShowLastHeroId(heroid) ~= nil)
    -- self.mBtnNext:SetActive(hero.HeroManager:getPanelShowNextHeroId(heroid) ~= nil)
    local heroVo = hero.HeroManager:getHeroVo(fashion.FashionManager:getHeroId())
    local wearingFashionVo = fashion.FashionManager:getHeroWearingFashionVo(self:getFashionType(), fashion.FashionManager:getHeroId())
    if (wearingFashionVo) then
        self.mCurFashionConfigVo = fashion.FashionManager:getHeroFashionConfigVo(self:getFashionType(), heroVo.tid, wearingFashionVo.fashionId)
    else
        self.mCurFashionConfigVo = fashion.FashionManager:getHeroFashionConfigVoBySort(self:getFashionType(), heroVo.tid, 1)
    end
    self:updateModelView()
    self:updateBackListBubble()
    self:updateFashionShowView()
end

function updateFashionShowView(self)
    local heroVo = hero.HeroManager:getHeroVo(fashion.FashionManager:getHeroId())
    -- if (heroVo.head) then
    --     self.mImgHeroIcon:SetImg(UrlManager:getIconPath(heroVo.head), false)
    -- elseif heroVo.headUrl then
    --     self.mImgHeroIcon:SetImg(heroVo.headUrl, false)
    -- else
    --     self.mImgHeroIcon:SetImg(UrlManager:getHeroHeadUrl(heroVo.tid), false)
    -- end

    self.mImgHeroIcon:SetImg(UrlManager:getHeroHeadUrlByModel(heroVo:getHeroModel()), false)

    self.mTxtName.text = heroVo.name
    local heroFashionDic = fashion.FashionManager:getHeroFashionConfigDic(self:getFashionType(), heroVo.tid)
    local list = {}
    local index = 1
    local selectIndex = 1
    for fashionId, vo in pairs(heroFashionDic) do

        local fashionVo, state = fashion.FashionManager:getHeroFashionVo(self:getFashionType(), fashion.FashionManager:getHeroId(), vo.fashionId)
        if (state ~= fashion.State.LOCK) then
            if self.mCurFashionConfigVo.fashionId == vo.fashionId then
                selectIndex = index
            end
            table.insert(list, vo)
            index = index + 1
        end
    end
    self:initDeltaList(list, selectIndex)
    self:updateBtnView()
end

function initDeltaList(self, list, initSelect)
    if (self.mDeltaList) then
        self.mDeltaList:destroy()
        self.mDeltaList = nil
    end
    if (not self.mDeltaList) then
        self.mDeltaList = DeltaList.new()
        self.mDeltaList:setFormulaParams(155, 60)
        self.mDeltaList:setTweenParams(0.5, gs.DT.Ease.InSine)
        self.mDeltaList:setViewParams(420.5, 418.5, 200.5, 399.5, true)
        self.mDeltaList:setNode(self.mShowContent, self.mFashionItem, self.mEventTrigger, self.mBtnLast, self.mBtnNext, false, true)
        self.mDeltaList:setData(list, initSelect, nil, fashion.FashionItem,
            function(data)
                local showVo = data.itemData
                local oldModel = self.mCurFashionConfigVo:getUIModel()
                self.mCurFashionConfigVo = fashion.FashionManager:getHeroFashionConfigVo(self:getFashionType(), showVo.heroTid, showVo.fashionId)
                if oldModel ~= self.mCurFashionConfigVo:getUIModel() then
                    self:updateBtnView()
                    self:updateModelView()
                end
            end)
        end
    end

    -- 打开英雄选择界面
    function onClickBackListHandler(self)
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_SHOW_SELECT_PANEL, {redType = hero.HeroFlagManager.FLAG_BTN_FASHION_CLOTHES})
    end

    function updateBackListBubble(self)
        if (hero.HeroFlagManager:getAllFlagExceptHero(fashion.FashionManager:getHeroId(), hero.HeroFlagManager.FLAG_BTN_FASHION_CLOTHES)) then
            RedPointManager:add(self.mBtnBackList.transform, nil, -22, 35)
        else
            RedPointManager:remove(self.mBtnBackList.transform)
        end
    end

    function updateBtnView(self)
        local curFashionId = self.mCurFashionConfigVo.fashionId
        local fashionVo, state = fashion.FashionManager:getHeroFashionVo(self:getFashionType(), fashion.FashionManager:getHeroId(), curFashionId)
        self.mBtnControl:SetActive(false)
        self.mBtnWeak:SetActive(false)
        if (state == fashion.State.LOCK) then
            if (bag.BagManager:getPropsCountByTid(self.mCurFashionConfigVo.costTid) > 0) then
                self.mBtnWeak:SetActive(true)
                self:setBtnLabel(self.mBtnWeak, 1080, "解锁")
            else
                self.mBtnControl:SetActive(true)
                self:setBtnLabel(self.mBtnControl, 46508, "获取")
                self.mImgControl:SetImg(UrlManager:getCommon5Path("common_0162.png"), false)
            end
        elseif (state == fashion.State.WEARING) then
            self.mBtnControl:SetActive(false)
            self.mBtnWeak:SetActive(false)
        elseif (state == fashion.State.UNLOCK) then
            self.mBtnWeak:SetActive(true)
            self:setBtnLabel(self.mBtnWeak, 62503, "穿戴")
        end
    end

    return _M

    --[[ 替换语言包自动生成，请勿修改！
]]
