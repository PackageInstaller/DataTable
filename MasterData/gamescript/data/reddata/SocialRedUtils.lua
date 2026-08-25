local RedType = RedTypeDefine.RedType
local SocialSubType = RedTypeDefine.SocialSubType
local SocialRedUtils = {}

function SocialRedUtils.Init(forceInit)
  if not DataCenter.redPointData[RedType.Social] or forceInit then
    DataCenter.redPointData[RedType.Social] = {}
  end
end

function SocialRedUtils.GetSocialBirtyRedCacheKey()
  return CommonDefine.LocalSaveKey.RedPoint .. RedType.Social .. "_" .. SocialSubType.Birthday
end

function SocialRedUtils.UpdateSocialBirthRedCache(redValue)
  local key = SocialRedUtils.GetSocialBirtyRedCacheKey()
  MobileFileDataManager.Instance:SetPlayerFileValue(key, redValue)
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
  DataCenter.redPointData[RedType.Social][SocialSubType.Birthday].red = redValue
end

function SocialRedUtils.UpdateSocialRed(data)
  if not data then
    return
  end
  SocialRedUtils.UpdateBirthRed(data)
  SocialRedUtils.UpdateAvatarRed()
end

function SocialRedUtils.UpdateBirthRed(data)
  local key = SocialRedUtils.GetSocialBirtyRedCacheKey()
  local birthRed = MobileFileDataManager.Instance:GetPlayerFileValue(key)
  if data.facade then
    local birthday = data.facade.birthday
    if nil == birthRed and (not birthday or "" == birthday) then
      birthRed = 1
    end
  end
  local SocialRedData = DataCenter.redPointData[RedType.Social]
  if not SocialRedData[SocialSubType.Birthday] then
    SocialRedData[SocialSubType.Birthday] = {}
  end
  SocialRedData[SocialSubType.Birthday].red = birthRed
end

function SocialRedUtils.UpdateAvatarRed()
  if not DataCenter.redPointData or not DataCenter.redPointData[RedPointDataUtils.RedType.Item] then
    return
  end
  local itemRedData = DataCenter.redPointData[RedPointDataUtils.RedType.Item]
  if itemRedData then
    for uid, redData in pairs(itemRedData) do
      local itemData = ItemDataUtils.GetItemByUid(uid)
      if not itemData then
      else
        local subType = ItemDataUtils.GetItemConfigByField("SubType", itemData.tid)
        if not subType then
        else
          if subType == CommonDefine.ItemSubType.PlayerAvatar then
            SocialRedUtils._UpdateAvatarRed(SocialSubType.Avatar, redData, uid)
          end
          if subType == CommonDefine.ItemSubType.AvatarFrame then
            SocialRedUtils._UpdateAvatarRed(SocialSubType.AvatarFrame, redData, uid)
          end
        end
      end
    end
  end
end

function SocialRedUtils._UpdateAvatarRed(socialSubType, redData, uid)
  if not DataCenter.redPointData[RedType.Social][socialSubType] then
    DataCenter.redPointData[RedType.Social][socialSubType] = {}
  end
  if not DataCenter.redPointData[RedType.Social][socialSubType][uid] then
    DataCenter.redPointData[RedType.Social][socialSubType][uid] = {}
  end
  for k, v in pairs(redData) do
    DataCenter.redPointData[RedType.Social][socialSubType][uid][k] = v
  end
end

function SocialRedUtils.UpdateAssistAwardRed(data)
  local SocialRedData = DataCenter.redPointData[RedType.Social]
  if not SocialRedData[SocialSubType.AssistReward] then
    SocialRedData[SocialSubType.AssistReward] = {}
  end
  local hasGainTimes = data.gainAssistRewardTime or 0
  local CanGainTimes = data.assistRewardTimes or 0
  local assistRewardRed = hasGainTimes < CanGainTimes and 1 or 0
  SocialRedData[SocialSubType.AssistReward].red = assistRewardRed
end

function SocialRedUtils.RemoveSocialRed(subType, subFields)
  if not subType then
    return
  end
  if table.contains({
    SocialSubType.Avatar,
    SocialSubType.AvatarFrame
  }, subType) then
    local uid = subFields and subFields[1]
    if uid then
      RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Item, RedPointDataUtils.RedAttrType.IsNew, uid)
    end
  elseif subType == SocialSubType.NewGoodRecord then
    RedPointDataUtils.ReqRemoveData(RedType.NewGoodRecord, RedPointDataUtils.RedAttrType.IsNew)
    SocialDataUtils.ReqClearNewGood()
    return
  elseif subType == SocialSubType.AssistReward then
    RedPointDataUtils.ReqRemoveData(SocialSubType.AssistReward, RedPointDataUtils.RedAttrType.Red)
    return
  elseif subType == SocialSubType.NewFans then
    RedPointDataUtils.ReqRemoveData(SocialSubType.NewFans, RedPointDataUtils.RedAttrType.Red)
  end
  local SocialData = DataCenter.redPointData[RedType.Social]
  if not SocialData or not SocialData[subType] then
    return
  end
  if table.contains({
    SocialSubType.Avatar,
    SocialSubType.AvatarFrame
  }, subType) then
    local uid = subFields and subFields[1]
    if uid and SocialData[subType][uid] then
      SocialData[subType][uid][RedPointDataUtils.RedAttrType.IsNew] = 0
    end
  elseif subType == SocialSubType.Birthday then
    local key = SocialRedUtils.GetSocialBirtyRedCacheKey()
    MobileFileDataManager.Instance:SetPlayerFileValue(key, 0)
    MobileFileDataManager.Instance:OnSavePlayerFileInfo()
    SocialData[SocialSubType.Birthday].red = 0
  end
end

function SocialRedUtils.GetSocialRed(args)
  if args and args[1] and (args[1] == SocialSubType.NewGoodRecord or args[1] == SocialSubType.AssistReward or args[1] == SocialSubType.NewFans) then
    local redType = table.remove(args, 1)
    do return RedPointDataUtils.GetRedPointState, redType end
    return RedPointDataUtils.GetRedPointState, redType, args
  end
  do return RedPointDataUtils.GetRedPointState, RedType.Social end
  return RedPointDataUtils.GetRedPointState, RedType.Social, args, args
end

return SocialRedUtils
