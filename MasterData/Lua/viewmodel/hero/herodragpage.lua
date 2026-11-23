HeroDragPage = {}
HeroDragPage.__index = HeroDragPage;

local EaseOut
local CalcUIDragAndSet
local SetOutTopTween
local SetInTopTween
local OnTweenEnd

require("ViewModel/Hero/HeroDragItem")

HeroDragPage.New = function(content)
    local self = {};
    setmetatable(self, HeroDragPage);
    self.gameObject = LuaMgr.GetPrefab("Assets/_BundleResources/UI/Hero/HeroDragPage.prefab");
    self.transform = self.gameObject.transform;
    self.transform:SetParent(content, false);
    
    self.onDown = function(index, eventData)
        self:OnDown(index, eventData)
    end
    self.onDrag = function(eventData)
        self:OnDrag(eventData)
    end
    self.onEnd = function(eventData)
        self:OnEnd(eventData)
    end
    
    self.transform:GetComponent("OnDragEvent"):SetData(0, self.onDown, self.onDrag, self.onEnd)
    self.dragItem = nil
    
    return self;
end

local GetLeftIndex = function(self) 
    local index = HeroParameter.characterIndex - 1
    if index < 1 then
        index = #HeroParameter.characterList
    end
    return index
end

local GetRightIndex = function(self)
    local index = HeroParameter.characterIndex + 1
    if index > #HeroParameter.characterList then
        index = 1
    end
    return index
end

local CalcDrag = function(self, pos)
    local offset = pos - self.downPos
    local dist = offset.x
    if dist > self.dragDist then
        return 1
    elseif dist < -self.dragDist then
        return -1
    end
    return 0
end

local OnCallback = function(self) 
    self.isCall = false

    if self.status == 0 then
        return
    end
    if self.status == 1 then
        HeroParameter.characterIndex = GetLeftIndex(self)
    else
        HeroParameter.characterIndex = GetRightIndex(self)
    end
    HeroParameter.characterId = HeroParameter.characterList[HeroParameter.characterIndex]
    self:SetData({}, true)
    LuaMgr.CheckRefCount()
    if self.OnEndCB ~= nil then
        self.OnEndCB(self.status)
    end
end

local SetDragItem = function(self, ani)
    if self.dragItem == nil then
        self.dragItem = HeroDragItem.New(self.transform, self.rectSize)
    end
    self.dragItem:SetData(HeroParameter.characterList[HeroParameter.characterIndex], ani,self.isAssistHero)
end

local InitData = function(self, data)
    self.OnClickCB = data.onClick
    self.OnEndCB = data.onEnd
    self.dragDist = data.dragDist
    self.rectSize = data.rectSize

    self.isDraging = false
    self.canDrag = data.canDrag
    

    self.leftPosition = nil
    self.rightPosition = nil
    self.leftRect = data.leftRect
    self.rightRect = data.rightRect
    if self.leftRect ~= nil then
        self.leftCanvasGroup = self.leftRect.transform:GetComponent("CanvasGroup")
    end
    if self.rightRect ~= nil then
        self.rightCanvasGroup = self.rightRect.transform:GetComponent("CanvasGroup")
    end
    self.isAssistHero=data.isAssistHero;
end

function HeroDragPage:SetData(data, isRefreshItem)
    if not isRefreshItem then
        InitData(self, data)
        SetDragItem(self, data.ani)
    else
        SetDragItem(self, false)
    end
    local pos = Vector2.zero;
    self.dragItem:SetPosition(pos, 0)
    if self.leftRect ~= nil then
        if self.leftPosition ~= nil then
            self.leftRect.anchoredPosition = self.leftPosition
        end
        self.leftCanvasGroup.alpha = 1
    end

    if self.rightRect ~= nil then
        if self.rightPosition ~= nil then
            self.rightRect.anchoredPosition = self.rightPosition
        end
        self.rightCanvasGroup.alpha = 1
    end

    if TableIsNull(HeroParameter.characterList) or #HeroParameter.characterList == 1 then
        self.canDrag = false
    end
end

function HeroDragPage:SetCanDrag(status)

    if TableIsNull(HeroParameter.characterList) or #HeroParameter.characterList == 1 then
        self.canDrag = false
        return
    end
    self.canDrag = status
end

function HeroDragPage:OnDown(index, eventData)
    if self.isCall then
        return
    end
    
    self.downPos = eventData.position
end

function HeroDragPage:OnDrag(eventData)
    if not self.canDrag or self.downPos == nil or self.isCall then
        return
    end


    if self.isDraging == false then
        LuaMgr.InvokeUIEventListeners(UIEventConst.HeroManagerDragBegin)

        if (self.leftPosition == nil or self.rightPosition == nil) and (self.leftRect ~= nil and self.rightRect ~= nil) then
            self.leftPosition = self.leftRect.anchoredPosition
            self.rightPosition = self.rightRect.anchoredPosition
        end
    end
    self.isDraging = true
    
    local offset = eventData.position - self.downPos
    self.dragItem:Move(offset)

    CalcUIDragAndSet(self, offset)
    LuaMgr.InvokeUIEventListeners(UIEventConst.HeroManagerDrag, offset)
end

function HeroDragPage:OnEnd(eventData)
    if self.downPos == nil or self.isCall then
        return
    end

    if not self.isDraging and self.OnClickCB ~= nil then
        self.OnClickCB()
    end

    if not self.canDrag then
        return
    end
    
    self.isDraging = false
    
    self.status = CalcDrag(self, eventData.position)
    local pos = Vector2.zero
    if self.status == -1 then
        pos.x = pos.x - self.rectSize
        self.dragItem:SetPosition(pos, HeroDragPage.TopTweenDuration, function()
            OnTweenEnd(self)
        end)
    elseif self.status == 1 then
        pos.x = pos.x + self.rectSize
        self.dragItem:SetPosition(pos, HeroDragPage.TopTweenDuration, function()
            OnTweenEnd(self)
        end)
    else
        self.dragItem:SetPosition(pos, HeroDragPage.TopTweenDuration, function()
            OnTweenEnd(self)
        end)
    end

    SetOutTopTween(self)
    
    self.isCall = true

    LuaMgr.InvokeUIEventListeners(UIEventConst.HeroManagerDragEnd, self.status)
end

OnTweenEnd = function(self)
    OnCallback(self)
    LuaMgr.NextFrame(function()
        SetInTopTween(self)
    end)
    local pos = Vector2.zero
    if self.status == -1 then
        pos.x = pos.x + self.rectSize
        self.dragItem:SetPosition(pos, 0)
        pos.x = 0
        self.dragItem:SetPosition(pos, 0.4)
    elseif self.status == 1 then
        pos.x = pos.x - self.rectSize
        self.dragItem:SetPosition(pos, 0)
        pos.x = 0
        self.dragItem:SetPosition(pos, 0.4)
    else
        self.dragItem:SetPosition(pos, 0.4)
    end
end

function HeroDragPage:Clear()
    self.isCall = false

    if self.dragItem ~= nil then
        self.dragItem:Clear()
        self.dragItem = nil
    end
end


HeroDragPage.MaxTopUIOffset = 250
HeroDragPage.LimitTopUIOffset = 250
HeroDragPage.TopTweenOffset = 50
HeroDragPage.TopTweenDuration = 0.15


EaseOut = function(offset, maxOffset, begin, change)
    local temp = math.abs(offset)
    maxOffset = math.abs(maxOffset)
    temp = temp > maxOffset and maxOffset or temp
    local process = (temp / maxOffset) - 1
    local result = change * (process * process * process * process * process + 1) + begin
    return offset > 0 and result or -result
end


CalcUIDragAndSet = function(self, offset)
    if self.leftPosition == nil or self.rightPosition == nil then
        return
    end
    self.topUIOffset = EaseOut(offset.x, 500, 0, HeroDragPage.LimitTopUIOffset)
    self.topUIAlpha = 1 - math.abs(self.topUIOffset) / HeroDragPage.MaxTopUIOffset
    self.leftRect.anchoredPosition = Vector2(self.leftPosition.x + self.topUIOffset, self.leftPosition.y)
    self.rightRect.anchoredPosition = Vector2(self.rightPosition.x + self.topUIOffset, self.rightPosition.y)
    self.leftCanvasGroup.alpha = self.topUIAlpha
    self.rightCanvasGroup.alpha = self.topUIAlpha
end

SetOutTopTween = function(self)
    if self.tween ~= nil then
        self.tween:Kill()
        self.tween = nil
    end

    if self.leftPosition == nil or self.rightPosition == nil then
        return
    end

    local canvasAlpha = 0
    local currentOffset = self.leftRect.anchoredPosition.x - self.leftPosition.x
    local offset = nil
    if self.status == -1 then
        offset = currentOffset - HeroDragPage.TopTweenOffset
    elseif self.status == 1 then
        offset = currentOffset + HeroDragPage.TopTweenOffset
    else
        offset = 0
    end

    self.tween=DOTWeen.To(
            function()
                return currentOffset
            end,
            function(value)
                self.leftRect.anchoredPosition = Vector2(self.leftPosition.x + value, self.leftPosition.y)
                self.rightRect.anchoredPosition = Vector2(self.rightPosition.x + value, self.rightPosition.y)
                if self.status == 0 then
                    if currentOffset == 0 then
                        canvasAlpha = 1
                    else
                        canvasAlpha = self.topUIAlpha + (1 - self.topUIAlpha) * (1 - value / currentOffset)
                    end
                else
                    canvasAlpha = self.topUIAlpha - self.topUIAlpha * value / offset
                end
                self.leftCanvasGroup.alpha = canvasAlpha
                self.rightCanvasGroup.alpha = canvasAlpha
            end,
            offset, HeroDragPage.TopTweenDuration
    ):SetEase(Ease.Linear);
end

SetInTopTween = function(self)
    if self.tween ~= nil then
        self.tween:Kill()
        self.tween = nil
    end

    if self.leftPosition == nil or self.rightPosition == nil then
        return
    end

    local offset = self.leftPosition.x - self.leftRect.anchoredPosition.x
    if offset == 0 then
        return
    end
    
    local canvasAlpha = 0
    self.tween=DOTWeen.To(
            function()
                return offset
            end,
            function(value)
                self.leftRect.anchoredPosition = Vector2(self.leftPosition.x + value, self.leftPosition.y)
                self.rightRect.anchoredPosition = Vector2(self.rightPosition.x + value, self.rightPosition.y)
                canvasAlpha = 1 - value / offset
                self.leftCanvasGroup.alpha = canvasAlpha
                self.rightCanvasGroup.alpha = canvasAlpha
            end,
            0, HeroDragPage.TopTweenDuration
    ):SetEase(Ease.Linear);
end