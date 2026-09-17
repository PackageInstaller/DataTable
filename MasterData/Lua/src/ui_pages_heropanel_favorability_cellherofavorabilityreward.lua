local module = class("cellHeroFavorabilityReward", G_UIModuleBase)

function module.bind()
  return {
    rewardDescText = "",
    lockedText = "",
    rewardDescTextActive = true,
    lockedTextActive = true
  }
end

function module.methods()
end

return module
