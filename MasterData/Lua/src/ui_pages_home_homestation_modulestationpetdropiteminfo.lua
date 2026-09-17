local module = class("moduleStationPetDropItemInfo", G_UIModuleBase)
local _petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
local _homeDropTpl = L_GameTpl:getHomeDropTpl()

function module.bind()
  return {
    txtPetName = "",
    grid_drops = {
      moduleName = "pages/home/homeStation/cellStationDropItem"
    },
    modulePxiePet = {
      moduleName = "pages/pet/cellPixelPet"
    }
  }
end

function module:initModule(params)
  self._params = params or {}
  self.petGuid = self._params.petGuid
  self:refresh()
end

function module:refresh()
  if not self.petGuid then
    return
  end
  local petItem = L_PetStore:getPetItem(self.petGuid)
  if not petItem then
    return
  end
  local confId = petItem.id
  local petTalentTpl = _petHomeTalentTpl:getTplById(confId)
  local dropIds = _petHomeTalentTpl:getFarmProducts(petTalentTpl)
  self.bind.txtPetName = petItem:getPetName()
  self.modules.modulePxiePet:setPetDataContent(self.petGuid, {
    guid = self.petGuid
  })
  self:refreshDropList(dropIds)
  local pixelPet = self.modules.modulePxiePet
  pixelPet:setPetDataContent(self.petGuid, {})
  pixelPet:refreshView()
end

function module:refreshDropList(dropIds)
  local itemMaps = {}
  local data = {}
  for i = 1, #dropIds do
    local v = dropIds[i]
    local tpl_drop = _homeDropTpl:getTplById(v)
    local itemType, itemId = _homeDropTpl:getItemType(tpl_drop), _homeDropTpl:getItemId(tpl_drop)
    if itemType ~= L_Const.resType.petEgg then
      itemMaps[itemType] = itemMaps[itemType] or {}
      if not itemMaps[itemType][itemId[1]] then
        table.insert(data, {
          itemType = itemType,
          itemId = itemId[1],
          go_mainDrop = i == 1
        })
      end
      itemMaps[itemType][itemId[1]] = true
    end
  end
  self.bind.grid_drops:clear()
  self.bind.grid_drops:insert_array(data)
end

function module:playChangeAnimation()
  self.bindComponents.anim:Stop()
  self.bindComponents.anim:Play("anim_product_stationedManage_petdropitem_change")
  self.bindComponents.boardCanvasGroup.alpha = 1
  self.bindComponents.rootCanvasGroup.alpha = 1
  self.bindComponents.rootCanvasGroup.transform.localPosition = C_Vector3(0, 0, 0)
end

function module:playHideAnimation()
  self.bindComponents.anim:Play("anim_product_stationedManage_petdropitem_out")
end

function module:showByAnim(param)
  L_TimerManager:stopTimer(self, "hideStationPetDropItemInfo")
  if self._isShowAnim then
    self:playChangeAnimation()
  end
  self:SetActive(true, false)
  self:initModule(param)
  self._isShowAnim = true
  self._isHideing = false
end

function module:hideByAnim()
  if not self._isShowAnim or self._isHideing then
    return
  end
  self._isHideing = true
  self:playHideAnimation()
  L_TimerManager:newOrResetTimer(self, "hideStationPetDropItemInfo", function()
    self:SetActive(false, false)
    self._isShowAnim = false
    self._isHideing = false
  end, 0.5)
end

function module:close()
  self:clearModuleTimer()
end

function module:clearModuleTimer()
  L_TimerManager:clearTimer(self)
end

function module:show(options)
  module.super.show(self, options)
  if not self.modules.grid_drops then
    return
  end
  for i, _module in ipairs(self.modules.grid_drops) do
    _module:playShowAnim()
  end
end

return module
