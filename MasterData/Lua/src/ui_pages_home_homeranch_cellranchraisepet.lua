local this = class("cellRanchRaisePet", G_UIModuleBase)
local _HomeRanchTpl = L_GameTpl:getHomeRanchTpl()
local _petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
local _homeDropTpl = L_GameTpl:getHomeDropTpl()
local CellMode = {
  LOCK = 1,
  EMPTY = 2,
  PET = 3
}

function this.bind()
  return {
    tab_mode = -1,
    module_pixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    txt_condition = "",
    img_iconDrop = ""
  }
end

function this.methods()
  return {
    onClick_pet = function(self)
      if self.bind.tab_mode == CellMode.EMPTY or self.bind.tab_mode == CellMode.PET then
        local function func(petGuid)
          C_HomeManager:GetHomeStore():ReqSetProductPet(self.bind.blockId, self.bind.index, petGuid, handler(self, self.refreshView))
        end
        
        L_UI:open("pageStation", {
          capacityId = L_HomeConst.homeLaborType.RANCH_PRODUCT,
          selectGuid = self._guid,
          petSize = {
            1,
            2,
            3,
            4
          },
          blockId = self.bind.blockId,
          callback = func
        })
      end
    end
  }
end

function this:open()
  self:refreshView()
  self.onHomeRanchSync = handler(self, self.refreshView)
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeRanchSync, self.onHomeRanchSync)
end

function this:refreshView()
  local blockId = self.bind.blockId
  local index = self.bind.index
  local ranchData = C_HomeManager:GetHomeStore():GetRanchData(blockId)
  local currLv = ranchData and ranchData.lv or 1
  local tpl = _HomeRanchTpl:getTplById(currLv)
  if index > _HomeRanchTpl:getPetLimit(tpl) then
    self.bind.tab_mode = CellMode.LOCK
    for i = 1, _HomeRanchTpl:getMaxLv() do
      local tempTpl = _HomeRanchTpl:getTplById(i)
      if index <= _HomeRanchTpl:getPetLimit(tempTpl) then
        self.bind.txt_condition = L_WordsTpl:getValue("ui_moduleCanteenFree_03", {
          [0] = i
        })
        break
      end
    end
  elseif not ranchData.productPets:ContainsKey(index) then
    self.bind.tab_mode = CellMode.EMPTY
    self._guid = 0
  else
    self.bind.tab_mode = CellMode.PET
    self._guid = ranchData.productPets[index].petGuid
    self.modules.module_pixelIcon:setGuid(self._guid, true)
    local confId = L_PetStore:getPetItem(self._guid).id
    local petTalentTpl = _petHomeTalentTpl:getTplById(confId)
    local dropIds = _petHomeTalentTpl:getFarmProducts(petTalentTpl)
    if #dropIds <= 0 then
      errorf("策划配错了 ,宠物" .. confId .. "没有牧场产出，要求所有宠物都有")
    else
      local tpl_drop = _homeDropTpl:getTplById(dropIds[1])
      local itemType, itemId = _homeDropTpl:getItemType(tpl_drop), _homeDropTpl:getItemId(tpl_drop)
      self.bind.img_iconDrop = L_ItemTplManager:getItemConfig(itemType, itemId[1]).icon
    end
  end
end

function this:close()
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeRanchSync, self.onHomeRanchSync)
end

return this
