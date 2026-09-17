local this = class("photoLightData", require("ui.pages.photo.submodule.lightDataBase"))
local lightPrefabPath = "Program/Photo/pre_photoPointLight.prefab"

function this:ctor()
  this.super.ctor(self)
  self.lightId = 0
  self.isOn = false
  self.color = C_Color.white
  self.range = 10
  self.intensity = 1
  self.position = nil
  self.lightObj = nil
end

function this:setColorHex(hex)
  local r, c = C_ColorUtility.TryParseHtmlString(hex)
  if r then
    self.color = c
  end
  return r
end

function this:setColor(color)
  self.color = color
  if self.lightComp then
    self.lightComp.color = color
  end
end

function this:setRange(range)
  self.range = range
  if self.lightComp then
    self.lightComp.range = range
  end
end

function this:setIntensity(intensity)
  self.intensity = intensity
  if self.lightComp then
    self.lightComp.intensity = intensity
  end
end

function this:getColorHex()
  return C_ColorUtility.ToHtmlStringRGB(self.color)
end

function this:reset(isInit)
  self.color = C_Color.white
  self.range = 10
  self.intensity = 1
  if isInit then
    self.position = nil
  elseif self.lightObj then
    local mainHeroEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
    if mainHeroEntity then
      self.position = self:getHeroGroundPos() + L_Const._photoLightOffset
    end
  end
  self:setLightComp()
end

function this:setIsOn(isOn)
  self.isOn = isOn
  if self.lightObj == nil then
    self:setLightObj()
  end
  self.lightObj:SetActive(isOn)
  self:setLightComp()
end

function this:setPosition(pos)
  self.position = pos
  if self.lightObj ~= nil then
    self.lightObj.transform.position = pos
  end
end

function this:setLightObj()
  if self.lightObj ~= nil then
    return
  end
  local obj = L_ResPool:syncGameObject(lightPrefabPath, C_LuaUtility.GetRootNode())
  self.lightObj = obj
  self.lightComp = self.lightObj:GetComponent(typeof(Unity.Light))
  self.lightObj:SetActive(self.isOn)
  self:setLightComp()
end

function this:setLightComp()
  if self.isOn and self.lightObj then
    if self.position == nil then
      self.position = self:getHeroGroundPos() + L_Const._photoLightOffset
    end
    self.lightObj.transform.position = self.position
    self.lightComp.intensity = self.intensity
    self.lightComp.range = self.range
    self.lightComp.color = self.color
  end
end

function this:getHeroGroundPos()
  local mainHeroEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if mainHeroEntity == nil then
    return C_Vector3.zero
  end
  local t = Unity.LayerMask.GetMask("Terrain")
  local t2 = Unity.LayerMask.GetMask("Default")
  local layerMask = t | t2
  local success, hit = mainHeroEntity.transform:GetRawTransform():RaycastForLua(C_Vector3.down, 5, layerMask)
  if success then
    return hit.point
  end
  return mainHeroEntity.transform:GetRawTransform().position
end

function this:destroyObj()
  if self.lightObj ~= nil then
    L_ResPool:dispose()
    C_GameObject.Destroy(self.lightObj)
    self.lightObj = nil
  end
end

function this:getRangeLimit()
  local str = self:getDefaultVal(L_Const.photoParam.lightLimit + self.lightId)
  local split = string.split(str, ",")
  local i = 2
  local sp = string.split(split[i], "|")
  local min = tonumber(sp[1])
  local max = tonumber(sp[2])
  return min, max
end

function this:getIntensityLimit()
  local str = self:getDefaultVal(L_Const.photoParam.lightLimit + self.lightId)
  local split = string.split(str, ",")
  local i = 1
  local sp = string.split(split[i], "|")
  local min = tonumber(sp[1])
  local max = tonumber(sp[2])
  return min, max
end

function this:getDefaultVal(id)
  local tpl = self.paramTpl:getTplById(id)
  local default = self.paramTpl:getParam(tpl)
  return default
end

return this
