local sdkInterface = require("sdk.SDKInterface")
g_protocolHanders = {}
g_protocolHanders[actionCodes.Role_loginRpc] = function(msg)
  if msg.result ~= "SUCCESS" then
    return
  end
  local newLogin = false
  if not game.role then
    game.role = require("app.models.Role"):create(msg.role)
    newLogin = true
  end
  game:setServerTime(msg.serverTime)
  for heroId, heroInfo in pairs(msg.heros or {}) do
    game.role.heros[heroInfo.id] = require("app.models.Hero"):create(heroInfo)
  end
  for equip, equipInfo in pairs(msg.equips or {}) do
    game.role.equips[equipInfo.id] = require("app.models.Equip"):create(equipInfo)
  end
  for sauce, sauceInfo in pairs(msg.sauces or {}) do
    game.role.sauces[sauceInfo.id] = require("app.models.Sauce"):create(sauceInfo)
  end
  for carbonId, carbonInfo in pairs(msg.carbons or {}) do
    game.role.carbons[carbonId] = carbonInfo
  end
  for mapId, mapInfo in pairs(msg.maps or {}) do
    game.role.maps[mapInfo.mapId] = mapInfo
  end
  game.role.towerData = msg.towerData
  game.role.pvpInfo = game.role.pvpInfo or {}
  table.merge(game.role.pvpInfo, msg.pvpInfo or {})
  game.role.friendRed = msg.friendRed
  game.role.unionData = msg.unionData
  if msg.storyBook then
    game.role.storyBook = json.decode(msg.storyBook)
    game.role.storyBook["6"] = game.role.storyBook["6"] and game.role.storyBook["6"]:toNumMap() or {}
    game.role.storyBook["7"] = game.role.storyBook["7"] and game.role.storyBook["7"]:toNumMap() or {}
    game.role:checkRedPoint("story")
  end
  if newLogin then
    for key, val in pairs(msg.timestamps or {}) do
      game.role[key] = val
    end
    for key, val in pairs(msg.dailyData or {}) do
      game.role[key] = val
    end
    game:enterScene("MainScene")
    sdkInterface:dispatchEvent({
      name = "noticeSdkEvent",
      eventName = "roleLogin",
      userId = game.platform_uid:sub(1, -3),
      roleName = game.role.name,
      roleId = game.role.id,
      roleLevel = game.role.level,
      createTime = game.role.createTime,
      cumulCharge = game.role.cumulCharge,
      serverId = game.serverInfo.serverId,
      serverName = game.serverInfo.name,
      firstLogin = game.role.firstLogin
    })
  else
    for key, value in pairs(msg.role) do
      if key ~= "storyBook" then
        if game.role["set_" .. key] then
          game.role:updateProperty(key, value)
        else
          game.role[key] = value
        end
      end
    end
    for key, value in pairs(msg.dailyData or {}) do
      if game.role["set_" .. key] then
        game.role:updateProperty(key, value)
      else
        game.role[key] = value
      end
    end
    for key, value in pairs(msg.timestamps or {}) do
      if game.role["set_" .. key] then
        game.role:updateProperty(key, value)
      else
        game.role[key] = value
      end
    end
    game.role:afterInit()
  end
  game.role:initBoxTalent(game.role.boxTalent)
  game.role:initRedPoint()
  scheduler.performWithDelayGlobal(function()
    if device.platform == "ios" then
      sdkInterface:initStore()
    end
  end, 1)
end
