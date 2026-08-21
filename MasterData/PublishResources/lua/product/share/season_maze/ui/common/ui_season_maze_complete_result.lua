_class("UISeasonMazeCompleteResult", UIController)
UISeasonMazeCompleteResult = UISeasonMazeCompleteResult

function UISeasonMazeCompleteResult:OnShow(uiParams)
  self.callback = uiParams[1]
  self.success = uiParams[2]
  self:InitWidget()
  self:OnValue()
end

function UISeasonMazeCompleteResult:InitWidget()
  self._level = self:GetUIComponent("UILocalizationText", "level")
  self._round = self:GetUIComponent("UILocalizationText", "round")
  self._map = self:GetUIComponent("UILocalizationText", "map")
  self._percent = self:GetUIComponent("UILocalizationText", "percent")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._head = self:GetUIComponent("RawImageLoader", "Head")
  self._headbg = self:GetUIComponent("UICircleMaskLoader", "headbg")
  self._itemObj = self:GetGameObject("item")
  self._formTrans = self:GetUIComponent("Transform", "form")
  self._total = self:GetUIComponent("UILocalizationText", "total")
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._signConfirmObj = self:GetGameObject("confirm")
  self._signAfterObj = self:GetGameObject("after")
  self._signAnim = self:GetUIComponent("Animation", "sign")
end

function UISeasonMazeCompleteResult:OnValue()
  self.signed = false
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._componentInfo = self._component:GetComponentInfo()
  self:InitCfg()
  self:InitCourse()
  self:InitTask()
  self:InitSign()
end

function UISeasonMazeCompleteResult:ClearData(TT)
  local cpt = self._component
  local res = AsyncRequestRes:New()
  cpt:HandleSeasonMazeClearing(TT, res)
  if res:GetSucc() then
    self:UnLock("UISeasonMazeEnterController:StopMazeBtnOnClick")
    LocalDB.Delete("UISeasonMazeEnterController_Enter_Game_New")
  else
    self:UnLock("UISeasonMazeEnterController:StopMazeBtnOnClick")
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeCompleteResult:InitCfg()
  local bossInfos = self._componentInfo.boss_info
  self.bossPass = 0
  self.bossCnt = table.count(bossInfos)
  for i = 0, self.bossCnt - 1 do
    local info = bossInfos[i]
    if info.do_cnt ~= -1 then
      break
    end
    self.bossPass = self.bossPass + 1
  end
  local hardLevel = self._componentInfo.hard
  self.seasonMazeCfg = self:GetSeasonMazeCfg(hardLevel)
end

function UISeasonMazeCompleteResult:GetSeasonMazeCfg(hardLevel)
  local cfgs = Cfg.cfg_component_season_maze({
    ComponentID = self.cmptId
  })
  if cfgs and table.count(cfgs) > 0 then
    for _, v in pairs(cfgs) do
      if v.Hard == hardLevel then
        return v
      end
    end
  end
  return nil
end

function UISeasonMazeCompleteResult:InitCourse()
  self._level:SetText(self._componentInfo.hard)
  self._round:SetText(table.count(self._componentInfo.round_num))
  self._map:SetText(self._componentInfo.do_layer_num)
  self._percent:SetText(math.floor(self.bossPass / self.bossCnt * 100) .. "%")
end

function UISeasonMazeCompleteResult:InitTask()
  local totalScore = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Score)
  for i = 1, self.bossPass do
    local rewardID = self.seasonMazeCfg.BossReward[i]
    local rewardCfg = Cfg.cfg_component_season_maze_mission_reward[rewardID]
    if rewardCfg then
      local item = UnityEngine.GameObject.Instantiate(self._itemObj, self._formTrans)
      local countText = item.gameObject.transform:Find("left/count"):GetComponent("UILocalizationText")
      local descText = item.gameObject.transform:Find("left/desc"):GetComponent("UILocalizationText")
      descText:SetText(StringTable.Get("str_season_maze_result_scores_tips", i))
      for _, id in ipairs(rewardCfg.EffectIDs) do
        local cfgs = Cfg.cfg_component_season_maze_effect({ID = id})
        if cfgs and 0 < #cfgs then
          local cfg = cfgs[1]
          for _, eff in pairs(cfg.EffectList) do
            if eff[2] == SeasonMazeAttrType.SMAT_Score then
              local score = eff[3]
              countText:SetText(score)
              item:SetActive(true)
              break
            end
          end
        end
      end
    end
  end
  self.success = self.bossPass == self.bossCnt
  if self.success then
    self._desc:SetText(StringTable.Get("str_season_maze_complete_result_4"))
  else
    self._desc:SetText(StringTable.Get("str_season_maze_complete_result_" .. self.bossPass))
  end
  if self.success then
    local hardInfo = self._componentInfo.hard_num[self._componentInfo.hard]
    if hardInfo then
      local count = hardInfo.vic_count + 1
      local smCfg = self:GetSeasonMazeCfg(self._componentInfo.hard)
      for _, v in pairs(smCfg.ClearingScore) do
        if v[1] == count then
          local item = UnityEngine.GameObject.Instantiate(self._itemObj, self._formTrans)
          local countText = item.gameObject.transform:Find("left/count"):GetComponent("UILocalizationText")
          local descText = item.gameObject.transform:Find("left/desc"):GetComponent("UILocalizationText")
          local cfgs = Cfg.cfg_component_season_maze_effect({
            ID = v[2]
          })
          descText:SetText(StringTable.Get("str_season_maze_special_score_task_content", self._componentInfo.hard, count))
          if cfgs and 0 < #cfgs then
            local cfg = cfgs[1]
            local score = cfg.EffectList[1][3]
            totalScore = totalScore + score
            countText:SetText(score)
          end
          item:SetActive(true)
        end
      end
    end
  end
  self._total:SetText(StringTable.Get("str_season_maze_complete_result_score", totalScore))
end

function UISeasonMazeCompleteResult:GetSeasonMazeCfg(hardLevel)
  local cfgs = Cfg.cfg_component_season_maze({
    ComponentID = self.cmptId
  })
  if cfgs and table.count(cfgs) > 0 then
    for _, v in pairs(cfgs) do
      if v.Hard == hardLevel then
        return v
      end
    end
  end
  return nil
end

function UISeasonMazeCompleteResult:InitSign()
  local roleModule = self:GetModule(RoleModule)
  local playerInfo = roleModule:UI_GetPlayerInfo()
  local headid = playerInfo.m_nHeadImageID
  local cfg_head = IsInland and Cfg.cfg_item_head[headid] or Cfg.cfg_role_head_image[headid]
  self._head:LoadImage(cfg_head.Icon)
  local headbgid = playerInfo.m_nHeadColorID
  local cfg_head_bg = Cfg.cfg_player_head_bg[headbgid]
  if cfg_head_bg == nil then
    Log.debug("###playerinfo - cfg_player_head_bg is nil ! id ", headbgid)
    local bid = HelperProxy:GetInstance():GetHeadBgDefaultID()
    cfg_head_bg = Cfg.cfg_player_head_bg[bid]
  end
  self._headbg:LoadImage(cfg_head_bg.Icon)
  local name = playerInfo.m_stRoleName
  self._name:SetText(name)
end

function UISeasonMazeCompleteResult:SignBtnOnClick()
  if self.signed then
    return
  end
  self.signed = true
  self._signConfirmObj:SetActive(false)
  self._signAfterObj:SetActive(true)
  self._signAnim:Play("uieff_UISeasonMazeCompleteResult_name")
  self:StartTask(function(TT)
    self:Lock("UISeasonMazeCompleteResult:SignBtnOnClick")
    self:ClearData(TT)
    YIELD(TT, 2000)
    if self.callback then
      self.callback()
    end
    self:UnLock("UISeasonMazeCompleteResult:SignBtnOnClick")
    if GameGlobal.GetModule(SeasonMazeModule):UIModule():IsRunning() then
      GameGlobal.GetModule(SeasonMazeModule):UIModule():ExitTo(UIStateType.UISeasonMazeMain)
    else
      self:CloseDialog()
      self:SwitchState(UIStateType.UISeasonMazeMain)
    end
  end)
end

function UISeasonMazeCompleteResult:BackpackBtnOnClick()
  self:ShowDialog("UISeasonMazeBackPackController", 2)
end
