local VampireFateCardInfoCtrl = class("VampireFateCardInfoCtrl", BaseCtrl)
VampireFateCardInfoCtrl._mapNodeConfig = {
  TMPFateCardTitleInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_FateCardInfo_Title"
  },
  TMPAcqDesc = {sComponentName = "TMP_Text"},
  tcFateCard = {
    sCtrlName = "Game.UI.VampireSurvivor.FateCardItemCtrl"
  },
  TMPAcqTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_FateCardAcqTitle"
  },
  grid = {
    sNodeName = "grid_",
    nCount = 5,
    sCtrlName = "Game.UI.VampireLevelSelect.VampireFateCardInfo.VampireFateCardInfo_fateCardPackageCtrl"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnScreenClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  rtWindow = {},
  ani = {sNodeName = "rtWindow", sComponentName = "Animator"},
  snapshot = {}
}
VampireFateCardInfoCtrl._mapEventConfig = {
  VampireFardInfoSelectFateCard = "OnEvent_SelectFateCard"
}
VampireFateCardInfoCtrl._mapRedDotConfig = {}

function VampireFateCardInfoCtrl:Awake()
  self._canvas = self.gameObject:GetComponent("Canvas")
  self.curFateCardItem = nil
end

function VampireFateCardInfoCtrl:FadeIn()
end

function VampireFateCardInfoCtrl:FadeOut()
end

function VampireFateCardInfoCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.nLevelId = tbParam[1]
  local initFateCard = 0
  local mapVampireSurvivorCfgData = ConfigTable.GetData("VampireSurvivor", self.nLevelId)
  if mapVampireSurvivorCfgData == nil then
    return
  end
  self.tbBundle = {}
  if mapVampireSurvivorCfgData.Type == GameEnum.vampireSurvivorType.Turn then
    local nSeasonId = PlayerData.VampireSurvivor:GetCurSeason()
    local mapSeason = ConfigTable.GetData("VampireRankSeason", nSeasonId)
    if mapSeason ~= nil then
      self.tbExFateCard = decodeJson(mapSeason.SpeciaFateCard)
      self.tbBundle = mapSeason.FateCardBundle
    end
  else
    self.tbExFateCard = decodeJson(mapVampireSurvivorCfgData.SpeciaFateCard)
    self.tbBundle = mapVampireSurvivorCfgData.FateCardBundle
  end
  if self.tbExFateCard == nil then
    self.tbExFateCard = {}
  end
  local mapBundle = PlayerData.StarTowerBook:GetAllFateCardBundle()
  local mapFirstCtrl, nRetId
  for i = 1, 5 do
    if self.tbBundle[i] ~= nil then
      local nBundleId = self.tbBundle[i]
      local mapBundleInfo = mapBundle[nBundleId]
      local tbFateCard = {}
      if mapBundleInfo ~= nil then
        tbFateCard = mapBundleInfo.tbCardList
      end
      local ret, retId = self._mapNode.grid[i]:Refresh(nBundleId, tbFateCard, self.tbExFateCard[i])
      if i == 1 then
        mapFirstCtrl = ret
        nRetId = retId
      end
    else
      self._mapNode.grid[i].gameObject:SetActive(false)
    end
  end
  if mapFirstCtrl ~= nil then
    self:OnEvent_SelectFateCard(nRetId, mapFirstCtrl)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.UIEffectSnapShotCapture(self._mapNode.snapshot)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.rtWindow:SetActive(true)
    self._mapNode.ani:Play("t_window_04_t_in")
  end
  
  cs_coroutine.start(wait)
end

function VampireFateCardInfoCtrl:OnDisable()
end

function VampireFateCardInfoCtrl:OnDestroy()
end

function VampireFateCardInfoCtrl:OnRelease()
end

function VampireFateCardInfoCtrl:OnBtnClick_Close()
  self._mapNode.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.17, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.VampireSurvivorFateCardInfo)
  end, true, true, true)
end

function VampireFateCardInfoCtrl:OnEvent_SelectFateCard(nFateCardId, mapCtrl)
  self._mapNode.tcFateCard.gameObject:SetActive(true)
  self._mapNode.tcFateCard:SetFateCardItem(nFateCardId, false)
  if self.curFateCardItem ~= nil then
    self.curFateCardItem:SetChoose(false)
  end
  mapCtrl:SetChoose(true)
  self.curFateCardItem = mapCtrl
  self:SetAcq(nFateCardId)
end

function VampireFateCardInfoCtrl:isExFateCard(nFateCardId)
  for i, tbExFateCard in ipairs(self.tbExFateCard) do
    if table.indexof(tbExFateCard, nFateCardId) > 0 then
      return true, i
    end
  end
  return false, 0
end

function VampireFateCardInfoCtrl:SetAcq(nFateCardId)
  local bEx, nIdx = self:isExFateCard(nFateCardId)
  if not bEx then
    NovaAPI.SetTMPText(self._mapNode.TMPAcqDesc, ConfigTable.GetUIText("Vampire_FateCardAcqNormal"))
  else
    local nBundleId = self.tbBundle[nIdx]
    if nBundleId == nil then
      NovaAPI.SetTMPText(self._mapNode.TMPAcqDesc, ConfigTable.GetUIText("Vampire_FateCardAcqNormal"))
    end
    local mapBundle = ConfigTable.GetData("StarTowerBookFateCardBundle", nBundleId)
    if mapBundle == nil then
      NovaAPI.SetTMPText(self._mapNode.TMPAcqDesc, ConfigTable.GetUIText("Vampire_FateCardAcqNormal"))
    end
    local sName = mapBundle.Name
    local mapVampireSurvivorCfgData = ConfigTable.GetData("VampireSurvivor", self.nLevelId)
    if mapVampireSurvivorCfgData == nil then
      return
    end
    local tbParam = {}
    if mapVampireSurvivorCfgData.Type == GameEnum.vampireSurvivorType.Turn then
      local nSeasonId = PlayerData.VampireSurvivor:GetCurSeason()
      local mapSeason = ConfigTable.GetData("VampireRankSeason", nSeasonId)
      if mapSeason ~= nil then
        tbParam = decodeJson(mapSeason.SpeciaFateCardParam)
      end
    else
      tbParam = decodeJson(mapVampireSurvivorCfgData.SpeciaFateCardParam)
    end
    if tbParam == nil then
      NovaAPI.SetTMPText(self._mapNode.TMPAcqDesc, ConfigTable.GetUIText("Vampire_FateCardAcqNormal"))
    end
    local nParamIdx = table.indexof(self.tbExFateCard[nIdx], nFateCardId)
    local nCount = 0
    if tbParam[nIdx] ~= nil and tbParam[nIdx][nParamIdx] ~= nil then
      nCount = tbParam[nIdx][nParamIdx]
    end
    NovaAPI.SetTMPText(self._mapNode.TMPAcqDesc, orderedFormat(ConfigTable.GetUIText("Vampire_FateCardAcqEx"), nCount, sName))
  end
end

return VampireFateCardInfoCtrl
