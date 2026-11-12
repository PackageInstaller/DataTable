local DepotDiscSkillInfoCtrl = class("DepotDiscSkillInfoCtrl", BaseCtrl)
DepotDiscSkillInfoCtrl._mapNodeConfig = {
  canvasGroupInfo = {
    sNodeName = "goInfo",
    sComponentName = "CanvasGroup"
  },
  imgIcon = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  txtLevelMax = {sComponentName = "TMP_Text"},
  txtLevel = {sComponentName = "TMP_Text"},
  NoteLayer = {
    nCount = 5,
    sCtrlName = "Game.UI.StarTower.Depot.DepotDiscNoteLayerCtrl"
  },
  CommonSkill = {
    sCtrlName = "Game.UI.StarTower.Depot.DepotDiscNoteLayerCtrl"
  },
  svLevel = {
    sComponentName = "LoopScrollView"
  },
  imgLock = {}
}
DepotDiscSkillInfoCtrl._mapEventConfig = {}
DepotDiscSkillInfoCtrl._mapRedDotConfig = {}

function DepotDiscSkillInfoCtrl:InitNoteSkill(tbSkill)
  if tbSkill.nType == AllEnum.DiscSkillType.Common then
    self:InitCommonSkill(tbSkill)
  else
    self:InitPassiveSkill(tbSkill)
  end
end

function DepotDiscSkillInfoCtrl:InitCommonSkill(mapSkill)
  self._mapNode.CommonSkill.gameObject:SetActive(true)
  self._mapNode.txtLevelMax.gameObject:SetActive(false)
  self._mapNode.txtLevel.gameObject:SetActive(false)
  for _, v in ipairs(self._mapNode.NoteLayer) do
    v.gameObject:SetActive(false)
  end
  self.mapCommonCfg = ConfigTable.GetData("DiscCommonSkill", mapSkill.nId)
  if not self.mapCommonCfg then
    return
  end
  self.nCommonLayer = mapSkill.nLevel
  local bUnlock = self.nCommonLayer > 0
  NovaAPI.SetTMPText(self._mapNode.txtName, self.mapCommonCfg.Name)
  self:SetPngSprite(self._mapNode.imgIcon, self.mapCommonCfg.Icon)
  local nMaxLayer = #self.mapCommonCfg.ActiveNoteNum
  if 0 < nMaxLayer then
    self._mapNode.svLevel.gameObject:SetActive(true)
    self._mapNode.svLevel:Init(nMaxLayer, self, self.OnGridRefresh, self.OnGridBtnClick)
    self:RefreshCommonSkill()
  else
    self._mapNode.svLevel.gameObject:SetActive(false)
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroupInfo, bUnlock and 1 or 0.35)
end

function DepotDiscSkillInfoCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local txtNoteLayer = goGrid.transform:Find("btnLevel/AnimRoot/txtNoteLayer"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtNoteLayer, nIndex)
end

function DepotDiscSkillInfoCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if nIndex == self.nCommonLayer then
    return
  end
  self.nCommonLayer = nIndex
  self:RefreshCommonSkill()
end

function DepotDiscSkillInfoCtrl:RefreshCommonSkill()
  local sDesc = UTILS.ParseDiscDesc(self.mapCommonCfg.Desc, self.mapCommonCfg, nil, self.nCommonLayer)
  local tbNote = {}
  for _, v in pairs(self.mapCommonCfg.ActiveNoteType) do
    tbNote[v] = self.mapCommonCfg.ActiveNoteNum[self.nCommonLayer]
  end
  self._mapNode.CommonSkill:Refresh(nil, tbNote, sDesc, self.nCommonLayer > 0)
end

function DepotDiscSkillInfoCtrl:InitPassiveSkill(mapSkill)
  self._mapNode.CommonSkill.gameObject:SetActive(false)
  local skillCfg = ConfigTable.GetData("DiscPassiveSkill", mapSkill.nId)
  if not skillCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, skillCfg.Name)
  self:SetPngSprite(self._mapNode.imgIcon, skillCfg.Icon)
  local nCurActiveLayer = mapSkill.nLevel
  local nMaxLayer = 0
  for i = 1, 5 do
    local bHasLayer = skillCfg["ActiveParam" .. i] and skillCfg["ActiveParam" .. i] ~= ""
    self._mapNode.NoteLayer[i].gameObject:SetActive(bHasLayer)
    if bHasLayer then
      if nMaxLayer == 0 then
        local bLastlayer = skillCfg["ActiveParam" .. i + 1] == nil or skillCfg["ActiveParam" .. i + 1] == ""
        if bLastlayer then
          nMaxLayer = i
        end
      end
      local sDesc = UTILS.ParseDiscDesc(skillCfg["Desc" .. i], skillCfg)
      local tbLayerNote = decodeJson(skillCfg["ActiveParam" .. i])
      local tbNote = {}
      for k, v in pairs(tbLayerNote) do
        local nNoteId = tonumber(k)
        local nNoteCount = tonumber(v)
        if nNoteId then
          tbNote[nNoteId] = nNoteCount
        end
      end
      self._mapNode.NoteLayer[i]:Refresh(i, tbNote, sDesc, i <= nCurActiveLayer)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Skill_Lv"), nCurActiveLayer, nMaxLayer))
  NovaAPI.SetTMPText(self._mapNode.txtLevelMax, orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Skill_MaxLv"), nCurActiveLayer, nMaxLayer))
  local bUnlock = 0 < nCurActiveLayer
  local bMaxLv = nCurActiveLayer == nMaxLayer
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroupInfo, bUnlock and 1 or 0.4)
  self._mapNode.imgLock.gameObject:SetActive(not bUnlock)
  self._mapNode.txtLevelMax.gameObject:SetActive(bMaxLv)
  self._mapNode.txtLevel.gameObject:SetActive(not bMaxLv)
end

return DepotDiscSkillInfoCtrl
