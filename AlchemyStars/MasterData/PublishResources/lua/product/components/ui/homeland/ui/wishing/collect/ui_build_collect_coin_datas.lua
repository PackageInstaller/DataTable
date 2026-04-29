_class("UIBuildCollectCoinData", Object)
UIBuildCollectCoinData = UIBuildCollectCoinData

function UIBuildCollectCoinData:Constructor(coinId)
  local itemCfg = Cfg.cfg_item[coinId]
  if not itemCfg then
    Log.exception("cfg_item缺少配置:", coinId)
  end
  local coinCfg = Cfg.cfg_item_wishing_coin[coinId]
  if not coinCfg then
    Log.exception("cfg_item_wishing_coin缺少配置:", coinId)
  end
  self._coinId = coinId
  self._name = StringTable.Get(itemCfg.Name)
  self._des = StringTable.Get(itemCfg.Intro)
  self._getWay = StringTable.Get(coinCfg.GetWay)
  self._getWayIcon = coinCfg.GetWayIcon
  self._icon = itemCfg.Icon
  self._isSpecial = coinCfg.IsSpecial == 1
  self._sortPriority = coinCfg.Sort
  self._model = coinCfg.Model
  self._effect1 = coinCfg.ThrowEffect1
  self._effect1AttachPath = coinCfg.ThrowEffect1AttachPath
  self._effect2 = coinCfg.ThrowEffect2
  self._effect2AttachPath = coinCfg.ThrowEffect2AttachPath
  self:Refresh()
end

function UIBuildCollectCoinData:GetEffect1()
  return self._effect1
end

function UIBuildCollectCoinData:GetEffect1AttachPath()
  return self._effect1AttachPath
end

function UIBuildCollectCoinData:GetEffect2()
  return self._effect2
end

function UIBuildCollectCoinData:GetEffect2AttachPath()
  return self._effect2AttachPath
end

function UIBuildCollectCoinData:GetModel()
  return self._model
end

function UIBuildCollectCoinData:GetName()
  if self._hasCollect then
    return self._name
  end
  return HomelandWishingConst.GetDefaultCoinfName()
end

function UIBuildCollectCoinData:GetDes()
  if self._hasCollect then
    return self._des
  end
  return HomelandWishingConst.GetDefaultCoinDes()
end

function UIBuildCollectCoinData:GetGetWay()
  if not self._hasCollect and self._isSpecial then
    return HomelandWishingConst.GetDefaultCoinGetWay()
  end
  return self._getWay
end

function UIBuildCollectCoinData:GetGetWayIcon()
  if not self._hasCollect and self._isSpecial then
    return HomelandWishingConst.GetDefaultCoinGetWayIcon()
  end
  return self._getWayIcon
end

function UIBuildCollectCoinData:GetIcon()
  if self._hasCollect then
    return self._icon
  end
  return HomelandWishingConst.GetDefaultCoinIcon()
end

function UIBuildCollectCoinData:GetIsSpecial()
  return self._isSpecial
end

function UIBuildCollectCoinData:HasCollect()
  return self._hasCollect
end

function UIBuildCollectCoinData:GetSortProprity()
  local priority = self._sortPriority
  if not self._hasCollect and HomelandWishingConst.CanCollectCoin(self._coinId) then
    priority = priority - 100000
  end
  return priority
end

function UIBuildCollectCoinData:GetCoinId()
  return self._coinId
end

function UIBuildCollectCoinData:Refresh()
  self._hasCollect = HomelandWishingConst.IsCoinCollected(self._coinId)
end

_class("UIBuildCollectCoinDatas", Object)
UIBuildCollectCoinDatas = UIBuildCollectCoinDatas

function UIBuildCollectCoinDatas:Constructor()
  self._datas = {}
  local cfgs = Cfg.cfg_item_wishing_coin({})
  for _, v in pairs(cfgs) do
    self._datas[#self._datas + 1] = UIBuildCollectCoinData:New(v.ID)
  end
  self:Sort()
end

function UIBuildCollectCoinDatas:GetCollectCoinDatas()
  return self._datas
end

function UIBuildCollectCoinDatas:Sort()
  table.sort(self._datas, function(a, b)
    return a:GetSortProprity() < b:GetSortProprity()
  end)
end

function UIBuildCollectCoinDatas:Refresh()
  for i = 1, #self._datas do
    self._datas[i]:Refresh()
  end
  self:Sort()
end

function UIBuildCollectCoinDatas:HasCollectCoin()
  for i = 1, #self._datas do
    local data = self._datas[i]
    if not data:HasCollect() and HomelandWishingConst.CanCollectCoin(data:GetCoinId()) then
      return true
    end
  end
  return false
end
