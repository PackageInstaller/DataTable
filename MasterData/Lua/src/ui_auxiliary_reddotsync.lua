local redDotSync = class("redDotSync")
local tag = "redDotSync"

function redDotSync:ctor(...)
  self._config = L_Config:getConfigDirectly("reddot")
  L_Util.addListener(MsgGenCode.CSProtoRedPointInfosSync, function(msg)
    self:handleData(msg)
  end)
end

function redDotSync:handleData(data)
  if next(data) then
    for i, v in ipairs(data.redpoints) do
      local config = self._config[v]
      L_RedDotHelper:changeValue(config.RedDot_Path, 1)
      printf(tag, "服务器推送添加红点：" .. config.RedDot_Path)
    end
    for i, v in ipairs(data.dredpoints) do
      local config = self._config[v]
      L_RedDotHelper:changeValue(config.RedDot_Path, 0)
      printf(tag, "服务器推送删除红点：" .. config.RedDot_Path)
    end
  end
end

return redDotSync
