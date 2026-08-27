local UINFriendshipLevel = class("UINFriendshipLevel", UIBaseNode)
local base = UIBaseNode
local UINTweenUtil = require("Game.CommonUI.Tween.UINTweenUtil")
local VowEnum = require("Game.VowSystem.Data.VowEnum")
local cs_MessageCommon = CS.MessageCommon

function UINFriendshipLevel:OnInit()
  self.curLevel = nil
  self.curExp = nil
  self.addExp = nil
  self.nextLevel = nil
  self.curTotalExp = nil
  self.levelTotalExp = {}
  self.overflowExp = 0
  self.maxLevel = #ConfigData.friendship_level
  self.noVowMaxLevel = ConfigData.hero_vow_config.basicVowLevel
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.levelTotalExp[0] = 0
  for level, data in ipairs(ConfigData.friendship_level) do
    self.levelTotalExp[level] = self.levelTotalExp[level - 1] + data.friendship
  end
  UIUtil.AddButtonListener(self.ui.btn_VowEntrance, self, self.__OnClickVowEntrance)
end

function UINFriendshipLevel:InitFriendShipPresent(heroId)
  self.curLevel = PlayerDataCenter.allFriendshipData:GetLevel(heroId)
  self.curExp = PlayerDataCenter.allFriendshipData:GetExp(heroId)
  self.curTotalExp = self.levelTotalExp[self.curLevel - 1] + self.curExp
  self.addExp = 0
  self.nextLevel = self.curLevel
  if self.heroId ~= heroId then
    self:_KillExpBarSeq()
  end
  self.heroId = heroId
  if not self._hasExpTween then
    self:RefrshUI()
  end
end

function UINFriendshipLevel:AddExp(exp, singleAddExp)
  if exp == nil or singleAddExp == nil then
    return false, 0
  end
  local isVowed = PlayerDataCenter:GetHeroData(self.heroId):GetHeroIsVowed()
  if not isVowed and self.nextLevel >= self.noVowMaxLevel then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(23014))
    return false, 0
  end
  if self.nextLevel >= self.maxLevel then
    return false, 0
  end
  local maxNeedExp = exp
  self.addExp = self.addExp + exp
  while self.addExp + self.curTotalExp >= self.levelTotalExp[self.nextLevel] do
    if self.nextLevel == self.maxLevel then
      maxNeedExp = self.levelTotalExp[self.nextLevel] - (self.addExp - exp + self.curTotalExp)
      self.addExp = self.addExp - exp + maxNeedExp
      self.overflowExp = exp - maxNeedExp
      self.overflowExp = self.overflowExp % singleAddExp
      break
    end
    self.nextLevel = self.nextLevel + 1
    if not isVowed and self.nextLevel >= self.noVowMaxLevel then
      local curMaxExp = self.levelTotalExp[self.noVowMaxLevel - 1]
      local preOverflowExp = self.curTotalExp + self.addExp - curMaxExp
      local overflowNum = math.floor(preOverflowExp / singleAddExp)
      local overflowItemExp = overflowNum * singleAddExp
      maxNeedExp = maxNeedExp - overflowItemExp
      self.addExp = self.addExp - overflowItemExp
    end
  end
  self:_KillExpBarSeq()
  self:RefrshUI()
  return true, maxNeedExp
end

function UINFriendshipLevel:MinExp(exp)
  if self.overflowExp ~= 0 then
    local oExp = exp
    exp = oExp - self.overflowExp
    self.overflowExp = self.overflowExp - oExp
    if self.overflowExp <= 0 then
      self.overflowExp = 0
    end
    if exp < 0 then
      exp = 0
    end
  end
  self.addExp = math.max(self.addExp - exp, 0)
  while self.addExp + self.curTotalExp < self.levelTotalExp[self.nextLevel - 1] do
    self.nextLevel = self.nextLevel - 1
  end
  self:_KillExpBarSeq()
  self:RefrshUI()
  AudioManager:PlayAudioById(1065)
  return true
end

function UINFriendshipLevel:RefrshUI()
  self.ui.tex_CurrentLevel:SetIndex(0, tostring(self.curLevel))
  local isUnder = self.nextLevel > self.curLevel
  self.ui.arrow:SetActive(isUnder)
  self.ui.tex_NextLevel.gameObject:SetActive(isUnder)
  if isUnder then
    self.ui.tex_NextLevel:SetIndex(0, tostring(self.nextLevel))
  end
  if 0 < self.addExp then
    self.ui.tex_AddExp.gameObject:SetActive(true)
    self.ui.tex_AddExp:SetIndex(0, tostring(self.addExp))
  else
    self.ui.tex_AddExp.gameObject:SetActive(false)
  end
  local thisLevelExp = ConfigData.friendship_level[self.nextLevel].friendship
  local lastLevelExp = self.levelTotalExp[self.nextLevel - 1]
  local thisLevelHasExp = self.addExp + self.curTotalExp - lastLevelExp
  local isVowed = PlayerDataCenter:GetHeroData(self.heroId):GetHeroIsVowed()
  if not isVowed and self.nextLevel == self.noVowMaxLevel then
    thisLevelHasExp = 0
  end
  self.ui.tex_TotalExp:SetIndex(0, tostring(thisLevelHasExp), tostring(thisLevelExp))
  self.ui.img_Bar.fillAmount = thisLevelHasExp / thisLevelExp
  self.whenAddData = {
    level = self.nextLevel,
    exp = thisLevelHasExp
  }
  self.tweenDiffData = {
    oldLevel = self.curLevel,
    oldRate = self.curTotalExp ~= 0 and self.curExp / self.curTotalExp or 0,
    level = self.nextLevel,
    rate = thisLevelHasExp / thisLevelExp
  }
  local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  if not vowSystemCtrl:GetVowIsUnlock() then
    self.ui.btn_VowEntrance.gameObject:SetActive(false)
  else
    local heroData = PlayerDataCenter.heroDic[self.heroId]
    local vowState = heroData == nil and VowEnum.EVowState.NoData or heroData:GetHeroVowState()
    local isHideVowBtn = vowState == VowEnum.EVowState.NoData or vowState == VowEnum.EVowState.CanNotVow
    self.ui.btn_VowEntrance.gameObject:SetActive(not isHideVowBtn)
    if vowState == VowEnum.EVowState.Vowed then
      self.ui.tex_VowEntrance:SetIndex(1)
    else
      self.ui.tex_VowEntrance:SetIndex(0)
    end
  end
end

function UINFriendshipLevel:__OnClickVowEntrance()
  local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  if not vowSystemCtrl:GetVowIsUnlock() then
    return
  end
  local heroData = PlayerDataCenter.heroDic[self.heroId]
  local vowState = heroData:GetHeroVowState()
  if vowState == VowEnum.EVowState.NoData or vowState == VowEnum.EVowState.CanNotVow then
    return
  end
  
  local function enterVowFunc()
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.HeroState)
  end
  
  vowSystemCtrl:SetCardCtrlFunc(enterVowFunc)
  if vowState == VowEnum.EVowState.CanVow then
    vowSystemCtrl:TryVowHero(heroData.dataId)
  else
    vowSystemCtrl:CheckVowCard(heroData.dataId)
  end
end

function UINFriendshipLevel:GetMaxAddableEXP(includeNewAdd)
  if includeNewAdd then
    return self.levelTotalExp[self.maxLevel] - (self.addExp + self.curTotalExp)
  else
    return self.levelTotalExp[self.maxLevel] - self.curTotalExp
  end
end

function UINFriendshipLevel:ShowExpBarTween(tweenDiffData)
  self.ui.tex_CurrentLevel:SetIndex(0, tostring(tweenDiffData.oldLevel))
  self._hasExpTween = true
  self._expSeq = UINTweenUtil.CreateExpBarSequence(self.ui.img_Bar, tweenDiffData, nil, function()
    self:_KillExpBarSeq()
    self:RefrshUI()
  end, function(tempLevel)
    self.ui.tex_CurrentLevel:SetIndex(0, tostring(tempLevel))
  end)
end

function UINFriendshipLevel:_KillExpBarSeq()
  self._hasExpTween = false
  if self._expSeq ~= nil then
    self._expSeq:Kill()
    self._expSeq = nil
  end
end

function UINFriendshipLevel:OnDelete()
  self:_KillExpBarSeq()
  base.OnDelete(self)
end

return UINFriendshipLevel
