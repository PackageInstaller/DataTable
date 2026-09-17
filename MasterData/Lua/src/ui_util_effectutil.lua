local util = {}
local starDirection = {
  def = 0,
  up = 1,
  down = 2,
  left = 3,
  right = 4
}
local arrowEffectPath = "pre_arrowhaed"
local effectRootType1 = "root"
local effectRootType2 = "AnimRoot"

function util.playEffect(effectPath, effectParent, scale, offset, dimension, pos, rotation)
  local pathSplit = string.split(effectPath, "/")
  local effectName = string.split(pathSplit[#pathSplit], ".")[1]
  local effect = effectParent.transform:Find(effectName)
  if L_CommonUtil.isValid(effect) then
    C_GameObject.DestroyImmediate(effect.gameObject)
  end
  effect = L_ResPool:syncGameObject(effectPath)
  effect.name = effectName
  effect.transform:SetParent(effectParent.transform)
  L_EffectUtil.setEffectParams(effect, scale, offset, dimension, pos, rotation)
  util.playAudio(effectName)
  return effect
end

function util.setEffectParams(effectObj, scale, offset, dimension, pos, rotation)
  local effect = effectObj
  local rectTrans = effect:GetComponent(typeof(C_RectTransform))
  if dimension then
    rectTrans.sizeDelta = dimension
    if effectObj.name == "pre_circleButtonEffect" then
      local scaleNode = effectObj.transform:Find("root/scaleNode"):GetComponent(typeof(C_RectTransform))
      scaleNode.localScale = L_Vector3.new(dimension.x / 120, dimension.y / 120, 1)
    end
  end
  if scale then
    rectTrans.localScale = scale
  else
    rectTrans.localScale = L_Vector3.one
  end
  if offset then
    rectTrans.anchoredPosition = offset
  else
    rectTrans.anchoredPosition = C_Vector2.zero
  end
  if rotation then
    rectTrans.rotation = rotation
  end
  if pos then
    rectTrans.position = pos
    local tempRectTransOffset = C_Vector2.zero
    if offset then
      tempRectTransOffset = offset
    end
    rectTrans.anchoredPosition = C_Vector2(rectTrans.anchoredPosition.x + tempRectTransOffset.x, rectTrans.anchoredPosition.y + tempRectTransOffset.y)
  end
end

function util.getEffectParams(effectScale, dimension, offset, parentTrans)
  local resScale, resdimension
  local resOffset = C_Vector2.zero
  local targetWorldPosition, targetRotation
  if not string.isEmpty(effectScale) then
    local scaleSplit = string.split(effectScale, "|")
    resScale = L_Vector3.new(tonumber(scaleSplit[1]), tonumber(scaleSplit[2]), 1)
  end
  if not string.isEmpty(dimension) then
    local dimensionSplit = string.split(dimension, "|")
    resdimension = C_Vector2(tonumber(dimensionSplit[1]), tonumber(dimensionSplit[2]))
  end
  if not string.isEmpty(offset) then
    local offsetSplit = string.split(offset, "|")
    resOffset = C_Vector2(tonumber(offsetSplit[1]), tonumber(offsetSplit[2]))
  end
  if parentTrans ~= nil then
    local parentRect = parentTrans:GetComponent(typeof(C_RectTransform))
    local offsetFromPivot = C_Vector3((0.5 - parentRect.pivot.x) * parentRect.rect.width, (0.5 - parentRect.pivot.y) * parentRect.rect.height, 0)
    targetRotation = parentRect.rotation
    targetWorldPosition = parentRect:TransformVector(offsetFromPivot) + parentRect.position
  end
  return resScale, resdimension, resOffset, targetWorldPosition, targetRotation
end

function util.setArrowEffectParams(effectObj, isShowArrow, effectArrowDirection, isOnlyShowEffectArrow)
  C_MJLog.LogInfo("guide Arrow-related parameters：" .. tostring(isShowArrow) .. tostring(effectArrowDirection) .. tostring(isOnlyShowEffectArrow), C_ELogModule.Guide)
  local parentRect = effectObj:GetComponent(typeof(C_RectTransform))
  local arrowEffectTfm = parentRect:Find(arrowEffectPath)
  if arrowEffectTfm == nil then
    C_MJLog.LogInfo("guide error: didn't find arrow effect node", C_ELogModule.Guide)
    return
  end
  local arrowEffectGo = arrowEffectTfm.gameObject
  if not isShowArrow then
    C_MJLog.LogInfo("guide Do not display the guiding arrow", C_ELogModule.Guide)
    arrowEffectGo:SetActive(false)
    return
  end
  arrowEffectGo:SetActive(true)
  local effectRect = arrowEffectGo:GetComponent(typeof(C_RectTransform))
  local parentHeight = parentRect.rect.height
  local parentWidth = parentRect.rect.width
  local effectHeight = effectRect.rect.height
  local effectWidth = effectRect.rect.width
  effectRect.pivot = C_Vector2(0.5, 0.5)
  if effectArrowDirection == starDirection.up then
    effectRect.anchoredPosition3D = C_Vector3.zero
    effectRect.anchoredPosition3D = C_Vector3(0, (parentWidth + effectWidth) / 2, 0)
  elseif effectArrowDirection == starDirection.down then
    effectRect.rotation = C_Quaternion.Euler(0, 0, -180)
    effectRect.anchoredPosition3D = C_Vector3(0, -(parentWidth + effectWidth) / 2, 0)
  elseif effectArrowDirection == starDirection.left then
    effectRect.rotation = C_Quaternion.Euler(0, 0, 90)
    effectRect.anchoredPosition3D = C_Vector3(-(parentWidth + effectWidth) / 2, 0, 0)
  elseif effectArrowDirection == starDirection.right then
    effectRect.rotation = C_Quaternion.Euler(0, 0, 270)
    effectRect.anchoredPosition3D = C_Vector3((parentWidth + effectWidth) / 2, 0, 0)
  elseif effectArrowDirection ~= starDirection.def then
    C_MJLog.LogInfo("@guide error: error arrow effect direction enum type: " .. tostring(effectArrowDirection) .. ", chek the effectArrowDirection value", C_ELogModule.Guide)
    arrowEffectGo:SetActive(false)
    return
  end
  if isOnlyShowEffectArrow then
    local effectGo = parentRect:Find(effectRootType1)
    effectGo = effectGo == nil and parentRect:Find(effectRootType2) or effectGo
    if effectGo ~= nil then
      effectGo.gameObject:SetActive(false)
    end
  end
end

function util.playAnimation(node, animationName, callback, owner)
  local animator = node.gameObject:GetComponent(typeof(C_CsAnimator))
  animator:Play(animationName, -1, 0)
  local length = L_EffectUtil.GetClipLength(animator, animationName)
  Timer.once(length, function()
    if callback then
      callback()
    end
  end, owner, node.gameObject)
end

function util.GetClipLength(animator, clipName)
  local clip = L_CommonUtil.getClip(animator, clipName)
  if clip then
    return clip.length
  end
  return 0
end

function util.playAudio(effectName)
  if effectName == "pre_circleButtonEffect" then
    L_AudioUtil.playSound("Play_SFX_System_HUD_Guide_Hint_Circle_Appear")
  elseif effectName == "pre_squareButtonEffect" then
    L_AudioUtil.playSound("Play_SFX_System_HUD_Guide_Hint_Square_Appear")
  end
end

function util.isElementVerticalVisible(uiElement, viewPortRect, contentRect)
  local uiElementRect = uiElement:GetComponent(typeof(C_RectTransform))
  local itemSize = uiElementRect.sizeDelta
  local itemPos = uiElementRect.anchoredPosition
  local viewPortRectSize = viewPortRect.rect.size
  local contentPos = contentRect.anchoredPosition
  if math.abs(contentPos.y) > math.abs(itemPos.y) then
    return false, math.abs(itemPos.y), true
  end
  if viewPortRectSize.y + math.abs(contentPos.y) > itemSize.y + math.abs(itemPos.y) then
    return true, math.abs(itemPos.y) - (viewPortRectSize.y - itemSize.y)
  end
  return false, math.abs(itemPos.y) - (viewPortRectSize.y - itemSize.y)
end

function util.scrollToItemHorizontal(viewRect, contentRect, itemRect, scrollComponent, callback)
  local viewLocalPos = viewRect:InverseTransformPoint(itemRect.position)
  local itemMinX = viewLocalPos.x - itemRect.rect.width * itemRect.pivot.x
  local itemMaxX = viewLocalPos.x + itemRect.rect.width * (1 - itemRect.pivot.x)
  local viewWidth = viewRect.rect.width
  local halfView = viewWidth * 0.5
  local offset = 0
  if itemMinX < 0 then
    offset = itemMinX
  elseif itemMaxX > viewWidth then
    offset = itemMaxX - viewWidth
  end
  if offset ~= 0 then
    local pos = contentRect.localPosition
    pos.x = pos.x - offset
    contentRect.localPosition = pos
  end
  if callback then
    callback(offset ~= 0)
  end
end

return util
