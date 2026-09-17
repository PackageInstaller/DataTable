local this = {}
local _librarySeriesTpl = L_GameTpl:getLibrarySeriesTpl()

function this:req_getBook(bookId, getType, callback)
  local data = {book_id = bookId, get_type = getType}
  L_Net:sendMessage(MsgGenCode.CSProtoReadHandbookGet, data, function(rspData, errorCode)
    callback(rspData, errorCode)
  end)
end

function this:req_bookRead(bookIds, callback)
  local data = {book_id = bookIds}
  L_Net:sendMessage(MsgGenCode.CSProtoReadHandbookRead, data, function(rspData, errorCode)
    callback(rspData, errorCode)
  end)
end

function this:req_bookReadBySeriesId(seriesid)
  local seriesTpl = _librarySeriesTpl:getTplById(seriesid)
  local sendList = {}
  for k, v in pairs(seriesTpl.subId) do
    if L_LibraryBookStore:isLbiraryBookUnReaded(v) then
      table.insert(sendList, v)
    end
  end
  if sendList == nil or #sendList == 0 then
    return
  end
  L_LibraryBookStore:req_bookRead(sendList, function(rspData, errCode)
  end)
end

function this:rsp_syncBookInfo(data)
  if data.infos == nil then
    return
  end
  for k, v in pairs(data.infos) do
    if data.send_type == 1 and not L_LibraryBookStore:isLibraryBookCollect(v.book_id) then
      AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.libraryBook, tonumber(v.book_id))
    end
    local item = self:getDataById(v.book_id)
    if item == nil then
      item = require(L_R.store .. "libraryBook.libraryBookItem").new()
      item.itemId = v.book_id
      item.isNew = v.book_state
      table.insert(self.data.itemDic, item)
    else
      item.itemId = v.book_id
      item.isNew = v.book_state
    end
  end
  self:call(self.event.libraryBookChange)
end

function this:resp_syncBookReddotInfo(data)
  if data.book_id == nil or #data.book_id == 0 then
    return
  end
  for k, v in pairs(self.data.itemDic) do
    for _, v2 in pairs(data.book_id) do
      if v.itemId == v2 then
        v.isNew = 1
      end
    end
  end
  self:call(self.event.libraryBookChange)
end

return this
