_class("UISeasonCgDetailController", UIController)
UISeasonCgDetailController = UISeasonCgDetailController

function UISeasonCgDetailController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonCgDetailController:OnShow(uiParams)
  self:InitWidget()
  local cfg = uiParams[1]
  self._cpt = uiParams[2]
  self._cfg = cfg
  if cfg then
    if cfg.Spine then
      self._staticPicGO:SetActive(false)
      self._spine1Go:SetActive(true)
      self._spine1Go.transform.localScale = Vector3(cfg.SpineScale, cfg.SpineScale, cfg.SpineScale)
      local spineName1 = cfg.Spine[1]
      self._spine1:LoadSpine(spineName1)
      local spineName2 = cfg.Spine[2]
      if spineName2 then
        self._spine2Go:SetActive(true)
        self._spine2:LoadSpine(spineName2)
        self._spine2Go.transform.localScale = Vector3(cfg.SpineScale, cfg.SpineScale, cfg.SpineScale)
      end
      self:_SetPicFullScreen(self._staticPicRect)
    else
      self._spine1Go:SetActive(false)
      self._spine2Go:SetActive(false)
      self._staticPicGO:SetActive(true)
      self._staticPic:LoadImage(cfg.StaticPic)
      self:_SetPicFullScreen(self._staticPicRect)
    end
    self.txtTitle:SetText(StringTable.Get(cfg.name))
    self.txtDesc:SetText(StringTable.Get(cfg.info))
  end
  self.onlyShowCg = false
  local count = 0
  if self:GetModule(ShareModule):CanShare() and cfg.SeasonShareStoryID and not self._cpt:IsStoryReceived(cfg.SeasonShareStoryID) then
    local storyCfg = Cfg.cfg_campaign_story[cfg.SeasonShareStoryID]
    count = storyCfg.RewardList[1][2]
  end
  self._shareBtn = self.shareBtnPool:SpawnObject("UISeasonShareBtn")
  self._shareBtn:SetData(count, function()
    self:_OnShare()
  end)
  self._shareBtn:GetGameObject():SetActive(GameGlobal.GetModule(ShareModule):CanShare())
end

function UISeasonCgDetailController:InitWidget()
  local topBtns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtns = topBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, nil, true)
  self._uiCanvasRect = self:GetUIComponent("RectTransform", "UICanvas")
  self._spine1 = self:GetUIComponent("SpineLoader", "spine1")
  self._spine1Go = self:GetGameObject("spine1")
  self._spine2 = self:GetUIComponent("SpineLoader", "spine2")
  self._spine2Go = self:GetGameObject("spine2")
  self._staticPic = self:GetUIComponent("RawImageLoader", "imgCg")
  self._staticPicRect = self:GetUIComponent("RectTransform", "imgCg")
  self._staticPicGO = self:GetGameObject("imgCg")
  self.txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.exclueCgGo = self:GetGameObject("exclueCgGo")
  self.exclueCgGo2 = self:GetGameObject("exclueCgGo2")
  self.shareBtnPool = self:GetUIComponent("UISelectObjectPath", "ShareBtn")
  self.root = self:GetGameObject("Root")
end

function UISeasonCgDetailController:ImgCgOnClick(go)
  self.onlyShowCg = not self.onlyShowCg
  self.exclueCgGo:SetActive(not self.onlyShowCg)
  self.exclueCgGo2:SetActive(not self.onlyShowCg)
end

function UISeasonCgDetailController:_OnShare()
  if self:GetModule(SeasonModule):CheckSeasonClose_ShowClientError() then
    return
  end
  self.exclueCgGo:SetActive(false)
  self.exclueCgGo2:SetActive(false)
  self:AttachEvent(GameEventType.OnFocusAfterShareBack, self._OnShareFinish)
  self:Lock("UISeasonShareCG")
  self:StartTask(function(TT)
    YIELD(TT)
    YIELD(TT)
    self:ShowDialog("UIShare", self:GetName(), ShareAnchorType.BottomRight, function()
      self.exclueCgGo:SetActive(true)
      self.exclueCgGo2:SetActive(true)
    end, nil, nil, nil, ShareSceneType.Common, nil, nil)
    self:UnLock("UISeasonShareCG")
  end, self)
end

function UISeasonCgDetailController:_OnShareFinish()
  self:DetachEvent(GameEventType.OnFocusAfterShareBack, self._OnShareFinish)
  if not self._cpt:IsStoryReceived(self._cfg.SeasonShareStoryID) then
    self:StartTask(self._ReqCompleteStory, self)
  else
    Log.error("cg分享奖励已经领过了")
  end
end

function UISeasonCgDetailController:_ReqCompleteStory(TT)
  local res = AsyncRequestRes:New()
  self:Lock("RequestCollectShareCgAward")
  local assets = self._cpt:HandleStoryTake(TT, res, self._cfg.SeasonShareStoryID)
  self:UnLock("RequestCollectShareCgAward")
  if res:GetSucc() then
    UISeasonHelper.ShowUIGetRewards(assets)
    self._shareBtn:GetGameObject():SetActive(false)
    self:DispatchEvent(GameEventType.OnSeasonShareCgFinished, self._cfg.ID)
  else
    Log.error("cg分享奖励领取错误:", res:GetResult())
  end
end

function UISeasonCgDetailController:_SetPicFullScreen(rectTrans)
  local fullPicWidth = 2048
  local fullPicHeight = 946
  local screenWidth, screenHeight = self:GetCanvasSize()
  local picAspect = fullPicWidth / fullPicHeight
  local screenAspect = screenWidth / screenHeight
  local blackSideHeight = 0
  local blackSideWidth = 0
  local picHeight = fullPicHeight * screenWidth / fullPicWidth
  rectTrans.sizeDelta = Vector2(screenWidth, picHeight)
  blackSideHeight = math.abs(screenHeight - picHeight) / 2
end

function UISeasonCgDetailController:GetCanvasSize()
  return self._uiCanvasRect.sizeDelta.x, self._uiCanvasRect.sizeDelta.y
end
