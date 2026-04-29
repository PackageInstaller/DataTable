_class("UIHauteCoutureDrawGetItemMainKR", UIHauteCoutureDrawGetItemBase)
UIHauteCoutureDrawGetItemMainKR = UIHauteCoutureDrawGetItemMainKR

function UIHauteCoutureDrawGetItemMainKR:Constructor()
end

function UIHauteCoutureDrawGetItemMainKR:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
end

function UIHauteCoutureDrawGetItemMainKR:InitWidgets()
  self:InitWidgetsBase()
  self._title = self:GetUIComponent("UILocalizationText", "txt_title")
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  local itemInfo = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._selectInfo = itemInfo:SpawnObject("UISelectInfo")
  self._selectInfo:SetType(3)
  local detailObj = self._selectInfo:GetG3CustomPool()
  detailObj.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawGetItemCellDetailKR.prefab")
  self._selectDetail = detailObj:SpawnObject("UIHauteCoutureDrawGetItemCellDetailKR")
end

function UIHauteCoutureDrawGetItemMainKR:_OnValue()
  local titleTex = self.controller.titleTex or StringTable.Get("str_senior_skin_draw_get_item_title")
  self._title:SetText(titleTex)
  local items = self.controller.items
  self._items = {}
  local sortItems = {}
  if noSort then
    sortItems = items
  else
    sortItems = self:GetModule(ItemModule):SortRoleAsset(items)
  end
  for i = 1, table.count(sortItems) do
    local ItemTempleate = Cfg.cfg_item[sortItems[i].assetid]
    if ItemTempleate then
      self._items[i] = {
        item_index = i,
        item_id = sortItems[i].assetid,
        item_count = sortItems[i].count,
        item_des = sortItems[i].des,
        award_type = sortItems[i].type,
        icon = ItemTempleate.Icon,
        item_name = ItemTempleate.Name,
        simple_desc = ItemTempleate.RpIntro,
        color = ItemTempleate.Color
      }
    end
  end
  if self._items and next(self._items) then
    self._pool:SpawnObjects("UIHauteCoutureDrawGetItemCellKR", #self._items)
    local pools = self._pool:GetAllSpawnList()
    for i = 1, #pools do
      local item = pools[i]
      local data = self._items[i]
      item:SetData(data, true, function(idx, pos)
        self:ItemClick(idx, pos)
      end)
    end
  end
end

function UIHauteCoutureDrawGetItemMainKR:ItemClick(idx, pos)
  if self._selectInfo then
    self._selectDetail:SetData(self._items[idx])
    self._selectInfo:OnlyShow(pos)
  end
end

function UIHauteCoutureDrawGetItemMainKR:BgOnClick(go)
  if self.controller.callback then
    self.controller.callback()
  end
  self.controller:CloseDialog()
end
