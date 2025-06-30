--[[ 
-----------------------------------------------------
@filename       : DupChipInfoView
@Description    : 芯片副本页面
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('dup.DupChipInfoView', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('dupEquip/DupChipInfoView.prefab')
destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1624, 750)
    self:setBg("dup_resources_1.jpg", false, "dup5")
    self:setTxtTitle(_TT(52113))
    self:setUICode(LinkCode.DupEquip)
end

--析构函数
function dtor(self)
end

function initData(self)
    self.mData = nil
    self.mDupList = {}
    -- 控制播放动画的顺序
    self.mShowIndex = 0
    self.mRefreshDay = os.date('*t', GameManager:getClientTime()).wday
    self.mDupType = 0
    self.mCurDupType = 0
    self.mDupData = nil
    self.mLevelData = nil
    self.mEletemList = {}
    self.mSuitItemList = {}
    self.mPropGridList = {}
    self.mAwardItemList = {}
    self.fightNeedMultiple = 1
    self.mSuitPropGridList = {}
    self.mSuitAwardItemList = {}
    self.mAwardPropGridList = {}
    self.mMainitemDic = {}
    self.mMainitemList = {}
    self.mMultiStorageKey = "DupChipMultiKey"
    self.mMultiNum = sysParam.SysParamManager:getValue(SysParamType.DUP_CHIP_MULTI)
end

function configUI(self)
    self.mImgBtn = self:getChildGO("mImgBtn")
    self.mBtnSuit = self:getChildGO("mBtnSuit")
    self.mImgMesh = self:getChildGO("mImgMesh")
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mGroupRight = self:getChildGO("mGroupRight")
    self.mGroupType = self:getChildTrans("mGroupType")
    self.mMoneyItem = self:getChildTrans("mMoneyItem")
    self.mBtnSuitInfo = self:getChildGO("mBtnSuitInfo")
    self.mBtnLockAward = self:getChildGO("mBtnLockAward")
    self.mSuitContent = self:getChildTrans("mSuitContent")
    self.mBtnCheckEnemy = self:getChildGO("mBtnCheckEnemy")
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mFightContent = self:getChildTrans("mFightContent")
    self.mLyScrollerTrans = self:getChildTrans("LyScroller")
    self.mScrollViewMain = self:getChildTrans("mScrollViewMain")
    self.mGorpLevelAward = self:getChildTrans("mGorpLevelAward")
    self.mAwardGridTrans = self:getChildTrans("mAwardGridTrans")
    self.mGroupSuitInfoTips = self:getChildGO("mGroupSuitInfoTips")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtAwardDec = self:getChildGO('mTxtAwardDec'):GetComponent(ty.Text)
    self.mGroupRightAni = self:getChildGO("mGroupRight"):GetComponent(ty.Animator)
    self.mTxtChipSuitName = self:getChildGO("mTxtChipSuitName"):GetComponent(ty.Text)
    self.mTxtFightNeedNum = self:getChildGO("mTxtFightNeedNum"):GetComponent(ty.Text)
    self.mTxtFirstAwardDec = self:getChildGO("mTxtFirstAwardDec"):GetComponent(ty.Text)
    self.mImgCheckmark = self:getChildGO("mImgCheckmark"):GetComponent(ty.AutoRefImage)
    self.mImgChipSuitIcon = self:getChildGO("mImgChipSuitIcon"):GetComponent(ty.AutoRefImage)
    self.mImgFightNeedIcon = self:getChildGO("mImgFightNeedIcon"):GetComponent(ty.AutoRefImage)
    self.mAwardContentLayout = self:getChildGO("mAwardContent"):GetComponent(ty.HorizontalLayoutGroup)
    --暂时隐藏单选框功能 后期可能会改回单选框功能
    --self.mToggleTwoFight = self:getChildGO("mToggleTwoFight"):GetComponent(ty.Toggle)
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(dup.DupChipItem)
    self.mNumberStepper = self:getChildGO("mNumberMultiple"):GetComponent(ty.LyNumberStepper)
    self.mNumberStepper:Init(self.mMultiNum, 1, 1, -1, self.onStepChange, self)

    self:setGuideTrans("guide_DupChipInfo_BtnSuit", self.mBtnSuit.transform)
end

--激活
function active(self, args)
    super.active(self, args)
    self.mImgMesh:SetActive(false)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID }, 1)
    if args then
        if args.isFight == false then
            self.mData = args
        else
            self.mData = dup.DupEquipBaseManager.mDupData
            if self.mData == nil then
                gs.Message.Show("(//̀Д/́/)雅雅大人制裁你！")
                return
            end
            self.mData.isFight = args.isFight
        end
    else
        self.mData = nil
    end
    GameDispatcher:addEventListener(EventName.UPDATE_DUP_LEVEL_INFO, self.updateLevelAwardItem, self)
    stamina.StaminaManager:addEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.updateFightCostNum, self)
    GameDispatcher:addEventListener(EventName.UPDATE_DUP_CHIP_SELECT_SUIT, self.updateView, self)
    GameDispatcher:addEventListener(EventName.ZERO_REFRESH, self.updateView, self)
    self.mGroupRight:SetActive(false)
    --local function onToggle()
    --    self:toggleChange()
    --end
    --self.mToggleTwoFight.onValueChanged:AddListener(onToggle)
    --self.mToggleTwoFight.isOn = StorageUtil:getString0(self.mMultiStorageKey) == "1"
    self.mGroupSuitInfoTips:SetActive(false)
    self:updateView()
    if self.mData == nil then
        self:updateEffect(true)
    end
    if self.mAnimatorDoTween then
        LoopManager:removeFrameByIndex(self.mAnimatorDoTween)
        self.mAnimatorDoTween = nil
    end
    if ((dup.DupEquipBaseManager.mIsShowDupAni == true and self.mData == nil) or (self.mData and not self.mData.isFight and not self.mData.isJump)) then
        dup.DupEquipBaseManager.mIsShowDupAni = false
        self:animatorDoTween()
    elseif ((dup.DupEquipBaseManager.mIsShowDupAni == false) or (self.mData and self.mData.isFight == true) or (self.mData and self.mData.isJump)) then
        self:addTimer(0.1, 0.1, function()
            if self.mData == nil then
                self.mData = dup.DupEquipBaseManager.mDupData
            end
            self.mDupType = self.mData.dupType
            self:updateEffect(false, self.mMainitemDic[self.mData.dupType], true)
            self:updateLevelInfo(self.mData.dupType, self.mData.dupType)
            self.mImgMesh:SetActive(false)
            --self.mMainitemDic[self.mData.dupType]:getGo():GetComponent(ty.Animator):SetTrigger("show")
        end)
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
    stamina.StaminaManager:removeEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.updateFightCostNum, self)
    GameDispatcher:removeEventListener(EventName.ZERO_REFRESH, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DUP_LEVEL_INFO, self.updateLevelAwardItem, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DUP_CHIP_SELECT_SUIT, self.updateView, self)
    --self.mToggleTwoFight.onValueChanged:RemoveAllListeners()
    TweenFactory:move2PosXEx(self.mAwardContent, 252, 0)
    self:updateDupSelect(0)
    self:clearDiscardItem()
    self:clearSuitItem()
    self.mGroupRight:SetActive(false)
    if self.mLyScroller.Count > 0 then
        self.mLyScroller:CleanAllItem()
    end
    self.mShowIndex = 0
    self.mDupType = 0
    dup.DupDailyBaseManager.mIsShowMain = false
    if self.mMainitemDic then
        for i, item in pairs(self.mMainitemDic) do
            item:poolRecover()
        end
        self.mMainitemDic = {}
    end
    self:clearDoTweenItem()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtFirstAwardDec.text = _TT(116)
end

--添加帧监听
function addAllUIEvent(self)
    self:addUIEvent(self.mImgBtn, self.closeInfoView)
    self:addUIEvent(self.mBtnClose, self.closeInfoView)
    self:addUIEvent(self.mBtnSuit, self.onClickOpenDropView)
    self:addUIEvent(self.mBtnFight, self.onClickFightHandler)
    self:addUIEvent(self.mBtnLockAward, self.onClickOpenAwardView)
    self:addUIEvent(self.mBtnSuitInfo, self.onClickIsShowSuitView)
    self:addUIEvent(self.mBtnCheckEnemy, self.checkEnemyFormation)
end

-- 关闭所有ui
function closeAll(self)
    super.closeAll(self)
    dup.DupDailyBaseManager:setSelectDupId(nil)
    dup.DupDailyBaseManager.mIsShowDupAni = true
end

-- 玩家关闭
function onClickClose(self)
    super.onClickClose(self)
    dup.DupDailyBaseManager:setSelectDupId(nil)
    dup.DupDailyBaseManager.mIsShowDupAni = true
end

--修改数据
function updateView(self)
    if self.mMainitemDic then
        for i, item in pairs(self.mMainitemDic) do
            item:poolRecover()
        end
        self.mMainitemDic = {}
    end
    self:clearDiscardItem()
    self.mBtnSuit:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_DUPCHIP_DROPSELECT, false))
    local list = dup.DupEquipMainManager:getDupEquipData()
    for i, vo in ipairs(list) do
        local mainItem = SimpleInsItem:create(self:getChildGO("mGroupMain"), self.mAwardContent, "DupChipInfoViewmGroupMainChip")
        mainItem:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("dup5/dup_chip_main_" .. i .. ".png"), false)
        mainItem:getChildGO("mTxtAwardTip"):GetComponent(ty.Text).text = _TT(4531)
        mainItem:getChildGO("mImgLockBg"):SetActive((funcopen.FuncOpenManager:isOpen(vo.funcId, false) == false) or (dup.DupEquipMainManager:getEntryIsPass(vo.type) == false))
        mainItem:getChildGO("mTxtNum_1"):GetComponent(ty.Text).text = self:getRomanConversion(i)
        mainItem:getChildGO("mTxtNum_2"):GetComponent(ty.Text).text = "0" .. i
        mainItem:getChildGO("mTxtName"):GetComponent(ty.Text).text = link.LinkManager:getLinkData(vo.funcId):getLinkName2()
        mainItem:getChildGO("mImgNum"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("dup5/dup_chip_num_" .. i .. ".png"), false)
        mainItem:getChildGO("mImgSec"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("dup5/dup_chip_sec_" .. i .. ".png"), false)
        mainItem:addUIEvent("mImgBg", function()
            if self.mShowSn then
                LoopManager:removeTimerByIndex(self.mShowSn)
                self.mShowSn = nil
                self.mGroupRight:SetActive(false)
            end
            if funcopen.FuncOpenManager:isOpen(vo.funcId, true) == false or (self.mDupType == vo.type and self.mGroupRight.activeSelf == true) then
                return
            end
            if (dup.DupEquipMainManager:getEntryIsPass(vo.type) == false) then
                gs.Message.Show(_TT(4620))
                return
            end
            if self.mDupType ~= vo.type then
                if self.mDupType ~= 0 then
                    self.mMainitemDic[self.mDupType]:getChildGO("Root"):GetComponent(ty.Animator):SetTrigger("exit")
                end
                self.mDupType = vo.type
            end
            if self.mData then
                self.mData = nil
            end
            if (self.mData and self.mData.isFight == false) or (self.mData == nil) then
                mainItem:getChildGO("Root"):GetComponent(ty.Animator):SetTrigger("show")
            end
            dup.DupDailyBaseManager:setSelectDupId(nil)
            self.mTxtTitle.text = vo:getName()
            self:updateLevelInfo(vo.type, vo.id)
            self.mBtnSuitInfo:SetActive(false)
            self.mGroupSuitInfoTips:SetActive(false)
            self:updateEffect(false, self.mMainitemDic[vo.type])
        end)
        self:updateAwardItem(vo.id, vo.type, mainItem:getChildTrans("mShowAwardList"))
        self.mMainitemDic[vo.type] = mainItem
        table.insert(self.mMainitemList, mainItem)
    end
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mAwardContent)
    local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(dup.DupEquipBaseManager:getUsingSuitId())
    self.mTxtChipSuitName.text = suitConfigVo.name
    self.mImgChipSuitIcon:SetImg(UrlManager:getIconPath(suitConfigVo.icon), false)
end

function updateLevelInfo(self, type, page, isNoClick)
    self.mCurDupType = type
    if self.showSign then
        LoopManager:removeFrameByIndex(self.showSign)
        self.showSign = nil
        self.mGroupRight:SetActive(false)
    end
    if self.mGroupRight.activeSelf == false then
        self.showSign = LoopManager:addFrame(2, 1, self, function()
            self.mGroupRight:SetActive(true)
            self.mImgBtn:SetActive(true)
            LoopManager:removeFrameByIndex(self.showSign)
            self.showSign = nil
        end)
    else
        self.mGroupRightAni:SetTrigger("show")
    end
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
    if not isNoClick then
        self:updateDupSelect(type)
    end
    self.mTxtTitle.text = dup.DupEquipMainManager:getDupNameByType(type)
    self.mDupList = dup.DupDailyMainManager:getDupDataList(type)
    local saveLastDupId = dup.DupDailyMainManager:getLastDupId(type) --缓存的最后打的副本id

    LoopManager:removeFrameByIndex(self.frameId)
    local tweenIndex = 0
    local canShowNum = math.floor(self.mLyScrollerTrans.rect.height / 61)
    local isSelect = false

    if dup.DupDailyBaseManager:getSelectDupId() ~= nil and dup.DupDailyBaseManager:getSelectDupId() ~= 0 then
        -- 单次选中进了阵容没进战斗退出来，显示刚刚临时选中的
        tweenIndex = self:getSelectIndex(dup.DupDailyBaseManager:getSelectDupId())
    elseif saveLastDupId ~= nil and saveLastDupId ~= 0 then
        -- 【重要】最后一次挑战成功的副本id，没有就自动选择最新的
        dup.DupDailyBaseManager:setSelectDupId(saveLastDupId)
        tweenIndex = self:getSelectIndex(saveLastDupId)
    elseif self.mData ~= nil and self.mData.dupId ~= 0 then
        dup.DupDailyBaseManager:setSelectDupId(self.mData.dupId)
        tweenIndex = self:getSelectIndex(self.mData.dupId)
    elseif dup.DupDailyBaseManager:getDupState(self.mDupList[#self.mDupList]) == 2 then
        dup.DupDailyBaseManager:setSelectDupId(self.mDupList[#self.mDupList].dupId)
        tweenIndex = #self.mDupList
    else
        for i, vo in ipairs(self.mDupList) do
            if dup.DupDailyBaseManager:getDupState(vo) <= 2 then
                dup.DupDailyBaseManager:setSelectDupId(vo.dupId)
                tweenIndex = i
            end
        end
    end

    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = self.mDupList
    else
        self.mLyScroller:ReplaceAllDataProvider(self.mDupList)
    end
    self.frameId = LoopManager:addFrame(3, 1, self, function()
        self.mLyScroller:ScrollToImmediately(0)
        if tweenIndex and canShowNum < tweenIndex then
            self.mLyScroller:ScrollToImmediately(tweenIndex)
        end
    end)
end

function getSelectIndex(self, selectDupId)
    local tweenIndex = 0
    for i, vo in ipairs(self.mDupList) do
        if vo.dupId == selectDupId then
            tweenIndex = i
            break
        end
    end
    return tweenIndex
end

--更新状态
function updateDupSelect(self, dupType)
    for type, item in pairs(self.mMainitemDic) do
        item:getChildGO("mImgChipSelect"):SetActive(type == dupType)
    end
end
--判断有无通关
function updateCustomPass(self, list)
    local isCustomPass = nil
    for i, levelVo in ipairs(list) do
        if (dup.DupDailyBaseManager:getDupState(levelVo) <= 2) then
        end
    end
end
--动画缓动
function animatorDoTween(self)
    self.mImgMesh:SetActive(false)
    for type, item in ipairs(self.mMainitemList) do
        item:getChildGO("Root"):SetActive(false)
    end
    local isOKAni = false
    local aniTime = 0
    gs.DT.DOTween:Sequence():AppendCallback(function()
        LoopManager:addFrame(3, 1, self, function()
            self.mAnimatorDoTween = LoopManager:addFrame(2, #self.mMainitemList, self, function()
                self.mShowIndex = self.mShowIndex + 1
                if (self.mShowIndex > #self.mMainitemList) then
                    LoopManager:removeFrameByIndex(self.mAnimatorDoTween)
                    self.mAnimatorDoTween = nil
                    return
                elseif self.mShowIndex == #self.mMainitemList then
                    isOKAni = true
                end
                self.mMainitemList[self.mShowIndex]:getChildGO("Root"):SetActive(true)
                self.mMainitemList[self.mShowIndex]:getChildGO("Root"):GetComponent(ty.Animator):SetTrigger("enter")
            end)
        end)
    end):OnComplete(function()
        if self.mData ~= nil and self.mGroupRight.activeSelf == false then
            aniTime = AnimatorUtil.getAnimatorClipTime(self.mMainitemList[#self.mMainitemList]:getChildGO("Root"):GetComponent(ty.Animator), "AwardContent_Enter")
            self.frameId = LoopManager:addFrame(1, 0, self, function()
                if isOKAni then
                    self:updateEffect(false, self.mMainitemDic[self.mData.dupType])
                    local type = self.mData.dupType
                    self.mDupType = type
                    self.aniFrame = LoopManager:addTimer(aniTime, aniTime, self, function()
                        self:updateLevelInfo(self.mData.dupType, self.mData.dupId)
                        LoopManager:removeTimerByIndex(self.aniFrame)
                        self.mImgMesh:SetActive(false)
                        self.aniFrame = nil
                        self.mData = nil
                    end)
                    LoopManager:removeFrameByIndex(self.frameId)
                    self.frameId = nil
                    isOKAni = false
                end
            end)
        else
            self.mImgMesh:SetActive(false)
        end
    end)
end
--缓动状态
function updateEffect(self, isBack, item, targetItem, isFightBack)
    local width = 0
    local tweenTime = self.mDupType ~= 0 and 0.5 or 0.01
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mAwardContent.gameObject:GetComponent(ty.RectTransform))
    if isBack == false then
        tweenTime = isFightBack == true and 0.01 or 0.5
        local rightWidth = self:getChildTrans("mGroupRight").rect.width
        local differenceLeftValue = (((self.mAwardContent.rect.width - self.mScrollViewMain.rect.width) / 2) - self.mAwardContent.anchoredPosition.x) - (item.m_trans.anchoredPosition.x - (item.m_trans.rect.width / 2))
        local differenceRightValue = (item.m_trans.anchoredPosition.x + (item.m_trans.rect.width / 2)) - (self.mScrollViewMain.rect.width - rightWidth) - ((self.mAwardContent.rect.width - self.mScrollViewMain.rect.width) / 2)
        if differenceLeftValue > 0 then
            TweenFactory:move2PosXEx(self.mAwardContent, differenceLeftValue - 130, tweenTime)
        elseif differenceRightValue > 0 then
            TweenFactory:move2PosXEx(self.mAwardContent, -differenceRightValue, tweenTime)
        end
    else
        local tweenPosX = ((self.mAwardContent.rect.width - self.mScrollViewMain.rect.width) / 2)
        if self.mDupType ~= 0 then
            self.mMainitemDic[self.mDupType]:getChildGO("Root"):GetComponent(ty.Animator):SetTrigger("exit")
            self.mDupType = 0
            TweenFactory:move2PosXEx(self.mAwardContent, tweenPosX, tweenTime)
        else
            gs.TransQuick:UIPosX(self.mAwardContent.transform, tweenPosX)
        end
        self:updateDupSelect(0)
    end
end
--更新关卡奖励
function updateLevelAwardItem(self, levelData)
    self.mLevelData = levelData
    if self.mLevelData then
        self:clearEleitemList()
        self.mDupData = dup.DupMainManager:getDupInfoData(self.mLevelData.type)
        self.mImgFightNeedIcon:SetImg(UrlManager:getPropsIconUrl(self.mLevelData.needTid), false)
        self:clearLevelAwardItem()
        local awardList = {}
        if self.mLevelData.showExtraDrop and self.mLevelData.state ~= 2 then
            for i, v in ipairs(self.mLevelData.showExtraDrop) do
                v.state = 1
                table.insert(awardList, v)
            end
        end
        for _, propVo in ipairs(self.mLevelData:getCurrentShowDrop(dup.DupEquipBaseManager:getUsingSuitId())) do
            propVo.state = 2
            table.insert(awardList, propVo)
        end
        if dup.DupMainManager:getIsMatchActivityMoney(dup.DupDailyUtil:getBattleType(self.mLevelData.type)) then
            local tempTid = sysParam.SysParamManager:getValue(SysParamType.ACTIVE_DEADLINE_PROP)
            local propVo = props.PropsManager:getPropsVo({ tid = tempTid, num = self.mLevelData.needNum })
            propVo.state = 3
            table.insert(awardList, propVo)
        end
        for k, awardVo in ipairs(awardList) do
            local propsGrid = PropsGrid:create(self.mGorpLevelAward, { tid = awardVo.tid, num = awardVo.num or awardVo.count }, 1, false);
            propsGrid:setEquipBgIsShow(false)
            local propsVo = props.PropsManager:getPropsVo(awardVo)
            if awardVo.state == 1 then
                propsGrid:setIsFirstPass(true)
            elseif awardVo.state == 3 then
                propsGrid:setIsDeadline(true)
            else
                propsGrid:setIsProbability(awardVo:getDropShow() > 0, AwardPackConst:getAwardShowName(awardVo:getDropShow()))
            end

            table.insert(self.mPropGridList, propsGrid)
        end
        for _, type in ipairs(self.mLevelData:getSuggestEleList()) do
            local typeItem = SimpleInsItem:create(self:getChildGO("mImgType"), self.mGroupType, "DupChipInfoViewherofighttypeImg")
            typeItem:getGo():GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl(type), false)
            table.insert(self.mEletemList, typeItem)
        end
        self:updateFightCostNum()
    end
end
--更新套装弹窗信息
function updateSuit(self, Vo)
    if Vo == nil then
        return
    end
    self:clearSuitItem()
    local propsVo = props.PropsManager:getPropsVo({ tid = Vo.tid, num = Vo.num })
    local item = SimpleInsItem:create(self:getChildGO("mGroupAwardItem"), self.mAwardGridTrans, "DupChipInfoViewSuitAwardItem")
    local prop = PropsGrid:create(item:getChildTrans("mAwardTrans"), { tid = propsVo.tid, num = propsVo.num or 1 }, 1, false)
    prop:setEquipBgIsShow(false)
    table.insert(self.mSuitPropGridList, prop)
    item:getChildGO("mTxtAwardName"):SetActive(true)
    item:getChildGO("mTxtAwardName"):GetComponent(ty.Text).text = HtmlUtil:color(string.sub(propsVo.name, 1, -3), "ffffffff")
    table.insert(self.mSuitAwardItemList, item)
    local equipConfigVo = equip.EquipManager:getEquipConfigVo(propsVo.tid)
    local suitId = equipConfigVo and equipConfigVo.suitId or 0
    local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
    local suitList = {}
    self.mTxtAwardDec.gameObject:SetActive(false)
    if suitConfigVo then
        if suitConfigVo.suitSkillId_2 > 0 and suitConfigVo.suitSkillId_4 > 0 then
            suitList[1] = suitConfigVo.suitSkillId_2
            suitList[2] = suitConfigVo.suitSkillId_4
        elseif suitConfigVo.suitSkillId_4 > 0 then
            suitList[1] = suitConfigVo.suitSkillId_4
        elseif suitConfigVo.suitSkillId_2 > 0 then
            suitList[1] = suitConfigVo.suitSkillId_2
        end
    else
        item:getChildGO("mTxtAwardName"):SetActive(false)
        self.mTxtAwardDec.gameObject:SetActive(true)
        self.mTxtAwardDec.text = propsVo.des
        return
    end
    for i, vo in ipairs(suitList) do
        local skillVo = fight.SkillManager:getSkillRo(vo)
        local introduceItem = SimpleInsItem:create(self:getChildGO("mTxtSuitDec"), self.mSuitContent, "DupChipInfoViewSuitInfoTxt")
        introduceItem:getTrans():GetComponent(ty.Text).text = skillVo:getDesc()
        introduceItem:getChildGO("mTxtSuit"):GetComponent(ty.Text).text = _TT(4036 + i)
        table.insert(self.mSuitItemList, introduceItem)
    end
end
--更新奖励预制体
function updateAwardItem(self, id, type, prent)
    local awardList = {}
    for _, vo in ipairs(dup.DupEquipBaseManager:getDupChipData(type)) do
        table.insert(awardList, vo:getCurSuitIdShowDrop(dup.DupEquipBaseManager:getUsingSuitId()))
    end
    if #awardList <= 0 then
        return
    end
    for k, vo1 in ipairs(awardList[id - 9]) do
        local propVo = props.PropsManager:getPropsVo({ tid = vo1.tid, num = vo1.num })
        if propVo.type == PropsType.EQUIP then
            local item = SimpleInsItem:create(self:getChildGO("mGroupAwardItem"), prent, "DupChipInfoViewAwardItem")
            local prop = PropsGrid:create(item:getChildTrans("mAwardTrans"), { tid = propVo.tid, num = propVo.num or 1 }, 1, false)
            prop:setCallBack(self, self.onClickIsShowSuitView, vo1)
            prop:setEquipBgIsShow(false)
            table.insert(self.mAwardPropGridList, prop)
            item:getChildGO("mTxtAwardName"):SetActive(false)
            item:getChildGO("mBtnShowSuit"):SetActive(false)
            table.insert(self.mAwardItemList, item)
        end
    end
end
--关闭信息面板
function closeInfoView(self)
    if self.mGroupRight.activeSelf == true then
        self.mImgBtn:SetActive(false)
        local AniTime = 0
        local AniTable = self.mGroupRightAni.runtimeAnimatorController.animationClips
        for i = 0, AniTable.Length do
            if AniTable[i].name == "DupChipInfoView_Exit" then
                AniTime = AniTable[i].length
                break
            end
        end
        self.mGroupRightAni:SetTrigger("exit")
        self.mShowSn = LoopManager:addTimer(AniTime, 1, self, function()
            self.mGroupRight:SetActive(false)
            LoopManager:removeTimerByIndex(self.mShowSn)
            self.mShowSn = nil
        end)
        self:updateEffect(true)
    end
end

--是否显示套装弹窗
function onClickIsShowSuitView(self, Vo)
    if self.mGroupSuitInfoTips.activeSelf == true then
        if not Vo then
            self.mBtnSuitInfo:SetActive(false)
            self.mGroupSuitInfoTips:SetActive(false)
        end
    else
        self.mBtnSuitInfo:SetActive(true)
        self.mGroupSuitInfoTips:SetActive(true)
    end
    self:updateSuit(Vo)
end

--打开每周详情掉落奖励页面
function onClickOpenAwardView(self)
    local args = {}
    args.index = self.mOpenPage
    args.duplist = self.mDupList
    GameDispatcher:dispatchEvent(EventName.OPEN_CHIP_DORP_ROLE_VIEW, args)
end

--打开掉落详情界面
function onClickOpenDropView(self)
    if self.mGroupSuitInfoTips.activeSelf == true then
        self.mGroupSuitInfoTips:SetActive(false)
        self.mBtnSuitInfo:SetActive(false)
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_DUP_EQUIP_DROP_SELECT_VIEW)
end
--步进器倍数
function onStepChange(self, cusCount, cusType)
    if cusType == 1 then
        -- '最大值'
        gs.Message.Show(_TT(26317))
        return
    elseif cusType == 2 then
        -- '最小值'  
        gs.Message.Show(_TT(4019))
        return
    end
    if not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_DUP_MULTI, true) then
        self.mNumberStepper.CurrCount = 1
        self.fightNeedMultiple = 1
        return
    end
    if not self:getIsPassFirst() then
        gs.Message.Show(_TT(1395))
        self.mNumberStepper.CurrCount = 1
        self.fightNeedMultiple = 1
        return
    end
    if cusCount > self.fightNeedMultiple and not self:checkChangeCurMaxMultiple(cusCount) then
        self.mNumberStepper.CurrCount = self.fightNeedMultiple
        return
    end
    self.fightNeedMultiple = self.mNumberStepper.CurrCount
    StorageUtil:saveString1(self.mMultiStorageKey .. self.mCurDupType, self.mNumberStepper.CurrCount)
    self:updateFightCostNum()

end

function checkChangeCurMaxMultiple(self, cusMulit)
    local playerCurLv = role.RoleManager:getRoleVo():getPlayerLvl()
    for _, curVo in ipairs(sysParam.SysParamManager:getValue(SysParamType.DUP_ASSETS_MULTI)) do
        if cusMulit == curVo[1] and playerCurLv < curVo[2] then
            gs.Message.Show(_TT(53612, curVo[2]))--链尉官等级{0}级解锁
            return false
        end
    end
    return true
end

function getIsPassFirst(self)
    for index, grid in ipairs(self.mPropGridList) do
        if grid:getIsFirstPass() == true then
            return false
        end
    end
    return true
end


-- 多倍挑战选择
--function toggleChange(self)
--    if self.mToggleTwoFight.isOn then
--        self.mImgCheckmark:SetImg(UrlManager:getCommon5Path("common_0017.png"))
--        self.fightNeedMultiple = 2
--    else
--        self.mImgCheckmark:SetImg(UrlManager:getCommon5Path("common_0018.png"))
--        self.fightNeedMultiple = 1
--    end
--    StorageUtil:saveString0(self.mMultiStorageKey, (self.mToggleTwoFight.isOn and "1" or "0"))
--    if self.mGroupRight.activeSelf == true then
--        self:updateFightCostNum()
--    end
--end

--请求战斗
function sendFight(self)
    local battleType = dup.DupDailyUtil:getBattleType(self.mLevelData.type)
    local roleLv = role.RoleManager:getRoleVo():getPlayerLvl()
    if self.mDupData.curId ~= 0 and self.mLevelData.dupId > self.mDupData.curId then
        -- gs.Message.Show('前置关卡未通关')
        gs.Message.Show(_TT(119))
    elseif self.mLevelData.enterLv > roleLv then
        gs.Message.Show(_TT(121, self.mLevelData.enterLv))
    else
        dup.DupDailyUtil:getDupMgr(self.mLevelData.type).enterCurId = self.mLevelData.dupId -- 记录本次进入副本的当前可挑战id，出来的时候对比用
        GameDispatcher:dispatchEvent(EventName.CLOSE_EQUIP_DUP_INFO, self.mLevelData.type)
        formation.checkFormationFight(battleType, nil, self.mLevelData.dupId, nil, nil, nil, nil, self.fightNeedMultiple)
    end
end

--进入战斗
function onClickFightHandler(self)
    if self.mLevelData == nil or self.mLevelData.type ~= self.mDupType then
        gs.Message.Show("未选择难度，请确认难度选择是否正确")
        return
    elseif self.mLevelData.state == 3 then
        gs.Message.Show(_TT(4523))
        return
    elseif MoneyUtil.getMoneyCountByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID) < self.fightNeedMultiple * self.mLevelData.needNum then
        GameDispatcher:dispatchEvent(EventName.OPEN_ADD_STAMINA_PANEL, { isByProps = true, needCost = 0, callFun = nil, callObj = nil })
        gs.Message.Show(_TT(26318))
        return
    end

    local equipList = bag.BagManager:getBagPagePropsList(bag.BagTabType.EQUIP, nil, nil, nil, nil, bag.BagType.Equip)
    --local propsList = bag.BagManager:getBagPagePropsList(bag.BagTabType.EQUIP,nil , nil, nil, {}, bag.BagTabType.EQUIP)
    
    local maxValue = sysParam.SysParamManager:getValue(SysParamType.EQUIP_MAX_COUNT)
    if #equipList >= maxValue then
        UIFactory:alertMessge(_TT(4388), true, function()
        dup.DupEquipBaseManager.mDupData = self.mLevelData
        dup.DupEquipBaseManager.mDupData.dupType = self.mLevelData.type
        local battleType = dup.DupDailyUtil:getBattleType(self.mLevelData.type)
        local needNum = self.mLevelData.needNum * self.fightNeedMultiple
        stamina.StaminaManager:checkStamina(battleType, nil, needNum, self.sendFight, self)
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    else
        dup.DupEquipBaseManager.mDupData = self.mLevelData
        dup.DupEquipBaseManager.mDupData.dupType = self.mLevelData.type
        local battleType = dup.DupDailyUtil:getBattleType(self.mLevelData.type)
        local needNum = self.mLevelData.needNum * self.fightNeedMultiple
        stamina.StaminaManager:checkStamina(battleType, nil, needNum, self.sendFight, self)
    end
end

--查看敌人阵型
function checkEnemyFormation(self)
    if self.mLevelData then
        dup.DupEquipBaseManager.mDupData = self.mLevelData
        dup.DupEquipBaseManager.mDupData.dupType = self.mLevelData.type
        GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, { dupVo = self.mLevelData })
    end
end

--更新战斗所需物品消耗倍数
function updateFightCostNum(self)
    self:udapteCurMultiple()
    for i, propsGrid in ipairs(self.mPropGridList) do
        if propsGrid:getIsFirstPass() == false and propsGrid.mPropsVo.count > 1 then
            local count = propsGrid.mPropsVo.count;
            count = propsGrid.mPropsVo.count * self.fightNeedMultiple;
            self.mPropGridList[i]:setCount(count)
        end
    end
    if self.mLevelData then
        self.mTxtFightNeedNum.text = self:getThreeUnaryValue(MoneyUtil.getMoneyCountByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID) >= self.fightNeedMultiple * self.mLevelData.needNum, HtmlUtil:color(self.fightNeedMultiple * self.mLevelData.needNum, "202226FF"), HtmlUtil:color(self.fightNeedMultiple * self.mLevelData.needNum, "FF0000"))
    end
end

function udapteCurMultiple(self)
    local multiNum = StorageUtil:getString1(self.mMultiStorageKey .. self.mCurDupType)
    self.mNumberStepper.CurrCount = ((multiNum == nil) or (multiNum == "") or (not self:getIsPassFirst())) and 1 or multiNum
    self.fightNeedMultiple = self.mNumberStepper.CurrCount
end

-- 三目运算函数
function getThreeUnaryValue(self, conditions, leftValue, rightValue)
    return conditions and leftValue or rightValue
end
-- 罗马数字转换
function getRomanConversion(self, Value)
    local list = { "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ", "Ⅶ", "Ⅷ", "Ⅸ", "Ⅹ" }
    return list[Value]
end

--刪除临时预制体
function clearDiscardItem(self)
    if #self.mAwardItemList > 0 then
        for _, vo in ipairs(self.mAwardItemList) do
            vo:poolRecover()
        end
        self.mAwardItemList = {}
    end
    if #self.mAwardPropGridList > 0 then
        for _, vo2 in ipairs(self.mAwardPropGridList) do
            vo2:poolRecover()
        end
        self.mAwardPropGridList = {}
    end
end

--删除推荐战员类型
function clearEleitemList(self)
    if #self.mEletemList > 0 then
        for _, item in ipairs(self.mEletemList) do
            item:poolRecover()
        end
        self.mEletemList = {}
    end
end

function clearSuitItem(self)
    if #self.mSuitPropGridList > 0 then
        for _, vo4 in ipairs(self.mSuitPropGridList) do
            vo4:poolRecover()
        end
        self.mSuitPropGridList = {}
    end
    if #self.mSuitItemList > 0 then
        for _, vo1 in ipairs(self.mSuitItemList) do
            vo1:poolRecover()
        end
        self.mSuitItemList = {}
    end
    if #self.mSuitAwardItemList > 0 then
        for _, vo2 in ipairs(self.mSuitAwardItemList) do
            vo2:poolRecover()
        end
        self.mSuitAwardItemList = {}
    end
end

--删除关卡奖励
function clearLevelAwardItem(self)
    if #self.mPropGridList > 0 then
        for _, vo2 in ipairs(self.mPropGridList) do
            vo2:poolRecover()
        end
        self.mPropGridList = {}
    end
end

--删除缓动目标列表
function clearDoTweenItem(self)
    if #self.mMainitemList > 0 then
        self.mMainitemList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]