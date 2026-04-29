_class("UIStoryModule", UIModule)
UIStoryModule = UIStoryModule

function UIStoryModule:Dispose()
  self._type = UIPlotFromType.None
  self._level_id = nil
end

function UIStoryModule:Constructor()
  self._uiParams = {}
  self._type = UIPlotFromType.None
end

function UIStoryModule:SetType(type)
  self._type = type
end

function UIStoryModule:SetLevelID(levelid)
  local tmpid = levelid or "nil"
  Log.debug("###[UIStoryModule] 设置levelid --> ", tmpid)
  self._level_id = levelid
end

function UIStoryModule:GetLevelID()
  local levelid = self._level_id
  local tmpid = levelid or "nil"
  Log.debug("###[UIStoryModule] 获取levelid --> ", tmpid)
  return levelid
end

function UIStoryModule:GetType()
  return self._type
end

function UIStoryModule:SetUiParams(uiParams)
  self._uiParams = uiParams
end

function UIStoryModule:ResetType()
  self._type = UIPlotFromType.None
end

function UIStoryModule:ResetLevelID()
  self._level_id = nil
end

function UIStoryModule:Goto3DStory()
end

function UIStoryModule:BackFrom3DStory()
  if self._uiParams and table.count(self._uiParams) > 0 then
    Log.debug("###[UIStoryModule] 有数据切到了剧情界面")
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIPlot, table.unpack(self._uiParams))
  else
    Log.debug("###[UIStoryModule] 没有数据切到了主界面")
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  end
end

local UIPlotFromType = {
  None = 0,
  Mission = 1,
  ExtMission = 2,
  Book = 3,
  Quest = 4,
  Other = 99
}
_enum("UIPlotFromType", UIPlotFromType)
