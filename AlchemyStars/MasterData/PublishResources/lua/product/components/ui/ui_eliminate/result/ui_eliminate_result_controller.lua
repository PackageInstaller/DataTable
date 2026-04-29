_class("UIEliminateResultController", UIController)
UIEliminateResultController = UIEliminateResultController

function UIEliminateResultController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIEliminateResultController:OnShow(uiParams)
  self._passAll = uiParams[1]
  self:_GetComponents()
  self:_InitComponents()
end

function UIEliminateResultController:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AniPopRoundRes)
end

function UIEliminateResultController:_GetComponents()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._levelTxt = self:GetUIComponent("UILocalizationText", "levelTxt")
  self._roundTxt = self:GetUIComponent("UILocalizationText", "roundTxt")
  self._eliminateTxt = self:GetUIComponent("UILocalizationText", "eliminateTxt")
  self._scoreTxt = self:GetUIComponent("UILocalizationText", "scoreTxt")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._selectItemInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._selectItemInfo = self._selectItemInfoPool:SpawnObject("UISelectInfo")
end

function UIEliminateResultController:_InitComponents()
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local aniPopInfo = anipopModule:GetAniPopInfo()
  local weekInfo = aniPopInfo.week_info
  local roundInfo = aniPopInfo.round_info
  local pass = self._passAll and roundInfo.mission_index or roundInfo.mission_index - 1
  local passLevel = pass .. "/" .. table.count(roundInfo.level_list)
  local curSeason = aniPopInfo.cur_season
  local hardID = roundInfo.select_hard_id
  local missionTeamId = Cfg.cfg_anipop_season[curSeason].MissionTeamId
  self:StartTask(function(TT)
    local res = anipopModule:Balance(TT, aniPopInfo.cur_hard_id)
    if res:GetSucc() then
      self._levelTxt:SetText(passLevel)
      self._roundTxt:SetText(roundInfo.total_use_turn)
      self._eliminateTxt:SetText(roundInfo.total_star_num)
      local scoreHardID = weekInfo.hard_id
      local scoreHardCfg = Cfg.cfg_anipop_hard[scoreHardID]
      local showTotalScore = math.min(weekInfo.total_score, scoreHardCfg.MaxScore)
      self._scoreTxt:SetText(showTotalScore)
      local awardList = {}
      local missionCfgs = Cfg.cfg_anipop_mission({MissionTeamId = missionTeamId, HardId = hardID})
      for i = 1, pass do
        local missionID = roundInfo.level_list[i].level_id
        for _, cfg in pairs(missionCfgs) do
          if table.icontains(cfg.FightLevelArray, missionID) and cfg.ItemId then
            local award = {}
            award.ID = cfg.ItemId
            award.Count = cfg.ItemCount
            table.insert(awardList, award)
            break
          end
        end
      end
      local showAwardList = {}
      local roundTotalAwardNum = roundInfo.local_search_reward_num
      local forNum = 0
      for _, award in pairs(awardList) do
        local itemInfo = {}
        itemInfo.ID = award.ID
        forNum = forNum + award.Count
        if roundTotalAwardNum < forNum then
          local tempNum = roundTotalAwardNum - forNum + award.Count
          if tempNum ~= 0 then
            itemInfo.Count = tempNum
            table.insert(showAwardList, itemInfo)
          end
          break
        elseif roundTotalAwardNum >= forNum then
          itemInfo.Count = award.Count
        end
        table.insert(showAwardList, itemInfo)
      end
      local awards = self._content:SpawnObjects("UIEliminateResultItem", #showAwardList)
      for i, award in pairs(awards) do
        award:SetData(awardList[i], function(id, pos)
          self._selectItemInfo:SetData(id, pos)
        end)
      end
    else
      self:CloseDialog()
      return
    end
  end)
end

function UIEliminateResultController:FullOnClick()
  self:_Close()
end

function UIEliminateResultController:_Close()
  self:StartTask(function(TT)
    self:Lock("uieff_UIEliminateResultController_out")
    self._anim:Play("uieff_UIEliminateResultController_out")
    YIELD(TT, 500)
    self:UnLock("uieff_UIEliminateResultController_out")
    self:CloseDialog()
  end)
end
