_class("UIN7TeammateItem", UICustomWidget)
UIN7TeammateItem = UIN7TeammateItem

function UIN7TeammateItem:OnShow(uiParams)
  self:_GetComonent()
end

function UIN7TeammateItem:SetData(pet)
  self._pet = pet
  self:ShowItem()
end

function UIN7TeammateItem:ShowItem()
  if self._pet then
    local petModule = GameGlobal.GetModule(PetModule)
    local uiModule = petModule.uiModule
    self._skillDetailInfos = uiModule:GetSkillDetailInfoBySkillTypeHideExtra(self._pet)
    local skillCount = table.count(self._skillDetailInfos)
    local skills = self:GetUIComponent("UISelectObjectPath", "item")
    skills:SpawnObjects("UIShopPetSkillItem", skillCount)
    self._skillsSpawns = skills:GetAllSpawnList()
    if self._skillsSpawns then
      for i = 1, skillCount do
        local item = self._skillsSpawns[i]
        local skill_info = self._skillDetailInfos[i]
        local skill_list = skill_info.skillList
        item:Flush(i, self._pet, skill_list)
      end
    end
  end
end

function UIN7TeammateItem:HideItem()
  self:DisposeCustomWidgets()
end

function UIN7TeammateItem:_GetComonent()
  self._item = self:GetUIComponent("UISelectObjectPath", "item")
end
