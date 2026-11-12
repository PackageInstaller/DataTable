local DepotDiscSkillCtrl = class("DepotDiscSkillCtrl", BaseCtrl)
DepotDiscSkillCtrl._mapNodeConfig = {
  imgNote = {nCount = 9, sComponentName = "Image"},
  txtNoteCount = {nCount = 9, sComponentName = "TMP_Text"},
  btnNoteDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NoteDetail"
  },
  goNoteListBtn = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NoteDetail"
  },
  btnDiscDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DiscDetail"
  },
  txtDiscDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_DiscSkillInfo"
  },
  txtMainSkillTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_MainSkill_Title"
  },
  txtMainSubSkillTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_MainSkill_TitleTip"
  },
  txtHarmonySkillTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_SubSkill_Title"
  },
  txtHarmonySkillSubTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_SubSkill_TitleTip"
  },
  DiscSkillDepotItem = {
    nCount = 3,
    sCtrlName = "Game.UI.StarTower.Depot.DepotDiscMainSkillItemCtrl"
  },
  goDiscSkillItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateDiscSkillCardCtrl"
  },
  goHarmonyGrid = {
    sComponentName = "RectTransform"
  },
  HarmonySkillDepotItem = {},
  svDiscSkill = {sComponentName = "ScrollRect"}
}
DepotDiscSkillCtrl._mapEventConfig = {
  SelectDepotDiscSkill = "OnEvent_SelectDepotDiscSkill"
}

function DepotDiscSkillCtrl:RefreshDiscSkill(mapNote, tbActiveSecondaryIds)
  local tbDisc = {}
  local tbSkillIds = {}
  self.tbMapNote = mapNote
  if nil == self._panel.tbDisc then
    return
  end
  for i = 1, 9 do
    self._mapNode.imgNote[i].gameObject:SetActive(false)
  end
  for nIdx, sNoteId in ipairs(self._panel.tbShowNote) do
    if nIdx <= #self._mapNode.imgNote then
      self._mapNode.imgNote[nIdx].gameObject:SetActive(true)
      local nNoteId = tonumber(sNoteId)
      local nNoteCount = mapNote[nNoteId] == nil and 0 or mapNote[nNoteId]
      local noteCfg = ConfigTable.GetData("SubNoteSkill", nNoteId)
      local nNoteNeed = self._panel.mapNoteNeed[nNoteId]
      local sIconPath = ""
      if nNoteNeed ~= nil and 0 < nNoteNeed then
        sIconPath = noteCfg.Icon .. AllEnum.DiscSkillIconSurfix.S_Light
      else
        sIconPath = noteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small
      end
      self:SetPngSprite(self._mapNode.imgNote[nIdx], sIconPath)
      NovaAPI.SetTMPText(self._mapNode.txtNoteCount[nIdx], nNoteCount)
    end
  end
  local nSubSkillCount = 0
  local nSortingOrder = self._panel._nIndex * 100 + 99
  for j = 1, 3 do
    local nDiscId = self._panel.tbDisc[j]
    local discData = self._panel.mapDiscData[nDiscId]
    table.insert(tbDisc, nDiscId)
    if discData ~= nil then
      table.insert(tbSkillIds, discData.nMainSkillId)
      self._mapNode.DiscSkillDepotItem[j]:Refresh(discData.nMainSkillId, discData.nRarity, nDiscId, discData.nStar)
      local tbSubSkill = discData:GetAllSubSkill(mapNote)
      for i = nSubSkillCount + 1, nSubSkillCount + #tbSubSkill do
        local nSkillId = tbSubSkill[i - nSubSkillCount]
        if nil == self.tbHarmonySkillDepotItemCtrl[i] then
          local itemObj = instantiate(self._mapNode.HarmonySkillDepotItem, self._mapNode.goHarmonyGrid)
          itemObj.gameObject:SetActive(true)
          local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.StarTower.Depot.DepotDiscSubSkillItemCtrl")
          table.insert(self.tbHarmonySkillDepotItemCtrl, itemCtrl)
        end
        if nSkillId ~= nil then
          local mapCfg = ConfigTable.GetData("SecondarySkill", nSkillId)
          if mapCfg ~= nil and nil ~= self.tbHarmonySkillDepotItemCtrl[i] then
            self.tbHarmonySkillDepotItemCtrl[i]:SetItem(nSkillId, nDiscId, mapNote, nSortingOrder)
          elseif nil ~= self.tbHarmonySkillDepotItemCtrl[i] then
            self.tbHarmonySkillDepotItemCtrl[i]:SetItem(nil)
          end
        elseif nil ~= self.tbHarmonySkillDepotItemCtrl[i] then
          self.tbHarmonySkillDepotItemCtrl[i]:SetItem(nil)
        end
      end
      nSubSkillCount = nSubSkillCount + #tbSubSkill
    end
  end
  if nSubSkillCount < 6 then
    for i = nSubSkillCount + 1, 6 do
      if nil == self.tbHarmonySkillDepotItemCtrl[i] then
        local itemObj = instantiate(self._mapNode.HarmonySkillDepotItem, self._mapNode.goHarmonyGrid)
        itemObj.gameObject:SetActive(true)
        local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.StarTower.Depot.DepotDiscSubSkillItemCtrl")
        table.insert(self.tbHarmonySkillDepotItemCtrl, itemCtrl)
      end
      self.tbHarmonySkillDepotItemCtrl[i]:SetItem(nil)
    end
  end
  NovaAPI.SetScrollRectVertical(self._mapNode.svDiscSkill, #self.tbHarmonySkillDepotItemCtrl > 6)
  if PlayerData.Guide:GetGuideState() then
    EventManager.Hit("Guide_StarTowerDepotDisc", 0 < nSubSkillCount)
  end
  if 0 < #tbDisc and 0 < #tbSkillIds then
    EventManager.Hit("SelectDepotDiscSkill", tbDisc[1], tbSkillIds[1], nil, false)
  end
end

function DepotDiscSkillCtrl:Awake()
  self.tbHarmonySkillDepotItemCtrl = {}
end

function DepotDiscSkillCtrl:OnEnable()
end

function DepotDiscSkillCtrl:OnDisable()
  for i, v in pairs(self.tbHarmonySkillDepotItemCtrl) do
    self:UnbindCtrlByNode(v)
    self.tbHarmonySkillDepotItemCtrl[i] = nil
  end
  self.tbHarmonySkillDepotItemCtrl = {}
end

function DepotDiscSkillCtrl:OnDestroy()
end

function DepotDiscSkillCtrl:OnRelease()
end

function DepotDiscSkillCtrl:Clear()
end

function DepotDiscSkillCtrl:OnBtnClick_NoteDetail()
  EventManager.Hit(EventId.OpenPanel, PanelId.NoteSkillInfo, self.tbMapNote)
end

function DepotDiscSkillCtrl:OnEvent_SelectDepotDiscSkill(nDiscId, nMainSkillId, nSubSkillId)
  local discData = self._panel.mapDiscData[nDiscId]
  self._mapNode.goDiscSkillItem:Refresh(nDiscId, nMainSkillId, nSubSkillId, discData.nStar)
  self._mapNode.goDiscSkillItem:ChangeWordRaycast(true)
end

function DepotDiscSkillCtrl:OnBtnClick_DiscDetail()
  if self:GetPanelId() == PanelId.StarTowerFastBattle then
    self._panel:OpenDepotDetailPanel(PanelId.DiscSkill, self._panel.tbDisc, self.tbMapNote, self._panel.mapDiscData)
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.DiscSkill, self._panel.tbDisc, self.tbMapNote, self._panel.mapDiscData)
end

return DepotDiscSkillCtrl
