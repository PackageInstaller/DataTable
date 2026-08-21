require("ui_season_maze_campsites_base")
_class("UISeasonMaze_Campsites_Bank", UISeasonMaze_Campsites_Base)
UISeasonMaze_Campsites_Bank = UISeasonMaze_Campsites_Bank

function UISeasonMaze_Campsites_Bank:InitWidget()
  self.topBtn = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._pool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._TipsAreaGo = self:GetGameObject("TipsArea")
  self._TipsAreaGo:SetActive(false)
  self._TipsText = self:GetUIComponent("UILocalizationText", "Tips")
  self._CurrentSaveCountTex = self:GetUIComponent("UILocalizationText", "CurrentSaveCount")
  self._SaveCount1Text = self:GetUIComponent("UILocalizationText", "SaveCount1")
  self._SaveCount2Text = self:GetUIComponent("UILocalizationText", "SaveCount2")
  self._SaveTag1Text = self:GetUIComponent("UILocalizationText", "SaveTag1")
  self._SaveTag2Text = self:GetUIComponent("UILocalizationText", "SaveTag2")
  self._SaveBtnAnim1 = self:GetUIComponent("Animation", "SaveBtn1")
  self._SaveBtnAnim2 = self:GetUIComponent("Animation", "SaveBtn2")
  self._SaveBtnRect1 = self:GetUIComponent("RectTransform", "SaveBtn1")
  self._SaveBtnRect2 = self:GetUIComponent("RectTransform", "SaveBtn2")
  self._SaveMaskImage1 = self:GetUIComponent("Image", "SaveMask1")
  self._SaveMaskImage2 = self:GetUIComponent("Image", "SaveMask2")
  self._ProgressTipsText = self:GetUIComponent("UILocalizationText", "ProgressTips")
  self.UISeasonMazeTopIcon = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeTopIcon")
  local contentGrid = self:GetUIComponent("GridLayoutGroup", "Content")
  self._paddingTop = contentGrid.padding.top
  self._cellSizeY = contentGrid.cellSize.y
  self._cellSpaceY = contentGrid.spacing.y
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._viewPortHeight = self:GetUIComponent("RectTransform", "Viewport").rect.height
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self._scrollRect.onValueChanged:AddListener(function()
    self:_OnScrollMove()
  end)
end

function UISeasonMaze_Campsites_Bank:_OnScrollMove()
  if self._contentRect.sizeDelta.y <= 0 then
    return
  end
  local deltaHeight = 50
  if self._contentRect.anchoredPosition.y + self._viewPortHeight + deltaHeight > self._contentRect.sizeDelta.y then
    self:CheckShowTipsArea()
  else
    self._TipsAreaGo:SetActive(false)
  end
end

function UISeasonMaze_Campsites_Bank:SetQuestPool()
  self._pool:SpawnObjects("UISeasonMaze_Campsites_BankWidget", #self._saveList)
  local pools = self._pool:GetAllSpawnList()
  self._cellWidgets = pools
  for i = 1, #self._saveList do
    local save = self._saveList[i]
    local widget = pools[i]
    widget:SetData(i, save, self._currentSaveCount)
  end
end

function UISeasonMaze_Campsites_Bank:LocateScroll()
  local index = self._unlockCount
  index = math.max(index, 1)
  local needScrollCount = 6
  local onePageCells = 7
  if index + onePageCells > #self._saveList then
    index = #self._saveList - 5
    self._uiLocateCell = index
  elseif needScrollCount >= index then
    index = 1
    self._uiLocateCell = index
    return
  else
    index = index - 3
    index = math.max(index, 1)
    self._uiLocateCell = index
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._contentRect)
  local height = self._contentRect.rect.height
  local y = self._paddingTop + (self._cellSizeY + self._cellSpaceY) * (index - 1) - self._cellSpaceY / 2
  y = Mathf.Clamp(y, 0, math.max(height - self._viewPortHeight, 0))
  self._contentRect.anchoredPosition = Vector2(0, y)
  self:_OnScrollMove()
end

function UISeasonMaze_Campsites_Bank:PlayQuestPoolShowInAnim()
  local lockName = "UISeasonMaze_Campsites_Bank:PlayQuestPoolShowInAnim"
  self:StartTask(function(TT)
    local eachDelay = 50
    local maxShowCells = 7
    local lockTime = 500
    local maxDelayMs = 0
    local startCell = 1
    local showStartCell = self._uiLocateCell
    if not showStartCell then
      showStartCell = math.max(self._unlockCount, 1)
      showStartCell = showStartCell - 3
      showStartCell = math.max(showStartCell, 1)
    end
    local showEndCell = showStartCell + maxShowCells - 1
    local maxCell = #self._saveList
    if maxCell <= showStartCell + maxShowCells - 1 then
      showEndCell = maxCell
      showStartCell = showEndCell - maxShowCells + 1
      showStartCell = math.max(showStartCell, 1)
    end
    if self._cellWidgets then
      for index, widget in ipairs(self._cellWidgets) do
        if index >= showStartCell and index <= showEndCell then
          local delayIndex = index - showStartCell
          local delayMs = delayIndex * eachDelay
          widget:PlayShowInAnim(delayMs)
          maxDelayMs = delayMs
        end
      end
    end
    lockTime = lockTime + maxDelayMs
  end)
end

function UISeasonMaze_Campsites_Bank:CreateData()
  local comInfo = self._com:GetComponentInfo()
  self._currentHard = comInfo.hard
  local maxHard = 0
  local mazeCfgs = Cfg.cfg_component_season_maze({
    ComponentID = self._comCfgID
  })
  if mazeCfgs and 0 < #mazeCfgs then
    for _, v in pairs(mazeCfgs) do
      if maxHard < v.Hard then
        maxHard = v.Hard
      end
    end
  end
  self._maxHard = maxHard
  self._saveList = {}
  self._saveMax = nil
  local cfgs = Cfg.cfg_component_season_maze_save({
    ComponentID = self._comCfgID
  })
  if cfgs and 0 < table.count(cfgs) then
    for key, value in pairs(cfgs) do
      if value.LockHard <= self._currentHard then
        table.insert(self._saveList, value)
        if not self._saveMax then
          self._saveMax = value.NeedNum
        elseif value.NeedNum > self._saveMax then
          self._saveMax = value.NeedNum
        end
      end
    end
  end
  table.sort(self._saveList, function(a, b)
    return a.Lv < b.Lv
  end)
  self._currentSaveCount = comInfo.save_info.exp or 0
  self._saveCount1 = 10
  self._saveCount2 = 100
  local unlockCount = 0
  for index, value in ipairs(self._saveList) do
    if self._currentSaveCount >= value.NeedNum then
      unlockCount = unlockCount + 1
    end
  end
  self._unlockCount = unlockCount
end

function UISeasonMaze_Campsites_Bank:InitRecordCurrentCellState()
  self._cellLockStates = {}
  if self._saveList and self._currentSaveCount then
    for index, cfg in ipairs(self._saveList) do
      local isLock = self._currentSaveCount < cfg.NeedNum
      self._cellLockStates[index] = isLock
    end
  end
end

function UISeasonMaze_Campsites_Bank:ChecKUnlockAnim()
  if self._saveList and self._currentSaveCount then
    for index, cfg in ipairs(self._saveList) do
      local isLock = self._currentSaveCount < cfg.NeedNum
      local oriLock = self._cellLockStates[index]
      if oriLock and not isLock then
        local widget = self._cellWidgets[index]
        if widget then
          widget:PlayUnlockAnim()
        end
      end
      self._cellLockStates[index] = isLock
    end
  end
end

function UISeasonMaze_Campsites_Bank:OnShowUI(uiParams)
  self._mulitOpen = UnityEngine.Input.multiTouchEnabled
  UnityEngine.Input.multiTouchEnabled = false
  self:InitWidget()
  self:CreateData()
  self:InitRecordCurrentCellState()
  self:SetTopBtn()
  self:SetUISeasonMazeTopIcon()
  self:SetQuestPool()
  self:LocateScroll()
  self:PlayQuestPoolShowInAnim()
  self:SetSaveInfo()
  self:SetTipsArea()
end

function UISeasonMaze_Campsites_Bank:SetUISeasonMazeTopIcon()
  if self.UISeasonMazeTopIcon then
    if not self.UISeasonMazeTopIconWidget then
      self.UISeasonMazeTopIconWidget = self.UISeasonMazeTopIcon:SpawnObject("UISeasonMazeTopIcon")
    end
    local typeList = {
      SeasonMazeTopIconType.Money
    }
    self.UISeasonMazeTopIconWidget:SetData(typeList)
  end
end

function UISeasonMaze_Campsites_Bank:SetSaveInfo()
  local saveNumStr
  if self._saveMax and self._saveMax > 0 then
    local formatStr = "<color=#252525><size=40>%s</size></color><color=#b83c3c><size=32>/%s</size></color>"
    saveNumStr = string.format(formatStr, tostring(self._currentSaveCount), tostring(self._saveMax))
  else
    local formatStr = "<color=#252525><size=40>%s</size></color>"
    saveNumStr = string.format(formatStr, tostring(self._currentSaveCount))
  end
  self._CurrentSaveCountTex:SetText(saveNumStr)
  local totalCount = #self._saveList
  local unlockCount = self._unlockCount
  local numStr = string.format("%s/%s", tostring(unlockCount), tostring(totalCount))
  local progressStr = StringTable.Get("str_season_maze_bank_progress", numStr)
  self._ProgressTipsText:SetText(progressStr)
  local enoughColor = Color(1, 1, 1, 1)
  local notEnoughColor = Color(0.6705882352941176, 0.1411764705882353, 0.1411764705882353, 1)
  if self:CheckCountEnough(self._saveCount1) then
    local saveStr = "<color=#ffffff>" .. tostring(self._saveCount1) .. "</color>"
    self._SaveCount1Text:SetText(saveStr)
    self._SaveTag1Text.color = enoughColor
  else
    local saveStr = "<color=#ab2424>" .. tostring(self._saveCount1) .. "</color>"
    self._SaveCount1Text:SetText(saveStr)
    self._SaveTag1Text.color = notEnoughColor
  end
  if self:CheckCountEnough(self._saveCount2) then
    local saveStr = "<color=#ffffff>" .. tostring(self._saveCount2) .. "</color>"
    self._SaveCount2Text:SetText(saveStr)
    self._SaveTag2Text.color = enoughColor
  else
    local saveStr = "<color=#ab2424>" .. tostring(self._saveCount2) .. "</color>"
    self._SaveCount2Text:SetText(saveStr)
    self._SaveTag2Text.color = notEnoughColor
  end
end

function UISeasonMaze_Campsites_Bank:SetTopBtn()
  self.topBtn:SpawnObject("UISMazeCommonTopButton"):SetData(function()
    self:CloseDialog()
  end, nil, nil, true)
end

function UISeasonMaze_Campsites_Bank:SaveBtnMask1OnClick(go)
  self:PlaySaveBtnAnim(self._SaveBtnAnim1)
  if self._saveMax and self._saveMax > 0 then
    if self._currentSaveCount == self._saveMax then
      local tips = StringTable.Get("str_season_maze_bank_full_tips")
      ToastManager.ShowToast(tips)
      return
    end
  else
    return
  end
  if self:CheckCountEnough(self._saveCount1) then
    local maxSave = self._saveMax - self._currentSaveCount
    local saveNum = math.min(self._saveCount1, maxSave)
    self:ReqSaveLv(saveNum)
  else
    local tips = StringTable.Get("str_season_maze_gold_not_enough")
    ToastManager.ShowToast(tips)
  end
end

function UISeasonMaze_Campsites_Bank:SaveBtnMask2OnClick(go)
  self:PlaySaveBtnAnim(self._SaveBtnAnim2)
  if self._saveMax and self._saveMax > 0 then
    if self._currentSaveCount == self._saveMax then
      local tips = StringTable.Get("str_season_maze_bank_full_tips")
      ToastManager.ShowToast(tips)
      return
    end
  else
    return
  end
  if self:CheckCountEnough(self._saveCount2) then
    local maxSave = self._saveMax - self._currentSaveCount
    local saveNum = math.min(self._saveCount2, maxSave)
    self:ReqSaveLv(saveNum)
  else
    local tips = StringTable.Get("str_season_maze_gold_not_enough")
    ToastManager.ShowToast(tips)
  end
end

function UISeasonMaze_Campsites_Bank:PlaySaveBtnAnim(anim)
  self._SaveBtnAnim1:Stop()
  self._SaveBtnAnim2:Stop()
  self._SaveBtnRect1.localScale = Vector3(1, 1, 1)
  self._SaveMaskImage1.color = Color(0.5490196078431373, 0.5490196078431373, 0.5490196078431373, 0)
  self._SaveBtnRect2.localScale = Vector3(1, 1, 1)
  self._SaveMaskImage2.color = Color(0.5490196078431373, 0.5490196078431373, 0.5490196078431373, 0)
  anim:Play("uieffanim_UISeasonMaze_Campsites_Bank_SaveBtn1_click")
end

function UISeasonMaze_Campsites_Bank:ReqSaveLv(num)
  self:Lock("UISeasonMaze_Campsites_Bank:ReqSaveLv")
  GameGlobal.TaskManager():StartTask(self.TaskReqSaveLv, self, num)
end

function UISeasonMaze_Campsites_Bank:TaskReqSaveLv(TT, num)
  local res = AsyncRequestRes:New()
  local response = self._com:HandleSeasonMazeSaveLv(TT, res, num)
  self:UnLock("UISeasonMaze_Campsites_Bank:ReqSaveLv")
  if res:GetSucc() then
    self:OnSaveEnd()
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMaze_Campsites_Bank] HandleSeasonMazeSaveLv fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMaze_Campsites_Bank:OnSaveEnd()
  self:CreateData()
  self:SetSaveInfo()
  self:SetQuestPool()
  self:ChecKUnlockAnim()
  self:RefreshMoney()
  self:SetTipsArea()
end

function UISeasonMaze_Campsites_Bank:OnHide()
  UnityEngine.Input.multiTouchEnabled = self._mulitOpen
end

function UISeasonMaze_Campsites_Bank:CheckCountEnough(count)
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  return count <= curGold
end

function UISeasonMaze_Campsites_Bank:RefreshMoney()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Gold)
end

function UISeasonMaze_Campsites_Bank:CheckShowTipsArea()
  if self._currentHard == self._maxHard then
    self._TipsAreaGo:SetActive(false)
  else
    self._TipsAreaGo:SetActive(true)
  end
end

function UISeasonMaze_Campsites_Bank:SetTipsArea()
  if self._currentHard == self._maxHard then
  else
    local tipsStrKey = "str_season_maze_bank_limit_tips_s1_" .. tostring(self._currentHard)
    local tipsStr = StringTable.Get(tipsStrKey)
    if tipsStr then
      self._TipsText:SetText(tipsStr)
    end
  end
end
