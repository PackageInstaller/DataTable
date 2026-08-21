_class("UISimpleHauteCoutureMainController", UIController)
UISimpleHauteCoutureMainController = UISimpleHauteCoutureMainController

function UISimpleHauteCoutureMainController:Constructor()
  self.isHomeGameServer = false
end

function UISimpleHauteCoutureMainController:LoadDataOnEnter(TT, res, uiParams)
  GameGlobal.GetModule(PayModule):RequestGetBalanceNormal()
  self._campaign = UIActivityCampaign:New()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_PET_SKIN)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  if not self._campaign then
    res:SetSucc(false)
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._randomLotteryComponent = self._campaign:GetComponent(ECampaignPetSkinComponentID.RANDOMLOTTERY)
  self._randomLotteryCompInfo = self._campaign:GetComponentInfo(ECampaignPetSkinComponentID.RANDOMLOTTERY)
  self._cfgMap = self._randomLotteryComponent:GetFirstCfg()
  self._cfgMain = self._randomLotteryComponent:GetCfgMain()
  self._conversionID = self._cfgMain.ScoreID
end

function UISimpleHauteCoutureMainController:OnShow(uiParams)
  self.atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self:_GetComponents()
  self:_Init()
  self:_LoadVideo()
  self:ItemCountChanged()
  self:AddListener()
  self._oldBgm = AudioHelperController.GetCurrentBgm()
  AudioHelperController.PlayBGMById(tonumber(self._cfgMain.BGM), AudioConstValue.BGMCrossFadeTime)
end

function UISimpleHauteCoutureMainController:AddListener()
  self._itemChangeCallback = GameHelper:GetInstance():CreateCallback(self.ItemCountChanged, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.ItemCountChanged, self._itemChangeCallback)
  self._activityShopBuySuccess = GameHelper:GetInstance():CreateCallback(self._CheckSkinGet, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.ActivityShopBuySuccess, self._activityShopBuySuccess)
end

function UISimpleHauteCoutureMainController:DetachListener()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.ItemCountChanged, self._itemChangeCallback)
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.ActivityShopBuySuccess, self._activityShopBuySuccess)
end

function UISimpleHauteCoutureMainController:OnHide()
  if self._countTimer then
    GameGlobal.Timer():CancelEvent(self._countTimer)
    self._countTimer = nil
  end
  if self._rt then
    self._rt:Release()
    self._rt = nil
  end
  self:DetachListener()
  AudioHelperController.PlayBGMById(self._oldBgm, AudioConstValue.BGMCrossFadeTime)
end

function UISimpleHauteCoutureMainController:_GetComponents()
  local topBarPool = self:GetUIComponent("UISelectObjectPath", "topbtn")
  local topBtns = topBarPool:SpawnObject("UINewCommonTopButton")
  topBtns:SetData(function()
    self:Close()
  end)
  self._videoPlayer = self:GetUIComponent("VideoPlayer", "VideoPlayer")
  self._simpleNum = self:GetUIComponent("UILocalizationText", "simpleNum")
  self._multipleNum = self:GetUIComponent("UILocalizationText", "multipleNum")
  self._topContent = self:GetUIComponent("UISelectObjectPath", "topContent")
  self._topTips = self:GetUIComponent("UISelectObjectPath", "toptips")
  self._topTipsInfo = self._topTips:SpawnObject("UITopTipsContext")
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._skinName = self:GetUIComponent("UILocalizationText", "skinName")
  self._drawIcon1 = self:GetUIComponent("Image", "drawIcon1")
  self._drawIcon2 = self:GetUIComponent("Image", "drawIcon2")
  self._mainBg = self:GetUIComponent("RawImageLoader", "mainBg")
  self._enterAniPool = self:GetUIComponent("UISelectObjectPath", "EnterAnimation")
  self._enterAniGo = self:GetGameObject("EnterAnimation")
  self._enterAniGo:SetActive(false)
  self._anim = self:GetUIComponent("Animation", "anim")
  self._videoPlayerObj = self:GetGameObject("VideoPlayer")
  self._layersGo = {}
  for i = 1, 7 do
    local subGo = self:GetGameObject("layer" .. i)
    subGo:SetActive(false)
    table.insert(self._layersGo, subGo)
  end
end

function UISimpleHauteCoutureMainController:_Init()
  local topMenu = self._topContent:SpawnObject("UISimpleHauteCoutureTopMenu")
  topMenu:SetData(self._topTipsInfo, self._cfgMap.CostItemID, RoleAssetID.RoleAssetDiamond, self._cfgMain.ScoreID, function()
    self:ShowDialog("UISimpleHauteCouturePurchaseController", self._campaign, self.isHomeGameServer)
  end)
  local iconCfg = Cfg.cfg_top_tips[self._cfgMap.CostItemID]
  if iconCfg then
    self._drawIcon1.sprite = self.atlas:GetSprite(iconCfg.Icon)
    self._drawIcon2.sprite = self.atlas:GetSprite(iconCfg.Icon)
  end
  self._mainBg:LoadImage(self._cfgMain.MainBg)
  self._titleSpawner = UIWidgetHelper.SpawnObject(self, "titleSpawner", "UISimpleHauteCoutureDrawTitle", self._cfgMain.TitlePrefab .. ".prefab")
  self._skinIconSpawner = UIWidgetHelper.SpawnObject(self, "skinIconSpawner", "UISimpleHauteCoutureDrawSkinIcon", self._cfgMain.SkinIconPrefab .. ".prefab")
  self._skinIconSpawner:SetData(self._cfgMain.SkinID, function()
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, self._cfgMain.SkinID)
  end)
  self:CheckFirstVedioPlay()
  self:CountDown()
  self._countTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:CountDown()
  end)
end

function UISimpleHauteCoutureMainController:_LoadVideo()
  local url = ResourceManager:GetInstance():GetAssetPath(self._cfgMain.MiniVideoName .. ".mp4", LoadType.VideoClip)
  Log.debug("[guide movie] move url ", url)
  self._rawImage = self:GetUIComponent("RawImage", "VideoPlayer")
  self._rt = UnityEngine.RenderTexture:New(339, 190, 16)
  self._rawImage.texture = self._rt
  self._videoPlayer.targetTexture = self._rt
  self._videoPlayer = self:GetUIComponent("VideoPlayer", "VideoPlayer")
  self._videoPlayer.gameObject:SetActive(true)
  self._videoPlayer.url = url
  self._videoPlayer.targetCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  self._videoPlayer:Play()
end

function UISimpleHauteCoutureMainController:_LoadSpine()
  self._dcgHandle = DynamicCG.SyncLoad(self._cfgMain.SpineName, self._spine)
  self:PlaySpineAnim(self._cfgMain.SkinID)
  UICG.SetTransform(self._spine.transform, "UIMainLobbyController", self._cfgMain.SpineName)
end

function UISimpleHauteCoutureMainController:PlaySpineAnim(skinid, animName)
  if self._playSpineAnim then
    return
  end
  local cfg_pet_skin = Cfg.cfg_pet_skin[skinid]
  if not cfg_pet_skin then
    Log.error("###[UIMainLobbyFinal] cfg_pet_skin is nil ! id --> ", skinid)
    return
  end
  local spineAnims = cfg_pet_skin.MainLobbySpineAnim
  if not spineAnims then
    return
  end
  local animList = {}
  for i = 1, #spineAnims do
    local spineAnim = spineAnims[i]
    table.insert(animList, spineAnim)
  end
  if #animList == 0 then
    Log.error("###[UIMainLobbyFinal] animList is nil ! skinid --> ", skinid)
    return
  end
  local randomVal = math.random(#animList)
  local anim = animList[randomVal]
  local animationName = anim
  if not self._dcgHandle then
    Log.debug("###[UIMainLobbyFinal] self._dcgHandle is nil --> ", self._dynamicSpineSettings)
    return
  end
  local entry = self._dcgHandle:SetAnimationWithTrackEntryReturn(0, animationName, false)
  self._dcgHandle:SetAnimMixTime(0)
  self._dcgHandle:Update(0)
  if self._dcgHandle:GetCurDynamicCGType() == DynamicCGType.Spine or self._dcgHandle:GetCurDynamicCGType() == DynamicCGType.None then
    self:PlayClickAnimBackIdleBySpine(entry, animName)
  elseif self._dcgHandle:GetCurDynamicCGType() == DynamicCGType.Live2D then
    self:PlayClickAnimBackIdleByLive2d(entry, animName)
  end
end

function UISimpleHauteCoutureMainController:PlayClickAnimBackIdleBySpine(entry, animName)
  if not entry then
    return
  end
  local anim = entry.Animation
  local duration = anim.Duration
  local yieldTime = math.floor(duration * 1000)
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
    self._playSpineAnim = false
  end
  self._playSpineAnim = true
  local animationName = animName or "idle"
  self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
    if not tolua.isnull(self._spine) then
      self._playSpineAnim = false
      self._dcgHandle:SetAnimation(0, animationName, true)
      self._dcgHandle:SetAnimMixTime(0)
      self._dcgHandle:Update(0)
    end
  end)
  Log.debug("###[UIMainLobbyFinal] spine 动画名字[", animationName, "] 动画时长[", duration, "]")
end

function UISimpleHauteCoutureMainController:PlayClickAnimBackIdleByLive2d(anim, animName)
  if anim then
    local duration = anim.length
    local yieldTime = math.floor(duration * 1000)
    if self._spineEvent then
      GameGlobal.Timer():CancelEvent(self._spineEvent)
      self._spineEvent = nil
      self._playSpineAnim = false
    end
    self._playSpineAnim = true
    self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._playSpineAnim = false
      local animationName = animName or "idle"
      self._dcgHandle:SetAnimationWithTrackEntryReturn(0, animationName, true)
    end)
  end
end

function UISimpleHauteCoutureMainController:Close()
  self:StartTask(function(TT)
    self:Lock("UISimpleHauteCoutureMainController:Close")
    self._anim:Play("uianim_UISimpleHauteCoutureMainController_out")
    YIELD(TT, 334)
    self:UnLock("UISimpleHauteCoutureMainController:Close")
    self:CloseDialog()
  end)
end

function UISimpleHauteCoutureMainController:CountDown()
  if not tolua.isnull(self._anim) then
    local endTime = self._randomLotteryCompInfo.m_close_time
    local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
    local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    local timeTxt = StringTable.Get("str_junior_skin_draw_common_main_endtime", self:GetTimeString(endTime - curTime))
    self._titleSpawner:SetTimeText(timeTxt)
    if endTime - curTime <= 0 then
      self:SwitchState(UIStateType.UIMain)
      ToastManager.ShowToast(StringTable.Get("str_junior_skin_draw_common_main_end"))
      return
    end
  end
end

function UISimpleHauteCoutureMainController:GetTimeString(seconds, dayStr, hourStr, minusStr, lessOneMinusStr)
  local colorTxt = self._cfgMain.NumberColor or "#ffda78"
  if seconds < 0 then
    seconds = 0
  end
  dayStr = dayStr or "str_junior_skin_draw_time_day"
  hourStr = hourStr or "str_junior_skin_draw_time_hour"
  minusStr = minusStr or "str_junior_skin_draw_time_min"
  lessOneMinusStr = lessOneMinusStr or "str_junior_skin_draw_time_less_one_minus"
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get(dayStr, "<color=" .. colorTxt .. ">" .. day .. "</color>")
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get(hourStr, "<color=" .. colorTxt .. ">" .. hour .. "</color>")
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get(hourStr, "<color=" .. colorTxt .. ">" .. hour .. "</color>")
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get(minusStr, "<color=" .. colorTxt .. ">" .. minus .. "</color>")
    end
  else
    timeStr = "<color=" .. colorTxt .. ">" .. StringTable.Get(lessOneMinusStr) .. "</color>"
  end
  return timeStr
end

function UISimpleHauteCoutureMainController:ItemCountChanged()
  local itemModule = self:GetModule(ItemModule)
  local itemNum = itemModule:GetItemCount(self._cfgMap.CostItemID)
  if 10 <= itemNum then
    self._simpleNum.color = Color(1, 1, 1)
    self._multipleNum.color = Color(1, 1, 1)
  elseif 1 <= itemNum then
    self._simpleNum.color = Color(1, 1, 1)
    self._multipleNum.color = Color(0.8980392156862745, 0.21176470588235294, 0)
  else
    self._simpleNum.color = Color(0.8980392156862745, 0.21176470588235294, 0)
    self._multipleNum.color = Color(0.8980392156862745, 0.21176470588235294, 0)
  end
  self:_CheckSkinGet()
end

function UISimpleHauteCoutureMainController:_CheckSkinGet()
  local petModule = self:GetModule(PetModule)
  local hasSkin = petModule:HaveSkin(self._cfgMain.SkinID)
  self._skinIconSpawner:SetSkinGet(hasSkin)
  return hasSkin
end

function UISimpleHauteCoutureMainController:IntroBtnOnClick()
  self:ShowDialog("UIIntroLoader", self._cfgMain.Intro, MaskType.MT_BlurMask)
end

function UISimpleHauteCoutureMainController:AwardShowBtnOnClick()
  self:ShowDialog("UISimpleHauteCoutureProbability", self._campaign)
end

function UISimpleHauteCoutureMainController:ShopBtnOnClick()
  self:ShowDialog("UISimpleHauteCoutureShop", self._campaign)
end

function UISimpleHauteCoutureMainController:SingleBtnOnClick()
  self:_DrawCard(SimpleHauteCoutureDrawType.Single)
end

function UISimpleHauteCoutureMainController:MultipleBtnOnClick()
  self:_DrawCard(SimpleHauteCoutureDrawType.Multiple)
end

function UISimpleHauteCoutureMainController:_DrawCard(type)
  local itemModule = self:GetModule(ItemModule)
  local itemCfg = Cfg.cfg_item[self._cfgMap.CostItemID]
  local itemNum = itemModule:GetItemCount(self._cfgMap.CostItemID)
  local costNum = self._cfgMap.OneCostCount
  local title = ""
  local costName = StringTable.Get(itemCfg.Name)
  local str = self.isHomeGameServer and "str_junior_skin_draw_common_main_draw_tip1" or "str_junior_skin_draw_common_main_draw_tip2"
  if type == SimpleHauteCoutureDrawType.Multiple then
    costNum = costNum * 10
  end
  title = self.isHomeGameServer and StringTable.Get(str, costNum, costName, costNum, costNum) or StringTable.Get(str, costNum, costName, costNum)
  if itemNum >= costNum then
    self:ShowDialog("UISimpleHauteCoutureConfirm", self._cfgMap.CostItemID, title, costNum, function()
      local hasSkin = self:_CheckSkinGet()
      self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        local isSingle = type == SimpleHauteCoutureDrawType.Single
        local data = self._randomLotteryComponent:HandleReceiveRandomLotteryCost(TT, res, self._cfgMap.ID, isSingle)
        if res:GetSucc() then
          self:ShowDialog("UISimpleHauteCoutureDrawResController", type, data, self._campaign, self.isHomeGameServer, hasSkin)
        else
          Log.fatal("抽卡失败：", res:GetResult())
        end
      end)
    end)
  else
    self:ShowDialog("UISimpleHauteCouturePurchaseController", self._campaign, self.isHomeGameServer)
  end
end

function UISimpleHauteCoutureMainController:FgOnClick(go)
  self:ShowDialog("UISimpleHauteCoutureVideoController", self._cfgMain.MiniVideoName, self._cfgMain.VideoBGM)
end

function UISimpleHauteCoutureMainController:FullBtnOnClick(go)
  self:PlaySpineAnim(self._cfgMain.SkinID)
end

function UISimpleHauteCoutureMainController:CheckFirstVedioPlay()
  self:StartTask(function(TT)
    if self._campaign and self._campaign:CheckCampaignNew() then
      self._campaign:ClearCampaignNew(TT)
      self._enterAniGo:SetActive(true)
      self:Lock("UISimpleHauteCoutureMainController:CheckFirstVedioPlay")
      local enter = self._enterAniPool:SpawnObject("UISimpleHauteCoutureDrawEnterAni")
      enter:SetData(self._cfgMain)
      YIELD(TT, enter:GetClipLength() * 1500)
      self._enterAniGo:SetActive(false)
      local animLen = self:CheckPlayDiyAnim(TT)
      if animLen and animLen ~= -1 then
        YIELD(TT, 1900)
      end
      self:_LoadSpine()
      self:PlayInAnim(TT)
      YIELD(TT, 100)
      self:UnLock("UISimpleHauteCoutureMainController:CheckFirstVedioPlay")
    else
      self:_LoadSpine()
      self:PlayInAnim(TT)
    end
  end)
end

function UISimpleHauteCoutureMainController:PlayInAnim(TT)
  self:_SetLayersGoVisible(true)
  self:Lock("UISimpleHauteCoutureMainController:PlayInAnim")
  self._anim:Play("uianim_UISimpleHauteCoutureMainFei_in")
  self._titleSpawner:PlayInAnimation()
  YIELD(TT, 767)
  self:UnLock("UISimpleHauteCoutureMainController:PlayInAnim")
end

function UISimpleHauteCoutureMainController:CheckPlayDiyAnim(TT)
  local prefab = self._cfgMain.CGPrefab
  local script = self._cfgMain.CGClass
  if not prefab or not script then
    return nil
  end
  local cg = UIWidgetHelper.SpawnObject(self, "EnterAnimationDIY", script, prefab .. ".prefab")
  cg:Play()
  return cg:GetClipLength()
end

function UISimpleHauteCoutureMainController:_SetLayersGoVisible(bVisible)
  for _, go in pairs(self._layersGo) do
    go:SetActive(bVisible)
  end
end
