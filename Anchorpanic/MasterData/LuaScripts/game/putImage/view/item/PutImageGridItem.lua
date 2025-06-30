-- @FileName:   PutImageGridItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-08-23 17:20:27
-- @Copyright:   (LY) 2023 雷焰网络

module("game.putImage.view.PutImageGridItem", Class.impl(SimpleInsItem))

function setArgs(self, args)
    super.setArgs(self, args)

    self:configUI()
    self:onAddPointerEvent()

    self.m_rectTrans.sizeDelta = gs.Vector2(self.m_args.width, self.m_args.height)
    self.m_autoRefRawImage:SetImg(self.m_args.img_path, false)
end

function recover(self)
    super.recover(self)

    self:onRemovePointerEvent()

    self.m_upCall = nil
    self.m_dragCall = nil
    self.m_recoverCall = nil
end

function configUI(self)
    self.mLongPressComponent = self:getGo():GetComponent(ty.LongPressOrClickEventTrigger)
    self.mLongPressComponent.durationThreshold = 0.0

    self.m_rectTrans = self:getGo():GetComponent(ty.RectTransform)
    self.m_autoRefRawImage = self:getGo():GetComponent(ty.AutoRefRawImage)

    self.mImgSelect = self:getChildGO("mImgSelect")
    self:OperateSelect(false)
end

-- 增加长按事件
function onAddPointerEvent(self)
    local function _onDragHandler()
        if self.m_dragCall then
            self.m_dragCall(self)
        end
    end
    self.mLongPressComponent.onDrag:AddListener(_onDragHandler)

    local function _onPointerUpHandler()
        if self.m_upCall then
            self:m_upCall(self)
        end
    end
    self.mLongPressComponent.onPointerUp:AddListener(_onPointerUpHandler)

end

-- 移除长按事件
function onRemovePointerEvent(self)
    self.mLongPressComponent.onDrag:RemoveAllListeners()
    self.mLongPressComponent.onPointerUp:RemoveAllListeners()
end

function refreshPos(self)
    if self.m_args then
        local pos_x = (self.m_args.col - 1) * (PutImageConst.Grid_Interval + self.m_args.width) + PutImageConst.Grid_Interval
        local pos_y = (self.m_args.max_row - self.m_args.row) * (PutImageConst.Grid_Interval + self.m_args.height) + PutImageConst.Grid_Interval
        self:setPos(pos_x, pos_y)

        --以下代码取消注释，生成正确位置
        -- local correct_posX = (self.m_args.correct_col - 1) * (PutImageConst.Grid_Interval + self.m_args.width) + PutImageConst.Grid_Interval
        -- local correct_posY = (self.m_args.max_row - self.m_args.correct_row) * (PutImageConst.Grid_Interval + self.m_args.height) + PutImageConst.Grid_Interval

        -- self:setPos(correct_posX, correct_posY)
    end
end

function refreshRecover(self)
    if self.m_args.row == self.m_args.correct_row and self.m_args.col == self.m_args.correct_col then
        self.m_recoverCall(self)
        return true
    end
end

function SetCallback(self, upCall, dragCall, recoverCall)
    self.m_upCall = upCall
    self.m_dragCall = dragCall
    self.m_recoverCall = recoverCall
end

function SetRect(self, x, y, width, height)
    self.m_go:GetComponent(ty.AutoRefRawImage).uvRect = gs.Rect(x, y, width, height)
end

function OperateSelect(self, value)
    self.mImgSelect:SetActive(value)
end

return _M
