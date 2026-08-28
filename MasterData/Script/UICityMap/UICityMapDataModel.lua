local DataModel = {
  initParams = nil,
  stationId = 0,
  cityMapId = 0,
  showCount = 1,
  devNum = 0,
  curShowBubbleList = {}
}

function DataModel.GetCurCityMapId()
  local cityMapId = DataModel.cityMapId
  if cityMapId <= 0 then
    local HomeCommon = require("Common/HomeCommon")
    local stateInfo = HomeCommon.GetCityStateInfo(DataModel.stationId)
    cityMapId = stateInfo.cityMapId
  end
  return cityMapId
end

return DataModel
