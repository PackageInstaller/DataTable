_class("UISeasonMazeItem", UICustomWidget)
UISeasonMazeItem = UISeasonMazeItem

function UISeasonMazeItem:OnShow(uiParams)
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._comInfo = self._component:GetComponentInfo()
  self:InitWidget()
end

function UISeasonMazeItem:InitWidget()
  self._items = self:GetUIComponent("UISelectObjectPath", "Items")
  self._obj = self:GetGameObject("Obj")
end

function UISeasonMazeItem:SetData(data, tips, scale)
  self._data = data
  self._tips = tips
  scale = scale or 1
  self._obj.transform.localScale = Vector3(scale, scale, 1)
  self._itemWidget = self._items:SpawnObject("UIItem")
  self._itemWidget:SetForm(UIItemForm.Base)
  self._itemWidget:SetClickCallBack(function(go)
    self:ShowTips(go)
  end)
  local icon, quality, count = self:GetItemInfo()
  self._itemWidget:SetData({
    icon = icon,
    quality = quality,
    text1 = count
  })
end

function UISeasonMazeItem:BtnOnClick(go)
  self:_ShowTips(go)
end

function UISeasonMazeItem:_ShowTips(go)
  if not self._tips then
    return
  end
  local totalCount = 0
  if self._data.type == SeasonMazeEffectType.SMET_Pro then
    totalCount = self._component:GetAttrValue(self._data.id)
  elseif self._data.type == SeasonMazeEffectType.SMET_Bead then
    if self._comInfo.m_auto_bead_map then
      for _, value in pairs(self._comInfo.m_auto_bead_map) do
        local bead = value
        if self._data.id == bead.bead_info.cfg_id then
          totalCount = totalCount + 1
        end
      end
    end
  else
    totalCount = GameGlobal.GetModule(RoleModule):GetAssetCount(self._data.id)
  end
  self._tips:SetSeasonMazeData(self._data, totalCount, go.transform.position)
end

function UISeasonMazeItem:GetItemInfo()
  local icon, quality, count
  if self._data.type == SeasonMazeEffectType.SMET_Pro then
    local cfg = Cfg.cfg_season_maze_attribute[self._data.id]
    if cfg then
      icon = cfg.ItemIcon
      quality = cfg.Quality
      count = self._data.value_min
    end
  else
    local cfg = Cfg.cfg_item[self._data.id]
    if cfg then
      icon = cfg.Icon
      quality = cfg.Color
      count = self._data.value_min
    end
  end
  return icon, quality, count
end
