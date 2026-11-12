local TrialDepotPanel = class("TrialDepotPanel", BasePanel)
TrialDepotPanel._bIsMainPanel = false
TrialDepotPanel._tbDefine = {
  {
    sPrefabPath = "Play_TrialBattle/TrialDepotPanel.prefab",
    sCtrlName = "Game.UI.TrialBattle.TrialDepotCtrl"
  }
}

function TrialDepotPanel:Awake()
  self.tbTeam = self._tbParam[1]
  self.tbDisc = self._tbParam[2]
  self.mapCharData = self._tbParam[3]
  self.mapDiscData = self._tbParam[4]
  self.mapPotentialAddLevel = self._tbParam[5]
  self.mapPotential = self._tbParam[6]
  self.mapNote = self._tbParam[7]
  self.bBattle = self._tbParam[8]
  self.mapNoteNeed = {}
  for nIndex, nDiscId in ipairs(self.tbDisc) do
    if 3 < nIndex then
      break
    end
    local mapDiscData = self.mapDiscData[nDiscId]
    if mapDiscData ~= nil then
      local tbNeedNote = mapDiscData.tbSkillNeedNote
      for _, mapNeedNote in ipairs(tbNeedNote) do
        if self.mapNoteNeed[mapNeedNote.nId] == nil then
          self.mapNoteNeed[mapNeedNote.nId] = 0
        end
        self.mapNoteNeed[mapNeedNote.nId] = self.mapNoteNeed[mapNeedNote.nId] + mapNeedNote.nCount
      end
    end
  end
end

function TrialDepotPanel:OnEnable()
end

function TrialDepotPanel:OnAfterEnter()
end

function TrialDepotPanel:OnDisable()
end

function TrialDepotPanel:GetSkillLevel(nCharId)
  local mapChar = self.mapCharData[nCharId]
  local tbList = {}
  tbList[GameEnum.skillSlotType.NORMAL] = mapChar and mapChar.tbSkillLvs[1] or 1
  tbList[GameEnum.skillSlotType.B] = mapChar and mapChar.tbSkillLvs[2] or 1
  tbList[GameEnum.skillSlotType.C] = mapChar and mapChar.tbSkillLvs[3] or 1
  tbList[GameEnum.skillSlotType.D] = mapChar and mapChar.tbSkillLvs[4] or 1
  return tbList
end

return TrialDepotPanel
