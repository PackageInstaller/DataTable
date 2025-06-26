--[[ 
-----------------------------------------------------
@filename       : DupPotencyView
@Description    : 潜能副本页面
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('dup.DupPotencyView', Class.impl(dup.DupDailyBasePanel))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupPotency/DupPotencyBasePanel.prefab")

function initData(self)
    self.mData = nil
    self.mDupList = {}
    -- 控制播放动画的顺序
    self.mShowIndex = 0
    self.mOpenPage = 0
    self.mRefreshDay = os.date('*t', GameManager:getClientTime()).wday
    self.mDupType = 0
    self.mDupData = nil
    self.mCurDupType = 0
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
    self.mMultiStorageKey = "DupPotencyMultiKey"
    self.mMultiNum = sysParam.SysParamManager:getValue(SysParamType.DUP_POTENCY_MULTI)
end

function getDupType(self)
    return mainPlay.MainPlayDupConst.MAINPLAYDUP_POTENCY
end

-- 初始化
function configUI(self)
    self.mImgBtn = self:getChildGO("mImgBtn")
    self.mImgMesh = self:getChildGO("mImgMesh")
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mGroupRight = self:getChildGO("mGroupRight")
    self.mEffectNode = self:getChildGO("mEffectNode")
    self.mGroupType = self:getChildTrans("mGroupType")
    self.mWeakGuideUI = self:getChildGO("mWeakGuideUI")
    self.mScrollView = self:getChildTrans("Scroll View")
    self.mMoneyGroups = self:getChildTrans("mMoneyGroups")
    self.mBtnCheckEnemy = self:getChildGO("mBtnCheckEnemy")
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mFightContent = self:getChildTrans("mFightContent")
    self.mLyScrollerTrans = self:getChildTrans("LyScroller")
    self.mGorpLevelAward = self:getChildTrans("mGorpLevelAward")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mShowTips = self:getChildGO("mShowTips"):GetComponent(ty.Text)
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mBtnFightImg = self:getChildGO("mBtnFight"):GetComponent(ty.AutoRefImage)
    self.mGroupRightAni = self:getChildGO("mGroupRight"):GetComponent(ty.Animator)
    self.mTxtFightNeedNum = self:getChildGO("mTxtFightNeedNum"):GetComponent(ty.Text)
    self.mGroupShowBg = self:getChildGO("mGroupShowBg"):GetComponent(ty.AutoRefImage)
    self.mTxtFirstAwardDec = self:getChildGO("mTxtFirstAwardDec"):GetComponent(ty.Text)
    self.mImgCheckmark = self:getChildGO("mImgCheckmark"):GetComponent(ty.AutoRefImage)
    self.mNumberStepper = self:getChildGO("mNumberMultiple"):GetComponent(ty.LyNumberStepper)
    self.mImgFightNeedIcon = self:getChildGO("mImgFightNeedIcon"):GetComponent(ty.AutoRefImage)
    self.mAwardContentLayout = self:getChildGO("mAwardContent"):GetComponent(ty.HorizontalLayoutGroup)
    self.mNumberStepper:Init(self.mMultiNum, 1, 1, -1, self.onStepChange, self)
    self.mLyScroller:SetItemRender(dup.DupPotencyItem)
    --暂时隐藏单选框功能 后期可能会改回单选框功能
    --self.mToggleTwoFight = self:getChildGO("mToggleTwoFight"):GetComponent(ty.Toggle)


    self:setGuideTrans("funcTips_guide_dupPotency_tips", self:getChildTrans("mGuideTips"))
end
--激活
function active(self, args)
    self.mImgMesh:SetActive(false)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID }, 1)
    if not self.mMoneyBarItem then
        self.mMoneyBarItem = MoneyItem:poolGet()
    end
    self.mMoneyBarItem:setData(self.mMoneyGroups, { tid = MoneyTid.ANTIEPIDEMIC_SERUM_TID, frontType = 2 })
    if args then
        if args.isFight == false then
            self.mData = args
        else
            self.mData = dup.DupDailyBaseManager.mDupData
            if self.mData == nil then
                gs.Message.Show("(//̀Д/́/)雅雅大人制裁你！")
                return
            end
            self.mData.isFight = args.isFight
        end
    else
        self.mData = nil
    end
    self.mGroupRight:SetActive(false)
    GameDispatcher:addEventListener(EventName.UPDATE_DUP_LEVEL_INFO, self.updateLevelAwardItem, self)
    stamina.StaminaManager:addEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.updateFightCostNum, self)
    --local function onToggle()
    --    self:toggleChange()
    --end
    --self.mToggleTwoFight.onValueChanged:AddListener(onToggle)
    if self.mData == nil then
        self:updateEffect(true)
    end
    self:updateView()
    if self.mAnimatorDoTween then
        LoopManager:removeFrameByIndex(self.mAnimatorDoTween)
        self.mAnimatorDoTween = nil
    end

    if ((dup.DupDailyBaseManager.mIsShowDupAni == true and self.mData == nil) or (self.mData and not self.mData.isFight and not self.mData.isJump)) then
        dup.DupDailyBaseManager.mIsShowDupAni = false
        self:animatorDoTween()
    elseif ((dup.DupDailyBaseManager.mIsShowDupAni == false) or (self.mData and self.mData.isFight == true)) or (self.mData and self.mData.isJump) then
        self:addTimer(0.2, 1, function()
            if self.mData == nil then
                self.mData = dup.DupDailyBaseManager.mDupData
            end
            self.mDupType = self.mData.dupType
            if self.mMainitemDic[self.mDupType] then
                self.mMainitemDic[self.mDupType]:getArgs().onClickHandler(self.mData.dupId)
            end
            self.mImgMesh:SetActive(false)
        end)
        --self.mMainitemDic[self.mData.dupType]:getGo():GetComponent(ty.Animator):SetTrigger("show")
    end
    self.mWeakGuideUI:SetActive(false)
    local stageId = sysParam.SysParamManager:getValue(SysParamType.WEAKGUIDE_MAINSTAGEID)
    if not battleMap.MainMapManager:isStagePass(stageId) and not guide.GuideManager:getCurHasGuide() then
        local time = sysParam.SysParamManager:getValue(SysParamType.WEAKGUIDE_DUPTIMEOUTTIME)
        self:setTimeout(time, function()
            self.mWeakGuideUI:SetActive(true)
        end)
    end
end

--反激活（销毁工作）
function deActive(self)
    if self.mMoneyBarItem then
        self.mMoneyBarItem:poolRecover()
        self.mMoneyBarItem = nil
    end
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
    stamina.StaminaManager:removeEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.updateFightCostNum, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DUP_LEVEL_INFO, self.updateLevelAwardItem, self)
    --self.mToggleTwoFight.onValueChanged:RemoveAllListeners()
    self:updateDupSelect(0)
    self:clearDiscardItem()
    self.mGroupRight:SetActive(false)
    if self.mLyScroller.Count > 0 then
        self.mLyScroller:CleanAllItem()
    end
    self.mShowIndex = 0
    self.mDupType = 0
    dup.DupDailyBaseManager.mIsShowMain = false
    gs.TransQuick:LPosY(self.mAwardContent, 0)
    self:clearDoTweenItem()
end

function animatorDoTween(self)
    self.mImgMesh:SetActive(false)
    self.mImgBtn:SetActive(false)
    if self.mData ~= nil then
        self:updateEffect(false, self.mMainitemDic[self.mData.dupType])
        local type = self.mData.dupType
        self.mDupType = type
        self:updateLevelInfo(self.mData.dupType, self.mData.dupId)
        self.mData = nil
    else
        local type = dup.DupDailyMainManager:getDupEntryListByType(self:getDupType())[1].type
        if self.mMainitemDic[type] then
            self.mMainitemDic[type]:getArgs().onClickHandler(nil)
        end
    end
end

--修改数据
function updateView(self)
    self:clearDoTweenItem()
    local list = dup.DupDailyMainManager:getDupEntryListByType(self:getDupType())
    for i, vo in ipairs(list) do
        if funcopen.FuncOpenManager:isOpen(vo.funcId, false) == true then
            local mainItem = SimpleInsItem:create(self:getChildGO("mGroupMain"), self.mAwardContent, "DupPotencyViewmGroupPotency")
            if (vo.type == 1 or vo.type == 2 or vo.type == 16) then
                self:setGuideTrans("guide_DupDailyItem_" .. vo.type, mainItem:getChildTrans("mImgBg"))
            end

            mainItem:getChildGO("mImgChipSelect"):SetActive(false)
            mainItem:getChildGO("mTxtName"):GetComponent(ty.Text).text = vo:getName()
            mainItem:getChildGO("mTxtDes"):GetComponent(ty.Text).text = vo:getDes()
            mainItem:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(vo:getUrl(), false)
            mainItem:getChildGO("mImgIconLitle"):GetComponent(ty.AutoRefImage):SetImg(vo:getUrl(), false)
            mainItem:getChildGO("mImgLockBg"):SetActive(funcopen.FuncOpenManager:isOpen(vo.funcId, false) == false)
            local click = function(dupId)
                if self.mShowSn then
                    LoopManager:removeTimerByIndex(self.mShowSn)
                    self.mGroupRight:SetActive(false)
                    self.mShowSn = nil
                end
                if funcopen.FuncOpenManager:isOpen(vo.funcId, true) == false or (self.mDupType == vo.type and self.mGroupRight.activeSelf == true) then
                    return
                end
                if self.mDupType ~= vo.type then
                    if self.mDupType ~= 0 then
                        self.mMainitemDic[self.mDupType]:getChildGO("mImgChipSelect"):SetActive(false)
                    end
                    self.mDupType = vo.type
                end
                if self.mData then
                    self.mData = nil
                end
                if (self.mData and self.mData.isFight == false) or (self.mData == nil) then
                    mainItem:getChildGO("mImgChipSelect"):SetActive(true)
                end
                if self.mGroupRight.activeSelf == true then
                    self.mGroupRightAni:SetTrigger("show")
                end
                dup.DupDailyBaseManager:setSelectDupId(nil)
                self:updateEffect(false, self.mMainitemDic[vo.type])
                local curDupId = dupId or self:checkDupId(dup.DupDailyMainManager:getDupDataList(vo.type))
                self:updateLevelInfo(vo.type, curDupId)
                self.mTxtTitle.text = vo:getTitleName()
                self.mWeakGuideUI:SetActive(false)
                if self.mWeakGuideSn then
                    self:clearTimeout(self.mWeakGuideSn)
                    self.mWeakGuideSn = nil
                end
            end
            vo.onClickHandler = click
            mainItem:addUIEvent("mImgBg", function()
                click(nil)
            end)
            mainItem:setArgs(vo)
            self.mMainitemDic[vo.type] = mainItem
            table.insert(self.mMainitemList, mainItem)
        end
    end
end

--更新关卡信息
function updateLevelInfo(self, type, dupId, isNoClick, isFrist)
    self.mCurDupType = type
    if self.mGroupRight.activeSelf == false then
        self.mGroupRight:SetActive(true)
    end
    if isNoClick then
        self:updateDupSelect(type)
    end
    self.mLyScroller:CleanAllItem()
    LoopManager:removeFrameByIndex(self.frameId)
    self.mTxtTitle.text = dup.DupDailyMainManager:getDupNameByType(type)
    self.mDupList = dup.DupDailyMainManager:getDupDataList(type)
    local canShowNum = math.floor(self.mLyScrollerTrans.rect.height / 61)
    local tweenIndex = self:checkCurDupByType(type, dupId) - 1
    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = self.mDupList
    else
        self.mLyScroller:ReplaceAllDataProvider(self.mDupList)
    end
    self:setBg("dupPotencyBg_" .. type .. ".jpg", false, "dupPotency")
    self.mGroupShowBg:SetImg(UrlManager:getIconPath("dupPotency/dupPotency_" .. type .. ".jpg"), false)

end

--更新关卡奖励
function updateLevelAwardItem(self, levelData)
    super.updateLevelAwardItem(self, levelData)
    self.mShowTips.text = self:getShowTips()
    if self.mLevelData.state > 2 then
        self:setBtnLabel(self.mBtnFight, 4613, "不可挑战")
    else
        self:setBtnLabel(self.mBtnFight, 27, "挑战")
    end
    self.mBtnFightImg:SetGray(self.mLevelData.state > 2)
    self.mEffectNode:SetActive(self.mLevelData.state <= 2)
    self.mShowTips.gameObject:SetActive(self.mLevelData.state > 2)
    self.mNumberStepper.gameObject:SetActive(self.mLevelData.state <= 2)
    local colorA = self.mBtnFightImg.color
    colorA.a = self.mLevelData.state > 2 and 0.5 or 1
    self.mBtnFightImg.color = colorA
end
--检查当前关卡类型的最新关卡
function checkCurDupByType(self, type, dupId)
    local tweenIndex = 0
    local saveLastDupId = dupId and dupId or dup.DupDailyMainManager:getLastDupId(type) --缓存的最后打的副本id

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
    return tweenIndex
end

function checkDupId(self, list)
    local dupId = nil
    for i, vo in ipairs(list) do
        if dup.DupDailyBaseManager:getDupState(vo) <= 2 then
            dupId = vo.dupId
        end
    end
    return dupId
end

--更新状态
function updateDupSelect(self, dupType)
    for type, v in pairs(self.mMainitemDic) do
        self.mMainitemDic[type]:getChildGO("mImgChipSelect"):SetActive(type == dupType)
    end
end

--更新战斗所需物品消耗倍数
function updateFightCostNum(self)
    self:udapteCurMultiple()
    for i, grid in ipairs(self.mPropGridList) do
        if grid:getIsFirstPass() == false and grid.mPropsVo.count > 1 then
            local count = grid.mPropsVo.count;
            count = grid.mPropsVo.count * self.fightNeedMultiple;
            self.mPropGridList[i]:setCount(count)
        end
    end
    if self.mLevelData then
        self.mTxtFightNeedNum.text = self:getThreeUnaryValue(MoneyUtil.getMoneyCountByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID) >= self.fightNeedMultiple * self.mLevelData.needNum, HtmlUtil:color(self.fightNeedMultiple * self.mLevelData.needNum, "ffffffFF"), HtmlUtil:color(self.fightNeedMultiple * self.mLevelData.needNum, "FF0000"))
    end
end

function updateEffect(self, isBack, item, isFightBack)
    local height = 0
    local tweenTime = 0.1
    if isBack == false then
        local subPosY = math.abs(item.m_trans.anchoredPosition.y) + item.m_trans.rect.height - math.abs(self.mAwardContent.anchoredPosition.y)
        local upPosY = math.abs(item.m_trans.anchoredPosition.y) - math.abs(self.mAwardContent.anchoredPosition.y)
        if subPosY > self:getChildTrans("mViewport").rect.height then
            -- TweenFactory:move2LPosX(self.mAwardContent, subPosY, 0.01)
            --elseif subPosY > 0 then
            local subValue = -(subPosY - self:getChildTrans("mViewport").rect.height)
            gs.TransQuick:LPosY(self.mAwardContent, self.mAwardContent.anchoredPosition.y - subValue + 10)
        elseif upPosY <= 0 then
            gs.TransQuick:LPosY(self.mAwardContent, math.abs(self.mAwardContent.anchoredPosition.y) + upPosY - 10)
        end
    else
        if self.mDupType ~= 0 then
            --self.mMainitemDic[self.mDupType]:getGo():GetComponent(ty.Animator):SetTrigger("exit")
            self.mDupType = 0
        end
        --self.mAwardContentLayout.padding.right = height
        --self:updateDupSelect(0)
    end
end

--进入战斗
function onClickFightHandler(self)
    if self.mLevelData.state >= 3 then
        gs.Message.Show(self:getShowTips())
        return
    end
    super.onClickFightHandler(self)
end

function getShowTips(self)
    local tipsText = _TT(53608)
    if self.mLevelData.state == 4 then
        tipsText = _TT(53612, self.mData.enterLv)
    elseif battleMap.MainMapManager:isStagePass(self.mLevelData.enterDup) == nil then
        local stageVo = battleMap.MainMapManager:getStageVo(self.mLevelData.enterDup)
        tipsText = _TT(53609, stageVo.indexName)
    end
    return tipsText
end

--关闭信息面板
function closeInfoView(self)

end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]