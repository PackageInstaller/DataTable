local JumpStrBuilder = {}
local JumpManager = require("Game.Jump.JumpManager")
local getDesDic = {
  [JumpManager.eJumpTarget.fragDungeon] = function(eJumpTarget, args, oringinalStr)
    local heroname
    local heroId = args[1]
    local cfg = ConfigData.hero_data[heroId]
    if cfg == nil then
      error("can't read heroname with dungeonId" .. tostring(heroId))
      heroname = ""
    else
      heroname = LanguageUtil.GetLocaleText(cfg.name)
    end
    return string.format(oringinalStr, heroname)
  end,
  [JumpManager.eJumpTarget.resourceDungeon] = function(eJumpTarget, args, oringinalStr)
    local name
    local dungeonId = args[1]
    local cfg = ConfigData.material_dungeon[dungeonId]
    if cfg == nil then
      error("can't read dungeonCfg with dungeonId" .. tostring(dungeonId))
      name = ""
    else
      name = LanguageUtil.GetLocaleText(cfg.name)
    end
    return string.format(oringinalStr, name)
  end,
  [JumpManager.eJumpTarget.ATHDungeon] = function(eJumpTarget, args, oringinalStr)
    local name
    local dungeonId = args[1]
    local cfg = ConfigData.material_dungeon[dungeonId]
    if cfg == nil then
      error("can't read dungeonCfg with dungeonId" .. tostring(dungeonId))
      name = ""
    else
      name = LanguageUtil.GetLocaleText(cfg.name)
    end
    return string.format(oringinalStr, name)
  end,
  [JumpManager.eJumpTarget.DynShop] = function(eJumpTarget, args, oringinalStr)
    local shopName
    local shopId = args[1]
    local shopCfg = ConfigData.shop[shopId]
    if shopCfg == nil then
      error("can't read shopCfg with shopId" .. tostring(shopId))
      shopName = ""
    else
      shopName = LanguageUtil.GetLocaleText(shopCfg.name)
    end
    return string.format(oringinalStr, shopName)
  end,
  [JumpManager.eJumpTarget.ShopBase] = function(eJumpTarget, args, oringinalStr)
    local shopName
    local shopId = args[1]
    local shopCfg = ConfigData.shop[shopId]
    if shopCfg == nil then
      error("can't read shopCfg with shopId" .. tostring(shopId))
      shopName = ""
    else
      shopName = LanguageUtil.GetLocaleText(shopCfg.name)
    end
    return string.format(oringinalStr, shopName)
  end
}

function JumpStrBuilder.GetDes(eJumpTarget, args, oringinalStr)
  local func = getDesDic[eJumpTarget]
  if func ~= nil then
    return func(eJumpTarget, args, oringinalStr)
  else
    return oringinalStr
  end
end

return JumpStrBuilder
