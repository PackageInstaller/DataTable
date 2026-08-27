local CommonResHelper = {}
local AtlasResName = {
  "CommonIcon",
  "CompanyCareer",
  "ExplorationIcon",
  "SkillIcon",
  "BaseItemQuality",
  "HeroHeadIcon"
}

function CommonResHelper:Init()
  self._resloader = CS.ResLoader.Create()
  self._commonAtlas = {}
  self._baseItemFx = {}
end

function CommonResHelper:LoadCommonAtlas(cs_DownloadWindow, progress)
  local atlasCount = #AtlasResName
  local atlasProgress = progress / atlasCount
  local maxProgress = cs_DownloadWindow:GetCurrentProgress() + progress
  for index, resName in ipairs(AtlasResName) do
    local atlasWait = self._resloader:LoadABAssetAsyncAwait(PathConsts:GetSpriteAtlasPath(resName))
    coroutine.yield(atlasWait)
    self._commonAtlas[index - 1] = atlasWait.Result
    cs_DownloadWindow:AddProgress(atlasProgress, progress)
  end
  self.atlasCount = table.count(self._commonAtlas)
end

function CommonResHelper:GetSprite(spriteName, atlasType)
  if atlasType == nil or type(atlasType) ~= "number" then
    atlasType = 0
  end
  local atlas = self._commonAtlas[atlasType]
  if atlasType >= self.atlasCount or IsNull(atlas) then
    return nil
  end
  local sp = AtlasUtil.GetResldSprite(atlas, spriteName)
  return sp
end

function CommonResHelper:GetSpriteByItemConfig(itemCfg, isSmall)
  if itemCfg == nil then
    return nil
  end
  if itemCfg.type == eItemType.Avatar or itemCfg.type == eItemType.Skin or itemCfg.type == eItemType.AvatarFrame or itemCfg.action_type == eItemActionType.HeroCardFrag or itemCfg.action_type == eItemActionType.HeroCard then
    return CRH:GetSprite(itemCfg.icon, CommonAtlasType.HeroHeadIcon)
  else
    local icon = isSmall and itemCfg.small_icon or itemCfg.icon
    return CRH:GetSprite(icon)
  end
end

function CommonResHelper:GetSpriteByItemId(itemId, isSmall)
  if (itemId or 0) == 0 then
    return nil
  end
  return self:GetSpriteByItemConfig(ConfigData.item[itemId], isSmall)
end

function CommonResHelper:GetHeroSkinSprite(heroId, skinId)
  local resName
  local id = skinId or 0
  if id ~= 0 then
    local skinCfg = ConfigData.skin[id]
    if skinCfg ~= nil and not string.IsNullOrEmpty(skinCfg.src_id_icon) then
      return CRH:GetSprite(skinCfg.src_id_icon, CommonAtlasType.HeroHeadIcon)
    end
  end
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg ~= nil and heroCfg.fragment ~= nil then
    local itemCfg = ConfigData.item[heroCfg.fragment]
    if itemCfg ~= nil then
      return CRH:GetSprite(itemCfg.icon, CommonAtlasType.HeroHeadIcon)
    end
  end
  return nil
end

function CommonResHelper:LoadBaseItemFx()
  local path = ItemEffPatch.greetLoop
  self._resloader:LoadABAssetAsync(path, function(prefab)
    self._baseItemFx.greetLoop = prefab
  end)
end

function CommonResHelper:GetBaseItemFx()
  return self._baseItemFx
end

function CommonResHelper:GetDefaultKeySprite(itemID, isSmall)
  if isSmall == nil then
    isSmall = true
  end
  local ticketID = itemID or ConstGlobalItem.SKey
  local costItemCfg = ConfigData.item[ticketID]
  return CRH:GetSpriteByItemConfig(costItemCfg, true)
end

return CommonResHelper
