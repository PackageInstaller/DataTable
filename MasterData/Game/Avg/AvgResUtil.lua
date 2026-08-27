local AvgResUtil = {}
local DialogResDic = {
  [1] = "Res/UIPrefabs/Avg/SteinsGateAvgDialog.prefab"
}

function AvgResUtil.GetAvgDialogRes(contentStyle)
  if contentStyle == nil then
    return
  end
  local resPath = DialogResDic[contentStyle]
  if string.IsNullOrEmpty(resPath) then
    error("[Avg]Unsupported DialogResDic, contentStyle:" .. tostring(contentStyle))
    return nil
  end
  return resPath
end

return AvgResUtil
