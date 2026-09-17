local this = {}

function this.socket_5001(data, errorCode)
  if data == true or data == false then
    return
  end
  this.initGame(data, errorCode)
end

function this.initGame(data, errorCode)
  if errorCode == L_Const.errorCode.ErrCodeSucc then
    this.enterGame(data, errorCode)
  end
end

function this.enterGame(data, errorCode)
  if data.data then
    local baseInfo = data.data.basic_info
    if not table.isEmpty(baseInfo) then
      L_PlayerStore:refreshBaseInfo(baseInfo)
    end
  end
end

return this
