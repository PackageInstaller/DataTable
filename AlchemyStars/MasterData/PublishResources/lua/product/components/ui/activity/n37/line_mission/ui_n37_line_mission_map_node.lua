_class("UIN37LineMissionMapNode", UICustomWidget)
UIN37LineMissionMapNode = UIN37LineMissionMapNode

function UIN37LineMissionMapNode:OnShow(uiParams)
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
end

function UIN37LineMissionMapNode:Destroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UIN37LineMissionMapNode:SetData(lineCfg, passInfo, cb)
  self._missionID = lineCfg.CampaignMissionId
  self._callback = cb
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
  end
  self:_SetRectTransform(lineCfg)
  self:_SetState(missionCfg.Type)
  self:_SetName_TMP(missionCfg.Type, StringTable.Get(missionCfg.Name))
  self:_SetStar(passInfo)
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  local id = lineCfg.MapPosY >= 0 and "uieff_UIXH1MissionNode_belowin" or "uieff_UIXH1MissionNode_topin"
  UIWidgetHelper.SetAnimationPlay(self, "anim", id)
end

function UIN37LineMissionMapNode:_SetRectTransform(lineCfg)
  self._rectTransform.anchorMax = Vector2(0, 0.5)
  self._rectTransform.anchorMin = Vector2(0, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
end

function UIN37LineMissionMapNode:_SetName(state, text)
  local tb = {
    "name_normal",
    "name_boss",
    "name_plot"
  }
  UIWidgetHelper.SetLocalizationText(self, tb[state], text)
end

function UIN37LineMissionMapNode:_SetName_TMP(state, text)
  local tb = {
    "name_normal",
    "name_boss",
    "name_plot"
  }
  local tb2 = {
    "uieff_uin37_line_normal.mat",
    "uieff_uin37_line_boss.mat",
    "uieff_uin37_line_plot.mat"
  }
  self._matReq = UIWidgetHelper.SetLocalizedTMPMaterial(self, tb[state], tb2[state], nil)
  UIWidgetHelper.SetLocalizedTMPText(self, tb[state], text)
end

function UIN37LineMissionMapNode:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "bg_normal",
      "name_normal",
      "star"
    },
    {
      "bg_boss",
      "name_boss",
      "star"
    },
    {"bg_plot", "name_plot"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
  local atlasName = "UIN37Main.spriteatlas"
  local spriteName1 = state == 2 and "n37_xxg_star03" or "n37_xxg_star01"
  local spriteName2 = state == 2 and "n37_xxg_star04" or "n37_xxg_star02"
  local tbStar = {
    "Star1",
    "Star2",
    "Star3"
  }
  for _, v in ipairs(tbStar) do
    UIWidgetHelper.SetImageSprite(self, v, atlasName, spriteName1)
  end
  local tbBg = {
    "StarBg1",
    "StarBg2",
    "StarBg3"
  }
  for _, v in ipairs(tbBg) do
    UIWidgetHelper.SetImageSprite(self, v, atlasName, spriteName2)
  end
  local spriteName3 = state == 2 and "n37_xxg_di07" or "n37_xxg_di06"
  UIWidgetHelper.SetImageSprite(self, "name_bg", atlasName, spriteName3)
end

function UIN37LineMissionMapNode:_SetStar(passInfo)
  local missionModule = self:GetModule(MissionModule)
  local stars = passInfo and missionModule:ParseStarInfo(passInfo.star) or 0
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [0] = {},
    [1] = {"Star1"},
    [2] = {"Star1", "Star2"},
    [3] = {
      "Star1",
      "Star2",
      "Star3"
    }
  })
  UIWidgetHelper.SetObjGroupShow(objs, stars)
end

function UIN37LineMissionMapNode:BtnOnClick(go)
  self._callback(self._missionID, self._isStoryNode, self._rectTransform.position)
end
