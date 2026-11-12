local WorldClassUpgradeCtrl = class("WorldClassUpgradeCtrl", BaseCtrl)
WorldClassUpgradeCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  btnMaskClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  txtRankNum = {sComponentName = "TMP_Text"},
  goLevelUp = {},
  imgLevelUp = {sComponentName = "Image"},
  goLevelUpEffect = {},
  imgSvBg = {},
  imgSingleBg = {},
  goEffect = {nCount = 3},
  imgLine = {},
  txtEffect1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "World_Class_Upgrade_1"
  },
  txtEffect2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "World_Class_Upgrade_2"
  },
  txtEffect3 = {sComponentName = "TMP_Text"},
  txtEffectValue = {nCount = 3, sComponentName = "TMP_Text"},
  txtRankText = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Name"
  },
  goAdvance = {},
  imgAdvance = {sComponentName = "Image"},
  txtAdvanceCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Upgrade_Advance"
  },
  txtLevel = {sComponentName = "TMP_Text"},
  btnRewardItem = {
    nCount = 6,
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardItem"
  },
  goRewardItem = {
    nCount = 6,
    sNodeName = "btnRewardItem",
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  }
}
WorldClassUpgradeCtrl._mapEventConfig = {}

function WorldClassUpgradeCtrl:SetOldWorldClass()
  self.nOldWorldClass = PlayerData.Base:GetOldWorldClass()
  local nOldWorldExp = PlayerData.Base:GetOldWorldExp()
  local mapOldCfg = ConfigTable.GetData("WorldClass", self.nOldWorldClass + 1, true)
  local nOldFullExp = 0
  if mapOldCfg then
    nOldFullExp = mapOldCfg.Exp
  end
  NovaAPI.SetTMPText(self._mapNode.txtRankNum, self.nOldWorldClass)
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local nCurExp = PlayerData.Base:GetWorldExp()
  local mapCfg = ConfigTable.GetData("WorldClass", nWorldClass + 1, true)
  local nFullExp = 0
  if mapCfg then
    nFullExp = mapCfg.Exp
  end
  NovaAPI.SetTMPText(self._mapNode.txtLevel, self.nOldWorldClass)
  self._mapNode.goLevelUpEffect.gameObject:SetActive(false)
  self:AddTimer(1, 0.8, function()
    self:Refresh()
  end, true, true, true)
end

function WorldClassUpgradeCtrl:Refresh()
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local mapCurCfg = ConfigTable.GetData("WorldClass", nWorldClass)
  local mapOldCfg = ConfigTable.GetData("WorldClass", self.nOldWorldClass)
  self._mapNode.goLevelUpEffect.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtRankNum, nWorldClass)
  local bOpenFunc, bRewardLimitChange = false
  local nChangeCount = 0
  if mapCurCfg.FuncChangeText1 ~= "" then
    bOpenFunc = true
    nChangeCount = nChangeCount + 1
  end
  if mapCurCfg.RewardLimit ~= mapOldCfg.RewardLimit and 0 < mapCurCfg.RewardLimit then
    bRewardLimitChange = true
    nChangeCount = nChangeCount + 1
  end
  self._mapNode.imgSvBg.gameObject:SetActive(nChangeCount == 2)
  self._mapNode.imgSingleBg.gameObject:SetActive(nChangeCount == 1)
  if nChangeCount == 1 then
    if bOpenFunc then
      NovaAPI.SetTMPText(self._mapNode.txtEffect3, mapCurCfg.FuncChangeText1)
      self._mapNode.txtEffectValue[3].gameObject:SetActive(false)
    elseif bRewardLimitChange then
      NovaAPI.SetTMPText(self._mapNode.txtEffect3, ConfigTable.GetUIText("World_Class_Upgrade_2"))
      NovaAPI.SetTMPText(self._mapNode.txtEffectValue[3], mapCurCfg.RewardLimit)
    end
  elseif nChangeCount == 2 then
    NovaAPI.SetTMPText(self._mapNode.txtEffectValue[1], "+" .. mapCurCfg.DoubleCount)
    NovaAPI.SetTMPText(self._mapNode.txtEffect2, mapCurCfg.FuncChangeText1)
    self._mapNode.txtEffectValue[2].gameObject:SetActive(false)
  end
end

function WorldClassUpgradeCtrl:RefreshAdvance()
  local tbWorldClass = CacheTable.Get("_DemonAdvance")
  local bMax = self.nDemonId == tbWorldClass[#tbWorldClass].Id
  local mapDemonAdvanceCfg = ConfigTable.GetData("DemonAdvance", self.nDemonId)
  if mapDemonAdvanceCfg ~= nil then
    if not bMax then
      local mapNextCfg = ConfigTable.GetData("DemonAdvance", self.nDemonId + 1)
      if mapNextCfg ~= nil then
        NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("WorldClass_Upgrade_Level_Limit"), mapNextCfg.LevelRange[2]))
      end
    end
    self._mapNode.txtLevel.gameObject:SetActive(not bMax)
    NovaAPI.SetTMPText(self._mapNode.txtRankNum, mapDemonAdvanceCfg.LevelRange[2])
    self.tbReward = {}
    for _, v in ipairs(self._mapNode.btnRewardItem) do
      v.gameObject:SetActive(false)
    end
    for i = 1, 4 do
      if mapDemonAdvanceCfg["Item" .. i] ~= 0 then
        local nId = mapDemonAdvanceCfg["Item" .. i]
        local nCount = mapDemonAdvanceCfg["Qty" .. i]
        self._mapNode.btnRewardItem[i].gameObject:SetActive(true)
        self._mapNode.goRewardItem[i]:SetItem(nId, nil, nCount, nil, nil, nil, nil, true)
        table.insert(self.tbReward, {nId = nId, nCount = nCount})
      end
    end
  end
end

function WorldClassUpgradeCtrl:FadeIn()
end

function WorldClassUpgradeCtrl:Awake()
end

function WorldClassUpgradeCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.nDemonId = 0
  if nil ~= tbParam then
    if tbParam[1] ~= nil then
      self.nDemonId = tbParam[1].nDemonId or 0
      self.callback = tbParam[1].callback
    end
    self.cbClose = tbParam[2]
  end
  self._mapNode.imgBlurredBg.gameObject:SetActive(true)
  self._mapNode.goRoot.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goRoot.gameObject:SetActive(true)
    self._mapNode.goLevelUp.gameObject:SetActive(self.nDemonId == 0)
    self._mapNode.goAdvance.gameObject:SetActive(self.nDemonId ~= 0)
    NovaAPI.SetImageNativeSize(self._mapNode.imgLevelUp)
    NovaAPI.SetImageNativeSize(self._mapNode.imgAdvance)
    if self.nDemonId ~= 0 then
      self._mapNode.animRoot:Play("WorldClassBreak", 0, 0)
      self:RefreshAdvance()
    else
      self._mapNode.animRoot:Play("WorldClassUp", 0, 0)
      self:SetOldWorldClass()
    end
  end
  
  cs_coroutine.start(wait)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
end

function WorldClassUpgradeCtrl:OnDisable()
end

function WorldClassUpgradeCtrl:OnDestroy()
  if nil ~= self.callback then
    self.callback()
  end
  if nil ~= self.cbClose then
    self.cbClose()
  end
end

function WorldClassUpgradeCtrl:OnBtnClick_Close()
  local function closePanel()
    PlayerData.Base:SetWorldClassChange(false)
    
    EventManager.Hit(EventId.ClosePanel, PanelId.WorldClassUpgrade)
  end
  
  if self.nDemonId ~= 0 then
    local mapDemonAdvanceCfg = ConfigTable.GetData("DemonAdvance", self.nDemonId)
    if mapDemonAdvanceCfg ~= nil then
      if PlayerData.Base:GetWorldClass() > mapDemonAdvanceCfg.LevelRange[2] then
        self.nDemonId = 0
        self._mapNode.animRoot:Play("WorldClassUp", 0, 0)
        self._mapNode.goLevelUp.gameObject:SetActive(self.nDemonId == 0)
        self._mapNode.goAdvance.gameObject:SetActive(self.nDemonId ~= 0)
        self:SetOldWorldClass()
      else
        closePanel()
      end
    end
  else
    closePanel()
  end
end

function WorldClassUpgradeCtrl:OnBtnClick_RewardItem(btn, nIndex)
  local nTid = self.tbReward[nIndex].nId
  UTILS.ClickItemGridWithTips(nTid, btn.gameObject.transform, false, true, false)
end

return WorldClassUpgradeCtrl
