ComponentsBlueprintApplyDic = {}

function ComponentsBlueprintApplyDic.Asset(cmptCfg, entity)
  if cmptCfg ~= nil then
    entity:AddAsset(NativeUnityPrefabAsset:New(cmptCfg))
  end
end

function ComponentsBlueprintApplyDic.Location(cmptCfg, entity)
  local pos = cmptCfg.Pos
  if pos ~= nil then
    entity:SetPosition(Vector3(pos[1], pos[2], pos[3]))
  end
  local dir = cmptCfg.Dir
  if dir ~= nil then
    entity:SetDirection(Vector3(dir[1], dir[2], dir[3]))
  end
end
