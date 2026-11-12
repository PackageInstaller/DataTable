local StarTowerMenuCtrl = class("StarTowerMenuCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
StarTowerMenuCtrl._mapNodeConfig = {
  contentRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  canvasGroup = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  btnBagPotential = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_BagPotential"
  },
  btnBagDisc = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_BagDisc"
  },
  btnMap = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Map"
  },
  rtBuildScore = {},
  imgRankIcon = {sComponentName = "Image"},
  TMPBuildScore = {sComponentName = "TMP_Text"},
  TMPBuildScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StartowerFastBattle_BuildScore"
  },
  aniBuildSweep = {
    sNodeName = "rtBuildScore",
    sComponentName = "Animator"
  },
  cgCoin = {
    sNodeName = "imgCoinBg",
    sComponentName = "CanvasGroup"
  },
  imgCoin = {sComponentName = "Image"},
  txtCoinCount = {sComponentName = "TMP_Text"}
}
StarTowerMenuCtrl._mapEventConfig = {
  LEVEL_ON_TELEPORTER_TRIGGER_RUN = "OnEvent_LevelTeleporter",
  RefreshStarTowerCoin = "OnEvent_SetCoin",
  ShowStarTowerCoin = "OnEvent_Show",
  StarTowerSetButtonEnable = "OnEvent_StarTowerSetButtonEnable",
  InputEnable = "OnEvent_InputEnable",
  StarTowerRefreshBuildScore = "OnEvent_SetBuildLevel"
}

function StarTowerMenuCtrl:Awake()
  self.bOpen = false
  self.tbSequence = {}
  self.nCoin = 0
  self.gameObject:SetActive(true)
  self._mapNode.rtBuildScore:SetActive(true)
  self._mapNode.rtBuildScore:SetActive(false)
  self:SetSprite_Coin(self._mapNode.imgCoin, AllEnum.CoinItemId.FixedRogCurrency)
  NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self.nCoin)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgCoin, 0)
end

function StarTowerMenuCtrl:OnEnable()
  if self._panel.nStarTowerId == 999 then
    self:OnEvent_StarTowerSetButtonEnable(false, false)
    self._mapNode.btnBagDisc.gameObject:SetActive(false)
    self._mapNode.btnBagPotential.gameObject:SetActive(false)
    self._mapNode.btnMap.gameObject:SetActive(false)
    self._mapNode.rtBuildScore:SetActive(false)
  else
    EventManager.Hit("StarTowerSetButtonEnable", true, true)
  end
  GamepadUIManager.AddGamepadUINode("BattleMenu", self:GetGamepadUINode())
end

function StarTowerMenuCtrl:OnDisable()
end

function StarTowerMenuCtrl:OnBtnClick_BagPotential()
  EventManager.Hit(EventId.StarTowerDepot, AllEnum.StarTowerDepotTog.Potential)
end

function StarTowerMenuCtrl:OnBtnClick_BagDisc()
  EventManager.Hit(EventId.StarTowerDepot, AllEnum.StarTowerDepotTog.DiscSkill)
end

function StarTowerMenuCtrl:OnBtnClick_Map()
  EventManager.Hit(EventId.BattleDashboardVisible, false)
  EventManager.Hit(EventId.StarTowerMap)
end

function StarTowerMenuCtrl:OnEvent_SetCoin(nCount)
  if nCount then
    if nCount > self.nCoin then
      local twCoin = DOTween.To(function()
        return self.nCoin
      end, function(v)
        NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self:ThousandsNumber(math.floor(v)))
      end, nCount, 1)
      
      local function _cb()
        self.nCoin = nCount
      end
      
      twCoin.onComplete = dotween_callback_handler(self, _cb)
    else
      NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self:ThousandsNumber(nCount))
    end
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgCoin, 0)
    self.bOpen = false
    return
  end
  if not self.bOpen then
    local tweener1 = self._mapNode.cgCoin:DOFade(1, 1)
    local tweener2 = self._mapNode.cgCoin:DOFade(0, 1)
    local sequence = DOTween.Sequence()
    sequence:Append(tweener1)
    sequence:AppendInterval(3)
    sequence:Append(tweener2)
    table.insert(self.tbSequence, sequence)
  end
end

function StarTowerMenuCtrl:OnEvent_SetBuildLevel(nScore)
  local function GetAnimName(nRank)
    if nRank <= 10 then
      return "BuildScore_Green"
    elseif nRank <= 20 then
      return "BuildScore_Blue"
    elseif nRank <= 30 then
      return "BuildScore_Gold"
    elseif nRank <= 40 then
      return "BuildScore_RainBow"
    end
    return "BuildScore_Green"
  end
  
  if not self.bOpen then
    return
  end
  self.nScore = nScore
  local nLastScore = tonumber(NovaAPI.GetTMPText(self._mapNode.TMPBuildScore))
  local nAfterScore = nScore
  if nAfterScore ~= nLastScore then
    local twCoin = DOTween.To(function()
      return nLastScore
    end, function(score)
      NovaAPI.SetTMPText(self._mapNode.TMPBuildScore, math.floor(score))
    end, nAfterScore, 1)
    
    local function _cb()
      NovaAPI.SetTMPText(self._mapNode.TMPBuildScore, nAfterScore)
    end
    
    twCoin.onComplete = dotween_callback_handler(self, _cb)
  end
  local mapBeforeRank = PlayerData.Build:CalBuildRank(nLastScore)
  local rank = PlayerData.Build:CalBuildRank(nAfterScore)
  
  local function wait()
    local imagePath = "Icon/BuildRank/BuildRank_" .. rank.Id
    self:SetPngSprite(self._mapNode.imgRankIcon, imagePath)
  end
  
  if rank.Id ~= mapBeforeRank.Id then
    local sAnimName = GetAnimName(rank.Id)
    self._mapNode.aniBuildSweep:Play(sAnimName)
    self:AddTimer(1, 0.1, wait, true, true, true)
  else
    wait()
  end
end

function StarTowerMenuCtrl:OnEvent_Show(bShow, nCount, nScore)
  self.nScore = nScore
  if nCount then
    self.nCoin = nCount
    NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self:ThousandsNumber(nCount))
  else
    NovaAPI.SetTMPText(self._mapNode.txtCoinCount, 0)
  end
  if bShow and not self.bOpen then
    if 0 < #self.tbSequence then
      for _, sequence in pairs(self.tbSequence) do
        sequence:Kill()
      end
      self.tbSequence = {}
      NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgCoin, 1)
    else
      self._mapNode.cgCoin:DOFade(1, 1)
    end
    self._mapNode.rtBuildScore:SetActive(true)
    local rank = PlayerData.Build:CalBuildRank(nScore)
    local imagePath = "Icon/BuildRank/BuildRank_" .. rank.Id
    self:SetPngSprite(self._mapNode.imgRankIcon, imagePath)
    NovaAPI.SetTMPText(self._mapNode.TMPBuildScore, math.floor(nScore))
    self.bOpen = true
  elseif not bShow and self.bOpen then
    if 0 < #self.tbSequence then
      for _, sequence in pairs(self.tbSequence) do
        sequence:Kill()
      end
      self.tbSequence = {}
    end
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgCoin, 0)
    self._mapNode.rtBuildScore:SetActive(false)
    self.bOpen = false
  end
end

function StarTowerMenuCtrl:OnEvent_StarTowerSetButtonEnable(bShow, bEnable)
  if self._panel.nStarTowerId == 999 then
    bEnable = false
    bShow = false
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bShow == true and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, bShow == true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, bShow == true)
  self._mapNode.btnBagDisc.interactable = bEnable == true
  self._mapNode.btnBagPotential.interactable = bEnable == true
  self._mapNode.btnMap.interactable = bEnable == true
end

function StarTowerMenuCtrl:OnEvent_LevelTeleporter()
  self:OnEvent_StarTowerSetButtonEnable(false, false)
end

function StarTowerMenuCtrl:OnEvent_InputEnable(bEnable)
  if self._panel.nStarTowerId == 999 then
    bEnable = false
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, bEnable == true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, bEnable == true)
  self._mapNode.btnBagDisc.interactable = bEnable == true
  self._mapNode.btnBagPotential.interactable = bEnable == true
  self._mapNode.btnMap.interactable = bEnable == true
end

return StarTowerMenuCtrl
