_class("UIHomelandMinimapIconData", Object)
UIHomelandMinimapIconData = UIHomelandMinimapIconData

function UIHomelandMinimapIconData:Constructor(miniMap, id, index, transform, iconContainer, params)
  self._markType = nil
  self._markId = nil
  self._id = id
  self._index = index
  self._transform = transform
  self._iconContainer = iconContainer
  local cfg = Cfg.cfg_homeland_minimap_icon[id]
  if cfg == nil then
    Log.error(" UIHomelandMinimapIconData:Constructor cfg_homeland_minimap_icon cant find ", index)
  end
  self._prefabName = cfg.IconPrefab
  self._scriptName = cfg.IconScript
  self._detailPrefab = cfg.DetailPrefab
  self._detailScript = cfg.DetailScript
  self._canClick = cfg.CanClick == 1
  self._canRotate = cfg.CanRotate == 1
  self._showIcon = cfg.ShowIcon
  self._showName = nil
  if cfg.ShowName then
    self._showName = StringTable.Get(cfg.ShowName)
  end
  self._showMinScaleRange = cfg.ShowScaleRange[1] / 1000
  self._showMaxScaleRange = cfg.ShowScaleRange[2] / 1000
  self._params = params
  self._showArrow = cfg.ShowArrow == 1
  self._arrowIconRotation = cfg.ArrowIconRotation == 1
  self._arrowIcon = cfg.ArrowIcon
  self._arrowIconOffset = Vector2(cfg.Offset[1] / 1000, cfg.Offset[2] / 1000)
  self._arrowIconSize = Vector2(cfg.Size[1] / 1000, cfg.Size[2] / 1000)
  self._miniMap = miniMap
  self._arrowItem = nil
  if self._showArrow then
    self._arrowItem = self._miniMap:AddArrow(self)
  end
  self._iconContainer:Refresh(self)
end

function UIHomelandMinimapIconData:GetMarkType()
  return self._markType
end

function UIHomelandMinimapIconData:SetMarkType(markType)
  self._markType = markType
end

function UIHomelandMinimapIconData:GetMarkId()
  return self._markId
end

function UIHomelandMinimapIconData:SetMarkId(markId)
  self._markId = markId
end

function UIHomelandMinimapIconData:GetMinimap()
  return self._miniMap
end

function UIHomelandMinimapIconData:GetMinimapStatus()
  return self._miniMap:GetMapStatus()
end

function UIHomelandMinimapIconData:GetScreenInfo()
  return self._miniMap:GetScreenInfo()
end

function UIHomelandMinimapIconData:UpdateArrowItem(item)
  self._arrowItem = item
end

function UIHomelandMinimapIconData:UpdateContainerItem(item)
  self._iconContainer = item
  self._iconContainer:Refresh(self)
end

function UIHomelandMinimapIconData:GetArrowItem()
  return self._arrowItem
end

function UIHomelandMinimapIconData:IsShowArrow()
  return self._showArrow
end

function UIHomelandMinimapIconData:IsArrowIconRotation()
  return self._arrowIconRotation
end

function UIHomelandMinimapIconData:GetArrowIcon()
  return self._arrowIcon
end

function UIHomelandMinimapIconData:GetArrowIconOffset()
  return self._arrowIconOffset
end

function UIHomelandMinimapIconData:GetArrowIconSize()
  return self._arrowIconSize
end

function UIHomelandMinimapIconData:GetId()
  return self._id
end

function UIHomelandMinimapIconData:GetIndex()
  return self._index
end

function UIHomelandMinimapIconData:GetSerializeId()
  if self._index == nil then
    return self._id * 10000
  end
  return self._id * 10000 + self._index
end

function UIHomelandMinimapIconData:GetTransform()
  return self._transform
end

function UIHomelandMinimapIconData:GetPrefabName()
  return self._prefabName
end

function UIHomelandMinimapIconData:GetScriptName()
  return self._scriptName
end

function UIHomelandMinimapIconData:GetIconContainer()
  return self._iconContainer
end

function UIHomelandMinimapIconData:GetDetailPrefab()
  return self._detailPrefab
end

function UIHomelandMinimapIconData:GetDetailScript()
  return self._detailScript
end

function UIHomelandMinimapIconData:GetCanClick()
  return self._canClick
end

function UIHomelandMinimapIconData:GetCanRotate()
  return self._canRotate
end

function UIHomelandMinimapIconData:GetShowIcon()
  return self._showIcon
end

function UIHomelandMinimapIconData:GetShowName()
  return self._showName
end

function UIHomelandMinimapIconData:CanShow(scale)
  if scale < self._showMinScaleRange or scale > self._showMaxScaleRange then
    return self._iconContainer:CanShow()
  end
  return true
end

function UIHomelandMinimapIconData:GetMapScale()
  return self._miniMap:GetMapScale()
end

function UIHomelandMinimapIconData:GetParam()
  return self._params
end

function UIHomelandMinimapIconData:Update()
  if self._iconContainer then
    self._iconContainer:Update()
  end
  if self._arrowItem then
    self._arrowItem:Update()
  end
end

function UIHomelandMinimapIconData:IsPlayer()
  return "UIHomelandMinimapIconPlayer" == self:GetScriptName()
end
