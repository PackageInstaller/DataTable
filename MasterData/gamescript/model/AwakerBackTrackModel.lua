local function modelState(awakerModel)
  local state = {}
  
  state.awakerModel = awakerModel
  return state
end

local function modelView(data)
  local view = {}
  
  function view:GetBackTrackEndTime()
    do return end
    return BackTrackDataUtils.GetEndTime
  end
  
  function view:GetRewardPreview(Tag)
    return data.previewReward[Tag]
  end
  
  return view
end

local function modelAction(data)
  local action = {}
  
  function action:FixItemList(itemData, list)
    local contains = false
    for _, v in ipairs(list) do
      if v.itemTid == itemData.tid then
        v.itemCount = v.itemCount + itemData.num
        contains = true
        break
      end
    end
    if not contains then
      local item = {
        tid = itemData.tid,
        itemTid = itemData.tid,
        itemCount = itemData.num
      }
      table.insert(list, item)
    end
  end
  
  function action:SetPreviewData(serverData)
    data.previewReward = {}
    local levelList = {}
    local potencyList = {}
    local blackList = {}
    local BackType = cd.BackTrackAwakerType
    for tag, tagData in pairs(serverData) do
      for itemTid, itemData in pairs(tagData) do
        if tag ~= BackType.PotencyLevelReset then
          self:FixItemList(itemData, blackList)
        end
        if tag == BackType.Level or tag == BackType.Talent or tag == BackType.Skill or tag == BackType.Break then
          self:FixItemList(itemData, levelList)
        end
        if tag == BackType.Potency or tag == BackType.PotencyLevelReset then
          self:FixItemList(itemData, potencyList)
        end
      end
    end
    
    local function sortFunc(a, b)
      local aTid = a.tid
      local bTid = b.tid
      local aConfig = ItemDataUtils.GetItemConfig(aTid)
      local bConfig = ItemDataUtils.GetItemConfig(bTid)
      local qualitySortA = DT.ItemQuality[aConfig.Quality].Sort
      local qualitySortB = DT.ItemQuality[bConfig.Quality].Sort
      if qualitySortA == qualitySortB then
        if aTid == bTid then
          return aConfig.BaseSortID < bConfig.BaseSortID
        end
        return aTid < bTid
      end
      return qualitySortA > qualitySortB
    end
    
    local defaultOrder = CommonDefine.SortOrder.Ascend
    table.sort(levelList, function(a, b)
      do return sortFunc, a end
      return sortFunc, a, b
    end)
    table.sort(blackList, function(a, b)
      do return sortFunc, a end
      return sortFunc, a, b
    end)
    data.previewReward[CommonDefine.BackTrackAwakerType.Level] = levelList
    data.previewReward[CommonDefine.BackTrackAwakerType.Potency] = potencyList
    data.previewReward[CommonDefine.BackTrackAwakerType.Black] = blackList
  end
  
  function action:ReqPreviewAwakerBacktrackItems(callback)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "PreviewAwakerBacktrackItems", function(serverData)
      self:SetPreviewData(serverData)
      if callback then
        callback()
      end
    end, function(_, code)
      Logger.Error("[唤醒体回溯] 预览奖励失败！错误码: %s", code.code)
    end, data.awakerModel.selectAwakerId)
  end
  
  return action
end

local function onSetup(_, _)
end

do return Vue.model("AwakerBackTrackModel", modelState):views(modelView):actions(modelAction).setup, (Vue.model("AwakerBackTrackModel", modelState):views(modelView):actions(modelAction)) end
return Vue.model("AwakerBackTrackModel", modelState):views(modelView):actions(modelAction).setup, Vue.model("AwakerBackTrackModel", modelState):views(modelView):actions(modelAction), onSetup
