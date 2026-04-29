_class("UISeasonMazeObj", Object)
UISeasonMazeObj = UISeasonMazeObj

function UISeasonMazeObj:Constructor(sample, module)
  self._mazeID = sample.id
  self._mazeType = sample.camp_type
  self._module = module
end

function UISeasonMazeObj:GetMazeID()
  return self._mazeID
end

function UISeasonMazeObj:GetComponent(cptID)
  local proccess = self._module:GetLocalProcess(self._mazeType, self._mazeID)
  return proccess and proccess:GetComponent(cptID)
end

function UISeasonMazeObj:GetComponentInfo(cptID)
  local localProcess = self._module:GetLocalProcess(self._mazeType, self._mazeID)
  return localProcess and localProcess:GetComponentInfo(cptID)
end

function UISeasonMazeObj:GetMazeComponent()
  return self:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
end

function UISeasonMazeObj:CheckErrorCode(result)
  self._module:CheckErrorCode(result)
end
