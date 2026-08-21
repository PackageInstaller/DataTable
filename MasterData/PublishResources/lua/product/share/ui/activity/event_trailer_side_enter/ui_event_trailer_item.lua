_class("UIEventTrailerItem", UICustomWidget)
UIEventTrailerItem = UIEventTrailerItem

function UIEventTrailerItem:Constructor()
  self._statue = EEventTrailerBtnStatue.NoWatch
  local pstID = GameGlobal.GetModule(RoleModule):GetPstId()
  self._newKey = "UIEventTrailerItem_New" .. pstID
end

function UIEventTrailerItem:OnShow()
  self:GetComponents()
end

function UIEventTrailerItem:OnHide()
end

function UIEventTrailerItem:GetComponents()
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._title2 = self:GetUIComponent("UILocalizationText", "title2")
  self._time1 = self:GetUIComponent("UILocalizationText", "time1")
  self._time2 = self:GetUIComponent("UILocalizationText", "time2")
  self._newObj = self:GetGameObject("new")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "anim")
  self._rootRect = self:GetUIComponent("RectTransform", "root")
  self._goBtnGroup = {}
  self._goBtnGroup[EEventTrailerBtnStatue.NoWatch] = self:GetGameObject("GoBtn1")
  self._goBtnGroup[EEventTrailerBtnStatue.Watch] = self:GetGameObject("GoBtn2")
  self._goBtnGroup[EEventTrailerBtnStatue.Go] = self:GetGameObject("GoBtn3")
  self._goBtnGroup[EEventTrailerBtnStatue.End] = self:GetGameObject("GoBtn4")
end

function UIEventTrailerItem:SetData(data)
  self._data = data
  self._cfg = self._data.cfg
  self._statue = self._data.statue
  self._newKey = self._newKey .. self._cfg.ID
  self._txtTitle:SetText(StringTable.Get(self._cfg.Title))
  self._title2:SetText(StringTable.Get(self._cfg.Name))
  self._time1:SetText(TimeToDate4(self._data.startTime, "day"))
  self._time2:SetText(TimeToDate4(self._data.endTime, "day"))
  for _, v in pairs(self._goBtnGroup) do
    v:SetActive(false)
  end
  self._goBtnGroup[self._statue]:SetActive(true)
  self._newObj:SetActive(LocalDB.GetInt(self._newKey, 0) == 0 and self._statue == EEventTrailerBtnStatue.Go)
end

function UIEventTrailerItem:GoBtn2OnClick()
  self:ShowDialog("UIEventTrailerInfoController", self._data)
end

function UIEventTrailerItem:ClearNew()
  if LocalDB.GetInt(self._newKey, 0) == 0 and self._statue == EEventTrailerBtnStatue.Go then
    LocalDB.SetInt(self._newKey, 1)
  end
end

function UIEventTrailerItem:GoBtn3OnClick()
  if self._cfg.CampaignType == EEventTrailerType.Campaign then
    local campaignModule = self:GetModule(CampaignModule)
    local campaign = campaignModule.m_campaign_manager.m_campaign_dict[self._cfg.CampaignID]
    if not campaign then
      local campaignCfg = Cfg.cfg_campaign[self._cfg.CampaignID]
      local missionCfg = Cfg.cfg_mission[campaignCfg.NeedMissionID]
      local missionName = StringTable.Get(missionCfg.Name)
      ToastManager.ShowToast(StringTable.Get("str_event_trailer_locked_tips_1", missionName))
      return
    end
    local key = math.floor(self._cfg.ComponentID - math.floor(self._cfg.ComponentID / 100) * 100)
    local componentInfo = campaign.m_component_dict[key]:GetComponentInfo()
    if not componentInfo.m_b_unlock then
      if componentInfo.m_unlock_items and table.count(componentInfo.m_unlock_items) > 0 then
        local itemCfg = Cfg.cfg_item[componentInfo.m_unlock_items[1]]
        local itemName = StringTable.Get(itemCfg.Name)
        ToastManager.ShowToast(StringTable.Get("str_event_trailer_locked_tips_2", itemName))
      elseif componentInfo.m_need_mission_id then
        local missionName = ""
        if componentInfo.m_need_mission_type == MatchType.MT_Season then
          local missionCfg = Cfg.cfg_season_mission[componentInfo.m_need_mission_id]
          missionName = StringTable.Get(missionCfg.Name)
        elseif componentInfo.m_need_mission_type == MatchType.MT_Campaign then
          local missionCfg = Cfg.cfg_campaign_mission[componentInfo.m_need_mission_id]
          missionName = StringTable.Get(missionCfg.Name)
        end
        ToastManager.ShowToast(StringTable.Get("str_event_trailer_locked_tips_1", missionName))
      end
      return
    end
  end
  local uiJumpModule = GameGlobal.GetUIModule(QuestModule)
  local jumpID = self._cfg.JumpID
  if jumpID then
    local jumpParam = self._cfg.JumpParams
    uiJumpModule:SetJumpUIData(jumpID, jumpParam)
    uiJumpModule:Jump()
  elseif self._cfg.SeasonJumpID then
    UIEventTrailerSeasonHelper.Jump(self._cfg.SeasonJumpID)
  else
    local campConfig = Cfg.cfg_campaign[self._cfg.CampaignID]
    local campType = campConfig.CampaignType
    local param = {campaign_type = campType}
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OpenContentByCampaignType, param)
  end
end

function UIEventTrailerItem:PlayInAnim(index)
  self._canvasGroup.alpha = 0
  self._rootRect.anchoredPosition = Vector2(160.3658, 0)
  self:StartTask(function(TT)
    local yieldTime = (index - 1) * 48
    YIELD(TT, yieldTime)
    if tolua.isnull(self._anim) then
      return
    end
    self._anim:Play("uianim_UIEventTrailerItem_in")
  end)
end

local EEventTrailerBtnStatue = {
  NoWatch = 1,
  Watch = 2,
  Go = 3,
  End = 4
}
_enum("EEventTrailerBtnStatue", EEventTrailerBtnStatue)
