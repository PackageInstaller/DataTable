require("base_ins_r")
_class("PlayZhongxuWaitRevertInstruction", BaseInstruction)
PlayZhongxuWaitRevertInstruction = PlayZhongxuWaitRevertInstruction

function PlayZhongxuWaitRevertInstruction:Constructor(paramList)
end

function PlayZhongxuWaitRevertInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local bvcmpt = casterEntity:BuffView()
  if not bvcmpt then
    return
  end
  local transToCatTaskID = bvcmpt:GetBuffValue("ZhongxuTrasnRevertTaskID")
  if transToCatTaskID and 0 < transToCatTaskID then
    local taskIDs = {transToCatTaskID}
    while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDs) do
      YIELD(TT)
    end
  end
  local transToPetPlayed = bvcmpt:GetBuffValue("ZhongxuCatTrasnToPetPlayed")
  if transToPetPlayed and transToPetPlayed == 1 then
  else
    local entity = casterEntity
    local effectHolderCmpt = entity:EffectHolder()
    if effectHolderCmpt then
      local effectService = self._world:GetService("Effect")
      local permanentEffectList = effectHolderCmpt:GetChainMovePermanentEffect()
      effectService:_DestroyEffectArray(permanentEffectList)
      effectHolderCmpt:ClearChainMovePermanentEffectIDListAfterDestroy()
      self:_ZhongxuShowHideModel(entity, true)
      bvcmpt:SetBuffValue("ZhongxuCatTrasnToPetPlayed", 1)
    end
  end
end

function PlayZhongxuWaitRevertInstruction:_ZhongxuShowHideModel(entity, bShow)
  Log.debug("PlayZhongxuWaitRevertInstruction, ZhongxuShowHideModel ,", bShow)
  local cView = entity:View()
  if cView then
    local CSGameObject = cView:GetGameObject()
    local CSGameObjectRoot = CSGameObject.transform:Find("Root")
    local tSkinnedMeshRender = CSGameObjectRoot.transform:GetComponentsInChildren(typeof(UnityEngine.SkinnedMeshRenderer))
    for i = 0, tSkinnedMeshRender.Length - 1 do
      tSkinnedMeshRender[i].enabled = bShow
    end
  end
end
