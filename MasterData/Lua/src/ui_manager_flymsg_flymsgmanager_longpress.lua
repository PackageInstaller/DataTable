local this = {}

function this:startLongPress(gesture, time, callback)
  AzurWorld.FlymsgManager:StartLongPress(gesture, time, callback)
end

return this
