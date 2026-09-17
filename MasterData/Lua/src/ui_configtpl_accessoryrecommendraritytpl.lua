local this = class("accessoryRecommendRarityTpl")
local _accessoryLevelTpl = L_GameTpl:getAccessoryLevelTpl()
local _accessorySubParameterTpl = L_GameTpl:getAccessorySubParameterTpl()

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRarityListByPlayLv(playLv)
  for key, value in pairs(self.data) do
    if playLv >= value.player_lv[1] and playLv <= value.player_lv[2] then
      return value.recommend_rarity
    end
  end
  return {}
end

return this
