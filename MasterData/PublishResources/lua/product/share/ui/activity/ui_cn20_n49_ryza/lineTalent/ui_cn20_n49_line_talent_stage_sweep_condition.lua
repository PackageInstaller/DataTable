_class("UICN20N49LineTalentStageSweepCondition", UICustomWidget)
UICN20N49LineTalentStageSweepCondition = UICN20N49LineTalentStageSweepCondition

function UICN20N49LineTalentStageSweepCondition:OnShow(uiParams)
  self:InitWidget()
end

function UICN20N49LineTalentStageSweepCondition:InitWidget()
  self._conditionsGo = self:GetGameObject("conditionGo")
  self._conditionNo = self:GetGameObject("conditionNo")
  self.conditionsPool = self:GetUIComponent("UISelectObjectPath", "conditions")
end

function UICN20N49LineTalentStageSweepCondition:SetData(missionID, cmpt)
  self._missionID = missionID
  self._cmpt = cmpt
  local cmpInfo = self._cmpt:GetComponentInfo()
  self._missionFinishInfo = cmpInfo.m_pass_mission_info[missionID]
  self._module = self:GetModule(MissionModule)
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  self:Flush(missionCfg)
end

function UICN20N49LineTalentStageSweepCondition:Flush(missionCfg)
  local sweepConditions = {}
  local ids = {0}
  for i, v in ipairs(ids) do
    local cond = StageCondition:New()
    cond.id = v
    cond.content = StringTable.Get("str_cn20_line_talent_sweep_condition")
    local isPass = false
    if self._missionFinishInfo then
      isPass = true
    end
    cond:FlushSatisfy(isPass)
    table.insert(sweepConditions, cond)
  end
  if 0 < #sweepConditions then
    self._conditionsGo:SetActive(true)
    self._conditionNo:SetActive(false)
    self.conditionsPool:SpawnObjects("UIConditionItem", #sweepConditions)
    self._conditionWidgets = self.conditionsPool:GetAllSpawnList()
    for i, v in ipairs(self._conditionWidgets) do
      v:Flush(sweepConditions[i], i)
    end
  else
    self._conditionsGo:SetActive(false)
    self._conditionNo:SetActive(true)
  end
end

function UICN20N49LineTalentStageSweepCondition:SweepTipsBtnOnClick(go)
  self:ShowDialog("UICN20N49SweepConditionTips")
end
