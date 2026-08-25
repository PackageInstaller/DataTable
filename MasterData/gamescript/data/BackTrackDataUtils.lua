local BacktrackSkipClearOriginItemBpIds = DT.GetOriginalConstant("BacktrackSkipClearOriginItemBpIds") or {}
local BackTrackDataUtils = {}

function BackTrackDataUtils.UpdateBackTrack(data, noUpdateRed)
  for k, v in pairs(data) do
    DataCenter.backTrackData.data[k] = v
  end
  DataCenter.backTrackData.data.endTs = BattlePassDataUtils.GetEndTs()
  RedPointDataUtils.UpdateBackTrackResidentRed()
  if not noUpdateRed then
    return
  end
  RedPointDataUtils.UpdateBackTrackOnceRed()
end

function BackTrackDataUtils.GetEndTime()
  local bpTid = BattlePassDataUtils.GetTid()
  if not bpTid then
    return
  end
  local cfgList = BattlePassDataUtils.GetBpConfigsList()
  local curIndex = -1
  for i = 1, #cfgList do
    if cfgList[i].ID == bpTid then
      curIndex = i
      break
    end
  end
  if -1 == curIndex then
    return
  end
  for i = curIndex, #cfgList do
    local cfg = cfgList[i]
    if not table.contains(BacktrackSkipClearOriginItemBpIds, cfg.ID) then
      return cfg.CloseDate
    end
  end
  return
end

function BackTrackDataUtils.GetTidHasBackTrack(tid)
  if not tid then
    return false
  end
  local saveSubKey = BackTrackDataUtils.GetBackTrackSaveSubKey(tid)
  local backTrackSave = ClientDataUtils.GetData(cd.ClientDataMainKey.BackTrack, saveSubKey, 0)
  return 0 ~= backTrackSave
end

function BackTrackDataUtils.SetTidHasBackTrack(tid)
  local saveSubKey = BackTrackDataUtils.GetBackTrackSaveSubKey(tid)
  ClientDataUtils.SetData(cd.ClientDataMainKey.BackTrack, saveSubKey, 1)
end

function BackTrackDataUtils.GetBackTrackSaveSubKey(tid)
  if not tid then
    return nil
  end
  local endTime = BackTrackDataUtils.GetEndTime()
  return tid .. "_" .. endTime
end

function BackTrackDataUtils.IsAwakerOpen(awakerId)
  local bOpen = BackTrackDataUtils.__IsAwakerOpen(awakerId)
  if not bOpen then
    local changeAwakerId = AwakerDataUtils.GetChangerForm(awakerId)
    if 0 ~= changeAwakerId then
      do return BackTrackDataUtils.__IsAwakerOpen end
      return BackTrackDataUtils.__IsAwakerOpen, awakerId
    end
  end
  return bOpen
end

function BackTrackDataUtils.__IsAwakerOpen(awakerId)
  local openType = BackTrackDataUtils.GetAwakerOpenType(awakerId)
  return openType ~= CommonDefine.BackTrackOpenType.NotOpen
end

function BackTrackDataUtils.GetAwakerOpenType(awakerId)
  local awakersMap = DataCenter.backTrackData.data.openAwakers
  local awakerOpenData = awakersMap and awakersMap[awakerId]
  return awakerOpenData and awakerOpenData.open or CommonDefine.BackTrackOpenType.NotOpen
end

function BackTrackDataUtils.CheckUseStateBit(awakerId, checkState)
  local awakerMap = DataCenter.backTrackData.data.openAwakers
  local awakerOpenData = awakerMap and awakerMap[awakerId]
  local useState = awakerOpenData and awakerOpenData.useStatus or 0
  return 0 ~= useState & 1 << checkState
end

function BackTrackDataUtils.SetUseStateBit(awakerId, checkState)
  local awakerMap = DataCenter.backTrackData.data.openAwakers
  local awakerOpenData = awakerMap and awakerMap[awakerId]
  local useState = awakerOpenData and awakerOpenData.useStatus
  if not useState then
    return
  end
  useState = useState | 1 << checkState
  awakerOpenData.useStatus = useState
end

function BackTrackDataUtils.IsUseLevelBack(awakerId)
  if not BackTrackDataUtils.IsAwakerOpen(awakerId) then
    return false
  end
  do return BackTrackDataUtils.CheckUseStateBit, awakerId end
  return BackTrackDataUtils.CheckUseStateBit, awakerId, CommonDefine.BackTrackUseStateBit.UsedBackLevel
end

function BackTrackDataUtils.IsUsePotencyBack(awakerId)
  if not BackTrackDataUtils.IsAwakerOpen(awakerId) then
    return false
  end
  do return BackTrackDataUtils.CheckUseStateBit, awakerId end
  return BackTrackDataUtils.CheckUseStateBit, awakerId, CommonDefine.BackTrackUseStateBit.UsedBackPotency
end

function BackTrackDataUtils.IsItemOpen(awakerId)
  local awakersMap = DataCenter.backTrackData.data.openAwakers
  local awakerOpenData = awakersMap and awakersMap[awakerId]
  return awakerOpenData and awakerOpenData.open == CommonDefine.BackTrackOpenType.ItemOpen
end

function BackTrackDataUtils.IsAwakerBacked(awakerId)
  local data = DataCenter.backTrackData.data
  local awakersMap = data.openAwakers
  if not awakersMap then
    return false
  end
  local awakerOpenData = awakersMap[awakerId]
  if awakerOpenData and awakerOpenData.open then
    return awakerOpenData.open > CommonDefine.BackTrackOpenType.GmOpen
  end
end

function BackTrackDataUtils.IsFreeBackAwaker(awakerId)
  local freeBackAwakerList = BackTrackDataUtils.GetFreeBackAwakerList()
  do return table.contains, freeBackAwakerList end
  return table.contains, freeBackAwakerList, awakerId
end

function BackTrackDataUtils.IsNormalAwaker(awakerId)
  local normalAwakerList = DT.GetOriginalConstant("BacktrackItemAwakers")
  do return table.contains, normalAwakerList end
  return table.contains, normalAwakerList, awakerId
end

function BackTrackDataUtils.IsUniqueAwaker(awakerId)
  return not BackTrackDataUtils.IsNormalAwaker(awakerId)
end

function BackTrackDataUtils.IsSystemAwaker(awakerId)
  local noGiveBackAwakerList = DT.GetOriginalConstant("NoGiveBackAwakers")
  do return table.contains, noGiveBackAwakerList end
  return table.contains, noGiveBackAwakerList, awakerId
end

function BackTrackDataUtils.IsLimitAwaker(awakerId)
  return not BackTrackDataUtils.IsNormalAwaker(awakerId) and not BackTrackDataUtils.IsSystemAwaker(awakerId)
end

function BackTrackDataUtils.GetFreeBackAwakerList()
  local bgConfig = BattlePassDataUtils.GetBPConfig()
  if not bgConfig then
    return {}
  end
  return bgConfig.PeriodFreeRevertAwaker or {}
end

function BackTrackDataUtils.GetFreeBackWeaponList()
  local bgConfig = BattlePassDataUtils.GetBPConfig()
  if not bgConfig then
    return {}
  end
  return bgConfig.PeriodFreeRevertWeapon or {}
end

function BackTrackDataUtils.IsWeaponOpen(weaponId, weaponUid)
  local data = DataCenter.backTrackData.data
  if (BattlePassDataUtils.GetEndTs() or 0) <= TimeUtils.GetServerTime() then
    return false
  end
  local weaponsMap = data.openWeapons
  if not weaponsMap then
    return false
  end
  local weaponOpenData = weaponsMap[weaponUid]
  if not weaponOpenData or not weaponOpenData.open then
    return false
  end
  return weaponOpenData.open > 0
end

function BackTrackDataUtils.IsEnableTrainBack(awakerId)
  local openType = BackTrackDataUtils.GetAwakerOpenType(awakerId)
  if openType == CommonDefine.BackTrackOpenType.NotOpen then
    return false
  end
  if BackTrackDataUtils.IsUseLevelBack(awakerId) then
    local tipsCfg = DT.TipsType[20167]
    return false, LT.Text(tipsCfg.Desc)
  end
  if TaskDataUtils.AwakerInTask(awakerId) then
    return false, LT.Text(DT.TipsType[20126].Desc)
  end
  return true
end

function BackTrackDataUtils.IsEnableQilingBack(awakerId)
  local openType = BackTrackDataUtils.GetAwakerOpenType(awakerId)
  if openType == CommonDefine.BackTrackOpenType.NotOpen then
    return false
  end
  if BackTrackDataUtils.IsUsePotencyBack(awakerId) then
    local tipsCfg = DT.TipsType[20168]
    return false, LT.Text(tipsCfg.Desc)
  end
  if BackTrackDataUtils.IsItemOpen(awakerId) and BackTrackDataUtils.IsUniqueAwaker(awakerId) then
    local tipsCfg = DT.TipsType[20166]
    return false, LT.Text(tipsCfg.Desc)
  end
  if TaskDataUtils.AwakerInTask(awakerId) then
    return false, LT.Text(DT.TipsType[20126].Desc)
  end
  local awaker = AwakerDataUtils.GetAwakerData(awakerId)
  local potencyLevel = awaker and awaker.potencyLevel or 0
  local chipCount = AwakerDataUtils.GetChipCount(awakerId)
  if potencyLevel + chipCount <= 0 then
    return false, LT.Text(DT.TipsType[201151].Desc)
  end
  return true
end

function BackTrackDataUtils.IsEnableHeichiBack(awakerId)
  local openType = BackTrackDataUtils.GetAwakerOpenType(awakerId)
  if openType == CommonDefine.BackTrackOpenType.NotOpen then
    return false
  end
  if BackTrackDataUtils.IsUseLevelBack(awakerId) or BackTrackDataUtils.IsUsePotencyBack(awakerId) then
    return false, LT.Text("BacktrackTips2")
  end
  if BackTrackDataUtils.IsItemOpen(awakerId) and BackTrackDataUtils.IsUniqueAwaker(awakerId) then
    local tipsCfg = DT.TipsType[20120]
    return false, LT.Text(tipsCfg.Desc)
  end
  if BackTrackDataUtils.IsSystemAwaker(awakerId) then
    local tipsCfg = DT.TipsType[20120]
    return false, LT.Text(tipsCfg.Desc)
  end
  if TaskDataUtils.AwakerInTask(awakerId) then
    return false, LT.Text(DT.TipsType[20126].Desc)
  end
  return true
end

return BackTrackDataUtils
