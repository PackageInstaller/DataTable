_class("UIHauteCoutureGetItemController", UIController)
UIHauteCoutureGetItemController = UIHauteCoutureGetItemController

function UIHauteCoutureGetItemController:Constructor()
end

function UIHauteCoutureGetItemController:OnShow(uiParams)
  self._title = self:GetUIComponent("UILocalizationText", "txt_title")
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  local itemInfo = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._selectInfo = itemInfo:SpawnObject("UIHauteSelectInfo")
  local items = uiParams[1]
  local titleTex = uiParams[2] or StringTable.Get("str_senior_skin_draw_get_item_title")
  self._title:SetText(titleTex)
  local noSort = uiParams[3]
  self._callback = uiParams[4]
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
        item_id = sortItems[i].assetid,
        item_count = sortItems[i].count,
        item_des = sortItems[i].des,
        award_type = sortItems[i].type,
        icon = ItemTempleate.Icon,
        item_name = ItemTempleate.Name,
        simple_desc = ItemTempleate.RpIntro,
        color = ItemTempleate.Color,
        showTag = sortItems[i].goumai
      }
    end
  end
  if self._items and next(self._items) then
    self._pool:SpawnObjects("UIHauteCoutureGetItemCell", #self._items)
    local pools = self._pool:GetAllSpawnList()
    for i = 1, #pools do
      local item = pools[i]
      local data = self._items[i]
      item:SetData(data, function(id, pos)
        self:ItemClick(id, pos)
      end)
    end
  end
end

function UIHauteCoutureGetItemController:ItemClick(id, pos)
  if self._selectInfo then
    self._selectInfo:SetData(id, pos)
  end
end

function UIHauteCoutureGetItemController:bgOnClick(go)
  if self._callback then
    self._callback()
  end
  self:CloseDialog()
end
