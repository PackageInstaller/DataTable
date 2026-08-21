_class("UICN16N45LineMapNode", UICustomWidget)
UICN16N45LineMapNode = UICN16N45LineMapNode

function UICN16N45LineMapNode:OnShow(uiParams)
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._starGo = self:GetGameObject("star_normal")
  self._passStarList = {}
  self._passStarList[1] = self:GetGameObject("normal_Star1")
  self._passStarList[2] = self:GetGameObject("normal_Star2")
  self._passStarList[3] = self:GetGameObject("normal_Star3")
  self._passStarNoList = {}
  self._passStarNoList[1] = self:GetGameObject("normal_Star1_no")
  self._passStarNoList[2] = self:GetGameObject("normal_Star2_no")
  self._passStarNoList[3] = self:GetGameObject("normal_Star3_no")
end

function UICN16N45LineMapNode:Destroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UICN16N45LineMapNode:SetData(lineCfg, passInfo, cb)
  self._missionID = lineCfg.CampaignMissionId
  self._callback = cb
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
  end
  self:_SetRectTransform(lineCfg)
  self:_SetName(missionCfg.Type, StringTable.Get(missionCfg.Name))
  self:_SetState(missionCfg.Type)
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  self:_SetStar(passInfo)
  self:_SetPlay(passInfo)
end

function UICN16N45LineMapNode:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"bg_normal"},
    {"bg_boss"},
    {"bg_plot"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UICN16N45LineMapNode:_SetRectTransform(lineCfg)
  self._rectTransform.anchorMax = Vector2(0, 0.5)
  self._rectTransform.anchorMin = Vector2(0, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
end

function UICN16N45LineMapNode:_SetName(state, text)
  local tb = {
    "name",
    "name",
    "name"
  }
  UIWidgetHelper.SetLocalizationText(self, tb[state], text)
end

function UICN16N45LineMapNode:_SetName_TMP(state, text)
  local tb = {
    "_txtNameNormal",
    "_txtNameBoss",
    "_txtNamePlot"
  }
  local tb2 = {
    "uieff_uin19_line_normal.mat",
    "uieff_uin19_line_boss.mat",
    "uieff_uin19_line_plot.mat"
  }
  self._matReq = UIWidgetHelper.SetLocalizedTMPMaterial(self, tb[state], tb2[state], nil)
  UIWidgetHelper.SetLocalizedTMPText(self, tb[state], text)
end

function UICN16N45LineMapNode:_SetStar(passInfo)
  self._starGo:SetActive(not self._isStoryNode)
  if not self._isStoryNode then
    local missionModule = self:GetModule(MissionModule)
    local stars = passInfo and missionModule:ParseStarInfo(passInfo.star) or 0
    for i = 1, 3 do
      local star = self._passStarList[i]
      local star_no = self._passStarNoList[i]
      star:SetActive(i <= stars)
      star_no:SetActive(not (i <= stars))
    end
  end
end

function UICN16N45LineMapNode:_SetPlay(passInfo)
  local isShow = passInfo and passInfo.pass_without_help ~= 0
  self:GetGameObject("_play"):SetActive(not isShow)
  self:GetGameObject("_playFin"):SetActive(isShow)
end

function UICN16N45LineMapNode:BtnOnClick(go)
  self._callback(self._missionID, self._isStoryNode, self._rectTransform.position)
end
