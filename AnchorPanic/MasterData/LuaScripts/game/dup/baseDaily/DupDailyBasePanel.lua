--[[ 
-----------------------------------------------------
@filename       : DupDailyBasePanel
@Description    : 日常副本
@date           : 2022-04-18 20:11:20
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("dup.DupDailyBasePanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupDaily/DupDailyBasePanel.prefab")

destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1624, 750)
    if self:getDupType() ~= mainPlay.MainPlayDupConst.MAINPLAYDUP_POTENCY then
        self:setTxtTitle(_TT(52025))
        self:setBg("dup_resources_1.jpg", false, "dup5")
        self:setUICode(LinkCode.DupDaily)
    else
        self:setTxtTitle(_TT(52083))
    end
end
--析构
function dtor(self)
end

function initData(self)
    self.mDupData = nil
    self.mData = nil
    -- 控制播放动画的顺序
    self.mShowIndex = 0
    self.frameId = nil
    self.mDupType = 0
    self.mCurDupType = 0
    self.mDupList = {}
    self.mLevelData = nil
    self.mPropGridList = {}
    self.mAwardItemList = {}
    self.fightNeedMultiple = 1
    self.mAwardPropGridList = {}
    self.mMainitemDic = {}
    self.mEletemList = {}
    self.mMainitemList = {}

    self.mMultiTime = sysParam.SysParamManager:getValue(SysParamType.DUP_MULTI)

    self.mMultiStorageKey = "DupDailyBasePanelMulti"
end
-- 初始化
function configUI(self)
    self.mImgBtn = self:getChildGO("mImgBtn")
    self.mImgMesh = self:getChildGO("mImgMesh")
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mIconType = self:getChildGO("mIconType")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mGroupRight = self:getChildGO("mGroupRight")
    self.mGroupType = self:getChildTrans("mGroupType")
    self.mScrollView = self:getChildTrans("mScrollView")
    self.mMoneyGroups = self:getChildTrans("mMoneyGroups")
    self.mBtnCheckEnemy = self:getChildGO("mBtnCheckEnemy")
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mFightContent = self:getChildTrans("mFightContent")
    self.mLyScrollerContent = self:getChildTrans("LyScroller")
    self.mGorpLevelAward = self:getChildTrans("mGorpLevelAward")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(dup.DupDailyBaseItem)
    self.mGroupRightAni = self:getChildGO("mGroupRight"):GetComponent(ty.Animator)
    --暂时隐藏单选框功能 后期可能会改回单选框功能
    --self.mToggleTwoFight = self:getChildGO("mToggleTwoFight"):GetComponent(ty.Toggle)
    self.mTxtFightNeedNum = self:getChildGO("mTxtFightNeedNum"):GetComponent(ty.Text)
    self.mTxtFirstAwardDec = self:getChildGO("mTxtFirstAwardDec"):GetComponent(ty.Text)
    self.mImgCheckmark = self:getChildGO("mImgCheckmark"):GetComponent(ty.AutoRefImage)
    self.mImgFightNeedIcon = self:getChildGO("mImgFightNeedIcon"):GetComponent(ty.AutoRefImage)
    self.mNumberStepper = self:getChildGO("mNumberMultiple"):GetComponent(ty.LyNumberStepper)
    self.mNumberStepper:Init(self.mMultiTime, 1, 1, -1, self.onStepChange, self)
    self.mAwardContentLayout = self:getChildGO("mAwardContent"):GetComponent(ty.HorizontalLayoutGroup)

    self:setGuideTrans("guide_dupDaily_btn_Fight", self.mBtnFight.transform)
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
    --self.mToggleTwoFight.isOn = StorageUtil:getString1(self.mMultiStorageKey) == "1"
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
        self:addTimer(0.1, 0.1, function()
            if self.mData == nil then
                self.mData = dup.DupDailyBaseManager.mDupData
            end
            self.mDupType = self.mData.dupType
            self:updateEffect(false, self.mMainitemDic[self.mData.dupType], true)
            self:updateLevelInfo(self.mData.dupType, self.mData.dupId, true)
            self.mImgMesh:SetActive(false)
        end)
        --self.mMainitemDic[self.mData.dupType]:getGo():GetComponent(ty.Animator):SetTrigger("show")
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
    stamina.StaminaManager:removeEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.updateFightCostNum, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DUP_LEVEL_INFO, self.updateLevelAwardItem, self)
    --self.mToggleTwoFight.onValueChanged:RemoveAllListeners()
    self:clearDiscardItem()
    self.mGroupRight:SetActive(false)
    if self.mLyScroller.Count > 0 then
        self.mLyScroller:CleanAllItem()
    end
    self:updateEffect(true)
    self.mShowIndex = 0
    dup.DupDailyBaseManager.mIsShowMain = false
    gs.TransQuick:LPosX(self.mAwardContent, 0)
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
    self:addUIEvent(self.mBtnFight, self.onClickFightHandler)
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
    self:clearDoTweenItem()
    local list = dup.DupDailyMainManager:getDupEntryListByType(self:getDupType())
    for i, vo in ipairs(list) do
        if funcopen.FuncOpenManager:isOpen(vo.funcId, false) == true then
            local mainItem = SimpleInsItem:create(self:getChildGO("mGroupMain"), self.mAwardContent, "DupDailyBasePanelmGroupMainDaily")
            if (vo.type == 1 or vo.type == 2 or vo.type == 16) then
                self:setGuideTrans("guide_DupDailyItem_" .. vo.type, mainItem:getChildTrans("mImgBg"))
            end
            mainItem:getChildGO("WeakGuideUI"):SetActive(false)

            if i == 1 then
                local stageId = sysParam.SysParamManager:getValue(SysParamType.WEAKGUIDE_MAINSTAGEID)
                if not battleMap.MainMapManager:isStagePass(stageId) and not guide.GuideManager:getCurHasGuide() then
                    local time = sysParam.SysParamManager:getValue(SysParamType.WEAKGUIDE_DUPTIMEOUTTIME)
                    self:setTimeout(time, function()
                        if self.mDupType == 0 then
                            mainItem:getChildGO("WeakGuideUI"):SetActive(true)
                        end
                    end)
                end
            end

            mainItem:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("dupDaily/dup_daily_mainicon_" .. i .. ".png"), false)
            mainItem:getChildGO("mTxtName"):GetComponent(ty.Text).text = vo:getName()
            mainItem:getChildGO("mTxtDes"):GetComponent(ty.Text).text = vo:getDes()
            mainItem:getGo():GetComponent(ty.Animator):SetTrigger("exit")
            mainItem:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(vo:getUrl(), false)
            mainItem:getChildGO("mImgLockBg"):SetActive(funcopen.FuncOpenManager:isOpen(vo.funcId, false) == false)
            mainItem:getChildGO("mImgType"):SetActive(dup.DupMainManager:getIsDupUp(vo.type))
            mainItem:addUIEvent("mImgBg", function()
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
                        self.mMainitemDic[self.mDupType]:getGo():GetComponent(ty.Animator):SetTrigger("exit")
                    end
                    self.mDupType = vo.type
                end
                if self.mData then
                    self.mData = nil
                end
                if (self.mData and self.mData.isFight == false) or (self.mData == nil) then
                    mainItem:getGo():GetComponent(ty.Animator):SetTrigger("show")
                end
                dup.DupDailyBaseManager:setSelectDupId(nil)
                self.mTxtTitle.text = vo:getTitleName()
                self:updateEffect(false, self.mMainitemDic[vo.type])
                self:updateLevelInfo(vo.type, vo.id)

                for _, item in ipairs(self.mMainitemList) do
                    item:getChildGO("WeakGuideUI"):SetActive(false)
                end
            end)
            self.mMainitemDic[vo.type] = mainItem
            table.insert(self.mMainitemList, mainItem)
        end
    end
end

function getDupType(self)
    return mainPlay.MainPlayDupConst.MAINPLAYDUP_DAILY
end
--更新关卡信息
function updateLevelInfo(self, type, page, isNoClick)
    self.mCurDupType = type
    self.mIconType:SetActive(dup.DupMainManager:getIsDupUp(self.mCurDupType))
    if self.mGroupRight.activeSelf == false then
        LoopManager:addFrame(2, 1, self, function()
            self.mGroupRight:SetActive(true)
            self.mImgBtn:SetActive(true)
        end)
    else
        self.mGroupRightAni:SetTrigger("show")
    end
    if isNoClick then
        self:updateDupSelect(type)
    end
    self.mLyScroller:CleanAllItem()
    LoopManager:removeFrameByIndex(self.frameId)
    self.mTxtTitle.text = dup.DupDailyMainManager:getDupNameByType(type)
    self.mDupList = dup.DupDailyMainManager:getDupDataList(type)
    local canShowNum = math.floor(self.mLyScrollerContent.rect.height / 54)
    local tweenIndex = 0
    local isSelect = false
    local saveLastDupId = dup.DupDailyMainManager:getLastDupId(type) --缓存的最后打的副本id

    -- if dup.DupDailyBaseManager:getSelectDupId() ~= nil and dup.DupDailyBaseManager:getSelectDupId() ~= 0 then
    --     -- 单次选中进了阵容没进战斗退出来，显示刚刚临时选中的
    --     tweenIndex = self:getSelectIndex(dup.DupDailyBaseManager:getSelectDupId())
    -- else
    if saveLastDupId ~= nil and saveLastDupId ~= 0 then
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
        self.mLyScroller:SetItemIndex(0, 0, 0, 0.01)
        if canShowNum < tweenIndex then
            self.mLyScroller:SetItemIndex(tweenIndex, 0, 0, 0.1)
        end
    end)
end

function udapteCurMultiple(self)
    local multiNum = StorageUtil:getString1(self.mMultiStorageKey .. self.mCurDupType)
    self.mNumberStepper.CurrCount = ((multiNum == nil) or (multiNum == "") or (not self:getIsPassFirst())) and 1 or multiNum
    self.fightNeedMultiple = self.mNumberStepper.CurrCount
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
    if self.mMainitemDic and self.mMainitemDic[dupType] then
        self.mMainitemDic[dupType]:getGo():GetComponent(ty.Animator):SetTrigger("show")
    end
end

--动画缓动
function animatorDoTween(self)
    self.mImgMesh:SetActive(true)
    for type, item in ipairs(self.mMainitemList) do
        item:getGo():SetActive(false)
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
                self.mMainitemList[self.mShowIndex]:getGo():SetActive(true)
                self.mMainitemList[self.mShowIndex]:getGo():GetComponent(ty.Animator):SetTrigger("enter")
            end)
        end)
    end):OnComplete(function()
        if self.mData ~= nil then
            aniTime = AnimatorUtil.getAnimatorClipTime(self.mMainitemList[#self.mMainitemList]:getGo():GetComponent(ty.Animator), "AwardContent_Enter")
            self.frameId = LoopManager:addFrame(1.1, 0, self, function()
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
function updateEffect(self, isBack, item, isFightBack)
    local width = 0
    local rightWidth = self:getChildTrans("mGroupRight").rect.width
    if isBack == false then
        width = rightWidth + 100
        local tweenTime = isFightBack == true and 0.01 or 0.5
        self.mAwardContentLayout.padding.right = width
        local differenceLeftValue = item.m_trans.anchoredPosition.x - (item.m_trans.rect.width / 2) - math.abs(self.mAwardContent.anchoredPosition.x)
        local differenceRightValue = (item.m_trans.anchoredPosition.x + (item.m_trans.rect.width / 2) - math.abs(self.mAwardContent.anchoredPosition.x) - (self.mScrollView.rect.width - rightWidth))
        if differenceLeftValue < 0 then
            TweenFactory:move2LPosX(self.mAwardContent, self.mAwardContent.anchoredPosition.x - differenceLeftValue + 30, tweenTime)
        elseif differenceRightValue > 0 then
            TweenFactory:move2LPosX(self.mAwardContent, self.mAwardContent.anchoredPosition.x - differenceRightValue - 20, tweenTime)
        end
    else
        if self.mDupType ~= 0 then
            self.mMainitemDic[self.mDupType]:getGo():GetComponent(ty.Animator):SetTrigger("exit")
            self.mDupType = 0
        end
        self.mAwardContentLayout.padding.right = width
    end
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mAwardContent)
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
        if dup.DupMainManager:getIsMatchActivityMoney(dup.DupDailyUtil:getBattleType(self.mLevelData.type)) then
            local propVo = props.PropsManager:getPropsVo({ tid = sysParam.SysParamManager:getValue(SysParamType.ACTIVE_DEADLINE_PROP), num = self.mLevelData.needNum })
            propVo.state = 3
            table.insert(awardList, propVo)
        end
        if self.mLevelData.showDrop then
            for _, showDropVo in ipairs(self.mLevelData.showDrop) do
                showDropVo.state = 2
                table.insert(awardList, showDropVo)
            end
        end

        for _, awardVo in ipairs(awardList) do
            local propsGrid = PropsGrid:create(self.mGorpLevelAward, { tid = awardVo.tid, num = awardVo.num or awardVo.count }, 1, false)
            -- propsGrid:getChildGO("GroupEquip"):SetActive(false)
            if awardVo.state == 1 then
                propsGrid:setIsFirstPass(true)
            elseif awardVo.state == 3 then
                propsGrid.mPropsVo.showDrop = 4
                propsGrid:setIsDeadline(true)
            else
                propsGrid.mPropsVo.showDrop = awardVo:getDropShow()
                propsGrid:setIsProbability(awardVo:getDropShow() > 0, AwardPackConst:getAwardShowName(awardVo:getDropShow()))
            end
            table.insert(self.mPropGridList, propsGrid)
        end
        for _, type in ipairs(self.mLevelData:getSuggestEleList()) do
            local typeItem = SimpleInsItem:create(self:getChildGO("mImgType"), self.mGroupType, "DupDailyBasePanelherofighttypeImg")
            typeItem:getGo():GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl(type), false)
            table.insert(self.mEletemList, typeItem)
        end
    end
    self:updateFightCostNum()
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
--    self:updateFightCostNum()
--end
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
    dup.DupDailyBaseManager.mDupData = self.mLevelData
    dup.DupDailyBaseManager.mDupData.dupType = self.mLevelData.type
    local battleType = dup.DupDailyUtil:getBattleType(self.mLevelData.type)
    local needNum = self.mLevelData.needNum * self.fightNeedMultiple
    stamina.StaminaManager:checkStamina(battleType, nil, needNum, self.sendFight, self)
end

--查看敌人阵型
function checkEnemyFormation(self)
    if self.mLevelData then
        dup.DupDailyBaseManager.mDupData = self.mLevelData
        dup.DupDailyBaseManager.mDupData.dupType = self.mLevelData.type
        GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, { dupVo = self.mLevelData })
    end
end

--更新战斗所需物品消耗倍数
function updateFightCostNum(self)
    self:udapteCurMultiple()
    for i, grid in ipairs(self.mPropGridList) do
        if grid:getIsFirstPass() == false and (grid.mPropsVo.showDrop == 4 or grid.mPropsVo.count > 1) then
            local count = grid.mPropsVo.count;
            count = grid.mPropsVo.count * self.fightNeedMultiple;
            self.mPropGridList[i]:setCount(count)
        end
    end
    if self.mLevelData then
        self.mTxtFightNeedNum.text = self:getThreeUnaryValue(MoneyUtil.getMoneyCountByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID) >= self.fightNeedMultiple * self.mLevelData.needNum, HtmlUtil:color(self.fightNeedMultiple * self.mLevelData.needNum, "202226FF"), HtmlUtil:color(self.fightNeedMultiple * self.mLevelData.needNum, "FF0000"))
    end
end

function getIsPassFirst(self)
    for index, grid in ipairs(self.mPropGridList) do
        if grid:getIsFirstPass() == true then
            return false
        end
    end
    return true
end
--关闭信息面板
function closeInfoView(self)
    if self.mGroupRight.activeSelf == true then
        self.mImgBtn:SetActive(false)
        local AniTime = AnimatorUtil.getAnimatorClipTime(self.mGroupRightAni, "DupChipInfoView_Exit")
        self.mGroupRightAni:SetTrigger("exit")
        self.mShowSn = LoopManager:addTimer(AniTime, 1, self, function()
            self.mGroupRight:SetActive(false)
            LoopManager:removeTimerByIndex(self.mShowSn)
            self.mShowSn = nil
        end)
        self:updateEffect(true)
    end
end

-- 三目运算函数
function getThreeUnaryValue(self, conditions, leftValue, rightValue)
    return conditions and leftValue or rightValue
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
        for _, grid in ipairs(self.mAwardPropGridList) do
            grid:poolRecover()
        end
        self.mAwardPropGridList = {}
    end
end

--删除关卡奖励
function clearLevelAwardItem(self)
    if #self.mPropGridList > 0 then
        for _, grid in ipairs(self.mPropGridList) do
            grid.mPropsVo.showDrop = nil
            grid:poolRecover()
        end
        self.mPropGridList = {}
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

--删除缓动目标列表
function clearDoTweenItem(self)
    if #self.mMainitemList > 0 then
        for index, item in ipairs(self.mMainitemList) do
            self.mMainitemList[index]:poolRecover()
        end
        self.mMainitemList = {}
    end
    if self.mMainitemDic then
        for k, _ in pairs(self.mMainitemDic) do
            self.mMainitemDic[k] = nil
        end
        self.mMainitemDic = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]