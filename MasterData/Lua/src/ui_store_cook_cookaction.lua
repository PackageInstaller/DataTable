local this = {}

function this:req_cook(guid, cookId, count, items, callback)
  local data = {
    build_guid = guid,
    cook_id = cookId,
    cook_count = count,
    cook_material = items
  }
  L_Net:sendMessage(MsgGenCode.CSProtoCookRequest, data, callback)
end

return this
