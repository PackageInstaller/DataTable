_class("PetObtainAnimSimple", PetObtainAnimBase)
PetObtainAnimSimple = PetObtainAnimSimple

function PetObtainAnimSimple:Constructor(pet, anim, starParent, uiStarParent, matAnim)
  self._pet = pet
  self._petID = self._pet:PetID()
  self._anim = anim
  self._animName = "uieff_uipetobtain_eff"
  self._effStars = starParent
  self._uiStars = uiStarParent
  self._matAnim = matAnim
  self._petAudioModule = GameGlobal.GetModule(PetAudioModule)
  local cfgv = Cfg.cfg_pet[self._petID]
  if cfgv == nil then
    Log.exception("找不到星灵：", self._petID)
  end
  self._star = cfgv.Star
  self._starTweenTimeTable = {
    [1] = {
      [1] = 0
    },
    [2] = {
      [1] = 0,
      [2] = 150
    },
    [3] = {
      [1] = 0,
      [2] = 150,
      [3] = 375
    },
    [4] = {
      [1] = 0,
      [2] = 150,
      [3] = 130,
      [4] = 375
    },
    [5] = {
      [1] = 0,
      [2] = 120,
      [3] = 95,
      [4] = 90,
      [5] = 350
    },
    [6] = {
      [1] = 0,
      [2] = 100,
      [3] = 85,
      [4] = 75,
      [5] = 70,
      [6] = 325
    }
  }
  self._tweenType2tweenName = {
    [1] = "uieff_uipetobtain_stars_left",
    [2] = "uieff_uipetobtain_stars_mid",
    [3] = "uieff_uipetobtain_stars_right",
    [4] = "uieff_uipetobtain_stars_final"
  }
  self._starTweenNameTable = {
    [1] = {
      [1] = self._tweenType2tweenName[2]
    },
    [2] = {
      [1] = self._tweenType2tweenName[1],
      [2] = self._tweenType2tweenName[3]
    },
    [3] = {
      [1] = self._tweenType2tweenName[1],
      [2] = self._tweenType2tweenName[2],
      [3] = self._tweenType2tweenName[3]
    },
    [4] = {
      [1] = self._tweenType2tweenName[1],
      [2] = self._tweenType2tweenName[2],
      [3] = self._tweenType2tweenName[3],
      [4] = self._tweenType2tweenName[4]
    },
    [5] = {
      [1] = self._tweenType2tweenName[1],
      [2] = self._tweenType2tweenName[2],
      [3] = self._tweenType2tweenName[2],
      [4] = self._tweenType2tweenName[3],
      [5] = self._tweenType2tweenName[4]
    },
    [6] = {
      [1] = self._tweenType2tweenName[1],
      [2] = self._tweenType2tweenName[1],
      [3] = self._tweenType2tweenName[2],
      [4] = self._tweenType2tweenName[2],
      [5] = self._tweenType2tweenName[3],
      [6] = self._tweenType2tweenName[4]
    }
  }
  self._audios = {
    [1] = CriAudioIDConst.Drawcard_pet_obtain_3,
    [2] = CriAudioIDConst.Drawcard_pet_obtain_3,
    [3] = CriAudioIDConst.Drawcard_pet_obtain_3,
    [4] = CriAudioIDConst.Drawcard_pet_obtain_4
  }
end

function PetObtainAnimSimple:Start()
  for i = 1, self._effStars.childCount do
    local tr = self._effStars:GetChild(i - 1)
    tr.gameObject:SetActive(false)
  end
  local state = self._anim:get_Item(self._animName)
  state.normalizedTime = 0
  self._anim:Play()
  self._tl = self:InitTimeLine()
  self._tl:Start()
  self._audio = AudioHelperController.RequestAndPlayUIVoiceAutoRelease(self._audios[self._star])
  self._running = true
end

function PetObtainAnimSimple:Update(dtMS)
  if not self._running then
    return
  end
  self._tl:Update(dtMS)
  if self._tl:Over() then
    self._running = false
  end
end

function PetObtainAnimSimple:IsOver()
  return not self._running
end

function PetObtainAnimSimple:Dispose()
  if self._running then
    self._running = false
    self._tl:Stop()
    self._anim:Stop()
  end
  self._petAudioModule:StopAll()
  if self._audio then
    AudioHelperController.StopUISound(self._audio)
  end
end

function PetObtainAnimSimple:InitTimeLine()
  local timeline1 = EZTL_Sequence:New({
    EZTL_Wait:New(2100, "等2.1秒"),
    EZTL_Callback:New(function()
      self._petAudioModule:PlayPetAudio("Obtain", self._petID)
    end, "播星灵语音")
  }, "时间线1，延迟播星灵语音")
  local tls = {
    EZTL_Wait:New(1233, "等1.233秒"),
    EZTL_Callback:New(function()
      self._effStars.gameObject:SetActive(true)
    end, "打开星星动效父节点")
  }
  for i = 1, self._effStars.childCount do
    local tr = self._effStars:GetChild(i - 1)
    local go = tr.gameObject
    tr:GetChild(0):GetChild(0).gameObject:GetComponent("CanvasGroup").alpha = 0
    if i <= self._star then
      go:SetActive(true)
      local yieldTime = self._starTweenTimeTable[self._star][i]
      tls[#tls + 1] = EZTL_Wait:New(yieldTime, "星星动效播完等" .. yieldTime .. "毫秒")
      tls[#tls + 1] = EZTL_Callback:New(function()
        tr:GetChild(0).gameObject:GetComponent("Animation"):Play(self._starTweenNameTable[self._star][i])
      end, "星星动效" .. i)
    else
      go:SetActive(false)
      tls[#tls + 1] = EZTL_Callback:New(function()
      end, "超过星等，关闭动效" .. i)
    end
  end
  local timeline2 = EZTL_Sequence:New(tls, "动画2，串行")
  local starTls = {}
  starTls[#starTls + 1] = EZTL_Wait:New(3200, "先等3.2s")
  for i = 1, self._star do
    local star = self._uiStars:GetChild(i - 1).gameObject
    star:SetActive(false)
    starTls[#starTls + 1] = EZTL_Callback:New(function()
      star:SetActive(true)
    end, "显示第" .. i .. "个星星")
    starTls[#starTls + 1] = EZTL_Wait:New(33, "等33ms")
  end
  self._matAnim:SetActive(false)
  if not self._pet:IsNew() then
    starTls[#starTls + 1] = EZTL_Callback:New(function()
      self._matAnim:SetActive(true)
    end, "播放重复获得材料动画")
  end
  local timeline3 = EZTL_Sequence:New(starTls, "星星依次显示")
  local waitTime = EZTL_Wait:New(4100, "等4秒")
  return EZTL_Parallel:New({
    timeline1,
    timeline2,
    timeline3,
    waitTime
  }, EZTL_EndTag.All, nil, "获取星灵总时间线，并行")
end
