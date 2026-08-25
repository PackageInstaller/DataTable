local Type_Awaker = CommonDefine.ItemType.AwakerItem
local Type_Weapon = CommonDefine.ItemType.Weapon
local SummonMultiAwakerWeaponComp, Super = System.NewComponent("SummonMultiAwakerWeaponComp")
SummonMultiAwakerWeaponComp.uiResCls = UI_Summon_Panel_AwakerWeaponResource

function SummonMultiAwakerWeaponComp:ctor(uiNode, viewData)
  Super.ctor(self)
  self.ui = SummonMultiAwakerWeaponComp.uiResCls(uiNode)
  self:_InitViewData(viewData)
end

function SummonMultiAwakerWeaponComp:OnBind(binder)
  self.binder = binder
  self:_InitView()
  self:RefreshView(true)
  self._timer = self.binder:BindTimer(5, -1, System.fn(self, self.RefreshView))
end

function SummonMultiAwakerWeaponComp:_InitViewData(viewData)
  self._poolId = viewData.poolId
  self._poolCfg = SummonDataUtils.GetSummonConfig(self._poolId)
  self._showNum = viewData.showNum
  local dropRateDict = {}
  DropCfgUtils.GetProbabilityPercentInfoList(self._poolCfg.SSRAward, 100, dropRateDict)
  local weaponItemTids = {}
  local awakerItemTids = {}
  for itemTid, _ in pairs(dropRateDict) do
    local itemCfg = ItemDataUtils.GetItemConfig(itemTid)
    if itemCfg.Type == Type_Awaker then
      table.insert(awakerItemTids, itemTid)
    elseif itemCfg.Type == Type_Weapon then
      table.insert(weaponItemTids, itemTid)
    end
  end
  self._awakerItemTids = awakerItemTids
  self._weaponItemTids = weaponItemTids
  self._compList = {}
  self._isShowAwaker = true
end

function SummonMultiAwakerWeaponComp:_InitView()
  local parentTf = self.ui.CardContent.transform
  local cnt = self:ReserveChildren(parentTf, self._showNum)
  for i = 1, self._showNum do
    local go = parentTf:GetChild(i - 1).gameObject
    go:SetActive(true)
    local comp = self.binder:BindComponent(SummonAwakerWeaponItem(go))
    self._compList[i] = comp
  end
end

function SummonMultiAwakerWeaponComp:RefreshView(firstRefresh)
  local showItemTids = {}
  if self._isShowAwaker then
    showItemTids = MathUtils.GetTargetRandomNumbers(self._awakerItemTids, self._showNum)
  else
    showItemTids = MathUtils.GetTargetRandomNumbers(self._weaponItemTids, self._showNum)
  end
  for i = 1, self._showNum do
    local itemTid = showItemTids[i]
    local comp = self._compList[i]
    if comp then
      comp:RefreshView(itemTid, firstRefresh)
    end
  end
  self._isShowAwaker = not self._isShowAwaker
end

function SummonMultiAwakerWeaponComp:_ClearTimer()
  if self._timer then
    self.binder:StopTimer(self._timer)
    self._timer = nil
  end
end

function SummonMultiAwakerWeaponComp:OnUnbind()
  Super.OnUnbind(self)
  self:_ClearTimer()
end

function SummonMultiAwakerWeaponComp:ReserveChildren(transform, num)
  local ct_transform = transform
  local cnt = ct_transform.childCount
  while num > cnt do
    Instantiate(ct_transform:GetChild(0).gameObject, ct_transform)
    cnt = cnt + 1
  end
  return cnt
end

return SummonMultiAwakerWeaponComp
