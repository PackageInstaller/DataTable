local _SetLocalPos = CS.Framework.TransformUtil.SetLocalPos
local Vector3 = CS.UnityEngine.Vector3
local tempVec3 = Vector3(0, 0, 0)
local PortraitUtils = System.NewClass("PortraitUtils")

function PortraitUtils.GetFullName(awakerResource, portraitType)
  portraitType = portraitType or CommonDefine.PortraitType.Middle
  local fullNamePattern = "Portrait_%s_Awaker_%s"
  if string.contains(awakerResource, "SpChar") then
    fullNamePattern = "Portrait_%s_%s"
  end
  do return string.format, fullNamePattern, portraitType end
  return string.format, fullNamePattern, portraitType, awakerResource
end

function PortraitUtils.GetAwakerPrefabPath(awakerResource, portraitType)
  portraitType = portraitType or CommonDefine.PortraitType.Middle
  local fullName = PortraitUtils.GetFullName(awakerResource, portraitType)
  local prefabPath = string.format("UI/UI_Portrait/%s.prefab", fullName)
  return prefabPath
end

function PortraitUtils.GetAwakerAniPrefabPath(awakerResource, portraitType)
  portraitType = portraitType or CommonDefine.PortraitType.Middle
  local fullName = PortraitUtils.GetFullName(awakerResource, portraitType)
  local prefabPath = string.format("UI/UI_Portrait/%s_Ani.prefab", fullName)
  return prefabPath
end

function PortraitUtils.GetAwakerAlphaPath(awakerResource, portraitType)
  portraitType = portraitType or CommonDefine.PortraitType.Middle
  local fullName = PortraitUtils.GetFullName(awakerResource, portraitType)
  local prefabPath = string.format("Portraits/Middle/%s_Alpha.png", fullName)
  return prefabPath
end

function PortraitUtils.GetAwakerTidMiniHead(awakerTid, face)
  local awakerCfg = AwakerDataUtils.GetAwakerConfig(awakerTid)
  if awakerCfg and awakerCfg.AwakerResNum then
    do return PortraitUtils.GetMiniHead, awakerCfg.AwakerResNum end
    return PortraitUtils.GetMiniHead, awakerCfg.AwakerResNum, face
  end
end

function PortraitUtils.GetAwakerTidMiddleHead(awakerTid, face)
  local awakerCfg = AwakerDataUtils.GetAwakerConfig(awakerTid)
  if awakerCfg and awakerCfg.AwakerResNum then
    do return PortraitUtils.GetFaceImg, awakerCfg.AwakerResNum end
    return PortraitUtils.GetFaceImg, awakerCfg.AwakerResNum, face
  end
end

function PortraitUtils.GetMiniHead(awakerResource, face)
  if not awakerResource then
    return
  end
  if not face then
    local pathPattern = "Portraits/Minihead/Portrait_Minihead_Awaker_%s.png"
    if string.contains(awakerResource, "SpChar") then
      pathPattern = "Portraits/Minihead/Portrait_Minihead_%s.png"
    end
    do return string.format, pathPattern end
    return string.format, pathPattern, awakerResource, nil, nil
  else
    local pathPattern = "Portraits/Miniface/Portrait_Minihead_Awaker_%s_Face_%s.png"
    if string.contains(awakerResource, "SpChar") then
      pathPattern = "Portraits/Miniface/Portrait_Minihead_%s_Face_%s.png"
    end
    do return string.format, pathPattern, awakerResource, PortraitUtils.CapitalFirstStr(face) end
    return string.format, pathPattern, awakerResource, PortraitUtils.CapitalFirstStr(face)
  end
end

function PortraitUtils.GetFaceImg(awakerResource, face)
  if not awakerResource or not face then
    return
  end
  local pathPattern = "Portraits/Middleface/Portrait_Middle_Awaker_%s_Face_%s.png"
  if string.contains(awakerResource, "SpChar") then
    pathPattern = "Portraits/Middleface/Portrait_Middle_%s_Face_%s.png"
  end
  local facePath = string.format(pathPattern, awakerResource, PortraitUtils.CapitalFirstStr(face))
  return facePath
end

function PortraitUtils.GetFaceMap(awakerResource, portraitType)
  portraitType = portraitType or CommonDefine.PortraitType.Middle
  local fullName = PortraitUtils.GetFullName(awakerResource, portraitType)
  local cfg = DT.GetPortraitCenter(fullName)
  return cfg and cfg.faces or {}
end

function PortraitUtils.CheckFaceValid(awakerResource, portraitType, face)
  local faceMap = PortraitUtils.GetFaceMap(awakerResource, portraitType)
  return faceMap and faceMap[face]
end

function PortraitUtils.CapitalFirstStr(str)
  local firstLetter = string.upper(string.sub(str, 1, 1))
  local remainingLetters = string.sub(str, 2)
  return firstLetter .. remainingLetters
end

function PortraitUtils.HorizontalCenter(awakerRootTf, awakerImgTf, portraitNo, portraitType)
  portraitType = portraitType or CommonDefine.PortraitType.Middle
  local portraitKey = string.format("Portrait_%s_Awaker_%s", portraitType, portraitNo)
  if portraitKey:contains("SpChar") then
    portraitKey = string.format("Portrait_%s_%s", portraitType, portraitNo)
  end
  local centerData = DT.GetPortraitCenter(portraitKey)
  if not centerData.pivotX or not centerData.pivotY then
    print(string.format("%s没有PortraitCenter数据", portraitKey))
    return
  end
  local centerX, centerY = PortraitUtils.GetCenterXY(centerData)
  tempVec3.x = centerX
  tempVec3.y = centerY
  local centerHeadPos = awakerImgTf:TransformPoint(tempVec3)
  local centerHeadRootPos = awakerRootTf:InverseTransformPoint(centerHeadPos)
  local curImgPos = awakerImgTf.localPosition
  _SetLocalPos(awakerImgTf.transform, curImgPos.x - centerHeadRootPos.x, curImgPos.y, curImgPos.z)
end

function PortraitUtils.VerticalCenter(awakerRootTf, awakerImgTf, portraitNo, portraitType)
  portraitType = portraitType or CommonDefine.PortraitType.Middle
  local portraitKey = string.format("Portrait_%s_Awaker_%s", portraitType, portraitNo)
  if portraitKey:contains("SpChar") then
    portraitKey = string.format("Portrait_%s_%s", portraitType, portraitNo)
  end
  local centerData = DT.GetPortraitCenter(portraitKey)
  if not centerData.pivotX or not centerData.pivotY then
    print(string.format("%s没有PortraitCenter数据", portraitKey))
    return
  end
  local centerX, centerY = PortraitUtils.GetCenterXY(centerData)
  tempVec3.x = centerX
  tempVec3.y = centerY
  local centerHeadPos = awakerImgTf:TransformPoint(tempVec3)
  local centerHeadRootPos = awakerRootTf:InverseTransformPoint(centerHeadPos)
  local curImgPos = awakerImgTf.localPosition
  _SetLocalPos(awakerImgTf.transform, curImgPos.x, curImgPos.y - centerHeadRootPos.y, curImgPos.z)
end

function PortraitUtils.GetCenterXY(centerData)
  local centerX, centerY = centerData.x, centerData.y
  if (centerX > centerData.width or centerY > centerData.height) and centerData.facePosX and centerData.facePosY then
    centerX = centerData.facePosX + 150.0
    centerY = centerData.facePosY + 150.0
  end
  return centerX, centerY
end

return PortraitUtils
