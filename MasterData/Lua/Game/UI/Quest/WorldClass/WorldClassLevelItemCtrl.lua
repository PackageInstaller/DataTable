local WorldClassLevelItemCtrl = class("WorldClassLevelItemCtrl", BaseCtrl)
WorldClassLevelItemCtrl._mapNodeConfig = {
  rtImgBg = {
    sNodeName = "imgBg",
    sComponentName = "RectTransform"
  },
  txtLevelCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Level"
  },
  txtLevel = {sComponentName = "TMP_Text"},
  btnRewardItem = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardItem"
  },
  goRewardItem = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Level_Receive"
  },
  txtUnComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Level_UnComplete"
  },
  imgComplete = {},
  imgUnOpen = {},
  txtUnOpen = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Level_Lock"
  },
  goInfo = {},
  imgOpenFunc = {nCount = 3},
  imgLevelInfo = {nCount = 3}
}
WorldClassLevelItemCtrl._mapEventConfig = {}
WorldClassLevelItemCtrl._mapRedDotConfig = {}

function WorldClassLevelItemCtrl:SetItem(nLevel, bUnOpen)
  self.nLevel = nLevel
  self.bUnOpen = bUnOpen
  local nCurWorldClass = PlayerData.Base:GetWorldClass()
  local bUnReceive = PlayerData.Base:GetWorldClassState(self.nLevel)
  local mapCfg = ConfigTable.GetData("WorldClass", nLevel)
  if mapCfg ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtLevel, nLevel)
    local tbRewardCfg = decodeJson(mapCfg.Reward)
    for _, v in ipairs(self._mapNode.btnRewardItem) do
      v.gameObject:SetActive(false)
    end
    self.tbReward = {}
    local i = 1
    for sItem, nCount in pairs(tbRewardCfg) do
      local nItemId = tonumber(sItem)
      local nRarity = 0
      local mapCfg = ConfigTable.GetData_Item(nItemId)
      if mapCfg ~= nil then
        nRarity = mapCfg.Rarity
      end
      table.insert(self.tbReward, {
        nId = nItemId,
        nCount = nCount,
        nRarity = nRarity
      })
      i = i + 1
    end
    table.sort(self.tbReward, function(a, b)
      if a.nRarity == b.nRarity then
        return a.nId < b.nId
      end
      return a.nRarity < b.nRarity
    end)
    for k, v in ipairs(self._mapNode.btnRewardItem) do
      v.gameObject:SetActive(k <= #self.tbReward)
      if k <= #self.tbReward then
        self._mapNode.goRewardItem[k]:SetItem(self.tbReward[k].nId, nil, self.tbReward[k].nCount, nil, not bUnReceive and nLevel <= nCurWorldClass, nil, nil, true)
      end
    end
    local nInfoCount = 0
    local tbOpenFunc = mapCfg.OpenFunc
    for k, v in ipairs(self._mapNode.imgOpenFunc) do
      v.gameObject:SetActive(tbOpenFunc[k] ~= nil and tbOpenFunc[k] ~= 0)
      if tbOpenFunc[k] ~= nil and tbOpenFunc[k] ~= 0 then
        nInfoCount = nInfoCount + 1
        local mapOpenFuncCfg = ConfigTable.GetData("OpenFunc", tbOpenFunc[k])
        if mapOpenFuncCfg ~= nil then
          local txtFunc = v.gameObject.transform:Find("txtFunc"):GetComponent("TMP_Text")
          local txtFuncDesc = v.gameObject.transform:Find("txtFuncDesc"):GetComponent("TMP_Text")
          NovaAPI.SetTMPText(txtFunc, orderedFormat(ConfigTable.GetUIText("WorldClass_Level_FuncOpen"), mapOpenFuncCfg.Name))
          NovaAPI.SetTMPText(txtFuncDesc, mapOpenFuncCfg.Desc)
        end
      end
    end
    for _, v in ipairs(self._mapNode.imgLevelInfo) do
      v.gameObject:SetActive(false)
    end
    for i = 1, 3 do
      if mapCfg["FuncChangeText" .. i] ~= "" then
        nInfoCount = nInfoCount + 1
        self._mapNode.imgLevelInfo[i].gameObject:SetActive(true)
        local txtLevelLimit = self._mapNode.imgLevelInfo[i].gameObject.transform:Find("txtLevelLimit"):GetComponent("TMP_Text")
        NovaAPI.SetTMPText(txtLevelLimit, mapCfg["FuncChangeText" .. i])
      end
    end
    self._mapNode.goInfo:SetActive(0 < nInfoCount)
  end
  self:RefreshStatus()
end

function WorldClassLevelItemCtrl:RefreshStatus()
  local nCurWorldClass = PlayerData.Base:GetWorldClass()
  local bUnReceive = PlayerData.Base:GetWorldClassState(self.nLevel)
  self._mapNode.txtUnComplete.gameObject:SetActive(not self.bUnOpen and nCurWorldClass < self.nLevel)
  self._mapNode.btnReceive.gameObject:SetActive(bUnReceive and nCurWorldClass >= self.nLevel)
  self._mapNode.imgComplete.gameObject:SetActive(not bUnReceive and nCurWorldClass >= self.nLevel)
  self._mapNode.imgUnOpen.gameObject:SetActive(self.bUnOpen)
  for k, v in ipairs(self._mapNode.btnRewardItem) do
    if k <= #self.tbReward then
      self._mapNode.goRewardItem[k]:SetItem(self.tbReward[k].nId, nil, self.tbReward[k].nCount, nil, not bUnReceive and nCurWorldClass >= self.nLevel, nil, nil, true)
    end
  end
end

function WorldClassLevelItemCtrl:Awake()
end

function WorldClassLevelItemCtrl:OnEnable()
end

function WorldClassLevelItemCtrl:OnDisable()
end

function WorldClassLevelItemCtrl:OnDestroy()
end

function WorldClassLevelItemCtrl:OnBtnClick_RewardItem(btn, nIndex)
  local nTid = self.tbReward[nIndex].nId
  UTILS.ClickItemGridWithTips(nTid, btn.gameObject.transform, false, true, false)
end

function WorldClassLevelItemCtrl:OnBtnClick_Receive()
  local function callback()
    PlayerData.State:ResetWorldClassRewardState(self.nLevel)
    
    self:RefreshStatus()
    EventManager.Hit("ReceiveWorldClassLevelReward")
  end
  
  PlayerData.Base:SendPlayerWorldClassRewardReceiveReq(self.nLevel, nil, callback)
end

return WorldClassLevelItemCtrl
