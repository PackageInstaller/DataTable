local UIAvgDetail = class("UIAvgDetail", UIBaseWindow)
local base = UIBaseWindow
local UINLevelDetailRewardItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelDetailRewardItem")
local UINStOUnlockConditionItem = require("Game.StrategyOverview.UI.Side.UINStOUnlockConditionItem")

function UIAvgDetail:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseAvgDetail)
  self._resloader = CS.ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClockCloseBg)
  UIUtil.AddButtonListener(self.ui.btn_ViewAvg, self, self.OnClickPlay)
  self._conditionItemPool = UIItemPool.New(UINStOUnlockConditionItem, self.ui.conditionItem)
  self.ui.conditionItem:SetActive(false)
  self._rewardItemPool = UIItemPool.New(UINLevelDetailRewardItem, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
  self.ui.detailNode.onComplete:AddListener(BindCallback(self, self.__OnMoveTweenComplete))
  self.ui.detailNode.onRewind:AddListener(BindCallback(self, self.__OnMoveTweenRewind))
end

function UIAvgDetail:InitAvgDetail(data_UIAvgDetail)
  self._data = data_UIAvgDetail
  self._closeCallback = self._data:GetAvgDetailCloseCallback()
  self._avgId = self._data:GetAvgDetailAvgId()
  self._avgCfg = self._data:GetAvgDetailAvgCfg()
  self:__InitBaseInfo()
  self:__InitReward()
  self:__InitViewState()
  self.ui.btn_Close.gameObject:SetActive(self._data:GetAvgDetailCloseBgOpen())
  self:__PlayEnterTween()
end

function UIAvgDetail:__InitBaseInfo()
  local path = self._data:GetAvgDetailAvgBannerTexPath()
  if path ~= nil then
    local tex = self._resloader:LoadABAsset(PathConsts:GetSectorBackgroundPath(path))
    if tex ~= nil then
      self.ui.img_LevelPic.texture = tex
    end
  end
  self.ui.tex_IdName.text = self._data:GetAvgDetailExTitle() or ""
  self.ui.tex_LevelName.text = LanguageUtil.GetLocaleText(self._avgCfg.name)
  self.ui.tex_LevelInfo.text = LanguageUtil.GetLocaleText(self._avgCfg.describe)
  self:__PlayEnterTween()
end

function UIAvgDetail:__InitReward()
  if not self._data:GetAvgDetailRewardShowState() then
    self.ui.rewardRank:SetActive(false)
    return
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local played = self._data:GetAvgDetailPlayed()
  local rewardDic = {}
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actFrameData = actCtrl:GetActivityFrameData(self._avgCfg.activity_id)
  if actFrameData ~= nil and actFrameData:IsActivityOpen() and not actFrameData:IsActivityRunningTimeout() then
    for i, itemId in ipairs(self._avgCfg.activityRewardIds) do
      local count = rewardDic[itemId] or 0
      rewardDic[itemId] = count + self._avgCfg.activityRewardNums[i]
    end
  end
  local extraReward = self._data:GetAvgDetailExtraReward()
  if extraReward ~= nil then
    for itemId, itemCount in pairs(extraReward) do
      local count = rewardDic[itemId] or 0
      rewardDic[itemId] = count + itemCount
    end
  end
  for k, itemId in ipairs(self._avgCfg.rewardIds) do
    local count = rewardDic[itemId] or 0
    rewardDic[itemId] = count + self._avgCfg.rewardNums[k]
  end
  local isShow = 0 < table.count(rewardDic)
  if not isShow then
    self.ui.rewardRank:SetActive(false)
    return
  end
  self.ui.rewardRank:SetActive(true)
  local itemClickCallback = BindCallback(self, self.__ShowRewardDetail)
  local rewardCount = 0
  local rewardCountMax = self.ui.AvgDropItemLimt or 5
  local rewardIdList = self:__GetRewardShowSort(rewardDic)
  self._rewardItemPool:HideAll()
  for _, itemId in ipairs(rewardIdList) do
    local itemNum = rewardDic[itemId]
    if rewardCount >= rewardCountMax then
      break
    end
    rewardCount = rewardCount + 1
    local rewardItem = self._rewardItemPool:GetOne()
    local itemCfg = ConfigData.item[itemId]
    rewardItem:InitItemWithCount(itemCfg, itemNum, itemClickCallback, played)
  end
end

function UIAvgDetail:__GetRewardShowSort(rewardDic)
  local rewardIds = {}
  for k, v in pairs(rewardDic) do
    table.insert(rewardIds, k)
  end
  table.sort(rewardIds, function(a, b)
    local aItem = ConfigData.item[a]
    local bItem = ConfigData.item[b]
    if aItem.quality ~= bItem.quality then
      return aItem.quality > bItem.quality
    end
    return a < b
  end)
  return rewardIds
end

function UIAvgDetail:__InitViewState()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local isUnlock = avgPlayCtrl:IsAvgUnlock(self._avgId)
  local extraLockList = self._data:GetAvgDetailExtraCondition()
  if isUnlock and extraLockList ~= nil then
    for i, v in ipairs(extraLockList) do
      if not v.unlock then
        isUnlock = false
        break
      end
    end
  end
  self.ui.btn_ViewAvg.gameObject:SetActive(isUnlock)
  self.ui.unlockCondition:SetActive(not isUnlock)
  if isUnlock then
    return
  end
  local conditionList = CheckCondition.GetUnlockAndInfoList(self._avgCfg.pre_condition, self._avgCfg.pre_para1, self._avgCfg.pre_para2)
  self._conditionItemPool:HideAll()
  for i, v in ipairs(conditionList) do
    local item = self._conditionItemPool:GetOne()
    item:InitStOUnlockConditionItem(v.unlock, v.lockReason)
  end
  if extraLockList ~= nil then
    for i, v in ipairs(extraLockList) do
      local item = self._conditionItemPool:GetOne()
      item:InitStOUnlockConditionItem(v.unlock, v.lockReason)
    end
  end
end

function UIAvgDetail:OnClickPlay()
  UIUtil.OnClickBackByUiTab(self)
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  avgCtrl:StartAvg(self._avgCfg.script_id, self._avgCfg.id, function()
    AvgUtil.ShowMainCamera(true)
  end)
  AvgUtil.ShowMainCamera(false)
end

function UIAvgDetail:OnClockCloseBg()
  UIUtil.OnClickBackByUiTab(self)
end

function UIAvgDetail:__ShowRewardDetail(itemCfg)
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:InitCommonItemDetail(itemCfg)
    end
  end)
end

function UIAvgDetail:GetAvgDetailDetailMoveWidthAndTime()
  if self._tempMoveWidth == nil then
    self._tempMoveWidth = self.ui.detailNode.transform.sizeDelta.x
    self._tempMoveTime = self.ui.detailNode.duration
  end
  return self._tempMoveWidth, self._tempMoveTime
end

function UIAvgDetail:__PlayEnterTween()
  if self._uiIsShow then
    return
  end
  self._uiIsShow = true
  UIUtil.AddOneCover("UIAvgDetail")
  self.ui.detailNode:DOPlayForward()
  AudioManager:PlayAudioById(1033)
  local func = self._data:GetAvgDetailOpenTweenBeginCallback()
  if func ~= nil then
    func()
  end
end

function UIAvgDetail:__PlayCloseTween()
  UIUtil.AddOneCover("UIAvgDetail")
  self.ui.detailNode:DOPlayBackwards()
  AudioManager:PlayAudioById(1034)
  local func = self._data:GetAvgDetailCloseTweenBeginCallback()
  if func ~= nil then
    func()
  end
end

function UIAvgDetail:__OnMoveTweenComplete()
  UIUtil.CloseOneCover("UIAvgDetail")
end

function UIAvgDetail:__OnMoveTweenRewind()
  UIUtil.CloseOneCover("UIAvgDetail")
  self:Delete()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
end

function UIAvgDetail:OnCloseAvgDetail(isHome)
  if isHome then
    self:Delete()
    if self._closeCallback ~= nil then
      self._closeCallback()
    end
  else
    self:__PlayCloseTween()
  end
end

return UIAvgDetail
