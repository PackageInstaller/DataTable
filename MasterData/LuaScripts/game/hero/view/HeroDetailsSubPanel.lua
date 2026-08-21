module("hero.HeroDetailsSubPanel", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("hero/HeroDetailsPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(0, 0)
    -- self:setTxtTitle(_TT(70004))
    -- self:setBg("hero5_bg_4.png", false, "hero5")
end

--只适配按钮
function getAdaptaTrans(self)
    return self:getChildGO("mGroupTop")
end

-- 初始化数据
function initData(self)
    self.curHeroTid = nil
    self.mPropGrid = nil
    self.mReuseItemList = {}
end

function configUI(self)
    self.mBtnCvZh = self:getChildGO("mBtnCvZh")
    self.mBtnCvJp = self:getChildGO("mBtnCvJp")
    self.mBtnMass = self:getChildGO("mBtnMass")
    self.mGroupReuse = self:getChildGO("mGroupReuse")
    self.mGroupMass = self:getChildGO("mGroupMass")
    self.mScrollContent = self:getChildTrans("mContent")
    self.mEffectTrans = self:getChildTrans("mEffectTrans")
    self.mImgMassTrans = self:getChildTrans("mImgMassTrans")
    self.mGroupEleAndOcc = self:getChildTrans("mGroupEleAndOcc")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtCvZh = self:getChildGO("mTxtCvZh"):GetComponent(ty.Text)
    self.mTxtCvJp = self:getChildGO("mTxtCvJp"):GetComponent(ty.Text)
    self.mTxtWeight = self:getChildGO("mTxtWeight"):GetComponent(ty.Text)
    self.mTxtHeight = self:getChildGO("mTxtHeight"):GetComponent(ty.Text)
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.Text)
    self.mTxtBtnMass = self:getChildGO("mTxtBtnMass"):GetComponent(ty.Text)
    self.mTxtMassNum = self:getChildGO("mTxtMassNum"):GetComponent(ty.Text)
    self.mImgCvZh = self:getChildGO("mImgCvZh"):GetComponent(ty.AutoRefImage)
    self.mTxtHeightDec = self:getChildGO("mTxtHeightDec"):GetComponent(ty.Text)
    self.mTxtWeightDec = self:getChildGO("mTxtWeightDec"):GetComponent(ty.Text)
    self.mImgColor_1 = self:getChildGO("mImgColor_1"):GetComponent(ty.AutoRefImage)
    self.mImgColor_2 = self:getChildGO("mImgColor_2"):GetComponent(ty.AutoRefImage)
end

function active(self, args)
    super.active(self, args)
    self.curCvImgNum = 0--当前关闭CV的图片后缀
    self.isShutView = 1--是否关闭页面  若关闭则为nil
    self.isShutCv = false
    self.isNoMass = args.isNoMass

    self:setData(args.heroId, args.heroTid)
    self:setCvBtnState(0)
    GameDispatcher:addEventListener(EventName.CHANGE_SHOW_HERO, self.onChangeHero, self)
end

function deActive(self)
    super.deActive(self)
    LoopManager:removeTimer(self, self.updateShutCvImg)
    LoopManager:removeTimer(self, self.updateOpenCvImg)
    self.isShutView = nil
    if self.mPropGrid then
        self.mPropGrid:poolRecover()
        self.mPropGrid = nil
    end

    GameDispatcher:removeEventListener(EventName.CHANGE_SHOW_HERO, self.onChangeHero, self)
    self:stopCVAudio()
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCvZh, self.onClickZhVoiceHandler)
    self:addUIEvent(self.mBtnMass, self.onClickMassHandler)
    self:addUIEvent(self:getChildGO("mBtnFragment"), self.onClickFragmentHandler)
end

function onClickCloseHandler(self)
    self.onClickClose(self)
end

function onChangeHero(self, args)
    local heroId = args.heroId
    local heroTid = args.heroTid
    local buttonState = args.state
    self:setData(heroId, heroTid)
    self:setCvBtnState(buttonState)
end

-- 停止cv播放
function stopCVAudio(self)
    if (self.isPlayIng) then
    end
    self.isPlayIng = false
    self.isShutCv = false
end
--中配cv
function onClickZhVoiceHandler(self)
    if self.isPlayIng then
        return
    end
    if self.curHeroVo.zhCVId == 5 then
        gs.Message.Show(_TT(1021))
        return
    end
    self.isPlayIng = true
    self.isShutCv = true
    self:setCvBtnState(1)
    AudioManager:playHeroCV(self.curHeroVo.zhCVId, function()
        if (self.isShutView and self.isShutCv) then
            self:setCvBtnState(0)
            self.isShutCv = false
        end
        self.isPlayIng = false
    end)
end
--日配cv
function onClickJpVoiceHandler(self)
    if self.isPlayIngJP then
        return
    end
    if self.curHeroVo.jpCVId == 0 then
        gs.Message.Show(_TT(1021))
        return
    end
    self.isPlayIngJP = true
    self.isShutCv = false
    self.mBtnCvJp:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("hero5/hero5_2_3.png"), false)
    self.mTxtCvJp.color = gs.ColorUtil.GetColor("76fdffff")
    AudioManager:playHeroCV(self.curHeroVo.zhCVId, function()
        if (self.isShutView and self.isShutCv == false) then
            self.mBtnCvJp:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("hero5/hero5_3_3.png"), false)
            self.mTxtCvJp.color = gs.ColorUtil.GetColor("ffffffff")
        end
        self.isPlayIngJP = false
    end)
end

--集结
function onClickMassHandler(self)
    local isCanUnLock = hero.HeroFlagManager:isHeroCanUnLock(self.curHeroVo)
    if (isCanUnLock) then
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_FRAGMENT_COMPOSE, { heroTid = self.curHeroVo.tid })
    else
        gs.Message.Show(_TT(4306))
    end
end

--更新集结状态
function updateMass(self, heroTid)
    if hero.HeroManager:getIsObtain(heroTid) or self.isNoMass then
        self.mGroupMass:SetActive(false)
        return
    else
        self.mGroupMass:SetActive(true)
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(heroTid)
        local hasCount = bag.BagManager:getPropsCountByTid(heroConfigVo.needFragment[1])
        local needCount = heroConfigVo.needFragment[2]
        self.mTxtMassNum.text = HtmlUtil:color(hasCount, hasCount >= needCount and "f05009ff" or ColorUtil.RED_NUM) .. "/" .. needCount
        local btnTxtColor = hasCount >= needCount and "202226ff" or "202226ff"
        self.mTxtBtnMass.text = HtmlUtil:color("集结", btnTxtColor)
        return
    end
end

function setData(self, cusHeroId, cusHeroTid)
    self.curHeroId = cusHeroId
    self.curHeroTid = cusHeroTid
    if (cusHeroId == nil) then
        self.curHeroVo = hero.HeroManager:getHeroConfigVo(self.curHeroTid)
    else
        self.curHeroVo = hero.HeroManager:getHeroVo(self.curHeroId)
    end
    self:updateView()
    logInfo("当前战员Tid" .. self.curHeroTid)
    self:updateMass(self.curHeroTid)
end

function updateView(self)
    self:removeEffect()
    self:removeReuseItemList()
    if (self.curHeroVo) then
        if self.mPropGrid then
            self.mPropGrid:poolRecover()
            self.mPropGrid = nil
        end
        local heroVo = hero.HeroManager:getHeroConfigVo(self.curHeroTid)
        -- self:addEffect("fx_ui_hero_show_0" .. self.curHeroVo.color, self.mEffectTrans, 0, 0, nil)
        self.mTxtName.text = self.curHeroVo.name
        self.mPropGrid = PropsGrid:create(self.mImgMassTrans, { self.curHeroVo.needFragment[1], 1 }, 0.4)
        self.mPropGrid:setShowColorBgState(false)
        self.mImgColor_1.color = gs.ColorUtil.GetColor(ColorUtil:getPropColor(self.curHeroVo.color))
        self.mImgColor_2.color = gs.ColorUtil.GetColor(ColorUtil:getPropColor(self.curHeroVo.color))
        self.mTxtCvZh.text = _TT(1015, self.curHeroVo.zhCVName)--"中：" .. self.curHeroVo.zhCVName
        self.mTxtCvJp.text = _TT(1016, self.curHeroVo.jpCVName)--"日：" .. self.curHeroVo.jpCVName
        self.mTxtHeightDec.text = _TT(1017)--身高
        self.mTxtWeightDec.text = _TT(1018)--体重
        self.mTxtHeight.text = self.curHeroVo.stature--"身高"
        self.mTxtWeight.text = self.curHeroVo.weight--"体重"
        self.mScrollContent.anchoredPosition = gs.Vector2.zero
        self.mTxtContent.text = self.curHeroVo.life
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mScrollContent)--立即刷新
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtContent:GetComponent(ty.RectTransform))--立即刷新

        if heroVo.professionType ~= nil then
            local occItem = SimpleInsItem:create(self.mGroupReuse, self.mGroupEleAndOcc, "occReuseItem")
            occItem:getChildGO("mIconReuse"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getMonsterJobSmallIconUrl(heroVo.professionType), true)
            occItem:getChildGO("mName"):GetComponent(ty.Text).text = hero.getProfessionName(heroVo.professionType)
            occItem:addUIEvent("mIconReuse", function()
                TipsFactory:heroEleAndOccTips(1, occItem:getTrans())
            end)
            table.insert(self.mReuseItemList, occItem)
        end
        if heroVo.eleType ~= -1 then
            local eleItem = SimpleInsItem:create(self.mGroupReuse, self.mGroupEleAndOcc, "eleReuseItem")
            local color, name = hero.getHeroTypeName(heroVo.eleType)
            eleItem:getChildGO("mIconReuse"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl(heroVo.eleType), true)
            eleItem:getChildGO("mName"):GetComponent(ty.Text).text = name
            eleItem:addUIEvent("mIconReuse", function()
                TipsFactory:heroEleAndOccTips(2, eleItem:getTrans())
            end)
            table.insert(self.mReuseItemList, eleItem)
        end
    end
end

--关闭Cv
function updateShutCvImg(self)
    if self.isShutView then
        if self.curCvImgNum == 3 then
            self.curCvImgNum = 0
        end
        self.curCvImgNum = self.curCvImgNum + 1
        self.mImgCvZh:SetImg(UrlManager:getPackPath("hero5/hero_3_" .. self.curCvImgNum .. ".png"), false)
    end
end
--开启Cv
function updateOpenCvImg(self)
    if self.isShutView then
        if self.curCvImgNum == 3 then
            self.curCvImgNum = 0
        end
        self.curCvImgNum = self.curCvImgNum + 1
        self.mImgCvZh:SetImg(UrlManager:getPackPath("hero5/hero_2_" .. self.curCvImgNum .. ".png"), false)
    end
end
--切换当前按钮状态  0:无语音播放 1：语音播放
function setCvBtnState(self, state)
    LoopManager:removeTimer(self, self.updateOpenCvImg)
    LoopManager:removeTimer(self, self.updateShutCvImg)
    if state == 0 then
        self.mTxtCvZh.color = gs.ColorUtil.GetColor("202226ff")
        self:updateShutCvImg()
        LoopManager:addTimer(0.5, 0, self, self.updateShutCvImg)
    elseif state == 1 then
        self:updateOpenCvImg()
        LoopManager:addTimer(0.5, 0, self, self.updateOpenCvImg)
        self.mTxtCvZh.color = gs.ColorUtil.GetColor("202226ff")
    end
end

function removeReuseItemList(self)
    if #self.mReuseItemList > 0 then
        for _, item in ipairs(self.mReuseItemList) do
            item:poolRecover()
            item = nil
        end
        self.mReuseItemList = {}
    end
end

function onClickFragmentHandler(self)
    local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.curHeroVo.tid)
    local propVo = props.PropsManager:getPropsConfigVo(heroConfigVo.needFragment[1])
    TipsFactory:propsTips({ propsVo = propVo, isShowUseBtn = true }, { rectTransform = self:getChildTrans("mBtnFragment") })
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]