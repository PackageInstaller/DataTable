local this = class("favorabilityManager")

function this:getFavorabilityAttrs(heroData)
  local heroFavorabilityInfoTpl = L_GameTpl:getHeroFavorabilityInfoTpl()
  local conifgId = L_HeroStore:getHeroConfigId(heroData)
  local configs = heroFavorabilityInfoTpl:getChildren(conifgId)
  if not configs then
    return {}
  end
  local favorLevel = L_HeroStore:getHeroFavorAbilityLevel(heroData)
  local attDic = {}
  for _, cfg in pairs(configs) do
    if favorLevel >= cfg.favorabilityLevel then
      local attrs = heroFavorabilityInfoTpl:getLevelUpAttribute(cfg)
      for i, attr in pairs(attrs) do
        if not attDic[i] then
          attDic[i] = 0
        end
        attDic[i] = attDic[i] + attr
      end
    end
  end
  return attDic
end

return this
