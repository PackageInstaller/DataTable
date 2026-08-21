local ChapterInfoCsv = require("csvdata.chapter_info")
local CarbonManager = class("CarbonManager")

function CarbonManager:getMapStar(mapId)
  local cur = 0
  local normalSet = ChapterInfoCsv[mapId]
  for index = 1, normalSet.dungeonNum do
    local carbonId = mapId * 100 + index
    local carbon = game.role.carbons[carbonId]
    cur = cur + (carbon and carbon.starNum or 0)
  end
  return cur
end

return CarbonManager
