local DepotNoteCtrl = class("DepotNoteCtrl", BaseCtrl)
DepotNoteCtrl._mapNodeConfig = {
  goDiscNoteItem = {
    nCount = 5,
    sCtrlName = "Game.UI.StarTower.Note.NoteCountItemCtrl"
  },
  btnDiscItem = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_DiscItem"
  },
  goDiscItem = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateDiscItemCtrl"
  },
  btnPassiveSkill = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_PassiveSkill"
  },
  ctrlPassiveSkill = {
    nCount = 3,
    sNodeName = "btnPassiveSkill",
    sCtrlName = "Game.UI.StarTower.Depot.DepotDiscSkillItemCtrl"
  },
  btnCommonSkill1_ = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Common1"
  },
  ctrlCommonSkill1_ = {
    nCount = 2,
    sNodeName = "btnCommonSkill1_",
    sCtrlName = "Game.UI.StarTower.Depot.DepotDiscSkillItemCtrl"
  },
  btnCommonSkill2_ = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Common2"
  },
  ctrlCommonSkill2_ = {
    nCount = 2,
    sNodeName = "btnCommonSkill2_",
    sCtrlName = "Game.UI.StarTower.Depot.DepotDiscSkillItemCtrl"
  },
  btnCommonSkill3_ = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Common3"
  },
  ctrlCommonSkill3_ = {
    nCount = 2,
    sNodeName = "btnCommonSkill3_",
    sCtrlName = "Game.UI.StarTower.Depot.DepotDiscSkillItemCtrl"
  }
}
DepotNoteCtrl._mapEventConfig = {}
DepotNoteCtrl._mapRedDotConfig = {}

function DepotNoteCtrl:InitDisc()
  for k, nId in ipairs(self._panel.tbDisc) do
    local mapDisc = self._panel.mapDiscData[nId]
    if mapDisc ~= nil then
      self._mapNode.goDiscItem[k]:Refresh(nId, mapDisc.nStar, mapDisc.nMaxStar, mapDisc.nLevel, mapDisc.tbShowNote)
    end
  end
end

function DepotNoteCtrl:RefreshNoteList(tbNoteList)
  if self.bInit then
    return
  end
  self.bInit = true
  self.tbPassiveSkill = {}
  self.tbCommomSkill = {}
  self.tbNoteList = tbNoteList
  for k, v in ipairs(self._mapNode.goDiscNoteItem) do
    local nNoteId = self._panel.tbShowNote[k]
    local nCount = tbNoteList[nNoteId] or 0
    v:Init(nCount)
  end
  for k, nId in ipairs(self._panel.tbDisc) do
    local discData = self._panel.mapDiscData[nId]
    self._mapNode.ctrlPassiveSkill[k]:SetNone()
    for i = 1, 2 do
      self._mapNode["ctrlCommonSkill" .. k .. "_"][i]:SetNone()
    end
    if discData then
      if discData.nPassiveSkillId then
        local mapPassiveCfg = ConfigTable.GetData("DiscPassiveSkill", discData.nPassiveSkillId)
        if mapPassiveCfg then
          local nCurLayer = discData:GetPassiveLayer(tbNoteList, mapPassiveCfg)
          local mapData = {
            nType = AllEnum.DiscSkillType.Passive,
            nId = discData.nPassiveSkillId,
            nLevel = nCurLayer,
            nMaxLevel = discData.nPassiveSkillMaxLayer
          }
          self._mapNode.ctrlPassiveSkill[k]:InitDiscSkill(mapData)
          self.tbPassiveSkill[k] = mapData
        end
      end
      for i, nCommonSkillId in ipairs(discData.tbCommonSkillId) do
        if nCommonSkillId then
          local mapCommonCfg = ConfigTable.GetData("DiscCommonSkill", nCommonSkillId)
          if mapCommonCfg then
            local nCurLayer = discData:GetCommonLayer(tbNoteList, mapCommonCfg)
            local mapData = {
              nType = AllEnum.DiscSkillType.Common,
              nId = nCommonSkillId,
              nLevel = nCurLayer,
              nMaxLevel = #mapCommonCfg.ActiveNoteNum
            }
            self._mapNode["ctrlCommonSkill" .. k .. "_"][i]:InitDiscSkill(mapData)
            if not self.tbCommomSkill[k] then
              self.tbCommomSkill[k] = {}
            end
            self.tbCommomSkill[k][i] = mapData
          end
        end
      end
    end
  end
end

function DepotNoteCtrl:OpenTips(mapSelect, btn)
  if not mapSelect then
    return
  end
  local mapData = {
    nType = mapSelect.nType,
    nSkillId = mapSelect.nId,
    nLevel = mapSelect.nLevel,
    nMaxLevel = mapSelect.nMaxLevel
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.DiscSkillTips, btn.transform, mapData)
end

function DepotNoteCtrl:Clear()
  self.bInit = false
end

function DepotNoteCtrl:Awake()
  self.bInit = false
end

function DepotNoteCtrl:OnEnable()
  for k, v in ipairs(self._panel.tbShowNote) do
    if nil ~= self._mapNode.goDiscNoteItem[k] then
      self._mapNode.goDiscNoteItem[k]:InitNote(v)
    end
  end
  self:InitDisc()
end

function DepotNoteCtrl:OnDisable()
end

function DepotNoteCtrl:OnDestroy()
end

function DepotNoteCtrl:OnRelease()
end

function DepotNoteCtrl:OnBtnClick_PassiveSkill(btn, nIndex)
  self:OpenTips(self.tbPassiveSkill[nIndex], btn)
end

function DepotNoteCtrl:OnBtnClick_Common1(btn, nIndex)
  self:OpenTips(self.tbCommomSkill[1][nIndex], btn)
end

function DepotNoteCtrl:OnBtnClick_Common2(btn, nIndex)
  self:OpenTips(self.tbCommomSkill[2][nIndex], btn)
end

function DepotNoteCtrl:OnBtnClick_Common3(btn, nIndex)
  self:OpenTips(self.tbCommomSkill[3][nIndex], btn)
end

return DepotNoteCtrl
