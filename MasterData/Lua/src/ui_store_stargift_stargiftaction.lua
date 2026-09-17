local this = {}

function this:rsp_syncStarGift(data, errorCode)
  if data.star_gifts then
    for i, v in pairs(data.star_gifts) do
      local data = self:getStarGiftItem(v.item_id, true)
      data.starGiftId = v.item_id
      data.starGiftNum = v.item_num
    end
  end
  if data.del_items then
    for i, v in pairs(data.del_items) do
      self.data.starGiftDic[v] = nil
    end
  end
end

function this:req_changeCSProtoStarGiftEquip(data, callback)
end

return this
