_class("UIHauteCoutureDrawDuplicateRewardBase", UICustomWidget)
UIHauteCoutureDrawDuplicateRewardBase = UIHauteCoutureDrawDuplicateRewardBase

function UIHauteCoutureDrawDuplicateRewardBase:OnShow()
  self:InitWidget()
end

function UIHauteCoutureDrawDuplicateRewardBase:SetData(uiParams)
  self._prizeCfgs = uiParams[1]
  self._replaceIdxs = uiParams[2]
  local count = #self._replaceIdxs
  self._itemInfo = {}
  local items = self.items:SpawnObjects(self:GetItemClassName(), count)
  for i = 1, count do
    items[i]:SetData(self._prizeCfgs[self._replaceIdxs[i]], function(id, pos, count)
      self:OnItemClick(id, pos, count)
    end)
  end
  local itemInfo = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._selectInfo = itemInfo:SpawnObject("UISelectInfo")
  self._selectInfo:SetType(3)
  local detailObj = self._selectInfo:GetG3CustomPool()
  local prefab, class = self:GetGetItemUIInfo()
  detailObj.dynamicInfoOfEngine:SetObjectName(prefab)
  self._selectDetail = detailObj:SpawnObject(class)
end

function UIHauteCoutureDrawDuplicateRewardBase:GetSelectInfoDetailPrefabAndScript()
  return "UIHauteCoutureDrawGetItemCellDetailGL.prefab", "UIHauteCoutureDrawGetItemCellDetailGL"
end

function UIHauteCoutureDrawDuplicateRewardBase:InitWidget()
  self.bg = self:GetUIComponent("RawImageLoader", "bg")
  self.items = self:GetUIComponent("UISelectObjectPath", "items")
end

function UIHauteCoutureDrawDuplicateRewardBase:GetItemClassName()
  return UIHauteCoutureDuplicateItem._className
end

function UIHauteCoutureDrawDuplicateRewardBase:GetGetItemUIInfo()
  Log.exception("子类必须重写此GetGetItemUIInfo方法:", debug.traceback())
end

function UIHauteCoutureDrawDuplicateRewardBase:CloseBtnOnClick(go)
  self.uiOwner:CloseDialog()
end

function UIHauteCoutureDrawDuplicateRewardBase:OnItemClick(id, pos, count)
  if self._selectInfo then
    local cfg = Cfg.cfg_item[id]
    local info = {
      item_id = id,
      item_count = count,
      icon = cfg.Icon,
      item_name = cfg.Name,
      simple_desc = cfg.RpIntro,
      color = cfg.Color
    }
    self._selectDetail:SetData(info)
    self._selectInfo:OnlyShow(pos)
  end
end
