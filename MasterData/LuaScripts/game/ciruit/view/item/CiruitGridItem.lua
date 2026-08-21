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
    self.m_canRotate = false
    self.m_canDrag = false

    self:configUI()
    self:onAddPointerEvent()

    self:rotate(self.m_gridConfigVo.init_angle)
    self:refreshGridShow()
    self:refreshBg()
end

function getData(self)
    return self.m_gridVo
end

function getId(self)
    return self.m_gridVo:getId()
end

function recover(self)
    super.recover(self)
    ciruit.CiruitManager:recoverGridVo(self.m_gridVo)

    self.m_gridVo = nil
    self.m_gridConfigVo = nil
    self.m_angle = nil
    self.m_canRotate = nil
    self.m_canDrag = nil

    self.m_parentInfo = nil

    self.m_dragStartCall = nil
    self.m_dragCall = nil
    self.m_drayEndCall = nil

    self:clearDownTimerOutSn()
    self:clearRotateTweener()
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

    self.m_rectTransform = self:getTrans():GetComponent(ty.RectTransform)
end

-- 增加长按事件
function onAddPointerEvent(self)
    local function _onclickHandler()
        if self.m_canDrag then
            return
        end
        self:onClick()
    end
    self.mLongPressComponent.onClick:AddListener(_onclickHandler)

    local function _onPointerDownHandler()
        self:onPointerDown()
    end
    self.mLongPressComponent.onPointerDown:AddListener(_onPointerDownHandler)

    local function _onPointerUpHandler()
        self:onPointerUp()
    end
    self.mLongPressComponent.onPointerUp:AddListener(_onPointerUpHandler)

    local function _onDragHandler()
        self:onDragHandler()
    end
    self.mLongPressComponent.onDrag:AddListener(_onDragHandler)
end

-- 移除长按事件
function onRemovePointerEvent(self)
    self.mLongPressComponent.onClick:RemoveAllListeners()

    self.mLongPressComponent.onPointerDown:RemoveAllListeners()
    self.mLongPressComponent.onPointerUp:RemoveAllListeners()
    self.mLongPressComponent.onDrag:RemoveAllListeners()
end

function onClick(self)
    if not self.m_canRotate then
        return
    end

    AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_link_1.prefab")

    self:rotate(self.m_angle - 90, true)
    GameDispatcher:dispatchEvent(EventName.CIRUIT_GRID_ROTATE)
end

function onEndDarg(self)
    if not self.m_canDrag then
        return
    end

    if self.m_drayEndCall then
        self:m_drayEndCall()
    end

    self.m_draging = false
end

function onPointerDown(self)
    if not self.m_canDrag then
        return
    end

    self:clearDownTimerOutSn()

    self.m_pointDownTimerOutSn = LoopManager:setTimeout(0.2, self, self.onItemUp)
end

function onPointerUp(self)
    if not self.m_canDrag then
        return
    end

    self:clearDownTimerOutSn()

    if self.m_draging then
        self:onEndDarg()
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_link_1.prefab")
    else
        self:onClick()
    end
end

function onDragHandler(self)
    if not self.m_canDrag then
        return
    end

    if not self.m_draging then
        return
    end

    if self.m_dragCall then
        self:m_dragCall()
    end
end

function clearDownTimerOutSn(self)
    if self.m_pointDownTimerOutSn then
        LoopManager:clearTimeout(self.m_pointDownTimerOutSn)
        self.m_pointDownTimerOutSn = nil
    end
end

function onItemUp(self)
    self.m_draging = true

    if self.m_dragStartCall then
        self:m_dragStartCall()
    end
end

--准备摆放
function readyPut(self)
    if self.m_parentInfo then
        return
    end

    local trans = self:getTrans()
    local rectTrans = trans:GetComponent(ty.RectTransform)

    local anchorMin, anchorMax = rectTrans.anchorMin, rectTrans.anchorMax
    local sortIndex = trans:GetSiblingIndex()
    local parent = trans.parent

    self.m_parentInfo =
    {
        sortIndex = sortIndex,
        parent = parent,
        anchorMin = anchorMin,
        anchorMax = anchorMax,
    }
end

--撤回摆放
function revokePut(self)
    local trans = self:getTrans()

    gs.TransQuick:SetParentOrg(trans, self.m_parentInfo.parent)
    if not self:isPutScene() then
        trans:SetSiblingIndex(self.m_parentInfo.sortIndex)
    end

    local rectTrans = trans:GetComponent(ty.RectTransform)
    rectTrans.anchorMin = self.m_parentInfo.anchorMin
    rectTrans.anchorMax = self.m_parentInfo.anchorMax

    self.m_parentInfo = nil
    self.m_angle = 0

    ciruit.CiruitManager:revokeGridVo(self.m_gridVo)
    self.m_gridVo:revoke()

    self:rotate(self.m_gridConfigVo.init_angle)

    self:refreshPass()
end

--摆放进场景
function putInScene(self, row, col)
    ciruit.CiruitManager:revokeGridVo(self.m_gridVo)
    ciruit.CiruitManager:putGridVo(row, col, self.m_gridVo)
    self:enabledRotate(self.m_gridConfigVo.canRotate)
end

function rotate(self, angle, isTween)
    if not isTween then
        self.mGroup.localEulerAngles = gs.Vector3(0, 0, angle)
    else
        self:clearRotateTweener()
        self.m_rotateTweerner = TweenFactory:lRotate2(self.mGroup, gs.Vector3(0, 0, angle % 360), 0.3)
    end
    self.m_gridVo:rotate(math.abs(angle - self.m_angle))

    self.m_angle = angle
end

function clearRotateTweener(self)
    if self.m_rotateTweerner then
        self.m_rotateTweerner:Kill()
        self.m_rotateTweerner = nil
    end
end

function isPutScene(self)
    return self.m_gridVo:isPut()
end

function enabledRotate(self, value)
    self.m_canRotate = value
    self:refreshBg()
end

function enabledDarg(self, drayStart, drag, drayEnd)
    self.m_canDrag = true

    self.m_dragStartCall = drayStart
    self.m_dragCall = drag
    self.m_drayEndCall = drayEnd

    self:refreshBg()
end

function isEnabledPut(self)
    return self.m_canDrag
end

function refreshBg(self)
    if self.m_canDrag then
        self.gridBg:SetImg("arts/ui/pack/ciruit/grid_bg_3.png")
    elseif self.m_canRotate then
        self.gridBg:SetImg("arts/ui/pack/ciruit/grid_bg_2.png")
    else
        self.gridBg:SetImg("arts/ui/pack/ciruit/grid_bg_1.png")
    end
end

function refreshGridShow(self)
    self.mImgLine_1_0.gameObject:SetActive(true)
    self.mImgLine_1_1.gameObject:SetActive(false)
    self.mImgLine_2_1.gameObject:SetActive(false)

    self.mImgLine_2_0.gameObject:SetActive(false)

    self.gridBg.enabled = true

    self.m_childGos["glow_01_1"]:SetActive(false)
    self.m_childGos["glow_03_1"]:SetActive(false)
    self.m_childGos["glow_04_1"]:SetActive(false)
    self.m_childGos["glow_05_1"]:SetActive(false)
    self.m_childGos["glow_06_1"]:SetActive(false)
    self.m_childGos["glow_07_1"]:SetActive(false)
    self.m_childGos["glow_08_1"]:SetActive(false)

    if self.m_gridConfigVo.grid_type == CiruitConst.GridType.Start then
        self.gridBg.enabled = false
        self.mImgLine_1_1.gameObject:SetActive(true)

        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_02_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_02_1.png")

    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.End then
        self.gridBg.enabled = false

        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_01_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_01_1.png")

        self.m_childGos["glow_01_1"]:SetActive(true)

    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.L then

        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_03_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_03_1.png")

        self.m_childGos["glow_03_1"]:SetActive(true)

    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.I then
        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_08_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_08_1.png")

        self.m_childGos["glow_08_1"]:SetActive(true)

    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.Skew then

        self.mImgLine_2_0.gameObject:SetActive(true)

        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_06_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_06_1.png")

        self.mImgLine_2_0:SetImg("arts/ui/pack/ciruit/grid_05_0.png")
        self.mImgLine_2_1:SetImg("arts/ui/pack/ciruit/grid_05_1.png")

        self.m_childGos["glow_05_1"]:SetActive(true)
        self.m_childGos["glow_06_1"]:SetActive(true)

    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.T then

        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_04_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_04_1.png")

        self.m_childGos["glow_04_1"]:SetActive(true)

    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.Cross then

        self.mImgLine_2_0.gameObject:SetActive(true)

        self.mImgLine_1_0:SetImg("arts/ui/pack/ciruit/grid_08_0.png")
        self.mImgLine_1_1:SetImg("arts/ui/pack/ciruit/grid_08_1.png")

        self.mImgLine_2_0:SetImg("arts/ui/pack/ciruit/grid_07_0.png")
        self.mImgLine_2_1:SetImg("arts/ui/pack/ciruit/grid_07_1.png")

        self.m_childGos["glow_07_1"]:SetActive(true)
        self.m_childGos["glow_08_1"]:SetActive(true)

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
    elseif self.m_gridConfigVo.grid_type == CiruitConst.GridType.End then
        self.mImgLine_1_1.gameObject:SetActive(ciruit.CiruitManager:checkEndGridPass(self.m_gridVo))
    else
        self.mImgLine_1_1.gameObject:SetActive(self.m_gridVo:isPass())
    end
end

return _M
