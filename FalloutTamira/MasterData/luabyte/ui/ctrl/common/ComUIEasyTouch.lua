local M = BaseClass("ComUIEasyTouch")
local eashTouch = CS.HedgehogTeam.EasyTouch.EasyTouch
local touchType = {}

function M:RegisterListener(type, callback)
    touchType[type] = callback
    self:Show(type)
end

function M:Hide()
    self:_RemoveAllTouch()
    touchType = {}
end

function M:Show(type)
    self:_SetTouchInfo(false, type)
    self:_SetTouchInfo(true, type)
end

function M:_SetTouchInfo(isAdd, type)
    if isAdd then 
        if type == ComConst.EasyTouch.Pinch then
            self:AddPinch()
        elseif type == ComConst.EasyTouch.TouchUp2 then
            self:AddTouchUp2()
        end
    else
        if type == ComConst.EasyTouch.Pinch then
            self:RemovePinch()
        elseif type == ComConst.EasyTouch.TouchUp2 then
            self:RemoveTouchUp2()
        end
    end
end

function M:_RemoveAllTouch()
    self:RemovePinch()
    self:RemoveTouchUp2()
end

function M:AddPinch()
    self._onPinchHandler = Bind(self, self.OnPinch)
    eashTouch.On_Pinch( '+', self._onPinchHandler)
end

function M:OnPinch(gesture)
    touchType[ComConst.EasyTouch.Pinch](gesture.twoFingerDistance)
end

function M:RemovePinch()
    if self._onPinchHandler then 
        eashTouch.On_Pinch( '-', self._onPinchHandler)
        touchType[ComConst.EasyTouch.Pinch] = nil
        self._onPinchHandler = nil
    end
end

function M:AddTouchUp2()
    self._onTouchUp2Handler = Bind(self, self.OnTouchUp2)
    eashTouch.On_TouchUp2Fingers( '+', self._onTouchUp2Handler)
end

function M:OnTouchUp2(gesture)
    touchType[ComConst.EasyTouch.TouchUp2]()
end

function M:RemoveTouchUp2()
    if self._onTouchUp2Handler then 
        eashTouch.On_TouchUp2Fingers( '-', self._onTouchUp2Handler)
        touchType[ComConst.EasyTouch.TouchUp2] = nil
        self._onTouchUp2Handler = nil
    end
end




return M
