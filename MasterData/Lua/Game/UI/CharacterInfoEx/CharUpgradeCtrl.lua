local CharUpgradeCtrl = class("CharUpgradeCtrl", BaseCtrl)
CharUpgradeCtrl._mapNodeConfig = {
  NotMax = {},
  txtTitleRank = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Template_CharRank"
  },
  txtCurLv = {nCount = 2, sComponentName = "TMP_Text"},
  goAdvanceStar = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateStarAdvanceCtrl"
  },
  txtMaxLevel = {sComponentName = "TMP_Text"},
  goExpbar = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateExpBarCtrl"
  },
  goProperty = {},
  goPropertyLong = {},
  trProperty = {sComponentName = "Transform"},
  goMat = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateMatGridCtrl"
  },
  btnMaxLv = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_MaxLv"
  },
  btnNextLv = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NextLv"
  },
  txtBtnNextLv = {
    sComponentName = "TMP_Text",
    sLanguageId = "Btn_UpOneLevel"
  },
  txtBtnMaxLv = {
    sComponentName = "TMP_Text",
    sLanguageId = "Btn_UpMaxLevel"
  },
  btnAdd = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Add"
  },
  btnReduce = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reduce"
  },
  btnUpgrade = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Upgrade"
  },
  txtBtnUpgrade = {
    sComponentName = "TMP_Text",
    sLanguageId = "Btn_LevelUp"
  },
  imgCostIcon = {sComponentName = "Image"},
  txtCostCount = {sComponentName = "TMP_Text"},
  Max = {},
  txtMaxLv = {nCount = 2, sComponentName = "TMP_Text"},
  trMaxProperty = {sComponentName = "Transform"},
  txtLvMax = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tip_MaxLevel"
  }
}
CharUpgradeCtrl._mapEventConfig = {}

function CharUpgradeCtrl:InitData(nCharId, mapCurLevel)
  self.nCharId = nCharId
  self.mapChar = PlayerData.Char:GetCharDataByTid(self.nCharId)
  self.mapBeforeLevel = mapCurLevel
  self.mapAfterLevel = nil
  self.tbMat = nil
  self.nGoldCost = 0
  self.mapAttrBefore = nil
  self.mapAttrAfter = nil
end

function CharUpgradeCtrl:Refresh(nCharId, mapCurLevel, nMaxAdvance, bMax)
  self:InitData(nCharId, mapCurLevel)
  self._mapNode.NotMax:SetActive(not bMax)
  self._mapNode.Max:SetActive(bMax)
  if bMax then
    self:RefreshMax()
  else
    self:RefreshNotMax()
  end
  self:RefreshStar(nMaxAdvance)
end

function CharUpgradeCtrl:RefreshMax()
  NovaAPI.SetTMPText(self._mapNode.txtMaxLv[1], self.mapBeforeLevel.nLevel)
  NovaAPI.SetTMPText(self._mapNode.txtMaxLv[2], "/" .. self.mapBeforeLevel.nLevel)
  self._mapNode.goExpbar[2]:Refresh(self.mapBeforeLevel)
  local mapAttrBase = PlayerData.Char:GetCharCfgAttr({1, 2}, self.nCharId, self.mapChar.nAdvance, self.mapChar.nLevel)
  delChildren(self._mapNode.trMaxProperty)
  for _, mapAttachAttr in ipairs(AllEnum.AttachAttr) do
    local mapAttr = mapAttrBase[mapAttachAttr.sKey]
    if mapAttr and mapAttr.Value > 0 then
      local goItemObj = instantiate(self._mapNode.goProperty, self._mapNode.trMaxProperty)
      goItemObj:SetActive(true)
      local ctrlItem = self:BindCtrlByNode(goItemObj, "Game.UI.TemplateEx.TemplatePropertyCtrl")
      ctrlItem:SetItemProperty(mapAttr.Key, mapAttr.Value)
    end
  end
end

function CharUpgradeCtrl:RefreshNotMax()
  self.mapAfterLevel = {
    nLevel = self.mapBeforeLevel.nLevel,
    nExp = self.mapBeforeLevel.nExp,
    nMaxLevel = self.mapBeforeLevel.nMaxLevel,
    nMaxExp = self.mapBeforeLevel.nMaxExp,
    nMatExp = self.mapBeforeLevel.nMatExp
  }
  self:RefreshInfo()
end

function CharUpgradeCtrl:RefreshInfo()
  self:RefreshLvAndExp(self.mapBeforeLevel, self.mapAfterLevel)
  self:RefreshAttr()
  self:RefreshCoin()
  self:RefreshMat(true)
end

function CharUpgradeCtrl:RefreshLvAndExp(mapBeforeLevel, mapAfterLevel)
  self._mapNode.txtCurLv[1].gameObject:SetActive(mapAfterLevel.nLevel <= mapBeforeLevel.nLevel)
  self._mapNode.txtCurLv[2].gameObject:SetActive(mapAfterLevel.nLevel > mapBeforeLevel.nLevel)
  for i = 1, 2 do
    NovaAPI.SetTMPText(self._mapNode.txtCurLv[i], mapAfterLevel.nLevel)
  end
  NovaAPI.SetTMPText(self._mapNode.txtMaxLevel, "/" .. mapAfterLevel.nMaxLevel)
  self._mapNode.goExpbar[1]:Refresh(mapBeforeLevel, mapAfterLevel)
end

function CharUpgradeCtrl:RefreshAttr()
  local bExpChanged = true
  if self.mapAfterLevel.nLevel == self.mapBeforeLevel.nLevel and self.mapAfterLevel.nExp == self.mapBeforeLevel.nExp then
    bExpChanged = false
  end
  self.mapAttrBefore = PlayerData.Char:GetCharCfgAttr({1, 2}, self.nCharId, self.mapChar.nAdvance, self.mapChar.nLevel)
  self.mapAttrAfter = PlayerData.Char:GetCharCfgAttr({1, 2}, self.nCharId, self.mapChar.nAdvance, self.mapAfterLevel.nLevel)
  delChildren(self._mapNode.trProperty)
  for _, mapAttachAttr in ipairs(AllEnum.AttachAttr) do
    local mapAttr = self.mapAttrBefore[mapAttachAttr.sKey]
    if mapAttr and mapAttr.Value > 0 then
      local goItemObj = instantiate(self._mapNode.goPropertyLong, self._mapNode.trProperty)
      goItemObj:SetActive(true)
      local ctrlItem = self:BindCtrlByNode(goItemObj, "Game.UI.TemplateEx.TemplatePropertyCtrl")
      local bValueChanged = self.mapAttrAfter[mapAttachAttr.sKey].Value ~= mapAttr.Value
      if bExpChanged and bValueChanged then
        ctrlItem:SetItemProperty(mapAttr.Key, mapAttr.Value, self.mapAttrAfter[mapAttachAttr.sKey].Value)
      else
        ctrlItem:SetItemProperty(mapAttr.Key, mapAttr.Value)
      end
    end
  end
end

function CharUpgradeCtrl:RefreshStar(nMaxAdvance)
  self._mapNode.goAdvanceStar[1]:SetStar(self.mapChar.nAdvance, nMaxAdvance)
  self._mapNode.goAdvanceStar[2]:SetStar(self.mapChar.nAdvance, nMaxAdvance)
end

function CharUpgradeCtrl:RefreshCoin()
  self:SetSprite_Coin(self._mapNode.imgCostIcon, AllEnum.CoinItemId.Gold)
  local nHasCoin = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.Gold)
  NovaAPI.SetTMPText(self._mapNode.txtCostCount, math.ceil(self.nGoldCost))
  NovaAPI.SetTMPColor(self._mapNode.txtCostCount, nHasCoin < self.nGoldCost and Red_Unable or Blue_Normal)
end

function CharUpgradeCtrl:RefreshMat(bInit)
  if bInit then
    self.tbMat = PlayerData.Char:GetUpgradeMatList()
    for i = 1, 4 do
      self._mapNode.goMat[i]:RerfeshGrid({
        nId = self.tbMat[i].nItemId
      })
    end
  else
    for i = 1, 4 do
      self._mapNode.goMat[i]:SetGridCount(self.tbMat[i].nCost)
    end
  end
end

function CharUpgradeCtrl:ChangeMat()
  self.mapAfterLevel, self.nGoldCost = PlayerData.Char:GetLevelDataAndCostByMat(self.nCharId, self.tbMat, self.mapBeforeLevel.nMaxLevel)
  self:RefreshLvAndExp(self.mapBeforeLevel, self.mapAfterLevel)
  self:RefreshAttr()
  self:RefreshCoin()
  self:RefreshMat()
end

function CharUpgradeCtrl:Awake()
end

function CharUpgradeCtrl:OnEnable()
end

function CharUpgradeCtrl:OnDisable()
end

function CharUpgradeCtrl:OnDestroy()
end

function CharUpgradeCtrl:OnBtnClick_MaxLv(btn)
  if self.mapAfterLevel.nLevel == self.mapAfterLevel.nMaxLevel then
    return
  end
  self.mapAfterLevel, self.tbMat, self.nGoldCost = PlayerData.Char:GetMaxLevelDataAndCost(self.nCharId, self.mapBeforeLevel.nMaxLevel)
  if self.nGoldCost == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Upgrade_NoneMat"))
    return
  end
  self:ChangeMat()
end

function CharUpgradeCtrl:OnBtnClick_NextLv(btn)
  if self.mapAfterLevel.nLevel == self.mapAfterLevel.nMaxLevel then
    return
  end
  self.mapAfterLevel, self.tbMat, self.nGoldCost = PlayerData.Char:GetCustomizeLevelDataAndCost(self.nCharId, self.mapAfterLevel.nLevel + 1, self.mapBeforeLevel.nMaxLevel)
  if self.nGoldCost == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Upgrade_NoneMat"))
    return
  end
  self:ChangeMat()
end

function CharUpgradeCtrl:OnBtnClick_Upgrade()
  if self.nGoldCost == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Upgrade_NoneMat"))
    return
  end
  if self.nGoldCost > PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.Gold) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Upgrade_GoinNotEnough"))
    return
  end
  
  local function callback()
    local function ani_end()
      self.nGoldCost = 0
      
      local mapData = {
        nLevel = self.mapAfterLevel.nLevel,
        mapAttrBefore = self.mapAttrBefore,
        mapAttrAfter = self.mapAttrAfter
      }
      if self.mapAfterLevel.nLevel > self.mapBeforeLevel.nLevel then
        EventManager.Hit(EventId.OpenPanel, PanelId.CharSucBar, mapData, true)
      end
      EventManager.Hit("CharDevelopmentRefresh")
    end
    
    self:RefreshLvAndExp(self.mapBeforeLevel, self.mapBeforeLevel)
    self._mapNode.goExpbar[1]:PlayAni(self.mapBeforeLevel, self.mapAfterLevel, ani_end, self._mapNode.txtCurLv[1])
    PlayerData.Voice:PlayCharVoice("charUp", self.nCharId)
  end
  
  PlayerData.Char:CharUpgrade(self.nCharId, self.tbMat, self.mapAfterLevel, callback)
end

function CharUpgradeCtrl:OnBtnClick_Add(btn, nIndex)
  local function func_tips()
    local mapData = {
      nTid = self.tbMat[nIndex].nItemId,
      
      bShowDepot = true,
      bShowJumpto = true
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
  end
  
  if self.mapAfterLevel.nLevel == self.mapAfterLevel.nMaxLevel then
    if btn.Operate_Type == 0 then
      func_tips()
    end
    return
  end
  local nHas = PlayerData.Item:GetItemCountByID(self.tbMat[nIndex].nItemId)
  if nHas <= 0 then
    func_tips()
    return
  end
  local nHasRemain = nHas - self.tbMat[nIndex].nCost
  if nHasRemain <= 0 then
    func_tips()
    return
  end
  if btn.Operate_Type == 0 then
    self.tbMat[nIndex].nCost = self.tbMat[nIndex].nCost + 1
  elseif btn.Operate_Type == 3 then
    if btn.CurrentGear == 0 then
      self.nRemain = PlayerData.Char:GetMaxMatCost(self.nCharId, self.tbMat, self.tbMat[nIndex], self.mapBeforeLevel.nMaxLevel)
      if nHasRemain < self.nRemain then
        self.nRemain = nHasRemain
      end
    end
    local nGear, _ = math.modf(btn.CurrentGear / 3)
    local nAdd = 2 ^ nGear
    local nRemain = self.nRemain - nAdd
    if nRemain < 0 then
      nAdd = self.nRemain
      self.nRemain = 0
    else
      self.nRemain = nRemain
    end
    self.tbMat[nIndex].nCost = math.floor(self.tbMat[nIndex].nCost + nAdd)
  end
  self.mapAfterLevel, self.nGoldCost = PlayerData.Char:GetLevelDataAndCostByMat(self.nCharId, self.tbMat, self.mapBeforeLevel.nMaxLevel)
  self:ChangeMat()
end

function CharUpgradeCtrl:OnBtnClick_Reduce(btn, nIndex)
  if btn.Operate_Type == 0 then
    self.tbMat[nIndex].nCost = self.tbMat[nIndex].nCost - 1
  elseif btn.Operate_Type == 3 then
    self.tbMat[nIndex].nCost = math.floor(self.tbMat[nIndex].nCost - 2 ^ btn.CurrentGear)
  end
  if 0 > self.tbMat[nIndex].nCost then
    self.tbMat[nIndex].nCost = 0
  end
  self.mapAfterLevel, self.nGoldCost = PlayerData.Char:GetLevelDataAndCostByMat(self.nCharId, self.tbMat, self.mapBeforeLevel.nMaxLevel)
  self:ChangeMat()
end

return CharUpgradeCtrl
