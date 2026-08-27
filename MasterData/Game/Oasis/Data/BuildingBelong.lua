local BuildingBelong = {Oasis = 1, Sector = 2}
BuildingBelong.SectorType = {production = 201, Addition = 202}

function BuildingBelong.CheckBelong(buildingType)
  if 100 <= buildingType and buildingType <= 109 then
    return BuildingBelong.Oasis
  elseif 200 <= buildingType and buildingType <= 209 then
    return BuildingBelong.Sector
  else
    error("建筑type错误： " .. tostring(buildingType))
  end
end

return BuildingBelong
