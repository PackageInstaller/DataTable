_class("UICN17N46FishingGameBubble", Object)
UICN17N46FishingGameBubble = UICN17N46FishingGameBubble

function UICN17N46FishingGameBubble:Constructor(parentTrans)
  self._bubbleReq = ResourceManager:GetInstance():SyncLoadAsset("UICN17N46FishingGameBubble.prefab", LoadType.GameObject)
  self._bubbleObj = self._bubbleReq.Obj
  self._bubbleObj.transform:SetParent(parentTrans, false)
  self._bubbleObj.transform.localPosition = Vector3.zero
  self._bubbleObj.transform.localEulerAngles = Vector3.zero
  self._bubbleObj.transform.localScale = Vector3.one
  self._errorObj = self._bubbleObj.transform:GetChild(0).gameObject
  self._rightObj = self._bubbleObj.transform:GetChild(1).gameObject
  self._scoreText = self._rightObj.transform:GetChild(0):GetComponent("UILocalizationText")
  self._bubbleObj:SetActive(false)
  self._isUsing = false
  self._timerHolder = UITimerHolder:New()
end

function UICN17N46FishingGameBubble:Hide()
  if self._bubbleObj ~= nil then
    self._bubbleObj:SetActive(false)
  end
end

function UICN17N46FishingGameBubble:Show(score, isRightFish, targetPos, offset)
  self._bubbleObj:SetActive(true)
  self._isUsing = true
  self._bubbleObj.transform.position = targetPos
  self._bubbleObj.transform.localPosition = self._bubbleObj.transform.localPosition + Vector3.up * 200
  if offset then
    local tmp = Vector2(self._bubbleObj.transform.localPosition.x + offset.x, self._bubbleObj.transform.localPosition.y + offset.y)
    self._bubbleObj.transform.localPosition = tmp
  end
  if isRightFish then
    self._scoreText:SetText("+" .. score)
    self._rightObj:SetActive(true)
    self._errorObj:SetActive(false)
  else
    self._rightObj:SetActive(false)
    self._errorObj:SetActive(true)
  end
  self._timerHolder:StartTimer("WaitForAnim", 1000, function()
    self:Hide()
    self._isUsing = false
  end)
end

function UICN17N46FishingGameBubble:CheckUsing()
  return self._isUsing
end

function UICN17N46FishingGameBubble:Dispose()
  if self._bubbleReq then
    self._bubbleReq:Dispose()
  end
  self._timerHolder:Dispose()
  self._bubbleReq = nil
  self._errorImg = nil
  self._scoreText = nil
  self._bubbleObj = nil
end
