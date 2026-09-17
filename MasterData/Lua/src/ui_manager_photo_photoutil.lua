local this = {}

function this:injectMediator_setting()
  local mediator = L_PhotoManager:getMediator()
  local base = {
    target = handler(self, this.translateTarget)
  }
  mediator:addHandlers(base)
  if not this.translateSetting then
    this.translateSetting = {
      [L_Const.photoParam.player] = {
        funcName = "translatePlayer"
      },
      [L_Const.photoParam.otherPlayer] = {
        funcName = "translateOtherPlayer"
      },
      [L_Const.photoParam.pet] = {
        funcName = "translatePet"
      },
      [L_Const.photoParam.npc] = {
        funcName = "translateNpc"
      },
      [L_Const.photoParam.alpha] = {
        funcName = "translateAlpha"
      },
      [L_Const.photoParam.teamPlayer] = {
        funcName = "translateTeamPlayer"
      },
      [L_Const.photoParam.enemy] = {
        funcName = "translateEnemy"
      },
      [L_Const.photoParam.petHud] = {
        funcName = "translatePetHud"
      },
      [L_Const.photoParam.npcHud] = {
        funcName = "translateNpcHud"
      },
      [L_Const.photoParam.highResolution] = {
        funcName = "translateHighResolution"
      }
    }
  end
  local setting = {}
  for key, value in pairs(this.translateSetting) do
    setting[key] = handler(self, this[value.funcName])
  end
  mediator.setting:addHandlers(setting)
end

function this:translateTarget(newEntity, oldEnity)
  if newEntity == nil and oldEnity then
    L_PhotoManager:getMediator():revertSetting()
  end
end

function this:translatePlayer(isShow)
  local mediator = L_PhotoManager:getMediator()
  local entity = mediator.target
  AzurWorldInstance:SetNodeVisible(L_Const.WorldNode.PLAYER, isShow, L_Const.worldNodeHideType.LuaUIControlHide)
  if isShow then
    local isMount = L_PlayerManager:isInMounting()
    if isMount then
      local mainHeroEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
      C_CameraManager.PlayBindTarget(mainHeroEntity.entity.transform:GetRawTransform())
    else
      C_CameraManager.PlayBindTarget(entity.entity.transform:GetRawTransform())
    end
  else
  end
  if not isShow then
    mediator.isViewLine = false
  end
end

function this:translateTeamPlayer(isShow)
end

function this:translateOtherPlayer(isShow)
end

function this:translateEnemy(isShow)
  AzurWorldInstance:SetNodeVisible(L_Const.WorldNode.ENEMY, isShow)
  AzurWorld.HomeMgr:SetAllPetHide(not isShow, "photo")
end

function this:translatePetHud(isShow)
  local mediator = L_PhotoManager:getMediator()
  if mediator then
    mediator.hudSwitch:SetHudShow(L_Const.WorldNode.ENEMY, isShow)
  end
end

function this:translateNpc(isShow)
  AzurWorldInstance:SetNodeVisible(L_Const.WorldNode.NPC, isShow)
end

function this:translatePet(isShow)
  C_PlayerUnitHelper.SetPetEntityVisible(isShow, CS.Lens.Gameplay.Modules.BigWorld.EEntityHideSource.Photo)
end

function this:translateAlpha(isShow)
end

function this:translateNpcHud(isShow)
  local mediator = L_PhotoManager:getMediator()
  if mediator then
    mediator.hudSwitch:SetHudShow(L_Const.WorldNode.NPC, isShow)
  end
end

function this:translateHighResolution(isShow)
  L_PhotoManager.useHighResolution = isShow
end

return this
