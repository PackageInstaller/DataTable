local UINHeroInfoStrotyNode = class("UINHeroInfoStrotyNode", UIBaseNode)
local base = UIBaseNode
local UINHeroInfoStrotyNodeLockedItem = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoStrotyNodeLockedItem")
local UINHeroInfoStrotyNodeUnlockedItem = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoStrotyNodeUnlockedItem")
local eHeroInfoenum = require("Game.Hero.NewUI.HeroInfo.eHeroInfoenum")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function UINHeroInfoStrotyNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.lockedItemPool = UIItemPool.New(UINHeroInfoStrotyNodeLockedItem, self.ui.lockedItem)
  self.unlockedItemPool = UIItemPool.New(UINHeroInfoStrotyNodeUnlockedItem, self.ui.unlockItem)
  self.ui.lockedItem:SetActive(false)
  self.ui.unlockItem:SetActive(false)
  self.lockedItemDic = {}
  self.unlockedItemDic = {}
  self.__unlockLockedItem = BindCallback(self, self.UnlockLockedItem)
  self.__playStoryVoice = BindCallback(self, self.PlayStoryVoice)
end

function UINHeroInfoStrotyNode:InitUsefulData(heroData, HeroInfoTextUtil)
  self.isPlayingVoice = false
  self.heroData = heroData
  self.HeroInfoTextUtil = HeroInfoTextUtil
  self:RefreshBuleDot()
  self.__IsHaveVoiceRes = ControllerManager:GetController(ControllerTypeId.Cv, true):HasCv(self.heroData.dataId)
end

function UINHeroInfoStrotyNode:InitHeroInfoNode()
  local friendship_awardCfg = ConfigData.friendship_award[self.heroData.dataId]
  if friendship_awardCfg == nil then
    error("hero " .. tostring(self.heroData.dataId) .. "not have friendship_awardCfg")
    return
  end
  local storyDataList = {}
  local friendShipLevel = PlayerDataCenter.allFriendshipData:GetLevel(self.heroData.dataId)
  for fsLevel, cfg in pairs(friendship_awardCfg) do
    local state
    if self.heroData:IsArchiveUnlocked(cfg.friendship_level) then
      state = eHeroInfoenum.achriveState.unlocked
    elseif fsLevel <= friendShipLevel then
      state = eHeroInfoenum.achriveState.completed
    else
      state = eHeroInfoenum.achriveState.locked
    end
    table.insert(storyDataList, {state = state, cfg = cfg})
  end
  table.sort(storyDataList, function(a, b)
    return a.cfg.friendship_level < b.cfg.friendship_level
  end)
  self.lockedItemPool:HideAll()
  self.unlockedItemPool:HideAll()
  for _, storyData in ipairs(storyDataList) do
    if storyData.state == eHeroInfoenum.achriveState.unlocked then
      local item = self.unlockedItemPool:GetOne()
      item:InitHISNUnlockedItem(storyData, self.HeroInfoTextUtil, self.__playStoryVoice, self.__IsHaveVoiceRes)
      self.unlockedItemDic[storyData.cfg.friendship_level] = item
    else
      local item = self.lockedItemPool:GetOne()
      item:InitHISNLockedItem(storyData, self.__unlockLockedItem)
      self.lockedItemDic[storyData.cfg.friendship_level] = item
    end
  end
end

function UINHeroInfoStrotyNode:RefreshBuleDot()
  local ok, heroInfoNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroData.dataId, RedDotStaticTypeId.HeroInfomation)
  if ok then
    if self.heroData:IsHaveCouldGetRewardArchive() then
      heroInfoNode:SetRedDotCount(1)
      self.ui.redDot:SetActive(true)
    else
      heroInfoNode:SetRedDotCount(0)
      self.ui.redDot:SetActive(false)
    end
  end
end

function UINHeroInfoStrotyNode:UnlockLockedItem(storyData)
  if self.__IsUnlocking then
    return
  end
  self.__IsUnlocking = true
  PlayerDataCenter:TakeHeroIdSnapShoot()
  local crTransDic = PlayerDataCenter:CalCrItemTransDic(storyData.cfg.awardIds, storyData.cfg.awardNums)
  NetworkManager:GetNetwork(NetworkTypeID.Hero):CS_HERO_Record(self.heroData.dataId, eHeroInfoenum.recordType.archives, storyData.cfg.friendship_level, function()
    self.__IsUnlocking = false
    self.heroData:SetArchiveUnlocked(storyData.cfg.friendship_level)
    local lockedItem = self.lockedItemDic[storyData.cfg.friendship_level]
    if lockedItem == nil then
      error("not have lockedItem")
      return
    end
    local siblingIndex = lockedItem.transform:GetSiblingIndex()
    storyData.state = eHeroInfoenum.achriveState.locked
    local item = self.unlockedItemPool:GetOne()
    item:InitHISNUnlockedItem(storyData, self.HeroInfoTextUtil, self.__playStoryVoice, self.__IsHaveVoiceRes)
    self.lockedItemPool:HideOne(lockedItem)
    item.transform:SetSiblingIndex(siblingIndex)
    if storyData.cfg ~= nil and storyData.cfg.awardIds ~= nil then
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          return
        end
        local CRData = CommonRewardData.CreateCRDataUseList(storyData.cfg.awardIds, storyData.cfg.awardNums):SetCRHeroSnapshoot(PlayerDataCenter:GetHeroIdSnapShoot()):SetCRItemTransDic(crTransDic)
        window:AddAndTryShowReward(CRData)
      end)
    end
    self:RefreshBuleDot()
  end)
end

function UINHeroInfoStrotyNode:PlayStoryVoice(heroId, voiceId, playerRateCallback, playOverCallback)
  if self.isPlayingVoice and self.AudioPlayback ~= nil then
    AudioManager:StopAudioByBack(self.AudioPlayback)
    self.AudioPlayback = nil
    if self.playerRateCallback ~= nil then
      self.playerRateCallback(0)
      self.playerRateCallback = nil
    end
    if self.playOverCallback ~= nil then
      self.playOverCallback()
      self.playOverCallback = nil
    end
    if self.playerRateTimerId ~= nil then
      TimerManager:StopTimer(self.playerRateTimerId)
      self.playerRateTimerId = nil
    end
  end
  if self.voiceId ~= voiceId then
    self.voiceId = voiceId
  elseif self.isPlayingVoice then
    self.isPlayingVoice = false
    return
  end
  self.playOverCallback = playOverCallback
  self.playerRateCallback = playerRateCallback
  self.isPlayingVoice = true
  self.AudioPlayback = ControllerManager:GetController(ControllerTypeId.Cv, true):PlayCv(heroId, voiceId, function()
    self.AudioPlayback = nil
    self.isPlayingVoice = false
    if self.playOverCallback ~= nil then
      self.playOverCallback()
    end
    if self.playerRateTimerId ~= nil then
      TimerManager:StopTimer(self.playerRateTimerId)
      self.playerRateTimerId = nil
    end
    if self.playerRateCallback ~= nil then
      self.playerRateCallback(0)
    end
  end)
  local sheetName, cueName = ControllerManager:GetController(ControllerTypeId.Cv, true):GetSheetNameAndCueName(heroId, voiceId)
  
  local function RefreshPlayRate()
    local curLength = 0
    local totalLength = 1
    if self.AudioPlayback ~= nil then
      totalLength = AudioManager:GetAudioLengthById(sheetName, cueName)
      curLength = AudioManager:GetAudioPlayedTime(self.AudioPlayback)
    end
    if self.playerRateCallback ~= nil then
      self.playerRateCallback(curLength / totalLength)
    end
  end
  
  RefreshPlayRate()
  self.playerRateTimerId = TimerManager:StartTimer(0.0167, function()
    RefreshPlayRate()
  end, self, false, false, false)
end

function UINHeroInfoStrotyNode:StopPlayVoice()
  if self.isPlayingVoice and self.AudioPlayback ~= nil then
    AudioManager:StopAudioByBack(self.AudioPlayback)
    self.AudioPlayback = nil
    if self.playOverCallback ~= nil then
      self.playOverCallback()
      self.playOverCallback = nil
    end
    TimerManager:StopTimer(self.playerRateTimerId)
    self.playerRateTimerId = nil
    if self.playerRateCallback ~= nil then
      self.playerRateCallback(0)
      self.playerRateCallback = nil
    end
  end
end

function UINHeroInfoStrotyNode:OnTcpLogOut_HeroInfoNode()
  TimerManager:StopTimer(self.playerRateTimerId)
  self.playerRateTimerId = nil
end

function UINHeroInfoStrotyNode:OnDelete()
  TimerManager:StopTimer(self.playerRateTimerId)
  self.playerRateTimerId = nil
  base.OnDelete(self)
end

return UINHeroInfoStrotyNode
