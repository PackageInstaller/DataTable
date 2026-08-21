require("reactive_system")
_class("AnimatorControllerSystem_Render", ReactiveSystem)
AnimatorControllerSystem_Render = AnimatorControllerSystem_Render

function AnimatorControllerSystem_Render:Constructor(world)
  self._world = world
end

function AnimatorControllerSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.AnimatorController)
  local c = Collector:New({group}, {"Added"})
  return c
end

function AnimatorControllerSystem_Render:Filter(entity)
  return entity:HasAnimatorController() and entity:HasView()
end

function AnimatorControllerSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    local e = entities[i]
    self:HandleEntity(e)
  end
end

function AnimatorControllerSystem_Render:HandleEntity(e)
  local cAnimatorController = e:AnimatorController()
  local gameObject = e:View().ViewWrapper.GameObject
  local specialRoot = cAnimatorController.specialAnimRoot
  local rootName = "Root"
  if specialRoot then
    rootName = specialRoot
  end
  local rootTF = gameObject.transform:Find(rootName)
  if rootTF == nil then
    Log.fatal("[animator] AnimatorControllerSystem_Render find root error ", e:View():GetResRequest().m_Name)
    cAnimatorController.AniTriggerTable = {}
    return
  end
  local animator = rootTF:GetComponent("Animator")
  animator = animator or gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))
  if not animator then
    Log.fatal("[animator] AnimatorControllerSystem_Render find Animator error ", e:View():GetResRequest().m_Name)
    cAnimatorController.AniTriggerTable = {}
    cAnimatorController.AnimatorLayerWeightTable = {}
    return
  end
  for layerIndex, weight in pairs(cAnimatorController.AnimatorLayerWeightTable) do
    animator:SetLayerWeight(layerIndex, weight)
  end
  if not cAnimatorController.bKeepAnimatorLayerWeight then
    cAnimatorController.AnimatorLayerWeightTable = {}
  end
  for param, value in pairs(cAnimatorController.AniBoolTable) do
    animator:SetBool(param, value)
    if e:HasAttachmentController() and param == "Move" then
      e:SetAttachmentAnimationBool(param, value)
    end
  end
  local triggerTable = cAnimatorController.AniTriggerTable
  for i = 1, #triggerTable do
    if triggerTable[i] == "Hit" and e:HasPetPstID() then
      local hittime = GameObjectHelper.GetActorAnimationLength(rootTF.gameObject, "hit")
      GameGlobal.TaskManager():CoreGameStartTask(self.SetHitFace, self, e, rootTF, hittime * 1000)
    end
    animator:SetTrigger(triggerTable[i])
    if e:HasAttachmentController() and (triggerTable[i] == "Hit" or triggerTable[i] == "Death" or triggerTable[i] == "Move") then
      e:SetAttachmentAnimationTrigger(triggerTable[i])
    end
  end
  cAnimatorController.AniTriggerTable = {}
end

function AnimatorControllerSystem_Render:SetHitFace(TT, entity, rootTF, hittime)
  if not entity:HasPetPstID() then
    return
  end
  local templateid = entity:PetPstID():GetTemplateID()
  local face_name = tostring(templateid) .. "_face"
  local face = GameObjectHelper.FindChild(rootTF, face_name)
  if not face then
    return
  end
  local render = face.gameObject:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))
  if render then
    local faceMat = render.material
    faceMat:SetInt("_Frame", 6)
    YIELD(TT, hittime)
    faceMat:SetInt("_Frame", 1)
  end
end

function AnimatorControllerSystem_Render:SetAnimatorLayerWeight(TT, entity, rootTF, hittime)
  if not entity:HasPetPstID() then
    return
  end
  local templateid = entity:PetPstID():GetTemplateID()
  local face_name = tostring(templateid) .. "_face"
  local face = GameObjectHelper.FindChild(rootTF, face_name)
  if not face then
    return
  end
  local render = face.gameObject:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))
  if render then
    local faceMat = render.material
    faceMat:SetInt("_Frame", 6)
    YIELD(TT, hittime)
    faceMat:SetInt("_Frame", 1)
  end
end
