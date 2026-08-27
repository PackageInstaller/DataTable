local UIActBlackHoleMain = class("UIActBlackHoleMain", UIBaseWindow)
local base = UIBaseWindow
local UINActBlackHoleFloorSelectItem = require("Game.ActivityBlackHole.UI.FloorSelect.UINActBlackHoleFloorSelectItem")
local UINActBlackHoleStageInfo = require("Game.ActivityBlackHole.UI.Info.UINActBlackHoleStageInfo")
local UINActBHRecommendNode = require("Game.ActivityBlackHole.UI.Recommend.UINActBlackHoleRecommendNode")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local BattleUtil = require("Game.Battle.BattleUtil")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")

function UIActBlackHoleMain:OnInit()
  base.OnInit(self)
  UIUtil.SetTopStatus(self, self.Delete, nil, self.ShowRuleInfo)
  self._OnClickBlackHoleFloorSelectItemCallback = BindCallback(self, self._OnClickBlackHoleFloorSelectItem)
  self._OnClickBlackHoleDungeonStartCallback = BindCallback(self, self._OnClickBlackHoleDungeonStart)
  self._OnClickReceiveAllCallback = BindCallback(self, self.OnClickReceiveAll)
  self.resloader = CS.ResLoader.Create()
  self.floorItemPool = UIItemPool.New(UINActBlackHoleFloorSelectItem, self.ui.floorItem, false)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived, false)
  self.infoItemPool = UIItemPool.New(UINActBlackHoleStageInfo, self.ui.obj_dungeonNode, false)
  self.bHRecommendNode = UINActBHRecommendNode.New()
  self.bHRecommendNode:Init(self.ui.obj_recommend)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.OnClickBtnRank)
  UIUtil.AddButtonListener(self.ui.btn_backGround, self, self.OnClickBtnBackGround)
  UIUtil.AddButtonListener(self.ui.btn_reset, self, self.OnClickBlackHoleReset)
  UIUtil.AddButtonListener(self.ui.btn_getReward, self, self.OnClickBtnGetReward)
end

function UIActBlackHoleMain:InitEventBlackHoleMain(actData, myRank)
  self._actData = actData
  self._actId = self._actData:GetActId()
  self.haveRank = myRank ~= nil
  self:Refresh(myRank)
  if self._timerId == nil then
    self._timerId = TimerManager:StartTimer(1, BindCallback(self, self.__TimeCountdown), self)
  end
  self:__TimeCountdown()
end

function UIActBlackHoleMain:Refresh(myRank)
  self:RefreshBlackHoleFloor()
  self:RefreshRankList(myRank)
  self:RefreshBlackHoleBossTime()
  self:RefreshActUI()
  self:RefreshCfgUI()
end

function UIActBlackHoleMain:RefreshActUI()
  self.ui.tex_totalScore.text = tostring(self._actData:GetActTotalScore())
  self:RefreshNextStageReward()
end

function UIActBlackHoleMain:RefreshNextStageReward()
  self.ui.obj_reward:SetActive(false)
  self.ui.obj_getRewardAll:SetActive(false)
  local rewardCfg = self._actData:GetNextStageRewardCfg()
  self.rewardItemPool:HideAll()
  if rewardCfg then
    self.ui.obj_reward:SetActive(true)
    for index, rewardId in pairs(rewardCfg.rewardIds) do
      local item = self.rewardItemPool:GetOne()
      item:InitItemWithCount(ConfigData.item[rewardId], rewardCfg.rewardNums[index])
    end
  else
    self.ui.obj_getRewardAll:SetActive(true)
  end
  local haveRewardRedDot = self._actData:GetHaveRewardRedDot()
  self.ui.obj_rewardRedDot:SetActive(haveRewardRedDot)
end

function UIActBlackHoleMain:RefreshCfgUI()
  local uiCfg = self._actData:GetBlackHoleUICfg()
  self.ui.tex_rankDes.text = LanguageUtil.GetLocaleText(uiCfg.rank_des)
  self.ui.tex_cnName.text = LanguageUtil.GetLocaleText(uiCfg.cn_name)
  self.ui.tex_enName.text = LanguageUtil.GetLocaleText(uiCfg.en_name)
  self:_LoadBackgroundPic(uiCfg)
  self.bHRecommendNode:InitBHRecommendNode(self._actData)
end

function UIActBlackHoleMain:_LoadBackgroundPic(uiCfg)
  local path = PathConsts:GetActBlackHoleBgPath(uiCfg.BG_name)
  self.ui.img_Hero.enabled = false
  self.resloader:LoadABAssetAsync(path, function(texture)
    if texture ~= nil and not IsNull(self.gameObject) then
      self.ui.img_Hero.enabled = true
      self.ui.img_Hero.texture = texture
      local x = uiCfg.BG_pos[1] or 0
      local y = uiCfg.BG_pos[2] or 0
      local z = uiCfg.BG_pos[3] or 0
      self.ui.img_Hero.transform.anchoredPosition = Vector3.New(x, y, z)
      local w = uiCfg.BG_size[1] or 0
      local h = uiCfg.BG_size[2] or 0
      self.ui.img_Hero.transform.sizeDelta = Vector2.New(w, h)
    end
  end)
end

function UIActBlackHoleMain:RefreshBlackHoleBossTime()
  local bossFloorData = self._actData:GetBlackHoleBossFloor()
  local isBossFloor = bossFloorData and bossFloorData:GetNowScore() > 0
  self.ui.obj_bossTime:SetActive(self.haveRank and isBossFloor)
  if not self.haveRank then
    return
  end
  if not isBossFloor then
    return
  end
  self.ui.obj_bossTime.transform:SetAsLastSibling()
  self.ui.tex_bossTime.text = BattleUtil.FrameToTimeString(bossFloorData:GetNowTime(), true)
end

function UIActBlackHoleMain:RefreshBlackHoleFloor()
  UIManager:DeleteWindow(UIWindowTypeID.DungeonLevelDetail)
  self.floorItemPool:HideAll()
  local nowSelectId = self._actData:GetNowSelectFloorId()
  local lastFloorData = self._actData:GetBlackHoleLastFloor()
  local floorDataList = self._actData:GetBlackHoleFloorDataList()
  local clickItem
  local clickId = nowSelectId or lastFloorData:GetFloorDataId()
  for i, data in pairs(floorDataList) do
    local floorItem = self.floorItemPool:GetOne()
    floorItem:InitActBlackHoleFloorSelectItem(data, self._OnClickBlackHoleFloorSelectItemCallback)
    floorItem:PlayFloorSelectItemSingleAni(i * 0.05)
    if data:GetIsNewUnlock() then
      floorItem:PlayFloorSelectItemUnlockAni(i * 0.05)
    end
    if i == clickId then
      clickItem = floorItem
    end
  end
  self:_OnClickBlackHoleFloorSelectItem(floorDataList[clickId], clickItem)
  self.ui.tex_new:SetIndex(0, LanguageUtil.GetLocaleText(lastFloorData:GetBHFloorName()))
  self.ui.levelScroll.verticalNormalizedPosition = 1 - (clickId - 1) / (#floorDataList - 1)
end

function UIActBlackHoleMain:ShowRuleInfo()
  local cfg = self._actData:GetBlackHoleMainCfg()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(cfg.rule_des), ConfigData:GetTipContent(cfg.rule_title))
  end)
end

function UIActBlackHoleMain:RefreshRankList(myRank)
  if myRank == nil then
    self.ui.obj_rankInfo:SetActive(false)
    return
  end
  local inRank = myRank and myRank.inRank or false
  if inRank then
    self.ui.tex_Rank:SetIndex(0, tostring(myRank.rankParam))
  else
    self.ui.tex_Rank:SetIndex(1)
  end
end

function UIActBlackHoleMain:__TimeCountdown()
  local endTime = self._actData:GetActivityEndTime()
  local diffTime = endTime - PlayerDataCenter.timestamp
  if diffTime <= 0 then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
    return
  end
  local lastTime = math.max(diffTime, 0)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(lastTime, false, true)
  if 0 < s then
    m = m + 1
  end
  self.ui.tex_time:SetIndex(0, tostring(d), tostring(h), tostring(m))
end

function UIActBlackHoleMain:_OnClickBlackHoleDungeonStart(levelData)
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(window)
    window:SetDunLevelDetaiHideStartEvent(function()
    end)
    window:SetDunLevelDetaiHideEndEvent(function()
    end)
    window:InitDungeonLevelDetail(levelData, false)
  end)
end

function UIActBlackHoleMain:_OnClickBlackHoleFloorSelectItem(floorData, floorSelectItem)
  self.selectFloorData = floorData
  self.selectFloorItem = floorSelectItem
  self.infoItemPool:HideAll()
  local dungeonList = floorData:GetDungeonLevelList()
  local haveMaxNum = 0
  for i, dungeonData in ipairs(dungeonList) do
    local item = self.infoItemPool:GetOne()
    item:InitActBlackHoleStageInfo(dungeonData, self._OnClickBlackHoleDungeonStartCallback, i, self.resloader)
    item:PlayStageInfoSingleAni(i * 0.08)
    if 0 < dungeonData:GetBlackHoleScoreNum() then
      haveMaxNum = haveMaxNum + 1
    end
  end
  local canShowReset = 1 < #dungeonList and 0 < haveMaxNum
  self.ui.obj_selected.transform:SetParent(floorSelectItem.transform)
  self.ui.obj_selected.transform.anchoredPosition = Vector2.zero
  self.ui.tex_FrameName.text = LanguageUtil.GetLocaleText(floorData:GetBHFloorName())
  self:RefreshResetShow(canShowReset)
  self._actData:SetNowSelectFloor(self.selectFloorData:GetFloorDataId())
  self:OnClickBtnBackGround()
end

function UIActBlackHoleMain:RefreshResetShow(bool)
  self.ui.tex_normalTip:SetActive(bool)
  self.ui.img_normalTip:SetActive(bool)
  self.ui.btn_reset.gameObject:SetActive(bool)
end

function UIActBlackHoleMain:OnClickBtnBackGround()
  local win = UIManager:GetWindow(UIWindowTypeID.DungeonLevelDetail)
  if win and win.active then
    UIUtil.OnClickBackByWinId(UIWindowTypeID.DungeonLevelDetail)
  end
end

function UIActBlackHoleMain:OnClickBlackHoleReset()
  local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
  window:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(7505), function()
    NetworkManager:GetNetwork(NetworkTypeID.ActivityBlackHole):CS_Activity_BlackHole_Reset(self._actId, self.selectFloorData:GetFloorDataId(), function()
      self:_OnClickBlackHoleFloorSelectItem(self.selectFloorData, self.selectFloorItem)
    end)
  end)
end

function UIActBlackHoleMain:OnClickReceiveAll()
  NetworkManager:GetNetwork(NetworkTypeID.ActivityBlackHole):CS_Activity_BlackHole_Reward(self._actId, function(args)
    UIManager:DeleteWindow(UIWindowTypeID.StageRewardPreview)
    self:RefreshNextStageReward()
    local obj = args[0]
    local rewardDic = obj.rewards
    local rewardIds = {}
    local rewardNums = {}
    for i, v in pairs(rewardDic) do
      table.insert(rewardIds, i)
      table.insert(rewardNums, v)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums)
      window:AddAndTryShowReward(CRData)
    end)
  end)
end

function UIActBlackHoleMain:OnClickBtnGetReward()
  local rewardLIstCfg = self._actData:GetBlackHoleRewardCfg()
  local curPhase, numPhase = self._actData:GetNowRewardStage()
  local nextStageCfg = self._actData:GetNextStageRewardCfg()
  UIManager:ShowWindowAsync(UIWindowTypeID.StageRewardPreview, function(win)
    if win == nil then
    end
    win:InitUIStageRewardPreview(rewardLIstCfg, curPhase, numPhase)
    if nextStageCfg and self._actData:GetActTotalScore() >= nextStageCfg.score then
      win:SetRewardReceivedAllFunc(self._OnClickReceiveAllCallback)
    else
      win:SetRewardReceivedAllFunc(nil)
    end
  end)
end

function UIActBlackHoleMain:OnClickBtnRank()
  local rankId = self._actData:GetBlackHoleRankId()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    UIManager:HideWindow(UIWindowTypeID.ActivityBlackHoleMain)
    rankWindow:InitCommonRank(rankId, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.ActivityBlackHoleMain)
    end)
  end)
end

function UIActBlackHoleMain:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.DungeonLevelDetail)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.infoItemPool:DeleteAll()
  self.floorItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIActBlackHoleMain
