_class("UIN12HardLevelScoreItem", UICustomWidget)
UIN12HardLevelScoreItem = UIN12HardLevelScoreItem

function UIN12HardLevelScoreItem:Constructor()
  self._atlas = self:GetAsset("UIN12.spriteatlas", LoadType.SpriteAtlas)
  self._animationName = "uieff_N12_Hard_ScroeItem_In"
end

function UIN12HardLevelScoreItem:OnShow(uiParams)
  self:_GetComponent()
  self:_AttachEvent()
end

function UIN12HardLevelScoreItem:_AttachEvent()
  self:AttachEvent(GameEventType.OnAffixScoreChange, self._OnAffixScoreChange)
end

function UIN12HardLevelScoreItem:_GetComponent()
  self._unLockScore = self:GetUIComponent("UILocalizationText", "UnLockScore")
  self._text = self:GetUIComponent("UILocalizationText", "Text")
  self._score = self:GetUIComponent("UILocalizationText", "Score")
  self._buttonObj = self:GetGameObject("Button")
  self._buttonImg = self:GetUIComponent("Image", "Button")
  self._gainType = self:GetUIComponent("Image", "GainType")
  self._selectMark = self:GetGameObject("Select")
  self._mutex = self:GetGameObject("Mutex")
  self._lock = self:GetGameObject("Lock")
  self._animation = self.view.gameObject:GetComponent("Animation")
  self._image1CanvasGroup = self:GetUIComponent("CanvasGroup", "Image1")
  self._image2CanvasGroup = self:GetUIComponent("CanvasGroup", "Image2")
  self._arrayBgObj = self:GetGameObject("ArrayBg")
  self._arrayBgRectTransform = self:GetUIComponent("RectTransform", "ArrayBg")
end

function UIN12HardLevelScoreItem:SetData(globalDelayTimeFunc, affixIds, selectAffixCallBack, mutexCheck, affixArrayIndex, affixArray)
  self._missionAffixCfg = Cfg.cfg_component_mission_affix[affixIds[1]]
  if not self._missionAffixCfg then
    Log.error("cfg_component_mission_affix does not exist." .. affixIds[1])
    return
  end
  local affixCfg = Cfg.cfg_affix[self._missionAffixCfg.AffixID]
  if not affixCfg then
    Log.error("cfg_affix does not exist." .. self._missionAffixCfg.AffixID)
    return
  end
  N12ToolFunctions.SetAffixText(self._text, affixCfg)
  self._score:SetText(self._missionAffixCfg.AffixScore)
  local color = Color(1.0, 0.7764705882352941, 0.1803921568627451)
  if self._missionAffixCfg.GainType == GainType.Friend then
    color = Color.red
  end
  self._score.color = color
  self._gainType.sprite = self._atlas:GetSprite(GainTypeSprite[self._missionAffixCfg.GainType])
  self._selectAffixCallBack = selectAffixCallBack
  self._mutexCheck = mutexCheck
  self._affixArrayIndex = affixArrayIndex
  self._affixArray = affixArray
  self._selected = table.icontains(self.uiOwner:GetSelectedAffixes(), affixIds[1])
  self:SelectAffix(self._selected, true)
  if affixArrayIndex then
    if affixArrayIndex == 1 then
      local affixCount = #affixArray
      self._arrayBgRectTransform.sizeDelta = Vector2(self._arrayBgRectTransform.sizeDelta.x, 89 * affixCount + (affixCount - 1) * 10)
    end
    self._arrayBgObj:SetActive(affixArrayIndex == 1)
  else
    self._arrayBgObj:SetActive(true)
    self._arrayBgRectTransform.sizeDelta = Vector2(self._arrayBgRectTransform.sizeDelta.x, 89)
  end
  self:_PlayAnimation(globalDelayTimeFunc)
end

function UIN12HardLevelScoreItem:_PlayAnimation(globalDelayTimeFunc)
  self._animation:Stop()
  self._animation:Play(self._animationName)
end

function UIN12HardLevelScoreItem:ButtonOnClick(go)
  self:_OnClickAffix()
end

function UIN12HardLevelScoreItem:LockOnClick(go)
  self:_OnClickAffix()
end

function UIN12HardLevelScoreItem:_OnClickAffix()
  local curScore = self.uiOwner:GetCurScore()
  if self._missionAffixCfg.GainType == GainType.Friend then
    curScore = curScore + self._missionAffixCfg.AffixScore
  end
  if curScore < self._missionAffixCfg.UnLockScore then
    ToastManager.ShowToast(StringTable.Get("str_n12_affix_unlock_score", self._missionAffixCfg.UnLockScore))
    return
  end
  self:SelectAffix(not self._selected, true)
  if self._mutexCheck then
    self._mutexCheck(self._affixArrayIndex)
  end
end

function UIN12HardLevelScoreItem:SelectAffix(select, needCalcScore)
  local needCallBack = self._selected ~= select and needCalcScore
  self._selected = select
  if needCallBack then
    self._selectAffixCallBack(self._missionAffixCfg.ID, select)
  end
  local sprite = "n12_xiangqing_icon_weixuan"
  if self._selected then
    sprite = "n12_xiangqing_icon_xuanzhong"
  end
  self._buttonImg.sprite = self._atlas:GetSprite(sprite)
  self._selectMark:SetActive(self._selected)
  self:_RefreshUnLockInfo()
end

function UIN12HardLevelScoreItem:_RefreshUnLockInfo()
  local lock = self._missionAffixCfg.UnLockScore > self.uiOwner:GetCurScore()
  self._lock:SetActive(lock)
  self._buttonObj:SetActive(not lock)
  local str = string.format("<color=#FFBF14>%s</color>", self._missionAffixCfg.UnLockScore)
  if lock then
    str = string.format("<color=#FF4141>%s</color>", self._missionAffixCfg.UnLockScore)
  end
  self._unLockScore:SetText(StringTable.Get("str_n12_affix_unlock_score", str))
  local mutex = lock
  if self._affixArray then
    for i = 1, #self._affixArray do
      local contain = table.icontains(self.uiOwner:GetSelectedAffixes(), self._affixArray[i])
      if contain and self._affixArray[i] ~= self._missionAffixCfg.ID and not self._selected then
        mutex = true
      end
    end
  end
  self._mutex:SetActive(mutex)
end

function UIN12HardLevelScoreItem:_OnAffixScoreChange()
  local select = table.icontains(self.uiOwner:GetSelectedAffixes(), self._missionAffixCfg.ID)
  if not select and self._selected then
    self:SelectAffix(false, false)
  else
    self:_RefreshUnLockInfo()
  end
end
