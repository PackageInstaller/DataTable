local DepotDiscSkillCtrl = class("DepotDiscSkillCtrl", BaseCtrl)
DepotDiscSkillCtrl._mapNodeConfig = {
  imgNote = {nCount = 9, sComponentName = "Image"},
  txtNoteCount = {nCount = 9, sComponentName = "TMP_Text"},
  goNoteListBtn = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NoteDetail"
  },
  btnNoteDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NoteDetail"
  },
  btnDiscDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DiscDetail"
  },
  txtDiscDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_Btn_Info"
  },
  txtMainSkillTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_MainSkill_Title"
  },
  txtMainSkillTitleTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_MainSkill_TitleTip"
  },
  txtHarmonySkillTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_SubSkill_Title"
  },
  txtHarmonySkillTitleTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_SubSkill_TitleTip"
  },
  DiscSkillDepotItem = {nCount = 3},
  goDiscSkillItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateDiscSkillCardCtrl"
  },
  goHarmonyGrid = {
    sComponentName = "RectTransform"
  },
  HarmonySkillDepotItem = {}
}
DepotDiscSkillCtrl._mapEventConfig = {
  SelectDepotDiscSkill = "OnEvent_SelectDepotDiscSkill"
}

function DepotDiscSkillCtrl:RefreshDiscSkill(mapNote)
  local tbDisc = {}
  local tbSkillIds = {}
  self.tbMapNote = mapNote
  if nil == self._panel.tbDisc then
    return
  end
  for i = 1, 9 do
    self._mapNode.imgNote[i].gameObject:SetActive(false)
  end
  if next(mapNote) == nil then
    self._mapNode.goNoteListBtn.gameObject:SetActive(false)
  else
    self._mapNode.goNoteListBtn.gameObject:SetActive(true)
    local nNoteIdx = 1
    for k, v in ipairsSorted(mapNote) do
      self._mapNode.imgNote[nNoteIdx].gameObject:SetActive(true)
      local nNoteId = tonumber(k)
      local nNoteCount = tonumber(v)
      local noteCfg = ConfigTable.GetData("SubNoteSkill", nNoteId)
      local sIconPath = ""
      if self._panel.mapNoteNeed[nNoteId] ~= nil and self._panel.mapNoteNeed[nNoteId] > 0 then
        sIconPath = noteCfg.Icon .. AllEnum.DiscSkillIconSurfix.S_Light
      else
        sIconPath = noteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small
      end
      self:SetPngSprite(self._mapNode.imgNote[nNoteIdx], sIconPath)
      NovaAPI.SetTMPText(self._mapNode.txtNoteCount[nNoteIdx], nNoteCount)
      nNoteIdx = nNoteIdx + 1
    end
  end
  local nSubSkillCount = 1
  local nSortingOrder = self._panel._nIndex * 100 + 99
  for i = 1, 3 do
    local nDiscId = self._panel.tbDisc[i]
    local discData = self._panel.mapDiscData[nDiscId]
    table.insert(tbDisc, nDiscId)
    if discData ~= nil then
      table.insert(tbSkillIds, discData.nMainSkillId)
      local objCtrl = self:BindCtrlByNode(self._mapNode.DiscSkillDepotItem[i].gameObject, "Game.UI.StarTower.Depot.DepotDiscMainSkillItemCtrl")
      objCtrl:Refresh(discData.nMainSkillId, discData.nRarity, nDiscId, discData.nStar)
      local tbSubSkill = discData:GetAllSubSkill(mapNote)
      for _, nSkillId in pairs(tbSubSkill) do
        local mapCfg = ConfigTable.GetData("SecondarySkill", nSkillId)
        if mapCfg ~= nil and nil == self.tbHarmonySkillDepotItemCtrl[nSubSkillCount] then
          local itemObj = instantiate(self._mapNode.HarmonySkillDepotItem, self._mapNode.goHarmonyGrid)
          itemObj.gameObject:SetActive(true)
          local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.StarTower.Depot.DepotDiscSubSkillItemCtrl")
          table.insert(self.tbHarmonySkillDepotItemCtrl, itemCtrl)
          itemCtrl:SetItem(nSkillId, nDiscId, mapNote, nSortingOrder)
        elseif nil ~= mapCfg then
          self.tbHarmonySkillDepotItemCtrl[nSubSkillCount]:SetItem(nSkillId, nDiscId, mapNote, nSortingOrder)
        end
        nSubSkillCount = nSubSkillCount + 1
      end
    end
  end
  if #self.tbHarmonySkillDepotItemCtrl < 6 then
    for i = #self.tbHarmonySkillDepotItemCtrl + 1, 6 do
      if nil == self.tbHarmonySkillDepotItemCtrl[i] then
        local itemObj = instantiate(self._mapNode.HarmonySkillDepotItem, self._mapNode.goHarmonyGrid)
        itemObj.gameObject:SetActive(true)
        local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.StarTower.Depot.DepotDiscSubSkillItemCtrl")
        table.insert(self.tbHarmonySkillDepotItemCtrl, itemCtrl)
      end
      self.tbHarmonySkillDepotItemCtrl[i]:SetItem(nil)
    end
  end
  if PlayerData.Guide:GetGuideState() then
    EventManager.Hit("Guide_StarTowerDepotDisc", 1 < nSubSkillCount)
  end
  if 0 < #tbDisc and 0 < #tbSkillIds then
    EventManager.Hit("SelectDepotDiscSkill", tbDisc[1], tbSkillIds[1], nil, false)
  end
end

function DepotDiscSkillCtrl:Awake()
  self.tbHarmonySkillDepotItemCtrl = {}
  self.tbEmpty = {}
end

function DepotDiscSkillCtrl:OnEnable()
end

function DepotDiscSkillCtrl:OnDisable()
  for i, v in pairs(self.tbHarmonySkillDepotItemCtrl) do
    self:UnbindCtrlByNode(v)
    self.tbHarmonySkillDepotItemCtrl[i] = nil
  end
  self.tbHarmonySkillDepotItemCtrl = {}
  self.tbEmpty = {}
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
  EventManager.Hit(EventId.OpenPanel, PanelId.DiscSkill, self._panel.tbDisc, self.tbMapNote, self._panel.mapDiscData)
end

return DepotDiscSkillCtrl
