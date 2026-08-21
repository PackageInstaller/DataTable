_class("UICurrencyMenu", UICustomWidget)
UICurrencyMenu = UICurrencyMenu

function UICurrencyMenu:Constructor()
  self.SortCurrencyId = {}
  local count = table.count(Cfg.cfg_top_tips({}))
  for id, cfg in pairs(Cfg.cfg_top_tips({})) do
    self.SortCurrencyId[id] = cfg.Sort
  end
end

function UICurrencyMenu:OnShow()
  self:AttachEvent(GameEventType.ShowHideTSFBtn, self.ShowHideTSFBtn)
  self:AttachEvent(GameEventType.ShowHideLimitedTimeRechargeBtn, self.ShowHideLimitedTimeRechargeBtn)
  self._topTips = self:GetUIComponent("UISelectObjectPath", "toptips")
  self._topTipsInfo = self._topTips:SpawnObject("UITopTipsContext")
  self._panel = self:GetUIComponent("UISelectObjectPath", "panel")
  self._btnZJJSF = self:GetUIComponent("Button", "btnZJJSF")
  self._btnTSF = self:GetUIComponent("Button", "btnTSF")
  self._btnZJJSF.gameObject:SetActive(false)
  self._btnTSF.gameObject:SetActive(false)
  self._btnLimitedTimeRechargeGO = self:GetGameObject("BtnLimitedTimeRecharge")
  self._btnLimitedTimeRechargeGO:SetActive(false)
end

function UICurrencyMenu:OnHide()
  self:DetachEvent(GameEventType.ShowHideTSFBtn, self.ShowHideTSFBtn)
  self:DetachEvent(GameEventType.ShowHideLimitedTimeRechargeBtn, self.ShowHideLimitedTimeRechargeBtn)
end

function UICurrencyMenu:GetItems()
  return self.items
end

function UICurrencyMenu:GetItemByTypeId(typeId)
  for index, item in ipairs(self.items) do
    if item:GetTypeId() == typeId then
      return item
    end
  end
  return nil
end

function UICurrencyMenu:SetData(typeIds, hideAddBtn)
  if not typeIds then
    return
  end
  table.sort(typeIds, function(a, b)
    return self.SortCurrencyId[a] < self.SortCurrencyId[b]
  end)
  local count = #typeIds
  self._panel:SpawnObjects("UICurrencyItem", count)
  self.items = self._panel:GetAllSpawnList()
  local index = 1
  for key, item in pairs(self.items) do
    local roleAssetId = typeIds[index]
    item:SetData(roleAssetId, function(id, go)
      self._topTipsInfo:SetData(id, go)
    end, hideAddBtn)
    if roleAssetId == RoleAssetID.RoleAssetPhyPoint then
      item:SetAddCallBack(function()
        self:ShowDialog("UIGetPhyPointController")
      end)
    end
    index = index + 1
  end
end

function UICurrencyMenu:ShowHideTSFBtn(isShow)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local isJapanZone = roleModule:IsJapanZone()
  if isJapanZone then
    self._btnZJJSF.gameObject:SetActive(isShow)
    self._btnTSF.gameObject:SetActive(isShow)
  else
    self._btnZJJSF.gameObject:SetActive(false)
    self._btnTSF.gameObject:SetActive(false)
  end
end

function UICurrencyMenu:btnZJJSFOnClick()
  self:ShowDialog("UIPayLawContentController", 2)
end

function UICurrencyMenu:btnTSFOnClick()
  self:ShowDialog("UIPayLawContentController", 1)
end

function UICurrencyMenu:ShowHideLimitedTimeRechargeBtn(isShow)
  local open = self:GetUIModule(SignInModule):CheckEventOpen(CommonEventType.LimitedTimeRecharge)
  local show = open and isShow
  self._btnLimitedTimeRechargeGO:SetActive(show)
  if show then
    self._newLimitedTimeRechargeGO = self:GetGameObject("NewLimitedTimeRecharge")
    local localDbKey = "LimitedTimeRechargeRead" .. self:GetModule(RoleModule):GetPstId()
    self._newLimitedTimeRechargeGO:SetActive(not LocalDB.HasKey(localDbKey))
  end
end

function UICurrencyMenu:BtnLimitedTimeRechargeOnClick()
  self:ShowDialog("UIPayLawContentController", 3)
  local localDbKey = "LimitedTimeRechargeRead" .. self:GetModule(RoleModule):GetPstId()
  LocalDB.SetInt(localDbKey, 1)
  self._newLimitedTimeRechargeGO:SetActive(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
end

function UICurrencyMenu:OnOpenShop()
  local open = self:GetUIModule(SignInModule):CheckEventOpen(CommonEventType.LimitedTimeRecharge)
  local localDbKey = "LimitedTimeRechargeRead" .. self:GetModule(RoleModule):GetPstId()
  if open and not LocalDB.HasKey(localDbKey) then
    self:BtnLimitedTimeRechargeOnClick()
  end
end

local CurrenyTypeId = {StarPoint = 1001, Hp = 2001}
_enum("CurrenyTypeId", CurrenyTypeId)
