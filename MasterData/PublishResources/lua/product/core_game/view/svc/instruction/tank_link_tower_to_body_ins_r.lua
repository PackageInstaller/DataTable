require("base_ins_r")
_class("TankLinkTowerToBodyInstruction", BaseInstruction)
TankLinkTowerToBodyInstruction = TankLinkTowerToBodyInstruction

function TankLinkTowerToBodyInstruction:Constructor(paramList)
  self._towerResourceName = paramList.towerResourceName
  self._bindGameObjectName = paramList.bindGameObjectName
end

function TankLinkTowerToBodyInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local fxsvc = world:GetService("Effect")
  local towerEntity = fxsvc:CreateEffectEntity()
  towerEntity:ReplaceAsset(NativeUnityPrefabAsset:New(self._towerResourceName, true))
  local csCasterTransform = casterEntity:View():GetGameObject().transform
  local csTowerGameObject = towerEntity:View():GetGameObject()
  local csTowerTransform = csTowerGameObject.transform
  local csMaterialAnim = csTowerGameObject:GetComponent(typeof(MaterialAnimation))
  if not csMaterialAnim or tostring(csMaterialAnim) == "null" then
    csMaterialAnim = csTowerGameObject:AddComponent(typeof(MaterialAnimation))
    local resServ = world.BW_Services.ResourcesPool
    local container = resServ:LoadAsset("globalShaderEffects.asset")
    towerEntity:AddMaterialAnimationComponent(container, csMaterialAnim)
    casterEntity:MaterialAnimationComponent():AddLinkMaterialAnimEntity(towerEntity)
  end
  local csCasterRoot = GameObjectHelper.FindChild(csCasterTransform, "Root")
  csTowerTransform:SetParent(csCasterRoot)
  csTowerTransform.localPosition = Vector3.zero
  csTowerTransform.localRotation = Quaternion.Euler(0, 0, 0)
  towerEntity:AddAnimatorController({}, {})
  if not casterEntity:HasAnimatorController() then
    casterEntity:AddAnimatorController({}, {})
  end
  casterEntity:AnimatorController():AddLinkAnimatorEntity(towerEntity)
  if not casterEntity:HasEffectHolder() then
    casterEntity:AddEffectHolder()
  end
  local cEffectHolder = casterEntity:EffectHolder()
  cEffectHolder:AttachEffect(BattleConst.Tank2002901TowerEffectKey, towerEntity)
end

function TankLinkTowerToBodyInstruction:GetCacheResource()
  return {
    {
      self._towerResourceName,
      1
    }
  }
end
