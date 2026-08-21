require("ui_season_maze_campsites_base")
_class("UISeasonMaze_Campsites_Medical", UISeasonMaze_Campsites_Base)
UISeasonMaze_Campsites_Medical = UISeasonMaze_Campsites_Medical

function UISeasonMaze_Campsites_Medical:OnShowUI(uiParams)
  self:InitWidget()
  self:Refresh()
end

function UISeasonMaze_Campsites_Medical:OnHide()
end

function UISeasonMaze_Campsites_Medical:InitWidget()
  self._txtCost = self:GetUIComponent("UILocalizationText", "txtCost")
  self._txtTimes = self:GetUIComponent("UILocalizationText", "txtTimes")
  local moneyPool = self:GetUIComponent("UISelectObjectPath", "money")
  self._moneyTopIcon = moneyPool:SpawnObject("UISeasonMaze_Campsites_Medical_Money")
  local tipsRect = self:GetUIComponent("RectTransform", "moneyTipsPos")
  self._moneyTipsPos = tipsRect.anchoredPosition
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UISeasonMaze_Campsites_Medical:Refresh()
  local goldCount = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local hasCureTimes = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_HealthyCnt)
  local currentTimes = hasCureTimes + 1
  local cfg = self._cfg_global.CureCount
  local cost = 0
  if cfg then
    if currentTimes > #cfg then
      cost = cfg[#cfg]
    else
      cost = cfg[currentTimes]
    end
  end
  self._bCostEnough = true
  self._txtTimes:SetText(StringTable.Get("str_season_maze_camp_med_room_count", hasCureTimes))
  if goldCount < cost then
    self._txtCost:SetText("<color=#fe0000>" .. cost .. "</color>")
    self._bCostEnough = false
  else
    self._txtCost:SetText(cost)
  end
  local str = self._cfg_global.CurePercent
  self._confirmDesc = StringTable.Get("str_season_maze_camp_med_heal_cost_desc", cost, str)
  self._moneyTopIcon:SetData(goldCount, function()
    local itemId = 9001002
    self:ShowDialog("UITopTipsController", itemId, self._moneyTipsPos)
  end)
end

function UISeasonMaze_Campsites_Medical:BtnOnClick(go)
  if not self:_HasHurtPet() then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_camp_med_fail_5006510"))
    return
  end
  if not self._bCostEnough then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_camp_med_fail_2"))
    return
  end
  UISeasonMazeModule.PopMsgBox(StringTable.Get("str_season_maze_camp_tips"), self._confirmDesc, SeasonMazeMsgBoxType.OkCancel, function()
    self:OnMedicalSure()
  end)
end

function UISeasonMaze_Campsites_Medical:_HasHurtPet()
  local petInfos = self._com:GetComponentInfo().m_bag_info.pet_list
  if not petInfos then
    return
  end
  for key, value in pairs(petInfos) do
    if value.cur_blood_prcent > 0 and value.cur_blood_prcent < 1 then
      return true
    end
  end
end

function UISeasonMaze_Campsites_Medical:CloseBtnOnClick(go)
  self._animation:Play("uieffanim_UISeasonMaze_Campsites_Life_out")
  self:Lock("UISeasonMaze_Campsites_Medical_out")
  self:StartTask(function(TT)
    YIELD(TT, 500)
    self:UnLock("UISeasonMaze_Campsites_Medical_out")
    self:CloseDialog()
  end)
end

function UISeasonMaze_Campsites_Medical:OnMedicalSure()
  self:Lock("UISeasonMaze_Campsites_Medical:OnMedicalSure")
  GameGlobal.TaskManager():StartTask(self.OnMedicalSureReq, self)
end

function UISeasonMaze_Campsites_Medical:OnMedicalSureReq(TT)
  local res = AsyncRequestRes:New()
  self._com:HandleSeasonMazeCure(TT, res)
  self:UnLock("UISeasonMaze_Campsites_Medical:OnMedicalSure")
  if res:GetSucc() then
    self:Refresh()
    ToastManager.ShowToast(StringTable.Get("str_season_maze_camp_med_succ"))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Gold)
  else
    local result = res:GetResult()
    if result == CampaignErrorType.E_COMPONENT_SEASON_MAZE_AllPetFullBlood then
      local tips = StringTable.Get("str_season_maze_camp_med_fail_5006510")
      ToastManager.ShowToast(tips)
    else
      Log.error("###[UISeasonMaze_Campsites_Medical] HandleSeasonMazeCure fail! result:", result)
      if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
        return
      end
    end
  end
end
