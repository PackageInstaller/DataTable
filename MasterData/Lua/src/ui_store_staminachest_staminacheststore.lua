local this = class("staminaChestStore", G_BaseStore)

function this:req_CSProtoStaminaBoxGet(boxId, times, cb)
  local data = {box_id = boxId, times = times}
  L_Net:sendMessage(MsgGenCode.CSProtoStaminaBoxGet, data, cb)
end

return this
