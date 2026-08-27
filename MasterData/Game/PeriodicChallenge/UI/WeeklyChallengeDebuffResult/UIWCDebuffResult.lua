local UIWCDebuffResult = class("UIWCDebuffResult", UIBaseWindow)
local base = UIBaseWindow
local UINWCDebuffResultItem = require("Game.PeriodicChallenge.UI.WeeklyChallengeDebuffResult.UINWCDebuffResultItem")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_Ease = CS.DG.Tweening.Ease
local cs_Dotween = CS.DG.Tweening.DOTween

function UIWCDebuffResult:OnInit()
  self.protoLayer = nil
  self.scoreGainRate = nil
  self.scoreRate = nil
  self.historyMaxScore = 0
  self.curScore = 0
  UIUtil.AddButtonListener(self.ui.btn_Retry, self, self.__OnClickReChallenge)
  UIUtil.AddButtonListener(self.ui.btn_NextStep, self, self.__OnClickContinue)
  self.resultItemPool = UIItemPool.New(UINWCDebuffResultItem, self.ui.obj_debuffResultItem)
  self.ui.obj_debuffResultItem:SetActive(false)
  self.ui.obj_NewRecord:SetActive(false)
end

function UIWCDebuffResult:InitWCDebuffResult(scoreShow, isWin, continueCallback)
  self.elemDataDic = scoreShow.show
  self.curScore = scoreShow.score
  self.ui.tex_NextStep:SetIndex(1)
  self.ui.tex_Title:SetIndex(0)
  local dungeonId = ExplorationManager:GetEpDungeonId()
  self.wcData = PlayerDataCenter.allWeeklyChallengeData:GetWeeklyChallengeDataByDungeonId(dungeonId)
  self.historyMaxScore = self.wcData:GetCurrentMaxScore()
  self.protoLayer = Mathf.Floor(scoreShow.buffRateFix / 100)
  self.scoreGainRate = scoreShow.buffRateFix
  self.scoreRate = (scoreShow.baseRate + 1000) / 1000
  if self.wcData == nil then
    self.isHaveRankList = false
  else
    self.isHaveRankList = self.wcData:GetIsHaveRankList()
  end
  self.statisticsType = ExplorationManager:IsInTDExp() and ExplorationEnum.epScoreStatisticsType.TowerStatistics or ExplorationEnum.epScoreStatisticsType.NormalStatistics
  self.continueCallback = continueCallback
  self:__RefreshUI(isWin)
end

function UIWCDebuffResult:_AddCanvasTween(canvasGroup, index)
  local tween = canvasGroup:DOFade(0, 0.3):SetDelay(index * 0.12):SetEase(cs_Ease.InCirc):From()
  return tween
end

function UIWCDebuffResult:InitWinChallengeScoreShow(msg, isWin, historyMaxScore, continueCallback)
  self.continueCallback = continueCallback
  local elemDataDic = msg.show
  self.ui.tex_Title:SetIndex(1)
  self.ui.tex_NextStep:SetIndex(1)
  if isWin then
    self.ui.img_ResultBG.color = self.ui.color_win
  else
    self.ui.img_ResultBG.color = self.ui.color_loss
  end
  self.ui.cg_debuffConditon.gameObject:SetActive(false)
  self.ui.cg_scoreRatio.gameObject:SetActive(false)
  self.ui.cg_NewRecord.gameObject:SetActive(false)
  self.ui.cg_ThisRecord.gameObject:SetActive(true)
  self.ui.tex_historyMaxPoint:SetIndex(0, tostring(historyMaxScore))
  local index = 1
  local sequece = cs_Dotween.Sequence()
  self._showSequence = sequece
  
  local function addFadeTween(canvasGroup)
    local tween = self:_AddCanvasTween(canvasGroup, index)
    index = index + 1
    sequece:Insert(0, tween)
  end
  
  local elemDataList = {}
  for _, resultItemData in pairs(elemDataDic) do
    table.insert(elemDataList, resultItemData)
  end
  table.sort(elemDataList, function(a, b)
    return a.id < b.id
  end)
  local itemCount = 0
  for i, resultItemData in ipairs(elemDataList) do
    if resultItemData.id ~= 3 or resultItemData.param ~= 0 then
      itemCount = itemCount + 1
      local resultItem = self.resultItemPool:GetOne()
      resultItem:InitWinChallengeScoreResultItem(resultItemData)
      if itemCount <= 12 then
        addFadeTween(resultItem.ui.cg_debuffResultItem)
      end
    end
  end
  self.ui.tex_NewPoint.text = tostring(msg.score)
  addFadeTween(self.ui.cg_ThisRecord)
  addFadeTween(self.ui.tex_NewPoint)
  addFadeTween(self.ui.cg_btn_NextStep)
  sequece:SetUpdate(true)
end

function UIWCDebuffResult:InitWarchessSeasonResult(msg, historyMaxScore, isWin, continueCallback)
  self.continueCallback = continueCallback
  self.ui.tex_Title:SetIndex(2)
  self.ui.tex_NextStep:SetIndex(1)
  self.ui.cg_debuffConditon.gameObject:SetActive(false)
  self.ui.cg_scoreRatio.gameObject:SetActive(false)
  local curScore = msg ~= nil and msg.totalScore or 0
  local isNew = historyMaxScore < curScore
  historyMaxScore = math.max(curScore, historyMaxScore)
  self.ui.cg_NewRecord.gameObject:SetActive(isNew)
  self.ui.cg_ThisRecord.gameObject:SetActive(not isNew)
  self.ui.tex_historyMaxPoint:SetIndex(0, tostring(historyMaxScore))
  self.ui.tex_NewPoint.text = tostring(curScore)
  local resultIds = ConfigData.warchess_season_score_show.sortList
  local scoreDetail = msg ~= nil and msg.scoreDetail or table.emptytable
  self.resultItemPool:HideAll()
  for _, resultid in ipairs(resultIds) do
    local cfg = ConfigData.warchess_season_score_show[resultid]
    local resultItemData = scoreDetail[resultid]
    if cfg.need_show or resultItemData ~= nil and 0 < resultItemData.value then
      local resultItem = self.resultItemPool:GetOne()
      resultItem:InitWarchessSeasonResultItem(cfg, scoreDetail[resultid])
    end
  end
end

function UIWCDebuffResult:__RefreshUI(isWin)
  DestroyUnityObject(self.img_ResultBG_Material)
  self.img_ResultBG_Material = nil
  self.img_ResultBG_Material = UIUtil.GetImageMaterial(self.ui.img_ResultBG)
  local resultBG_Material = self.img_ResultBG_Material
  resultBG_Material:SetFloat("_Decoloration", 0)
  if isWin then
    self.ui.img_ResultBG.color = self.ui.color_win
  else
    self.ui.img_ResultBG.color = self.ui.color_loss
  end
  if self.isHaveRankList then
    self.ui.tex_historyMaxPoint.gameObject:SetActive(true)
    self.ui.tex_historyMaxPoint:SetIndex(0, tostring(self.historyMaxScore))
  else
    self.ui.tex_historyMaxPoint.gameObject:SetActive(false)
  end
  self.protoLayer = 0 < self.protoLayer and self.protoLayer or 0
  self.ui.tex_Layer:SetIndex(0, tostring(self.protoLayer))
  self.ui.tex_Gain.text = tostring(self.scoreGainRate / 10) .. "%"
  local isNewRecord = self:__IsNewRecord()
  self.ui.obj_scoreRatio:SetActive(self.scoreRate ~= 1)
  self.ui.tex_ScoureRatio:SetIndex(0, tostring(self.scoreRate))
  self.ui.tex_NewPoint.text = tostring(self.curScore)
  for scoreId, cfg in pairs(ConfigData.weekly_challenge_score) do
    if cfg.const_show and table.contain(cfg.type, self.statisticsType) then
      if self.elemDataDic[scoreId] == nil then
        self.elemDataDic[scoreId] = {
          id = scoreId,
          score = 0,
          param = 0,
          isconst = true
        }
      else
        self.elemDataDic[scoreId].isconst = true
      end
    end
  end
  local index = 1
  local sequece = cs_Dotween.Sequence()
  
  local function addFadeTween(canvasGroup)
    local tween = self:_AddCanvasTween(canvasGroup, index)
    index = index + 1
    sequece:Insert(0, tween)
  end
  
  local elemDataList = {}
  for _, resultItemData in pairs(self.elemDataDic) do
    if resultItemData.id ~= 18 then
      table.insert(elemDataList, resultItemData)
    end
  end
  table.sort(elemDataList, function(a, b)
    if a.isconst ~= b.isconst then
      return a.isconst
    end
    return a.id < b.id
  end)
  if self.elemDataDic[18] ~= nil then
    table.insert(elemDataList, 1, self.elemDataDic[18])
  end
  self.resultItemPool:HideAll()
  local itemCount = 0
  for i, resultItemData in ipairs(elemDataList) do
    if resultItemData.id ~= 19 or resultItemData.param ~= 0 then
      itemCount = itemCount + 1
      local resultItem = self.resultItemPool:GetOne()
      resultItem:InitResultItem(resultItemData, itemCount)
      if itemCount <= 12 then
        addFadeTween(resultItem.ui.cg_debuffResultItem)
      end
    end
  end
  addFadeTween(self.ui.cg_debuffConditon)
  addFadeTween(self.ui.cg_total)
  if self.ui.obj_scoreRatio.activeInHierarchy then
    addFadeTween(self.ui.cg_scoreRatio)
  end
  if self.isHaveRankList and isNewRecord then
    sequece:InsertCallback(index * 0.12, function()
      self.ui.obj_NewRecord:SetActive(true)
    end)
    addFadeTween(self.ui.cg_NewRecord)
  end
  addFadeTween(self.ui.tex_NewPoint)
  addFadeTween(self.ui.cg_btn_NextStep)
  self._showSequence = sequece
end

function UIWCDebuffResult:__OnClickContinue()
  self:Delete()
  if self.continueCallback ~= nil then
    self.continueCallback()
  end
end

function UIWCDebuffResult:__OnClickReChallenge()
  if self.reChallengeFunc ~= nil then
    self.reChallengeFunc()
  end
end

function UIWCDebuffResult:__IsNewRecord()
  return (self.curScore or 0) > (self.historyMaxScore or 0)
end

function UIWCDebuffResult:OnDelete()
  if self._showSequence ~= nil then
    self._showSequence:Kill()
    self._showSequence = nil
  end
  DestroyUnityObject(self.img_ResultBG_Material)
  self.img_ResultBG_Material = nil
  base.OnDelete(self)
end

return UIWCDebuffResult
