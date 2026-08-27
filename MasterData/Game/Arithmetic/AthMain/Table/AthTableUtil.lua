local AthTableUtil = {}

function AthTableUtil.GetAthGridIdList(athData, pos, sizeX)
  local athSize = athData:GetAthSize()
  local gridIdList = {pos}
  if athSize == 2 then
    local gridId = pos + sizeX
    table.insert(gridIdList, gridId)
  elseif athSize == 4 then
    for i = 0, 1 do
      local gridId
      if i ~= 0 then
        gridId = pos + i
        table.insert(gridIdList, gridId)
      end
      gridId = pos + i + sizeX
      table.insert(gridIdList, gridId)
    end
  elseif athSize == 8 then
    for i = 0, 1 do
      for j = 0, 3 do
        if i ~= 0 or j ~= 0 then
          local gridId = pos + i + sizeX * j
          table.insert(gridIdList, gridId)
        end
      end
    end
  end
  return gridIdList
end

return AthTableUtil
