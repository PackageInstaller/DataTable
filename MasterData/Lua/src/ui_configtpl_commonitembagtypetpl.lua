local this = class("commonItemBagTypeTpl")

function this:init(config)
  self.data = config
  self._tabId2Id = {}
  for _, conf in pairs(config) do
    self._tabId2Id[conf.commonTabId] = conf.id
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getSortFilter(tpl)
  return tpl.sortFilter == 1
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getId(tpl)
  return tpl.id
end

function this:getShow(tpl)
  return tpl.show
end

function this:getOrder(tpl)
  return tpl.order
end

function this:getLimit(tpl)
  return tpl.limit
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getSortTplList()
  local res = {}
  for i, v in pairs(self.data) do
    if v.show == 1 then
      table.insert(res, v)
    end
  end
  table.sort(res, function(a, b)
    return a.order < b.order
  end)
  return res
end

function this:getTabId(tpl)
  return tpl.commonTabId
end

function this:getIdByTab(tab)
  return self._tabId2Id[tab]
end

function this:getSubType(tpl)
  return tpl.subType
end

return this
