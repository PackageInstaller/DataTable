local this = {}
this.modType = {
  cloth = 1,
  ear = 2,
  eye = 3,
  eyebrow = 4,
  eyelash = 5,
  hair = 6,
  headdress = 7,
  mouth = 8,
  tail = 9,
  height = 11,
  skin = 12,
  sound = 13,
  tryOn = 14,
  sex = 15
}
this.animLayerType = {
  cloth = 1,
  hair = 6,
  tail = 9
}
this.notPartType = {
  [this.modType.height] = true,
  [this.modType.skin] = true
}
this.eyeType = {eyeL = 1, eyeR = 2}
this.modTypeText = {
  [1] = "ui_modStore_01",
  [2] = "ui_modStore_02",
  [3] = "ui_modStore_03",
  [4] = "ui_modStore_04",
  [5] = "ui_modStore_05",
  [6] = "ui_modStore_06",
  [7] = "ui_modStore_07",
  [8] = "ui_modStore_08",
  [11] = "ui_modStore_09",
  [12] = "ui_modStore_10",
  [13] = "ui_modStore_11",
  [14] = "ui_modStore_12",
  [15] = "ui_modStore_13"
}

function this:init()
  this.super.init(self)
  self.tempAvatarCtrl = nil
end

function this:getModData()
  return self.tempAvatarCtrl
end

function this:getModSex()
  return self:getModData().Sex
end

function this:isTempWearWardrobeId(type, avatarId)
  local partId = self:getTempAvatarWardrobe(type)
  return partId == avatarId
end

function this:getTempAvatarWardrobe(type)
  if not type then
    return -1
  end
  return self.tempAvatarCtrl and self.tempAvatarCtrl:GetWardrobeAvatarId(type) or -1
end

function this:isTempSelectColor(wardrobeType, colorIndex, colorId)
  return self:getTempAvatarColor(wardrobeType, colorIndex) == colorId
end

function this:getTempAvatarColor(wardrobeType, colorIndex)
  return self.tempAvatarCtrl and self.tempAvatarCtrl:GetColorId(wardrobeType, colorIndex)
end

function this:initTimelineCtrl()
  C_AzurTimelineMgr.GetOrCreateTimelineControl()
end

function this:destroyTimelineCtrl()
  if self.timelineAvatar then
    self.timelineAvatar = nil
  end
  C_AzurTimelineMgr.DisposeTimelineControl()
end

function this:setModTimelineAvatar(sex)
  self.timelineAvatar = AzurWorld.avatarMgr:GetDefaultAvatarData(sex):Clone()
end

function this:setModTimelineAvatarByAvatarData(avatarData)
  self.timelineAvatar = avatarData
end

function this:modShowTimeline(path, timelineAssetName, heroId, callback)
  print("setCustomAvatarData begin")
  C_AzurTimelineMgr.SetCustomAvatarData(self.timelineAvatar)
  print("asyncLoadTimelineAssets begin")
  C_AzurTimelineMgr.AsyncLoadTimelineAssets(path, timelineAssetName, nil, heroId, true, function()
  end, function()
    print("createPlayer load Capture Timeline all finished")
    local tlState = C_AzurTimelineMgr.GetTimelinePrefabState(path)
    C_AzurTimelineMgr.SetAssetsActive(true)
    tlState.gameObject.transform.position = CS.UnityEngine.Vector3(400, 0, 400)
    C_AzurTimelineMgr.TryChangNextTimelineState(timelineAssetName)
    tlState.director.extrapolationMode = CS.UnityEngine.Playables.DirectorWrapMode.Hold
    FrameScheduler.add(function()
      if callback then
        callback()
      end
    end, 10)
  end, 0)
end

return this
