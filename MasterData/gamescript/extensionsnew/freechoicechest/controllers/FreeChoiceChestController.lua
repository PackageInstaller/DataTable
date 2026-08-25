local FreeChoiceChestController, Super = NewClass("FreeChoiceChestController", BaseController)

function FreeChoiceChestController:OnInit()
end

function FreeChoiceChestController:OnReset()
end

function FreeChoiceChestController:OpenFreeChoiceChestView(chestItemTid, confirmCallback, isPreview)
  UIManager.Instance:Reopen(Urls.FreeChoiceChestView, chestItemTid, confirmCallback, isPreview)
end

function FreeChoiceChestController:CloseFreeChoiceChestView()
  UIManager.Instance:CloseByUrl(Urls.FreeChoiceChestView)
end

function FreeChoiceChestController:RequestChooseItem(callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  local model = FreeChoiceChestDataModel.Instance
  local currSelectedItemInfo = model:GetCurrSelectedItemInfo()
  ProtoManager.Instance:ReqServer("GameRequest", "OnUseChooseItem", function(svrData)
    if callback then
      callback(svrData)
    end
  end, function()
  end, model:GetChestItemTid(), currSelectedItemInfo.tid, 1)
end

function FreeChoiceChestController:OnChooseItem(itemInfo, extraParams, confirmCallback)
  local function _CloseView()
    self:CloseFreeChoiceChestView()
  end
  
  if itemInfo.itemType == CommonDefine.ItemType.AwakerItem then
    if itemInfo.maxPotency then
      local tipsId = 20097
      local awakerTid = itemInfo.awakerTid
      local normalAwakerList = DT.GetOriginalConstant("NonLimitedAwakerList")
      if not table.contains(normalAwakerList, awakerTid) then
        tipsId = "LimitAwakerEnlightenmentOverflowTips"
      end
      Alert.Show(tipsId, nil, function()
        if confirmCallback then
          confirmCallback(extraParams, _CloseView)
          return
        end
        self:RequestChooseItem(_CloseView)
      end)
    else
      if confirmCallback then
        confirmCallback(extraParams, _CloseView)
        return
      end
      self:RequestChooseItem(_CloseView)
    end
  elseif itemInfo.itemType == CommonDefine.ItemType.Weapon then
    if confirmCallback then
      confirmCallback(extraParams, _CloseView)
      return
    end
    self:RequestChooseItem(_CloseView)
  elseif not confirmCallback then
    self:RequestChooseItem(_CloseView)
  else
    confirmCallback(extraParams, _CloseView)
  end
end

return FreeChoiceChestController
