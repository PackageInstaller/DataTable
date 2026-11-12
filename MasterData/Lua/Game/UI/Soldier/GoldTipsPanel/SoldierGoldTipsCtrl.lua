local BaseCtrl = require("GameCore.UI.BaseCtrl")
local SoldierGoldTipsCtrl = class("SoldierGoldTipsCtrl", BaseCtrl)
SoldierGoldTipsCtrl._mapNodeConfig = {
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txt_glodTitle = {
    sNodeName = "txt_glodTitle",
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_GoldTips_Title"
  },
  txt_desc = {sNodeName = "txt_desc", sComponentName = "TMP_Text"},
  txt_IncomeTitle = {
    sNodeName = "txt_IncomeTitle",
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_GoldTips_Income"
  },
  txt_WinningstreakTitle = {
    sNodeName = "txt_WinningstreakTitle",
    sComponentName = "TMP_Text"
  },
  IncomeRoot = {sNodeName = "IncomeRoot", sComponentName = "Transform"},
  IncomeItem = {},
  WinningstreakRoot = {
    sNodeName = "WinningstreakRoot",
    sComponentName = "Transform"
  },
  WinningstreakItem = {}
}
SoldierGoldTipsCtrl._mapEventConfig = {}
SoldierGoldTipsCtrl._mapRedDotConfig = {}
local RootPath = "UI/Soldier/SpriteAtlas/Sandbox/"

function SoldierGoldTipsCtrl:Awake()
  self:ParseConfig()
end

function SoldierGoldTipsCtrl:OnEnable()
  self:OnRefresh()
end

function SoldierGoldTipsCtrl:OnDisable()
end

function SoldierGoldTipsCtrl:OnDestroy()
end

function SoldierGoldTipsCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierGoldTips)
end

function SoldierGoldTipsCtrl:OnRefresh()
  self:_RefreshDes()
  self:_RefreshIncameItems()
  self:_RefreshStreakItems()
end

function SoldierGoldTipsCtrl:ParseConfig()
  local sSoldierCoinWinningStreak = ConfigTable.GetConfigValue("SoldierCoinWinningStreak")
  self.tbWinningStreak = {}
  if sSoldierCoinWinningStreak ~= nil then
    local tbSoldierCoinWinningStreak = decodeJson(sSoldierCoinWinningStreak)
    for k, v in pairs(tbSoldierCoinWinningStreak) do
      table.insert(self.tbWinningStreak, {
        nCount = tonumber(k),
        nReward = v
      })
    end
    table.sort(self.tbWinningStreak, function(a, b)
      return a.nCount < b.nCount
    end)
  end
  local sSoldierCoinLosingStreak = ConfigTable.GetConfigValue("SoldierCoinLosingStreak")
  self.tbLosingStreak = {}
  if sSoldierCoinLosingStreak ~= nil then
    local tbSoldierCoinLosingStreak = decodeJson(sSoldierCoinLosingStreak)
    for k, v in pairs(tbSoldierCoinLosingStreak) do
      table.insert(self.tbLosingStreak, {
        nCount = tonumber(k),
        nReward = v
      })
    end
    table.sort(self.tbLosingStreak, function(a, b)
      return a.nCount < b.nCount
    end)
  end
  local sSoldierCoinInterest = ConfigTable.GetConfigValue("SoldierCoinInterest")
  self.nCoinInterestCount = 1
  self.nCoinInterestRatio = 1
  self.nCoinInterestMax = 0
  if sSoldierCoinInterest ~= nil then
    local tbSoldierCoinInterest = string.split(sSoldierCoinInterest, ",")
    self.nCoinInterestCount = tonumber(tbSoldierCoinInterest[1]) or 0
    self.nCoinInterestRatio = tonumber(tbSoldierCoinInterest[2]) or 1
    self.nCoinInterestMax = tonumber(tbSoldierCoinInterest[3]) or 0
  end
  local nEffectAdd = 0
  if PlayerData.SoldierData:GetCurLevelData() ~= nil then
    nEffectAdd = PlayerData.SoldierData:GetCurLevelData():GetInterestLimit()
    self.nCoinInterestMax = self.nCoinInterestMax + nEffectAdd
  end
end

function SoldierGoldTipsCtrl:_RefreshDes()
  if self._mapNode.txt_desc == nil then
    return
  end
  local str = orderedFormat(ConfigTable.GetUIText("Soldier_GoldTips_Desc"), self.nCoinInterestCount, self.nCoinInterestRatio, self.nCoinInterestMax)
  NovaAPI.SetTMPText(self._mapNode.txt_desc, str)
end

function SoldierGoldTipsCtrl:_RefreshIncameItems()
  self.tbIncomeItems = {}
  local curLevelData = PlayerData.SoldierData:GetCurLevelData()
  local nCurNodeId = curLevelData:GetNodeId()
  local nodeConfig = ConfigTable.GetData("SoldierNodePlan", nCurNodeId)
  if nodeConfig ~= nil and nodeConfig.Coin > 0 then
    table.insert(self.tbIncomeItems, {
      sDesc = ConfigTable.GetUIText("Soldier_GoldTips_BasicReward"),
      nCoin = nodeConfig.Coin
    })
  end
  self.nWiningStreak, self.nLosingStreak = curLevelData:GetStreakCount()
  if 0 < self.nWiningStreak or 0 < self.nLosingStreak then
    local nCurStreak = 0 < self.nWiningStreak and self.nWiningStreak or self.nLosingStreak
    local tbTargetStreak = 0 < self.nWiningStreak and self.tbWinningStreak or self.tbLosingStreak
    local sStreakText = 0 < self.nWiningStreak and ConfigTable.GetUIText("Soldier_GoldTips_Winningstreak") or ConfigTable.GetUIText("Soldier_GoldTips_Losingingstreak")
    local targetData
    for _, data in pairs(tbTargetStreak) do
      if nCurStreak >= data.nCount then
        targetData = data
      else
        break
      end
    end
    if targetData ~= nil then
      table.insert(self.tbIncomeItems, {
        sDesc = orderedFormat(sStreakText, targetData.nCount),
        nCoin = targetData.nReward
      })
    end
  end
  self.bWinningStreak = 0 < self.nWiningStreak or self.nWiningStreak == 0 and self.nLosingStreak == 0
  local curTotalCoin = curLevelData:GetItem(AllEnum.CoinItemId.SoldierCurrency)
  local nInterestCoin = math.floor(curTotalCoin / self.nCoinInterestCount) * self.nCoinInterestRatio
  nInterestCoin = math.min(nInterestCoin, self.nCoinInterestMax)
  if 0 < nInterestCoin then
    table.insert(self.tbIncomeItems, {
      sDesc = orderedFormat(ConfigTable.GetUIText("Soldier_GoldTips_Interest"), self.nCoinInterestCount, self.nCoinInterestRatio, self.nCoinInterestMax),
      nCoin = nInterestCoin
    })
  end
  for i = 1, #self.tbIncomeItems do
    local item = self.tbIncomeItems[i]
    if self._mapNode.IncomeItem ~= nil then
      local itemNode = instantiate(self._mapNode.IncomeItem, self._mapNode.IncomeRoot)
      self:RefreshItems(itemNode, item.nCoin, item.sDesc)
    end
  end
  self._mapNode.IncomeItem.gameObject:SetActive(false)
  if self.bWinningStreak then
    NovaAPI.SetTMPText(self._mapNode.txt_WinningstreakTitle, ConfigTable.GetUIText("Soldier_GoldTips_Winningstreak"))
  else
    NovaAPI.SetTMPText(self._mapNode.txt_WinningstreakTitle, ConfigTable.GetUIText("Soldier_GoldTips_Losingingstreak"))
  end
end

function SoldierGoldTipsCtrl:_RefreshStreakItems()
  self.tbStreakItems = {}
  local str = self.bWinningStreak and ConfigTable.GetUIText("Soldier_GoldTips_Winningstreak") or ConfigTable.GetUIText("Soldier_GoldTips_Losingingstreak")
  NovaAPI.SetTMPText(self._mapNode.WinningstreakTitle, str)
  local tbStreak = self.bWinningStreak and self.tbWinningStreak or self.tbLosingStreak
  for i = 1, #tbStreak do
    local item = tbStreak[i]
    if self._mapNode.WinningstreakItem ~= nil then
      local itemNode = instantiate(self._mapNode.WinningstreakItem, self._mapNode.WinningstreakRoot)
      local sDesc = ""
      if i < #tbStreak then
        local minCount = item.nCount
        local maxCount = tbStreak[i + 1].nCount - 1
        sDesc = minCount .. "-" .. maxCount
      else
        sDesc = item.nCount .. "+"
      end
      local nCurStreak = self.bWinningStreak and self.nWiningStreak or self.nLosingStreak
      local bCurItem = nCurStreak >= item.nCount and (i == #tbStreak or nCurStreak < tbStreak[i + 1].nCount)
      self:RefreshItems(itemNode, item.nReward, sDesc, true, bCurItem)
    end
  end
  self._mapNode.WinningstreakItem.gameObject:SetActive(false)
end

function SoldierGoldTipsCtrl:RefreshItems(goItem, nCoinCount, sDesc, bStreak, bCurItem)
  if goItem == nil then
    return
  end
  goItem:SetActive(true)
  local txt_Name = goItem.transform:Find("TextName"):GetComponent("TMP_Text")
  local txRefreshCount = goItem.transform:Find("txRefreshCount"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txt_Name, sDesc)
  NovaAPI.SetTMPText(txRefreshCount, nCoinCount)
  if bStreak == true then
    local imgItemLine = goItem.transform:Find("imgItemLine").gameObject
    imgItemLine:SetActive(bCurItem)
    local imgItemIcon = goItem.transform:Find("imgItemIcon"):GetComponent("Image")
    local sIcon = self.bWinningStreak and "icon_soldier_sandbox_chess_2" or "icon_soldier_sandbox_chess_5"
    self:SetSprite(imgItemIcon, RootPath .. sIcon)
  end
end

return SoldierGoldTipsCtrl
