local this = class("timelineAssetHandle")

function this:ctor()
  self._clipMap = {}
  self._clipHandleMap = {}
  self.lastTimelineName = nil
  self._dictStringDictStringListObj = {}
  self.loadTimelineAssetFinishHandle = nil
  self._curTimelineName = nil
  self._curTimelineAssetName = nil
  self.control = nil
end

function this:dispose()
  for i, v in pairs(self._clipMap) do
    for _i, _v in pairs(v) do
      C_LuaUtility.ReleaseTimelineAsset(_v)
      v[_i] = nil
    end
    self._clipMap[i] = nil
  end
  self._clipMap = nil
  for i, v in pairs(self._clipHandleMap) do
    for _i, _v in pairs(v) do
      if _v then
        C_LuaUtility.DestroyTimelineAsset(_v)
      end
    end
  end
  self._clipHandleMap = nil
  for k, v in pairs(self._dictStringDictStringListObj) do
    for i = 0, v.Count - 1 do
      CS.Azur.Gameplay.Core.Asset.AssetManager.Instance:DestroyNewAsset(v[i])
    end
    v:Clear()
    v = nil
  end
  self._dictStringDictStringListObj = nil
  self.loadTimelineAssetFinishHandle = nil
  self._curTimelineName = nil
  self._curTimelineAssetName = nil
  self.control = nil
  self.lastTimelineName = nil
end

function this:loadTimelineAssetFinish(timelineName, timelineAssetName, timelineAsset)
  self._curTimelineName = timelineName
  self._curTimelineAssetName = timelineAssetName
  if self.loadTimelineAssetFinishHandle then
    self.loadTimelineAssetFinishHandle(timelineName, timelineAssetName, timelineAsset)
  end
end

function this:disposeTimeAsset(timelineName)
  if not self or not timelineName then
    return
  end
  if not self._clipMap or not self._clipHandleMap then
    return
  end
  local timelineTable = self._clipMap[timelineName]
  for k, v in pairs(timelineTable) do
    if v then
      C_LuaUtility.ReleaseTimelineAsset(v)
    end
  end
  table.clear(timelineTable)
  if timelineTable and next(timelineTable) == nil then
    self._clipMap[timelineName] = nil
  end
  local handleTable = self._clipHandleMap[timelineName]
  for k, v in pairs(handleTable) do
    if v then
      C_LuaUtility.DestroyTimelineAsset(v)
    end
  end
  table.clear(handleTable)
  if handleTable and next(handleTable) == nil then
    self._clipHandleMap[timelineName] = nil
  end
  
  local function startsWith(str, prefix)
    return string.sub(str, 1, #prefix) == prefix
  end
  
  local path, assetsList = next(self._dictStringDictStringListObj)
  while path do
    if startsWith(path, timelineName) then
      for i = 0, assetsList.Count - 1 do
        CS.Azur.Gameplay.Core.Asset.AssetManager.Instance:DestroyNewAsset(assetsList[i])
      end
      assetsList:Clear()
      self._dictStringDictStringListObj[path] = nil
    end
    path, assetsList = next(self._dictStringDictStringListObj, path)
  end
end

function this:loadTimelineAssetList(timelineName, timelineAssetNameList, customCallback, showTimelineAssetName)
  if timelineName == nil or timelineAssetNameList == nil then
    if customCallback then
      customCallback()
    end
    return
  end
  if timelineName ~= self.lastTimelineName then
    self:disposeTimeAsset(self.lastTimelineName)
  end
  self.lastTimelineName = timelineName
  self.tempAssetLoadingList = {}
  for key, value in pairs(timelineAssetNameList) do
    self.tempAssetLoadingList[key] = value
  end
  self.tempTargetTimelineAsset = nil
  
  local function tempLoadTimeLineAssetCout(_timelineName, timelineAssetName, _timelineAsset)
    if _timelineName == showTimelineAssetName then
      self.tempTargetTimelineAsset = _timelineAsset
    end
    if self.tempAssetLoadingList == nil then
      if customCallback then
        customCallback(_timelineName, timelineAssetName, _timelineAsset)
      else
        self:loadTimelineAssetFinish(timelineName, showTimelineAssetName, self.tempTargetTimelineAsset)
      end
      return
    end
    for k, v in pairs(self.tempAssetLoadingList) do
      if v == timelineAssetName then
        table.remove(self.tempAssetLoadingList, k)
      end
    end
    if table.isEmpty(self.tempAssetLoadingList) then
      if customCallback then
        customCallback(_timelineName, timelineAssetName, _timelineAsset)
      else
        self:loadTimelineAssetFinish(timelineName, showTimelineAssetName, self.tempTargetTimelineAsset)
      end
      self.tempAssetLoadingList = nil
      self.tempTargetTimelineAsset = nil
    end
  end
  
  for k, v in pairs(timelineAssetNameList) do
    print("================================v", v)
    self:loadOneTimeLineAsset(timelineName, v, tempLoadTimeLineAssetCout)
  end
end

function this:loadTimelineAsset(timelineName, timelineAssetName, customCallback)
  if timelineName == nil or timelineAssetName == nil then
    if customCallback then
      customCallback()
    end
    return
  end
  if timelineName ~= self.lastTimelineName then
    self:disposeTimeAsset(self.lastTimelineName)
  end
  self.lastTimelineName = timelineName
  local clipPath = self:getFilePath(timelineName, timelineAssetName)
  local tempList = CS.System.Collections.Generic.List(CS.UnityEngine.Object)()
  self._clipMap[timelineName] = self._clipMap[timelineName] or {}
  self._clipHandleMap[timelineName] = self._clipHandleMap[timelineName] or {}
  local timelineAsset = self._clipMap[timelineName][timelineAssetName]
  if timelineAsset then
    if customCallback then
      customCallback(timelineName, timelineAssetName, timelineAsset)
    else
      self:loadTimelineAssetFinish(timelineName, timelineAssetName, timelineAsset)
    end
    return
  end
  if self._clipHandleMap[timelineName][timelineAssetName] then
    C_LuaUtility.DestroyTimelineAsset(self._clipHandleMap[timelineName][timelineAssetName])
    print("timeline repeat load", timelineAssetName)
  end
  local handle
  handle = C_LuaUtility.LoadTimelineAsset(clipPath, function(_timelineAsset)
    if self.control == nil then
      return
    end
    if self._clipMap == nil then
      return
    end
    local TimelineUtility = CS.Lens.Gameplay.Tools.TimelineExtensions.TimelineUtility
    TimelineUtility.InstantiateSubAssets(_timelineAsset, {
      typeof(CS.UnityEngine.Timeline.AvatarAnimationTrack)
    }, nil, tempList)
    self._clipMap[timelineName][timelineAssetName] = _timelineAsset
    if customCallback then
      customCallback(timelineName, timelineAssetName, _timelineAsset)
    else
      self:loadTimelineAssetFinish(timelineName, timelineAssetName, _timelineAsset)
    end
    if self._dictStringDictStringListObj[clipPath] then
      self._dictStringDictStringListObj[clipPath]:AddRange(tempList)
    else
      self._dictStringDictStringListObj[clipPath] = tempList
    end
  end, C_LoadPriority.Extra)
  self._clipHandleMap[timelineName][timelineAssetName] = handle
end

function this:loadOneTimeLineAsset(timelineName, timelineAssetName, customCallback)
  local clipPath = self:getFilePath(timelineName, timelineAssetName)
  local tempList = CS.System.Collections.Generic.List(CS.UnityEngine.Object)()
  self._clipMap[timelineName] = self._clipMap[timelineName] or {}
  self._clipHandleMap[timelineName] = self._clipHandleMap[timelineName] or {}
  local timelineAsset = self._clipMap[timelineName][timelineAssetName]
  if timelineAsset then
    customCallback(timelineName, timelineAssetName, timelineAsset)
    return
  end
  local handle
  handle = C_LuaUtility.LoadTimelineAsset(clipPath, function(_timelineAsset)
    if self.control == nil then
      return
    end
    if self._clipMap == nil then
      return
    end
    local TimelineUtility = CS.Lens.Gameplay.Tools.TimelineExtensions.TimelineUtility
    TimelineUtility.InstantiateSubAssets(_timelineAsset, {
      typeof(CS.UnityEngine.Timeline.AvatarAnimationTrack)
    }, nil, tempList)
    self._clipMap[timelineName][timelineAssetName] = _timelineAsset
    customCallback(timelineName, timelineAssetName, _timelineAsset)
    if self._dictStringDictStringListObj[clipPath] then
      self._dictStringDictStringListObj[clipPath]:AddRange(tempList)
    else
      self._dictStringDictStringListObj[clipPath] = tempList
    end
  end, C_LoadPriority.Extra)
  self._clipHandleMap[timelineName][timelineAssetName] = handle
end

function this:getFilePath(timelineName, timelineAssetName)
  if timelineName and timelineAssetName then
    local path = timelineName .. "/timeline_" .. timelineAssetName .. ".playable"
    return path
  end
end

return this
