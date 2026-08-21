--[[ 
    主线关卡章节item
]]
module("battleMap.MainMapChapterItem", Class.impl("lib.component.CurveItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mCanvasGroup = self.UIObject:GetComponent(ty.CanvasGroup)
    self.mGoLock = self:getChildGO("mImgLock")
    -- self.mTxtChapterPro = self:getChildGO("mTxtChapterPro"):GetComponent(ty.Text)
    self.mImgComplete = self:getChildGO("mImgComplete")
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.Text)
    -- self.mTxtIndex = self:getChildGO("mTxtIndex"):GetComponent(ty.Text)
    self:addOnClick(self.UIObject, self.onClickItemHandler, "")

    GameDispatcher:addEventListener(EventName.MAIN_SCROLLER_START_ROLL, self.__startMoveHandler, self)
    GameDispatcher:addEventListener(EventName.MAIN_SCROLLER_END_ROLL, self.__endMoveHandler, self)
    self.mMaxAlpha = 1

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgBar = self:getChildTrans("Mask"):GetComponent(ty.AutoRefImage)
    self.mImgBarBg = self:getChildTrans("BarBg"):GetComponent(ty.AutoRefImage)
    self.mProgressBar = self:getChildGO('ProgressBar'):GetComponent(ty.ProgressBar)
    self.mProgressBar:InitData(4)
    self.mTxtContent = self:getChildTrans("mTxtContent"):GetComponent(ty.Text)
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)
    self.mCanvasGroupContent = self:getChildTrans("mTxtContent"):GetComponent(ty.CanvasGroup)
    self.mRectContent = self:getChildTrans("mTxtContent"):GetComponent(ty.RectTransform)
    self.mGoLock = self:getChildGO("mImgLock")

    self.mTxtStart = self:getChildGO("mTxtStart"):GetComponent(ty.Text)
    self.mImgStart = self:getChildGO("mImgStart")
    self.mImgComplete = self:getChildGO("mImgComplete")
    self.mImgStyle = self:getChildGO("mImgStyle"):GetComponent(ty.AutoRefImage)
    self:getChildGO("mTxtStart"):GetComponent(ty.Text).text = _TT(2911)
end

-- 界面放入缓存节点过久会自动销毁，需要移除事件
function onDelete(self)
    super.onDelete(self)
    GameDispatcher:removeEventListener(EventName.MAIN_SCROLLER_START_ROLL, self.__startMoveHandler, self)
    GameDispatcher:removeEventListener(EventName.MAIN_SCROLLER_END_ROLL, self.__endMoveHandler, self)
    self.mIsMoveUp = nil
end

function deActive(self)
    super.deActive(self)
    self:updateBubble(false)
    self.mIsMoveUp = nil
end

function checkFrameSn(self)
end

function setData(self, param)
    super.setData(self, param)

    -- 移除帧循环，交给外部触发
    self:__removeFrameSn()
    if (not self.data) then
        self.mCanvasGroup.alpha = 0
        return
    end

    local chapterVo = self.data.chapterVo
    -- local standardTrans = self.data.standardTrans

    -- 显示是否解锁的标识
    local firstStageId = chapterVo:getFirstStageId(battleMap.MainMapManager:getStyle())
    local firstStageVo = battleMap.MainMapManager:getStageVo(firstStageId)
    local isActive, needPassStageId = firstStageVo:isActive()
    local styleType = battleMap.MainMapManager:getStyle()

    local roleVo = role.RoleManager:getRoleVo()
    if (not roleVo or not roleVo:getPlayerLvl()) then
        return
    end

    local styleType = battleMap.MainMapManager:getStyle()
    if (styleType == battleMap.MainMapStyleType.Easy) then
        -- self.mImgStyle:SetActive(false)
        self.mImgStyle.color = gs.ColorUtil.GetColor("478afdff")
        -- self.mImgBar.color = gs.ColorUtil.GetColor("478afdff")
        -- self.mImgBar:SetImg(UrlManager:getPackPath("mainMap/main_map_easy_bar.png"), false)
        -- self.mImgBarBg:SetImg(UrlManager:getPackPath("mainMap/main_map_easy_bar_bg.png"), false)
    elseif (styleType == battleMap.MainMapStyleType.Difficulty) then
        -- self.mImgStyle:SetActive(true)
        self.mImgStyle.color = gs.ColorUtil.GetColor("e15be1ff")
        -- self.mImgBar.color = gs.ColorUtil.GetColor("e15be1ff")
        -- self.mImgBar:SetImg(UrlManager:getPackPath("mainMap/main_map_difficulty_bar.png"), false)
        -- self.mImgBarBg:SetImg(UrlManager:getPackPath("mainMap/main_map_difficulty_bar_bg.png"), false)
    elseif (styleType == battleMap.MainMapStyleType.SuperDifficulty) then
        -- self.mImgStyle:SetActive(true)
        self.mImgStyle.color = gs.ColorUtil.GetColor("ff0000ff")
        -- self.mImgBar.color = gs.ColorUtil.GetColor("ff0000ff")
        -- self.mImgBar:SetImg(UrlManager:getPackPath("mainMap/main_map_difficulty_bar.png"), false)
        -- self.mImgBarBg:SetImg(UrlManager:getPackPath("mainMap/main_map_difficulty_bar_bg.png"), false)
    end
    local proPercent, proStr = chapterVo:getStage(styleType)
    self.mProgressBar:SetValue(0, 100, false)
    self.mProgressBar:SetValue(proPercent, proStr, true)
    self.mImgComplete:SetActive(proPercent >= proStr)
    local contentStr = chapterVo:getName()
    -- if (self.mTxtContent.text ~= contentStr) then
    --     if (self.mScaleTweener) then
    --         self.mScaleTweener:Kill()
    --         self.mScaleTweener = nil
    --     end
    --     if (self.mAlphaTweener) then
    --         self.mAlphaTweener:Kill()
    --         self.mAlphaTweener = nil
    --     end
    --     self.mScaleTweener = TweenFactory:scaleTo(self.mRectContent, math.Vector3(1.3, 1.3, 1), math.Vector3(1, 1, 1), 0.3, nil,
    --     function()
    --         self.mScaleTweener:Kill()

    --         self.mScaleTweener = nil
    --     end)
    --     self.mAlphaTweener = TweenFactory:canvasGroupAlphaTo(self.mCanvasGroupContent, 0.5, 1, 0.3, nil,
    --     function()
    --         self.mAlphaTweener:Kill()
    --         self.mAlphaTweener = nil
    --     end)
    -- end
    self.mTxtContent.text = contentStr
    if chapterVo.chapterId >= 10 then
        self.mTxtNum.text = chapterVo.chapterId
    else
        self.mTxtNum.text = "0" .. chapterVo.chapterId
    end
    self.mImgBg:SetImg(UrlManager:getIconPath("mainMap/img_main_item" .. chapterVo.chapterId .. ".png"), false)

    -- 显示是否解锁的标识
    local firstStageId = chapterVo:getFirstStageId(battleMap.MainMapManager:getStyle())
    local firstStageVo = battleMap.MainMapManager:getStageVo(firstStageId)
    local isActive, needPassStageId = firstStageVo:isActive()
    local needLevl = role.RoleManager:getRoleVo():getPlayerLvl() >= chapterVo.m_level
    if (isActive and needLevl) then
        self.mMaxAlpha = 1
        self.mGoLock:SetActive(false)
        self.mProgressBar.gameObject:SetActive(true)
        self.mImgStart.gameObject:SetActive(true)
        self:updateBubble(self.data.isBubble)
    else
        self:updateBubble(false)
        self.mMaxAlpha = 0.8
        self.mGoLock:SetActive(true)
        self.mProgressBar.gameObject:SetActive(false)
        self.mImgStart.gameObject:SetActive(false)
    end
    -- 外部触发帧事件
    self:__onFrameHandler()
end

function sendSelectChange(self, isClick)
    battleMap.MainMapManager:dispatchEvent(battleMap.MainMapManager.MAIN_MAP_CHAPTER_SELECT_CHANGE, { chapterVo = self.data.chapterVo, isClick = isClick })
end

-- 滚动容器开始滚动
function __startMoveHandler(self, args)
    self:__addFrameSn()
    if (self.data) then
        self.mIsMoveUp = args.isMoveUp
    end
end
-- 滚动容器停止滚动
function __endMoveHandler(self, args)
    self:__removeFrameSn()
    if (self.data) then
        self.mIsMoveUp = nil
        if (args.chapterVo == self.data.chapterVo) then
            self.mCanvasGroup.alpha = self:maxAlpha() * self.mMaxAlpha
        else
            self.mCanvasGroup.alpha = 0
        end
    end
end

function __onFrameHandler(self)
    if (not self.data) then
        return
    end
    ---------------------------- 变换内容坐标 ----------------------------
    local standardTrans = self.data.standardTrans
    -- 将item的基准线y坐标换算成父节点的局部y坐标（standardPosY为正或负）
    local standardPosY = standardTrans:InverseTransformPoint(self.m_goStandard.position).y
    -- -- 是否超出圆半径(判断是否圆内，超出则不显示不处理逻辑)
    -- if(self:radius() < math.abs(standardPosY))then
    --     return
    -- end
    -- 是否y坐标变化(判断是否拖动)
    local standLocalPosY = standardTrans.localPosition.y
    local deltaY = standardPosY - standLocalPosY
    local absDeltaY = math.ceil(math.abs(deltaY))
    if (not self:isChangeY(absDeltaY)) then
        return
    end

    -- 圆心的x坐标
    -- local centerX = self:maxX() - self:radius()
    -- local x = centerX + math.sqrt(self:radius() * self:radius() - standardPosY * standardPosY)
    -- gs.TransQuick:UIPosX(self.m_rect, x)

    -- 临时屏蔽X轴的移动
    -- if(standardPosY >= standLocalPosY)then
    --     local x = centerX + self:radius() - standardPosY * 0.22
    --     gs.TransQuick:UIPosX(self.m_rect, x)
    -- else
    --     local x = centerX + self:radius() - standardPosY * 0.22
    --     gs.TransQuick:UIPosX(self.m_rect, x)
    -- end
    -- local alpha = self.mCanvasGroup.alpha
    -- if (absDeltaY < self:itemH() / 2) then
    --     local maxAlpha = self:maxAlpha()
    --     if(alpha < maxAlpha)then
    --         alpha = alpha + 0.2
    --         alpha = alpha >= maxAlpha and maxAlpha or alpha
    --     end
    -- else
    --     local maxAlpha = self:maxAlpha()
    --     local halfScrollerH = self:scrollerH() / 2
    --     local _deltaY = absDeltaY >= halfScrollerH and halfScrollerH or absDeltaY
    --     -- 超出透明缓动距离的，逐渐变透明
    --     if(standardPosY <= -self:alphaDistance() or standardPosY >= self:alphaDistance())then
    --         alpha = (maxAlpha * (1 - _deltaY / halfScrollerH))
    --     else
    --         if(alpha > 0)then
    --             alpha = alpha - 0.2
    --             alpha = alpha <= 0 and 0 or alpha
    --         end
    --     end
    -- end

    local alpha = self:maxAlpha()
    if (self.mIsMoveUp == true) then
        if (deltaY > self:scrollerH() / 2 + self:itemH() / 2) then
            alpha = 0
        else
            if (deltaY > self:itemH()) then
                alpha = 0
            else
                local halfScrollerH = self:scrollerH() / 3 * 2
                local _deltaY = absDeltaY >= halfScrollerH and halfScrollerH or absDeltaY
                alpha = (self:maxAlpha() * (1 - _deltaY / halfScrollerH))
            end
        end
    elseif (self.mIsMoveUp == false) then
        if (deltaY < -(self:scrollerH() / 2 + self:itemH() / 2)) then
            alpha = 0
        else
            if (deltaY < -self:itemH()) then
                alpha = 0
            else
                local halfScrollerH = self:scrollerH() / 3 * 2
                local _deltaY = absDeltaY >= halfScrollerH and halfScrollerH or absDeltaY
                alpha = (self:maxAlpha() * (1 - _deltaY / halfScrollerH))
            end
        end
    else
        if (absDeltaY < self:itemH() / 2) then
            alpha = 1
        else
            alpha = 0
        end
    end
    self.mCanvasGroup.alpha = alpha * self.mMaxAlpha

    -- 是否进入scroller的标准线范围内
    if (not self.m_isSelect) then
        if (absDeltaY < self:itemH() / 2) then
            self:sendSelectChange(false)
            self.m_isSelect = true
        end
    else
        if (absDeltaY >= self:itemH() / 2) then
            self.m_isSelect = false
        end
    end
end

-- item的高度，和资源高度一致(不要改动虚拟列表的间隔，通过改变item高度即可)
function itemH(self)
    return 315
end

-- item的最大x坐标
function maxX(self)
    return 70
end

-- scroller的高度，和资源高度一致
function scrollerH(self)
    return 492
end

-- 更新红点
function updateBubble(self, isShowRed)
    if isShowRed then
        RedPointManager:add(self.mImgBg.gameObject.transform, UrlManager:getCommon5Path("common_0013_max.png"), 459.5, 164.5)
    else
        RedPointManager:remove(self.mImgBg.gameObject.transform)
    end
end

function getAlpha(self)
    if (self.UIObject and not gs.GoUtil.IsGoNull(self.UIObject) and self.UIObject.activeSelf ~= false) then
        if (self.mCanvasGroup and not gs.GoUtil.IsCompNull(self.mCanvasGroup)) then
            return self.mCanvasGroup.alpha
        end
    end
    return 0
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]