local TrekkerVersusDifficultyCtrl = class("TrekkerVersusDifficultyCtrl", BaseCtrl)
TrekkerVersusDifficultyCtrl._mapNodeConfig = {
  rtWindow = {
    sComponentName = "RectTransform"
  },
  aniWindow = {sNodeName = "rtWindow", sComponentName = "Animator"},
  lsvDifficulty = {
    sComponentName = "LoopScrollView"
  },
  txtWindowTitleDifficulty = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_DifficultyPreviewTitle"
  },
  btn_Close = {sComponentName = "UIButton", callback = "ClosePanel"},
  btnClose_difficulty = {sComponentName = "UIButton", callback = "ClosePanel"}
}
TrekkerVersusDifficultyCtrl._mapEventConfig = {}
TrekkerVersusDifficultyCtrl._mapRedDotConfig = {}

function TrekkerVersusDifficultyCtrl:RefreshDuelDifficulty()
  self.nCurDifficulty = self._mapActData:GetRecordLevel()
  self.tbIdleRewards = {}
  
  local function foreachIdleRewards(mapData)
    self.tbIdleRewards[mapData.Difficulty] = mapData
  end
  
  ForEachTableLine(DataTable.TravelerDuelIdleRewards, foreachIdleRewards)
  self.tbDuelDifficulty = {}
  
  local function foreachDifficulty(mapDifficultyData)
    table.insert(self.tbDuelDifficulty, mapDifficultyData)
  end
  
  ForEachTableLine(DataTable.TravelerDuelChallengeDifficulty, foreachDifficulty)
  table.sort(self.tbDuelDifficulty, function(a, b)
    return a.Id < b.Id
  end)
  self._mapNode.lsvDifficulty:Init(#self.tbDuelDifficulty, self, self.OnDuelDifficultyGridRefresh)
  self._mapNode.lsvDifficulty:SetScrollGridPos(self.nCurDifficulty - 1 > 0 and self.nCurDifficulty - 1 or 0, 0)
end

function TrekkerVersusDifficultyCtrl:OnDuelDifficultyGridRefresh(goGrid, nIdx)
  local nIndex = nIdx + 1
  local mapDifficultyData = self.tbDuelDifficulty[nIndex]
  local mapDifficultyRewardData = self.tbIdleRewards[mapDifficultyData.Id]
  local goAnimRoot = goGrid.transform:Find("btnGrid"):Find("AnimRoot")
  if goAnimRoot == nil then
    return
  end
  local imgHalf = goAnimRoot:Find("imgHalo").gameObject
  imgHalf:SetActive(mapDifficultyData.Id == self.nCurDifficulty)
  local imgArrow = goAnimRoot:Find("imgArrow").gameObject
  imgArrow:SetActive(mapDifficultyData.Id == self.nCurDifficulty)
  local txtGridHighestRecordNum = goAnimRoot:Find("txtGridHighestRecordNum").gameObject:GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtGridHighestRecordNum, mapDifficultyData.Id)
  local txtHourReward = goAnimRoot:Find("txtHourReward").gameObject:GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtHourReward, ConfigTable.GetUIText("TD_HourReward"))
  local txtEnemyEffect = goAnimRoot:Find("imgEnemyEffect"):Find("txtEnemyEffect").gameObject:GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtEnemyEffect, ConfigTable.GetUIText("TD_EnemyEffect"))
  local txtEnemyEffectNum = goAnimRoot:Find("imgEnemyEffect"):Find("txtEnemyEffectNum").gameObject:GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtEnemyEffectNum, mapDifficultyData.Attr .. "%")
  local nCount = 0
  local nItemGridCount = 4
  
  local function foreachIdleReward(mapData)
    nCount = nCount + 1
    nItemGridCount = nItemGridCount - 1
    local nEveryMinuteAccumulateValue = 0
    if nCount == 1 then
      nEveryMinuteAccumulateValue = mapDifficultyRewardData.TypeAValue
    elseif nCount == 2 then
      nEveryMinuteAccumulateValue = mapDifficultyRewardData.TypeBValue
    elseif nCount == 3 then
      nEveryMinuteAccumulateValue = mapDifficultyRewardData.TypeCValue
    end
    local nItemCount = math.floor(nEveryMinuteAccumulateValue * 60 / mapData.CumulativeValue)
    local btnItem = goAnimRoot:Find("rtItem"):Find("btnItem_" .. nItemGridCount).gameObject:GetComponent("UIButton")
    if 0 < nItemCount then
      btnItem.gameObject:SetActive(true)
      btnItem.onClick:RemoveAllListeners()
      btnItem.onClick:AddListener(function()
        UTILS.ClickItemGridWithTips(mapData.Id, btnItem.transform, true, true, false)
      end)
      local objItem = btnItem.transform:Find("GameObject"):Find("item" .. nItemGridCount).gameObject
      local itemCtrl = self:BindCtrlByNode(objItem, "Game.UI.TemplateEx.TemplateItemCtrl")
      if itemCtrl ~= nil then
        itemCtrl:SetItem(mapData.Id, nil, nItemCount)
        if self.tbObjCtrl[goGrid] ~= nil then
          self:UnbindCtrlByNode(self.tbObjCtrl[goGrid])
          self.tbObjCtrl[goGrid] = nil
        end
        self.tbObjCtrl[goGrid] = itemCtrl
      end
    else
      btnItem.gameObject:SetActive(false)
    end
  end
  
  ForEachTableLine(DataTable.TravelerDuelHotValueItem, foreachIdleReward)
end

function TrekkerVersusDifficultyCtrl:Awake()
  self._mapGridCtrl = {}
end

function TrekkerVersusDifficultyCtrl:FadeIn()
end

function TrekkerVersusDifficultyCtrl:FadeOut()
end

function TrekkerVersusDifficultyCtrl:OnEnable()
  self._mapAllQuestCfgData = {}
  self._mapNode.rtWindow.gameObject:SetActive(false)
  self.tbObjCtrl = {}
end

function TrekkerVersusDifficultyCtrl:OnDisable()
  if self._coroutineOpen ~= nil then
    cs_coroutine.stop(self._coroutineOpen)
    self._coroutineOpen = nil
  end
  self:UnbindAllGrids()
end

function TrekkerVersusDifficultyCtrl:OnDestroy()
end

function TrekkerVersusDifficultyCtrl:OnRelease()
end

function TrekkerVersusDifficultyCtrl:ClosePanel()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:AddTimer(1, 0.3, function()
    self.gameObject:SetActive(false)
    self._mapNode.rtWindow.gameObject:SetActive(false)
  end, true, true, true, nil)
end

function TrekkerVersusDifficultyCtrl:UnbindAllGrids()
  for go, ctrl in pairs(self.tbObjCtrl) do
    self:UnbindCtrlByNode(ctrl)
  end
  self.tbObjCtrl = {}
end

function TrekkerVersusDifficultyCtrl:OpenPanel(mapActData)
  self.gameObject:SetActive(true)
  self._mapActData = mapActData
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.rtWindow.gameObject:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    self:RefreshDuelDifficulty()
  end
  
  self._coroutineOpen = cs_coroutine.start(wait)
end

return TrekkerVersusDifficultyCtrl
