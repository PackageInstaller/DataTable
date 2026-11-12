local SoldierBattleEventItemCtrl = class("SoldierBattleEventItemCtrl", BaseCtrl)
SoldierBattleEventItemCtrl._mapNodeConfig = {
  imgBgNormal = {sComponentName = "Image"},
  ConfirmBtnLocalPos = {sComponentName = "Transform"},
  TextName = {sComponentName = "TMP_Text"},
  TextDes = {sComponentName = "TMP_Text"},
  btnTakeBuff = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TakeBuff"
  },
  txtTakeBuff = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BattleEventItem_Challenge"
  },
  txt_charTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BattleEventItem_RewardItem"
  },
  gridCoin = {
    sCtrlName = "Game.UI.Soldier.Template.SoldierItemGridCtrl"
  },
  gridChess = {
    sCtrlName = "Game.UI.Soldier.Template.SoldierItemGridCtrl"
  },
  gridBuff = {
    sCtrlName = "Game.UI.Soldier.Template.SoldierItemGridCtrl"
  },
  RewardRoot = {}
}
SoldierBattleEventItemCtrl._mapEventConfig = {}
SoldierBattleEventItemCtrl._mapRedDotConfig = {}

function SoldierBattleEventItemCtrl:Awake()
end

function SoldierBattleEventItemCtrl:OnEnable()
end

function SoldierBattleEventItemCtrl:OnDisable()
end

function SoldierBattleEventItemCtrl:OnDestroy()
end

function SoldierBattleEventItemCtrl:SetRefreshCallback(obj, fn)
  self._objRefreshCallback = obj
  self._fnRefreshCallback = fn
end

function SoldierBattleEventItemCtrl:SetSelectCallback(obj, fn)
  self._objSelectCallback = obj
  self._fnSelectCallback = fn
end

function SoldierBattleEventItemCtrl:OnBtnClick_Select()
end

function SoldierBattleEventItemCtrl:SetItemData(tbItem)
  if tbItem == nil then
    self._nCardId = -1
    self._nIndex = 0
    self:SetSelected(false)
    return
  end
  self._nCardId = tbItem.id or -1
  self._nIndex = tbItem.index or 0
  local cfg = ConfigTable.GetData("SoldierEventBattlePool", self._nCardId)
  if cfg == nil then
    return
  end
  self:_SetIcon(cfg.Icon)
  if self._mapNode.TextName ~= nil then
    NovaAPI.SetTMPText(self._mapNode.TextName, cfg.Title or "")
  end
  if self._mapNode.TextDes ~= nil then
    NovaAPI.SetTMPText(self._mapNode.TextDes, cfg.Name or "")
  end
  self:SetPngSprite(self._mapNode.imgBgNormal, "Icon/SoldierOtherIcon/EventBattleQuality_0" .. cfg.LevelName)
  self:RefreshCharItems(cfg.coin, cfg.CharacterCount, cfg.StrategyCardCount)
end

function SoldierBattleEventItemCtrl:RefreshCharItems(nCoinCount, nCharCount, nStrategyCardCount)
  if nCoinCount <= 0 and nCharCount <= 0 and nStrategyCardCount <= 0 then
    self._mapNode.RewardRoot.gameObject:SetActive(false)
    return
  end
  self._mapNode.RewardRoot.gameObject:SetActive(true)
  self.nCoinCount = nCoinCount
  if 0 >= self.nCoinCount then
    self._mapNode.gridCoin.gameObject:SetActive(false)
  else
    self._mapNode.gridCoin.gameObject:SetActive(true)
    self._mapNode.gridCoin:SetItem(1, self.nCoinCount, "Icon/Item/item_40", 40)
  end
  self.nCharCount = nCharCount
  if 0 >= self.nCharCount then
    self._mapNode.gridChess.gameObject:SetActive(false)
  else
    self._mapNode.gridChess.gameObject:SetActive(true)
    self._mapNode.gridChess:SetItem(1, self.nCharCount, "Icon/SoldierOtherIcon/icon_soldier_random_chess", 2701001)
  end
  self.nStrategyCardCount = nStrategyCardCount
  if 0 >= self.nStrategyCardCount then
    self._mapNode.gridBuff.gameObject:SetActive(false)
  else
    self._mapNode.gridBuff.gameObject:SetActive(true)
    self._mapNode.gridBuff:SetItem(1, self.nStrategyCardCount, "Icon/SoldierOtherIcon/icon_soldier_random_strategycard", 2701002)
  end
  self:SetButtonInit()
end

function SoldierBattleEventItemCtrl:SetButtonInit()
  self._mapNode.btnTakeBuff.gameObject:SetActive(true)
end

function SoldierBattleEventItemCtrl:OnGridBtnClick(nIndex)
end

function SoldierBattleEventItemCtrl:GetCardId()
  return self._nCardId
end

function SoldierBattleEventItemCtrl:GetIndex()
  return self._nIndex
end

function SoldierBattleEventItemCtrl:SetSelected(bSelected)
  self._bSelected = bSelected == true
  if self._mapNode.ImageSelect ~= nil and self._mapNode.ImageSelect.gameObject ~= nil then
    self._mapNode.ImageSelect.gameObject:SetActive(self._bSelected)
  end
end

function SoldierBattleEventItemCtrl:IsSelected()
  return self._bSelected
end

function SoldierBattleEventItemCtrl:GetConfirmBtnPosition()
  local node = self._mapNode.ConfirmBtnLocalPos
  if node == nil or node.transform == nil then
    return nil
  end
  return node.transform.position
end

function SoldierBattleEventItemCtrl:_SetIcon(sIconPath)
  if self._mapNode.img_icon == nil then
    return
  end
  if sIconPath and 0 < #sIconPath then
    self:SetPngSprite(self._mapNode.img_icon, sIconPath)
    self._mapNode.img_icon.gameObject:SetActive(true)
  else
    self._mapNode.img_icon.gameObject:SetActive(false)
  end
end

function SoldierBattleEventItemCtrl:OnBtnClick_TakeBuff()
  local function callback()
    EventManager.Hit("SoldierSelectEventBattle")
  end
  
  PlayerData.SoldierData:GetCurLevelData():SendEventBattleChoose(self._nIndex, callback)
end

return SoldierBattleEventItemCtrl
