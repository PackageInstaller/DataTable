module('lib.component.CurveItemRender', Class.impl(lib.component.BaseItemRender))
--[[
    @author: Zzz
    @todo: 弧形列表lua渲染器，使用时请继承本类
    @todo: 该方法由C#类 LyScroller的子项渲染器ItemRender 调用
    @param: go 列表子项GameObject
    @param: param 列表子项对应处理的数据

    @careful：item资源需要添加脚本ItemRender、CanvasGroup、Button，对应的item和LyScroller资源需要加上基准线（默认居中）
]]

function onInit(self, go)
    super.onInit(self, go)

    -- self.m_element = self.UIObject:GetComponent(ty.LayoutElement)
    self.m_rect = self.UIObject.gameObject:GetComponent(ty.RectTransform)
    self.mCanvasGroup = self.UIObject.gameObject:GetComponent(ty.CanvasGroup)
    self.m_goStandard = self:getChildTrans("ImgStandard")
    
    self:adOnClickEvent()
end

function adOnClickEvent(self)
    self:addOnClick(self.UIObject.gameObject, self.onClickItemHandler)
end

function checkFrameSn(self)
    self:__removeFrameSn()
    if(not self.data)then
        self.mCanvasGroup.alpha = 0
        self.m_oldDeltaY = nil
    else
        self.mCanvasGroup.alpha = self:maxAlpha()
        self.m_oldDeltaY = nil
        self:__addFrameSn()
    end
end

function setData(self, param)
    super.setData(self, param)
    self:checkFrameSn()
end

function deActive(self)
    super.deActive(self)
    self:__removeFrameSn()
end

function onDelete(self)
    super.onDelete(self)
    self:__removeFrameSn()
end

function __onFrameHandler(self)
    if(not self.data)then
        return
    end
    ---------------------------- 变换内容坐标 ----------------------------
    
    local standardTrans = self.data.standardTrans
    -- 将item的基准线y坐标换算成父节点的局部y坐标（standardPosY为正或负）
    local standardPosY = standardTrans:InverseTransformPoint(self.m_goStandard.position).y
    -- 是否超出圆半径((判断是否园内，超出则不显示不处理逻辑)
    if(self:radius() < math.abs(standardPosY))then
        return
    end
    -- 是否y坐标变化(判断是否拖动)
    local standLocalPosY = standardTrans.localPosition.y
    local deltaY = math.ceil(math.abs(standardPosY - standLocalPosY))
    if(not self:isChangeY(deltaY))then
        return
    end
    
    -- 圆心的x坐标
    local centerX = self:maxX() - self:radius()
    local x = centerX + math.sqrt(self:radius() * self:radius() - standardPosY * standardPosY)
    gs.TransQuick:UIPosX(self.m_rect, x)
    
    local alpha = self.mCanvasGroup.alpha
    if(deltaY < self:itemH() / 2)then
        if(alpha > 0)then
            alpha = alpha - 0.05
            alpha = alpha <= 0 and 0 or alpha
        end
    else
        local maxAlpha = self:maxAlpha()
        local halfScrollerH = self:scrollerH() / 2
        local _deltaY = deltaY >= halfScrollerH and halfScrollerH or deltaY
        -- 超出透明缓动距离的，逐渐变透明
        if(standardPosY <= -self:alphaDistance() or standardPosY >= self:alphaDistance())then
            alpha = (maxAlpha * (1 - _deltaY / halfScrollerH))
        else
            if(alpha < maxAlpha)then
                alpha = alpha + 0.05
                alpha = alpha >= maxAlpha and maxAlpha or alpha
            end
        end
    end
    self.mCanvasGroup.alpha = alpha
    
    -- 是否进入scroller的标准线范围内
    if(not self.m_isSelect)then
        if(deltaY < self:itemH() / 2) then
            self:sendSelectChange(false)
            self.m_isSelect = true
        end
    else
        if(deltaY >= self:itemH() / 2) then
            self.m_isSelect = false
        end
    end
    
    -- 变换item高低
    -- local minH = self:itemH()
    -- local maxH = 100
    -- -- 将基准线换算成父节点的局部坐标
    -- if(standardPos.y > standardY)then
        --     -- 上
        --     local deltaY = standardPos.y - standardY
        --     if(deltaY <= self:itemH() / 2)then
            --         self.m_element.preferredHeight = (self:itemH() / 2 - deltaY) / (self:itemH() / 2) * maxH + minH
        --     else
            --         self.m_element.preferredHeight = minH
        --     end
    -- elseif(standardPos.y == standardY)then
        --     -- 一致
        --     self.m_element.preferredHeight = maxH
    -- elseif(standardPos.y < standardY)then
        --     -- 下
        --     local deltaY = standardY - standardPos.y
        --     if(deltaY <= self:itemH() / 2)then
            --         self.m_element.preferredHeight = (self:itemH() / 2 - deltaY) / (self:itemH() / 2) * maxH + minH
        --     else
            --         self.m_element.preferredHeight = minH
        --     end
    -- end
    
    -- 变换内容缩放
    -- local minScale = 0.7
    -- local maxScale = 1
    -- -- 将基准线换算成父节点的局部坐标
    -- if(standardPos.y > standardY)then
        --     -- 上
        --     local deltaY = standardPos.y - standardY
        --     if(deltaY <= self:itemH() / 2)then
            --         local scale = (self:itemH() / 2 - deltaY) / (self:itemH() / 2) * maxScale + minScale
            --         gs.TransQuick:Scale(self.m_groupScaleRect, scale, scale, 1)
        --     else
            --         gs.TransQuick:Scale(self.m_groupScaleRect, minScale, minScale, 1)
        --     end
    -- elseif(standardPos.y == standardY)then
        --     -- 一致
        --     self.m_element.preferredHeight = maxScale
    -- elseif(standardPos.y < standardY)then
        --     -- 下
        --     local deltaY = standardY - standardPos.y
        --     if(deltaY <= self:itemH() / 2)then
            --         local scale = (self:itemH() / 2 - deltaY) / (self:itemH() / 2) * maxScale + minScale
            --         gs.TransQuick:Scale(self.m_groupScaleRect, scale, scale, 1)
        --     else
            --         gs.TransQuick:Scale(self.m_groupScaleRect, minScale, minScale, 1)
        --     end
    -- end
end

function onClickItemHandler(self)
    if(self.data)then
        self:sendSelectChange(true)
    end
end

-- 选中项改变，用以通知外部的界面根据选中项更新界面，overwrite...
function sendSelectChange(self, isClick)
end

-- 获取当前item的y坐标是否改变
function isChangeY(self, curDeltaY)
    local isChange
    if(self.m_oldDeltaY == nil)then
        -- 如果是初始item时，手动设置执行5次逻辑以达到透明度变化达到正确值
        self.m_runAlphaTimes = 5
        isChange = true
        self.m_oldDeltaY = curDeltaY
    else
        if(self.m_oldDeltaY == curDeltaY)then
            if(self.m_runAlphaTimes <= 0)then
                isChange = false
            else
                self.m_runAlphaTimes = self.m_runAlphaTimes - 1
                isChange = true
            end
        else
            isChange = true
        end
    end
    self.m_oldDeltaY = curDeltaY
    return isChange
end

-- item的高度，和资源高度一致(不要改动虚拟列表的间隔，通过改变item高度即可)
function itemH(self)
    return 60
end

-- item的最大透明度
function maxAlpha(self)
    return 1
end

-- 列表围绕的圆半径，决定列表的弧度
function radius(self)
    return 250
end

-- item的最大x坐标
function maxX(self)
    return 145
end

-- scroller的高度，和资源高度一致
function scrollerH(self)
    return 334
    --return 420
end

-- item的透明度缓变判断距离
function alphaDistance(self)
    return 150
end

function __addFrameSn(self)
    if (self.m_delayFrameSn == nil) then
        self.m_delayFrameSn = LoopManager:addFrame(1, 0, self, self.__onFrameHandler)
    end
end

function __removeFrameSn(self)
    if (self.m_delayFrameSn) then
        LoopManager:removeFrameByIndex(self.m_delayFrameSn)
        self.m_delayFrameSn = nil
    end
end

return _M
