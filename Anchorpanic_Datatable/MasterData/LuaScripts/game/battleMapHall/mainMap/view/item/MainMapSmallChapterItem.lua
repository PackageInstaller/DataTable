--[[ 
    主线关卡章节item
]]
module("battleMap.MainMapSmallChapterItem", Class.impl("lib.component.CurveItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mCanvasGroup = self.UIObject:GetComponent(ty.CanvasGroup)
    self.mGoLock = self:getChildGO("mImgLock")
    self.mRedTrans = self:getChildTrans("mRedTrans")
    self.mTxtChapterPro = self:getChildGO("mTxtChapterPro"):GetComponent(ty.Text)
    self.mImgComplete = self:getChildGO("mImgComplete")
    self.mImgLine = self:getChildGO("mImgLine"):GetComponent(ty.Image)
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.Text)
    self.mTxtIndex = self:getChildGO("mTxtIndex"):GetComponent(ty.Text)
    self:addOnClick(self.UIObject.gameObject, self.onClickItemHandler, "")

    GameDispatcher:addEventListener(EventName.MAIN_SCROLLER_START_ROLL, self.__startMoveHandler, self)
    GameDispatcher:addEventListener(EventName.MAIN_SCROLLER_END_ROLL, self.__endMoveHandler, self)
    self.mMaxAlpha = 0
end

function adOnClickEvent(self)
    self:addOnClick(self:getChildGO("ImgToucher"), self.onClickItemHandler)
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
    local standardTrans = self.data.standardTrans
    --battleMap.MainMapManager:getChapterDic(chapterVo.chapterId)

    -- 显示是否解锁的标识
    local firstStageId = chapterVo:getFirstStageId(battleMap.MainMapManager:getStyle())
    local firstStageVo = battleMap.MainMapManager:getStageVo(firstStageId)
    local isActive, needPassStageId = firstStageVo:isActive()
    local styleType = battleMap.MainMapManager:getStyle()

    local roleVo = role.RoleManager:getRoleVo()
    if (not roleVo or not roleVo:getPlayerLvl()) then
        return
    end
    local needLevl = roleVo:getPlayerLvl() >= chapterVo.m_level
    local proPercent, proStr = chapterVo:getStage(styleType)
    self.mTxtChapterPro.text = proPercent .. "/" .. proStr
    self.mImgComplete:SetActive(proPercent >= proStr)
    self.mTxtChapterPro.gameObject:SetActive(proPercent < proStr)
    if (isActive and needLevl) then
        self.mGoLock:SetActive(false)
        self.mMaxAlpha = 1
        if (self.mImgComplete.activeSelf == false and proPercent < proStr) then
            self.mTxtChapterPro.gameObject:SetActive(true)
        end
        -- self.mTxtContent.color = gs.ColorUtil.GetColor("202226ff")
        -- self.mTxtIndex.color = gs.ColorUtil.GetColor("202226ff")
        -- self.mImgLine.color = gs.ColorUtil.GetColor("202226ff")
        self:updateBubble(self.data.isBubble)
    else
        self:updateBubble(false)
        self.mGoLock:SetActive(true)
        self.mMaxAlpha = 0.8
        self.mTxtChapterPro.gameObject:SetActive(false)
        -- self.mTxtContent.color = gs.ColorUtil.GetColor("404548ff")
        -- self.mTxtIndex.color = gs.ColorUtil.GetColor("404548ff")
        -- self.mImgLine.color = gs.ColorUtil.GetColor("404548ff")
    end
    self.mTxtContent.text = chapterVo:getName()
    if chapterVo.chapterId >= 10 then
        self.mTxtIndex.text =  chapterVo.chapterId
    else
        self.mTxtIndex.text = "0" .. chapterVo.chapterId
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
    local alpha = 0
    if (absDeltaY < self:itemH() / 2) then
        if (alpha > 0) then
            alpha = alpha - 0.4
            alpha = alpha <= 0 and 0 or alpha
        end
    else
        local maxAlpha = self:maxAlpha()
        local halfScrollerH = self:scrollerH() / 2
        local _deltaY = absDeltaY >= halfScrollerH and halfScrollerH or absDeltaY
        -- 超出透明缓动距离的，逐渐变透明
        if (standardPosY <= -self:alphaDistance() or standardPosY >= self:alphaDistance()) then
            alpha = (maxAlpha * (1 - _deltaY / halfScrollerH))
        else
            if (alpha < maxAlpha) then
                alpha = alpha + 0.4
                alpha = alpha >= maxAlpha and maxAlpha or alpha
            end
        end
        alpha = self.mMaxAlpha
    end

    if (self.mIsMoveUp ~= nil) then
        -- 下拉时首个和上划时末个超过，中间线就不显示
        if (self.mIsMoveUp == true) then
            if (self.data.isEnd) then
                if (deltaY > -self:itemH() / 2) then
                    alpha = 0

                end
            end
        else
            if (self.data.isStart) then
                if (deltaY < self:itemH() / 2) then
                    alpha = 0
                end
            end
        end
    end

    self.mCanvasGroup.alpha = alpha

    -- local alpha = 0
    -- if(math.abs(absDeltaY) > 5)then
    --     local halfScrollerH = self:scrollerH() / 2
    --     local _deltaY = absDeltaY >= halfScrollerH and halfScrollerH or absDeltaY
    --     alpha = (self:maxAlpha() * (1 - _deltaY / halfScrollerH))
    -- end
    -- self.mCanvasGroup.alpha = alpha * self.mMaxAlpha

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

-- 更新红点
function updateBubble(self, isShowRed)
    if isShowRed then
        RedPointManager:add(self.mRedTrans, nil, -14, 16, nil, nil, nil, true)
    else
        RedPointManager:remove(self.mRedTrans)
    end
end

-- item的高度，和资源高度一致(不要改动虚拟列表的间隔，通过改变item高度即可)
function itemH(self)
    return 210
end

-- item的最大x坐标
function maxX(self)
    return 70
end

-- scroller的高度，和资源高度一致
function scrollerH(self)
    return 492
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]