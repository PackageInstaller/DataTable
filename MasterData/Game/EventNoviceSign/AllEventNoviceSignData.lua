local AllEventNoviceSignData = class("AllEventNoviceSignData")
local EventNoviceSignData = require("Game.EventNoviceSign.EventNoviceSignData")

function AllEventNoviceSignData:ctor()
  self.dataDic = {}
end

function AllEventNoviceSignData:InitNoviceSignData(signActDic)
  self.dataDic = {}
  for i, v in pairs(signActDic) do
    local data = EventNoviceSignData.New()
    data:InitNoviceSignData(v)
    self.dataDic[v.id] = data
  end
end

function AllEventNoviceSignData:UpdateNoviceSignData(signAct)
  local data = self.dataDic[signAct.id]
  if data == nil then
    data = EventNoviceSignData.New()
    self.dataDic[signAct.id] = data
    data:InitNoviceSignData(signAct)
  else
    data:UpdateNoviceSignData(signAct)
  end
end

function AllEventNoviceSignData:GetSortSignDataIdList()
  local list = {}
  for k, v in pairs(self.dataDic) do
    table.insert(list, k)
  end
  table.sort(list, function(a, b)
    local orderA = self.dataDic[a]:GetSignCfg().order
    local orderB = self.dataDic[b]:GetSignCfg().order
    return orderA < orderB
  end)
  return list
end

return AllEventNoviceSignData
