local this = {}

function this:req_playerPhoto(playerId)
end

function this:req_deleteTemplate(id, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoDeletePhotoGraphTemplet, {u32 = id}, function(rspData, errorCode)
    if errorCode ~= L_Const.errorCode.ErrCodeSucc then
      return
    end
    if callback then
      callback(errorCode)
    end
  end)
end

function this:req_renameTemplate(id, nameStr, callback)
  local data = {id = id, name = nameStr}
  L_Net:sendMessage(MsgGenCode.CSProtoChangePhotoGraphTempletName, data, function(rspData, errorCode)
    local isSuccess = errorCode == L_Const.errorCode.ErrCodeSucc
    if callback then
      callback(isSuccess)
    end
    if not isSuccess then
      return
    end
  end)
end

function this:req_createTemplate(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoChangePhotoGraphTempletInfo, data, function(rspData, errorCode)
    local isSuccess = errorCode == L_Const.errorCode.ErrCodeSucc
    if callback then
      callback(isSuccess)
    end
    if not isSuccess then
      return
    end
  end)
end

function this:updateServerTempData(data, errorCode)
  for i, info in pairs(data.infos or table.empty) do
    if info.id and info.id >= 0 then
      L_PhotoStore:createPhotoTemplateData(L_Const.photoTemplateDataType.custom, info.id, info)
    end
  end
end

return this
