_class("UIWidgetInnerAutoBeadItem", UICustomWidget)
UIWidgetInnerAutoBeadItem = UIWidgetInnerAutoBeadItem

function UIWidgetInnerAutoBeadItem:OnShow(uiParams)
  self._atlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self._controller = self.uiOwner
  self:InitWidget()
end

function UIWidgetInnerAutoBeadItem:InitWidget()
  self._gameObject = self.view:GetGameObject()
  self._transform = self._gameObject.transform
  self._bg = self:GetUIComponent("Image", "Bg")
  self._root = self:GetGameObject("Type")
  self._type = self:GetUIComponent("Image", "Type")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._star = self:GetGameObject("Star")
  self._starGO = {}
  self._starGO[1] = self:GetGameObject("Star1")
  self._starGO[2] = self:GetGameObject("Star2")
  self._starGO[3] = self:GetGameObject("Star3")
  self._iconGO = self:GetGameObject("Icon")
  self._selected = self:GetGameObject("Selected")
  self._tagLock = self:GetUIComponent("Image", "TagLock")
end

function UIWidgetInnerAutoBeadItem:SetData(index, data, callBack, totalTagDic)
  self._index = index
  self._data = data
  self._uid = data.unique_id
  self._cfgID = data.bead_id
  self._callBack = callBack
  if self._data then
    if self:IsEmptySlot() then
      self._root:SetActive(false)
    else
      self._cfg = Cfg.cfg_component_season_maze_autobead[self._cfgID]
      if self._cfg then
        self._type.sprite = self._atlas:GetSprite(self:_GetTypeSprite(self._cfg))
        self._icon.gameObject:SetActive(true)
        self._icon:LoadImage(self._cfg.Icon)
        for key, value in ipairs(self._starGO) do
          value:SetActive(key < self._cfg.Lv)
        end
        local isLock = not self:_ContainTag(self._cfg.NeedTag)
        self:TagLock(isLock)
      end
      self._root:SetActive(true)
    end
  else
    self._root:SetActive(false)
  end
end

function UIWidgetInnerAutoBeadItem:_ContainTag(tags)
  if not tags then
    return true
  end
  local contain = false
  local beadList = InnerGameHelperRender.GetAutoBeadList()
  if beadList then
    for _, info in ipairs(beadList) do
      local cfg = Cfg.cfg_component_season_maze_autobead[info.bead_id]
      if cfg and cfg.Tag then
        for _, _tag in ipairs(cfg.Tag) do
          if table.icontains(tags, _tag) then
            contain = true
            break
          end
        end
      end
    end
  end
  return contain
end

function UIWidgetInnerAutoBeadItem:IsEmptySlot()
  return self._cfgID == 0
end

function UIWidgetInnerAutoBeadItem:IconOnClick(go)
  if self._data and not self:IsEmptySlot() and self._callBack then
    self._callBack(self._uid, self._cfgID, self._data, go.transform.position)
  end
end

function UIWidgetInnerAutoBeadItem:_GetTypeSprite(cfg)
  if cfg.Type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Skill then
    return "thread_junei_zdz01"
  elseif cfg.Type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Strong then
    return "thread_junei_zdz02"
  elseif cfg.Type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Energy then
    return "thread_junei_zdz03"
  end
  return "cn14_sjmj_xdjmk_di12"
end

function UIWidgetInnerAutoBeadItem:Transform()
  return self._transform
end

function UIWidgetInnerAutoBeadItem:Index()
  return self._index
end

function UIWidgetInnerAutoBeadItem:Data()
  return self._data
end

function UIWidgetInnerAutoBeadItem:Level()
  if self._cfg then
    return self._cfg.Lv
  end
  return 0
end

function UIWidgetInnerAutoBeadItem:IsMax()
  if self._cfg then
    return self._cfg.Lv == 4
  end
  return false
end

function UIWidgetInnerAutoBeadItem:OnSelect(select)
  self._selected:SetActive(select)
end

function UIWidgetInnerAutoBeadItem:TagLock(lock)
  self._tagLock.enabled = lock
end
