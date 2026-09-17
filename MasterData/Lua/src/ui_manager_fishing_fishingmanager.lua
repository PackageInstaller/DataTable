local this = class("fishingManager")
table.merge(this, require("ui.manager.fishing.fishingManager_gamePlay"))
local _fishTpl = L_GameTpl:getFishTpl()
local _fishPondTpl = L_GameTpl:getFishPondTpl()
local _fishGroupTpl = L_GameTpl:getFishGroupTpl()
local _fishEventTpl = L_GameTpl:getFishEventTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this:initialize()
  self.onSvrSceneLeaveHandle = self.onSvrSceneLeaveHandle or L_CommonUtil.handle(self.onSvrSceneLeave, self)
  C_WorldEvent.instance:Listen(C_EWorldEvent.OnSvrSceneLeave, self.onSvrSceneLeaveHandle)
end

function this:dispose()
  if self.onSvrSceneLeaveHandle ~= nil then
    C_WorldEvent.instance:Cancel(C_EWorldEvent.OnSvrSceneLeave, self.onSvrSceneLeaveHandle)
    self.onSvrSceneLeaveHandle = nil
  end
end

function this:onSvrSceneLeave(_, varList)
  local playerId = varList and varList:GetInt(1)
  if playerId and playerId == L_PlayerStore:getPlayerId() and L_UI:checkPageOpen("pageFishing") then
    L_FishingManager:reqFishing(false, self._pointId)
    L_UI:close("pageFishing")
  end
end

function this:reqFinishFish(success, callback)
  L_FishingStore:req_CSProtoFishFinish(success, function(errCode)
    if errCode == L_Const.errorCode.ErrCodeSucc then
      local function endDo()
        local fishFinish = L_FishingStore:getFishFinish()
        
        if math.isEmpty(fishFinish:getEventId()) and math.isEmpty(fishFinish:getFishId()) then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("info_fish_fishrun"))
        elseif not math.isEmpty(fishFinish:getEventId()) then
          local tpl = _fishEventTpl:getTplById(fishFinish:getEventId())
          local type = _fishEventTpl:getType(tpl)
          if type == L_FishingConst.FishingEventType.Egg then
            L_UI:open("pageGetPetEgg", {
              configId = fishFinish:getRewards()[1].itemid
            })
          else
            L_UI:open("pageFishingEvent")
          end
        elseif not math.isEmpty(fishFinish:getFishId()) then
          L_UI:open("pageShowFish")
        end
      end
      
      if success then
        self:resetEffectRoot()
        self:setFishingSuccessTimeline(endDo, callback)
      else
        endDo()
        if callback then
          callback()
        end
        self:resetRod()
      end
    else
      if callback then
        callback()
      end
      self:resetRod()
    end
  end)
end

function this:checkFishing(pointId)
  if math.isEmpty(L_FishingStore:getCurRodId()) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("info_fish_nochooserod"))
    return false
  end
  if math.isEmpty(L_FishingStore:getCurBaitId()) or not math.isEmpty(L_FishingStore:getCurBaitId()) and C_BagMgr:getItemNumByItemId(L_FishingStore:getCurBaitId()) <= 0 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("info_fish_nochoosebait"))
    return false
  end
  if 0 >= self:getFishPointFishCountSum(pointId) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("info_fish_nofish"))
    return false
  end
  return true
end

function this:checkBait(pointId)
  local tpl_pond = _fishPondTpl:getTplById(pointId)
  local groupId = _fishPondTpl:getFishGroup(tpl_pond)
  local fish = _fishGroupTpl:getGroupFish(groupId)
  local baitDic = {}
  for i, v in pairs(fish) do
    local item = L_ItemManager:parseCommonItem(i)
    local baitList = _fishTpl:getBait(_fishTpl:getTplById(item.subId))
    for i1, v1 in pairs(baitList) do
      baitDic[v1] = true
    end
  end
  if baitDic[L_FishingStore:getCurBaitId()] == nil then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("info_fish_notrightbait"))
    return false
  end
  return true
end

function this:replaceBait(fishPondId)
  local rodList = _commonItemTpl:getTypeGroup(L_BagConst.bagItemType.fishingBait)
  local cellItemList = {}
  for i, v in pairs(rodList) do
    if C_BagMgr:getItemNumByItemId(_commonItemTpl:getId(v)) > 0 then
      table.insert(cellItemList, {
        guid = _commonItemTpl:getId(v),
        type = _commonItemTpl:getBagType(v),
        fishPondId = fishPondId
      })
    end
  end
  if table.isEmpty(cellItemList) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("info_fish_nobait"))
  else
    table.sort(cellItemList, function(a, b)
      local isCurSelectA = a.guid == L_FishingStore:getCurBaitId() and 1 or 0
      local isCurSelectB = b.guid == L_FishingStore:getCurBaitId() and 1 or 0
      if isCurSelectA == isCurSelectB then
        local tplDataA = L_ItemTplManager:getCommonItem(a.guid)
        local tplDataB = L_ItemTplManager:getCommonItem(b.guid)
        local qualityA = tplDataA.quality
        local qualityB = tplDataB.quality
        if qualityA == qualityB then
          return a.guid < b.guid
        else
          return qualityA > qualityB
        end
      else
        return isCurSelectA > isCurSelectB
      end
    end)
    local data = {
      txtTitle = L_WordsTpl:getValue("notice_fishing_choose"),
      itemList = cellItemList,
      defaultSelectId = L_FishingStore:getCurBaitId(),
      callback = function(selectId)
        local reqData = {baitId = selectId}
        L_FishingStore:req_CSProtoFishSetRod(reqData)
      end
    }
    L_UI:open("pageSelectFishingGear", data)
  end
end

function this:replaceRod(fishPondId)
  local rodList = _commonItemTpl:getTypeGroup(L_BagConst.bagItemType.fishingRod)
  local cellItemList = {}
  for i, v in pairs(rodList) do
    if C_BagMgr:getItemNumByItemId(_commonItemTpl:getId(v)) > 0 then
      table.insert(cellItemList, {
        guid = _commonItemTpl:getId(v),
        type = _commonItemTpl:getBagType(v),
        fishPondId = fishPondId
      })
    end
  end
  if table.isEmpty(cellItemList) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("info_fish_norod"))
  else
    table.sort(cellItemList, function(a, b)
      local isCurSelectA = a.guid == L_FishingStore:getCurRodId() and 1 or 0
      local isCurSelectB = b.guid == L_FishingStore:getCurRodId() and 1 or 0
      if isCurSelectA == isCurSelectB then
        local tplDataA = L_ItemTplManager:getCommonItem(a.guid)
        local tplDataB = L_ItemTplManager:getCommonItem(b.guid)
        local qualityA = tplDataA.quality
        local qualityB = tplDataB.quality
        if qualityA == qualityB then
          return a.guid < b.guid
        else
          return qualityA > qualityB
        end
      else
        return isCurSelectA > isCurSelectB
      end
    end)
    local data = {
      txtTitle = L_WordsTpl:getValue("notice_fishing_choose"),
      itemList = cellItemList,
      defaultSelectId = L_FishingStore:getCurRodId(),
      callback = function(selectId)
        local reqData = {rodId = selectId}
        L_FishingStore:req_CSProtoFishSetRod(reqData)
      end
    }
    L_UI:open("pageSelectFishingGear", data)
  end
end

function this:getFishPointFishCountSum(pondId)
  local serverData = L_FishingStore:getFishPoint(pondId) or {}
  local tpl_pond = _fishPondTpl:getTplById(pondId)
  local maxCount = _fishPondTpl:getFishGroupTime(tpl_pond)
  if not table.isEmpty(serverData) and L_TimeUtil.isSameDay(serverData.refresh_time, L_TimeUtil.getServerTime()) then
    return maxCount - serverData.count
  else
    return maxCount
  end
end

return this
