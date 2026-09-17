local this = class("cellPetStationedManage", G_UIModuleBase)
local IsPc = L_DeviceTpl:getIsPc()
local _petTpl = L_GameTpl:getPetTpl()
local _homeFreeWorkPositionTpl = L_GameTpl:getHomeFreeWorkPositionTpl()
local PetGifIconPath = "UI/Icon/PetPixelIcon/tex_icon_pet_%s_%d.png"
local MaxPetGifFrame = 8

function this.bind()
  return {
    tab_stationed = 1,
    active_img_designated = false,
    text_lockedDesc = L_WordsTpl:getValue("ui_cellNoviceTaskItem_02"),
    modulesPetShow = {
      type = "toggleModule",
      cellPixelPet = {
        assetName = "UI/Pages/Pet/cellPixelPet",
        moduleName = "pages/pet/cellPixelPet"
      }
    },
    togglePetShow = ""
  }
end

function this.methods()
  return {
    onClick_pet = function(self)
      self:onClickPet()
    end,
    onClick_remove_pet1 = function(self)
      self:onClickPet()
    end,
    btn_onPointEnter = function(self)
      if not IsPc then
        return
      end
      self.pointEnter = true
      if self.onPointEnter then
        self.onPointEnter(self)
      end
      self:refresh()
    end,
    btn_onPointExit = function(self)
      if not IsPc then
        return
      end
      self.pointEnter = nil
      if self.onPointExit then
        self.onPointExit(self)
      end
      self:refresh()
    end
  }
end

function this:close()
end

function this:refresh()
  if self.bind.index == nil or self.bind.petGuid == nil then
    return
  end
  if self.bind.isUnlock then
    self:refreshData(self.bind.petGuid, self.bind.index, true)
  else
    self:refreshData(0, self.bind.index, false)
  end
  self:refreshUI()
end

function this:refreshData(petGuid, freeWorkPosId, isUnlock)
  self.UIData = {}
  self.UIData.petGuid = petGuid
  self.UIData.isUnlock = isUnlock
  self.UIData.curPetGifFrame = 1
  if self.UIData.petGuid ~= 0 then
    local csPetData = L_PetStore:getCsPetData(petGuid)
    local petId = L_PetStore:getPetConfigId(csPetData)
    local petGuid = self.UIData.petGuid
    local petTpl = _petTpl:getTplById(petId)
    local petItem = L_PetStore:getPetItem(petGuid)
    local isSpecial = petItem ~= nil and petItem:isSpecialPet()
    local initFrameIcon = _petTpl:getPetPixelIcon(petTpl, isSpecial)
    self.UIData.petGifPixelIconIdStr = string.match(initFrameIcon, "%a*%d+")
    self.UIData.isDesignated = L_PetStore:getPetIsDesignated(csPetData)
  else
    self.UIData.petGifPixelIconIdStr = ""
    self.UIData.isDesignated = false
  end
  self.UIData.freeWorkPosId = freeWorkPosId
  local cfg = _homeFreeWorkPositionTpl:getUnlockConditionListByFreeWorkPositionId(self.UIData.freeWorkPosId)
  if not cfg then
    return
  end
  local unlockCondition = cfg[1]
  self.UIData.unlockConditionDescString = L_ConditionManager:getSingleDesc(unlockCondition)
end

function this:refreshUI()
  if self.UIData.petGuid ~= 0 then
    self.bind.tab_stationed = 3
  elseif self.UIData.isUnlock then
    self.bind.tab_stationed = 2
  else
    self.bind.tab_stationed = 1
  end
  self.bind.active_img_designated = self.UIData.isDesignated
  self.bind.text_lockedDesc = self.UIData.unlockConditionDescString
  self:refeshPixelIcon()
end

function this:refeshPixelIcon()
  if not self.isBind then
    return
  end
  local pixelPet = self.modules.modulesPetShow.cellPixelPet
  pixelPet.bind.choice = true
  
  function pixelPet.bind.pointEnterCallback()
    self.pointEnter = true
    self:onPointEnter()
    self:refeshPixelIcon()
  end
  
  function pixelPet.bind.pointExitCallback()
    self.pointEnter = nil
    self:onPointExit()
    self:refeshPixelIcon()
  end
  
  function pixelPet.bind.removeCallback()
    self:onClickPet()
  end
  
  function pixelPet.bind.callback()
    self:onClickPet()
  end
  
  pixelPet.bind.selected = self.pointEnter and true or false
  if self.UIData.petGuid ~= 0 then
    self.bind.togglePetShow = "cellPixelPet"
    pixelPet:setPetGUID(self.UIData.petGuid)
    pixelPet:setPetFilterType(self.bind.filterType or L_PetConst.filterPetBox.labor)
    pixelPet:refreshView()
    local scale = self.pointEnter and 1.1 or 1
    pixelPet._pixelIconModule:setImgTranScale(scale)
    pixelPet._pixelIconModule:outLineShow(self.pointEnter)
    if self.pointEnter then
      pixelPet._pixelIconModule:playPixelGif()
    else
      pixelPet._pixelIconModule:stopPixelGif()
    end
    pixelPet.bind.selected = self.pointEnter and true or false
  else
  end
  pixelPet:SetTagActive(L_PetConst.TagEnum.Team, false)
  self.bind.active_img_designated = false
end

function this:refreshFilterType(filterType)
  local pixelPet = self.modules.modulesPetShow.cellPixelPet
  pixelPet.bind.filterType = filterType
  this:refresh()
end

function this:playPetGif()
  local singlePetIconPath = string.format(PetGifIconPath, self.UIData.petGifPixelIconIdStr, self.UIData.curPetGifFrame)
  self.bind.img_pet = singlePetIconPath
  self.UIData.curPetGifFrame = self.UIData.curPetGifFrame % MaxPetGifFrame + 1
end

function this:onClickPet()
  if not (self.UIData and self.UIData.petGuid) or self.UIData.petGuid == 0 then
    return
  end
  self.pointEnter = nil
  if self.bind.onClickPet then
    self.bind.onClickPet(self.UIData.petGuid)
  end
  L_HomeManager:setPetStationedSelected(self.UIData.petGuid)
end

function this:onPointEnter()
  if not self.UIData then
    return
  end
  if self.bind.onPointEnter then
    self.bind.onPointEnter(self.UIData.petGuid)
  end
end

function this:onPointExit()
  if not self.UIData then
    return
  end
  if self.bind.onPointExit then
    self.bind.onPointExit(self.UIData.petGuid)
  end
end

function this:refeshPixelIconDropItem(guid)
  self.bind.togglePetShow = "cellPixelPet"
  local pixelPet = self.modules.modulesPetShow.cellPixelPet
  if pixelPet then
    pixelPet:refreshDropItem(guid)
  end
end

function this:setPetStationed(petGuid)
  local csPetData = L_PetStore:getCsPetData(petGuid)
  local isFreeWork = L_PetStore:getPetIsFreeWork(csPetData)
  local isWorking = L_PetStore:getPetIsWorking(csPetData)
  if isWorking then
    L_FlyMsgManager:showNormalMsgByKey("ui_cellPetStationedManage")
    return
  end
  if isFreeWork then
    L_HomeStore:reqPetExitHomeHub(petGuid)
  else
    L_HomeStore:reqPetStationHomeHub(petGuid)
  end
end

return this
