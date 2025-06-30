module("favorable.FavorableGiveView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("favorable/tab/FavorableGiveView.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function setMask(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mGiveItems = {}
    self.mMoreItems = {}
end

function configUI(self)
    -- super.configUI(self)
    self.mLvBg = self:getChildGO("mLvBg")
    self.mImgMax = self:getChildGO("mImgMax")
    self.mMoreBtn = self:getChildGO("mMoreBtn")
    self.mHideBtn = self:getChildGO("mHideBtn")
    self.mMoreInfo = self:getChildGO("mMoreInfo")
    self.mGiveEmpty = self:getChildGO("mGiveEmpty")
    self.mGroupAttr = self:getChildTrans("mGroupAttr")
    self.mBtnGiveProps = self:getChildGO("mBtnGiveProps")
    self.mTitleTxt = self:getChildGO("mTitleTxt"):GetComponent(ty.Text)
    self.mTitleEnTxt = self:getChildGO("mTitleEnTxt"):GetComponent(ty.Text)
    self.mLvBgRect = self:getChildGO("mLvBg"):GetComponent(ty.RectTransform)
    self.mCurrentIcon = self:getChildGO("Icon"):GetComponent(ty.AutoRefImage)
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mCurrentInfoTxt = self:getChildGO("mCurrentInfoTxt"):GetComponent(ty.Text)
    self.mTxtFavorableMax = self:getChildGO("mTxtFavorableMax"):GetComponent(ty.Text)
    self.mGiveCanvasGroup = self:getChildGO("mGivelist"):GetComponent(ty.CanvasGroup)
    self.mCurrentLvLockTxt = self:getChildGO("mCurrentLvLockTxt"):GetComponent(ty.Text)
    self.mGiveScrollView = self:getChildGO("mScrollViewGive"):GetComponent(ty.LyScroller)
    self.mGiveScrollView:SetItemRender(favorable.FavorableGiveItem)
    self.mMoreScrollView = self:getChildGO("mMoreScrollView"):GetComponent(ty.LyScroller)
    self.mMoreScrollView:SetItemRender(favorable.FavorableMoreItem)
    self.mGiveEffect = self:getChildGO("mGive"):GetComponent(ty.Animator)
end
-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_FAVORABLE, self.onUpdateFavorableLv, self)
    GameDispatcher:addEventListener(EventName.UPDATE_HERO_PREVIEW_ALL_ATTR, self.onHerPreviewAttrUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_FAVORABLE_ATTR, self.updateAttr, self)
    hero.HeroManager:addEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.onUpdateHero, self)
    self.mHeroId = hero.HeroManager:getPanelShowHeroId()
    self:updateView()
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self.mMoreInfo:SetActive(false)
    favorable.FavorableManager:initSelectProps()
    GameDispatcher:removeEventListener(EventName.UPDATE_FAVORABLE, self.onUpdateFavorableLv, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HERO_PREVIEW_ALL_ATTR, self.onHerPreviewAttrUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FAVORABLE_ATTR, self.updateAttr, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.onUpdateHero, self)
    favorable.FavorableManager.curHeroId = nil
    if self.mGiveScrollView then
        self.mGiveScrollView:CleanAllItem()
    end
    self:recoverAttrItem()
    -- self:recoverEffectItem()
    self.mEffectNum = 0
end

function initViewText(self)
    self:setBtnLabel(self.mMoreBtn, 41709, "查看全部")
    self:setBtnLabel(self.mHideBtn, 41710, "隐藏全部")
    self.mTxtFavorableMax.text = _TT(1081)--"已达满级"
    self:setBtnLabel(self.mBtnGiveProps, 41711, "赠送礼物")
    self.mTxtEmptyTip.text = _TT(41723)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mMoreBtn, self.onMoreBtnClickHanlder)
    self:addUIEvent(self.mHideBtn, self.onHideBtnClickHanlder)
    self:addUIEvent(self.mBtnGiveProps, self.onGiveBtnClickHandler)
end

-- 英雄预览属性更新
function onHerPreviewAttrUpdateHandler(self, args)
    local previewType = args.previewType
    if (previewType == hero.AllPreviewAttrType.FAVORABLE) then
        local heroId = args.heroId
        if (self.mHeroId == heroId) then
            self:updateAttr()
        end
    end
end

function onUpdateHero(self)
    self.mHeroId = hero.HeroManager:getPanelShowHeroId()
    self:updateView()
end

function onUpdateFavorableLv(self)
    self:updateView()
end

function onHideBtnClickHanlder(self)
    self.mMoreInfo:SetActive(false)
end

function onGiveBtnClickHandler(self)
    if (self.cusHeroVo:checkIsPreData()) then
        return
    end
    local item_list = favorable.FavorableManager:getSelectProps()
    if #item_list == 0 then
        gs.Message.Show(_TT(70103))
        return
    end
    favorable.FavorableManager:setOldHeroVo(self.cusHeroVo)
    GameDispatcher:dispatchEvent(EventName.REQ_FAVORABLE_GIVE, { hero_id = self.mHeroId, item_list = item_list })
    self.mGiveEffect:SetTrigger("show")
    GameDispatcher:dispatchEvent(EventName.RESETGIFT)
    favorable.FavorableManager:initSelectProps()
end

function updateView(self)
    -- 成功后的处理
    favorable.FavorableManager:initSelectProps()
    self.cusHeroVo = hero.HeroManager:getHeroVo(self.mHeroId)
    self.cusHeroVo:checkIsPreData()
    favorable.FavorableManager.curHeroId = self.mHeroId
    self.heroFavorableData = favorable.FavorableManager:getHeroFavorableData(self.cusHeroVo.tid)
    self.favLv = self.cusHeroVo.favorableLevel
    self.favorableData = self.heroFavorableData.favorableData
    self.mMaxLv = sysParam.SysParamManager:getValue(SysParamType.MAX_FAVORABLE_LV)

    if self.favLv >= self.mMaxLv then
        self.mCurrentInfoTxt.text = _TT(41706) -- "-已经是最大等级了-"
        self.mLvBg:SetActive(false)
        -- self.mCurrentIcon.gameObject:SetActive(false)
        self.mGiveCanvasGroup.alpha = 0.4
    else
        self.mCurrentLvLockTxt.text = _TT(41719, self.favLv + 1) ---"亲密度:" .. self.favLv + 1 .. "级解锁"
        self.mLvBg:SetActive(true)
        -- self.mCurrentIcon:SetImg(UrlManager:getPackPath(self.favorableData[self.favLv + 1].icon), false)
        self.mCurrentInfoTxt.text = _TT(self.favorableData[self.favLv + 1].des)
        self.mGiveCanvasGroup.alpha = 1
    end

    self.likeDic = self.heroFavorableData.likegift
    self.likeList = {}
    self.likeAddDic = {}

    self.needExp = 0
    for lv, data in pairs(self.heroFavorableData.favorableData) do
        if lv >= self.cusHeroVo.favorableLevel then
            self.needExp = self.needExp + data.favorableExp
        end
    end
    self.needExp = self.needExp - self.cusHeroVo.favorableExp
    favorable.FavorableManager:setNeedExp(self.needExp)

    local props = bag.BagManager:getPropsListByEffect(UseEffectType.ADD_HERO_FAVORABLE)

    local giftList = {}
    local tempList = {}
    for i, v in ipairs(props) do
        local vo = favorable.FavorableGiveVo.new()
        vo:setData(v.id, v.tid)
        table.insert(tempList, vo)
    end

    table.sort(tempList, self.sortProps)
    for i, vo in ipairs(tempList) do
        vo.tweenId = i
        table.insert(giftList, vo)
    end
    local giftTypeCount = #giftList
    self.mGiveEmpty:SetActive(giftTypeCount <= 0)
    if giftTypeCount == 0 or self.mGiveScrollView.Count ~= giftTypeCount then
        self.mGiveScrollView.DataProvider = giftList
    else
        self.mGiveScrollView:ReplaceAllDataProvider(giftList)
    end

    for i = 1, #self.favorableData do
        self.favorableData[i].cusLv = self.favLv
    end

    self.mMaxLv = sysParam.SysParamManager:getValue(SysParamType.MAX_FAVORABLE_LV)
    if self.favLv == self.mMaxLv then
        self.mBtnGiveProps:SetActive(false)
        self.mImgMax:SetActive(true)
    else
        self.mBtnGiveProps:SetActive(true)
        self.mImgMax:SetActive(false)
    end
    self:updateAttr()
end

function clearGiveItems(self)
    for i = 1, #self.mGiveItems do
        self.mGiveItems[i]:poolRecover()
    end
    self.mGiveItems = {}
end

function clearMoreItems(self)
    for i = 1, #self.mMoreItems do
        self.mMoreItems[i]:poolRecover()
    end
    self.mMoreItems = {}
end

function onMoreBtnClickHanlder(self)
    self.sortList = self:sortList()
    self.mMoreScrollView.DataProvider = self.sortList
    self.mMoreInfo:SetActive(true)
end

function sortProps(vo1, vo2)
    if vo1:getIsLike() == true and vo2:getIsLike() == false then
        return true
    elseif vo1:getIsLike() == false and vo2:getIsLike() == true then
        return false
    else
        if vo1:getIsDislike() == false and vo2:getIsDislike() == true then
            return true
        elseif vo1:getIsDislike() == true and vo2:getIsDislike() == false then
            return false
        else
            if vo1.propsConfigVo.color > vo2.propsConfigVo.color then
                return true
            elseif vo1.propsConfigVo.color < vo2.propsConfigVo.color then
                return false
            end
        end
    end
    return false
end

function sortList(self)
    local retList = {}
    local lastList = {}
    for i = 1, #self.favorableData do
        if (self.favLv >= self.favorableData[i].favorableLevel) then
            table.insert(lastList, self.favorableData[i])
        else
            table.insert(retList, self.favorableData[i])
        end
    end

    for i = 1, #lastList do
        table.insert(retList, lastList[i])
    end
    return retList
end

-- 更新预览属性
function updateAttr(self)
    self:recoverAttrItem()

    local heroVo = hero.HeroManager:getHeroVo(self.mHeroId)
    local attrDic = heroVo:getNowFavorablePreviewAttrDic()
    if (attrDic == nil or table.nums(attrDic) == 0) then
        attrDic = {}
        attrDic[AttConst.ATTACK] = 0
        attrDic[AttConst.HP_MAX] = 0
        attrDic[AttConst.DEFENSE] = 0
    end
    local addAttrList = {}
    local nextAttr = nil
    local targetFavorLv = favorable.FavorableManager:getPreLv()
    self.isShowNextAttr = targetFavorLv - self.favLv > 0
    if (targetFavorLv == 0) then
        -- targetFavorLv = heroVo.favorableLevel + 1
        nextAttr = {}
        nextAttr[AttConst.ATTACK] = 0
        nextAttr[AttConst.HP_MAX] = 0
        nextAttr[AttConst.DEFENSE] = 0
    else
        nextAttr = heroVo:getNowFavorablePreviewAttrDic(targetFavorLv)
    end
    for key, value in pairs(attrDic) do
        local nextValue = nil
        if (nextAttr) then
            nextValue = nextAttr[key]
        end
        local addAttrVo = { key = key, value = value, nextValue = nextValue }
        if (addAttrVo.value >= 0) then
            addAttrVo.value = AttConst.getValueStr(addAttrVo.key, addAttrVo.value)
            addAttrVo.key = AttConst.getName(key)
            if (key == AttConst.ATTACK) then
                table.insert(addAttrList, 1, addAttrVo)
            elseif (key == AttConst.HP_MAX) then
                table.insert(addAttrList, 2, addAttrVo)
            elseif (key == AttConst.DEFENSE) then
                table.insert(addAttrList, 3, addAttrVo)
            end
        end
    end
    if (#addAttrList > 0) then
        for i = 1, #addAttrList do
            if (addAttrList[i]) then
                local item = SimpleInsItem:create(self:getChildGO("GroupAttrItem"), self.mGroupAttr, "FavorableGiveViewAttrItem")
                item:setText("mTxtAttrName", nil, addAttrList[i].key)
                item:setText("mTxtAttrValue", 0, addAttrList[i].value)
                local nextText = item:getChildGO("mTxtAddValue")
                if addAttrList[i].nextValue ~= nil and addAttrList[i].nextValue > 0 and self.isShowNextAttr then
                    item:getChildGO("mTxtAddValue"):SetActive(true)
                    item:setText("mTxtAddValue", 0, addAttrList[i].nextValue)
                else
                    item:getChildGO("mTxtAddValue"):SetActive(false)
                end
                table.insert(self.attrItemList, item)
            end
        end
    end
end

-- 回收项       
function recoverAttrItem(self)
    if self.attrItemList then
        for i, v in pairs(self.attrItemList) do
            v:poolRecover()
        end
    end
    self.attrItemList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]