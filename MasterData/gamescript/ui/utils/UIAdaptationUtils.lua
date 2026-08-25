local UIAdaptationUtils = {}

function UIAdaptationUtils.RefreshGoHeightByTMPHeight(targetGo, tmpGp, oriHeight)
  tmpGp:ForceMeshUpdate()
  local textCompSize = tmpGp.bounds.size
  targetGo.sizeDelta = CS.UnityEngine.Vector2(targetGo.sizeDelta.x, oriHeight + textCompSize.y)
end

return UIAdaptationUtils
