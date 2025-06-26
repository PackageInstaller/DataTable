-- @FileName:   SandPlayFishingUI.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.view.SandPlayFishingUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("sandPlay/SandPlayFishingUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
isShowCloseAll = 0 --是否显示导航按钮

function ctor(self)
    super.ctor(self)

    self:setSize(750, 600)
    self:setBg("")
    self:setTxtTitle(_TT(95007))
    self:initData()
end

-- 初始化数据
function initData(self)
    self.mProgressRedValue = sysParam.SysParamManager:getValue(5597)
    self.mProgressRedYellowValue = sysParam.SysParamManager:getValue(5598)
    self.mFishSignMoveSpeed = sysParam.SysParamManager:getValue(5593)

    self.mRangeMinWidth = 68
end

-- 初始化
function configUI(self)
    self.mBaitGroup = self:getChildGO("mBaitGroup")

    self.mBtnFishing = self:getChildGO("mBtnFishing"):GetComponent(ty.LongPressOrClickEventTrigger)
    self.mImgFish1 = self:getChildGO("mImgFish1")
    self.mImgFish2 = self:getChildGO("mImgFish2")
    self.mImgFish3 = self:getChildGO("mImgFish3")

    self.mBtnAtlas = self:getChildGO("mBtnAtlas")
    self.mBtnTeaching = self:getChildGO("mBtnTeaching")

    self.mBaitTipsGroup = self:getChildGO("mBaitTipsGroup")
    self.mTextBaitTipsName = self:getChildGO("mTextBaitTipsName"):GetComponent(ty.Text)
    self.mTextBaitTips = self:getChildGO("mTextBaitTips"):GetComponent(ty.Text)

    self.mProgressGroup = self:getChildGO("mProgressGroup")
    self.mImgFishTime_1 = self:getChildGO("mImgFishTime_1"):GetComponent(ty.Image)
    self.mImgFishTime_2 = self:getChildGO("mImgFishTime_2"):GetComponent(ty.Image)
    self.mImgFishTime_3 = self:getChildGO("mImgFishTime_3"):GetComponent(ty.Image)
    self.mImgFishSign = self:getChildGO("mImgFishSign"):GetComponent(ty.RectTransform)

    self.mImgFishRange = self:getChildGO("mImgFishRange"):GetComponent(ty.RectTransform)

    self.mImgEmpty = self:getChildGO("mImgEmpty")

    self.mAutoBtn = self:getChildGO("mAutoBtn")
    self.mAutoBtnChildGo = GoUtil.GetChildHash(self.mAutoBtn)

    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(sandPlay.SandPlayFishingBaitItem)
end

function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAtlas, self.onOpenAtlas)
    self:addUIEvent(self.mBtnTeaching, self.onOpenTeaching)

    self:addUIEvent(self.mImgEmpty, self.onClickEmpty)

    self:addUIEvent(self.mAutoBtn, self.onClickAutoFish)
end

-- -- 设置货币栏
function setMoneyBar(self)
end

-- 增加长按事件
function onAddPointerEvent(self)
    local function _onPointerClickHandler()
        if self.mEatFish_info then
            return
        end

        self:onFishing()
    end
    self.mBtnFishing.onClick:AddListener(_onPointerClickHandler)

    local function _onPointerDownHandler()
        if self.mAutoFishState then
            return
        end

        if not self.mEatFish_info then
            return
        end

        self.mBuoyDir = 1
    end
    self.mBtnFishing.onPointerDown:AddListener(_onPointerDownHandler)

    local function _onPointerUpHandler()
        if self.mAutoFishState then
            return
        end

        if not self.mEatFish_info then
            return
        end

        self.mBuoyDir = -1
    end
    self.mBtnFishing.onPointerUp:AddListener(_onPointerUpHandler)
end

-- 移除长按事件
function onRemovePointerEvent(self)
    self.mBtnFishing.onClick:RemoveAllListeners()
    self.mBtnFishing.onPointerDown:RemoveAllListeners()
    self.mBtnFishing.onPointerUp:RemoveAllListeners()
end

--激活
function active(self, args)
    super.active(self)

    GameDispatcher:addEventListener(EventName.SANDPLAY_FISHING_BAITSELECT, self.onShowBaitTips, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_FISHING_FISHEAT, self.onFishEat, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_START_FISHING, self.onFishing, self)

    GameDispatcher:addEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updataRedState, self)

    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.refreshBait, self)

    self:onAddPointerEvent()

    self.mBaitTipsGroup:SetActive(false)
    self.mImgFish1:SetActive(true)
    self.mImgFish2:SetActive(false)
    self.mImgFish3:SetActive(false)

    self.mProgressGroup:SetActive(false)

    if sandPlay.SandPlayManager:getFishingActivityOpenRedState() then
        self:onOpenTeaching()
    end

    StorageUtil:saveNumber1(gstor.SANDPLAY_FISHING_OPENRED, GameManager:getClientTime())

    self:openBaitView()

    self:updataRedState()

    self.mAutoFishState = sandPlay.SandPlayManager:isAutoFish()
    self:refreshAutoFish()
end
--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.SANDPLAY_FISHING_BAITSELECT, self.onShowBaitTips, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_FISHING_FISHEAT, self.onFishEat, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_START_FISHING, self.onFishing, self)

    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updataRedState, self)

    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.refreshBait, self)

    self:onRemovePointerEvent()

    self:clearFrame()
    self:KillTween()
    self.mEatFish_info = nil

    -- sandPlay.SandPlayManager:setFishingBait(nil)
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_EXIT_FISHING)
end

-- 打开教学
function onOpenTeaching(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_FISH_TEACHING_VIEW, {resList = {"fish_tips_1", "fish_tips_2", "fish_tips_3"}, des = {98968, 98969, 98970}})
end

function onClickEmpty(self)
    self.mBaitTipsGroup:SetActive(false)
end

function onClickAutoFish(self)
    if not sandPlay.SandPlayManager:canAutoFish() then
        gs.Message.Show(_TT(98975))
        return
    end

    self.mAutoFishState = not self.mAutoFishState

    StorageUtil:saveBool1(gstor.SANDPLAY_PLAYER_FISHAUTOSTATE, self.mAutoFishState)

    self:refreshAutoFish()
end

function refreshAutoFish(self)
    self.mAutoBtnChildGo["mNormal"]:SetActive(not self.mAutoFishState)
    self.mAutoBtnChildGo["mSelect"]:SetActive(self.mAutoFishState)
end

function onFishEat(self, fish_info)
    if not self.mProgressGroup.activeSelf then
        self.mProgressGroup:SetActive(true)
    end

    self.mImgFish1:SetActive(false)
    self.mImgFish2:SetActive(true)
    self.mImgFish3:SetActive(false)

    self.mEatFish_info = fish_info
    self.mEatFishConfig = sandPlay.SandPlayManager:getFishConfigVo(self.mEatFish_info.fish_id)

    self.mBuoyDir = -1 --浮标移动的方向
    self.mLateRangeMoveTime = GameManager:getClientTime()--有效区域上次移动的时间

    self.mFish_FillAmount = 0
    self:refreshFishingProgress(sysParam.SysParamManager:getValue(5592))

    self.mImgFishSign.anchoredPosition = gs.Vector2(0, self.mImgFishSign.anchoredPosition.y)

    self.mImgFishRange.sizeDelta = gs.Vector2(self.mRangeMinWidth + self.mEatFishConfig.begin_buoy, self.mImgFishRange.rect.height)
    self.mImgFishRange.anchoredPosition = gs.Vector2(0, self.mImgFishRange.anchoredPosition.y)

    self:clearFrame()
    self.mFrameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
end

function clearFrame(self)
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
end

function onFrame(self)
    ---更新浮标位置
    local minFishSignPos_x, maxFishSignPos_x = -217, 213

    if not self.mAutoFishState then
        if self.mImgFishSign.anchoredPosition.x >= minFishSignPos_x and self.mImgFishSign.anchoredPosition.x <= maxFishSignPos_x then
            local anchoredPosition_x = self.mImgFishSign.anchoredPosition.x + gs.Time.deltaTime * self.mBuoyDir * self.mFishSignMoveSpeed
            if anchoredPosition_x < minFishSignPos_x then
                anchoredPosition_x = minFishSignPos_x
            elseif anchoredPosition_x > maxFishSignPos_x then
                anchoredPosition_x = maxFishSignPos_x
            end
            self.mImgFishSign.anchoredPosition = gs.Vector2(anchoredPosition_x, self.mImgFishSign.anchoredPosition.y)
        end
    else
        self.mImgFishSign.anchoredPosition = gs.Vector2(self.mImgFishRange.anchoredPosition.x, self.mImgFishSign.anchoredPosition.y)

        gs.TransQuick:SetLRotation(self.mAutoBtnChildGo["mImgAutoSelect"].transform, 0, 0, gs.TransQuick:GetRotationZ(self.mAutoBtnChildGo["mImgAutoSelect"].transform) + 3)
    end

    local fishRangeWidth_half = (self.mImgFishRange.rect.width - self.mRangeMinWidth) / 2 --一半宽度
    local minRange_posX = self.mImgFishRange.anchoredPosition.x - 22 - fishRangeWidth_half --最小位置
    local maxRange_posX = self.mImgFishRange.anchoredPosition.x + 22 + fishRangeWidth_half --最大位置
    if (self.mImgFishSign.anchoredPosition.x < minRange_posX) or (self.mImgFishSign.anchoredPosition.x > maxRange_posX) then
        self:refreshFishingProgress(-gs.Time.deltaTime * self.mEatFishConfig.reduce_fillAmount)

    else
        self:refreshFishingProgress(gs.Time.deltaTime * self.mEatFishConfig.add_fillAmount)
    end

    --如果当前的钓鱼时间停留 大于
    if GameManager:getClientTime() - self.mLateRangeMoveTime > self.mEatFishConfig.stay_time then
        --检测绿色区域移动
        for i = 1, #self.mEatFishConfig.buoy_length do
            local range = self.mEatFishConfig.buoy_length[i][1]
            if self.mFish_FillAmount >= range[1] and self.mFish_FillAmount <= range[2] then

                local widthRange = self.mEatFishConfig.buoy_length[i][2]
                local minWidth = widthRange[1]
                local maxWidth = widthRange[2]

                --最小68，最大500 68长度最大位置 217 最小位置 - 216
                local randomWidth = math.random(minWidth, maxWidth) + self.mRangeMinWidth

                --最小位置 -216 最大位置 211
                local randomWidth_half = randomWidth / 2
                local minPos_x = -216 + randomWidth_half
                local maxPos_x = 216 - randomWidth_half

                self:KillTween()

                local random_posX = minPos_x

                local min_posDiff = math.abs(self.mRangeMinWidth + self.mEatFishConfig.begin_buoy) / 2
                if 500 - randomWidth > min_posDiff then
                    random_posX = self:getRandom(minPos_x, maxPos_x, min_posDiff)
                end

                local time = math.abs(random_posX - self.mImgFishRange.anchoredPosition.x) / self.mEatFish_info.buoy_move_speed
                self.mTweenRange_AnchorPosX = self:DOAnchorPosX(self.mImgFishRange, random_posX, time)

                self.mTweenRange_SizeDelta = self:DOSizeDelta(self.mImgFishRange, gs.Vector2(randomWidth, self.mImgFishRange.rect.height), 0.3)

                self.mLateRangeMoveTime = GameManager:getClientTime() + time
                break
            end
        end
    end
end

--更新钓鱼的进度
function refreshFishingProgress(self, value)
    self.mFish_FillAmount = self.mFish_FillAmount + value

    self.mImgFishTime_1.gameObject:SetActive(self.mFish_FillAmount <= self.mProgressRedValue)
    self.mImgFishTime_2.gameObject:SetActive(self.mFish_FillAmount > self.mProgressRedValue and self.mFish_FillAmount <= self.mProgressRedYellowValue)
    self.mImgFishTime_3.gameObject:SetActive(self.mFish_FillAmount > self.mProgressRedYellowValue)

    local fillAmount = self.mFish_FillAmount / 100
    self.mImgFishTime_1.fillAmount = fillAmount
    self.mImgFishTime_2.fillAmount = fillAmount
    self.mImgFishTime_3.fillAmount = fillAmount

    if self.mFish_FillAmount >= 100 then
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_FISHING_SUCCESS)

        if not sandPlay.SandPlayManager:canAutoFish() then
            local fishCount = StorageUtil:getNumber1(gstor.SANDPLAY_PLAYER_FISH_COUNT)
            fishCount = fishCount + 1
            StorageUtil:saveNumber1(gstor.SANDPLAY_PLAYER_FISH_COUNT, fishCount)

            local autoCount = sysParam.SysParamManager:getValue(SysParamType.SandPlayAutoFishCount)
            if fishCount >= autoCount then
                StorageUtil:saveNumber1(gstor.SANDPLAY_PLAYER_FISHAUTO, GameManager:getClientTime())
            end
        end
    elseif self.mFish_FillAmount <= 0 then
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_FISHING_FAIL)
    end

end

function KillTween(self)
    if self.mTweenRange_AnchorPosX then
        self.mTweenRange_AnchorPosX:Kill()
        self.mTweenRange_AnchorPosX = nil
    end

    if self.mTweenRange_SizeDelta then
        self.mTweenRange_SizeDelta:Kill()
        self.mTweenRange_SizeDelta = nil
    end
end

--获取去重随机数
function getRandom(self, min_val, max_val, min_posDiff)
    local random = math.random(min_val, max_val)
    if math.abs(random - self.mImgFishRange.anchoredPosition.x) < min_posDiff then
        return self:getRandom(min_val, max_val, min_posDiff)
    end

    return random
end

function DOAnchorPosX(self, rectTransform, value, time, finishCall)
    local tween = rectTransform:DOAnchorPosX(value, time)
    tween:OnComplete(finishCall)
    return tween
end

function DOSizeDelta(self, rectTransform, vec2, time, finishCall)
    local tween = rectTransform:DOSizeDelta(vec2, time)
    tween:OnComplete(finishCall)
    return tween
end

function onOpenAtlas(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_FISHATLASPANEL)
end

function refreshBait(self)
    if not self.mBaitGroup.activeSelf then
        return
    end
    self:openBaitView()
end

function openBaitView(self)
    if not self.mBaitGroup.activeSelf then
        self.mBaitGroup:SetActive(true)
        self.gBtnClose.gameObject:SetActive(true)
    end

    local list = {}
    local baitConfigDic = sandPlay.SandPlayManager:getBaitConfigVoDic()
    for k, config in pairs(baitConfigDic) do
        table.insert(list, config)
    end

    table.sort(list, function(a, b)
        return a.sort_index < b.sort_index
    end)

    if sandPlay.SandPlayManager:getFishingBait() == nil then
        sandPlay.SandPlayManager:setFishingBait(list[1].id)
    end

    self.mLyScroller.DataProvider = list
end

function closeBaitView(self)
    self.mBaitGroup:SetActive(false)
    self.gBtnClose.gameObject:SetActive(false)
end

function onShowBaitTips(self)
    self.mBaitTipsGroup:SetActive(true)

    local prop_id = sandPlay.SandPlayManager:getFishingBait()
    local propsConfigVo = props.PropsManager:getPropsConfigVo(prop_id)
    self.mTextBaitTipsName.text = propsConfigVo:getName()
    self.mTextBaitTips.text = propsConfigVo:getDes()
end

function onFishing(self)
    local bait_id = sandPlay.SandPlayManager:getFishingBait()
    if not bait_id then
        gs.Message.Show(_TT(98338))
        return
    end
    local count = bag.BagManager:getPropsCountByTid(bait_id)
    if count <= 0 then
        gs.Message.Show(_TT(98338))
        return
    end

    self.mImgFish1:SetActive(true)
    self.mImgFish2:SetActive(false)
    self.mImgFish3:SetActive(true)

    self:closeBaitView()

    GameDispatcher:dispatchEvent(EventName.SANDPLAY_FISHING_CLICK)
end

function updataRedState(self)
    if sandPlay.SandPlayManager:getFishingRedState() then
        RedPointManager:add(self.mBtnAtlas.transform, nil, 40, 38)
    else
        RedPointManager:remove(self.mBtnAtlas.transform)
    end
end

return _M
