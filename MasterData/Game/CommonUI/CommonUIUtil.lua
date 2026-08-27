local CommonUIUtil = {}

function CommonUIUtil.CreateHeroSkinTags(skinCfg, tagPool)
  if skinCfg == nil then
    return 0, false
  end
  local live2dLevel = PlayerDataCenter.skinData:GetSkinLive2dLevel(skinCfg.id)
  local haveModel = not string.IsNullOrEmpty(skinCfg.src_id_model)
  if haveModel then
    local item = tagPool:GetOne(true)
    item:InitSkinTag(0)
  end
  if 0 < live2dLevel then
    local item = tagPool:GetOne(true)
    item:InitSkinTagLive2dLevel(live2dLevel)
  end
  if skinCfg.has_skill_movie then
    local item = tagPool:GetOne(true)
    item:InitSkinTag(3)
  end
  if skinCfg.has_voice then
    local item = tagPool:GetOne(true)
    item:InitSkinTag(4)
  end
  return live2dLevel, haveModel
end

function CommonUIUtil.CreateFntThemeTags(themeItem, tagPool)
  if themeItem.only_big then
    local item = tagPool:GetOne(true)
    item:SetIndex(1)
  end
end

function CommonUIUtil.SetCommonItemRewardAudioId(audioId)
  CommonUIUtil.CommonItemRewardAudioId = audioId
end

function CommonUIUtil.GetCommonItemRewardAudioId()
  return CommonUIUtil.CommonItemRewardAudioId
end

return CommonUIUtil
