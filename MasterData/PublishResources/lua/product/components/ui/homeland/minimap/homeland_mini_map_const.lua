_class("HomelandMinimapConst", Object)
HomelandMinimapConst = HomelandMinimapConst

function HomelandMinimapConst:Constructor()
end

function HomelandMinimapConst.Init()
  local cfg = Cfg.cfg_homeland_minimap_const[1]
  HomelandMinimapConst.MaxmapScaleSpeed = cfg.ScaleSpeed / 1000
  HomelandMinimapConst.BigmapScale = cfg.DefaultScale / 1000
  HomelandMinimapConst.MinimapScale = cfg.MinimapScale / 1000
  HomelandMinimapConst.MinScale = cfg.MinScale / 1000
  HomelandMinimapConst.MaxScale = cfg.MaxScale / 1000
  local size = cfg.MapSize
  HomelandMinimapConst.MapSize = Vector2(size[1] / 1000, size[2] / 1000)
  size = cfg.MapBackgroundSize
  HomelandMinimapConst.MapBackgroundSize = Vector2(size[1] / 1000, size[2] / 1000)
  size = cfg.MapMinPos
  HomelandMinimapConst.RealMapMinPositionValue = Vector3(size[1] / 1000, size[2] / 1000, size[3] / 1000)
  size = cfg.MapMaxPos
  HomelandMinimapConst.RealMapMaxPositionValue = Vector3(size[1] / 1000, size[2] / 1000, size[3] / 1000)
  HomelandMinimapConst.MapTextureName = cfg.MapTexture
  HomelandMinimapConst.MapBackgroundTextureName = cfg.MapBackgroundTexture
  HomelandMinimapConst.IconClickRange = cfg.IconClickeRange / 1000
  HomelandMinimapConst.FocusSpeed = cfg.FocusSpeed / 1000
end

function HomelandMinimapConst.GetMaxmapScaleSpeed()
  return HomelandMinimapConst.MaxmapScaleSpeed
end

function HomelandMinimapConst.GetBigmapScale()
  return HomelandMinimapConst.BigmapScale
end

function HomelandMinimapConst.SetBigmapScale(scale)
  HomelandMinimapConst.BigmapScale = scale
end

function HomelandMinimapConst.GetMinimapScale()
  return HomelandMinimapConst.MinimapScale
end

function HomelandMinimapConst.GetMinScale()
  return HomelandMinimapConst.MinScale
end

function HomelandMinimapConst.GetMaxScale()
  return HomelandMinimapConst.MaxScale
end

function HomelandMinimapConst.GetMapSize()
  return HomelandMinimapConst.MapSize
end

function HomelandMinimapConst.GetMapBackgroundSize()
  return HomelandMinimapConst.MapBackgroundSize
end

function HomelandMinimapConst.RealMapMinPosition()
  return HomelandMinimapConst.RealMapMinPositionValue
end

function HomelandMinimapConst.RealMapMaxPosition()
  return HomelandMinimapConst.RealMapMaxPositionValue
end

function HomelandMinimapConst.GetMapTextureName()
  return HomelandMinimapConst.MapTextureName
end

function HomelandMinimapConst.GetMapBackgroundTextureName()
  return HomelandMinimapConst.MapBackgroundTextureName
end

function HomelandMinimapConst.GetIconClickRange()
  return HomelandMinimapConst.IconClickRange
end

function HomelandMinimapConst.GetFocusSpeed()
  return HomelandMinimapConst.FocusSpeed
end
