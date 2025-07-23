module("cycle.CycleMainPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(73006))
    self:setBg("infinityCity_bg_4.jpg", false, "infiniteCity")
    self:setUICode(LinkCode.Cycle)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mDifficultyItemList = {}
    self.mCurDifficulty = nil
    self.mSuggleList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBtnTask = self:getChildGO("mBtnTask")
    self.mBtnHide = self:getChildGO("mBtnHide")
    self.mBtnRank = self:getChildGO("mBtnRank")
    self.mBtnStory = self:getChildGO("mBtnStory")
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnLevel = self:getChildGO("mBtnLevel")
    self.mBtnInvest = self:getChildGO("mBtnInvest")
    self.mBtnTalent = self:getChildGO("mBtnTalent")
    self.mGroupArrow = self:getChildGO("mGroupArrow")
    self.mBtnAbandon = self:getChildGO("mBtnAbandon")
    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")
    self.mDifficultItem = self:getChildGO("mDifficultItem")
    self.mBtnCollection = self:getChildGO("mBtnCollection")
    self.mBtnDifficulty = self:getChildGO("mBtnDifficulty")
    self.mTXtlv = self:getChildGO("mTXtlv"):GetComponent(ty.Text)
    self.mTxtFight = self:getChildGO("mTxtFight"):GetComponent(ty.Text)
    self.mFightEff = self:getChildGO("mFightEff")
    self.mTxtRemTime = self:getChildGO("mTxtRemTime"):GetComponent(ty.Text)
    self.mTxtAbandon = self:getChildGO("mTxtAbandon"):GetComponent(ty.Text)
    self.mCurProgress = self:getChildGO("mCurProgress"):GetComponent(ty.Text)
    self.mImgClick = self:getChildGO("mImgClick"):GetComponent(ty.AutoRefImage)
    self.mScrollView = self:getChildGO("mScrollView"):GetComponent(ty.ScrollRect)
    self.mTxtDifficulty = self:getChildGO("mTxtDifficulty"):GetComponent(ty.Text)
    self.mImgDifficultyBg = self:getChildGO("mImgDifficultyBg"):GetComponent(ty.Image)
    self.mTxtDifficultyName = self:getChildGO("mTxtDifficultyName"):GetComponent(ty.Text)
    self.mImgEleBg = self:getChildGO("mImgEleBg")

    self:setGuideTrans("funcTips_guide_CycleMainPanel_btn_1", self:getChildTrans("mGuide_btn_1"))
    self:setGuideTrans("funcTips_guide_CycleMainPanel_btn_2", self:getChildTrans("mGuide_btn_2"))
    self:setGuideTrans("funcTips_guide_CycleMainPanel_btn_3", self:getChildTrans("mGuide_btn_3"))
    self:setGuideTrans("funcTips_guide_CycleMainPanel_btn_4", self:getChildTrans("mGuide_btn_4"))
    self:setGuideTrans("funcTips_guide_CycleMainPanel_btn_5", self:getChildTrans("mGuide_btn_5"))
    self:setGuideTrans("funcTips_guide_CycleMainPanel_btn_6", self:getChildTrans("mGuide_btn_6"))
    self:setGuideTrans("funcTips_guide_CycleMainPanel_btn_7", self:getChildTrans("mGuide_btn_7"))

end

-- 激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:dispatchEvent(EventName.HIDE_CYCLE_TOP_PANEL)
    GameDispatcher:addEventListener(EventName.UPDATE_CYCLE_MAIN_PANEL, self.updateCycleMainHandler, self)
    self:showPanel()
    self:updateDifficultySelct()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    GameDispatcher:removeEventListener(EventName.UPDATE_CYCLE_MAIN_PANEL, self.updateCycleMainHandler, self)
    if self.mMonTimeloopSn then
        LoopManager:removeTimerByIndex(self.mMonTimeloopSn)
    end
    RedPointManager:remove(self.mBtnTalent.transform)

    self:closeSuggleListItem()
end

function updateCycleMainHandler(self)
    self:showPanel()
end

function showPanel(self)

    self.mBtnAbandon:SetActive(cycle.CycleManager:getCycleDifficult() > 0)
    self.mTxtFight.text = (self.mBtnAbandon.activeSelf == true) and _TT(77598) or _TT(77597)
    --self.mFightEff:SetActive(self.mBtnAbandon.activeSelf == false)
    self.mImgClick:SetGray(false)
    if self.mBtnAbandon.activeSelf == false and self:getIsCanFight() == false then
        self.mImgClick:SetGray(true)
        self.mFightEff:SetActive(false)
    else
        self.mFightEff:SetActive(true)
    end
    self.mGroupArrow:SetActive(self.mBtnAbandon.activeSelf == false)
    local difficult = cycle.CycleManager:getCycleDifficult()
    local layer = cycle.CycleManager:getCurrentLayer()
    local curTaskOverNums, allTaskNums = cycle.CycleManager:getServerTaskProgress()
    self.mTXtlv.text = cycle.CycleManager.mHistoryInfo.lv
    self.mCurProgress.text = _TT(45013, HtmlUtil:size(curTaskOverNums, 42), allTaskNums)
    if difficult == 0 or layer == 0 then
        local isPass = cycle.CycleManager:getCycleSettIsPass()
        cycle.CycleManager:setFightEnd(true)
        if isPass then
            -- local point, addExp, statsInfo = cycle.CycleManager:getCycleSettleInfo()
            -- if point and addExp and statsInfo then
            GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_PASS_PANEL)
            --end
        else
            local point, addExp, statsInfo = cycle.CycleManager:getCycleSettleInfo()
            if point and addExp and statsInfo then
                GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_SETT_PANEL)
            end
        end

    end
    if self.mMonTimeloopSn then
        LoopManager:removeTimerByIndex(self.mMonTimeloopSn)
    end
    self.mMonTimeloopSn = self:addTimer(1, 0, self.onMonTimerLoop)
    self:onMonTimerLoop()
    self:updateRed()
end


function onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_TOP_PANEL)
    self:__closeOpenAction()
end

function getIsCanFight(self)
    local isRemaining = sysParam.SysParamManager:getValue(SysParamType.CYCLE_ABANDON_RECHALLENGE_CD) - (GameManager:getClientTime() - cycle.CycleManager:getCycleAbandonTime()) <= 0
    return isRemaining
end
-- 获取剩余时间
function updateRemainingTime(self)
    if self.mBtnAbandon.activeSelf == false and self:getIsCanFight() == false then
        local time = sysParam.SysParamManager:getValue(SysParamType.CYCLE_ABANDON_RECHALLENGE_CD) - (GameManager:getClientTime() - cycle.CycleManager:getCycleAbandonTime())
        self.mTxtFight.text = _TT(77510, HtmlUtil:size(time, 24))
        return _TT(77510, HtmlUtil:size(time, 24))
    else
        self.mImgClick:SetGray(false)
        self.mFightEff:SetActive(true)
        self.mTxtFight.text = _TT(77597)
        return
    end
end

function onMonTimerLoop(self)
    local serverTime = GameManager:getClientTime()
    local resetTime = cycle.CycleManager:getResetTime()
    local s = TimeUtil.getFormatTimeBySeconds_2(resetTime - serverTime)
    self.mTxtRemTime.text = s .. _TT(27557)
    self:updateRemainingTime()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtAbandon.text = _TT(77606)
    self:setBtnLabel(self.mBtnLevel, 77599, "记战行录")
    self:setBtnLabel(self.mBtnInvest, 77601, "无限筹资")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
    self:addUIEvent(self.mBtnInvest, self.onBtnInvestClickHandler)
    self:addUIEvent(self.mBtnFight, self.onBtnFightClickHandler)
    self:addUIEvent(self.mBtnLevel, self.onBtnLevelClickHandler)
    self:addUIEvent(self.mBtnAbandon, self.onBtnAbandonClickHandler)
    self:addUIEvent(self.mBtnTask, self.onBtnTaskClickHandler)
    self:addUIEvent(self.mBtnCollection, self.onBtnCollectionClickHandler)
    self:addUIEvent(self.mBtnHide, self.onBtnHideStateHandelr, nil, true)
    self:addUIEvent(self.mBtnDifficulty, self.onBtnHideStateHandelr, nil, false)
    self:addUIEvent(self.mBtnTalent, self.onOpenTalentPanelHandle)
    self:addUIEvent(self.mBtnStory, self.onBtnStoryClickHandler)
    self:addUIEvent(self.mBtnRank, self.onOpenRank)
end

--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.Cycle })
end

function onOpenRank(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RANK_MAIN_PANEL, { type = rank.RankConst.RANK_CYCLE })
end

function onBtnStoryClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_STORY_PANEL)
end

function onBtnInvestClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_INVEST_PANEL)
end

function onOpenTalentPanelHandle(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_TALENT_PANEL)
end

function onBtnHideStateHandelr(self, isHide)
    if self.mBtnAbandon.activeSelf == false then
        self.mBtnHide:SetActive(isHide == false)
        if isHide == false then
            self:updateDifficultySelct()
        end
    end
end

function updateDifficultySelct(self)
    self:closeSuggleListItem()
    self:closeDifficultyListItem()

    self.maxDifficult = cycle.CycleManager:getMaxDifficulty()
    if (not self.mCurDifficulty) then
        if cycle.CycleManager:getCycleDifficult() == 0 then
            self.mCurDifficulty = cycle.CycleManager:getMaxDifficultyVo()
        else
            self.mCurDifficulty = cycle.CycleManager:getDifficultVoById(cycle.CycleManager:getCycleDifficult())
        end
        self:updateCurDifficulty(self.mCurDifficulty)
    end
    local list = {}
    for _, Vo in pairs(cycle.CycleManager:getDifficultData()) do
        table.insert(list, Vo)
    end
    table.sort(list, function(vo1, vo2)
        return vo1.id > vo2.id
    end)
    for _, data in ipairs(list) do
        local item = SimpleInsItem:create(self.mDifficultItem, self.mScrollView.content, "CycleMainPanelmRogueDifficultItem")
        item:setArgs(data)
        local color = (self.mCurDifficulty.id == data.id) and "202226ff" or "ffffffff"
        local specialColor = (self.mCurDifficulty.id == data.id) and "82898Cff" or "99aec1ff"
        item:getChildGO("mImgCurBg"):SetActive(self.mCurDifficulty.id == data.id)
        item:getChildGO("mImgSelect"):SetActive(self.mCurDifficulty.id == data.id)
        item:getChildGO("mBtnSelect"):SetActive(false)
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = HtmlUtil:color(data:getTitle(), color)
        item:getChildGO("mTxtDes"):SetActive(data:getEffectDes() ~= false)
        --item:getChildGO("mTxtMonsterDes"):SetActive(data:getDifficultyDes() ~= false)
        item:getChildGO("mTxtUnLock"):GetComponent(ty.Text).text = _TT(77591)
        item:getChildGO("mTxtScoreDes"):GetComponent(ty.Text).text = HtmlUtil:color(_TT(77503, HtmlUtil:color("+" .. data:getPointMultiple(), color)), specialColor)
        if data:getEffectDes() ~= false then
            local richTxt = item:getChildGO("mTxtDes"):GetComponent(ty.TMP_Text)
            local richTxtLink = self:getChildGO("mTxtDes"):GetComponent(ty.TextMeshProLink)
            richTxtLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
            richTxt.text = data:getEffectDes()
            richTxt.color = gs.ColorUtil.GetColor(color)
        end
        item:getChildGO("mImgDifficultLine"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor(ColorUtil:getPropLineColor(data.id))
        item:getChildGO("mImgDifficultNum"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("cycle/cycleMainNum_0" .. data.id .. ".png"), true)
        local isLock = data.id > self.maxDifficult + 1
        item:getChildGO("mImgUnlock"):SetActive(isLock)
        local suggestList = data:getSuggestEle()
        for i = 1, #suggestList do
            local eleItem = SimpleInsItem:create(self.mImgEleBg, item:getChildTrans("mRecommandFormation"), "CycleMainPanelcycleDifficult")
            local type = eleItem:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
            type:SetImg(UrlManager:getHeroEleTypeIconUrl(suggestList[i]), false)
            table.insert(self.mSuggleList, eleItem)
        end
        item:getChildGO("mTxtRecommandFormation"):SetActive(#suggestList > 0)
        item:addUIEvent("mBtnSelect", function()
            if self.mCurDifficulty.id ~= data.id then
                self:updateCurDifficulty(data)
            end
        end)
        item:addUIEvent(nil, function()
            if isLock then
                gs.Message.Show(_TT(77591))
                return
            end
            self:updateDifficultyItemState(data)
        end)
        -- item:addUIEvent("mTxtDes", function()
        -- end)
        table.insert(self.mDifficultyItemList, item)
    end
end



function updateCurDifficulty(self, data)
    self.mCurDifficulty = data
    self.mImgDifficultyBg.color = gs.ColorUtil.GetColor(ColorUtil:getPropLineColor(data.id))
    self.mTxtDifficulty.text = _TT(4522) .. data.id
    self.mTxtDifficultyName.text = data:getTitle()
    self:updateDifficultyItemState(data)
end

function updateDifficultyItemState(self, data)
    for _, item in ipairs(self.mDifficultyItemList) do
        local color = (item:getArgs().id == data.id) and "202226ff" or "ffffffff"
        local specialColor = (item:getArgs().id == data.id) and "82898Cff" or "99aec1ff"
        item:getChildGO("mImgSelect"):SetActive(item:getArgs().id == data.id)
        item:getChildGO("mBtnSelect"):SetActive(
        ((data.id ~= self.mCurDifficulty.id) and (data.id == item:getArgs().id) and
        (item:getArgs().id <= self.maxDifficult + 1)))
        item:getChildGO("mImgCurBg"):SetActive(self.mCurDifficulty.id == item:getArgs().id)
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = HtmlUtil:color(item:getArgs():getTitle(), color)
        if item:getArgs():getEffectDes() ~= false then
            local richTxt = item:getChildGO("mTxtDes"):GetComponent(ty.TMP_Text)
            richTxt.text = item:getArgs():getEffectDes()
            richTxt.color = gs.ColorUtil.GetColor(color)
        end
        item:getChildGO("mTxtScoreDes"):GetComponent(ty.Text).text = HtmlUtil:color(_TT(77503, HtmlUtil:color("+" .. item:getArgs():getPointMultiple(), color)), specialColor)

        -- if item:getArgs():getDifficultyDes() ~= false then
        --     item:getChildGO("mTxtMonsterDes"):GetComponent(ty.Text).text = HtmlUtil:color(_TT(77504, HtmlUtil:color("+" .. item:getArgs():getDifficultyDes(), color)), specialColor)
        -- end
    end
end

function closeDifficultyListItem(self)
    if #self.mDifficultyItemList > 0 then
        for _, item in ipairs(self.mDifficultyItemList) do
            item:poolRecover()
            item = nil
        end
        self.mDifficultyItemList = {}
    end
end

function closeSuggleListItem(self)
    for i = 1, #self.mSuggleList do
        self.mSuggleList[i]:poolRecover()
    end
    self.mSuggleList = {}
end

function onBtnFightClickHandler(self)
    -- 如果还没有步骤数据
    if self:getIsCanFight() then
        if cycle.CycleManager:getCycleDifficult() == 0 then
            GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_STEP_INFO, {
                step = CYCLE_STEP.SELECT_DIFFICULT,
                args = { self.mCurDifficulty.id }
            })
        else -- 如果已经有了步骤数据
            cycle.CycleManager:disposeStepEvent()
        end
    else
        gs.Message.Show(self:updateRemainingTime())
    end
end

function onBtnLevelClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_LEVEL_PANEL)
end

function onBtnAbandonClickHandler(self)
    UIFactory:alertMessge(_TT(77596), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_ABANDON_CYCLE)
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
end

function onBtnTaskClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_TASK_PANEL)
end

function onBtnCollectionClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_COLLECTION_PANEL)
end

function updateRed(self)
    if cycle.CycleTalentManager:getRedFlag() then
        RedPointManager:add(self.mBtnTalent.transform, nil, 78, 12)
    else
        RedPointManager:remove(self.mBtnTalent.transform)
    end

    if cycle.CycleManager:canGetCollection() then
        RedPointManager:add(self.mBtnCollection.transform, nil, -87.5, 31.3)
    else
        RedPointManager:remove(self.mBtnCollection.transform)
    end

    if cycle.CycleManager:canGetStory() then
        RedPointManager:add(self.mBtnStory.transform, nil, -87.5, 31.3)
    else
        RedPointManager:remove(self.mBtnStory.transform)
    end

    if cycle.CycleManager:canReceiveAward() then
        RedPointManager:add(self.mBtnLevel.transform, nil, 95.26, 16.26)
    else
        RedPointManager:remove(self.mBtnLevel.transform)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27557):	"后刷新"
]]