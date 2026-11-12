local BuildModifierNoteSkillListCtrl = class("BuildModifierNoteSkillListCtrl", BaseCtrl)
BuildModifierNoteSkillListCtrl._mapNodeConfig = {
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "STShop_OutfitNoteHintTitle"
  },
  MusicSkillLSV = {
    sComponentName = "LoopScrollView"
  }
}
BuildModifierNoteSkillListCtrl._mapEventConfig = {}
BuildModifierNoteSkillListCtrl._mapRedDotConfig = {}

function BuildModifierNoteSkillListCtrl:Awake()
  self.mapGridCtrl = {}
end

function BuildModifierNoteSkillListCtrl:FadeIn()
end

function BuildModifierNoteSkillListCtrl:FadeOut()
end

function BuildModifierNoteSkillListCtrl:OnEnable()
end

function BuildModifierNoteSkillListCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.mapGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapGridCtrl[nInstanceId] = nil
  end
  self.mapGridCtrl = {}
end

function BuildModifierNoteSkillListCtrl:OnDestroy()
end

function BuildModifierNoteSkillListCtrl:OnRelease()
end

function BuildModifierNoteSkillListCtrl:Refresh(tbOutfitId, mapNoteCount, mapNoteCountAfter)
  self.mapNoteCount = mapNoteCount
  self.mapNoteCountAfter = mapNoteCountAfter
  self.tbAllDisc = tbOutfitId
  self.tbDiscId = {}
  for i = 1, 3 do
    table.insert(self.tbDiscId, tbOutfitId[i])
  end
  self.tbShowSkill = {}
  self.mapOriginSkillInfo = PlayerData.Disc:GetDiscSkill(self.tbDiscId, self.mapNoteCount)
  self.mapAfterSkillInfo = PlayerData.Disc:GetDiscSkill(self.tbDiscId, self.mapNoteCountAfter)
  for nGroupId, _ in pairs(self.mapOriginSkillInfo) do
    table.insert(self.tbShowSkill, nGroupId)
  end
  
  local function sort(a, b)
    local mapSkillA = self.mapOriginSkillInfo[a]
    local mapSkillB = self.mapOriginSkillInfo[b]
    if mapSkillA.nCurLevel ~= mapSkillB.nCurLevel then
      return mapSkillA.nCurLevel > mapSkillB.nCurLevel
    else
      return b < a
    end
  end
  
  table.sort(self.tbShowSkill, sort)
  if #self.tbShowSkill == 0 then
    self._mapNode.MusicSkillLSV.gameObject:SetActive(false)
  else
    self._mapNode.MusicSkillLSV.gameObject:SetActive(true)
    self._mapNode.MusicSkillLSV:Init(#self.tbShowSkill, self, self.OnDiscSkillInfoGridRefresh, self.OnDiscSkillInfoGridClick, true)
  end
end

function BuildModifierNoteSkillListCtrl:OnDiscSkillInfoGridRefresh(goGrid, nIdx)
  local nInstanceId = goGrid:GetInstanceID()
  local objCtrl = self.mapGridCtrl[nInstanceId]
  if objCtrl == nil then
    objCtrl = self:BindCtrlByNode(goGrid, "Game.UI.BuildModifier.Note.BuildModifierNoteSkillListGridCtrl")
    self.mapGridCtrl[nInstanceId] = objCtrl
  end
  nIdx = nIdx + 1
  local nId = self.tbShowSkill[nIdx]
  self.mapGridCtrl[nInstanceId]:Refresh(self.mapOriginSkillInfo[nId], self.mapAfterSkillInfo[nId], self.mapNoteCount, self.mapNoteCountAfter)
end

function BuildModifierNoteSkillListCtrl:OnDiscSkillInfoGridClick(goGrid, nIdx)
  local nInstanceId = goGrid:GetInstanceID()
  local objCtrl = self.mapGridCtrl[nInstanceId]
  if objCtrl == nil then
    objCtrl = self:BindCtrlByNode(goGrid, "Game.UI.BuildModifier.Note.BuildModifierNoteSkillListGridCtrl")
    self.mapGridCtrl[nInstanceId] = objCtrl
  end
  nIdx = nIdx + 1
  local nId = self.tbShowSkill[nIdx]
  local nDiscId = self.mapOriginSkillInfo[nId].nDiscId
  local mapDiscData = {}
  for _, nDiscId in pairs(self.tbAllDisc) do
    mapDiscData[nDiscId] = PlayerData.Disc:GetDiscById(nDiscId)
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.DiscSkill, self.tbAllDisc, self.mapNoteCountAfter, mapDiscData, nDiscId)
end

function BuildModifierNoteSkillListCtrl:OnNoteChange()
  self.mapAfterSkillInfo = PlayerData.Disc:GetDiscSkill(self.tbDiscId, self.mapNoteCountAfter)
  if #self.tbShowSkill == 0 then
    self._mapNode.MusicSkillLSV.gameObject:SetActive(false)
  else
    self._mapNode.MusicSkillLSV.gameObject:SetActive(true)
    self._mapNode.MusicSkillLSV:Init(#self.tbShowSkill, self, self.OnDiscSkillInfoGridRefresh, self.OnDiscSkillInfoGridClick, true)
  end
end

return BuildModifierNoteSkillListCtrl
