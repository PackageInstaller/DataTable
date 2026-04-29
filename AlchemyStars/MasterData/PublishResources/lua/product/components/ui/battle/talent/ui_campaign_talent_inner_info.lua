_class("UICampaignTalentInnerInfo", UIController)
UICampaignTalentInnerInfo = UICampaignTalentInnerInfo

function UICampaignTalentInnerInfo:LoadDataOnEnter(TT, res, uiParams)
  local serialautofightmodule = self:GetModule(SerialAutoFightModule)
  local running = serialautofightmodule:IsRunning()
  if running then
    res:SetSucc(false)
  else
    res:SetSucc(true)
  end
end

function UICampaignTalentInnerInfo:OnShow(uiParams)
  self._detailContentText = self:GetUIComponent("UILocalizationText", "DetailContent")
  self._titleText = self:GetUIComponent("UILocalizationText", "Title")
  local match = self:GetModule(MatchModule)
  local matchEnterData = match:GetMatchEnterData()
  local campaignMissionInfo = matchEnterData:GetCampaignMissionInfo()
  if not campaignMissionInfo then
    return
  end
  local talentIDList = campaignMissionInfo.mTalentTreeSkills
  if not talentIDList then
    return
  end
  local attack = 0
  local defense = 0
  local hp = 0
  local recoverPoint = 0
  local pointMax = 0
  local skillIncrease = 0
  local slotStrInfoList = {}
  for index, value in ipairs(talentIDList) do
    local cfgGroup = Cfg.cfg_component_talent_tree_skill({SkillID = value})
    if cfgGroup and 0 < #cfgGroup then
      local cfg = cfgGroup[1]
      if cfg.Type == TalentTreeSkillType.TTST_Skill_Main then
        if cfg.Attack then
          attack = attack + cfg.Attack
        end
        if cfg.Defense then
          defense = defense + cfg.Defense
        end
        if cfg.HP then
          hp = hp + cfg.HP
        end
        if cfg.Point then
          recoverPoint = recoverPoint + cfg.Point
        end
        if cfg.PointMax then
          pointMax = pointMax + cfg.PointMax
        end
        if cfg.activeskill then
          skillIncrease = skillIncrease + cfg.activeskill
        end
      elseif cfg.Type == TalentTreeSkillType.TTST_Skill_Common then
        local innerCfg = Cfg.cfg_battle_talent[value]
        if innerCfg then
          local desc = innerCfg.Desc
          if desc then
            table.insert(slotStrInfoList, desc)
          end
        end
      elseif cfg.Type == TalentTreeSkillType.TTST_Skill_Pet then
      end
    end
  end
  local tempStr = ""
  tempStr = tempStr .. "<size=34><b>" .. StringTable.Get("str_battle_talent_small_title_01") .. "\n" .. "</b></size>"
  tempStr = tempStr .. "<size=28>"
  if 0 < #slotStrInfoList then
    for index, str in ipairs(slotStrInfoList) do
      tempStr = tempStr .. "-" .. StringTable.Get(str) .. "\n"
    end
  end
  tempStr = tempStr .. "<size=10>" .. "\n" .. "</size>"
  tempStr = tempStr .. "</size>"
  tempStr = tempStr .. "<size=34><b>" .. StringTable.Get("str_battle_talent_small_title_02") .. "\n" .. "</b></size>"
  tempStr = tempStr .. "<size=28>"
  if 0 < attack then
    tempStr = tempStr .. "-" .. StringTable.Get("str_season_talent_tree_desc_101", tostring(attack)) .. "\n"
  end
  if 0 < defense then
    tempStr = tempStr .. "-" .. StringTable.Get("str_season_talent_tree_desc_102", tostring(defense)) .. "\n"
  end
  if 0 < hp then
    tempStr = tempStr .. "-" .. StringTable.Get("str_season_talent_tree_desc_103", tostring(hp)) .. "\n"
  end
  if 0 < recoverPoint then
    tempStr = tempStr .. "-" .. StringTable.Get("str_season_talent_tree_desc_104", tostring(recoverPoint)) .. "\n"
  end
  if 0 < pointMax then
    tempStr = tempStr .. "-" .. StringTable.Get("str_season_talent_tree_desc_105", tostring(pointMax)) .. "\n"
  end
  if 0 < skillIncrease then
    tempStr = tempStr .. "-" .. StringTable.Get("str_season_talent_tree_desc_106", tostring(skillIncrease)) .. "\n"
  end
  tempStr = tempStr .. "</size>"
  self._detailContentText:SetText(tempStr)
end

function UICampaignTalentInnerInfo:FullScreenBtnOnClick(go)
  self:CloseDialog()
end
