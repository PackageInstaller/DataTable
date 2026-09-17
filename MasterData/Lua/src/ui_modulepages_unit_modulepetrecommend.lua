local this = class("modulePetRecommend", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _petSellTypeTpl = L_GameTpl:getFormationPetSellTpl()

function this.bind()
  return {
    recommendList = {
      moduleName = "modulePages/unit/cellPetRecommendType"
    },
    module_petFilterName = "",
    module_petFilter = {
      type = "toggleModule",
      modulePetFilter = {
        assetName = "UI/CommonModules/Unit/modulePetRecommendFilter",
        moduleName = "modulePages/unit/modulePetRecommendFilter"
      }
    },
    go_active = true,
    go_recommendListAcitve = true
  }
end

function this.methods()
  return {
    onClick_petFilter = function(self)
      self:petFilter()
      if self.SetBtnRecommendVisible then
        self:SetBtnRecommendVisible(true)
      end
    end,
    onClick_emptyClose = function(self)
      self:setActive(false)
      if self.SetBtnRecommendVisible then
        self:SetBtnRecommendVisible(true)
      end
    end
  }
end

function this:setActive(active)
  self.bind.go_active = active
end

function this:initModule(param)
  self:setActive(true)
  self.heroConfigId = param and param.configId
  self.SetBtnRecommendVisible = param and param.SetBtnRecommendVisible
  self.bind.module_petFilterName = ""
  if not self.heroConfigId then
    return
  end
  local tpl = _heroTpl:getTplById(self.heroConfigId)
  if not tpl then
    return
  end
  local petTable = _heroTpl:getHeroRecommendPet(tpl)
  if not petTable then
    return
  end
  self.bind.go_recommendListAcitve = true
  local cellList = {}
  for type, petList in pairs(petTable) do
    local typeTpl = _petSellTypeTpl:getTplById(type)
    table.insert(cellList, {
      heroConfigId = self.heroConfigId,
      typeTitle = _petSellTypeTpl:getTypeName(typeTpl),
      type = type,
      petList = petList
    })
  end
  self.bind.recommendList:clear()
  self.bind.recommendList:insert_array(cellList)
end

function this:petFilter()
  self.bind.module_petFilterName = "modulePetFilter"
  if self.modules.module_petFilter.modulePetFilter then
    self.modules.module_petFilter.modulePetFilter:initModule({
      configId = self.heroConfigId
    })
    if self.bind.onClickSelectPet then
      function self.modules.module_petFilter.modulePetFilter.bind.onClickSelectPet(cell, petGuid)
        self.bind:onClickSelectPet(petGuid)
      end
    end
    self.bind.go_recommendListAcitve = false
  end
end

return this
