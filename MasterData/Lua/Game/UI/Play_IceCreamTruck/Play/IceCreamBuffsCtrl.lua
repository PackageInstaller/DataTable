local IceCreamBuffsCtrl = class("IceCreamBuffsCtrl", BaseCtrl)
IceCreamBuffsCtrl._mapEventConfig = {
  Event_InitBuffPool = "InitBuffPool",
  GMEvent_PrintBuffPool = "GM_PrintBuffPool"
}

function IceCreamBuffsCtrl:Awake()
  self.tbCurrentBuffsPool = {}
end

function IceCreamBuffsCtrl:OnEnable()
end

function IceCreamBuffsCtrl:OnDestroy()
  self.tbCurrentBuffsPool = {}
end

function IceCreamBuffsCtrl:InitBuffPool(LevelData)
  if LevelData == nil then
    printError("初始道具池--LevelData 为空")
    return
  end
  self.LevelData = LevelData
  local nPoolId = self.LevelData.BuffPoolId
  local CurrentBuffPool = {}
  
  local function forEachLine_BuffPool(mapLineData)
    if mapLineData.PoolId == nPoolId then
      table.insert(CurrentBuffPool, {
        buffId = mapLineData.BuffId,
        weight = mapLineData.Weight
      })
    end
  end
  
  ForEachTableLine(DataTable.IceCreamBuffPool, forEachLine_BuffPool)
  self.tbCurrentBuffsPool = CurrentBuffPool
end

function IceCreamBuffsCtrl:GetBuffItemID()
  local tbAllBuff = self.tbCurrentBuffsPool
  local tbCandidates = {}
  local nTotalWeight = 0
  for _, mapCfg in ipairs(tbAllBuff) do
    table.insert(tbCandidates, {
      nId = mapCfg.buffId,
      nWeight = mapCfg.weight
    })
    nTotalWeight = nTotalWeight + mapCfg.weight
  end
  if #tbCandidates == 0 or nTotalWeight <= 0 then
    printError("没有可用的候选道具")
    return nil
  end
  local nRand = math.random(1, nTotalWeight)
  local nCumWeight = 0
  local nSelectedId = tbCandidates[1].nId
  for _, item in ipairs(tbCandidates) do
    nCumWeight = nCumWeight + item.nWeight
    if nRand <= nCumWeight then
      nSelectedId = item.nId
      break
    end
  end
  return nSelectedId
end

function IceCreamBuffsCtrl:GM_PrintBuffPool()
  if self.tbCurrentBuffsPool == nil or #self.tbCurrentBuffsPool == 0 then
    printLog("[IceCream][GM] 当前道具池为空")
    return
  end
  local nTotalWeight = 0
  for _, mapCfg in ipairs(self.tbCurrentBuffsPool) do
    nTotalWeight = nTotalWeight + mapCfg.weight
  end
  printLog(string.format("[IceCream][GM] 当前道具池数量=%d, 总权重=%d", #self.tbCurrentBuffsPool, nTotalWeight))
  for _, mapCfg in ipairs(self.tbCurrentBuffsPool) do
    local nBuffId = mapCfg.buffId
    local nWeight = mapCfg.weight
    local mapBuffCfg = ConfigTable.GetData("IceCreamBuff", nBuffId)
    local sName = mapBuffCfg ~= nil and mapBuffCfg.Name or "<未配置>"
    local fProb = 0 < nTotalWeight and nWeight / nTotalWeight * 100 or 0
    printLog(string.format("buffId:%d, Name：%s, weight：%d ,概率：%.2f%%", nBuffId, tostring(sName), nWeight, fProb))
  end
end

return IceCreamBuffsCtrl
