-- @FileName:   CiruitGridItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-08-23 17:20:27
-- @Copyright:   (LY) 2023 雷焰网络

module("game.ciruit.view.CiruitGridItem", Class.impl(SimpleInsItem))

-- 设置data
function setData(self, gridVo)
    self.m_gridVo = gridVo
    self.m_gridConfigVo = gridVo:getConfigData()
    self.m_angle = 0

    self:configUI()
    self:onAddPointerEvent()

    self:refreshGridShow()
end

function getData(self)
    return self.m_gridVo
end

function recover(self)
    super.recover(self)

    self:clearTweer()
    self:onRemovePointerEvent()
end

function configUI(self)
    self.mLongPressComponent = self:getGo():GetComponent(ty.LongPressOrClickEventTrigger)

    self.mImgLine_1_0 = self:getChildGO("mImgLine_1_0"):GetComponent(ty.AutoRefImage)
    self.mImgLine_2_0 = self:getChildGO("mImgLine_2_0"):GetComponent(ty.AutoRefImage)
    self.mImgLine_1_1 = self:getChildGO("mImgLine_1_1"):GetComponent(ty.AutoRefImage)
    self.mImgLine_2_1 = self:getChildGO("mImgLine_2_1"):GetComponent(ty.AutoRefImage)

    self.mGroup = self:getChildTrans("mGroup")

    self.gridBg = self:getGo():GetComponent(ty.AutoRefImage)

end

-- 增加长按事件
function onAddPointerEvent(self)
    local function _onclickHandler()
        self:onClick()
    end
    self.mLongPressComponent.onClick:AddListener(_onclickHandler)

    -- local function _onPointerDownHandler()

    -- end
    -- self.mLongPressComponent.onPointerDown:AddListener(_onPointerDownHandler)

    -- local function _onPointerUpHandler()

    -- end
    -- self.mLongPressComponent.onPointerUp:AddListener(_onPointerUpHandler)

    -- local function _onDragHandler()

    -- end
    -- self.mLongPressComponent.onDrag:AddListener(_onDragHandler)

    -- local function _onEndDragHandler()

    -- end
    -- self.mLongPressComponent.onEndDrag:AddListener(_onEndDragHandler)
end

-- 移除长按事件
function onRemovePointerEvent(self)
    self.mLongPressComponent.onClick:RemoveAllListeners()

    -- self.mLongPressComponent.onPointerDown:RemoveAllListeners()
    -- self.mLongPressComponent.onPointerUp:RemoveAllListeners()
    -- self.mLongPressComponent.onDrag:RemoveAllListeners()
    -- self.mLongPressComponent.onEndDrag:RemoveAllListeners()
end

function onClick(self)
    self:rotate(self.m_angle - 90, true)
    GameDispatcher:dispatchEvent(EventName.CIRUIT_GRID_ROTATE)
end

function rotate(self, angle, isTween)
    if not isTween then
        self.mGroup.localEulerAngles = gs.Vector3(0, 0, angle)
    else
        self:clearTweer()
        self.m_rotateTweer = TweenFactory:lRotate2(self.mGroup, gs.Vector3(0, 0, angle % 360), 0.3)
    end
    self.m_gridVo:rotate(math.abs(angle - self.m_angle))

    self.m_angle = angle
end

function clearTweer(self)
    if self.m_rotateTweer then
        self.m_rotateTweer:Kill()
        self.m_rotateTweer = nil
    end
end

function refreshGridShow(self)
    self.mImgLine_1_0.gameObject:SetActive(true)
    self.mImgLine_1_1.gameObject:SetActive(false)
    self.mImgLine_2_1.gameObject:SetActive(false)

    self.mImgLine_2_0.gameObject:SetActive(false)

    self.gridBg.enabled = true
    self.gridBg.raycastTarget = self.m_gridConfigVo.canRotate

    if self.m_gridConfigVo.grid_type == CiruitConst.GridType.Start then
        self.gridBg.enabled = false
        self.mImgLine_1_1.gameObject:SetActive(true)

        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_02_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_02_1.png")

    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.End then
        self.gridBg.enabled = false

        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_01_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_01_1.png")

    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.L then

        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_03_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_03_1.png")

    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.I then
        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_08_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_08_1.png")

    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.Skew then

        self.mImgLine_2_0.gameObject:SetActive(true)

        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_06_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_06_1.png")

        self.mImgLine_2_0:SetImg("arts/ui/pack/ciruit/grid_05_0.png")
        self.mImgLine_2_1:SetImg("arts/ui/pack/ciruit/grid_05_1.png")

    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.T then

        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_04_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_04_1.png")

    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.Cross then

        self.mImgLine_2_0.gameObject:SetActive(true)

        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_08_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_08_1.png")

        self.mImgLine_2_0:SetImg("arts/ui/pack/ciruit/grid_07_0.png")
        self.mImgLine_2_1:SetImg("arts/ui/pack/ciruit/grid_07_1.png")
    end
end

function refreshPass(self)
    if self.m_gridConfigVo.grid_type == CiruitConst.GridType.Skew then
        local angle = math.abs(self.m_angle) % 360
        if angle == 0 then
            self.mImgLine_1_1.gameObject:SetActive(self.m_gridVo:isPass(CiruitConst.GridDir.Up))
            self.mImgLine_2_1.gameObject:SetActive(self.m_gridVo:isPass(CiruitConst.GridDir.Down))
        elseif angle == 90 then
            self.mImgLine_1_1.gameObject:SetActive(self.m_gridVo:isPass(CiruitConst.GridDir.Up))
            self.mImgLine_2_1.gameObject:SetActive(self.m_gridVo:isPass(CiruitConst.GridDir.Down))
        elseif angle == 180 then
            self.mImgLine_1_1.gameObject:SetActive(self.m_gridVo:isPass(CiruitConst.GridDir.Down))
            self.mImgLine_2_1.gameObject:SetActive(self.m_gridVo:isPass(CiruitConst.GridDir.Up))
        elseif angle == 270 then
            self.mImgLine_1_1.gameObject:SetActive(self.m_gridVo:isPass(CiruitConst.GridDir.Down))
            self.mImgLine_2_1.gameObject:SetActive(self.m_gridVo:isPass(CiruitConst.GridDir.Up))
        end
    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.Cross then
        local angle = math.abs(self.m_angle) % 180
        if angle == 0 then
            self.mImgLine_1_1.gameObject:SetActive(self.m_gridVo:isPass(CiruitConst.GridDir.Up))
            self.mImgLine_2_1.gameObject:SetActive(self.m_gridVo:isPass(CiruitConst.GridDir.Right))
        else
            self.mImgLine_1_1.gameObject:SetActive(self.m_gridVo:isPass(CiruitConst.GridDir.Right))
            self.mImgLine_2_1.gameObject:SetActive(self.m_gridVo:isPass(CiruitConst.GridDir.Up))
        end
    else
        self.mImgLine_1_1.gameObject:SetActive(self.m_gridVo:isPass())
    end
end

return _M
