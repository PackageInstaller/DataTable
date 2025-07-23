--[[ 
-----------------------------------------------------
@filename       : FashionShowView
@Description    : 皮肤商店购买界面
@date           : 2023-1-30 14:29:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('purchase.FashionShowView', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('purchase/FashionShowView.prefab')
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52120))
    self:setBg("", false)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mShowId = 0
    self.mFashionVo = nil
    self.mIsFristShowModel = true
    self.mIsShow3D = false
end

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
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.PAY_ITIANIUM_TID })
    GameDispatcher:addEventListener(EventName.UPDATE_SKIN_SHOW, self.updateShow, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SKIN_SHOP_ITEM, self.updateShowState, self)
    GameDispatcher:addEventListener(EventName.UPDATE_HERO_WEAR_FASHION, self.updateShowState, self)
    GameDispatcher:addEventListener(EventName.UPDATE_HERO_FASHION_COLOR, self.updateHeroFashionColor, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateShowState, self)
    if args == nil then
        args = purchase.FashionShopManager:getFashionShowVo()
    end
    self:updateView(args)

    local function onToggle()
        self:toggleChange()
    end
    self.mToggleDynamics.onValueChanged:AddListener(onToggle)

    local function onToggleDisc()
        self:toggleDiscChange()
    end
    self.mToggleDis.onValueChanged:AddListener(onToggleDisc)
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_SKIN_SHOW, self.updateShow, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SKIN_SHOP_ITEM, self.updateShowState, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HERO_WEAR_FASHION, self.updateShowState, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HERO_FASHION_COLOR, self.updateHeroFashionColor, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateShowState, self)
    if (self.mDeltaList) then
        self.mDeltaList:destroy()
        self.mDeltaList = nil
    end
    self:recoverModel(true)
    self.mIsFristShowModel = true
    self.mIsShow3D = false
    purchase.FashionShopManager:setFashionShowVo(nil)
    self.mToggleDynamics.onValueChanged:RemoveAllListeners()
    self.mToggleDis.onValueChanged:RemoveAllListeners()
    purchase.FashionShopManager.isUseDiscount = false
    self.mToggleDis.isOn = false
    self:onClickCloseFashionColor()
    self:recoverFColorItem()
    self:clearSpine()
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
end

function initViewText(self)
    super.initViewText(self)
    self:setBtnLabel(self.mBtnBuy, 9, "购买")
    self:setBtnLabel(self.mBtnHide, 280, "隐藏UI")
    self:setBtnLabel(self.mBtnCanWear, 1334, "穿戴")
    self:setBtnLabel(self.mBtnWearOver, 50036, "已穿戴")
    self:setBtnLabel(self.mBtnFight, 50086, "前往试用")
    self.mTxtDisToggle.text = _TT(121192) --使用打折卡
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBuy, self.onClickBuyHandler)
    self:addUIEvent(self.mBtnHide, self.onClickHideHanler)
    self:addUIEvent(self.mBtnCanWear, self.onClickCanWearHandler)
    self:addUIEvent(self.mBtnWearOver, self.onClickWearOverHandler)
    self:addUIEvent(self.mBtnShow3D, self.onClickOpen3DShowView, nil, true)
    self:addUIEvent(self.mBtnShow, self.onClickOpen3DShowView, nil, false)
    self:addUIEvent(self.mBtnFashionColor, self.onClickShowFashionColor)
    self:addUIEvent(self.mBtnFColorPre, self.onClickCloseFashionColor)
    self:addUIEvent(self.mBtnFColorWeak, self.onClickFColorWear)
    self:addUIEvent(self.mBtnFColorControl, self.onClickFColorControl)
    self:addUIEvent(self.mBtnFight, self.onClickFashionFight)
    -- self:addUIEvent(self.mImgLeft, self.onClickNextHandler, nil, true)
    -- self:addUIEvent(self.mImgRight, self.onClickNextHandler, nil, false)
end


function onClickShowFashionColor(self)
    self.mBtnFColorPre:SetActive(true)
    self.mGroupFColorMenu:SetActive(true)
    self.mModelPlayer:showSiwai()
end

function onClickCloseFashionColor(self)
    self.mBtnFColorPre:SetActive(false)
    self.mGroupFColorMenu:SetActive(false)
    self.mBtnFColorControl:SetActive(false)
    self.mGroupFColorUse:SetActive(false)
    self.mGroupRight:SetActive(true)
end

function getHeroTid(self)
    return self.mFashionVo:getHeroTid()
end

function getFahiondId(self)
    return self.mFashionVo:getFashionId()
end

-- 皮肤试玩
function onClickFashionFight(self)
    -- UIFactory:alertMessge("是否进入皮肤试用关卡？", true, function()
    UIFactory:alertMessge(_TT(50087), true, function()
        fight.FightManager:reqBattleEnter(PreFightBattleType.Fashion_Imitate, self:getHeroTid(), nil, self:getFahiondId())
    end, nil, nil, true)
end

-- 跳转来源
function onClickFColorControl(self)
    if self.mFashionColorBaseVo and self.mFashionColorBaseVo.uicode ~= 0 then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = self.mFashionColorBaseVo.uicode })
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

    local heroId = hero.HeroManager:getHeroIdByTid(self:getHeroTid())
    GameDispatcher:dispatchEvent(EventName.REQ_WEAR_FASHION_COLOR, { heroId = heroId, fashionId = self:getFahiondId(), colorId = self.mSelectColorId })
end


-- 动态切换
function toggleChange(self)
    local isOn = self.mToggleDynamics.isOn
    if not isOn or not self:isShowDynamic() then
        self:clearSpine()
    else
        self:updateShowSpine()
    end
end

-- 折扣卡切换
function toggleDiscChange(self)
    purchase.FashionShopManager.isUseDiscount = self.mToggleDis.isOn
    GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_DISCOUNT)
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
        if spineBgTrans then
            spineBgTrans.gameObject:SetActive(false)
        end
        local spineMaskTrans = self.mSpineGo.transform:Find("mImgMask")
        if spineMaskTrans then
            spineMaskTrans.gameObject:SetActive(false)
        end

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

function updateHeroFashionColor(self, msgVo)
    if msgVo.heroTid == self:getHeroTid() and msgVo.fashionId == self:getFahiondId() then
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

        local heroId = hero.HeroManager:getHeroIdByTid(self:getHeroTid())
        local msgVo = fashion.FashionManager:getHeroFashionColor(self:getHeroTid(), self:getFahiondId())
        local isWear = msgVo.colorId == v.id
        local unlock = table.indexof(msgVo.colorList, v.id) ~= false or v.id == 0
        item:getChildGO("mImgFColorLock"):SetActive(not unlock)
        item:getChildGO("mImgFColorSelect"):SetActive(false)
        item:getChildGO("mImgFColorUse"):SetActive(isWear)
        table.insert(self.mFColorItemList, item)

        item:addUIEvent(nil, function()
            self.mFashionColorBaseVo = v
            self:resetFColorSelect()
            item:getChildGO("mImgFColorSelect"):SetActive(true)

            if self:getFashionIsUnLock() and heroId and heroId ~= 0 then
                self.mGroupRight:SetActive(false)
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
    local heroId = hero.HeroManager:getHeroIdByTid(self:getHeroTid())
    local fashionVo, state = fashion.FashionManager:getHeroFashionVo(self:getFashionType(), heroId, self:getFahiondId())
    if (state == fashion.State.LOCK) then
        return false
    end
    return true
end

function resetFColorSelect(self, selectIndex)
    local list = self:getFashionColorList()
    if not list then
        return
    end
    if self.mFColorItemList then
        for i, item in ipairs(self.mFColorItemList) do
            item:getChildGO("mImgFColorSelect"):SetActive((selectIndex and item:getArgs() == selectIndex))
        end
    end
end

-- 获取该时装的部位配置
function getFashionColorList(self)
    local list = fashion.FashionManager:getFasionColorList(self:getHeroTid(), self:getFahiondId())
    return list
end

function getFashionType(self)
    return fashion.Type.CLOTHES
end

-- 更新是否有显示动态
function updateDynamicState(self)
    self.mImgDynamics:SetActive(self:isShowDynamic())
    self.mBtnFight:SetActive(not self:isShowDynamic()) --正式打开这里
    self:toggleChange()
end

-- 是否有动态
function isShowDynamic(self)
    local funcOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PERMIT) --跟随通行证开放（降低审核风险）
    local dynamicData = hero.HeroInteractManager:getModelIsDynamic(self:getModelId())
    return not self.mIsShow3D and (dynamicData ~= nil) and funcOpen
end

-- 取模型id
function getModelId(self)
    return self.mFashionVo:getFashionModel()
end

function updateView(self, args)
    self.mIsShow3D = args.type == fashionShop.ShopType.FASHIONCOIN
    self.mImgFashionShowBg:SetActive(args.type ~= fashionShop.ShopType.FASHIONCOIN)
    self.mImgBg.gameObject:SetActive(args.type ~= fashionShop.ShopType.FASHIONCOIN)
    local list = purchase.FashionShopManager:getCurShopList(args.type)
    for i, vo in ipairs(list) do
        list[i].isShow = true
    end
    self.mShowId = list[1].id
    self:initDeltaList(list, args.sort)
    self:updateShow(args)
end

function initDeltaList(self, list, initSelect)
    if (not self.mDeltaList) then
        self.mDeltaList = DeltaList.new()
        self.mDeltaList:setFormulaParams(155, 60)
        self.mDeltaList:setTweenParams(0.3, gs.DT.Ease.InSine)
        self.mDeltaList:setViewParams(420.5, 418.5, 200.5, 399.5, true)
        self.mDeltaList:setNode(self.mShowContent, self.mSkinShowItem, self.mEventTrigger, self.mImgLeft, self.mImgRight, false, true)
        self.mDeltaList:setData(list, initSelect, self.mScrollView, purchase.FashionShowItem,
        function(data)
            local showVo = data.itemData
            local item = data.item
            if showVo.id ~= self.mFashionVo.id then
                GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOW, showVo)
            end
        end)
    end
end

function onClickOpen3DShowView(self, isShow3D)
    if self.mIsShow3D == isShow3D then
        return
    end
    if isShow3D then
        self:recoverModel(false)
    end
    self:update3DShow(isShow3D)
end

function update3DShow(self, isShow3D)
    self.mIsShow3D = isShow3D
    if isShow3D and not self.mIsFristShowModel then
        self:updateModelView(self.mFashionVo:getFashionUIModel())
    elseif (not isShow3D and self.mModelPlayer.m_modelView) then
        self.mModelPlayer.m_modelView:clearModel()
    end
    self.mImgFashionShowBg:SetActive((not isShow3D))
    self.mImgBg.gameObject:SetActive((not isShow3D))
    self:getChildGO("mImgShowHero"):SetActive((not isShow3D))
    self:getChildGO("mImgShowHero3D"):SetActive(isShow3D)
    local color1 = (self:getChildGO("mImgShowHero").activeSelf == true) and "404548ff" or "82898Cff"
    local color2 = (self:getChildGO("mImgShowHero3D").activeSelf == true) and "404548ff" or "82898Cff"
    self.mTxtShow.color = gs.ColorUtil.GetColor(color1)
    self.mTxtModel.color = gs.ColorUtil.GetColor(color2)

    if not isShow3D then
        self.mBtnFColorControl:SetActive(false)
    end
    self:updateDynamicState()
    self:updateFashionColorBtn()
end

-- 更新皮肤部件按钮
function updateFashionColorBtn(self)
    local funcOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PERMIT) --跟随通行证开放（降低审核风险）
    local list = self:getFashionColorList()
    self.mBtnFashionColor:SetActive(not (list == nil) and self.mIsShow3D and funcOpen)
    local list = self:getFashionColorList()
    if list then
        GameDispatcher:dispatchEvent(EventName.REQ_LOOK_FASHION_COLOR, { heroTid = self:getHeroTid(), fashionId = self:getFahiondId() })
    end
end

function onClickBuyHandler(self)
    local fashionShopVo = purchase.FashionShopManager:getFashionShopVoByType(purchase.FashionShopManager:getFashionShowVo().type)
    local needMoney = self.mFashionVo:getMoneyCount()
    if self.mToggleDis.isOn and self.mFashionVo:getDiscountCost() > 0 then
        needMoney = self.mFashionVo:getDiscountCost()
    end

    if self.mFashionVo:getMoneyTid() == MoneyType.MONEY then
        recharge.sendRecharge(recharge.RechargeType.FASHION_OTHER, nil, self.mFashionVo.id)
        return
    end

    if (MoneyUtil.getMoneyCountByTid(fashionShopVo:getMoneyTid()) < needMoney) then
        UIFactory:alertMessge(_TT(25038, props.PropsManager:getName(fashionShopVo:getMoneyTid())), true, function()
            if fashionShopVo:getMoneyTid() == MoneyTid.PAY_ITIANIUM_TID then
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Purchase })
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW, { moneyList = { MoneyTid.PAY_ITIANIUM_TID, MoneyTid.FASHION_TID }, ratio = sysParam.SysParamManager:getValue(SysParamType.FASHION_ICAN_CONVERSION_RATIO) })
            end
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
        return
    end

    local isUseDis = 0
    local msgStr = _TT(121194) --"是否确认购买？"
    if self.mFashionVo:getDiscountCost() > 0 then
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
        GameDispatcher:dispatchEvent(EventName.REQ_FASHION_SHOP_BUY, { id = self.mFashionVo.id, isUseDis = isUseDis })
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
end

function onClickWearOverHandler(self)
    if self.mFashionVo:getIsSellOut() then
        if self.mFashionVo:getIsWear() then
            gs.Message.Show(_TT(50036))--已穿戴
            return
        end
    end
end

function onClickCanWearHandler(self)
    if self.mFashionVo:getIsSellOut() then
        if (not self.mFashionVo:getIsGainHero()) then
            gs.Message.Show(_TT(50038))--获得战员后可穿戴
            return
        end
        if not self.mFashionVo:getIsWear() then
            self.mFashionVo:onClickWearHandler()
            return
        end
    end
end

function onClickHideHanler(self)
    if self.mGroupAll.activeSelf == true then
        self.mAni:SetTrigger("show")
        self.mGroupAll:SetActive(false)
        self:setBtnLabel(self.mBtnHide, 281, "显示UI")
        self.mImgHideChange:SetImg(UrlManager:getPackPath("mainui/mainui_6.png"), true)
    else
        self.mAni:SetTrigger("exit")
        self.mGroupAll:SetActive(true)
        self:setBtnLabel(self.mBtnHide, 280, "隐藏UI")
        self.mImgHideChange:SetImg(UrlManager:getPackPath("mainui/mainui_7.png"), true)
    end
    self.base_childGos["mGroupTop"]:SetActive(self.mGroupAll.activeSelf == true)
end

function updateShow(self, args)
    local curFashionData = args
    self.mBtnBuy:SetActive((not curFashionData:getIsSellOut()))
    self.mBtnCanWear:SetActive(((curFashionData:getIsSellOut()) and (not curFashionData:getIsWear())))
    self.mBtnWearOver:SetActive((curFashionData:getIsSellOut() and (curFashionData:getIsWear())))
    local count = bag.BagManager:getPropsCountByTid(PROPS_TID.FASHION_DISCOUNT_CARE)
    self.mImgToggle:SetActive(not curFashionData:getIsSellOut() and curFashionData:getDiscountCost() > 0 and curFashionData:getDiscount() <= 0 and count > 0)
    if curFashionData:getDiscountCost() <= 0 or (curFashionData:getDiscount() > 0 and not curFashionData:getIsSellOut()) or count <= 0 then
        self.mToggleDis.isOn = false
    end
    purchase.FashionShopManager:setFashionShowVo(args)
    self.mFashionVo = curFashionData
    -- self:setFashionSelectIndex(false)
    self.mTxtTopSeries.text = curFashionData:getFashionName()
    self.mTxtHeroSeries.text = curFashionData:getFashionSeries()
    self.mTxtSeriesName.text = curFashionData:getFashionName()
    self.mTxtHeroNameLeft.text = curFashionData:getHeroName()
    self.mImgFashionShow:SetImg(curFashionData:getFashionShowUrl(), true)
    self.mTxtFashionDsc.text = curFashionData:getFashionDsc()
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

function updateShowState(self)
    self:updateShow(self.mFashionVo)
end

-- 更新模型
function updateModelView(self, args)
    if (args) then
        if (self.mIsShow3D or self.mIsFristShowModel) then
            self:recoverModel(false)
            self.mModelPlayer:setModelData(args, false, true, 1, true, MainCityConst.ROLE_MODE_OVERVIEW, nil, self.mModelClicker, true, function()
                if self.mIsFristShowModel then
                    local isFirstShow3D = self.mIsShow3D
                    self:update3DShow(isFirstShow3D)
                    self.mIsFristShowModel = false
                end
                self:resetFColorSelect(0)

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

function recoverModel(self, isResetMaincity)
    self.mModelPlayer:reset(isResetMaincity)
    if self.mHarFrameSn then
        LoopManager:removeFrameByIndex(self.mHarFrameSn)
        self.mHarFrameSn = nil
    end
end

--左移/右移
function onClickNextHandler(self, isLeft)
    --更新下一个数据
    local nextIndex = (isLeft == true) and table.indexof(purchase.FashionShopManager:getFashionsIdList(), self.mShowId) - 1 or table.indexof(purchase.FashionShopManager:getFashionsIdList(), self.mShowId) + 1
    if nextIndex <= 0 or nextIndex > #purchase.FashionShopManager:getCurShopList() then
        nextIndex = (isLeft == true) and nextIndex + 1 or nextIndex - 1
    end
    local nextVo = purchase.FashionShopManager:getCurShopList()[nextIndex]
    GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOW, nextVo)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]