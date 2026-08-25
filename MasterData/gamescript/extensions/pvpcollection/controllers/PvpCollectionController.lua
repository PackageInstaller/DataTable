local PvpCollectionController = NewClass("PvpCollectionController", BaseController)

function PvpCollectionController:OnInit()
  self:RegisterNewAcquiredItemEvent()
end

function PvpCollectionController:OnReset()
end

function PvpCollectionController:OpenPvpCollectionMainView(viewData)
  UIManager.Instance:Reopen(Urls.PvpCollectionMainView, viewData)
end

function PvpCollectionController:ReqCollectionRanks(rankType, collectionTid, startIdx, endIdx, onSuccess, onFail)
  ProtoManager.Instance:ReqServer("GameRequest", "OnQueryRank", function(data)
    RankModel.Instance:UpdateBySvrData(rankType, collectionTid, data, startIdx, endIdx)
    if onSuccess then
      onSuccess()
    end
  end, function()
    if onFail then
      onFail()
    end
  end, rankType, startIdx, endIdx, collectionTid)
end

function PvpCollectionController:RegisterNewAcquiredItemEvent()
  EventMgr.Instance.NewAcquiredItemEvent:RemoveEvent(System.fn(self, self._OnNewAcquiredItem))
  EventMgr.Instance.NewAcquiredItemEvent:RegisterEvent(System.fn(self, self._OnNewAcquiredItem))
end

function PvpCollectionController:_OnNewAcquiredItem(itemData, oldNum, reason)
  PVPCollectionDataUtils._OnAddItemForPvpCollection(itemData)
end

return PvpCollectionController
