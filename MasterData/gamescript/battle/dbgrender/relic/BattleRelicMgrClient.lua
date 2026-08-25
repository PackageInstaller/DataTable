local BattleRelicMgrClient, Super = System.NewClass("BattleRelicMgrClient", BattleEntity)

function BattleRelicMgrClient:ctor()
  Super.ctor(self)
  self.relicList = {}
end

function BattleRelicMgrClient:InitAllRelics(relicDataList)
  self.relicList = {}
  for _, relic in ipairs(relicDataList) do
    if relic.tid == DT.GetConstant("RelicKey") then
      do
        local WorldStageManager = require("Managers.WorldStage.WorldStageManager")
        local stageData = WorldStageManager.Instance:GetCurStageData() or {}
        if not stageData.specialItemBag then
          stageData.specialItemBag = {}
        end
        table.insert(stageData.specialItemBag, {
          tid = relic.tid,
          uid = relic.uid
        })
      end
    else
      local cloneRelic = table.deepclone(relic)
      table.insert(self.relicList, cloneRelic)
    end
  end
end

function BattleRelicMgrClient:GetAllRelicDatas()
  return self.relicList
end

function BattleRelicMgrClient:OnAddNewRelic(tid)
  table.insert(self.relicList, {
    tid = tid,
    uid = os.time()
  })
  EventMgr.Instance.OnRelicDataChange:Dispatch()
  EventMgr.Instance.OnRelicAdd:Dispatch(tid)
end

function BattleRelicMgrClient:OnRemoveRelic(tid)
  for i, data in ipairs(self.relicList) do
    if tid == data.tid then
      table.remove(self.relicList, i)
      break
    end
  end
  EventMgr.Instance.OnRelicDataChange:Dispatch()
  EventMgr.Instance.OnRelicRemove:Dispatch(tid)
end

return BattleRelicMgrClient
