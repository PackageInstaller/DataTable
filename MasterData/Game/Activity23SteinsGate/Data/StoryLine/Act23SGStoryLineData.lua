local Act23SGStoryLineData = class("Act23SGStoryLineData")

function Act23SGStoryLineData:ctor(lineIndex)
  self.__lineId = lineIndex
  self.__isCouldShow = nil
  self.lineCfg = ConfigData.activity_23steinsgate_line[self.__lineId]
end

function Act23SGStoryLineData:Act23GSLN_GetIsLineCouldShow()
  return self.__isCouldShow
end

function Act23SGStoryLineData:Act23GSLN_SetIsCouldShow(isCouldShow)
  self.__isCouldShow = isCouldShow
end

function Act23SGStoryLineData:Act23GSLN_Get()
  if self.lineCfg == nil then
    return "?"
  end
  return self.lineCfg.digit
end

return Act23SGStoryLineData
