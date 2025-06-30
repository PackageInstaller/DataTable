module("task.AchievementPreviewTabView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("achievement/AchievementPreviewTab.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isShow3DBg = 1
--构造函数
function ctor(self)
    super.ctor(self)
    local w, h = ScreenUtil:getScreenSize()
    self:setSize(w, h)
    self:setTxtTitle(_TT(72106))
    self:setBg("common_bg_015.jpg", false)
end

-- 初始化数据
function initData(self)
    self.mPropsList = {}
    --当前奖励弹窗索引
    self.mCurIndex = 0
    self:recoverPreviewList()
    self:recoverScoreList()
end

-- 关闭所有UI
function onCloseAllCall(self)
    self:playerClose()
    super.onCloseAllCall(self)
end

-- 玩家点击关闭
function onClickClose(self)
    self:playerClose()
    super.onClickClose(self)
end

function playerClose(self)
    self:initData()
end

function configUI(self)
    self.mBtnHide = self:getChildGO("mBtnHide")
    self.mScoreItem = self:getChildGO('mScoreItem')
    self.mPreviewItem = self:getChildGO('mPreviewItem')
    self.mAwardGroup = self:getChildTrans("mAwardGroup")
    self.mImgLeftArrow = self:getChildGO("mImgLeftArrow")
    self.mProgressBar = self:getChildTrans("mProgressBar")
    self.mProgressTip = self:getChildTrans("mProgressTip")
    self.mImgRightArrow = self:getChildGO("mImgRightArrow")
    self.mProgressRect = self:getChildTrans('mProgressRect')
    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mAwardTipsGroup = self:getChildGO("mAwardTipsGroup")
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)
    self.mTextTip = self:getChildGO('mTextTip'):GetComponent(ty.Text)
    self.mBar = self:getChildGO("mBar"):GetComponent(ty.AutoRefImage)
    self.mTxtTitle = self:getChildGO('mTxtTitle'):GetComponent(ty.Text)
    self.mImgRound3 = self:getChildGO("mImgRound3"):GetComponent(ty.Image)
    self.mImgRound6 = self:getChildGO("mImgRound6"):GetComponent(ty.Image)
    self.mTxtCondition = self:getChildGO("mTxtCondition"):GetComponent(ty.Text)
    self.mTxtAwardTips = self:getChildGO("mTxtAwardTips"):GetComponent(ty.Text)
    self.mTextCurCount = self:getChildGO('mTextCurCount'):GetComponent(ty.Text)
    self.mTextAllCount = self:getChildGO('mTextAllCount'):GetComponent(ty.Text)
    self.mAwardTipsAni = self:getChildGO("mAwardTipsGroup"):GetComponent(ty.Animator)
    self.mProgressScroll = self:getChildGO("mProgressScroll"):GetComponent(ty.ScrollRect)
    self.mProScrollRect = self:getChildGO("mProgressScroll"):GetComponent(ty.RectTransform)
end


function active(self, args)
    super.active(self, args)
    self.mBtnHide:SetActive(false)
    self.mAwardTipsGroup:SetActive(false)
    local function scrollRectValueChange(value)
        local progress = value.x
        if progress < 0.01 then
            self.mImgLeftArrow:SetActive(false)
        elseif progress > 0.99 then
            self.mImgRightArrow:SetActive(false)
        else
            self.mImgLeftArrow:SetActive(true)
            self.mImgRightArrow:SetActive(true)
        end
    end
    self.mProgressScroll.onValueChanged:AddListener(scrollRectValueChange)
    GameDispatcher:addEventListener(EventName.UPDATE_ACHIEVEMENT_SCORE_AWARD, self.__onUpdateScoreAwardHandler, self)
    self:updateView()
    self:updateRedHandler()
    if not self.isReshow then
        self.mAnimator:SetTrigger("show")
        self:moveCanRecive()
    end
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ACHIEVEMENT_SCORE_AWARD, self.__onUpdateScoreAwardHandler, self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
    self.mBtnHide:SetActive(false)
    self.mAwardTipsGroup:SetActive(false)
    LoopManager:removeFrameByIndex(self.mNumSign)
    LoopManager:removeTimerByIndex(self.mNumTimeSign)
    self:recoverPropsList()
    self.mNumTimeSign = nil
    self.mNumSign = nil
end

function initViewText(self)
    self.mTextTip.text = _TT(36518) --"总成就个数"
    self.mTxtTitle.text = _TT(36519) --"成就奖励"
    self.mTxtAwardTips.text = _TT(165)--"奖励查看"
end

-- UI事件管理
function addAllUIEvent(self)
    local list = { task.AchievementTab.STORY, task.AchievementTab.DEVELOPMENT, task.AchievementTab.HERO, task.AchievementTab.OTHER }
    for i, tabType in ipairs(list) do
        self:addUIEvent(self:getChildGO("mBtnGroup" .. tabType), self.onClickOpenView, nil, tabType)
    end
    self:addUIEvent(self.mBtnHide, self.onClickHideAwardTips)
end

function __onUpdateScoreAwardHandler(self, args)
    self:updateScoreList(false)
end

function updateRedHandler(self)
    local list = { task.AchievementTab.STORY, task.AchievementTab.DEVELOPMENT, task.AchievementTab.HERO, task.AchievementTab.OTHER }
    for i, tabType in ipairs(list) do
        if task.AchievementManager:judgeIsTypeCanRes(tabType) then
            if self.mPreviewItemList[i].tabType == tabType then
                if tabType % 2 == 0 then
                    RedPointManager:add(self:getChildTrans("mRedTrans" .. tabType), nil, 0, 0)
                else
                    RedPointManager:add(self:getChildTrans("mRedTrans" .. tabType), nil, 0, 0)
                end
            end
        else
            if self.mPreviewItemList[i].tabType == tabType then
                RedPointManager:remove(self:getChildTrans("mRedTrans" .. tabType))
            end
        end
    end
end

function updateView(self)
    if task.AchievementManager:getLastValue() == 0 then
        task.AchievementManager:setLastValue(task.AchievementManager:getCompleteNum(nil))
    end
    self.mTextAllCount.text = task.AchievementManager:getAchievementConfigPointNum(nil)
    self.mTxtNum.text = task.AchievementManager:getCompleteNum(nil) .. HtmlUtil:colorAndSize("/" .. task.AchievementManager:getAchievementConfigPointNum(nil), "404548", 18)
    self:updatePreviewList()
    self:updateScoreList(true)
    if self.isReshow ~= nil then
        self:updateTxtEffect(task.AchievementManager:getLastValue(), task.AchievementManager:getCompleteNum(nil), 0.8)
        task.AchievementManager:setLastValue(task.AchievementManager:getCompleteNum(nil))
    else
        self.mTextCurCount.text = task.AchievementManager:getCompleteNum(nil)
        self.mImgRound6.fillAmount = task.AchievementManager:getCompleteNum(nil) / task.AchievementManager:getAchievementConfigPointNum(nil)
        self.mImgRound3.fillAmount = task.AchievementManager:getCompleteNum(nil) / task.AchievementManager:getAchievementConfigPointNum(nil)
    end
end

function updatePreviewList(self)
    self:recoverPreviewList()
    local list = { task.AchievementTab.STORY, task.AchievementTab.DEVELOPMENT, task.AchievementTab.HERO, task.AchievementTab.OTHER }
    for i = 1, #list do
        local tabType = list[i]
        local curCount = task.AchievementManager:getCompleteNum(tabType)
        local achievementConfigList = task.AchievementManager:getAchievementConfigList(tabType)
        local allCount = task.AchievementManager:getAchievementConfigPointNum(tabType)--#achievementConfigList 
        local needShow = #achievementConfigList > 0

        if (needShow) then
            local item = SimpleInsItem:create(self.mPreviewItem, self:getChildTrans("mPos" .. tabType), self.__cname .. "_achievement_preview_item")
            local textName = item:getChildGO("mTxtName"):GetComponent(ty.Text)
            local progressBar = item:getChildGO("ProgressBar"):GetComponent(ty.ProgressBar)
            progressBar:InitData(0)
            progressBar:SetValue(curCount, allCount, false)
            item.tabType = tabType
            item:getChildGO("mTxtShowProgress"):GetComponent(ty.Text).text = curCount .. HtmlUtil:colorAndSize("/" .. allCount, "404548", 18)
            textName.text = task.getPageName(tabType)
            item:getChildGO("mImgStyle"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("achievement/achievement_item_icon_" .. tabType .. ".png"), false)
            table.insert(self.mPreviewItemList, item)
        end
    end
end

--阶段奖励预览弹窗
function updateAwardShow(self, item, index)
    self.mAwardTipsGroup:SetActive(true)
    if (self.mAwardTipsGroup.activeSelf == true) and (self.mCurIndex ~= index) then
        self:recoverPropsList()
        self.mCurIndex = index
        local pos = item:getTrans().anchoredPosition.x - (self.mProgressScroll.gameObject.transform.rect.width / 2) + 18.2 --math.abs(self.mGuideGroup.transform.rect.width) - (item.trans.anchoredPosition.x + math.abs(self.mAwardTipsGroup.transform.rect.width / 2)) + self.mGroupBox.sizeDelta.x
        gs.TransQuick:LPosX(self.mAwardTipsGroup.transform, pos)
        self.mBtnHide:SetActive(true)
        for _, propVo in ipairs(item:getArgs():getAwardList()) do
            local propItem = PropsGrid:createByData({ tid = propVo.tid, num = propVo.num, parent = self.mAwardContent, scale = 1, showUseInTip = true })
            table.insert(self.mPropsList, propItem)
        end
        self.mTxtCondition.text = item.tip
        self.mAwardTipsAni:SetTrigger("enter")
    end
end

function updateScoreList(self, isInit)
    self:recoverScoreList()
    local curShowW = nil
    local list = task.AchievementManager:getAchieveScoreConfigList()
    local finish = 0
    local currFinScore = 0
    local nextFinScore = nil
    local CurSumLength = task.AchievementManager:getAchieveMaxScoreByConfig() * 3
    local curSumDifValue = 0
    if task.AchievementManager:getAchieveMaxScoreByConfig() <= 300 then
        curSumDifValue = (300 - task.AchievementManager:getAchieveMaxScoreByConfig())
        CurSumLength = 900
    end
    gs.TransQuick:SizeDelta01(self.mProgressBar, CurSumLength)
    gs.TransQuick:SizeDelta01(self.mAwardGroup, CurSumLength + 30)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mProgressRect)
    for i = 1, #list do
        local scoreConfigVo = list[i]
        local item = SimpleInsItem:create(self.mScoreItem, self:getChildTrans("mAwardGroup"), self.__cname .. "_achievement_score_item")
        local textScore = item:getChildGO("TextScore"):GetComponent(ty.Text)
        local groupCanRec = item:getChildGO("GroupCanRec")
        local groupHadRec = item:getChildGO("GroupHadRec")
        local groupUnRec = item:getChildGO("mImgUnRec")
        local gridNode = item:getChildTrans("GridNode")
        textScore.text = scoreConfigVo.score
        local state = task.AchievementManager:getScoreAwardState(scoreConfigVo.id)
        groupCanRec:SetActive(state == task.AwardRecState.CAN_REC)
        item:setArgs(scoreConfigVo)
        groupHadRec:SetActive(state == task.AwardRecState.HAS_REC)
        groupUnRec:SetActive(state == task.AwardRecState.UN_REC)
        if state ~= task.AwardRecState.UN_REC then
            finish = finish + 1
            currFinScore = scoreConfigVo.score
        elseif state == task.AwardRecState.UN_REC and currFinScore ~= nil and nextFinScore == nil then
            nextFinScore = scoreConfigVo.score
        end

        local function _clickScoreItemFun()
            if (state == task.AwardRecState.UN_REC) then
                item.tip = string.format(_TT(36514), scoreConfigVo.score)
                self:updateAwardShow(item, i)
            elseif (state == task.AwardRecState.HAS_REC) then
                item.tip = _TT(29108)
                self:updateAwardShow(item, i)
            elseif (state == task.AwardRecState.CAN_REC) then
                GameDispatcher:dispatchEvent(EventName.REQ_REC_ACHIEVEMENT_SCORE_AWARD, { scoreId = scoreConfigVo.id })
            end
        end
        item:addUIEvent("ImgClick", _clickScoreItemFun)
        gs.TransQuick:LPosX(item:getTrans(), self:getItemPos(scoreConfigVo.score))
        table.insert(self.mScoreItemList, item)
    end
    self.mBar.fillAmount = (task.AchievementManager:getCompleteNum(nil)) / list[#list].score
end

function getItemPos(self, score)
    if task.AchievementManager:getAchieveMaxScoreByConfig() <= 300 then
        local psoX = (score / task.AchievementManager:getAchieveMaxScoreByConfig()) * 900
        return psoX
    else
        return score * 3
    end
end

function onClickOpenView(self, index)
    GameDispatcher:dispatchEvent(EventName.OPEN_ACHIEVEMENT_PANEL, { type = index })
end


function onClickHideAwardTips(self)
    if self.mBtnHide.activeSelf == true then
        local aniTime = AnimatorUtil.getAnimatorClipTime(self.mAwardTipsAni, "AwardTipsGroup_Enter")
        self.mAwardTipsAni:SetTrigger("exit")
        self:addTimer(aniTime, aniTime, function()
            self:recoverPropsList()
            self.mBtnHide:SetActive(false)
            self.mAwardTipsGroup:SetActive(false)
            self.mCurIndex = 0
        end)
    end
end

function recoverPreviewList(self)
    if (self.mPreviewItemList) then
        for _, item in pairs(self.mPreviewItemList) do
            RedPointManager:remove(self:getChildTrans("mRedTrans" .. item.tabType))
            item:poolRecover()
        end
    end
    self.mPreviewItemList = {}
end

function recoverPropsList(self)
    if (#self.mPropsList > 0) then
        for _, item in ipairs(self.mPropsList) do
            item:poolRecover()
        end
    end
    self.mPropsList = {}
end

-- 数字动效
function updateTxtEffect(self, startTValue, endValue, endTime)
    local sequence = gs.DT.DOTween.Sequence()
    sequence:SetAutoKill(false):Join(gs.DT.DOTween.To(function(value)
        self.mTextCurCount.text = "" .. math.floor(value)
        self.mImgRound6.fillAmount = value / task.AchievementManager:getAchievementConfigPointNum(nil)
        self.mImgRound3.fillAmount = value / task.AchievementManager:getAchievementConfigPointNum(nil)
    end, startTValue, endValue, endTime))
end
--最新可领取奖励位置显示在可显示位置
function moveCanRecive(self)
    local targetItem
    for i, vo in ipairs(task.AchievementManager:getAchieveScoreConfigList()) do
        if task.AchievementManager:getScoreAwardState(vo.id) == task.AwardRecState.CAN_REC then
            targetItem = self.mScoreItemList[i]
        end
    end
    if not targetItem then
        return
    end
    local scrollRightPosX = self.mProScrollRect.rect.width
    local targetPosX = targetItem:getGo():GetComponent(ty.RectTransform).anchoredPosition.x + (targetItem:getGo():GetComponent(ty.RectTransform).rect.width / 2)
    local difRightValue = targetPosX - scrollRightPosX
    if difRightValue > 0 then
        TweenFactory:move2LPosX(self.mProgressRect, self.mProgressRect.anchoredPosition.x - difRightValue, 0.5)
    end
end

function recoverScoreList(self)
    if (self.mPropsGridList) then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
    end
    self.mPropsGridList = {}
    if (self.mScoreItemList) then
        for k, item in pairs(self.mScoreItemList) do
            item:poolRecover()
        end
    end
    self.mScoreItemList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]