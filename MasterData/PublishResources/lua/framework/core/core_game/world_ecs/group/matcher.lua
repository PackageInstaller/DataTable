_class("Matcher", Object)
Matcher = Matcher

function Matcher:Constructor(allOfIndices, anyOfIndices, noneOfIndices)
  local indices = {}
  for _, v in ipairs(allOfIndices) do
    indices[v] = true
  end
  for _, v in ipairs(anyOfIndices) do
    indices[v] = true
  end
  for _, v in ipairs(noneOfIndices) do
    indices[v] = true
  end
  self.indices = indices
  self._allOfIndices = allOfIndices
  self._anyOfIndices = anyOfIndices
  self._noneOfIndices = noneOfIndices
end

function Matcher:Matches(entity)
  local indices = self.indices
  local allOfIndices = self._allOfIndices
  local anyOfIndices = self._anyOfIndices
  local noneOfIndices = self._noneOfIndices
  return (allOfIndices == nil or entity:HasComponents(allOfIndices)) and (anyOfIndices == nil or #anyOfIndices == 0 or entity:HasAnyComponent(anyOfIndices)) and (noneOfIndices == nil or #noneOfIndices == 0 or not entity:HasAnyComponent(noneOfIndices))
end
