local ParticleSystemSwitch = {}

function ParticleSystemSwitch:Init(obj)
  self:SetCallback(obj)
  obj:SetActive(false)
end

function ParticleSystemSwitch:SetCallback(obj)
  local root = obj.transform
  local size = root.childCount - 1
  for i = 0, size do
    local go = root:GetChild(i)
    if go then
      local stopScript = go:GetComponent(typeof(CS.Framework.ParticleSystemStop))
      if stopScript then
        stopScript:SetStopCallback(function()
          obj:SetActive(false)
        end)
      end
    end
  end
end

function ParticleSystemSwitch:Trigger(obj)
  obj:SetActive(true)
end

return ParticleSystemSwitch
