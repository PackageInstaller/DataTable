local this = {}

function this:req_playerCustomData(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoPlayerCustomData, data, function(rsp, errcode)
    if callback ~= nil then
      callback(rsp, errcode)
    end
    if errcode == L_Const.errorCode.ErrCodeSucc then
      self:call(self.event.creatPlayerModOver)
    end
  end)
end

function this:setUrlData(urlData)
  self.cacheUrlData = urlData
end

function this:reqPlayerCustomData(name, sex, cb, failCb)
  local luaUrlData = {}
  for k, v in pairs(self.cacheUrlData) do
    luaUrlData[k] = v
  end
  local avatarData = L_ModStore:getDefaultData(sex)
  local data = {
    name = name,
    wardrobe_info = L_ModStore:transitionDataToServer(avatarData, luaUrlData)
  }
  self:req_playerCustomData(data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if cb then
        cb()
      end
    elseif failCb then
      failCb()
    end
  end)
end

return this
