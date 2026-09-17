local test = {}

function test:SendGMCommand(command, args)
  local msg = {command = command, args = args}
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end

return test
