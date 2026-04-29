_class("UISeasonStageEnemyBalckfist", UICustomWidget)
UISeasonStageEnemyBalckfist = UISeasonStageEnemyBalckfist

function UISeasonStageEnemyBalckfist:OnShow(uiParams)
  self:InitWidget()
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonStageEnemyBalckfist:InitWidget()
  self._petMembersWiget = {}
  local leaderPool = self:GetUIComponent("UISelectObjectPath", "leader")
  local leaderWidget = leaderPool:SpawnObject("UISeasonStageEnemyBalckfistItem")
  table.insert(self._petMembersWiget, leaderWidget)
  local membersPool = self:GetUIComponent("UISelectObjectPath", "menbers")
  local membersWigets = membersPool:SpawnObjects("UISeasonStageEnemyBalckfistItem", 4)
  for k, subWidget in pairs(membersWigets) do
    table.insert(self._petMembersWiget, subWidget)
  end
end

function UISeasonStageEnemyBalckfist:SetData(missionId)
  local missionCfg = Cfg.cfg_component_blackfist[missionId]
  local cfg_pet_element = Cfg.cfg_pet_element({})
  local cfg_blackfist_squads = Cfg.cfg_blackfist_squads({
    SquadsID = missionCfg.SquadsID
  })
  self._cfg_blackfist_hard = Cfg.cfg_blackfist_hard({
    HardID = missionCfg.HardID
  })
  self._teamCfg = {
    cfg_blackfist_squads[1].CfgPetId1,
    cfg_blackfist_squads[1].CfgPetId2,
    cfg_blackfist_squads[1].CfgPetId3,
    cfg_blackfist_squads[1].CfgPetId4,
    cfg_blackfist_squads[1].CfgPetId5
  }
  self._teamData = {}
  for i = 1, #self._teamCfg do
    local pet = Cfg.cfg_pet({
      self._teamCfg[i]
    })
    local petskin = Cfg.cfg_pet_skin({
      id = pet[1].SkinId
    })
    local elemt1, elemt2, petskinTeamBody, staticBody, battleMe
    petskinTeamBody = petskin[1].TeamBody
    staticBody = petskin[1].StaticBody
    battleMe = petskin[1].BattleMes
    if pet[1].FirstElement == 0 then
      elemt1 = nil
    else
      elemt1 = self._atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[pet[1].FirstElement].Icon))
    end
    if pet[1].SecondElement == 0 then
      elemt2 = nil
    else
      elemt2 = self._atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[pet[1].SecondElement].Icon))
    end
    if elemt2 and self._cfg_blackfist_hard[1].Grade ~= pet[1].Element2NeedGrade then
      elemt2 = nil
    end
    local tab = {
      elemt1 = elemt1,
      elemt2 = elemt2,
      skin = petskinTeamBody,
      staticBody = staticBody,
      battleMe = battleMe,
      element2NeedGrade = pet[1].Element2NeedGrade
    }
    table.insert(self._teamData, i, tab)
    self._petMembersWiget[i]:SetData(petskinTeamBody, elemt1, elemt2, function()
      self:ShowDialog("UIN7EnemyDetailsController", self:_GetPetData(), i)
    end)
    if i == 1 then
      local petIndo = pet_data:New()
      petIndo.template_id = self._teamCfg[1]
      petIndo.level = self._cfg_blackfist_hard[1].Lv
      petIndo.grade = self._cfg_blackfist_hard[1].Grade
      petIndo.awakening = self._cfg_blackfist_hard[1].Awakening
      petIndo.affinity_level = 1
      petIndo.current_skin = 0
      local pet = Pet:New(petIndo)
      self._petMembersWiget[i]:SetLeader(pet)
    end
  end
end

function UISeasonStageEnemyBalckfist:_GetPetData()
  local date
  local len1 = table.count(self._teamData)
  local len2 = table.count(self._teamCfg)
  if len1 == len2 then
    date = {}
    for i = 1, len1 do
      local v1 = self._teamCfg[i]
      local v2 = self._teamData[i]
      local dt = {}
      dt.petid = v1
      dt.elemt1 = v2.elemt1
      dt.elemt2 = v2.elemt2
      dt.battleMe = v2.battleMe
      dt.lv = self._cfg_blackfist_hard[1].Lv
      dt.awakening = self._cfg_blackfist_hard[1].Awakening
      dt.grade = self._cfg_blackfist_hard[1].Grade
      dt.equip = self._cfg_blackfist_hard[1].Equip
      table.insert(date, dt)
    end
  end
  return date
end
