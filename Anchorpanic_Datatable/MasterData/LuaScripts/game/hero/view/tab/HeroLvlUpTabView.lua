
module("hero.HeroLvlUpTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("hero/tab/HeroLvlUpTab.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mCurHeroId = nil
    self.mCurHeroVo = nil
    self.mIsReadyMilitaryUp = false
    self.mIsLongPress = false
    self.mIsQucikLvlUp = false
    self.mDelayUpdate = nil
    self.mDelayLvUpCost = nil
    self.isUpdate = false
    self.mLvlUpAttrList={}
end

function configUI(self)
    super.configUI(self)
    self.mTxtLvl = self:getChildGO("mTxtLvl"):GetComponent(ty.Text)
    self.mTxtLvLimit = self:getChildGO("mTxtLvLimit"):GetComponent(ty.Text)
    -- self.mTxtMilitaryName = self:getChildGO("mTxtMilitaryName"):GetComponent(ty.Text)
    self.mBtnAward = self:getChildGO("mBtnAward")
    self.mBtnAni = self.mBtnAward:GetComponent(ty.Animator)
    self.mProgressBar = self:getChildGO('mProgressBar'):GetComponent(ty.ProgressBar)
    self.mProgressBar:InitData(4)
    self.mTxtExpPro = self:getChildGO("mTxtExpPro"):GetComponent(ty.Text)
    -- 属性容器
    self.mGroupSpecialAttr = self:getChildGO("mGroupSpecialAttr")
    -- 属性详情按钮
    self.mBtnDetail = self:getChildGO("mBtnDetail")

    -- 当前等级
    self.mGroupCurLvl = self:getChildGO("mGroupCurLvl")
    self.mGroupDoLvlUp = self:getChildGO("mGroupDoLvlUp")
    self.mBtnLvlUp = self:getChildGO("mBtnLvlUp")
    self.mBtnLvlUpRect = self.mBtnLvlUp:GetComponent(ty.RectTransform)
    self.mTxtBtnLvlUpCost = self:getChildGO("mTxtBtnLvlUpCost"):GetComponent(ty.Text)
    self.mImgBtnLvlUpCost = self:getChildGO("mImgBtnLvlUpCost"):GetComponent(ty.AutoRefImage)
    self.mBtnLvlUpTrigger = self:getChildGO("mBtnLvlUp"):GetComponent(ty.LongPressOrClickEventTrigger)
    -- self.mTxtLvUpTip = self:getChildGO("mTxtLvUpTip"):GetComponent(ty.Text)
    -- 快速购买
    self.mTxtQuickLvlUp = self:getChildGO("mTxtQuickLvlUp"):GetComponent(ty.Text)
    self.mImgQuickLvlUp = self:getChildGO("mImgQuickLvlUp"):GetComponent(ty.AutoRefImage)
    -- 最大等级
    self.mGroupMaxLvl = self:getChildGO("mGroupMaxLvl")
    self.mTxtMaxLvlTip = self:getChildGO("mTxtMaxLvlTip"):GetComponent(ty.Text)
    self.mTxtMax = self:getChildGO("mTxtMax")
    self.mBtnQuickLvlUp = self:getChildGO("mBtnQuickLvlUp")

    -- 新增
    self.NameGroup = self:getChildGO("NameGroup")
    self.mBtnEle = self:getChildGO("mEleIcon")
    self.mEleIcon = self.mBtnEle:GetComponent(ty.AutoRefImage)
    self.mTxtEleName = self:getChildGO("mTxtEleName"):GetComponent(ty.Text)
    self.mIconFight = self:getChildGO("mIconFight"):GetComponent(ty.AutoRefImage)
    self.mTxtFight = self:getChildGO("mTxtFight"):GetComponent(ty.Text)
    self.mTxtDefineType = self:getChildGO("mTxtDefineType"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mStartGroup = {}
    for i=1, 6 do
        table.insert(self.mStartGroup, self:getChildGO("mStart" .. i):GetComponent(ty.Image))
    end
    self.mBtnRankUp = self:getChildGO("mBtnRankUp")

    self.mBtnResetExp = self:getChildGO("mBtnResetExp")
    self.mTxtResetExp = self:getChildGO("mTxtResetExp"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    self:clearListener()
    local function _onLongPressHandler()
        self:onClickBtnLvlUpHandler(true)
    end
    self.mBtnLvlUpTrigger.onLongPress:AddListener(_onLongPressHandler)
    local function _onClickHandler()
        self:onClickBtnLvlUpHandler(false)
    end
    self.mBtnLvlUpTrigger.onClick:AddListener(_onClickHandler)
    local function _onPointerUpHandler()
        self:onClickLvlUpCancelHandler()
    end
    self.mBtnLvlUpTrigger.onPointerUp:AddListener(_onPointerUpHandler)
    local function _onPointerExitHandler()
        self:onClickLvlUpCancelHandler()
    end
    self.mBtnLvlUpTrigger.onPointerExit:AddListener(_onPointerExitHandler)
    GameDispatcher:addEventListener(EventName.UPDATE_LVLUP_PANEL, self.onLvlUpUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
        
    hero.HeroManager:addEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.__onPlayUpdateAni, self)
    hero.HeroLvlTargetManager:addEventListener(hero.HeroLvlTargetManager.UPDATE_LVL_TARGET_lIST, self.onHeroLvlTargetUpdateHandler, self)
     -- hero.HeroFlagManager:addEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)

    self.mIsLongPress = false
    self.mIsQucikLvlUp = false
    self.mIsReadyMilitaryUp = false

    local heroId = args.heroId

    -- if self.isUpdate  then 
    --     self:__onPlayUpdateAni()
    -- end
--    if self.isUpdate == false then 
--     self.isUpdate =true
--    end

    self:setData(heroId)
end

function deActive(self)
    super.deActive(self)
    self:clearListener()
    GameDispatcher:removeEventListener(EventName.UPDATE_LVLUP_PANEL, self.onLvlUpUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.__onPlayUpdateAni, self)
    hero.HeroLvlTargetManager:removeEventListener(hero.HeroLvlTargetManager.UPDATE_LVL_TARGET_lIST, self.onHeroLvlTargetUpdateHandler, self)
    -- hero.HeroFlagManager:removeEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)
    RedPointManager:remove(self.mBtnLvlUpRect)
    RedPointManager:remove(self.mBtnAward.transform)
    RedPointManager:remove(self.mBtnRankUp.transform)
    self:recyAllItem()
    self:removeActionTextSn()
    self:removeAllDelay()

    -- self:recyLvlUpItem()
    -- self:recyLvlUpAttrList()

    hero.HeroController:stopCurPlayCVData()
    self.isUpdate = false
end

function clearListener(self)
    self.mBtnLvlUpTrigger.onLongPress:RemoveAllListeners()
    self.mBtnLvlUpTrigger.onClick:RemoveAllListeners()
    self.mBtnLvlUpTrigger.onPointerUp:RemoveAllListeners()
    self.mBtnLvlUpTrigger.onPointerExit:RemoveAllListeners()
end

function removeAllDelay(self)
    if (self.mDelayUpdate) then
        LoopManager:removeFrameByIndex(self.mDelayUpdate)
        self.mDelayUpdate = nil
    end
    if (self.mDelayLvUpCost) then
        LoopManager:removeFrameByIndex(self.mDelayLvUpCost)
        self.mDelayLvUpCost = nil
    end
end

function initViewText(self)
    -- self:setBtnLabel(self.mBtnDetail, 25027, "详情")
    self.mTxtMaxLvlTip.text = _TT(1081) -- "已达满级"
    self:getChildGO("mTxtTitleLv"):GetComponent(ty.Text).text = _TT(1003)  --等级
    
    self:setBtnLabel(self.mBtnLvlUp, 1106, "升级")
    self:setBtnLabel(self.mBtnAward, 48131, "训练目标")

    self.mTxtResetExp.text = _TT(4238)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnDetail, self.onClickBtnDetailHandler)
    self:addUIEvent(self.mBtnQuickLvlUp, self.onClickQuickLvlUpHandler)
    self:addUIEvent(self.mBtnAward, self.onClickAwardHandler)
    self:addUIEvent(self.mBtnEle, self.onOpenEleTip)
    self:addUIEvent(self.NameGroup, self.onOpenFightTip)
    self:addUIEvent(self.mBtnRankUp, self.onOpenRankUp)

    self:addUIEvent(self.mBtnResetExp, self.onClickBtnResetExpHandler)
end

function onClickBtnResetExpHandler(self)
    if self.mCurHeroVo.lvl <= 1 then
        gs.Message.Show(_TT(53707))
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_CS_RESET_HERO_LV_PRE_VIEW, {
        hero_id = self.mCurHeroVo.id
    })
end

-- 选择快速升级
function onClickQuickLvlUpHandler(self)
    self.mIsQucikLvlUp = not self.mIsQucikLvlUp
    self:updateLvlUpBtnState()
    self.mDelayLvUpCost = LoopManager:addFrame(1, 1, self, self.updateLvlUpCost)
end

-- 打开属性详细信息
function onClickBtnDetailHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_ATTR_LIST_PANEL, { heroVo = self.mCurHeroVo })
end

-- 打开战员奖励
function onClickAwardHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_LVL_TARGET_PANEL, { heroId = self.mCurHeroId })
end

function onOpenRankUp(self)
    GameDispatcher:dispatchEvent(EventName.CHANGE_HERO_TAB, true)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_HERO_LVL_TARGET_PANEL, { heroId = self.mCurHeroId })
end

-- 点击升级
function onClickBtnLvlUpHandler(self, isLongPress)
    if (isLongPress) then
        if (not self.m_frameSn) then
            self.m_frameSn = LoopManager:addFrame(1, 0, self, self.__onFramdUpdateHandler)
            self:checkSend()
        end
    else
        self:checkSend()
    end
end

function onOpenFightTip(self)
    TipsFactory:heroEleAndOccTips(1, self.NameGroup.transform)
end

function onOpenEleTip(self)
    TipsFactory:heroEleAndOccTips(2, self.mBtnEle.transform)
end

function __onFramdUpdateHandler(self, deltaTime)
    -- 初始化变量
    if (not self.m_frames) then
        self.m_frames = 0
    end
    if (not self.m_speed) then
        self.m_speed = 0
    end
    if (not self.m_downSec) then
        self.m_downSec = 0
    end
    if (not self.m_isCanSend) then
        self.m_isCanSend = false
    end
    if (not self.m_isReceive) then
        self.m_isReceive = false
    end
    -- 按下时每20帧加1
    -- 1秒后每15帧加1
    -- 2秒后每10帧加1
    self.m_frames = self.m_frames + 1
    self.m_speed = self.m_speed + 1
    if (self.m_frames >= 30) then
        -- 模拟30帧为1秒
        self.m_downSec = self.m_downSec + 1
        self.m_frames = 0
    end

    if (self.m_downSec >= 2 and self.m_speed >= 10) then
        self.m_speed = 0
        self.m_isCanSend = true
    elseif (self.m_downSec >= 1 and self.m_speed >= 15) then
        self.m_speed = 0
        self.m_isCanSend = true
    elseif (self.m_downSec >= 0 and self.m_speed >= 20) then
        self.m_speed = 0
        self.m_isCanSend = true
    end
    -- 达到条件速度和收到服务器响应后发送升级
    if (self.m_isCanSend and self.m_isReceive) then
        self.m_isCanSend = false
        self.m_isReceive = false
        self:checkSend()
    end
end

function checkSend(self)
    if (self.mCurHeroVo.lvl >= self.mCurHeroVo:getMaxMilitaryLvl()) then
        self:onClickLvlUpCancelHandler()
        local maxMilitaryRank = hero.HeroMilitaryRankManager:getMaxMilitaryRankLvl(self.mCurHeroVo.tid)
        if (self.mCurHeroVo.militaryRank >= maxMilitaryRank) then
            -- 军阶已满，且英雄已经升级到最大级了
            gs.Message.Show(_TT(1082)) -- "英雄等级已达到最大级"
        end
    else
        -- 升级
        local propsConfigVo = nil
        local needCount = 0
        local targetLv = 0
        if self.mIsQucikLvlUp then
            -- 一键升级
            propsConfigVo, needCount, goLevel = hero.HeroLvlUpManager:getLvlUpMaxPropsCount(self.mCurHeroVo)
            targetLv = goLevel
        else
            propsConfigVo, needCount = hero.HeroFlagManager:getLvlUpNeedPropsCount(self.mCurHeroVo)
            targetLv = self.mCurHeroVo.lvl + 1
        end

        local isEnough, _ = MoneyUtil.judgeNeedMoneyCountByTid(propsConfigVo.tid, needCount, true, false)
        if (isEnough) then
            self.mIsQucikLvlUp = false
            GameDispatcher:dispatchEvent(EventName.REQ_HERO_LVL_UP, {
                heroId = self.mCurHeroId,
                level = targetLv
            })
        else
            UIFactory:alertMessge(_TT(1155), true,
            function() -- '战员经验不足，是否前往战备演习中获取？'
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
                    linkId = LinkCode.DupExp
                })
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil) -- 确定
        end
    end
end

-- 释放升级按钮
function onClickLvlUpCancelHandler(self)
    if (self.m_frameSn) then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
        self.m_frames = nil
        self.m_speed = nil
        self.m_downSec = nil
        self.m_isCanSend = nil
        self.m_isReceive = nil
    end

    -- 此处的升级按钮有概率会缩小，强制手动还原下大小
    gs.TransQuick:Scale(self.mBtnLvlUpRect, 1, 1, 1)
end

-- 英雄等级更新
function onLvlUpUpdateHandler(self, args)
    local heroId = args.heroId
    if (self.mCurHeroId == heroId) then

        self:removeActionTextSn()
        self.m_frameSnText = LoopManager:addFrame(1, 0, self, self.updateActionText)
        if self.mCurHeroVo.exp == self.mCurHeroVo.maxExp and self.mCurHeroVo.maxExp == 0 then
            self.mProgressBar:SetValue(1, 1, true, false, true, 0.3)
        else
            self.mProgressBar:SetValue(self.mCurHeroVo.exp, self.mCurHeroVo.maxExp, true, false, true, 0.3)
        end
        if (self.mCurHeroVo.exp == 0) then
            self.mEffectSn = LoopManager:addTimer(0.3, 1, self, function()
                self:addEffect("fx_ui_common_shengji", self.mProgressBar.gameObject.transform, 150, 0, nil)
            end)
        end
        self.mDelayUpdate = LoopManager:addFrame(1, 1, self, self.updateView)
    end
    self.m_isReceive = true
end

function onUpdateHeroDetailDataHandler(self, args)
    local heroId = args.heroId
    if (self.mCurHeroId == heroId) then
        self:updateNormalExpBar()
        self.mDelayUpdate = LoopManager:addFrame(1, 1, self, self.updateView)
    end
end
function onHeroLvlTargetUpdateHandler(self, args)
    local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    if (not args.heroTid or args.heroTid == heroVo.tid) then
        self:updateLvlTargetBubbleView()
    end
end

function updateLvlUpBubbleView(self)
    local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local isFlag = hero.HeroFlagManager:isHeroCanMilitaryUp(heroVo)
    if (isFlag) then
        RedPointManager:add(self.mBtnRankUp.transform, nil, 129, 18)
    else
        RedPointManager:remove(self.mBtnRankUp.transform)
    end
end

function updateLvlTargetBubbleView(self)
    local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local targetFlag = hero.HeroFlagManager:isHeroCanRecLvlTarget(heroVo)
    local targetAllFlag = hero.HeroFlagManager:isHeroAllRecLvlTarget(heroVo)
    if (targetFlag) then
        RedPointManager:add(self.mBtnAward.transform, nil, 20, 30)
        self.mBtnAni:ResetTrigger("puv")
        self.mBtnAni:SetTrigger("show")
    else
        RedPointManager:remove(self.mBtnAward.transform)
        self.mBtnAni:SetTrigger("puv")
    end
end

function setData(self, cusHeroId)
    self.mCurHeroId = cusHeroId

    local heroVo = hero.HeroManager:getHeroVo(cusHeroId)
    if (heroVo.m_isPreData) then
        return
    end
    self.mCurHeroVo = heroVo
    self:updateNormalExpBar()
    self.mDelayUpdate = LoopManager:addFrame(1, 1, self, self.updateView)
    -- self:updateView()
    -- self:updateLvlUpBubbleView()
end

function recyAllItem(self)
    if (self.mItemList) then
        for i = 1, #self.mItemList do
            local item = self.mItemList[i]
            item:poolRecover()
        end
    end
    self.mItemList = {}
end

function removeActionTextSn(self)
    if (self.m_frameSnText) then
        LoopManager:removeFrameByIndex(self.m_frameSnText)
        self.m_frameSnText = nil
    end
    if (self.mEffectSn) then
        LoopManager:removeTimerByIndex(self.mEffectSn)
        self.mEffectSn = nil
    end
end

-- 进度条文字相关
function updateActionText(self, deltaTime)
    if (self.mCurHeroVo.exp == self.mCurHeroVo.maxExp and self.mCurHeroVo.maxExp == 0) then -- 0/0
        self.mTxtExpPro.text = _TT(1081)
    else
        self.mTxtExpPro.text = self.mProgressBar.Current .. "/" .. self.mProgressBar.Total
    end
end

function updateNormalExpBar(self)
    if (self.mCurHeroVo == nil) then
        return
    end
    if self.mCurHeroVo.exp == self.mCurHeroVo.maxExp and self.mCurHeroVo.maxExp == 0 then
        self.mProgressBar:SetValue(1, 1, false, false, false, 0.3)
        self.mTxtExpPro.text = _TT(1081)
    else
        self.mProgressBar:SetValue(self.mCurHeroVo.exp, self.mCurHeroVo.maxExp, false, false, false, 0.3)
        self.mTxtExpPro.text = self.mCurHeroVo.exp .. "/" .. self.mCurHeroVo.maxExp
    end
end

function updateView(self)
    self:recyAllItem()
    if not self.showAttrList then
         self.showAttrList = { AttConst.HP_MAX, AttConst.ATTACK, AttConst.DEFENSE, AttConst.SPEED }
    end

    for i = 1, #self.showAttrList do
        local attrKey = self.showAttrList[i]
        if (self.mCurHeroVo.attrDic[attrKey]) then
            local attrVo = {
                key = attrKey,
                value = self.mCurHeroVo.attrDic[attrKey]
            }
            local item = hero.HeroLvlUpAttrItem_1:poolGet()
            item:setData(i, attrVo,i, true)
            item:setParent(self.mGroupSpecialAttr.transform)
            table.insert(self.mItemList, item)
        end
    end
    self.mTxtLvl.text = self.mCurHeroVo.lvl
    -- .. "<size=32>" .. "/" .. self.mCurHeroVo:getMaxMilitaryLvl() .. "</size>"
    self.mTxtLvLimit.text =  self.mCurHeroVo:getMaxMilitaryLvl()
    -- local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.mCurHeroVo.tid,
    -- self.mCurHeroVo.militaryRank)
    -- self.mTxtMilitaryName.text = curMilitaryRankVo:getName()

    self.mEleIcon:SetImg(UrlManager:getHeroEleTypeIconUrl(self.mCurHeroVo.eleType), false)
    local color, txt = hero.getHeroTypeName(self.mCurHeroVo.eleType)
    self.mTxtEleName.text = txt
    self.mTxtEleName.color = gs.ColorUtil.GetColor(color)
    self.mIconFight:SetImg(UrlManager:getHeroJobSmallIconUrl(self.mCurHeroVo.professionType), false)
    self.mTxtFight.text = hero.getProfessionName(self.mCurHeroVo.professionType)
    self.mTxtDefineType.text = hero.getDefineName(self.mCurHeroVo.defineType)
    self.mTxtName.text = self.mCurHeroVo.name
    local initialStar = self.mCurHeroVo.evolutionLvl and self.mCurHeroVo.evolutionLvl or 0
    for i = 1, 6 do
        local color = "5c697aff"
        if i <= initialStar then 
            color = "ffffffff"
        end
        self.mStartGroup[i].color = gs.ColorUtil.GetColor(color)
    end

    self.mGroupDoLvlUp:SetActive(true)
    self.mGroupMaxLvl:SetActive(false)
    -- self.mTxtLvUpTip.gameObject:SetActive(false)
    self.mTxtBtnLvlUpCost.gameObject:SetActive(true)
    self.mImgBtnLvlUpCost.gameObject:SetActive(true)
    self.mTxtMax:SetActive(false)

    self.mBtnRankUp:SetActive(false)
    self.mBtnLvlUp:SetActive(true)
    local maxMilitaryRank = hero.HeroMilitaryRankManager:getMaxMilitaryRankLvl(self.mCurHeroVo.tid)
    local isMaxMilitaryRank = self.mCurHeroVo.militaryRank >= maxMilitaryRank

    if (self.mCurHeroVo.lvl >= self.mCurHeroVo:getMaxMilitaryLvl()) then
        self:onClickLvlUpCancelHandler()
        if (isMaxMilitaryRank) then -- 军阶已满，且英雄已经升级到最大级了
            self.mTxtMax:SetActive(true)
            self.mGroupDoLvlUp:SetActive(false)
            self.mGroupMaxLvl:SetActive(true)
        else
            self.mBtnRankUp:SetActive(true)
            self.mBtnLvlUp:SetActive(false)
            self.mBtnQuickLvlUp:SetActive(false)
        end
    else
        GameDispatcher:dispatchEvent(EventName.CHANGE_HERO_TAB, false)
        local _, needCount = hero.HeroFlagManager:getLvlUpNeedPropsCount(self.mCurHeroVo)
        if (needCount > 0) then
            self.mDelayLvUpCost = LoopManager:addFrame(1, 1, self, self.updateLvlUpCost)
        end
        self:updateLvlUpBtnState()
    end

    -- 等级目标奖励：未上阵的战斗单独还要显示红点，不影响外面
    self:updateLvlTargetBubbleView()
    self:updateGuide()

    if (self.mDelayUpdate) then
        LoopManager:removeFrameByIndex(self.mDelayUpdate)
        self.mDelayUpdate = nil
    end
    self:updateLvlUpBubbleView()
    --self:updateLvlUpHandler()

    self.mBtnResetExp:SetActive(not isMaxMilitaryRank)
end

-- function recyLvlUpAttrList(self)
--     if (self.mLvlUpAttrList) then
--         for k, item in pairs(self.mLvlUpAttrList) do
--             item:destroy()
--             item:poolRecover()
--             item=nil
--         end
--     end
--     self.mLvlUpAttrList = {}
--     if self.mLvlUpUsingItemList then
--         for i = 1, #self.mLvlUpUsingItemList do
--             local item = self.mLvlUpUsingItemList[i]
--             item:poolRecover()
--             item=nil
--         end
--     end

--     self.mLvlUpUsingItemList={}
-- end

-- function recyLvlUpItem(self)
--     if (self.mLvlUpItemDic) then
--         for _, item in pairs(self.mLvlUpItemDic) do
--             local event=item:getChildGO("mBtnAdd"):GetComponent(ty.LongPressOrClickEventTrigger)
--             event.onPointerUp:RemoveAllListeners()
--             event.onLongPress:RemoveAllListeners()
--             item:poolRecover()
--             item=nil
--         end
--     end
--     self.mLvlUpItemDic = {}
-- end

--function updateLvlUpHandler(self)
--     self:recyLvlUpAttrList()
--     self:recyLvlUpItem()
--     --self:resetNumHandler()
--     --self.mTxtShowAddExp.text=""
--     local curExp = self.mCurHeroVo.exp
--     local list={ AttConst.HP_MAX, AttConst.ATTACK, AttConst.DEFENSE}

--    for i = 1, #list do
--        local attrKey = self.showAttrList[i]
--        if (self.mCurHeroVo.attrDic[attrKey]) then
--            local addValueVo = hero.HeroLvlUpManager:getHeroLvlUpAddAllValue(self.mCurHeroVo,self.mCurHeroVo.lvl,attrKey)
--            addValueVo.value=self.mCurHeroVo.basicAttrDic[attrKey]+addValueVo.value
--            local item =self.mLvlUpAttrList[attrKey] or hero.HeroLvlUpAttrItem:poolGet()
--            item:setData(i, addValueVo,i, true,addValueVo)
--            item:setParent(self.mLvUpAttrTrans)
--            self.mLvlUpAttrList[attrKey]=item
--        end
--    end
--     --local needNumDic,costTidDic = hero.HeroLvlUpManager:getLvlUpMaxInfo(self.mCurHeroVo)
--     local costTidDic = hero.HeroLvlUpManager:getLvlUpCostDic()
--     for i, tid in pairs(costTidDic) do
--         if not  self.mNumChangeDic[tid] then
--             self.mNumChangeDic[tid]=0  
--         end
--         local item=SimpleInsItem:create(self.mExpendItem, self.mItemTrans, "LvlUpExpendItem"..i)
--         local propsGrid=PropsGrid:createByData({ tid = tid, num = 0, parent = item:getChildTrans("mTrans"), scale = 1, showUseInTip = true })
--         table.insert(self.mLvlUpUsingItemList,propsGrid)
--         item:getChildGO("mTxtNum"):GetComponent(ty.Text).text = _TT(45013,self.mNumChangeDic[tid],MoneyUtil.getMoneyCountByTid(tid))
--         item:getChildGO("mBtnReduce"):SetActive(false)
--         local curAddExp=hero.HeroLvlUpManager:getCurAddExp(self.mNumChangeDic)
--         local _,isMax=hero.HeroLvlUpManager:getCurLvStateByExp(self.mCurHeroVo,curAddExp)
--         local isCanClick = self.mNumChangeDic[tid]<MoneyUtil.getMoneyCountByTid(tid) and MoneyUtil.getMoneyCountByTid(tid)>0 and not isMax
--         item:getChildGO("mBtnAdd"):SetActive(isCanClick)
--         local function onLongClick()
--             if not self.mTimeSn then
--                 self.mTimeSn = LoopManager:addTimer(0.3,0,self,function()
--                     self:onClickHanlder(tid)
--                 end)
--             end
--         end
--         local function onClear()
--             self:onClearTime()
--         end
--         local event=item:getChildGO("mBtnAdd"):GetComponent(ty.LongPressOrClickEventTrigger)
--         event.onLongPress:AddListener(onLongClick)
--         event.onPointerUp:AddListener(onClear)
--         item:addUIEvent("mBtnAdd",function ()
--             self:onClickHanlder(tid)
--         end)
--         item:addUIEvent("mBtnReduce",function ()
--             if self.mNumChangeDic[tid]>0 then
--                 self.mNumChangeDic[tid]=self.mNumChangeDic[tid]-1
--                 self:updateShowInfo(tid)
--             end
--         end)
--         self.mLvlUpItemDic[tid]=item
--     end
--     self.mTxtLvUpLvl.text = _TT(102001).." "..HtmlUtil:colorAndSize(self.mCurHeroVo.lvl, "ffffffff", 28)
--     self.mTxtLvUpExpPro.text = _TT(45013,curExp,self.mCurHeroVo.maxExp)
--     self.mLvUpBar.fillAmount = curExp / self.mCurHeroVo.maxExp
--     self.mLvUpAddBar.fillAmount = curExp / self.mCurHeroVo.maxExp
--end

function recoverMilitaryAddAttrList(self)
    if (self.mMilitaryAddAttrList) then
        for i = 1, #self.mMilitaryAddAttrList do
            self.mMilitaryAddAttrList[i]:poolRecover()
        end
    end
    self.mMilitaryAddAttrList = {}
end

function updateLvlUpCost(self)
    local propsConfigVo = nil
    local needCount = 0
    local canGoLvl = 0

    propsConfigVo, needCount = hero.HeroFlagManager:getLvlUpNeedPropsCount(self.mCurHeroVo)
    if self.mIsQucikLvlUp then -- 一键升级
        propsConfigVo, needCount, canGoLvl = hero.HeroLvlUpManager:getLvlUpMaxPropsCount(self.mCurHeroVo)
    end
    local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(propsConfigVo.tid, needCount, false, false)
    if (isEnough) then
        self.mTxtBtnLvlUpCost.color = gs.ColorUtil.GetColor("FFFFFFFF")
    else
        self.mTxtBtnLvlUpCost.color = gs.ColorUtil.GetColor("DF1E1EFF")
    end
    self.mImgBtnLvlUpCost:SetImg(UrlManager:getPropsIconUrl(propsConfigVo.tid), false)
    self.mTxtBtnLvlUpCost.text = needCount
    if (self.mDelayLvUpCost) then
        LoopManager:removeFrameByIndex(self.mDelayLvUpCost)
        self.mDelayLvUpCost = nil
    end
end

function updateLvlUpBtnState(self)
    local _, _, canGoLvl = hero.HeroLvlUpManager:getLvlUpMaxPropsCount(self.mCurHeroVo)
    if canGoLvl > 0 and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FAST_LVUP) then
        self.mBtnQuickLvlUp:SetActive(true)
        self.mTxtQuickLvlUp.text = _TT(1107, canGoLvl) -- string.format("升至%s级", canGoLvl)
    else
        self.mBtnQuickLvlUp:SetActive(false)
    end

    if self.mIsQucikLvlUp then
        self.mImgQuickLvlUp:SetImg(UrlManager:getPackPath("common5/common_0017.png"), true)
        self:setBtnLabel(self.mBtnLvlUp, 1106, "一键升级")
    else
        self.mImgQuickLvlUp:SetImg(UrlManager:getPackPath("common5/common_0018.png"), true)
        self:setBtnLabel(self.mBtnLvlUp, 1106, "升级")
    end
end

function updateGuide(self)

    if (self.mCurHeroVo.id == 1) then
        self:setGuideTrans("hero_lvlup_btn_lvlup_" .. self.mCurHeroVo.id, self.mBtnLvlUpRect)
    end
    self:setGuideTrans("hero_lvlup_btn_lvlup", self.mBtnLvlUpRect)

    self:setGuideTrans("hero_lvup_group_max", self.mBtnQuickLvlUp.transform)
end

function __onPlayUpdateAni(self)
    if not self.m_UIObjectAni then 
        self.m_UIObjectAni = self.UIObject:GetComponent(ty.Animator)
    end
    if not gs.GoUtil.IsCompNull(self.m_UIObjectAni) then 
        self.m_UIObjectAni:SetTrigger("show")
    end
end

function __checkNeedPassStage(self)

    local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.mCurHeroVo.tid,
    self.mCurHeroVo.militaryRank)
    if battleMap.MainMapManager:isStagePass(curMilitaryRankVo.stageId) then
        return 0
    end
    return curMilitaryRankVo.stageId
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]