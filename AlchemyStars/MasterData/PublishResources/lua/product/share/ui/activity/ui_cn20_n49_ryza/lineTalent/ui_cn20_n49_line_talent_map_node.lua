_class("UICN20N49LineTalentMapNode", UICustomWidget)
UICN20N49LineTalentMapNode = UICN20N49LineTalentMapNode

function UICN20N49LineTalentMapNode:OnShow(uiParams)
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._starGo = self:GetGameObject("star_normal")
  self._passStarList = {}
  self._passStarList[1] = self:GetUIComponent("Image", "normal_Star1")
  self._passStarList[2] = self:GetUIComponent("Image", "normal_Star2")
  self._passStarList[3] = self:GetUIComponent("Image", "normal_Star3")
  self._passStarNoList = {}
  self._passStarNoList[1] = self:GetUIComponent("Image", "normal_Star1_no")
  self._passStarNoList[2] = self:GetUIComponent("Image", "normal_Star2_no")
  self._passStarNoList[3] = self:GetUIComponent("Image", "normal_Star3_no")
end

function UICN20N49LineTalentMapNode:Destroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UICN20N49LineTalentMapNode:SetStarSp(normapStar, normalNoStar, bossStar, bossNoStar)
  self._normapStar = normapStar
  self._normalNoStar = normalNoStar
  self._bossStar = bossStar
  self._bossNoStar = bossNoStar
end

function UICN20N49LineTalentMapNode:SetData(lineCfg, passInfo, cb)
  self._missionID = lineCfg.CampaignMissionId
  self._callback = cb
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
  end
  local missionTipsCfg = Cfg.cfg_cn20_n49_line_talent_stage_tips[self._missionID]
  if not missionTipsCfg then
    Log.exception("cfg_cn20_n49_line_talent_stage_tips:", self._missionID)
  end
  self:_SetRectTransform(lineCfg)
  self:_SetName(missionCfg.Type, StringTable.Get(missionCfg.Name))
  self:_SetTips(missionCfg.Type, StringTable.Get(missionTipsCfg.Tips, table.unpack(missionTipsCfg.TipsParam)))
  self:_SetState(missionCfg.Type)
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  self._isBossNode = missionCfg.Type == DiscoveryStageType.FightBoss
  self:_SetStar(passInfo)
  self:_SetPlay(passInfo)
end

function UICN20N49LineTalentMapNode:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"bg_normal"},
    {"bg_boss"},
    {"bg_plot"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UICN20N49LineTalentMapNode:_SetRectTransform(lineCfg)
  self._rectTransform.anchorMax = Vector2(0, 0.5)
  self._rectTransform.anchorMin = Vector2(0, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
end

function UICN20N49LineTalentMapNode:_SetName(state, text)
  local tb = {
    "name",
    "boss_name",
    "story_name"
  }
  UIWidgetHelper.SetLocalizationText(self, tb[state], text)
end

function UICN20N49LineTalentMapNode:_SetStar(passInfo)
  self._starGo:SetActive(false)
  do return end
  self._starGo:SetActive(not self._isStoryNode)
  if not self._isStoryNode then
    local missionModule = self:GetModule(MissionModule)
    local stars = passInfo and missionModule:ParseStarInfo(passInfo.star) or 0
    for i = 1, 3 do
      local star = self._passStarList[i]
      local star_no = self._passStarNoList[i]
      if self._isBossNode then
        star.sprite = self._bossStar
        star_no.sprite = self._bossNoStar
      else
        star.sprite = self._normapStar
        star_no.sprite = self._normalNoStar
      end
      star_no.gameObject:SetActive(not (i <= stars))
      star.gameObject:SetActive(i <= stars)
    end
  end
end

function UICN20N49LineTalentMapNode:_SetPlay(passInfo)
  local isShow = passInfo and passInfo.pass_without_help ~= 0
  self:GetGameObject("_play"):SetActive(not isShow)
  self:GetGameObject("_playFin"):SetActive(isShow)
end

function UICN20N49LineTalentMapNode:BtnOnClick(go)
  self._callback(self._missionID, self._isStoryNode, self._rectTransform.position)
end

function UICN20N49LineTalentMapNode:_SetTips(state, text)
  local tb = {
    "tips",
    "boss_tips",
    "story_tips"
  }
  UIWidgetHelper.SetLocalizationText(self, tb[state], text)
end
