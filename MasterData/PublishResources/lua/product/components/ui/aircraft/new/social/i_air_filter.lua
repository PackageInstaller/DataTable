_class("IAirFilter", Object)
IAirFilter = IAirFilter

function IAirFilter:Filter(elements)
end

_class("SocialWeightFilter", IAirFilter)
SocialWeightFilter = SocialWeightFilter

function SocialWeightFilter:Filter(pet)
  return true
end

_class("AreaFilter", IAirFilter)
AreaFilter = AreaFilter

function AreaFilter:Filter(pet)
  local area = pet:GetWanderingArea()
  local spaceId = pet:GetSpace()
  return area ~= nil
end
