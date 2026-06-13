local DormFashionHeroCtrl = BaseClass("DormFashionHeroCtrl")
local M = DormFashionHeroCtrl
local eashTouch = CS.HedgehogTeam.EasyTouch.EasyTouch
local CS_GameHelper = CS.GameX.GameHelper
local CS_Camera = CS.UnityEngine.Camera
local rotateSpeed = 150

function M:IsIdle()
    return self.heroCurState == self.heroState.idle  
end

function M:PlayBodyAnimation(state)
    if self.hoemRoleModel then
        self.hoemRoleModel:PlayAnimation(state)
    end
end


function M:SetHeroState(state)
    self.heroCurState = state
    self:EnterState()
    self:PlayBodyAnimation(state)
end


function M:EnterState()
    if self.heroCurState == self.heroState.gift then
        self:Gift()
    elseif self.heroCurState == self.heroState.show then
        self:PlayShow()
    end
end


function M:Gift()
    self._stateTimer = TimerManager:GetInstance():GetTimer(self._giftTime, Bind(self, self.OnGiftOver), nil, true)
    self._stateTimer:Start()
end

function M:OnGiftOver()
    self._stateTimer:Stop()
    self:SetHeroState(self.heroState.idle)
end

function M:PlayShow()
    self._stateTimer = TimerManager:GetInstance():GetTimer(self._showTime, Bind(self, self.OnShowOver), nil, true)
    self._stateTimer:Start()
end

function M:OnShowOver()
    self._stateTimer:Stop()
    self:SetHeroState(self.heroState.idle)
end

function M:LieIdle()
    local index = math.random(1, 50)
    if index < 10 then
        self:SetHeroState(self.heroState.show)
        return
    end

    self:SetHeroState(self.heroState.gift) 
end

function M:Init()
    self._actionTimer:Start()
    self:SetHeroState(self.heroState.idle)
end

function M:__init(obj)
    self.showGirlOjb = obj
    self.hoemRoleModel = self.showGirlOjb.transform:GetHomeRoleModel()
    self.heroState = { 
        idle = 'Idle1', 
        show = 'Show', 
        gift = 'Gift'
    }

    self._actionTime = 15
    self._giftTime = 10
    self._showTime = 10
   
    self._isDownValid = false
    self._stateTimer = nil
    self._actionTimer = TimerManager:GetInstance():GetTimer(self._actionTime, Bind(self, self._OnActionState), nil, false)
    self._operateTime = Time.realtimeSinceStartup
    self:Init()
end

function M:_SetTouchInfo(isAdd)
    
    if isAdd then 
        self._onSwipeHandler = self._onSwipeHandler or Bind(self,self.OnSwipe)
        eashTouch.On_Swipe( '+', self._onSwipeHandler)
        self._onTouchDownHandler = self._onTouchDownHandler or Bind(self,self.OnTouchDown)
        eashTouch.On_TouchDown('+',self._onTouchDownHandler)
        self._onTouchUpHandler = self._onTouchUpHandler or Bind(self, self.OnTouchUp)
        eashTouch.On_TouchUp('+', self._onTouchUpHandler)
    else
        if self._onSwipeHandler then 
            eashTouch.On_Swipe( '-', self._onSwipeHandler)
        end
        if self._onTouchDownHandler then 
            eashTouch.On_TouchDown('-', self._onTouchDownHandler)
        end
        if self._onTouchUpHandler then 
            eashTouch.On_TouchUp('-', self._onTouchUpHandler)
        end
    end
end

function M:_OnActionState()
    if self:IsIdle() then
        self:LieIdle()
    end
end

function M:SetTimer(isPause)
    if isPause then
        if self._actionTimer then
            self._actionTimer:Pause()
        end
    else
        if self._actionTimer then
            self._actionTimer:Resume()
        end
    end
end

function M:Hide()
    self:SetTimer(true)
    self:_SetTouchInfo(false)
    self.showGirlOjb:SetActive(false)
end

function M:Show()
    self:SetTimer(false)
    self:_SetTouchInfo(false)
    self:_SetTouchInfo(true)
    self.hoemRoleModel.transform.localEulerAngles = Vector3.zero
    self.showGirlOjb:SetActive(true)
end

function M:OnTouchDown(gesture)
    if CS_GameHelper.bClickUI() then 
        return 
    end
    if self._screenPointX == nil then 
        local screenPoint = CS_Camera.main:WorldToScreenPoint(self.showGirlOjb.transform.position)
        self._screenPointX = screenPoint.x 
    end
    
    local screenX = gesture.position.x 
    if screenX < self._screenPointX - 300 or screenX > self._screenPointX + 300 then 
        return
    end

    self._isDownValid = true 
    self._operateTime = Time.realtimeSinceStartup
end

function M:OnTouchUp(gesture)
    if not self._isDownValid then 
        return 
    end
    self._operateTime = Time.realtimeSinceStartup
    self._isDownValid = false  
end

function M:OnSwipe(gesture)
    if not self._isDownValid then 
        return 
    end
    if not IsNull(self.hoemRoleModel) then
        self.hoemRoleModel:OnDragGirl(gesture.deltaPosition.x, rotateSpeed);
        self._operateTime = Time.realtimeSinceStartup
    end
end

function M:Destroy()
    GameUtil.DestroyGo(self.showGirlOjb)
    self:OnDispose()
end

function M:OnDispose()
    self:_SetTouchInfo(false)
    if self._actionTimer then
        self._actionTimer:Stop()
        self._actionTimer = nil
    end
    
    self._animator = nil
end





return DormFashionHeroCtrl
