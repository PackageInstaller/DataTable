_class("UISeasonFinalPlotShare", UIController)
UISeasonFinalPlotShare = UISeasonFinalPlotShare

function UISeasonFinalPlotShare:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonFinalPlotShare:OnShow(uiParams)
  self:InitWidget()
  local seasonID = uiParams[1]
  self._cpt = uiParams[2]
  self._onFinish = uiParams[3]
  local cfg = Cfg.cfg_season_campaign_client[seasonID]
  self._storyID = cfg.FinalStoryShareStoryID
  local cg = cfg.FinalStoryCg
  local sourceCg = cfg.FinalStorySourceCg
  local cfg = Cfg.cfg_campaign_story[self._storyID]
  local asset = cfg.RewardList[1]
  self.cg:LoadImage(cg)
  self.sourceCg:LoadImage(sourceCg)
  local btn = self._shareBtn:SpawnObject("UISeasonShareBtn")
  btn:SetData(asset[2], function()
    self:_ShareBtnOnClick()
  end)
end

function UISeasonFinalPlotShare:InitWidget()
  self.cg = self:GetUIComponent("RawImageLoader", "Cg")
  self.sourceCg = self:GetUIComponent("RawImageLoader", "SourceCg")
  self._shareBtn = self:GetUIComponent("UISelectObjectPath", "ShareBtn")
  self._anim = self:GetGameObject():GetComponent("Animation")
  self._root = self:GetGameObject("root")
end

function UISeasonFinalPlotShare:_ShareBtnOnClick()
  if self:GetModule(SeasonModule):CheckSeasonClose_ShowClientError() then
    return
  end
  self:Lock("UISeasonFinalPlotShare")
  self:AttachEvent(GameEventType.OnFocusAfterShareBack, self._OnShareFinish)
  self.sourceCg.gameObject:SetActive(true)
  self._root:SetActive(false)
  self:StartTask(function(TT)
    YIELD(TT)
    YIELD(TT)
    self:ShowDialog("UIShare", self:GetName(), ShareAnchorType.BottomRight, function()
      self.sourceCg.gameObject:SetActive(false)
      self._root:SetActive(true)
    end, nil, nil, nil, ShareSceneType.Common, nil, nil)
    self:UnLock("UISeasonFinalPlotShare")
  end, self)
end

function UISeasonFinalPlotShare:_OnShareFinish()
  self:DetachEvent(GameEventType.OnFocusAfterShareBack, self._OnShareFinish)
  if not self._cpt:IsStoryReceived(self._storyID) then
    self:StartTask(self._ReqCompleteStory, self)
  else
    Log.error("分享奖励已经领过了")
  end
end

function UISeasonFinalPlotShare:_ReqCompleteStory(TT)
  local res = AsyncRequestRes:New()
  self:Lock("RequestCollectFinalPlotShareCgAward")
  local assets = self._cpt:HandleStoryTake(TT, res, self._storyID)
  self:UnLock("RequestCollectFinalPlotShareCgAward")
  if res:GetSucc() then
    self:_CloseDialogWithAnim(function()
      UISeasonHelper.ShowUIGetRewards(assets)
      self._onFinish()
      self:DispatchEvent(GameEventType.OnSeasonShareCgFinished)
    end)
  else
    Log.error("分享奖励领取错误:", res:GetResult())
  end
end

function UISeasonFinalPlotShare:CloseOnClick(go)
  self:_CloseDialogWithAnim(function()
    self._onFinish()
  end)
end

function UISeasonFinalPlotShare:_CloseDialogWithAnim(callback)
  if self._anim then
    self:Lock("UISeasonFinalPlotShare:CloseDialogWithAnim")
    if self._anim then
      self._anim:Play("uianim_UISeasonFinalPlotShare_out")
    end
    self:StartTask(function(TT)
      YIELD(TT, 500)
      self:UnLock("UISeasonFinalPlotShare:CloseDialogWithAnim")
      if not self.view then
        return
      end
      self:CloseDialog()
      if callback then
        callback()
      end
    end, self)
  end
end
