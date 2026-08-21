_class("UISeasonBuffInnerGameInfo", UIController)
UISeasonBuffInnerGameInfo = UISeasonBuffInnerGameInfo

function UISeasonBuffInnerGameInfo:LoadDataOnEnter(TT, res, uiParams)
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  local seasonClose = seasonModule:GetCurSeasonID() == -1
  if seasonClose then
    Log.error("当前赛季已经结束不能打开BUFF弹窗")
    seasonModule:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
    res:SetSucc(false)
    return
  end
  local serialautofightmodule = self:GetModule(SerialAutoFightModule)
  local running = serialautofightmodule:IsRunning()
  if running then
    res:SetSucc(false)
  else
    res:SetSucc(true)
  end
end

function UISeasonBuffInnerGameInfo:OnShow(uiParams)
  self._detailLevelText = self:GetUIComponent("UILocalizationText", "DetailLevel")
  self._detailContentText = self:GetUIComponent("UILocalizationText", "DetailContent")
  self._titleText = self:GetUIComponent("UILocalizationText", "Title")
  local seasonModule = self:GetModule(SeasonModule)
  local seasonObj = seasonModule:GetCurSeasonObj()
  if seasonObj then
    local componentID = seasonObj:GetSeasonMissionComponentCfgID()
    local curLevel, curProgress, maxLevel, isMaxLevel = UISeasonHelper.CalcBuffLevel(componentID)
    self._detailLevelText:SetText(StringTable.Get("str_season_buff_level", tostring(curLevel)))
    local cfgGroup = Cfg.cfg_component_season_wordbuff({ComponentID = componentID, Lv = curLevel})
    if cfgGroup and 0 < #cfgGroup then
      local cfg = cfgGroup[1]
      local desc = cfg.Desc
      self._detailContentText:SetText(StringTable.Get(desc))
    else
      self._detailContentText:SetText("")
    end
  end
  self._titleText:SetText(StringTable.Get(UISeasonHelper.CurSeasonBuffTitleInBattle()))
  local icon = self:GetUIComponent("RawImageLoader", "Icon")
  icon:LoadImage(UISeasonHelper.CurSeasonBuffIconInBattle())
end

function UISeasonBuffInnerGameInfo:FullScreenBtnOnClick(go)
  self:CloseDialog()
end
