local module = class("dungeonPointItem", G_UIModuleBase)
local _unitTpl = L_GameTpl:getUnitTpl()
local _worldMapTpl = L_GameTpl:getWorldMapTpl()

function module.bind()
  return {
    imgIcon = "UI/Atlas/MapNode/tex_icon_mapnode_zhixian.png",
    guidePoint = false,
    targetDirection = false,
    distance_label = "",
    longPressAmount = 0
  }
end

function module.methods()
  return {}
end

function module:created(...)
  self.super.created(self, ...)
end

function module:open()
  self.showEffect = false
  self.bindComponents.guidePoint:Init()
end

function module:hide()
  self.showEffect = false
  self.bindComponents.effect:Stop()
end

function module:close()
end

function module:refreshChallengeTarget(limitCanvas, guidePointViewPort)
  local player = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  local entityPos = self.bind.targetPos
  if player == nil or not entityPos then
    if self.bind.guidePoint then
      self.bind.guidePoint = false
    end
    self.showEffect = false
    return
  end
  self:commonLogicProcess(entityPos, limitCanvas, guidePointViewPort)
  if self.showEffect == false then
    self.bindComponents.effect:Play()
    self.showEffect = true
  end
end

function module:commonLogicProcess(entityPos, limitCanvas, guidePointViewPort)
  self.bindComponents.guidePoint:RefreshTargetPos(entityPos.x, entityPos.y, entityPos.z, guidePointViewPort, self.bind.triggerRange or 0)
end

function module:showPointEffect()
  if self.bind.guidePoint ~= false then
    self.bindComponents.effect:Play()
  end
end

return module
