_class("UIActivityNewYearLuckBagController", UIController)
UIActivityNewYearLuckBagController = UIActivityNewYearLuckBagController

function UIActivityNewYearLuckBagController:OnShow(uiParams)
  self._randomLotteryComponentInfo = uiParams[1]
  self.drawList = self._randomLotteryComponentInfo.m_draw
  self.uiCtrl = uiParams[2]
  self._storyComp = uiParams[3]
  self._DRAWResult = self.uiCtrl._DRAWResult
  self.MAXDRAWTIME = self.uiCtrl.MAXDRAWTIME
  self._isExpire = false
  self._hasDrawedExtremely = false
  self._DrawResult = self:GetUIComponent("UISelectObjectPath", "DrawResult")
  self._selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self.cancelButton = self:GetGameObject("CancelButton")
  self.finishDrawButton = self:GetGameObject("FinishDrawButton")
  self.reDrawButton = self:GetGameObject("ReDrawButton")
  self.remainDrawTime = self:GetUIComponent("UILocalizationText", "RemainDrawTime")
  self.spineLoader = self:GetUIComponent("SpineLoader", "SpineLoader")
  self._posAndScaleRoot = self:GetUIComponent("RectTransform", "posAndScale")
  self._anim = self:GetUIComponent("Animation", "anim")
  local topBarPool = self:GetUIComponent("UISelectObjectPath", "CommonTopBar")
  local topBtns = topBarPool:SpawnObject("UINewCommonTopButton")
  topBtns:SetData(function()
    self:_Close()
  end, nil, nil, true)
  self:ShowDrawAnimation()
  self:_SetCommonTopButton()
end

function UIActivityNewYearLuckBagController:ShowDrawAnimation()
  self:FlushDrawResult()
end

function UIActivityNewYearLuckBagController:OnItemSelect(id, pos)
  if not self._selectInfo then
    self._selectInfo = self._selectInfoPool:SpawnObject("UISelectInfo")
  end
  self._selectInfo:SetData(id, pos)
end

function UIActivityNewYearLuckBagController:FlushDrawResult()
  for _, v in pairs(self.drawList) do
    if v.random_type == self._DRAWResult.Extremely then
      self._hasDrawedExtremely = true
    end
  end
  local drawResultPool = self._DrawResult:SpawnObject("UIActivityNewYearLuckBagResultItem")
  local lastestDrawResultInfo = self.drawList[#self.drawList]
  local resultCfg = self:GetDrawResultCfg(lastestDrawResultInfo.pet_cfg_id)
  drawResultPool:FlushData(lastestDrawResultInfo, self.uiCtrl, false, function(id, pos)
    self:OnItemSelect(id, pos)
  end)
  self.curDrawResultType = lastestDrawResultInfo.random_type
  local leftTime = self.MAXDRAWTIME - table.count(self.drawList)
  leftTime = leftTime == 0 and "<color=#FF0000>" .. leftTime .. "</color>" or leftTime
  local tempRemindTime = "<color=#ffd257>" .. leftTime .. "/" .. self.MAXDRAWTIME .. "</color>"
  self.remainDrawTime:SetText(StringTable.Get("str_cn12_n41_game_tip2", tempRemindTime))
  self:FlushButtons()
  self:FlushSpine(resultCfg.SpineIdle, resultCfg.SpineFace)
  UICG.SetTransform(self.spineLoader.transform, "UIMainLobbyController", resultCfg.SpineIdle)
end

function UIActivityNewYearLuckBagController:FlushSpine(spine, spineFace)
  spineFace = spineFace or "idle"
  self.spineLoader:LoadSpine(spine)
  self._spineSke = self.spineLoader.CurrentSkeleton
  if not self._spineSke then
    self._spineSke = self.spineLoader.CurrentMultiSkeleton
  end
  if self._spineSke then
    self._spineSke.AnimationState:SetAnimation(0, spineFace, true)
  end
end

function UIActivityNewYearLuckBagController:GetDrawResultCfg(id)
  local cfgs = Cfg.cfg_component_random_lottery_draw_pet({ID = id})
  if cfgs and 0 < #cfgs then
    return cfgs[1]
  end
  return nil
end

function UIActivityNewYearLuckBagController:FlushButtons()
  self.cancelButton:SetActive(false)
  self.finishDrawButton:SetActive(false)
  self.reDrawButton:SetActive(false)
  if #self.drawList == self.MAXDRAWTIME then
    self.finishDrawButton:SetActive(true)
  elseif self.curDrawResultType ~= self._DRAWResult.Extremely then
    self.reDrawButton:SetActive(true)
  else
    self.cancelButton:SetActive(true)
    self.reDrawButton:SetActive(true)
  end
end

function UIActivityNewYearLuckBagController:_SetCommonTopButton()
end

function UIActivityNewYearLuckBagController:SetExpire(isExpire)
  self._isExpire = isExpire
end

function UIActivityNewYearLuckBagController:ReDrawButtonOnClick()
  if self._isExpire then
    self:_Close()
    return
  end
  self.uiCtrl:DrawAction(function()
    self:_Close(function()
      self:ShowDialog("UIActivityNewYearLuckBagAnimController", self._randomLotteryComponentInfo, self.uiCtrl, self._storyComp)
    end)
  end)
end

function UIActivityNewYearLuckBagController:CancelButtonOnClick()
  self:_Close()
end

function UIActivityNewYearLuckBagController:FinishDrawButtonOnClick()
  self:_Close()
end

function UIActivityNewYearLuckBagController:_Close(cb)
  self:StartTask(function(TT)
    self._anim:Play("uieff_UIActivityNewYearLuckBagController_out")
    self:Lock("uieff_UIActivityNewYearLuckBagController_out")
    YIELD(TT, 267)
    self:UnLock("uieff_UIActivityNewYearLuckBagController_out")
    self:CloseDialog()
    if cb then
      cb()
    end
  end)
end

function UIActivityNewYearLuckBagController:_HideUI()
  self._topComponentObj:SetActive(false)
end

function UIActivityNewYearLuckBagController:_ShowUI()
  self._topComponentObj:SetActive(true)
end
