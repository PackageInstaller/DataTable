_class("UICG", Object)
UICG = UICG

function UICG.GetResType(resName)
  local resType = UICGResType.CG
  if string.endwith(resName, "_cg") then
    resType = UICGResType.CG
  elseif string.find(resName, "_spine_") or string.startwith(resName, "l2d_") then
    resType = UICGResType.Spine
  end
  return resType
end

function UICG.SetDefaultValue(tran)
  if not tran then
    return
  end
  tran.anchoredPosition = Vector2.zero
  tran.localScale = Vector3.one
end

function UICG.SetTransform(tran, uiName, resName, cfgGroupIndex)
  resName = DynamicCG.ReplaceL2D(resName)
  cfgGroupIndex = cfgGroupIndex or 1
  local cfg = Cfg.pet_cg_transform({ResName = resName, UIName = uiName})
  if not cfg then
    UICG.SetDefaultValue(tran)
    return
  end
  local v = cfg[1]
  if not v then
    UICG.SetDefaultValue(tran)
    return
  end
  local resType = UICG.GetResType(resName)
  local transform
  if resType == UICGResType.CG then
    transform = v.CGTransform
  elseif resType == UICGResType.Spine then
    transform = v.SpineTransform
  else
    Log.fatal("### UICG unknown resType:", resName, uiName)
  end
  if not transform then
    UICG.SetDefaultValue(tran)
    return
  end
  local startIndex = (cfgGroupIndex - 1) * 5
  local posX, posY, scale, width, height = transform[startIndex + 1], transform[startIndex + 2], transform[startIndex + 3], transform[startIndex + 4], transform[startIndex + 5]
  tran.anchoredPosition = Vector2(posX, posY)
  tran.localScale = Vector3(scale, scale, scale)
  if width and height then
    tran.sizeDelta = Vector2(width, height)
  end
end

local UICGResType = {CG = 0, Spine = 1}
_enum("UICGResType", UICGResType)
