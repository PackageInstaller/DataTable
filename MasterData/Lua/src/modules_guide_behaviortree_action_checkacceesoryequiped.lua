local this = L_BevTree:registClass("guide.checkAcceesoryEquiped", L_BevTree.action)
local accessoryTpl = L_GameTpl:getAccessoryTpl()

function this:param()
  self.accessoryType = 0
end

function this:parse()
  self.accessoryType = self:getParam("accessoryType", true)
end

function this:execute()
  local main = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if main then
    local guid = main.data.UUID
    local hero = L_HeroStore:getHero(guid)
    local accessories = L_HeroStore:getHeroAccessoryGuidList(hero)
    for _, accessoryGuid in ipairs(accessories) do
      if not math.isEmpty(accessoryGuid) then
        local accessory = C_AccessoryMgr:getAccessory(accessoryGuid)
        if accessory then
          local tpl = accessoryTpl:getTplById(accessory.accessoryId)
          if tpl ~= nil and accessoryTpl:getType(tpl) == self.accessoryType then
            return L_BevTree.taskResult.Success
          end
        end
      end
    end
  end
  return L_BevTree.taskResult.Failure
end

return this
