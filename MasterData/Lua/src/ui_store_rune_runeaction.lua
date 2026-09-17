local this = {}

function this:req_CSProtoComposeRune(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoComposeRune, data, function(rspData, errorCode)
    if errorCode ~= L_Const.errorCode.ErrCodeSucc then
      return
    end
    if callback then
      callback(rspData)
    end
    self:call(self.event.composeSuccess)
  end)
end

return this
