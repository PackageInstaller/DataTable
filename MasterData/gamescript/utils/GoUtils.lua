local GoUtils = {}

function GoUtils.GetComponentInParent(go, compType)
  if IsNil(go) then
    return nil
  end
  local parent = go.transform
  while nil ~= parent do
    local comp = parent.gameObject:GetComponent(compType)
    if comp then
      return comp
    end
    parent = parent.parent
  end
  return nil
end

return GoUtils
