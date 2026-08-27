local SkyManager = {}
local CS_RenderSettings = CS.UnityEngine.RenderSettings

function SkyManager.ApplySkyboxGroup(groupId, resLoader)
  local groupCfgList = ConfigData.skybox_group[groupId]
  if groupCfgList == nil then
    error("Cant get skybox_group cfg, groupId:" .. tostring(groupId))
    return
  end
  for i = #groupCfgList, 1, -1 do
    local cfg = groupCfgList[i]
    if CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
      local path = PathConsts:GetSkyboxMat(cfg.skybox)
      local mat = resLoader:LoadABAsset(path)
      if not IsNull(mat) then
        CS_RenderSettings.skybox = mat
      end
      return
    end
  end
end

return SkyManager
