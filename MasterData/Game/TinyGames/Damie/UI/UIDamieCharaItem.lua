local UIDamieCharaItem = class("UIDamieCharaItem", UIBaseNode)
local base = UIBaseNode
local cs_Tweening = CS.DG.Tweening
local cs_DoTween = cs_Tweening.DOTween

function UIDamieCharaItem:OnShow()
  base.OnShow(self)
  if self.bornSeq ~= nil then
    self.bornSeq:Kill()
  end
  self.transform.localRotation = Quaternion.Euler(90, 0, 0)
  self.transform.localPosition = Vector3.zero
  self.bornSeq = cs_DoTween.Sequence()
  self.bornSeq:Append(self.transform:DOLocalRotate(Vector3.zero, 0.1, cs_Tweening.RotateMode.FastBeyond360):SetUpdate(true):SetEase(cs_Tweening.Ease.OutQuad):SetAutoKill(false))
end

function UIDamieCharaItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn_HeroPic.onPressDown:AddListener(BindCallback(self, self.__OnPressItem))
  self.__recycleItem = BindCallback(self, self.__RecycleItem)
end

function UIDamieCharaItem:InitWithData(id, existTime, maxPressedCount)
  self.dataId = id
  self.existTime = existTime
  self.isUpdateExistTime = false
  self.scoreGetted = 0
  self.maxPressedCount = maxPressedCount or 1
end

function UIDamieCharaItem:UpdateExistTime(existTime)
  if self.isUpdateExistTime then
    return
  end
  self.existTime = existTime
  if self.existTimerId ~= nil then
    TimerManager:StopTimer(self.existTimerId)
    self.existTimerId = nil
  end
  self:Active()
  self.isUpdateExistTime = true
end

function UIDamieCharaItem:CheckAndActiveExtraState(value)
  if self.ui.state2 ~= nil and self.ui.state2.activeSelf ~= value then
    self.ui.state2:SetActive(value)
  end
end

function UIDamieCharaItem:InjectPressFunc(onPressedAction)
  self.__onPressedAction = onPressedAction
end

function UIDamieCharaItem:InjectRecycleItemFunc(onRecycleItem)
  self.__onRecycleItem = onRecycleItem
end

function UIDamieCharaItem:Active()
  self.existTimerId = TimerManager:StartTimer(self.existTime, self.__recycleItem, nil, true)
end

function UIDamieCharaItem:__OnPressItem()
  if self.__onPressedAction == nil then
    return
  end
  local result = false
  self.maxPressedCount = self.maxPressedCount - 1
  if self.shakeSeq ~= nil then
    self.shakeSeq:Kill()
  end
  self.shakeSeq = cs_DoTween.Sequence()
  self.shakeSeq:Append(self.transform:DOShakePosition(0.1, Vector3.New(200, 0, 200), 50):SetUpdate(true):SetEase(cs_Tweening.Ease.OutQuad):SetAutoKill(false))
  if self.__onPressedAction ~= nil then
    result = self.__onPressedAction(self.maxPressedCount)
  end
  if result then
    self.__onPressedAction = nil
    self:__RecycleItem()
  end
end

function UIDamieCharaItem:UpdateScoreGetted(score)
  self.scoreGetted = self.scoreGetted + score
end

function UIDamieCharaItem:GetDamieCharaItemHeroId()
  return self.ui.dataId
end

function UIDamieCharaItem:__RecycleItem()
  if self.existTimerId ~= nil then
    TimerManager:StopTimer(self.existTimerId)
    self.existTimerId = nil
  end
  if self.deadSeq ~= nil then
    self.deadSeq:Kill()
  end
  self.transform.localRotation = Quaternion.identity
  self.deadSeq = cs_DoTween.Sequence()
  self.deadSeq:Append(self.transform:DOLocalRotate(Vector3.New(85, 0, 0), 0.1, cs_Tweening.RotateMode.FastBeyond360):SetEase(cs_Tweening.Ease.InBounce))
  self.deadSeq:Join(self.transform:DOLocalMoveY(-120, 0.1):SetEase(cs_Tweening.Ease.InBounce))
  self.deadSeq:SetAutoKill(false)
  self.deadSeq:SetUpdate(true)
  TimerManager:StartTimer(0.2, function()
    if self.__onRecycleItem ~= nil then
      self.__onRecycleItem(self.dataId)
    end
  end, nil, true, false, true)
end

function UIDamieCharaItem:__ResetData()
  self:CheckAndActiveExtraState(false)
  self.dataId = nil
  self.existTime = nil
  self.maxPressedCount = nil
  self.__onPressedAction = nil
  self.__onRecycleItem = nil
  self.isUpdateExistTime = false
  self.scoreGetted = 0
end

function UIDamieCharaItem:OnHide()
  base.OnHide(self)
  self:__StopExistTimer()
  self:__ResetData()
end

function UIDamieCharaItem:OnDelete()
  self:__StopExistTimer()
  if self.bornSeq ~= nil then
    self.bornSeq:Kill()
    self.bornSeq = nil
  end
  if self.shakeSeq ~= nil then
    self.shakeSeq:Kill()
    self.shakeSeq = nil
  end
  if self.deadSeq ~= nil then
    self.deadSeq:Kill()
    self.deadSeq = nil
  end
  base.OnDelete(self)
end

function UIDamieCharaItem:__StopExistTimer()
  if self.existTimerId ~= nil then
    TimerManager:StopTimer(self.existTimerId)
    self.existTimerId = nil
  end
end

return UIDamieCharaItem
