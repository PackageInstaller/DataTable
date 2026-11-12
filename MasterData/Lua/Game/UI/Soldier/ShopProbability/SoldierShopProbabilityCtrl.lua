local SoldierShopProbabilityCtrl = class("SoldierShopProbabilityCtrl", BaseCtrl)
SoldierShopProbabilityCtrl._mapNodeConfig = {
  btnCloseFull = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  ScrollView = {
    sComponentName = "LoopScrollView"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_ShopProbability_Title"
  },
  TextLv = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Level"
  },
  TextLvCost = {sComponentName = "TMP_Text", nCount = 5}
}
SoldierShopProbabilityCtrl._mapEventConfig = {}
SoldierShopProbabilityCtrl._mapRedDotConfig = {}
local ITEM_LUA_PATH = "Game.UI.Soldier.ShopProbability.SoldierShopProbabilityItemCtrl"

function SoldierShopProbabilityCtrl:Awake()
  self._tbItemCtrls = {}
  if self._mapNode.ListItemTemplate ~= nil then
    self._mapNode.ListItemTemplate:SetActive(false)
  end
end

function SoldierShopProbabilityCtrl:OnEnable()
  self:_RefreshList()
end

function SoldierShopProbabilityCtrl:OnDisable()
  self:UnbindRowItems()
  self.tbRowsCtrl = nil
end

function SoldierShopProbabilityCtrl:OnDestroy()
end

function SoldierShopProbabilityCtrl:_RefreshList()
  for k, v in pairs(self._mapNode.TextLvCost) do
    NovaAPI.SetTMPText(v, orderedFormat(ConfigTable.GetUIText("Soldier_ShopProbability_ChessCost"), k))
  end
  self.tbRows = {}
  
  local function _f(mapLine)
    if mapLine ~= nil then
      table.insert(self.tbRows, mapLine)
    end
  end
  
  ForEachTableLine(ConfigTable.Get("SoldierShopLevel"), _f)
  table.sort(self.tbRows, function(a, b)
    return (a.Level or 0) < (b.Level or 0)
  end)
  self:UnbindRowItems()
  self._mapNode.ScrollView:Init(#self.tbRows, self, self.OnGridRefresh)
end

function SoldierShopProbabilityCtrl:OnGridRefresh(goGrid, nGridIndex)
  local nIndex = nGridIndex + 1
  local ctrl = self:BindCtrlByNode(goGrid, ITEM_LUA_PATH)
  if ctrl ~= nil then
    self.tbRowsCtrl[goGrid:GetInstanceID()] = ctrl
    ctrl:Refresh(self.tbRows[nIndex])
  end
end

function SoldierShopProbabilityCtrl:UnbindRowItems()
  if self.tbRowsCtrl == nil then
    self.tbRowsCtrl = {}
    return
  end
  for _, ctrl in ipairs(self.tbRowsCtrl) do
    self:UnbindCtrlByNode(ctrl)
  end
end

function SoldierShopProbabilityCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierShopProbabilityPanel)
end

return SoldierShopProbabilityCtrl
