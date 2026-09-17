local this = class("pagePetGene", G_UIPageBase)
local petTpl = L_GameTpl:getPetTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    geneGrid = {
      [1] = {},
      [2] = {},
      [3] = {},
      [4] = {},
      [5] = {},
      [6] = {}
    },
    initialGrid = {
      gene_name = "",
      gene_skill = "",
      pos = 0,
      lock = false,
      geneGuid = 0,
      geneColor = 0,
      rarity = 0,
      geneLv = 0,
      gridSize = 0
    },
    geneColor = {
      [1] = "#e98b8b",
      [2] = "#799258",
      [3] = "#d6b16c",
      [4] = "#8fb4e3"
    },
    effectIcon = {
      [1] = "Pages/Pet/tex_pet_frame_reinforce_red",
      [2] = "Pages/Pet/tex_pet_frame_reinforce_green",
      [3] = "Pages/Pet/tex_pet_frame_reinforce_yellow",
      [4] = "Pages/Pet/tex_pet_frame_reinforce_blue",
      [5] = "Pages/Pet/tex_pet_frame_reinforce_multi"
    }
  }
end

function this.bind()
  return {
    modulePetDisplay = {
      moduleName = "pages/pet/modulePetDisplay"
    },
    modulePetGene = {
      moduleName = "pages/pet/modulePetGene"
    },
    show_petDisplay = true,
    enableEdit_color = 1,
    moduleCommonTop = {
      moduleName = "modulePages/moduleCommonTop"
    }
  }
end

function this.methods()
  return {
    onClick_enableGeneEdit = function(self)
      local data = self:getCurrentRareGene()
      if #data == 0 then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_rare_gene_empty"))
        return
      end
      L_UI:open("pageShowSpecialGene", {
        id = self.pet.id,
        rareGene = data
      })
    end
  }
end

function this:preOpen(options)
  self.enableEdit = true
  if options ~= nil and options.disableEdit == true then
    self.enableEdit = false
  end
  if options ~= nil and options.pet ~= nil then
    self.pet = options.pet
  else
    self.pet = L_PetStore:getPetItem(L_PetStore:getCurSelectPetId())
  end
  local data = {
    name = L_WordsTpl:getValue("notice_pagePetGene"),
    helpBtnBool = false,
    mainBtnBool = false,
    closeCurPage = function()
      L_UI:close(self.pageName)
    end,
    helpBtn = function()
    end,
    mainBtn = function()
      L_UI:backToRoot()
    end
  }
  self.modules.moduleCommonTop:initModule(data)
  self.editMode = false
  self.curSelectedGene = nil
  self:refreshPetProperty(self.pet)
  self.modules.modulePetDisplay:infoRefresh(self.pet)
  self.modules.modulePetGene:initPetGene(self.pet)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId, self)
end

function this:show()
end

function this:close()
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet)
  L_PetStore:unListenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId)
end

function this:onEvent_refreshPet(pet)
  if pet.guid ~= self.pet.guid then
    return
  end
  self:refreshPetProperty(pet)
end

function this:onEvent_setCurPetId(petId)
  self:refreshPetProperty(L_PetStore:getPetItem(petId))
end

function this:getCurrentRareGene()
  local data = {}
  if not self.pet then
    return data
  end
  local petInfoTpl = petTpl:getTplById(self.pet.petId)
  local genes = petTpl:getDna(petInfoTpl)
  for _, v in ipairs(genes) do
    table.insert(data, v[1])
  end
  return data
end

function this:refreshPetProperty(pet)
  if pet == nil then
    return
  end
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petGene)
  callback(result)
end

return this
