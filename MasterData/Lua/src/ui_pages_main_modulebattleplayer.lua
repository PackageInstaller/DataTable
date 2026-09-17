local this = class("moduleBattlePlayer", G_UIModuleBase)

function this.bind()
  return {
    goNodeNormal = true,
    scrollRectHero = {
      moduleName = "modulePages/cellBattleHero"
    }
  }
end

function this.methods()
  return {
    scrollRectHero = {
      onClick = function(self, bind)
        self:onChoice_hero(bind.index)
      end
    }
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  self:initFormation()
end

function this:close()
end

function this:show()
  L_ShortCutManager:registerShortCutMapList("moduleBattlePlayer", {
    C_InputManager_KeyType.EMainSwitchHero1,
    C_InputManager_KeyType.EMainSwitchHero2,
    C_InputManager_KeyType.EMainSwitchHero3
  })
end

function this:initFormation()
  local selectTeam = L_BattleTeamStore:getBattleTeamInfo()
  self.teamList = {}
  for i = 0, selectTeam.Count - 1 do
    local v = selectTeam[i]
    local item = {}
    item.heroId = v.id
    item.control = i == 0
    if v.teamPetData ~= nil then
      item.petId = v.teamPetData.id
    else
      item.petId = 0
    end
    item.index = i + 1
    table.insert(self.teamList, item)
  end
  self.bind.scrollRectHero:clear()
  self.bind.scrollRectHero:insert_array(self.teamList)
end

function this:refreshFormationList()
  for i = 1, #self.teamList do
    self.bind.scrollRectHero:change(i, self.teamList[i])
  end
end

function this:onChoice_hero(index)
  L_FormationManager:switchMyPlayerMainControl(index - 1)
end

return this
