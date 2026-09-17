local this = {}

function this:req_CSProtoAddPetFood(operationType, items, buildingGuid, callback)
  local data = {
    items = items,
    build_guid = buildingGuid,
    operate_type = operationType
  }
  L_Net:sendMessage(MsgGenCode.CSProtoAddPetFood, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback(rspData)
    end
  end)
end

return this
