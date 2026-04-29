_class("UIN25VampireChallengeTaskGain", UIController)
UIN25VampireChallengeTaskGain = UIN25VampireChallengeTaskGain

function UIN25VampireChallengeTaskGain:LoadDataOnEnter(TT, res, uiParams)
end

function UIN25VampireChallengeTaskGain:OnShow(uiParams)
  self._bloodsuckerComponentInfo = uiParams[1]
  self._rewards = uiParams[2]
  self._lastdata = uiParams[3]
  self._hidecallback = uiParams[4]
  self._taskid = uiParams[5]
  self.slider = self:GetUIComponent("Slider", "sldProgress")
  self.levelText = self:GetUIComponent("UILocalizationText", "levelText")
  self.lInfoText = self:GetUIComponent("UILocalizationText", "lInfoText")
  self.rInfoText = self:GetUIComponent("UILocalizationText", "rInfoText")
  self.addText = self:GetUIComponent("UILocalizationText", "addText")
  self.preText = self:GetUIComponent("UILocalizationText", "pre")
  self.lastText = self:GetUIComponent("UILocalizationText", "last")
  self.preGo = self:GetGameObject("pre")
  self.arrGo = self:GetGameObject("arr")
  self.lastGo = self:GetGameObject("last")
  self.upGo = self:GetGameObject("up")
  self.uplevelGo = self:GetGameObject("uplevel")
  self.btnGo = self:GetGameObject("Btn")
  self.prenochangeText = self:GetUIComponent("UILocalizationText", "prenochange")
  self.prenochangeGo = self:GetGameObject("prenochange")
  self._anim = self:GetUIComponent("Animation", "lvUp")
  self:Flush()
end

function UIN25VampireChallengeTaskGain:Flush()
  local data = self._bloodsuckerComponentInfo.talent_info
  local cfg = Cfg.cfg_component_bloodsucker_talent_level({
    Level = data.talent_level
  })
  local prelevelCfg = Cfg.cfg_component_bloodsucker_talent_level({
    Level = data.talent_level - 1
  })
  local addExpCount = 0
  local addpoint = 0
  local changeLv = false
  if data.talent_level ~= self._lastdata.talent_level then
    changeLv = true
    self:PlayLvAnim(data.talent_level)
  else
    self.levelText:SetText(data.talent_level)
  end
  for index, value in ipairs(self._rewards) do
    if value.assetid == 3000289 then
      addExpCount = value.count
    end
    if value.assetid == 3000290 then
      addpoint = value.count
    end
  end
  if 0 < addExpCount then
    self.lInfoText:SetText(0)
    self:ShowTweenAni(self.lInfoText, 0, data.cur_exp, 1200)
    self.rInfoText:SetText("/" .. cfg[1].Exp)
  else
    self.lInfoText:SetText(data.cur_exp)
    self.rInfoText:SetText("/" .. cfg[1].Exp)
  end
  if 0 < addpoint then
    self.prenochangeGo:SetActive(false)
    self.preGo:SetActive(true)
    self.upGo:SetActive(true)
    local point = data.cur_talent_point - addpoint
    if data.talent_level ~= self._lastdata.talent_level and prelevelCfg then
      point = point - prelevelCfg[1].TalentPoint
    end
    self.preText:SetText(point)
    self.lastText:SetText(point)
    self:PlayPointAnim(changeLv)
    self:ShowTweenAni(self.lastText, point, data.cur_talent_point, 1400)
  else
    self.prenochangeGo:SetActive(true)
    self.prenochangeText:SetText(data.cur_talent_point)
    self.upGo:SetActive(false)
    self.preGo:SetActive(false)
  end
  self.addText:SetText("+" .. addExpCount)
  self.btnGo:SetActive(false)
  self:PlayBtnAnim()
  self:PlaySliderAnim(data, cfg, prelevelCfg)
end

function UIN25VampireChallengeTaskGain:OnHide()
  self._rewards = nil
  if self._hidecallback then
    self._hidecallback(self._taskid)
  end
end

function UIN25VampireChallengeTaskGain:BtnOnClick()
  self:CloseDialog()
end

function UIN25VampireChallengeTaskGain:CloseOnClick()
  self:CloseDialog()
end

function UIN25VampireChallengeTaskGain:ShowTweenAni(textCom, startvalue, endvalue, yeildtime)
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "HideCallBack"
    self:Lock(lockName)
    YIELD(TT, yeildtime)
    DoTweenHelper.DoUpdateInt(startvalue, endvalue, 0.5, function(val)
      local num = math.floor(val)
      textCom:SetText(num)
    end)
    self:UnLock(lockName)
  end, self)
end

function UIN25VampireChallengeTaskGain:PlayLvAnim(level)
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "PlayLvAni"
    self:Lock(lockName)
    self.levelText:SetText(self._lastdata.talent_level)
    YIELD(TT, 2000)
    self._anim:Play("uieffanim_UIN25VampireChallengeTaskGain_level")
    self.levelText:SetText(level)
    self.uplevelGo:SetActive(true)
    self:UnLock(lockName)
  end, self)
end

function UIN25VampireChallengeTaskGain:PlayPointAnim(changeLv)
  local time = changeLv and 2000 or 1200
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "PlayPointAnim"
    self:Lock(lockName)
    YIELD(TT, time)
    self.arrGo:SetActive(true)
    YIELD(TT, 300)
    self.lastGo:SetActive(true)
    self:UnLock(lockName)
  end, self)
end

function UIN25VampireChallengeTaskGain:PlayBtnAnim()
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "PlayBtnAnim"
    self:Lock(lockName)
    YIELD(TT, 1600)
    self.btnGo:SetActive(true)
    self:UnLock(lockName)
  end, self)
end

function UIN25VampireChallengeTaskGain:PlaySliderAnim(data, cfg, prelevelCfg)
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "PlaySliderAnim"
    self:Lock(lockName)
    local changelv = false
    if data.talent_level ~= self._lastdata.talent_level then
      changelv = true
    end
    if changelv then
      self.slider.value = self._lastdata.cur_exp / prelevelCfg[1].Exp
      YIELD(TT, 1200)
      self.slider:DOValue(1, 1)
      YIELD(TT, 1100)
      self.slider.value = 0
      YIELD(TT, 100)
      self.slider:DOValue(data.cur_exp / cfg[1].Exp, 1)
    else
      self.slider.value = self._lastdata.cur_exp / cfg[1].Exp
      self.slider:DOValue(data.cur_exp / cfg[1].Exp, 1)
    end
    self:UnLock(lockName)
  end, self)
end
