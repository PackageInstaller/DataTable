local TutorialNoteCtrl = class("TutorialNoteCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
TutorialNoteCtrl._mapNodeConfig = {
  contentRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  canvasGroup = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  }
}
TutorialNoteCtrl._mapEventConfig = {
  RefreshNoteCount = "OnEvent_RefreshNoteCount"
}
TutorialNoteCtrl._mapRedDotConfig = {}

function TutorialNoteCtrl:InitPanel()
  self.tbDiscSubSkill = {}
  if nil == self._panel.tbDisc then
    return
  end
  for k, nId in ipairs(self._panel.tbDisc) do
    if k <= 3 then
      local discData = self._panel.mapDiscData[nId]
      if 0 ~= nId and discData ~= nil then
        self.tbDiscSubSkill[nId] = {}
        local tbSubSkillId = discData:GetAllSubSkill(self.mapNoteCount)
        for _, nSubSkillId in ipairs(tbSubSkillId) do
          self.tbDiscSubSkill[nId][nSubSkillId] = {}
          local mapCfg = ConfigTable.GetData("SecondarySkill", nSubSkillId)
          if mapCfg ~= nil then
            local tbActiveNote = decodeJson(mapCfg.NeedSubNoteSkills)
            for k, v in pairs(tbActiveNote) do
              local nNoteId = tonumber(k)
              local nNoteCount = tonumber(v)
              self.tbDiscSubSkill[nId][nSubSkillId][nNoteId] = {nNeed = nNoteCount, nCur = 0}
            end
          end
        end
      end
    end
  end
end

function TutorialNoteCtrl:GetChangeDiscSkillList(mapNoteChange)
  local tbChangeDiscSkill = {}
  for nDiscId, discData in pairs(self.tbDiscSubSkill) do
    for nSkillId, v in pairs(discData) do
      local bChange = false
      local changeNoteList = {}
      for nNoteId, data in pairs(v) do
        if mapNoteChange[nNoteId] ~= nil then
          local nCount = mapNoteChange[nNoteId].nCount
          local bLucky = mapNoteChange[nNoteId].bLucky
          if data.nCur < data.nNeed then
            changeNoteList[nNoteId] = {
              nChangeCount = nCount,
              nNeed = data.nNeed,
              bLucky = bLucky
            }
            bChange = true
          end
          data.nCur = data.nCur + nCount
        end
      end
      if bChange then
        table.insert(tbChangeDiscSkill, {
          nDiscId = nDiscId,
          nSkillId = nSkillId,
          tbChangeNote = changeNoteList
        })
      end
    end
  end
  return tbChangeDiscSkill
end

function TutorialNoteCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.mapNoteCount = {}
end

function TutorialNoteCtrl:OnEnable()
  self:InitPanel()
end

function TutorialNoteCtrl:OnEvent_RefreshNoteCount(mapNote, mapChange, mapChangeSecondarySkill, bManual)
  local tbChange = {}
  local tbLose = {}
  local bChange = false
  if next(self.mapNoteCount) == nil then
    for k, v in pairs(mapNote) do
      if 0 < v then
        bChange = true
        tbChange[k] = {nCount = v, bLucky = false}
      end
    end
  else
    for k, v in pairs(mapNote) do
      local nLastCount = self.mapNoteCount[k] or 0
      if v > nLastCount then
        local bLucky = false
        if mapChange ~= nil and mapChange[k] ~= nil and 0 < mapChange[k].LuckyLevel then
          bLucky = true
        end
        bChange = true
        tbChange[k] = {
          nCount = v - nLastCount,
          bLucky = bLucky
        }
      elseif v < nLastCount then
        tbLose[k] = {
          nCount = v - nLastCount
        }
      end
    end
  end
  local tbTips = {}
  if mapChangeSecondarySkill ~= nil then
    for _, v in ipairs(mapChangeSecondarySkill) do
      if v.Active == false then
        table.insert(tbTips, {
          nSkillId = v.SecondaryId,
          nTipType = AllEnum.StarTowerTipsType.DiscTip
        })
      end
    end
  end
  if 0 < #tbTips then
    EventManager.Hit("StarTowerDiscTips", tbTips)
  end
  local tbNoteReduceTips = {}
  for nNoteId, data in pairs(tbLose) do
    local nCount = math.abs(data.nCount)
    table.insert(tbNoteReduceTips, {
      nNoteId = nNoteId,
      nCount = nCount,
      nTipType = AllEnum.StarTowerTipsType.NoteTip
    })
  end
  if 0 < #tbNoteReduceTips then
    EventManager.Hit("StarTowerDiscTips", tbNoteReduceTips)
  end
  local tbDiscSkillChange = self:GetChangeDiscSkillList(tbChange)
  local tbDiscSkillAct = {}
  for i = 1, 3 do
    local nDiscId = self._panel.tbDisc[i]
    local discData = self._panel.mapDiscData[nDiscId]
    if discData ~= nil and mapChangeSecondarySkill ~= nil then
      local tbSecondarySkills = discData:GetAllSubSkill(self.mapNoteCount)
      for _, v in ipairs(tbSecondarySkills) do
        for _, data in ipairs(mapChangeSecondarySkill) do
          if data.Active == true and data.SecondaryId == v then
            table.insert(tbDiscSkillAct, {
              nDiscId = nDiscId,
              nSkillId = data.SecondaryId
            })
            break
          end
        end
      end
    end
  end
  if bChange and not bManual then
    table.sort(tbDiscSkillChange, function(a, b)
      return a.nSkillId < b.nSkillId
    end)
    local tbParam = {
      tbSkill = tbDiscSkillChange,
      tbNoteChange = tbChange,
      tbDiscSkillAct = tbDiscSkillAct
    }
    EventManager.Hit("StarTowerShowDiscSkill", tbParam, clone(mapNote))
  end
  self.mapNoteCount = clone(mapNote)
end

return TutorialNoteCtrl
