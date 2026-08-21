_class("UISeasonOnceMissionStageCondition", UICustomWidget)
UISeasonOnceMissionStageCondition = UISeasonOnceMissionStageCondition

function UISeasonOnceMissionStageCondition:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonOnceMissionStageCondition:InitWidget()
  self._conditionsGo = self:GetGameObject("conditionGo")
  self._conditionNo = self:GetGameObject("conditionNo")
  self.conditionsPool = self:GetUIComponent("UISelectObjectPath", "conditions")
end

function UISeasonOnceMissionStageCondition:SetData(missionID, onceMissionData, cmpt)
  self._missionID = missionID
  self._onceMissionData = onceMissionData
  self._cmpt = cmpt
  local cmpInfo = self._cmpt:GetComponentInfo()
  self._missionFinishInfo = cmpInfo.m_pass_mission_info[missionID]
  self._module = self:GetModule(MissionModule)
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  self:Flush(missionCfg)
end

function UISeasonOnceMissionStageCondition:Flush(missionCfg)
  local threeStarConditions = {}
  if missionCfg.IgnoreThreeStar == 0 then
    local ids = {
      missionCfg.ThreeStarCondition1,
      missionCfg.ThreeStarCondition2,
      missionCfg.ThreeStarCondition3
    }
    for i, v in ipairs(ids) do
      local cond = StageCondition:New()
      cond:Init(i, v)
      table.insert(threeStarConditions, cond)
    end
    if self._missionFinishInfo then
      local starCount, completeStarList = self._module:ParseStarInfo(self._missionFinishInfo.star)
      self:UpdateCondition(threeStarConditions, completeStarList)
    end
  end
  if not missionCfg.ThreeStarCondition3 then
    self._conditionsGo:SetActive(false)
    self._conditionNo:SetActive(true)
  elseif 0 < #threeStarConditions then
    self._conditionsGo:SetActive(true)
    self._conditionNo:SetActive(false)
    self.conditionsPool:SpawnObjects("UIConditionItem", #threeStarConditions)
    self._conditionWidgets = self.conditionsPool:GetAllSpawnList()
    for i, v in ipairs(self._conditionWidgets) do
      v:Flush(threeStarConditions[i], i)
    end
  else
    self._conditionsGo:SetActive(false)
    self._conditionNo:SetActive(true)
  end
end

function UISeasonOnceMissionStageCondition:UpdateCondition(three_star_condition, conditions)
  local l_cur_star_num = 0
  for index, value in ipairs(three_star_condition) do
    if value.satisfy == true then
      l_cur_star_num = l_cur_star_num + 1
    end
  end
  local l_finish_star_num = #conditions
  for index, value in ipairs(three_star_condition) do
    if l_finish_star_num == l_cur_star_num then
      value:FlushSatisfy(false)
    end
    for i, v in ipairs(conditions) do
      if v == index then
        value:FlushSatisfy(true)
      end
    end
  end
end

function UISeasonOnceMissionStageCondition:ThreeStarTipsBtnOnClick(go)
  self:ShowDialog("UIThreeStarTips")
end
