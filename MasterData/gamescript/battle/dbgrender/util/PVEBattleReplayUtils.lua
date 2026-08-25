local PVEBattleReplayUtils = {}

function PVEBattleReplayUtils.PlayReplay(battleUuid, watchUid, callback)
  UIManager.Instance:Reopen(Urls.PVEReplayBattlePanel, battleUuid, watchUid, callback)
end

function PVEBattleReplayUtils.CheckReplayForbidTips()
  if bg.isReplay then
    Alert.Show("PVEReplayUnableOperateTips")
    return true
  end
end

function PVEBattleReplayUtils.GetShareContent(recordData, getShareContentCallback)
  CopyRecordsController.Instance:ReqQueryRecordDetail(recordData.stageTid, recordData.wid, function(detailData)
    print("-----------------get share content from detail", table.tostring(detailData, 4))
    detailData.wid = recordData.wid
    local shareCode = PVEBattleReplayUtils._GetShareContentFromDetail(detailData)
    if getShareContentCallback then
      getShareContentCallback(shareCode)
    end
  end)
end

function PVEBattleReplayUtils._GetShareContentFromDetail(detailData)
  local shareCode = LT.Text("PvEReplayCode")
  local replaceMap = {}
  local replayType = CommonDefine.ReplayType.PVE
  replaceMap[0] = PVPBattleReplayUtils.GetPlayCode(replayType, detailData.battleUuid, 0)
  local facade = CopyRecordsModel.Instance:GetRecordFacade(detailData.playerId)
  if facade then
    replaceMap[1] = facade.name
  elseif detailData.playerId == PlayerDataUtils.GetPlayerUid() then
    replaceMap[1] = PlayerDataUtils.GetName()
  else
    replaceMap[1] = ""
  end
  replaceMap[1] = string.gsub(replaceMap[1], "%%player%%", "")
  replaceMap[2] = detailData.playerId
  replaceMap[3] = CopyDataUtils.GetStageName(detailData.stageTid)
  local teamData = detailData.teamData
  local items = teamData.items or {}
  local assitItems = detailData.assistData and detailData.assistData.items or {}
  local awakers = teamData.awakers
  local awakerIndex = 4
  local awakerInfoCount = 3
  for i = 1, 4 do
    local awaker = awakers[i]
    local tid = awaker.tid
    local startIndex = awakerIndex + (i - 1) * awakerInfoCount
    if tid and AwakerDataUtils.GetAwakerConfig(tid) then
      replaceMap[startIndex] = AwakerDataUtils.GetAwakerName(tid)
    end
    for weaponIndex = 1, 2 do
      local weaponInfo = awaker.weaponSlots[weaponIndex]
      local weaponReplaceIndex = startIndex + weaponIndex
      local weaponUid = weaponInfo and weaponInfo.weaponUid or 0
      local weaponItemInfo = items[weaponUid] or assitItems[weaponUid]
      if weaponItemInfo then
        replaceMap[weaponReplaceIndex] = ItemDataUtils.GetItemName(weaponItemInfo.tid)
      else
        replaceMap[weaponReplaceIndex] = "-"
      end
    end
    local trinketUids = awaker.trinket and awaker.trinket.trinkets
    trinketUids = trinketUids or awaker.trinkets or {}
    trinketUids = trinketUids or {}
    local trinketDatas = {}
    for j = 1, CommonDefine.MaxEquipTrinketsNum do
      local uid = trinketUids[j] or 0
      local trinket = items[uid] or assitItems[uid]
      if trinket then
        trinketDatas[j] = trinket
      end
    end
    local suitList = AwakerTrinketDataUtils.GetActiveSuitEffectDescList(trinketDatas)
    local mergeSuitName = ""
    for j = 1, 2 do
      local suitData = suitList and suitList[j]
      local suitName = suitData and suitData.suitName
      if suitName then
        if "" == mergeSuitName then
          mergeSuitName = suitName
        else
          mergeSuitName = mergeSuitName .. "、" .. suitName
        end
      end
    end
    replaceMap[17 + i - 1] = mergeSuitName
  end
  local keeperSkill = teamData.keeperSkill
  replaceMap[16] = ItemDataUtils.GetItemName(keeperSkill)
  for k, v in pairs(replaceMap) do
    shareCode = shareCode:replace(string.format("{%s}", k), v)
  end
  return shareCode
end

function PVEBattleReplayUtils.GetReplayInfoFromCode(shareCode)
  do return PVPBattleReplayUtils.GetReplayInfoFromCode end
  return PVPBattleReplayUtils.GetReplayInfoFromCode, shareCode
end

return PVEBattleReplayUtils
