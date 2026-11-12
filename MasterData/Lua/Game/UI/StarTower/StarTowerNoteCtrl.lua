local StarTowerNoteCtrl = class("StarTowerNoteCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
StarTowerNoteCtrl._mapNodeConfig = {
  contentRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  canvasGroup = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  }
}
StarTowerNoteCtrl._mapEventConfig = {
  RefreshNoteCount = "OnEvent_RefreshNoteCount",
  StarTowerEventInteract = "OnEvent_StarTowerEventInteract",
  InitStarTowerNote = "OnEvent_InitStarTowerNote"
}
StarTowerNoteCtrl._mapRedDotConfig = {}

function StarTowerNoteCtrl:InitPanel()
end

function StarTowerNoteCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.mapNoteCount = {}
end

function StarTowerNoteCtrl:OnEnable()
  self:InitPanel()
end

function StarTowerNoteCtrl:OnEvent_RefreshNoteCount(mapNote, mapChange, mapChangeSecondarySkill, bManual)
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
  self.mapNoteCount = clone(mapNote)
  local tbTips = {}
  if mapChangeSecondarySkill ~= nil then
    for _, v1 in ipairs(mapChangeSecondarySkill) do
      local bShowTips = false
      for _, v2 in ipairs(mapChangeSecondarySkill) do
        if v1.Active == false then
          bShowTips = true
          if v2.Active == true then
            local mapCfg1 = ConfigTable.GetData("SecondarySkill", v1.SecondaryId)
            local mapCfg2 = ConfigTable.GetData("SecondarySkill", v2.SecondaryId)
            if mapCfg1 ~= nil and mapCfg2 ~= nil and mapCfg1.GroupId == mapCfg2.GroupId then
              bShowTips = false
              break
            end
          end
        end
      end
      if bShowTips then
        table.insert(tbTips, {
          nSkillId = v1.SecondaryId,
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
    if not bChange then
      self:AddTimer(1, 0.5, function()
        EventManager.Hit("ShowDiscLoseTips", tbNoteReduceTips)
      end, true, true)
    else
      EventManager.Hit("StarTowerDiscTips", tbNoteReduceTips)
    end
  end
  local tbDiscSkillChange = {}
  local tbDiscSkillAct = {}
  for i = 1, 3 do
    local nDiscId = self._panel.tbDisc[i]
    local discData = self._panel.mapDiscData[nDiscId]
    if discData ~= nil then
      local tbSkill = discData:GetAllSubSkill(self.mapNoteCount)
      if tbSkill ~= nil then
        for _, nSkillId in ipairs(tbSkill) do
          local bSkillChange = false
          local bActive = true
          local changeNoteList = {}
          local mapCfg = ConfigTable.GetData("SecondarySkill", nSkillId)
          if mapCfg ~= nil then
            local tbNote = decodeJson(mapCfg.NeedSubNoteSkills)
            for k, v in pairs(tbNote) do
              local nNoteId = tonumber(k)
              local nNeedCount = tonumber(v)
              if tbChange[nNoteId] ~= nil then
                bSkillChange = true
                changeNoteList[nNoteId] = tbChange[nNoteId]
              end
              local nCount = self.mapNoteCount[nNoteId] or 0
              if nNeedCount > nCount then
                bActive = false
              end
            end
          end
          if bSkillChange then
            table.insert(tbDiscSkillChange, {
              nDiscId = nDiscId,
              nSkillId = nSkillId,
              tbChangeNote = changeNoteList,
              bActive = bActive
            })
          end
        end
      end
      if mapChangeSecondarySkill ~= nil then
        local tbSecondarySkillGroupId = discData.tbSubSkillGroupId
        for _, v in ipairs(tbSecondarySkillGroupId) do
          for _, data in ipairs(mapChangeSecondarySkill) do
            local mapSecSkill = ConfigTable.GetData("SecondarySkill", data.SecondaryId)
            if mapSecSkill ~= nil and data.Active == true and mapSecSkill.GroupId == v then
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
    EventManager.Hit("DiscSkillActive", tbParam)
  end
end

function StarTowerNoteCtrl:OnEvent_StarTowerEventInteract(mapNoteChange, mapItemChange, mapPotentialChange, tbChangeFateCard, mapChangeSecondarySkill)
end

function StarTowerNoteCtrl:OnEvent_InitStarTowerNote(mapNote)
  if mapNote ~= nil then
    self.mapNoteCount = clone(mapNote)
  end
end

return StarTowerNoteCtrl
