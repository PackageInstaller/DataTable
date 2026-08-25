local UIAnimationController = CS.Z1Client.UIAnimationController
local GameObject = CS.UnityEngine.GameObject
local SummonPoolGroupItem, Super = System.NewComponent("SummonPoolGroupItem")
local SummonGroupItem

function SummonPoolGroupItem:ctor(uiNode, summonPanelModel)
  Super.ctor(self)
  self.ui = UI_Summon_MixPoolGroupResource(uiNode)
  self.summonPanelModel = summonPanelModel
  self.groupItemGoList = {}
  self.parentGroupGoObj = self.ui.Group_Pool
end

function SummonPoolGroupItem:OnBind(binder)
  self.binder = binder
  self:BindGroupItems()
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
end

function SummonPoolGroupItem:OnUnbind()
  Super.OnUnbind(self)
  for _, gameObj in pairs(self.groupItemGoList) do
    GameObject.Destroy(gameObj)
  end
end

function SummonPoolGroupItem:BindGroupItems()
  self.binder:BindToRaw(function(cbinder, poolTidList)
    self:HideAllGroupItem()
    if not poolTidList or 1 == #poolTidList then
      return
    end
    if not SummonDataUtils.CheckPoolListItemIsShow(poolTidList) then
      return
    end
    local firstPoolTid = poolTidList[1]
    if not SummonCfgUtils.GetCfg(firstPoolTid) then
      return
    end
    self:CreateNewGroupItemGameObj(#poolTidList)
    self:MoveItemToParentGroup(firstPoolTid)
    for index = 1, #poolTidList do
      self:BindPoolGroupItem(cbinder, self.groupItemGoList[index], poolTidList[index])
    end
  end, function()
    return self.summonPanelModel.poolTidList
  end)
end

function SummonPoolGroupItem:BindPoolGroupItem(cbinder, gameObj, poolTid)
  local clickFunc = System.fn(self, self.OnClickPoolTid)
  if SummonDataUtils.IsLuckyBagPool(poolTid) then
    local subKey = cd.ClientSubKey.TimeLimitedLuckyBagGroupFirstOpen_ .. poolTid
    cbinder:BindComponent(SummonGroupItem(gameObj, poolTid, self.summonPanelModel, clickFunc, subKey))
  else
    cbinder:BindComponent(SummonGroupItem(gameObj, poolTid, self.summonPanelModel, clickFunc))
  end
end

function SummonPoolGroupItem:OnClickPoolTid(poolTid)
  self.summonPanelModel:SetCurrPoolId(poolTid)
  if #self.summonPanelModel.poolTidList > 1 then
    SummonDataUtils.SetLastSelectedGroupPoolTid(self.summonPanelModel.poolTidList, poolTid)
  end
end

function SummonPoolGroupItem:MoveItemToParentGroup(poolTid)
  local parentGo = self:GetParentGroupGoObj(poolTid)
  if not parentGo or parentGo == self.parentGroupGoObj then
    return
  end
  local curParentGo = parentGo
  self.parentGroupGoObj = curParentGo
  for i, gameObj in ipairs(self.groupItemGoList) do
    gameObj.transform:SetParent(curParentGo.transform)
    gameObj.transform:SetSiblingIndex(i - 1)
  end
end

function SummonPoolGroupItem:GetParentGroupGoObj(poolTid)
  local poolCfg = SummonDataUtils.GetCfg(poolTid)
  local poolType = poolCfg.Type
  local group1Type = {
    cd.SummonPoolType.MixPool,
    cd.SummonPoolType.LuckyBag,
    cd.SummonPoolType.TripleLuckyBag
  }
  if table.contains(group1Type, poolType) then
    return self.ui.Group_Pool
  else
    return self.ui.Group_Pool2
  end
end

function SummonPoolGroupItem:HideAllGroupItem()
  for i = 1, #self.groupItemGoList do
    local gameObj = self.groupItemGoList[i]
    gameObj:SetActive(false)
  end
end

function SummonPoolGroupItem:CreateNewGroupItemGameObj(groupCount)
  local parentTf = self.parentGroupGoObj.transform
  local cnt = #self.groupItemGoList
  for i = cnt + 1, groupCount do
    local gameObj = GameObject.Instantiate(self.ui.Item_MixPool, parentTf)
    table.insert(self.groupItemGoList, gameObj)
  end
  local isHideAll = groupCount <= 1
  for i = 1, #self.groupItemGoList do
    local gameObj = self.groupItemGoList[i]
    if isHideAll then
      gameObj:SetActive(false)
    else
      gameObj:SetActive(groupCount >= i)
    end
  end
end

function SummonPoolGroupItem:GetPoolTidByIndex(index)
  return self.summonPanelModel.poolTidList[index]
end

SummonGroupItem = System.NewComponent("SummonGroupItem")

function SummonGroupItem:ctor(gameObj, poolTid, model, clickFunc, subKey)
  Super.ctor(self)
  self.ui = UI_Summon_Item_MixPoolResource(gameObj)
  self.poolTid = poolTid
  self.poolCfg = SummonDataUtils.GetCfg(poolTid)
  self.summonPanelModel = model
  self.clickFunc = clickFunc
  self.subKey = subKey or nil
end

function SummonGroupItem:OnBind(binder)
  self.binder = binder
  local isLuckyBagPool = SummonDataUtils.IsLuckyBagPool(self.poolTid)
  local isTripleLuckyBagPool = SummonCfgUtils.IsTripleLuckyBagPool(self.poolTid)
  local poolIcon, poolIconSuffix = self:GetPoolIcon()
  if isLuckyBagPool or isTripleLuckyBagPool then
    binder:SetActive(self.ui.Group_Pool, true)
    binder:SetActive(self.ui.Group_Weapon, false)
    binder:SetActive(self.ui.Group_Awaker, false)
    binder:SetActive(self.ui.Image_Pool, poolIcon)
    binder:SetImage(self.ui.Image_Pool, poolIcon)
    binder:BindToVisible(self.ui.Group_Got, function()
      do return SummonDataUtils.CheckPoolIsSummonOut end
      return SummonDataUtils.CheckPoolIsSummonOut, self.poolTid
    end)
  else
    binder:SetActive(self.ui.Group_Awaker, true)
    binder:SetActive(self.ui.Image_Awaker, self:GetAwakerHead())
    binder:SetImage(self.ui.Image_Awaker, self:GetAwakerHead())
    binder:SetActive(self.ui.Image_Weapon, self:GetWeaponIcon())
    binder:SetImage(self.ui.Image_Weapon, self:GetWeaponIcon())
    binder:SetActive(self.ui.Group_Weapon, self:GetWeaponIcon())
    binder:SetActive(self.ui.Group_Got, false)
  end
  binder:SetActive(self.ui.Image_PoolSuffix, poolIconSuffix)
  binder:SetImage(self.ui.Image_PoolSuffix, poolIconSuffix)
  binder:BindToVisible(self.ui.Image_Select, function()
    return self.poolTid == self.summonPanelModel.curPoolId
  end)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.clickFunc then
      self.clickFunc(self.poolTid)
      if self.subKey then
        ClientDataUtils.SetData(cd.ClientDataMainKey.TimeLimitedLuckyBagGroupFirstOpen, self.subKey, 0)
      end
    end
  end)
  self.binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, function()
    if RedPointDataUtils.IsShowPoolCurrencyEnough(self.poolTid) then
      return "red"
    end
    return false
  end))
  binder:BindToVisible(self.ui.UI_Common_Item_Hint, function()
    if not isLuckyBagPool then
      return false
    end
    return 0 ~= ClientDataUtils.GetData(cd.ClientDataMainKey.TimeLimitedLuckyBagGroupFirstOpen, self.subKey)
  end)
  if isLuckyBagPool then
    self.binder:BindToText(self.ui.Text_C_Recommend, function()
      do return LT.Text end
      return LT.Text, "LuckyBagRedDotText"
    end)
  end
end

function SummonGroupItem:GetDetailItemTid()
  local detailItems = self.poolCfg.DetailItem or {}
  return detailItems[1]
end

function SummonGroupItem:GetPoolIcon()
  local poolGroupImage = self.poolCfg.PoolGroupImage
  if poolGroupImage and string.contains(poolGroupImage, ";") then
    local picList = string.split(poolGroupImage, ";")
    return picList[1], picList[2]
  else
    return poolGroupImage, nil
  end
end

function SummonGroupItem:GetAwakerHead()
  local detailItemTid = self:GetDetailItemTid()
  local itemCfg = ItemDataUtils.GetItemConfig(detailItemTid) or {}
  if itemCfg.Type == cd.ItemType.AwakerItem and itemCfg.SpParam and itemCfg.SpParam[1] then
    do return AwakerDataUtils.GetAwakerDefaultBust end
    return AwakerDataUtils.GetAwakerDefaultBust, itemCfg.SpParam[1]
  end
end

function SummonGroupItem:GetWeaponIcon()
  local detailItemTid = self:GetDetailItemTid()
  local itemType = detailItemTid and ItemDataUtils.GetItemConfigByField("Type", detailItemTid)
  if itemType == cd.ItemType.Weapon then
    do return ItemDataUtils.GetSpIcon end
    return ItemDataUtils.GetSpIcon, detailItemTid
  end
end

return SummonPoolGroupItem
