_class("UIHauteCoutureDrawV2ReviewController", UIController)
UIHauteCoutureDrawV2ReviewController = UIHauteCoutureDrawV2ReviewController

function UIHauteCoutureDrawV2ReviewController:Constructor()
  self._timer = 0
  self.hcType = HauteCoutureType.HC_None
  self.bg = nil
  self.main = nil
  self.CtxData = nil
end

function UIHauteCoutureDrawV2ReviewController:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self.CtxData = campaignModule:GetCurHauteCouture_Review()
  if not self.CtxData then
    campaignModule:LoadCampaignInfoListTask(TT)
    campaignModule:RefreshCurHauteCoutureInfo()
    self.CtxData = campaignModule:GetCurHauteCouture()
  end
  if not self.CtxData then
    Log.fatal("没有开启的活动")
    res:SetSucc(false)
    return
  end
  self._campaign = self.CtxData:ReqDetailInfo(TT, res)
  if not self._campaign then
    res:SetSucc(false)
    return
  end
  self._buyComponet = self._campaign:GetLocalProcess()._buyGiftComponent
  self._buyComponetInfo = self._campaign:GetLocalProcess()._buyGiftComponentInfo
  self._component = self._campaign:GetLocalProcess()._seniorSkinComponent
  self._componentInfo = self._campaign:GetLocalProcess()._seniorSkinComponentInfo
  local time = self._componentInfo.m_close_time
  local now = math.floor(self:GetModule(SvrTimeModule):GetServerTime() / 1000)
  if time < now then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    res:SetSucc(false)
    return
  end
  if self._campaign._id == 1034 then
    self.hcType = HauteCoutureType.HC_GL
    HauteCouture:GetInstance().CostCoinId = 3000266
  elseif self._campaign._id == 1038 then
    self.hcType = HauteCoutureType.HC_KR
    HauteCouture:GetInstance().CostCoinId = 3000275
  else
    self.hcType = self.CtxData:HC_Type()
    HauteCouture:GetInstance().CostCoinId = self.CtxData:CostItemID()
  end
  HauteCouture:GetInstance().HcType = self.hcType
  self._closed = false
  self._componentId = self._component:GetComponentCfgId()
  self._cfg = self.CtxData:GetSeniorSkinCfg()
  self._prizes = self.CtxData:GetPrizeCfgs()
  self._drawCost = Cfg.cfg_component_senior_skin_cost({
    ComponentID = self._componentId
  })
  if not self._drawCost then
    Log.exception("[HauteCouture] cfg_component_senior_skin_cost中缺少配置:", self._componentId)
  end
  self._specialIdx = self._cfg.SpecialIdx
  self._allPrizes = {}
  table.sort(self._prizes, function(a, b)
    return a.RewardSortOrder > b.RewardSortOrder
  end)
end

function UIHauteCoutureDrawV2ReviewController:OnShow(uiParams)
  local bg = self:GetUIComponent("UISelectObjectPath", "bgRoot")
  local main = self:GetUIComponent("UISelectObjectPath", "uiRoot")
  if self.hcType == HauteCoutureType.HC_GL then
    bg.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawBgGL.prefab")
    main.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawMainGL.prefab")
    self.bg = bg:SpawnObject("UIHauteCoutureDrawBgGL")
    self.main = main:SpawnObject("UIHauteCoutureDrawMainGL")
  elseif self.hcType == HauteCoutureType.HC_KR then
    bg.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawBgKR.prefab")
    main.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawMainKR.prefab")
    self.bg = bg:SpawnObject("UIHauteCoutureDrawBgKR")
    self.main = main:SpawnObject("UIHauteCoutureDrawMainKR")
  else
    local bgPrefab, bgClass = self.CtxData:GetMainUIBgInfo()
    local mainPrefab, mainClass = self.CtxData:GetMainUIInfo()
    if string.isnullorempty(bgPrefab) then
      Log.exception("[HauteCouture] 高级时装背景图Prefab为空:", self.CtxData:CampaignID())
    end
    if not bgClass then
      Log.exception("[HauteCouture] 高级时装背景类为空:", self.CtxData:CampaignID())
    end
    if string.isnullorempty(mainPrefab) then
      Log.exception("[HauteCouture] 高级时装主界面Prefab为空:", self.CtxData:CampaignID())
    end
    if not mainClass then
      Log.exception("[HauteCouture] 高级时装主界面类型为空:", self.CtxData:CampaignID())
    end
    bg.dynamicInfoOfEngine:SetObjectName(bgPrefab)
    main.dynamicInfoOfEngine:SetObjectName(mainPrefab)
    self.bg = bg:SpawnObject(bgClass._className)
    self.main = main:SpawnObject(mainClass._className)
  end
  if not self.bg then
    return
  end
  self.main:CheckEndTime()
  local bgm = self._cfg.bgm
  if bgm and 0 < bgm then
    self._oldBgm = AudioHelperController.GetCurrentBgm()
    AudioHelperController.PlayBGMById(bgm, AudioConstValue.BGMCrossFadeTime)
  end
end

function UIHauteCoutureDrawV2ReviewController:OnUpdate(dtMS)
  if not self._closed then
    self._timer = self._timer + dtMS
    if self._timer > 1000 then
      self._timer = 0
      self._closed = self.main:CheckEndTime()
    end
  end
end

function UIHauteCoutureDrawV2ReviewController:OnHide()
  if self._oldBgm then
    AudioHelperController.PlayBGMById(self._oldBgm, AudioConstValue.BGMCrossFadeTime)
  end
end
