local this = class("modulePetRecommendFilter", G_UIModuleBase)

function this.bind()
  return {
    list_pet = {
      moduleName = "pages/pet/cellPixelPet"
    },
    module_formationPetProperty = {
      type = "toggleModule",
      moduleFormationPetProperty = {
        assetName = "UI/pages/Formation/moduleFormationPetProperty",
        moduleName = "pages/formation/formationModule/moduleFormationPetProperty"
      }
    },
    module_formationPetPropertyName = "",
    blurActive = false
  }
end

function this.methods()
  return {
    onClick_detail = function(self)
      if self.curSelectPetGuid == nil then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_petsell_search_tips"))
        return
      end
      L_UI:open("pagePet", {
        petId = self.curSelectPetGuid
      })
    end
  }
end

function this:show()
  local isPc = L_DeviceTpl:getIsPc()
  self.bind.blurActive = isPc
  local blend = self.bindComponents.board:GetComponent(typeof(C_BlendDefinition))
  if blend and not isPc then
    blend.enabled = false
  end
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
end

function this:hide()
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
end

function this:initModule(param)
  self.heroConfigId = param and param.configId
  if not self.heroConfigId then
    return
  end
  self._petPropertyModule = nil
  self.bind.module_formationPetPropertyName = ""
  self.curSelectPetGuid = nil
  self:initBoxList()
end

function this:initBoxList()
  self.bind.list_pet:clear()
  local dataList = L_PetStore:getRecommendPetList(self.heroConfigId)
  table.sort(dataList, function(a, b)
    local gradeA = L_PetStore:getPetGradeNew(a.guid)
    local gradeB = L_PetStore:getPetGradeNew(b.guid)
    return gradeA > gradeB
  end)
  local cellList = {}
  for _, v in ipairs(dataList) do
    table.insert(cellList, {
      guid = v.guid,
      petConfigId = v.petConfigId,
      filterType = L_PetConst.filterPetBox.grade,
      choice = self.curSelectPetGuid == v.guid,
      pageType = L_PetConst.PageType.Formation,
      callback = function(cell)
        self:onClick_Choose(cell)
      end,
      pointEnterCallback = function(cell)
        self:onPointEnter(cell)
      end,
      pointExitCallback = function(cell)
        self:onPointExit(cell)
      end
    })
  end
  self.bind.list_pet:insert_array(cellList)
end

function this:onClick_Choose(cell)
  if not cell or math.isEmpty(cell.bind.guid) then
    return
  end
  if self.curSelectPetGuid == cell.bind.guid then
    return
  end
  if self.bind.onClickSelectPet then
    self.bind:onClickSelectPet(cell.bind.guid)
    local eventData = {
      hero_id = self.heroConfigId,
      pet_id = cell.bind.petConfigId,
      rec_result = 1
    }
    L_GameUtil.logEvent(L_Const.logEventName.pet_formation_rec, eventData)
  end
  for i = 1, #self.modules.list_pet do
    local petCell = self.modules.list_pet[i]
    if petCell and petCell.bind and petCell.bind.guid == self.curSelectPetGuid then
      petCell:setGifPlay(false)
    end
  end
  self.curSelectPetGuid = cell.bind.guid
  cell:setGifPlay(true)
  self:showPetProperty(cell:getRaycastGo(), cell.bind.guid)
end

function this:onPointEnter(cell)
  if not cell or math.isEmpty(cell.bind.guid) then
    return
  end
  cell.bind.pointEnter = true
  cell:setGifPlay(true)
  self:showPetProperty(cell:getRaycastGo(), cell.bind.guid)
end

function this:onPointExit(cell)
  if not cell or math.isEmpty(cell.bind.guid) then
    return
  end
  cell.bind.pointEnter = false
  local isSelected = self.curSelectPetGuid == cell.bind.guid
  cell:setGifPlay(isSelected)
  if self._petPropertyModule then
    self._petPropertyModule:showModuleInfo(false)
  end
end

function this:showPetProperty(go, guid)
  if not self._petPropertyModule then
    self.bind.module_formationPetPropertyName = "moduleFormationPetProperty"
    self._petPropertyModule = self.modules.module_formationPetProperty.moduleFormationPetProperty
    self._petPropertyModule:openDetailBtn()
  end
  local parentRect = self.bindComponents.modulePetRecommendFilter
  self._petPropertyModule:showModuleInfo(true, guid)
  local targetPos = parentRect.transform:InverseTransformPoint(go.transform.position)
  self._petPropertyModule:setLocalPosAndArrowInRect(targetPos.x, targetPos.y, parentRect, go)
end

function this:onEvent_refreshPet(pet)
  for i = 1, #self.modules.list_pet do
    local petCell = self.modules.list_pet[i]
    if petCell and pet.guid == petCell.bind.guid then
      petCell:refreshView()
    end
  end
end

return this
