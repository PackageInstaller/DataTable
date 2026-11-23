

























ElementCell = {}
ElementCell.__index = ElementCell

local objs = {
    animator = {path = "Group", type = UITool.Animator},
    groupObj = {path = "Group", type = UITool.GameObject},
    bgObj = {path = "BG", type = UITool.GameObject},
    horizonArrowObj = {path = "Group/HorizonArrow", type = UITool.GameObject},
    verticalArrowObj = {path = "Group/VerticalArrow", type = UITool.GameObject},
    lockObj = {path = "Group/Lock", type = UITool.GameObject},
    lock1Obj = {path = "Group/Lock/Lock1", type = UITool.GameObject},
    lock2Obj = {path = "Group/Lock/Lock2", type = UITool.GameObject},
    selectObj = {path = "Group/SelectObj", type = UITool.GameObject},
    baseIcon = {path = "Group/BaseIcon", type = UITool.Image},
    xingyunEffect = {path = "Group/eff_xingyun_loop", type = UITool.GameObject},
    guadaoEffect = {path = "Group/eff_guadao_loop", type = UITool.GameObject},
    wuyaEffect = {path = "Group/eff_wuya_loop", type = UITool.GameObject},
    fireEffect = {path = "Group/eff_fire_loop", type = UITool.GameObject},
    eliminateEffect = {path = "Group/eff_boom", type = UITool.GameObject},
    eliminateFireEffect = {path = "Group/eff_fire", type = UITool.GameObject}
}

ElementCell.FadeOrgin = UnityEngine.Color(1, 1, 1, 1)
ElementCell.FadeGoal = UnityEngine.Color(0.8, 0.8, 0.8, 0.8)
ElementCell.GridParentSizeHalf = nil
ElementCell.CellSizeHalf = nil

function ElementCell.New(elementType, isIce, prefab, parentTransform, cellSize)
    if ElementCell.GridParentSizeHalf == nil then
        local parentRect = parentTransform:GetComponent(UITool.RectTransform)
        ElementCell.GridParentSizeHalf = parentRect.sizeDelta.x / 2
    end
    if ElementCell.CellSizeHalf == nil then
        ElementCell.CellSizeHalf = cellSize / 2
    end

    local self = {}
    setmetatable(self, ElementCell)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parentTransform, false)
    self.transform = self.gameObject.transform
    self.rectTransform = self.transform:GetComponent(UITool.RectTransform)
    self.elementType = elementType
    self.isIce = isIce
    UITool.Parse(self.gameObject, self, objs)
    self.CellSize = cellSize
    self.CurrentElement = nil
    self:RegisterEvents()
    SetActive(self.groupObj, self.elementType ~= Match3Const.ElementType.None)
    local func = function()
        if IsObjectNull(self.gameObject) == false and self.groupObj.activeSelf == true then
            self.animator:Play(Match3Const.BornAnimName)
        end
    end
    LuaMgr.NextFrame(func)
    return self
end

function ElementCell:SetIcon()
    self.tempType = nil
    SetActive(self.baseIcon.gameObject, false)
    SetActive(self.xingyunEffect, false)
    SetActive(self.guadaoEffect, false)
    SetActive(self.fireEffect, false)
    SetActive(self.wuyaEffect, false)
    if self.elementType == Match3Const.ElementType.SuperColorBall then
        SetActive(self.xingyunEffect, true)
    elseif self.elementType == Match3Const.ElementType.Horizontal or self.elementType == Match3Const.ElementType.Vertical then
        SetActive(self.guadaoEffect, true)
    elseif self.elementType == Match3Const.ElementType.ColorBall then
        SetActive(self.fireEffect, true)
    elseif self.elementType == Match3Const.ElementType.WoodenBox then
        SetActive(self.wuyaEffect, true)
    elseif self.elementType ~= Match3Const.ElementType.None then
        SetActive(self.baseIcon.gameObject, true)
        local atlasName = "Match3Game"
        local prifixName = "ui_hd_hw_sx_icon_"
        local spriteName = prifixName .. Match3Const.ElementType2ID[self.elementType]
        self.sprite = LuaMgr.GetSprite(atlasName, spriteName)
        self.baseIcon.sprite = self.sprite
    end
end


function ElementCell:SetTempIconByType(type)
    local atlasName = "Match3Game"
    local prifixName = "ui_hd_hw_sx_icon_"
    local spriteName = prifixName .. Match3Const.ElementType2ID[type]
    self.sprite = LuaMgr.GetSprite(atlasName, spriteName)
    self.baseIcon.sprite = self.sprite
    self.tempType = type
end

function ElementCell:SetTempType(type)
    self.tempType = type
end

function ElementCell:Reset()
    self.elementType = self.CurrentElement.Type
    SetActive(self.groupObj, self.elementType ~= Match3Const.ElementType.None)
    SetActive(self.bgObj, self.elementType == Match3Const.ElementType.None)
    SetActive(self.horizonArrowObj, self.elementType == Match3Const.ElementType.Horizontal)
    SetActive(self.verticalArrowObj, self.elementType == Match3Const.ElementType.Vertical)
    SetActive(self.lockObj, self.isIce == true)
    SetActive(self.lock1Obj, true)
    SetActive(self.lock2Obj, true)
    SetActive(self.selectObj, false)
    SetActive(self.baseIcon.gameObject, self.elementType ~= Match3Const.ElementType.None)
    self:SetIcon()
end


function ElementCell:RegisterEvents()
    self.onClick = function(pos)
        if self.elementType == Match3Const.ElementType.None then
            return
        end
        if self.CurrentElement and self.CurrentElement.Pos:Equals(pos) then
            self:OnClicked()
        end
    end
    self.onDragBegin = function(startPos)
        if self.elementType == Match3Const.ElementType.None then
            return
        end
        if self.CurrentElement and self.CurrentElement.Pos:Equals(startPos) then
            self:OnDragStarted()
        end
    end
    self.onDragEnd = function(startPos, endPos)
        if self.elementType == Match3Const.ElementType.None then
            return
        end
        if self.CurrentElement and self.CurrentElement.Pos:Equals(startPos) then
            self:OnDragEnded(endPos)
        end
    end
    self.onElementFall = function(param)
        if self.elementType == Match3Const.ElementType.None then
            return
        end
        local animData = param[0]
        self:HandleElementFall(animData)
    end
    self:UnRegisterEvents()
    LuaMgr.AddUIEventListener(UIEventConst.ElementFall, self.onElementFall)
    LuaMgr.AddUIEventListener(UIEventConst.Match3ElementClick, self.onClick)
    LuaMgr.AddUIEventListener(UIEventConst.Match3ElementDragBegin, self.onDragBegin)
    LuaMgr.AddUIEventListener(UIEventConst.Match3ElementDragEnd, self.onDragEnd)
end

function ElementCell:UnRegisterEvents()
    LuaMgr.RemoveUIEventListener(UIEventConst.ElementFall, self.onElementFall)
    LuaMgr.RemoveUIEventListener(UIEventConst.Match3ElementClick, self.onClick)
    LuaMgr.RemoveUIEventListener(UIEventConst.Match3ElementDragBegin, self.onDragBegin)
    LuaMgr.RemoveUIEventListener(UIEventConst.Match3ElementDragEnd, self.onDragEnd)
end



function ElementCell:SetElement(element)
    self.CurrentElement = element
    if element then
        self.gameObject.name = tostring(element.Id)
        self:SetVisible(true)
        self:Reset()
        self:UpdatePosition()
        local id = self.CurrentElement:GetID()
        if self.elementType ~= Match3Const.ElementType.None then
            self.elementFactory:CacheCellByPosKey(self.CurrentElement.Pos, self)
        else
            self.elementFactory.nullElementCellMap[id] = self
        end
    else
        self.gameObject.name = "NULL"
        self:SetVisible(false)
    end
end

function ElementCell:ReSetElement(element)
    if self.elementType == Match3Const.ElementType.None then
        return 0, Match3Const.AnimTimeCalType.Max
    end
    local animTime = 0.25
    if self.tweenSequenceReset ~= nil then
        self.tweenSequenceReset:Kill()
        self.tweenSequenceReset = nil
    end
    local tempCallback = function()
        local oldPosKey = self.CurrentElement.Pos:ToString()
        self.elementFactory:CacheCellByPosKey(self.CurrentElement.Pos, nil)
        self.CurrentElement = element
        self.gameObject.name = tostring(element.Id)
        self:Reset()
        self.elementFactory:CacheCellByPosKey(self.CurrentElement.Pos, self)
    end
    self.tweenSequenceReset = DOTWeen:Sequence()
    self.tweenSequenceReset:AppendInterval(animTime):OnComplete(tempCallback)
    return animTime, Match3Const.AnimTimeCalType.Max
end


function ElementCell:UpdatePosition()
    if not self.CurrentElement then
        return
    end
    local pos = self.CurrentElement.Pos
    local localPosX = pos.X * self.CellSize - ElementCell.GridParentSizeHalf - ElementCell.CellSizeHalf
    local localPosY = -pos.Y * self.CellSize + ElementCell.GridParentSizeHalf + ElementCell.CellSizeHalf
    self.transform.localPosition = Vector3(localPosX, localPosY, 0)
end

function ElementCell:SetVisible(visible)
    SetActive(self.gameObject, visible)
end



function ElementCell:PlayEliminateAnimation(callback)
    local animTime = 0
    if self.CurrentElement.Healthy > 0 then
        self.CurrentElement:AddHealty(-1)
        if self.CurrentElement == 1 then
            SetActive(self.lock2Obj, false)
        elseif self.CurrentElement == 0 then
            SetActive(self.lock1Obj, false)
        end
    end
    local tempCallback = function()
        if self.tempType ~= nil and self.tempType == Match3Const.ElementType.ColorBall then
            self:SetFireElimateEffect(false)
        else
            SetActive(self.eliminateEffect, false)
        end
        if callback then
            callback(self)
        end
    end
    if self.tempType ~= nil and self.tempType == Match3Const.ElementType.ColorBall then
        self:SetFireElimateEffect(true)
    else
        SetActive(self.eliminateEffect, true)
    end

    animTime = Match3Const.EliminatedWaitTime
    if self.tweenSequence ~= nil then
        self.tweenSequence:Kill()
        self.tweenSequence = nil
    end
    self.tweenSequence = DOTWeen:Sequence()
    self.tweenSequence:AppendInterval(animTime):OnComplete(tempCallback)
    return animTime, Match3Const.AnimTimeCalType.Max
end

function ElementCell:PlayEliminateAnimationMove(pos, during)
    if self.posDoTween ~= nil then
        self.posDoTween.onComplete = nil
        self.posDoTween:Kill()
        self.posDoTween = nil
    end
    local startPosFunc = function()
        return self.transform.localPosition
    end
    local updatePosFunc = function(localPos)
        self.transform.localPosition = localPos
    end
    local localPosX = pos.X * self.CellSize - ElementCell.GridParentSizeHalf - ElementCell.CellSizeHalf
    local localPosY = -pos.Y * self.CellSize + ElementCell.GridParentSizeHalf + ElementCell.CellSizeHalf
    local endPos = Vector3(localPosX, localPosY, 0)
    local callback = function()
        self:SetVisible(false)
    end
    self.posDoTween = DOTWeen.To(startPosFunc, updatePosFunc, endPos, during):OnComplete(callback)
    self.posDoTween:SetEase(Ease.InBack)
end

function ElementCell:SetFireElimateEffect(visible)
    SetActive(self.eliminateFireEffect, visible)
end

function ElementCell:HandleElementFall(animData)
    if self.CurrentElement == nil then
        return
    end
    local curElementID = self.CurrentElement:GetID()
    local tempElementID = animData.element:GetID()
    if curElementID == tempElementID then
        local orginPos = animData.fromPos
        local localOrginPosX = orginPos.X * self.CellSize - ElementCell.GridParentSizeHalf - ElementCell.CellSizeHalf
        local localOrginPosY = -orginPos.Y * self.CellSize + ElementCell.GridParentSizeHalf + ElementCell.CellSizeHalf
        local orginLocalPos = Vector3(localOrginPosX, localOrginPosY, 0)
        self.transform.localPosition = orginLocalPos
        local targetPos = animData.toPos
        local localPosX = targetPos.X * self.CellSize - ElementCell.GridParentSizeHalf - ElementCell.CellSizeHalf
        local localPosY = -targetPos.Y * self.CellSize + ElementCell.GridParentSizeHalf + ElementCell.CellSizeHalf
        local targetLocalPos = Vector3(localPosX, localPosY, 0)
        self.AnimBeforePos = self.CurrentElement.Pos
        local onComplete = function()
            if self.CurrentElement then
                self.CurrentElement:UpdatePosition(targetPos)
                self.CurrentElement:ResetTempPos()
                self:UpdatePosition()
                animData.cell = self
                LuaMgr.InvokeUIEventListeners(UIEventConst.SingElementFallEnd, animData)
                self.fallTween = nil
            end
        end
        if self.fallTween then
            self.fallTween:Kill()
            self.fallTween = nil
        end
        self.fallTween = self.transform:DOLocalMove(targetLocalPos, animData.duration)
        self.fallTween:OnComplete(onComplete)
    end
end


function ElementCell:OnClicked()
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ElementViewClick, self.CurrentElement)
end


function ElementCell:OnDragStarted()
    self.baseIcon.color = ElementCell.FadeGoal
end


function ElementCell:OnDragEnded(endPos)
    self.baseIcon.color = ElementCell.FadeOrgin
    LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ElementViewDragEnd, self.CurrentElement.Pos, endPos)
end


function ElementCell:Recycle()
    if self.gameObject == nil or IsObjectNull(self.gameObject) then
        return
    end
    self.rectTransform.anchoredPosition = Vector2(100000, 100000)
    self:SetElement(nil)
end

function ElementCell:Destroy()
    self:UnRegisterEvents()
end