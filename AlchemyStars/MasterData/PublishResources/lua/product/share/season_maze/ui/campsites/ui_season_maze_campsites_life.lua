require("ui_season_maze_campsites_base")
_class("UISeasonMaze_Campsites_Life", UISeasonMaze_Campsites_Base)
UISeasonMaze_Campsites_Life = UISeasonMaze_Campsites_Life

function UISeasonMaze_Campsites_Life:OnShowUI(uiParams)
  self:InitWidget()
  self:Refresh()
end

function UISeasonMaze_Campsites_Life:OnHide()
end

function UISeasonMaze_Campsites_Life:InitWidget()
  self._txtCost = self:GetUIComponent("UILocalizationText", "txtCost")
  self._txtTimes = self:GetUIComponent("UILocalizationText", "txtTimes")
  local moneyPool = self:GetUIComponent("UISelectObjectPath", "money")
  self._moneyTopIcon = moneyPool:SpawnObject("UISeasonMaze_Campsites_Medical_Money")
  local tipsRect = self:GetUIComponent("RectTransform", "moneyTipsPos")
  self._moneyTipsPos = tipsRect.anchoredPosition
  self._animation = self:GetUIComponent("Animation", "animation")
  self._maskCanotReviveGo = self:GetGameObject("maskCanotRevive")
  self._canotReviveGo = self:GetGameObject("canotRevive")
end

function UISeasonMaze_Campsites_Life:Refresh()
  local goldCount = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local hasReViveTimes = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_ResurrectCnt)
  local currentTimes = hasReViveTimes + 1
  local cfg = self._cfg_global.ReviveCount
  local cost = 0
  if cfg then
    if currentTimes > #cfg then
      cost = cfg[#cfg]
    else
      cost = cfg[currentTimes]
    end
  end
  self._cost = cost
  self._txtTimes:SetText(StringTable.Get("str_season_maze_camp_life_room_count", hasReViveTimes))
  if goldCount < cost then
    self._txtCost:SetText("<color=#fe0000>" .. cost .. "</color>")
  else
    self._txtCost:SetText(cost)
  end
  self._moneyTopIcon:SetData(goldCount, function()
    local itemId = 9001002
    self:ShowDialog("UITopTipsController", itemId, self._moneyTipsPos)
  end)
  self._needRevive = false
  local petInfos = self._com:GetComponentInfo().m_bag_info.pet_list
  for key, value in pairs(petInfos) do
    if 0 >= value.cur_blood_prcent then
      self._needRevive = true
      break
    end
  end
  local noRiveve = not self._needRevive
  self._canotReviveGo:SetActive(noRiveve)
  self._maskCanotReviveGo:SetActive(noRiveve)
  if noRiveve then
    self._txtTimes:SetText("")
  end
end

function UISeasonMaze_Campsites_Life:BtnOnClick(go)
  if not self._needRevive then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_camp_life_fail_1"))
    return
  end
  local goldCount = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  if goldCount < self._cost then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_camp_life_fail_2"))
    return
  end
  self:ShowDialog("UISeasonMaze_Campsites_Life_Select", self._cost, function(pstid)
    self:OnChooseLifeSure(pstid)
  end)
end

function UISeasonMaze_Campsites_Life:CloseBtnOnClick(go)
  self._animation:Play("uieffanim_UISeasonMaze_Campsites_Life_out")
  self:Lock("UISeasonMaze_Campsites_Life_out")
  self:StartTask(function(TT)
    YIELD(TT, 500)
    self:UnLock("UISeasonMaze_Campsites_Life_out")
    self:CloseDialog()
  end)
end

function UISeasonMaze_Campsites_Life:OnChooseLifeSure(pstid)
  self:Lock("UISeasonMaze_Campsites_Life:OnChooseLifeSure")
  GameGlobal.TaskManager():StartTask(self.OnChooseLifeSureReq, self, pstid)
end

function UISeasonMaze_Campsites_Life:OnChooseLifeSureReq(TT, pstid)
  local res = AsyncRequestRes:New()
  self._com:HandleSeasonMazeResurrectPet(TT, res, pstid)
  self:UnLock("UISeasonMaze_Campsites_Life:OnChooseLifeSure")
  if res:GetSucc() then
    self:Refresh()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Gold)
    local allPets = self._uiSeasonMazeModule:GetSeasonMazePets()
    local pet = allPets[pstid]
    local petName = StringTable.Get(pet:GetPetName())
    ToastManager.ShowToast(StringTable.Get("str_season_maze_camp_life_succ", petName))
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMaze_Campsites_Life] HandleSeasonMazeResurrectPet fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end
