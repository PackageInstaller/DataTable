--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeView
@Description    : 代号·希望副本页面
@date           : 2021年5月10日 14:42:50
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup.dup_codeHope.view.DupCodeHopeChapterPanel', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupCodeHope/DupCodeHopeChapterPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52086))
    self:setBg("dup_train_bg.jpg", false, "dup5")
    self:setUICode(LinkCode.ChellengeCodeHope)
end
-- 析构  
function dtor(self)
end

function initData(self)
    self.mDupItemList = {}
    self.mAniTime = 0
    self.lastX = 0
end

-- 初始化
function configUI(self)
    self.mBtnBuff = self:getChildGO("mBtnBuff")
    self.mBtnRank = self:getChildGO('mBtnRank')
    self.mBtnReset = self:getChildGO("mBtnReset")
    self.mContent = self:getChildTrans("Content")
    self.mImgPass = self:getChildTrans('mImgPass')
    self.mGroupBuff = self:getChildGO("mGroupBuff")
    self.mImgToucher = self:getChildGO("mImgToucher")
    self.mGroupInfo = self:getChildTrans("mGroupInfo")
    self.mScrollView = self:getChildTrans("Scroll View")
    self.mBtnBuffClose = self:getChildGO("mBtnBuffClose")
    self.mGroupExplore = self:getChildGO("mGroupExplore")
    self.mGroupPassTips = self:getChildGO('mGroupPassTips')
    self.mGroupChapter = self:getChildTrans("mGroupChapter")
    self.mImgBuffPrevent = self:getChildGO("mImgBuffPrevent")
    self.mTxtPro = self:getChildGO("mTxtPro"):GetComponent(ty.Text)
    self.mScrollBuffContent = self:getChildTrans("mScrollBuffContent")
    self.mImgProBar = self:getChildGO("mImgProBar"):GetComponent(ty.Image)
    self.mTxtExplore = self:getChildGO("mTxtExplore"):GetComponent(ty.Text)
    self.mTitleImg = self:getChildGO("mTitleImg"):GetComponent(ty.AutoRefImage)
    self.mImgProBg = self:getChildGO("mImgProBg"):GetComponent(ty.AutoRefImage)
    self.mTxtExploreState = self:getChildGO("mTxtExploreState"):GetComponent(ty.Text)

    self.mComplete = self:getChildGO("mComplete")

    self.mBtnHidden = self:getChildGO("mBtnHidden")
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mAwardGroup = self:getChildGO("mAwardGroup")
    self.mAwardGroupAni = self:getChildGO("mAwardGroup"):GetComponent(ty.Animator)

    self.mTxtAwardTips = self:getChildGO("mTxtAwardTips"):GetComponent(ty.Text)
    self.mTxtCondition = self:getChildGO("mTxtCondition"):GetComponent(ty.Text)

    self:setGuideTrans("funcTips_codeHope_1", self:getChildTrans("mCodeHope1"))
    self:setGuideTrans("funcTips_codeHope_2", self:getChildTrans("mGroupExplore"))

    self:setGuideTrans("funcTips_codeHope_reset", self:getChildTrans("mBtnReset"))
    self:setGuideTrans("funcTips_codeHope_explore", self:getChildTrans("mGroupExplore"))


end

-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.OPEN_CODE_HOPE_INFO, self.onOpenDupInfoHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CODE_HOPE_INFO, self.onCloseDupInfoHandler, self)
    dup.DupCodeHopeManager:addEventListener(dup.DupCodeHopeManager.EVENT_DUP_INFO_UPDATE, self.onDupInfoUpdate, self)

    if args.chapter then
        self.curChapter = args.chapter
    elseif args.dupId then
        local dupVo = dup.DupCodeHopeManager:getDupVo(args.dupId)
        self.curChapter = dupVo.chapter
        self.showDupId = args.dupId
    else
        self.curChapter = dup.DupCodeHopeManager:curChapter()
    end

    if dup.DupCodeHopeManager.activeBuffId then
        local buffId = dup.DupCodeHopeManager.activeBuffId
        GameDispatcher:dispatchEvent(EventName.OPEN_CODE_HOPE_SHOW_BUFF, buffId)
        dup.DupCodeHopeManager.activeBuffId = nil
    end

    -- self:setChapterView(self.curChapter)
    self:updateDupList(self.curChapter)

    if dup.DupCodeHopeManager.isChapterEnd then
        self:setTimeout(1, function()
            self:showChapterEndTips()
        end)
        dup.DupCodeHopeManager.isChapterEnd = false
    end

    GameDispatcher:dispatchEvent(EventName.REQ_CODE_HOPE_HERO_INFO, self.curChapter)

end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.OPEN_CODE_HOPE_INFO, self.onOpenDupInfoHandler, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_CODE_HOPE_INFO, self.onCloseDupInfoHandler, self)
    dup.DupCodeHopeManager:removeEventListener(dup.DupCodeHopeManager.EVENT_DUP_INFO_UPDATE, self.onDupInfoUpdate, self)
    LoopManager:removeFrameByIndex(self.frameId)
    if self.mShowSn then
        LoopManager:removeTimerByIndex(self.mShowSn)
        self.mShowSn = nil
    end
    self.showDupId = nil
    self.isShowBuffIng = false
    self.isCloseBuffIng = false
    -- self:getChildGO("mBtnBuffMask"):SetActive(true)
    self:recoverDupItem()
    self:onCloseDupViewHandler()
    RedPointManager:remove(self.mGroupExplore.transform)
    self.mAniTime = 0
    self.mAwardGroup:SetActive(false)

end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
    ]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtAwardTips.text = _TT(165) .. ":"--"查看奖励"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.mBtnReturn, self.onReturn)
    -- self:addUIEvent(self.mBtnFight, self.onFight)
    -- self:addUIEvent(self.mImgToucher, self.onCloseDupInfoHandler)
    self:addUIEvent(self.mBtnBuff, self.onShowEffGroup)
    self:addUIEvent(self.mBtnBuffClose, self.onCloseEffGroup)
    self:addUIEvent(self.mImgBuffPrevent, self.onCloseEffGroup)
    self:addUIEvent(self.mBtnReset, self.onReset)
    self:addUIEvent(self.mGroupExplore, self.onShowAward)
    self:addUIEvent(self.mGroupPassTips, self.onCloseChapterEndTips)
    self:addUIEvent(self.mBtnRank, self.onOpenRank)
    self:addUIEvent(self.mImgToucher, self.onScollContentClick)
    self:addUIEvent(self.mBtnHidden, self.hiddenAwardShow)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
end

function setMoneyBar(self)

end

function onOpenRank(self)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_CODE_HOPE_RANK_PANEL)
    GameDispatcher:dispatchEvent(EventName.OPEN_RANK_MAIN_PANEL, { type = rank.RankConst.RANK_CODE_HOPE })
end

function onShowEffGroup(self)
    if self.isShowBuffIng or self.isCloseBuffIng then
        return
    end
    self.isShowBuffIng = true

    -- self:getChildGO("mBtnBuffMask"):SetActive(false)
    self.mGroupBuff:SetActive(true)

    gs.TransQuick:ScaleY(self:getChildTrans("mImgBuffBg"), 0)
    self:getChildGO("mScrollBuff"):GetComponent(ty.CanvasGroup).alpha = 0

    gs.TransQuick:SizeDelta01(self:getChildTrans("mImgBuffTitileMask"), 0)
    self:getChildTrans("mImgBuffTitileMask"):DOWidth(368, 0.4)

    gs.TransQuick:UIPosX(self:getChildTrans("mBtnBuffClose"), -170)

    local sequence = gs.DT.DOTween.Sequence()
    local move = self:getChildTrans("mBtnBuffClose"):DOMoveUIX(180, 0.4)
    sequence:Join(move)
    local rotate = self:getChildTrans("mBtnBuffClose"):DOLocalRotate(gs.Vector3(0, 0, -1080), 0.4)
    sequence:Join(rotate)

    local function _tempCall()
        TweenFactory:scaleTo(self:getChildTrans("mImgBuffBg"), gs.Vector3(1, 0, 1), gs.Vector3(1, 1, 1), 0.2, nil, function()
            TweenFactory:canvasGroupAlphaTo(self:getChildGO("mScrollBuff"):GetComponent(ty.CanvasGroup), 0, 1, 0.4, nil, function()
                self.isShowBuffIng = false
            end)
        end)
    end
    sequence:OnComplete(_tempCall)
    sequence:Play()

    self:updateBuffList()
end
function onCloseEffGroup(self)
    if self.isShowBuffIng or self.isCloseBuffIng then
        return
    end

    self.isCloseBuffIng = true

    TweenFactory:canvasGroupAlphaTo(self:getChildGO("mScrollBuff"):GetComponent(ty.CanvasGroup), 1, 0, 0.2, nil, function()

        TweenFactory:scaleTo(self:getChildTrans("mImgBuffBg"), gs.Vector3(1, 1, 1), gs.Vector3(1, 0, 1), 0.2, nil, function()

            self:getChildTrans("mImgBuffTitileMask"):DOWidth(0, 0.3)

            local sequence = gs.DT.DOTween.Sequence()
            local move = self:getChildTrans("mBtnBuffClose"):DOMoveUIX(-170, 0.3)
            sequence:Join(move)
            local rotate = self:getChildTrans("mBtnBuffClose"):DOLocalRotate(gs.Vector3(0, 0, 720), 0.3, CS.DG.Tweening.RotateMode.FastBeyond360)
            sequence:Join(rotate)
            local function _tempCall()
                self.mGroupBuff:SetActive(false)
                self.isCloseBuffIng = false

                self:getChildGO("mBtnBuffMask"):SetActive(true)
                gs.TransQuick:SizeDelta01(self:getChildTrans("mBtnBuffMask"), 0)
                self:getChildTrans("mBtnBuffMask"):DOWidth(130, 0.2)
            end
            sequence:OnComplete(_tempCall)
            sequence:Play()
        end)
    end)
end

function onReset(self)
    -- if dup.DupCodeHopeManager.remaidResetTime <= 0 then
    --     -- gs.Message.Show("无重置次数")
    --     gs.Message.Show(_TT(29102))
    --     return
    -- end
    local passCount, allCount = dup.DupCodeHopeManager:getChapterProgress(self.curChapter)
    -- if passCount == 0 or passCount >= allCount then
    if passCount == 0 then
        -- gs.Message.Show("当前无法重置")
        gs.Message.Show(_TT(29116))
        return
    end


    UIFactory:alertMessge(_TT(29104) .. _TT(29105), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_CODE_HOPE_RESET, self.curChapter)
    end, nil, nil, true, nil)

    -- GameDispatcher:dispatchEvent(EventName.OPEN_CODE_HOPE_RESET, self.curChapter)
end

function onShowAward(self)
    -- local passCount, allCount = dup.DupCodeHopeManager:getChapterProgress(self.curChapter)
    local chapterVo = dup.DupCodeHopeManager:getChapterData(self.curChapter)
    local canGet = dup.DupCodeHopeManager:chapterAwardIsCanGet(self.curChapter)
    if not canGet then
        -- GameDispatcher:dispatchEvent(EventName.OPEN_DAILY_TASK_AWARD_PANEL, { tip = "探索率达到<color='#26d5d3'>100%</color>可领取", propsList = chapterVo.chapterAward })
        -- GameDispatcher:dispatchEvent(EventName.OPEN_DAILY_TASK_AWARD_PANEL, { tip = _TT(29107), propsList = chapterVo:getAwardList() })
        self:onShowAwardView({ tip = _TT(29107), propsList = chapterVo:getAwardList() })
    else
        local chapterAwardIsGain = dup.DupCodeHopeManager:chapterAwardIsGain(self.curChapter)
        if not chapterAwardIsGain then
            GameDispatcher:dispatchEvent(EventName.REQ_CODE_HOPE_CHAPTER_AWARD, self.curChapter)
        else
            -- GameDispatcher:dispatchEvent(EventName.OPEN_DAILY_TASK_AWARD_PANEL, { tip = "已领取", propsList = chapterVo.chapterAward })
            -- GameDispatcher:dispatchEvent(EventName.OPEN_DAILY_TASK_AWARD_PANEL, { tip = _TT(29108), propsList = chapterVo:getAwardList() })
            self:onShowAwardView({ tip = _TT(29108), propsList = chapterVo:getAwardList() })
        end
    end
end

-- 副本信息更新
function onDupInfoUpdate(self)
    self:updateDupList(self.curChapter)
end

function onScollContentClick(self)
    self.mImgToucher:SetActive(false)
    self:onCloseDupInfoHandler()
end

function onOpenDupInfoHandler(self, cusDupId)
    self:__onOpenDupInfoHandler(cusDupId)
    for i, item in ipairs(self.mDupItemList) do
        item:setSelectState(false)
        if cusDupId == item:getData().dupId then
            item:setSelectState(true)
            self:onScollTo(item, i)
        end
    end
end
function onCloseDupInfoHandler(self)
    if self.gInfoView then
        self.gInfoView:actionExitAni()
        self.gInfoView = nil
    end
    for i, item in ipairs(self.mDupItemList) do
        item:setSelectState(false)
    end
end

-- 副本信息
function __onOpenDupInfoHandler(self, cusDupId)
    self.mImgToucher:SetActive(true)
    if self.gInfoView == nil then
        self.gInfoView = dup.DupCodeHopeInfoView.new()
    end
    self.gInfoView:show(self.mGroupInfo, cusDupId)
end
-- 关闭副本详情
function onCloseDupViewHandler(self)
    if self.gInfoView then
        self.gInfoView:deActive()
        self.gInfoView:destroy()
        self.gInfoView = nil
    end
    self:recoverMoneyBar()
end

-- 轮次结束
function showChapterEndTips(self)
    self.mGroupPassTips.transform:SetParent(self.UIBaseTrans, false)
    self.mGroupPassTips:SetActive(true)

    gs.TransQuick:ScaleY(self.mImgPass, 0)
    self.passTween = self.mImgPass:DOScaleY(1, 0.1)
    self.passTween:OnComplete(function()
        self:setTimeout(2, function()
            self:onCloseChapterEndTips()
        end)
    end)
end

function onCloseChapterEndTips(self)
    self.passTween:Kill()
    self.passTween = nil
    gs.TransQuick:ScaleY(self.mImgPass, 1)
    self.passTween = self.mImgPass:DOScaleY(0, 0.1)
    self.passTween:OnComplete(function()
        self.mGroupPassTips:SetActive(false)
        self.mGroupPassTips.transform:SetParent(self.UITrans, false)
    end)
end

-- 打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.ChellengeCodeHope })
end

function updateDupInfo(self, chapter)

    -- self.mTitleTxt.text = ""
    self.mTitleImg:SetImg(UrlManager:getPackPath(string.format("dupCodeHope/dupCodeHope_chapter_name_%s.png", chapter)), true)

    local passCount, allCount = dup.DupCodeHopeManager:getChapterProgress(chapter)

    local isGain = dup.DupCodeHopeManager:chapterAwardIsGain(chapter)
    local canGet = dup.DupCodeHopeManager:chapterAwardIsCanGet(chapter)

    if isGain then
        self.mTxtPro.gameObject:SetActive(true)
        self.mImgProBar.gameObject:SetActive(false)
        self.mTxtExploreState.gameObject:SetActive(true)
        self.mImgProBg:SetImg(UrlManager:getPackPath("dupCodeHope/dupCodeHope_42.png"), false)
        self.mTxtExploreState.color = gs.ColorUtil.GetColor("00000099")
        self.mTxtExploreState.text = _TT(29108) -- "已领取"
        -- self.mTxtPro.text = "100%"
        self.mTxtPro.text = string.format("%.2f", passCount / allCount) * 100 .. "%"
        self.mComplete:SetActive(true)
    else
        if canGet then
            self.mTxtPro.gameObject:SetActive(true)
            self.mImgProBar.gameObject:SetActive(false)
            self.mTxtExploreState.gameObject:SetActive(true)
            self.mImgProBg:SetImg(UrlManager:getPackPath("dupCodeHope/dupCodeHope_41.png"), false)
            self.mTxtExploreState.color = gs.ColorUtil.GetColor("000000FF")
            self.mTxtExploreState.text = _TT(29109) -- "待领取"
            self.mTxtPro.text = "100%"
        else
            self.mTxtPro.gameObject:SetActive(true)
            self.mImgProBar.gameObject:SetActive(true)
            self.mTxtExploreState.gameObject:SetActive(false)
            self.mImgProBar.fillAmount = passCount / allCount
            self.mTxtPro.text = string.format("%.2f", passCount / allCount) * 100 .. "%"
            self.mImgProBg:SetImg(UrlManager:getPackPath("dupCodeHope/dupCodeHope_17.png"), false)
        end
        self.mComplete:SetActive(false)
    end

    local isFlag = dup.DupCodeHopeManager:getChapterFlag(chapter)
    if isFlag then
        RedPointManager:add(self.mGroupExplore.transform, nil, 33, 24)
    else
        RedPointManager:remove(self.mGroupExplore.transform)
    end
end

-- 更新副本列表
function updateDupList(self, chapter)
    self:updateDupInfo(chapter)
    self:recoverDupItem()

    self.lastX = 0
    local lastItem = nil
    local itemDic = {}
    local parent = self.mContent
    local baseData = dup.DupCodeHopeManager:getBaseData()
    local list = baseData[chapter].stageList
    for i = 1, #list do
        local dupId = list[i]

        local dupVo = dup.DupCodeHopeManager:getDupVo(dupId)

        local isOpen = dup.DupCodeHopeManager:getDupIsOpen(dupId)

        local item
        if dupVo.stageType == 4 then
            item = dup.DupCodeHopeDupBossItem:new()
        else
            item = dup.DupCodeHopeDupItem:new()
        end
        item:setLineActive(false)

        local preId = dupVo.preIds[1]
        local preItem = itemDic[preId]
        if preItem then
            parent = preItem:getNextPoint(dupVo.localId)
        end
        if isOpen then
            for i, v in ipairs(dupVo.preIds) do
                local preItem = itemDic[v]
                if preItem then
                    preItem:setLineActive(true)
                end
            end
        end

        -- item:setParentTrans(parent)
        item:setData(parent, dupId)
        if i == 1 then
            item:setPosition(50)
        else
            item:setPosition(0)
        end

        itemDic[dupVo.dupId] = item
        table.insert(self.mDupItemList, item)
        -- item:setLineActive(isOpen)

        if isOpen then
            -- lastItem = item
            self.lastX = math.max(self.lastX, self.mContent:InverseTransformPoint(item.UITrans.position).x)
        else
            -- if lastItem then
            --     lastItem:setLineActive(false)
            -- end
        end
    end
    -- local item = self.mDupItemList[#self.mDupItemList]
    local w = self.lastX + self.mScrollView.rect.size.x / 2 + 100
    gs.TransQuick:SizeDelta01(self.mContent, w)

    local passCount, allCount = dup.DupCodeHopeManager:getChapterProgress(self.curChapter)
    if passCount == 0 then
        self.mBtnReset:SetActive(false)
    else
        self.mBtnReset:SetActive(true)
    end

    self:scollToItem(false)
end

function recoverDupItem(self)
    for i, v in ipairs(self.mDupItemList) do
        v:setSelectState(false)
        v:poolRecover()
    end
    self.mDupItemList = {}
end

-- 设置当前的章节地图
-- function setChapterView(self, chapter)
--     self:updateDupInfo(chapter)
--     self:destroyChapterView()
--     local chapterViewGo = gs.GOPoolMgr:Get(UrlManager:getUIPrefabPath(string.format("dupCodeHope/DupCodeHopeChapter_%s.prefab", chapter)))
--     chapterViewGo.transform:SetParent(self.mGroupChapter, false)
--     self.chapterViewGo = chapterViewGo
--     self.mChapterViewGos, self.mChapterViewTrans = GoUtil.GetChildHash(self.chapterViewGo)
--     self.mScollContent = self.mChapterViewGos["Content"]
--     self.mScollContentTrans = self.mChapterViewTrans["Content"]
--     self.mScrollView = self.mChapterViewTrans["Scroll View"]
--     self:addUIEvent(self.mScollContent, self.onScollContentClick)
--     local baseData = dup.DupCodeHopeManager:getBaseData()
--     for i = 1, #baseData[chapter].stageList do
--         if self.mChapterViewGos["dupItem_" .. i] then
--             local item = dup.DupCodeHopeDupItem.new()
--             item:setup(self.mChapterViewGos["dupItem_" .. i])
--             item:setData(baseData[chapter].stageList[i])
--             table.insert(self.mDupItemList, item)
--         end
--     end
--     local passCount, allCount = dup.DupCodeHopeManager:getChapterProgress(self.curChapter)
--     if passCount == 0 or passCount >= allCount then
--         self.mBtnReset:SetActive(false)
--     else
--         self.mBtnReset:SetActive(true)
--     end
--     self:scollToItem(false)
-- end
-- function destroyChapterView(self)
--     if self.chapterViewGo then
--         self.mScollContent = nil
--         self.mScollContentTrans = nil
--         self.mScrollView = nil
--         for i = 1, #self.mDupItemList do
--             local item = self.mDupItemList[i]
--             item:destroy()
--         end
--         self.mDupItemList = {}
--         gs.GameObject.Destroy(self.chapterViewGo)
--         self.chapterViewGo = nil
--     end
-- end
function scollToItem(self)
    local curDupId = dup.DupCodeHopeManager:curDupId()
    for i = 1, #self.mDupItemList do
        local item = self.mDupItemList[i]

        local dupId = self.showDupId or (curDupId or self.mDupItemList[#self.mDupItemList]:getData().dupId)
        if dupId == item:getData().dupId then
            self:onScollTo(item)
            break
        end
        -- if self.showDupId then
        --     -- 默认不定位
        --     if self.showDupId == item:getData().dupId then
        --         self:onScollTo(item)
        --         break
        --     end
        -- end
    end

end

function onScollTo(self, item)
    local scollTo = function()
        local itemX = self.mContent:InverseTransformPoint(item.UITrans.position).x
        local posX = itemX - self.mScrollView.rect.size.x / 2 + 90

        posX = math.max(posX, 0)
        posX = -math.min(math.abs(posX), self.mContent.sizeDelta.x)
        TweenFactory:move2LPosX(self.mContent, posX, 0.3)
    end
    self.frameId = LoopManager:addFrame(3, 1, self, scollTo)
end

-- 更新buff列表
function updateBuffList(self)
    self:recoverBuffItem()
    local chapterVo = dup.DupCodeHopeManager:getChapterData(self.curChapter)
    local list = {}
    local tempList = {}
    for i, v in ipairs(chapterVo.buffList) do
        if dup.DupCodeHopeManager:buffIsActive(v) then
            table.insert(list, v)
        else
            table.insert(tempList, v)
        end
    end
    list = table.mergeAll(list, tempList)
    table.sort(list)

    for i, v in ipairs(list) do
        local buffVo = dup.DupCodeHopeManager:getBuffData(v)
        local skillVo = fight.SkillManager:getSkillRo(buffVo.skillId)
        local item = SimpleInsItem:create(self:getChildGO("GroupBuffItem"), self.mScrollBuffContent, "DupCodeHopeChapterBuffItem")
        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(buffVo.icon), true)
        if dup.DupCodeHopeManager:buffIsActive(buffVo.id) then
            item:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("dupCodeHope/dupCodeHope_26.png"))
            item:getChildGO("mImgIcon"):GetComponent(ty.CanvasGroup).alpha = 1
            item:getChildGO("mImgLock"):SetActive(false)
            item:getChildGO("mImgLine"):SetActive(true)
            item:getChildGO("mTxtInfo"):SetActive(false)
            item:setText("mTxtName", nil, skillVo:getName())
            item:setText("mTxtDes", nil, skillVo:getDesc())
        else
            item:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("dupCodeHope/dupCodeHope_27.png"))
            item:getChildGO("mImgIcon"):GetComponent(ty.CanvasGroup).alpha = 0.2
            item:getChildGO("mImgLock"):SetActive(true)
            item:getChildGO("mImgLine"):SetActive(false)
            item:getChildGO("mTxtInfo"):SetActive(true)
            item:setText("mTxtInfo", buffVo.langId)
        end

        table.insert(self.mBuffList, item)
    end
end
-- 回收项
function recoverBuffItem(self)
    if self.mBuffList then
        for i, v in pairs(self.mBuffList) do
            v:poolRecover()
        end
    end
    self.mBuffList = {}
end


-- 探索度奖励展示
function onShowAwardView(self, data)
    self.mAwardGroup:SetActive(true)
    if (self.mAwardGroup.activeSelf == true) then
        self:recoverPropsList()
        self.mBtnHidden:SetActive(true)
        for _, vo in ipairs(data.propsList) do
            local count = vo.count and vo.count or vo.num
            local propsGrid = PropsGrid:createByData({ tid = vo.tid, num = count, parent = self.mAwardContent, isTween = true, showUseInTip = false })
            table.insert(self.mPropsList, propsGrid)
        end
        self.mTxtCondition.text = data.tip
        self.mAwardGroupAni:SetTrigger("enter")
    end
end

function recoverPropsList(self)
    if self.mPropsList then
        for i = 1, #self.mPropsList do
            self.mPropsList[i]:poolRecover()
        end
    end
    self.mPropsList = {}
end

function hiddenAwardShow(self)
    if self.mAwardGroup.activeSelf == true then
        local aniTime = AnimatorUtil.getAnimatorClipTime(self.mAwardGroupAni, "AwardGroup_Enter")
        self.mAwardGroupAni:SetTrigger("exit")
        self:addTimer(aniTime, aniTime, function()
            self:recoverPropsList()
            self.mAwardGroup:SetActive(false)
            self.mBtnHidden:SetActive(false)
        end)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]