require("base_ins_r")
_class("PlayCasterMeshVisibleInstruction", BaseInstruction)
PlayCasterMeshVisibleInstruction = PlayCasterMeshVisibleInstruction

function PlayCasterMeshVisibleInstruction:Constructor(paramList)
  self._visible = tonumber(paramList.visible)
  self._objs = string.split(paramList.objs, "|")
end

function PlayCasterMeshVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  for i, objName in ipairs(self._objs) do
    local tf = GameObjectHelper.FindChild(casterEntity:View().ViewWrapper.GameObject.transform, objName)
    if tf then
      tf.gameObject:SetActive(self._visible == 1)
    end
  end
end
