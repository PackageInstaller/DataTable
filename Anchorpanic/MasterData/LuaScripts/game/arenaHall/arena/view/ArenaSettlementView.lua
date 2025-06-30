--[[ 
-----------------------------------------------------
@filename       : ArenaSettlementView
@Description    : 竞技场-段位界面
@date           : 2022-03-31 10:20:13
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("arena.ArenaSettlementView", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("arenaHall/arena/ArenaSettlementView.prefab")
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    --self:setBg("arena_bg_01.jpg", false, "arenaHall")
end

-- 初始化数据
function initData(self)
    --进度条数值
    self.mProgressNum = 0
    --进度条终值
    self.mNextPross = 0
    --进度条速率
    self.mProgressSpeed = 0
    --最新总积分
    self.mSubSorce = 0
    --是否改变段位
    self.mIsUpDan = false
    --是否掉段第一阶段完毕
    self.mIsOverDown = false
    --结算积分
    self.mSettlementSorce = 0

    self.mGroupItems = {}
end

function configUI(self)
    super.configUI(self)
    self.mGroup = self:getChildGO("mGroup")
    self.mGroupState = self:getChildGO("mGroupState")
    self.mGroupProps = self:getChildTrans("mGroupProps")
    self.mGroupPlayback = self:getChildGO("mGroupPlayback")
    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
    self.mTxtDan = self:getChildGO("mTxtDan"):GetComponent(ty.Text)
    self.mFillBar = self:getChildGO("mFillBar"):GetComponent(ty.Image)
    self.mTxtState = self:getChildGO("mTxtState"):GetComponent(ty.Text)
    self.mSliderLv = self:getChildGO("mSliderLv"):GetComponent(ty.Slider)
    self.mTxtSorceDec = self:getChildGO("mTxtSorceDec"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtCurSorce = self:getChildGO("mTxtCurSorce"):GetComponent(ty.Text)
    self.mImgState = self:getChildGO("mImgState"):GetComponent(ty.AutoRefImage)
    self.mTxtExtraSorce = self:getChildGO("mTxtExtraSorce"):GetComponent(ty.Text)
    self.mImgStateBg = self:getChildGO("mImgStateBg"):GetComponent(ty.AutoRefImage)
    self.mPreviewBtn = self:getChildGO("mPreViewBtn")
    -- self.mImgIconFlow = self:getChildGO("mImgIconFlow"):GetComponent(ty.AutoRefImage)
end

function active(self, args)
    super.active(self, args)
    self.data = args
    self.mGroup:SetActive(fight.FightManager:isReplaying() == false)
    self.mGroupPlayback:SetActive(fight.FightManager:isReplaying() == true)
    local curDanNeed = 0
    local lastScore = 0

    if not fight.FightManager:isReplaying() then
        if arena.ArenaManager.mysegment < #arena.ArenaManager.mAwardList then
            curDanNeed = arena.ArenaManager:getSegmentVo(arena.ArenaManager.mysegment + 1).needScore - arena.ArenaManager:getSegmentVo(arena.ArenaManager.mysegment).needScore
        else
            curDanNeed = arena.ArenaManager:getSegmentVo(arena.ArenaManager.mysegment).needScore - arena.ArenaManager:getSegmentVo(arena.ArenaManager.mysegment).needScore
        end

        lastScore = arena.ArenaManager.myScore - arena.ArenaManager:getSegmentVo(arena.ArenaManager.mysegment).needScore
        local lastPross = (lastScore / curDanNeed)
        self.mSliderLv.value = lastPross
        self.mSettlementSorce = self.data.args[1]
        if not self.mSettlementSorce then
            self.mSettlementSorce = 0
        end
        if self.data.state == "Win" then
            self:updateWin()
        elseif self.data.state == "Fail" then
            self:updateLose()
        end
        self:updateAward()
    end

    self.isCanClose = false
    self:setTimeout(2, function()
        self.isCanClose = true
    end)
end

function deActive(self)
    super.deActive(self)
    LoopManager:removeTimer(self, self.updateUpLoop)
    LoopManager:removeTimer(self, self.updateDownLoop)
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, { isWin = true })
    self:clearPros()
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mPreviewBtn, self.onPreviewClick)
end

function onPreviewClick(self)
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PREVIEW_SHOW)
end
--胜利状态
function updateWin(self)
    self.mSubSorce = arena.ArenaManager.myScore + self.mSettlementSorce
    self.mTxtState.text = _TT(62208)
    self:setStateImgPath("arena_win_1.png", "arena_win_2.png")
    self.mAnimator:SetTrigger("win")
    self.mTxtCurSorce.text = arena.ArenaManager.myScore >= arena.ArenaManager:getMaxSegmentNeedScore() and self.mSubSorce or arena.ArenaManager.myScore
    self.mTxtExtraSorce.text = HtmlUtil:color("+" .. math.abs(self.mSettlementSorce), "1AE92Cff")
    self.mImgIcon:SetImg(arena.ArenaManager:getLastSegmentVo(arena.ArenaManager.myScore):getRankIcon(), true)
    --d self.mImgIconFlow:SetImg(arena.ArenaManager:getLastSegmentVo(arena.ArenaManager.myScore):getRankIcon(), true)
    if ((arena.ArenaManager:getLastSegment(arena.ArenaManager.myScore) > arena.ArenaManager:getLastSegment(self.mSubSorce))) then
        self.mTxtDan.gameObject:SetActive(true)
        self.mTxtDan.text = _TT(arena.ArenaManager:getLastSegmentVo(arena.ArenaManager.myScore).rankName)
        self:setTimeout(0.5, function()
            self:updateProgressBar(0, true)
        end)
        return
    end
    self.mTxtDan.gameObject:SetActive(false)
    self:setTimeout(0.5, function()
        self:updateProgressBar(0, false)
    end)
end
--失败状态
function updateLose(self)
    self.mSubSorce = arena.ArenaManager.myScore - self.mSettlementSorce
    self.mTxtState.text = _TT(62209)
    self:setStateImgPath("arena_lose_1.png", "arena_lose_2.png")
    self.mAnimator:SetTrigger("lose")
    self.mTxtCurSorce.text = arena.ArenaManager.myScore >= arena.ArenaManager:getMaxSegmentNeedScore() and self.mSubSorce or arena.ArenaManager.myScore
    self.mTxtExtraSorce.text = HtmlUtil:color("-" .. math.abs(self.mSettlementSorce), "F34B3Fff")
    self.mImgIcon:SetImg(arena.ArenaManager:getLastSegmentVo(arena.ArenaManager.myScore):getRankIcon(), true)
    --self.mImgIconFlow:SetImg(arena.ArenaManager:getLastSegmentVo(arena.ArenaManager.myScore):getRankIcon(), true)
    --local iconPath = arena.ArenaManager:getLastSegmentVo(arena.ArenaManager.myScore):getRankIcon()
    --local sprite = gs.ResMgr:Load(iconPath)
    --self.mImgIconFlow.material:SetTexture("_Texture", sprite.texture)
    if ((arena.ArenaManager:getLastSegment(arena.ArenaManager.myScore) < arena.ArenaManager:getLastSegment(self.mSubSorce))) then
        self.mTxtDan.gameObject:SetActive(true)
        self.mTxtDan.text = _TT(arena.ArenaManager:getLastSegmentVo(arena.ArenaManager.myScore).rankName)
        self:setTimeout(1.2, function()
            self:updateProgressBar(1, true)
        end)
        return
    end
    self.mTxtDan.gameObject:SetActive(false)
    self:setTimeout(1.2, function()
        self:updateProgressBar(1, false)
    end)

end

function updateAward(self)
    self:clearPros()
    local cusPropsList = self.data.award
    local list = {}
    for _, v in ipairs(cusPropsList) do
        local configVo = props.PropsManager:getPropsConfigVo(v.tid)
        if configVo.type == PropsType.EQUIP then
            -- 服务器发来的会自动合并tid一样的，前端先全部拆分
            local count = v.count
            v.count = 1
            for i = 1, count do
                local equipVo = LuaPoolMgr:poolGet(props.EquipVo)
                equipVo:setPropsAwardMsgData(v)
                table.insert(list, equipVo)
            end
        else
            local propsVo = LuaPoolMgr:poolGet(props.PropsVo)
            propsVo:setPropsAwardMsgData(v)
            table.insert(list, propsVo)
        end
    end
    table.sort(list, bag.BagManager.sortPropsListByDescending)

    for i = 1, #list do
        local propsVo = list[i]
        local grid = ShowAwardItem:poolGet()
        grid:setData(self.mGroupProps, propsVo)
        table.insert(self.mGroupItems, grid)
    end
end

function clearPros(self)
    for i = 1, #self.mGroupItems do
        self.mGroupItems[i]:poolRecover()
    end
    self.mGroupItems = {}
end

--普通进度条 0:胜利 1：失败 
function updateProgressBar(self, state, isUp)
    if not isUp then
        isUp = false
    end
    local curscore = 0
    local curDanNeed = 0
    local lastScore = 0
    if arena.ArenaManager.myScore >= arena.ArenaManager:getMaxSegmentNeedScore() then
        self.mSliderLv.value = 1
        self:updateTxtEffect(arena.ArenaManager.myScore, self.mSubSorce, 1.5)
        return
    else
        curDanNeed = arena.ArenaManager:getSegmentVo(arena.ArenaManager.mysegment + 1).needScore - arena.ArenaManager:getSegmentVo(arena.ArenaManager.mysegment).needScore
        lastScore = arena.ArenaManager.myScore - arena.ArenaManager:getSegmentVo(arena.ArenaManager.mysegment).needScore
    end
    local lastPross = (lastScore / curDanNeed)
    self.mProgressNum = lastPross
    self.mIsUpDan = isUp
    self.mSliderLv.value = lastPross
    if state == 0 then
        self.mNextPross = (lastScore + self.mSettlementSorce) / curDanNeed
        if self.mNextPross > 1 then
            self.mSliderLv:DOValue(1, 0.5):SetLoops(1):OnStepComplete(function()
                self.mSliderLv.value = 0
                self.mSliderLv:DOValue(self.mNextPross - 1, 1)
                self.mTxtDan.text = _TT(arena.ArenaManager:getLastSegmentVo(self.mSubSorce).rankName)
                self.mImgIcon:SetImg(arena.ArenaManager:getLastSegmentVo(self.mSubSorce):getRankIcon(), true)
                --self.mImgIconFlow:SetImg(arena.ArenaManager:getLastSegmentVo(self.mSubSorce):getRankIcon(), true)
                --local iconPath = arena.ArenaManager:getLastSegmentVo(self.mSubSorce):getRankIcon()
                --local sprite = gs.ResMgr:Load(iconPath)
                --self.mImgIconFlow.material:SetTexture("_Texture", sprite.texture)
            end)
        else
            self.mSliderLv:DOValue(self.mNextPross, 1.5)
        end
    elseif state == 1 then
        self.mNextPross = (lastScore - self.mSettlementSorce) / curDanNeed
        if self.mNextPross < 0 then
            self.mSliderLv:DOValue(0, 0.5):SetLoops(1):OnStepComplete(function()
                -- self.mSliderLv.value = lastPross
                self.mSliderLv:DOValue(1 + self.mNextPross, 1)
                self.mTxtDan.text = _TT(arena.ArenaManager:getLastSegmentVo(self.mSubSorce).rankName)
                self.mImgIcon:SetImg(arena.ArenaManager:getLastSegmentVo(self.mSubSorce):getRankIcon(), true)
                --self.mImgIconFlow:SetImg(arena.ArenaManager:getLastSegmentVo(self.mSubSorce):getRankIcon(), true)
                --local iconPath = arena.ArenaManager:getLastSegmentVo(self.mSubSorce):getRankIcon()
                --local sprite = gs.ResMgr:Load(iconPath)
                --self.mImgIconFlow.material:SetTexture("_Texture", sprite.texture)
            end)
        else
            self.mSliderLv.value = lastPross
            self.mSliderLv:DOValue(self.mNextPross, 1.5)
        end
    end
    self:updateTxtEffect(arena.ArenaManager.myScore, self.mSubSorce, 1.5)
end

function onClickClose(self)
    if self.isCanClose then
        super.onClickClose(self)
    end
end

-- 数字动效
function updateTxtEffect(self, startTValue, endValue, endTime)
    local sequence = gs.DT.DOTween.Sequence()
    sequence:SetAutoKill(false):Join(gs.DT.DOTween.To(function(value)
        self.mTxtCurSorce.text = "" .. math.floor(value)
    end, startTValue, endValue, endTime))
end

--修改图片
function setStateImgPath(self, topName, downName)
    self.mImgStateBg:SetImg(UrlManager:getPackPath("arena5/" .. topName), false)
    self.mImgState:SetImg(UrlManager:getPackPath("arena5/" .. downName), true)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]