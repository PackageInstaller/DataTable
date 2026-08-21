_class("UIDrawCardAnimController", UIController)
UIDrawCardAnimController = UIDrawCardAnimController

function UIDrawCardAnimController:OnShow(uiParams)
  self._curLayer = self:GetDepth() - 1
  for i = 0, self._curLayer do
    GameGlobal.UIStateManager().uiControllerManager:ShowLayer(i, false)
  end
  self.data = uiParams[1]
  self:InitWidget()
  self:InitConfig()
  Log.warn("开始抽卡动画，最高星等：", self.data:GetMaxStar())
  self._finder = UnityEngine.GameObject.Find("LOGICROOT"):GetComponent(typeof(UIView))
  self._opration = UIDrawCardAnimOperation:New(self._finder)
  self._operating = false
  self:InitSceneObjects()
  local audio_lights = {
    [ShakeType.SHAKE_ONCE] = CriAudioIDConst.Drawcard_light_one,
    [ShakeType.SHAKE_MULTIPLE] = CriAudioIDConst.Drawcard_light_more
  }
  local audio_light = audio_lights[self.data:GetShakeType()]
  self._opration:Init(self._camera, self.data:GetMaxStar(), function()
    self:SetBtnVisible(true)
    self._timeLinePlayer:Play(self._timeLine2)
    self._light_audio = AudioHelperController.PlayRequestedUISound(audio_light)
  end)
  self:SetBtnVisible(false)
  self:InitTimeLines()
  self._timeLinePlayer:Play(self._timeLine1)
  UIBgmHelper.PlayDrawcardBgm()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnLayerChanged)
end

function UIDrawCardAnimController:_OnLayerChanged()
  GameGlobal.UIStateManager().uiControllerManager:ShowAllLayers()
  self._curLayer = self:GetDepth() - 1
  for i = 0, self._curLayer do
    GameGlobal.UIStateManager().uiControllerManager:ShowLayer(i, false)
  end
end

function UIDrawCardAnimController:OnHide()
  local funcModule = self:GetModule(RoleModule).uiModule
  funcModule:LockAchievementFinishPanel(false)
  for i = 0, self._curLayer do
    GameGlobal.UIStateManager().uiControllerManager:ShowLayer(i, true)
  end
  self._opration:Dispose()
  if self._lightReqs and 0 < #self._lightReqs then
    for _, req in ipairs(self._lightReqs) do
      req:Dispose()
    end
  end
  if self._timeLinePlayer and self._timeLinePlayer:IsPlaying() then
    self._timeLinePlayer:Stop()
    self._timeLinePlayer = nil
  end
end

function UIDrawCardAnimController:OnUpdate(deltaTimeMS)
  self._opration:Update(deltaTimeMS)
  if self._operating then
    local x = self._handle.eulerAngles.x
    if 180 < x then
      x = x - 360
    end
    local percent = (self._handleStartRot - x) / self._handleAngle
    self._animState.enabled = true
    self._animState.normalizedTime = percent
    self._animState.weight = 1
    self._handleEftAnim:Sample()
    self._animState.enabled = false
  end
end

function UIDrawCardAnimController:InitWidget()
  self._skipBtn = self:GetGameObject("ButtonSkip")
  self._fader = self:GetUIComponent("Animation", "fader")
  self._faderImage = self:GetUIComponent("Image", "fader")
end

function UIDrawCardAnimController:InitConfig()
  self._handleAnimNames = {
    [3] = "eff_chouka_lagan_charge_1",
    [4] = "eff_chouka_lagan_charge_2",
    [5] = "eff_chouka_lagan_charge_3",
    [6] = "eff_chouka_lagan_charge_4"
  }
  self._handleFallDownAnim = {
    [3] = "eff_chouka_laganwan_finished_1",
    [4] = "eff_chouka_laganwan_finished_2",
    [5] = "eff_chouka_laganwan_finished_3",
    [6] = "eff_chouka_laganwan_finished_4"
  }
  self._lightCfg = {
    [3] = {
      prefab = "eff_chouka_blue.prefab",
      color = Color(0.155, 0.521, 1, 1),
      Y = 2.5,
      W = 20,
      audio = AudioHelperController.GetConfigName(CriAudioIDConst.DrawCard_lanse)
    },
    [4] = {
      prefab = "eff_chouka_purple.prefab",
      color = Color(0.5196, 0.2401, 0.7169, 1),
      Y = 2.5,
      W = 40,
      audio = AudioHelperController.GetConfigName(CriAudioIDConst.DrawCard_zise)
    },
    [5] = {
      prefab = "eff_chouka_gold.prefab",
      color = Color(1, 0.592, 0.231, 1),
      Y = 2.5,
      W = 50,
      audio = AudioHelperController.GetConfigName(CriAudioIDConst.DrawCard_zise)
    },
    [6] = {
      prefab = "eff_chouka_orange.prefab",
      color = Color(1, 0.252, 0.108, 1),
      Y = 2.5,
      W = 60,
      audio = AudioHelperController.GetConfigName(CriAudioIDConst.DrawCard_chengse)
    }
  }
  self._newLightCfg = {
    [3] = {
      prefab = "eff_chouka_blue_new.prefab",
      audio = AudioHelperController.GetConfigName(CriAudioIDConst.DrawCard_lanse)
    },
    [4] = {
      prefab = "eff_chouka_purple_new.prefab",
      audio = AudioHelperController.GetConfigName(CriAudioIDConst.DrawCard_zise)
    },
    [5] = {
      prefab = "eff_chouka_gold_new.prefab",
      audio = AudioHelperController.GetConfigName(CriAudioIDConst.DrawCard_zise)
    },
    [6] = {
      prefab = "eff_chouka_orange_new.prefab",
      audio = AudioHelperController.GetConfigName(CriAudioIDConst.DrawCard_chengse)
    }
  }
end

function UIDrawCardAnimController:InitSceneObjects()
  self._animation = self:GetSceneGameObject("anim"):GetComponent(typeof(UnityEngine.Animation))
  self._animation.gameObject:SetActive(true)
  self._camera = self:GetSceneGameObject("Camera"):GetComponent(typeof(UnityEngine.Camera))
  self._chouKaCam = self:GetSceneGameObject("ChoukaCamera")
  self._chouKaCam:SetActive(true)
  self._farSceneGO = self:GetSceneGameObject("choukaPrefab")
  self._farSceneGO:SetActive(false)
  self._handle = self:GetSceneGameObject("Ckt_Yg").transform
  self._handle.gameObject:SetActive(true)
  self._handleStartRot = Cfg.cfg_drawcard_value[2].Value
  local handleFinishRot = Cfg.cfg_drawcard_value[4].Value
  self._handleAngle = self._handleStartRot - handleFinishRot
  self._handleEftAnim = self._finder:GetUIComponent("Animation", "Chouka_lagan_charge_prefab")
  Log.error("self._finder", self._finder)
  Log.error("self._handleEftAnim", self._handleEftAnim)
  Log.error("self._handleEftAnim", self._handleAnimNames[self.data:GetMaxStar()])
  Log.error("GetClipCount", self._handleEftAnim:GetClipCount())
  self._animState = self._handleEftAnim:get_Item(self._handleAnimNames[self.data:GetMaxStar()])
  self._animState.enabled = true
  self._animState.weight = 1
  self._animState.normalizedTime = 0
  self._handleEftAnim:Sample()
  self._animState.enabled = false
  self._fallDownAnim = self._finder:GetUIComponent("Animation", "chouka_lagan_prefab")
  self._fallDownAnim.gameObject:SetActive(false)
  self._powerEft = self:GetSceneGameObject("chouka_wunei_prefab")
  self._powerEft:SetActive(false)
  if self.data:GetShakeType() == ShakeType.SHAKE_MULTIPLE then
    self:InitMultipleLight()
  elseif self.data:GetShakeType() == ShakeType.SHAKE_ONCE then
    self:InitSingleLight()
  end
end

function UIDrawCardAnimController:InitTimeLines()
  self._timeLinePlayer = EZTL_Player:New()
  self._timeLine1 = EZTL_Sequence:New({
    EZTL_Callback:New(function()
      self._animation:Play("drawcard1")
    end, "回调，摄像机动画1，拉近拉杆"),
    EZTL_PlayAudioOnce:New(AudioHelperController.GetConfigName(CriAudioIDConst.DrawCard_tuijingtou), "运镜音频"),
    EZTL_Callback:New(function()
      GameGlobal.UAReportForceGuideEvent("UIDrawCardEvent", {
        "open_camera"
      }, true)
      self._camera.gameObject:SetActive(true)
      self._farSceneGO:SetActive(false)
    end, "打开摄像机"),
    EZTL_Wait:New(2000, "等相机动画播完"),
    EZTL_Callback:New(function()
      self._opration:SetEnable(true)
      self._operating = true
    end, "回调，玩家可操作")
  }, "抽卡时间线1，串行")
  self._timeLine2 = EZTL_Sequence:New(self:_InitTimeline2(), "抽卡时间线2，串行")
end

function UIDrawCardAnimController:InitSingleLight()
  local renderers = self._farSceneGO.transform:Find("global_eff/stage").gameObject:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))
  local mats = {}
  for i = 0, renderers.Length - 1 do
    mats[#mats + 1] = renderers[i].sharedMaterial
  end
  for i = 1, 10 do
    local seq = string.format("%02d", i)
    for _, mat in ipairs(mats) do
      mat:SetColor("_PointLightColor" .. seq, Color(0, 0, 0, 0))
    end
  end
end

function UIDrawCardAnimController:InitMultipleLight()
end

function UIDrawCardAnimController:_InitTimeline2()
  local _handleFinishRot = Cfg.cfg_drawcard_value[4].Value
  local _handleFallDuaration = Cfg.cfg_drawcard_value[5].Value
  local timeline = {
    EZTL_DOTweenRotate:New(self._handle, Vector3(_handleFinishRot, 0, 0), _handleFallDuaration, DG.Tweening.Ease.InCubic, "拉杆下落"),
    EZTL_Callback:New(function()
      self._operating = false
      AudioHelperController.PlayRequestedUISound(CriAudioIDConst.DrawCard_preshilian)
      AudioHelperController.PlayRequestedUISound(CriAudioIDConst.DrawCard_daodi)
      self._fallDownAnim.gameObject:SetActive(true)
      self._fallDownAnim:Play(self._handleFallDownAnim[self.data:GetMaxStar()])
      self._animState.enabled = true
      self._animState.normalizedTime = 1
      self._animState.weight = 1
      self._handleEftAnim:Sample()
      self._animState.enabled = false
    end, "拉杆下落，运动完成"),
    EZTL_Parallel:New({
      EZTL_PlayAnimation:New(self._animation, "drawcard2", "摄像机动画2，远离拉杆"),
      EZTL_Sequence:New({
        EZTL_Wait:New(1600, "光球音效前等待"),
        EZTL_Callback:New(function()
          GameGlobal.UAReportForceGuideEvent("UIDrawCardEvent", {"guangqiu"}, true)
        end, "上报事件")
      }),
      EZTL_Wait:New(2750, "切视角前等3.7秒")
    }, EZTL_EndTag.SomeOne, 3, "并行时间线，切换视角并等待"),
    EZTL_Callback:New(function()
      self._camera.gameObject:SetActive(false)
      self._farSceneGO:SetActive(true)
    end, "切换摄像机")
  }
  timeline[#timeline + 1] = EZTL_Wait:New(200, "大光柱音效延迟")
  if self.data:GetShakeType() == ShakeType.SHAKE_MULTIPLE then
    timeline[#timeline + 1] = EZTL_Callback:New(function()
      self._lightReqs = {}
      local cards = self.data:GetCards()
      local posParent = self._finder:GetUIComponent("Transform", "ChoukaPoint")
      for i = 1, #cards do
        local card = cards[i]
        local star = Cfg.cfg_pet[card.assetid].Star
        local qCfg = self._newLightCfg[star]
        local req = ResourceManager:GetInstance():SyncLoadAsset(qCfg.prefab, LoadType.GameObject)
        local light = req.Obj.transform
        local parent = posParent:GetChild(i - 1)
        light:SetParent(parent)
        light.localPosition = Vector3.zero
        light.localRotation = Quaternion.identity
        light.localScale = Vector3.one
        light.gameObject:SetActive(true)
        table.insert(self._lightReqs, req)
      end
    end, "同时展示10个光柱")
    timeline[#timeline + 1] = EZTL_Wait:New(370, "显示光柱后等待播音频")
    local max = self.data:GetMaxStar()
    timeline[#timeline + 1] = EZTL_Wait:New(1500, "最后等1.5秒")
    timeline[#timeline + 1] = EZTL_Callback:New(function()
      GameGlobal.UAReportForceGuideEvent("UIDrawCardEvent", {"qianzhi"}, true)
    end, "上报事件")
    timeline[#timeline + 1] = EZTL_PlayAnimation:New(self._fader, "UIDrawCardAnim_black", "黑屏转场")
  elseif self.data:GetShakeType() == ShakeType.SHAKE_ONCE then
    timeline[#timeline + 1] = EZTL_Wait:New(970, "单抽等待")
    timeline[#timeline + 1] = EZTL_Callback:New(function()
      GameGlobal.UAReportForceGuideEvent("UIDrawCardEvent", {"qianzhi"}, true)
    end, "上报事件")
    timeline[#timeline + 1] = EZTL_PlayAnimation:New(self._fader, "UIDrawCardAnim_white", "白屏转场")
  end
  timeline[#timeline + 1] = EZTL_Callback:New(function()
    self:AnimFinish(false)
  end, "动画结束，跳转界面")
  return timeline
end

function UIDrawCardAnimController:AnimFinish(skip)
  AudioHelperController.StopUISound(self._light_audio)
  local pets
  self:SetBtnVisible(false)
  self._faderImage.color = Color.black
  if skip then
    self._camera.gameObject:SetActive(false)
    pets = self.data:GetUnskipCards()
  else
    pets = self.data:GetCards()
  end
  if #pets == 0 then
    if self.data:GetShakeType() == ShakeType.SHAKE_MULTIPLE then
      self:ShowDialog("UIDrawCardMultipleShowController", self.data)
    else
      self:ShowDialog("UIPetObtain", self.data:GetCards(), function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshRecuitUIView)
        self:Manager():CloseAllDialogOverLayerWithName("UIRecruit", {
          "UICriVideoController"
        })
      end, true)
    end
  else
    local afterShow
    if self.data:GetShakeType() == ShakeType.SHAKE_MULTIPLE then
      function afterShow()
        self:ShowDialog("UIDrawCardMultipleShowController", self.data)
        
        self:Manager():CloseDialog("UIPetObtain")
      end
    else
      function afterShow()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshRecuitUIView)
        
        self:Manager():CloseAllDialogOverLayerWithName("UIRecruit", {
          "UICriVideoController"
        })
      end
    end
    self:ShowDialog("UIPetObtain", pets, afterShow)
    self._chouKaCam:SetActive(false)
  end
end

function UIDrawCardAnimController:ButtonSkipOnClick(go)
  self._timeLinePlayer:Stop()
  self:AnimFinish(true)
end

function UIDrawCardAnimController:SetBtnVisible(_show)
  self._skipBtn:SetActive(_show)
end

function UIDrawCardAnimController:GetSceneGameObject(name)
  return self._finder:GetGameObject(name)
end
