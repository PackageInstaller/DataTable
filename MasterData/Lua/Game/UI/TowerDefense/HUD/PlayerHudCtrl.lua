local PlayerHudCtrl = class("PlayerHudCtrl", BaseCtrl)
local barWidth = 122
local chargeColor = Color(0.4, 1.0, 0.996078431372549, 1)
local costColor = Color(0.9921568627450981, 0.3215686274509804, 0.4745098039215686, 1)
PlayerHudCtrl._mapNodeConfig = {
  go_Level = {nCount = 6},
  go_LevelUpTips = {},
  skillBar = {},
  bar = {
    sComponentName = "RectTransform"
  },
  img_bar = {sNodeName = "bar", sComponentName = "Image"},
  go_levelUpDes = {},
  txt_upDes = {sComponentName = "TMP_Text"}
}
PlayerHudCtrl._mapEventConfig = {
  TowerDefense_character_levelUp = "OnEvent_LevelUp",
  TowerDefensePointChange = "OnEvent_PointChange",
  ResetEnergy = "OnEvent_UpdateEnergy",
  BeginSkill = "OnEvent_BeginSkill",
  TowerDefenseShowFullScreenPanel = "OnEvent_PauseEnergy",
  TowerDefenseShowHideScreenPanel = "OnEvent_ResumeEnergy",
  TowerDefenseFuncShow = "OnEvent_FuncShow",
  TowerDefenseCheckTips = "OnEvent_CheckTips"
}
PlayerHudCtrl._mapRedDotConfig = {}

function PlayerHudCtrl:Awake()
  self:Init()
end

function PlayerHudCtrl:OnDestroy()
  if self.tweener ~= nil then
    self.tweener:Kill()
  end
end

function PlayerHudCtrl:Init()
  for _, go in pairs(self._mapNode.go_Level) do
    go:SetActive(false)
  end
  self.nPoint = 0
  self.bFuncIsShow = false
end

function PlayerHudCtrl:SetPlayerId(characterId)
  self:Init()
  self.nCharacterId = characterId
  self._mapNode.go_Level[1]:SetActive(true)
  self.nlevel = 1
  self._mapNode.go_levelUpDes:SetActive(false)
  self._mapNode.go_LevelUpTips:SetActive(false)
  self._mapNode.skillBar:SetActive(false)
end

function PlayerHudCtrl:CheckTips()
  if self.bFuncIsShow then
    self._mapNode.go_LevelUpTips:SetActive(false)
    return
  end
  local config = ConfigTable.GetData("TowerDefenseCharacter", self.nCharacterId)
  if config == nil then
    return
  end
  local needPoint = config.PointNeeded[self.nlevel]
  if needPoint ~= nil then
    self._mapNode.go_LevelUpTips:SetActive(needPoint <= self.nPoint)
  else
    self._mapNode.go_LevelUpTips:SetActive(false)
  end
end

function PlayerHudCtrl:OnEvent_LevelUp(nCharacterId, nlevel)
  if self.nCharacterId ~= nCharacterId then
    return
  end
  self._mapNode.go_Level[self.nlevel]:SetActive(false)
  self.nlevel = nlevel
  self._mapNode.go_Level[self.nlevel]:SetActive(true)
  local config = ConfigTable.GetData("TowerDefenseCharacter", self.nCharacterId)
  if config == nil then
    return
  end
  self._mapNode.go_levelUpDes:SetActive(false)
  if self.timer ~= nil then
    self.timer:_Stop()
  end
  if #config["NewPotential" .. nlevel] == 1 then
    local id = config["NewPotential" .. nlevel][1]
    local potentialConfig = ConfigTable.GetData("TowerDefensePotential", id)
    if potentialConfig == nil then
      return
    end
    NovaAPI.SetTMPText(self._mapNode.txt_upDes, potentialConfig.Name)
    self._mapNode.go_levelUpDes:SetActive(true)
    
    local function cb()
      self._mapNode.go_levelUpDes:SetActive(false)
    end
    
    self.timer = self:AddTimer(1, 1.5, cb, true, true, true)
  end
end

function PlayerHudCtrl:OnEvent_PointChange(nPoint)
  if self.nCharacterId == nil then
    return
  end
  self.nPoint = nPoint
  self:CheckTips()
end

function PlayerHudCtrl:OnEvent_UpdateEnergy(entityId, characterId, skillId, curCd, maxCd, isAuto)
  if characterId ~= self.nCharacterId then
    return
  end
  NovaAPI.SetImageColor(self._mapNode.img_bar, chargeColor)
  local cdValue = curCd:AsFloat() or 0
  local cdMaxValue = maxCd:AsFloat() or 0
  cdValue = math.max(0, cdMaxValue - cdValue)
  if self.tweener ~= nil then
    self.tweener:Kill()
  end
  self._mapNode.skillBar:SetActive(true)
  if isAuto then
    self.tweener = DOTween.To(function()
      return cdMaxValue - cdValue
    end, function(v)
      self._mapNode.bar.sizeDelta = Vector2(barWidth * (v / cdMaxValue), self._mapNode.bar.sizeDelta.y)
    end, cdMaxValue, cdValue):OnComplete(function()
      self._mapNode.bar.sizeDelta = Vector2(barWidth, self._mapNode.bar.sizeDelta.y)
    end)
  else
    self._mapNode.bar.sizeDelta = Vector2(barWidth * ((cdMaxValue - cdValue) / cdMaxValue), self._mapNode.bar.sizeDelta.y)
  end
end

function PlayerHudCtrl:OnEvent_BeginSkill(entityId, characterId, skillId, totalTime)
  if characterId ~= self.nCharacterId then
    return
  end
  NovaAPI.SetImageColor(self._mapNode.img_bar, costColor)
  local nTotalTime = totalTime:AsFloat() or 0
  if self.tweener ~= nil then
    self.tweener:Kill()
  end
  self._mapNode.skillBar:SetActive(true)
  self.tweener = DOTween.To(function()
    return 1
  end, function(v)
    self._mapNode.bar.sizeDelta = Vector2(barWidth * v, self._mapNode.bar.sizeDelta.y)
  end, 0, nTotalTime):OnComplete(function()
    self._mapNode.bar.sizeDelta = Vector2(0, self._mapNode.bar.sizeDelta.y)
  end)
end

function PlayerHudCtrl:OnEvent_PauseEnergy()
  if self.tweener == nil then
    return
  end
end

function PlayerHudCtrl:OnEvent_ResumeEnergy()
  if self.tweener == nil then
    return
  end
end

function PlayerHudCtrl:OnEvent_FuncShow(bIsShow, characterId)
  if characterId ~= self.nCharacterId then
    return
  end
  self.bFuncIsShow = bIsShow
  if self.bFuncIsShow then
    self._mapNode.go_LevelUpTips:SetActive(false)
  else
    self:CheckTips()
  end
end

function PlayerHudCtrl:OnEvent_CheckTips()
  self:CheckTips()
end

return PlayerHudCtrl
