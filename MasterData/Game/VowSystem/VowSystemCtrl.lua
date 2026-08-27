local base = ControllerBase
local VowSystemCtrl = class("VowSystemCtrl", base)
local VowCardCtrl = require("Game.VowSystem.Ctrl.VowCardCtrl")
local VowEnum = require("Game.VowSystem.Data.VowEnum")
local JumpManager = require("Game.Jump.JumpManager")

function VowSystemCtrl:ctor()
  self.ctrls = {}
end

function VowSystemCtrl:OnInit()
  self._net = NetworkManager:GetNetwork(NetworkTypeID.Vow)
end

function VowSystemCtrl:GetVowIsUnlock()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_vow)
  if not isUnlock then
    local unlockDes = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_vow)
    return false, unlockDes
  end
  return true
end

function VowSystemCtrl:GetVowChangeNameIsUnlock()
  local openCfg = ConfigData.system_open[proto_csmsg_SystemFunctionID.SystemFunctionID_vow_nickname]
  if openCfg ~= nil and openCfg.screening then
    return false, ConfigData:GetTipContent(23010)
  end
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_vow_nickname)
  if not isUnlock then
    local unlockDes = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_vow_nickname)
    return false, unlockDes
  end
  return true
end

function VowSystemCtrl:GetVowCardCtrl(createNew)
  if createNew and self.vowCardCtrl == nil then
    self.vowCardCtrl = VowCardCtrl.New(self)
    self.vowCardCtrl:InitVowCardCtrl()
  end
  return self.vowCardCtrl
end

function VowSystemCtrl:SetSingleVowCloseCallback(callback)
  self._singleCloseCallback = callback
end

function VowSystemCtrl:SetVowBgmSourceOpen(bool)
  local homeController = ControllerManager:GetController(ControllerTypeId.HomeController)
  if bool and not self._isOpenBgm then
    self._isOpenBgm = true
    if homeController ~= nil then
      homeController:ResetShowHeroVoiceImme()
    end
    AudioManager:RecordCurBgm()
    AudioManager:StopSource(eAudioSourceType.BgmSource)
    AudioManager:RemoveAllVoice(true)
    self.bgm = AudioManager:PlayAudioById(ConfigData.hero_vow_config.bgmId)
    if not string.IsNullOrEmpty(ConfigData.hero_vow_config.bgmselector) then
      AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, ConfigData.hero_vow_config.bgmselector, ConfigData.hero_vow_config.bgmlabel)
    end
  elseif not bool and self._isOpenBgm then
    self._isOpenBgm = false
    AudioManager:StopAudioByBack(self.bgm)
    AudioManager:RemoveBgmSourceFader()
    AudioManager:ResumeLastBgm()
    AudioManager:RemoveAllVoice(true)
  end
end

function VowSystemCtrl:LoadEmptyVowScene(callback)
  UIManager:DeleteAllWindow()
  CS.GSceneManager.Instance:LoadSceneByAB(Consts.SceneName.Empty4AB, function()
    AudioManager:RecordCurBgm()
    AudioManager:StopSource(eAudioSourceType.BgmSource)
    AudioManager:RemoveAllVoice(true)
    self.bgm = AudioManager:PlayAudioById(ConfigData.hero_vow_config.bgmId)
    if not string.IsNullOrEmpty(ConfigData.hero_vow_config.bgmselector) then
      AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, ConfigData.hero_vow_config.bgmselector, ConfigData.hero_vow_config.bgmlabel)
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function VowSystemCtrl:GetVowStoryIsCheck(heroId)
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData == nil then
    return false
  end
  local vowCfg = heroData:GetVowCfg()
  if vowCfg == nil then
    return false
  end
  local avgId = vowCfg.vow_story_id
  if avgId == 0 then
    return false
  end
  return ControllerManager:GetController(ControllerTypeId.AvgPlay, true):IsAvgPlayed(avgId)
end

function VowSystemCtrl:TryShowVowAvg(heroId)
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData == nil then
    return
  end
  local vowCfg = heroData:GetVowCfg()
  if vowCfg == nil then
    return
  end
  local conList = vowCfg.vow_story_condition
  local isShowVowStoryBtn = 0 < #conList and conList[1] == 1
  if not isShowVowStoryBtn then
    return
  end
  local skinId = conList[2]
  local isHaveSkin = PlayerDataCenter.skinData:IsHaveSkin(skinId)
  local vowState = heroData:GetHeroVowState()
  if vowState == VowEnum.EVowState.Vowed and isHaveSkin then
    local avgId = vowCfg.vow_story_id
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
    avgCtrl:StartAvg(nil, avgId)
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.VowCardSign, function(win)
    win:InitVowStory(heroId)
  end)
end

function VowSystemCtrl:TryVowHero(heroId)
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData == nil then
    return
  end
  local vowCfg = heroData:GetVowCfg()
  if vowCfg == nil then
    return
  end
  self._heroId = heroId
  
  local function reqFunc(isSpecialCost)
    if not isSpecialCost then
      local costEnough = true
      local heroData = PlayerDataCenter.heroDic[heroId]
      local heroVowCfg = heroData:GetVowCfg()
      for rewardId, rewardNum in pairs(heroVowCfg.vow_cost) do
        if rewardNum > PlayerDataCenter:GetItemCount(rewardId) then
          costEnough = false
          break
        end
      end
      if not costEnough then
        local windonw = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
        windonw:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(23013), function()
          JumpManager:Jump(JumpManager.eJumpTarget.ShopVow)
        end)
        return
      end
    end
    self:ReqVow(heroId, isSpecialCost, function()
      AudioManager:PlayAudioById(1284)
      self:GetVowCardCtrl(true):SetVowEnterLeaveFunc(self._enterFunc, self._leaveFunc)
      self:ShowVowShow(heroId)
      self:SetVowBgmSourceOpen(true)
    end)
  end
  
  UIManager:ShowWindowAsync(UIWindowTypeID.VowCardSign, function(win)
    win:InitVowSign(heroId, function(hasSpecialCost, isSpecialCost, hasNormalVowItemCount, specialCostId)
      local specialCostItemNum = PlayerDataCenter:GetItemCount(specialCostId)
      if hasSpecialCost and not isSpecialCost and hasNormalVowItemCount then
        local tip = ConfigData:GetTipContent(23019)
        local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
        window:ShowTextBoxWithYesAndNo(tip, function()
          reqFunc(isSpecialCost)
        end, nil, true)
      elseif hasSpecialCost and isSpecialCost and specialCostItemNum <= 0 then
        local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
        window:InitCommonItemDetail(ConfigData.item[specialCostId])
      else
        reqFunc(isSpecialCost)
      end
    end)
  end)
end

function VowSystemCtrl:ShowVowShow(heroId)
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData == nil then
    return
  end
  local vowCfg = heroData:GetVowCfg()
  if vowCfg == nil then
    return
  end
  
  local function skipFunc()
    UIManager:ShowWindow(UIWindowTypeID.CommonMask):InitCommonMask(Color.black):CommonMaskFadeOut(1, function()
      if self._isSkip then
        local vowCardCtrl = self:GetVowCardCtrl(true)
        vowCardCtrl:ForceEnterVowCheckState()
      end
      UIManager:DeleteWindow(UIWindowTypeID.CommonMask)
    end)
  end
  
  UIManager:ShowWindowAsync(UIWindowTypeID.VowShow, function(window)
    window:InitVowCardShow(heroId, function(isSkip)
      self._isSkip = isSkip
      local vowCardCtrl = self:GetVowCardCtrl(true)
      vowCardCtrl:SetVowEnterLeaveFunc(self._enterFunc, self._leaveFunc)
      if heroData:GetIsSetVowCard() then
        vowCardCtrl:LoadAndCheckCard(heroId, skipFunc)
      else
        vowCardCtrl:LoadAndSetCard(heroId, skipFunc)
      end
    end)
  end)
end

function VowSystemCtrl:SetCardCtrlFunc(enterFunc, leaveFunc)
  self._enterFunc = enterFunc
  self._leaveFunc = leaveFunc
end

function VowSystemCtrl:CheckVowCard(heroId)
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData == nil then
    return
  end
  local vowCfg = heroData:GetVowCfg()
  if vowCfg == nil then
    return
  end
  self._heroId = heroId
  local vowCardCtrl = self:GetVowCardCtrl(true)
  vowCardCtrl:SetVowEnterLeaveFunc(self._enterFunc, self._leaveFunc)
  vowCardCtrl:LoadAndCheckCard(heroId, nil)
  self:SetVowBgmSourceOpen(true)
end

function VowSystemCtrl:LeaveVow(isShowAvg)
  if self.vowCardCtrl ~= nil then
    self.vowCardCtrl:Delete()
    self.vowCardCtrl = nil
  end
  if self._singleCloseCallback ~= nil then
    self._singleCloseCallback()
    self._singleCloseCallback = nil
  end
  if not isShowAvg then
    self:Delete()
  end
end

function VowSystemCtrl:LeaveVowScene()
  AudioManager:StopAudioByBack(self.bgm)
  AudioManager:RemoveBgmSourceFader()
  AudioManager:ResumeLastBgm()
  AudioManager:RemoveAllVoice(true)
  UIManager:ShowWindow(UIWindowTypeID.VowMask):InitCommonMask(Color.black):CommonMaskFadeIn(0.3, function()
    CS.GSceneManager.Instance:LoadSceneByAB(Consts.SceneName.Main, function()
      ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
      UIManager:CreateWindowAsync(UIWindowTypeID.Home)
      if self._heroId ~= nil then
        JumpManager:Jump(JumpManager.eJumpTarget.Hero, nil, function()
          local win = UIManager:GetWindow(UIWindowTypeID.HeroList)
          if win ~= nil then
            local heroData = PlayerDataCenter:GetHeroData(self._heroId)
            win:Roll2Hero(heroData.dataId)
            win:OnSelHeroItemClick(heroData, nil, function()
              UIManager:ShowWindow(UIWindowTypeID.VowMask):InitCommonMask(Color.black):CommonMaskFadeOut(0.3, function()
                UIManager:DeleteWindow(UIWindowTypeID.VowMask)
                if self._singleCloseCallback ~= nil then
                  self._singleCloseCallback()
                  self._singleCloseCallback = nil
                end
              end)
            end)
          end
          self._heroId = nil
        end, {
          self._heroId
        })
      end
    end)
  end)
end

function VowSystemCtrl:SkipToCheckCardState()
  local cardCtrl = self:GetVowCardCtrl()
  if cardCtrl == nil then
    return
  end
  cardCtrl:ForceEnterVowCheckState()
end

function VowSystemCtrl:GetHeroName(heroId, isShowVowName)
  local isContain = PlayerDataCenter:ContainsHeroData(heroId)
  if isContain then
    local heroData = PlayerDataCenter:GetHeroData(heroId)
    return heroData:GetHeroName(isShowVowName)
  end
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    error("cant find heroId:" .. heroId)
    return
  end
  return LanguageUtil.GetLocaleText(heroCfg.name)
end

function VowSystemCtrl:ReqVow(heroId, isSpecialCost, callback)
  self._net:CS_HERO_Vow(heroId, isSpecialCost, callback)
end

function VowSystemCtrl:ReqVowSign(heroId, sign, callback)
  self._net:CS_HERO_Vow_Sign(heroId, sign, callback)
end

function VowSystemCtrl:ReqVowModifyName(heroId, name, callback)
  self._net:CS_HERO_Vow_Modify_Name(heroId, name, callback)
end

function VowSystemCtrl:OnDelete()
  for ctrl, _ in pairs(self.ctrls) do
    ctrl:Delete()
  end
  self:SetVowBgmSourceOpen(false)
  base.OnDelete(self)
end

return VowSystemCtrl
