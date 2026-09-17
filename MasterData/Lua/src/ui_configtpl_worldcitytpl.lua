local this = class("worldCityTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getCityStory(tpl)
  return tpl.cityStory
end

function this:getCity(tpl)
  return L_Config:provider(tpl.city)
end

function this:getBorthPos(tpl)
  local point = tpl.borthPoint
  return {
    x = point[1],
    y = point[2],
    z = point[3]
  }
end

function this:getBorthRot(tpl)
  local point = tpl.borthPoint
  return {
    x = point[4],
    y = point[5],
    z = point[6]
  }
end

function this:getMountAvailable(tpl)
  return tpl.mountAvailable == 1
end

function this:getTimeScale(tpl)
  return tpl.timePassAvailable
end

function this:getArtScene(tpl)
  return tpl.artScene
end

function this:getBGM(tpl)
  return tpl.bgm
end

function this:getAMB(tpl)
  return tpl.amb
end

function this:getPlayModule(tpl)
  return nil
end

function this:defaultSecond(tpl)
  return tpl.defaultTime / L_Const.weatherSecondRate
end

function this:getType(tpl)
  return tpl.type
end

function this:getExploreSwitch(tpl)
  return tpl.exploreSwitch == 1
end

function this:getFormationScene(cityId)
  local tpl = self:getTplById(cityId)
  if tpl and tpl.formationSence ~= "" then
    return tpl.formationSence
  end
  return "default"
end

function this:getCharge(tpl)
  return tpl.charge
end

function this:getEnterPoint(tpl)
  return tpl.EnterPoint
end

function this:getIsSystemDisable(tpl, systemId)
  local disableList = tpl.featureBlockList or {}
  for _, v in ipairs(disableList) do
    if v == systemId then
      return true
    end
  end
  return false
end

return this
