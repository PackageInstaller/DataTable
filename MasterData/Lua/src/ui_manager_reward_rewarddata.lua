local this = class("rewardData")

function this:ctor(rewards)
  if rewards == nil then
    return
  end
  self.src = rewards.src
  self.seq = rewards.seq
  self.rewards = rewards.rewards
  self.ignoreQueueCheck = false
  self.rewardShowType = L_Const.rewardShowType.none
  self.forceShow = nil
end

function this:constructOne(guid, itemid, itemnum, itemtype)
  self.rewards = {}
  local item = {
    itemid = itemid,
    guid = guid,
    itemnum = itemnum,
    itemtype = itemtype
  }
  table.insert(self.rewards, item)
end

function this:constructList(dataList)
  self.rewards = {}
  if dataList.Count then
    for i = 0, dataList.Count - 1 do
      local v = dataList[i]
      local itemData = {
        itemid = v.itemId or v.itemid,
        itemnum = v.itemNum or v.itemnum,
        deadtime = v.deadTime,
        exts = v.exts,
        itemtype = v.itemType or v.itemtype,
        varitems = v.varitems,
        guid = v.guid,
        collect = v.collect
      }
      table.insert(self.rewards, itemData)
    end
  else
    for i, v in ipairs(dataList) do
      local itemData = {
        itemid = v.itemId or v.itemid,
        itemnum = v.itemNum or v.itemnum,
        deadtime = v.deadTime,
        exts = v.exts,
        itemtype = v.itemType or v.itemtype,
        varitems = v.varitems,
        guid = v.guid,
        collect = v.collect
      }
      table.insert(self.rewards, itemData)
    end
  end
end

return this
