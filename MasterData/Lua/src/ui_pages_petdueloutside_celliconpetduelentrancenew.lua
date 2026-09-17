local cls = class("cellIconPetDuelEntranceNew", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local elementTpl = L_GameTpl:getElementTypeTpl()
local _trialPetTpl = L_GameTpl:getTrialPetTpl()
local IsPc = L_DeviceTpl:getIsPc()
local _petCatchItemTpl = L_GameTpl:getPetCatchItemTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local petElementColor = {
  [1] = "#E14F47",
  [2] = "#FF9537",
  [3] = "#CE8556",
  [4] = "#9BCE50",
  [5] = "#59D7D4",
  [6] = "#60BBFF",
  [7] = "#708BFF",
  [8] = "#FFF157",
  [9] = "#8C7195"
}
local costIconEnum = {
  [0] = "UI/Icon/PetDuelIcon/tex_petduel_num_0.png",
  [1] = "UI/Icon/PetDuelIcon/tex_petduel_num_1.png",
  [2] = "UI/Icon/PetDuelIcon/tex_petduel_num_2.png",
  [3] = "UI/Icon/PetDuelIcon/tex_petduel_num_3.png",
  [4] = "UI/Icon/PetDuelIcon/tex_petduel_num_4.png",
  [5] = "UI/Icon/PetDuelIcon/tex_petduel_num_5.png",
  [6] = "UI/Icon/PetDuelIcon/tex_petduel_num_6.png",
  [7] = "UI/Icon/PetDuelIcon/tex_petduel_num_7.png",
  [8] = "UI/Icon/PetDuelIcon/tex_petduel_num_8.png",
  [9] = "UI/Icon/PetDuelIcon/tex_petduel_num_9.png"
}
local catchCardItemToImgPath = {
  [1000001] = 1,
  [1000002] = 2,
  [1000003] = 3,
  [1000004] = 4,
  [1000005] = 5
}
local layout = {61, 105}

function cls.bind()
  return {
    toggle_empty = false,
    none_img_mask = false,
    none_img_select = false,
    active_img_select = false,
    active_img_onDrag = false,
    active_img_selectFrame = false,
    img_dec = "",
    img_petIcon = "",
    img_petIconNew = "",
    active_petIconNew = false,
    img_elementBg = "",
    img_elementIcon = "",
    color_elementIcon = C_Color(1, 1, 1, 1),
    pos_elementIcon = C_Vector2(0, 0),
    img_subElementBg = "",
    img_subElementIcon = "",
    color_subElementIcon = C_Color(1, 1, 1, 1),
    pos_subElementIcon = C_Vector2(0, 0),
    active_subElementBg = false,
    txt_cost = "",
    txt_level = "",
    txt_petName = "",
    tagList = {
      moduleName = "pages/petDuel/cellKiBoDuelTag"
    },
    active_trialNode = false,
    active_forbiddenNode = false,
    alpha_content = 1,
    shiningActive = false,
    shiningFxActive = false,
    active_removeBtn = false,
    active_exchange = false,
    active_goNestEmpty = false,
    img_cardIcon = "",
    active_annoy = false,
    active_front = true,
    active_back = true,
    img_glowDec = "",
    img_bg = "",
    img_cost = ""
  }
end

function cls.methods()
  return {
    onClick_select = function(self)
      if not self:tryTrigger(true) then
        return
      end
      if self.bind.callback then
        self.bind.callback(self)
      end
    end,
    onClick_remove = function(self)
      if not self:tryTrigger() then
        return
      end
      if self.bind.callback_remove then
        self.bind.callback_remove(self)
      end
    end,
    onPointEnter_content = function(self)
      if not self:tryTrigger() then
        return
      end
      if not (IsPc and self.petGuid) or self.petGuid <= 0 or self._isDragging then
        return
      end
      if not self.bind.pointEnterCallback or self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationSlot or self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationPetPool then
      end
    end,
    onPointExit_content = function(self)
      if not self:tryTrigger() then
        return
      end
      if not (IsPc and self.petGuid) or self.petGuid <= 0 or self._isDragging then
        return
      end
      if not self.bind.pointExitCallback or self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationSlot or self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationPetPool then
      end
    end,
    onPointEnter_exchange = function(self)
      if not self:tryTrigger() then
        return
      end
      if not self._isDragging or self._isDragSelect or self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationPetPool then
        return
      end
      if not self.petGuid or self.petGuid <= 0 then
        self:setExchangeEmptySelect(true)
        return
      end
      self:setExchangeSelect(true)
    end,
    onPointExit_exchange = function(self)
      if not self:tryTrigger() then
        return
      end
      if not self._isDragging or self._isDragSelect or self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationPetPool then
        return
      end
      if not self.petGuid or self.petGuid <= 0 then
        self:setExchangeEmptySelect(false)
        return
      end
      self:setExchangeSelect(false)
    end
  }
end

function cls:tryTrigger(isShowTip)
  if self.isTeachMode then
    if isShowTip then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_entrust_troop_interim"))
    end
    return false
  end
  return true
end

function cls:initData(data)
  self.petCfgId = data.petCfgId
  self.petLv = data.petLv
  self.petGuid = data.petGuid
  self.petItem = L_PetStore:getPetItem(self.petGuid)
  self.cellMode = data.cellMode
  self.slotId = data.slotId
  self.selectSlotId = data.selectSlotId
  self.isTrial = data.is_trial
  self.isForbidden = data.isForbidden
  self.bind.callback = data.callback
  local petCfg = petTpl:getTplById(self.petItem:petCfgId())
  local isSpecial = self.petItem:isSpecialPet()
  self.bind.petName = petTpl:getName(petCfg, isSpecial)
  self.isTeachMode = data.isTeachMode
  self.trialPetCfgId = nil
  if self.isTeachMode then
    self.trialPetCfgId = self.bind.trialPetCfgId
    local trialPetCfg = _trialPetTpl:getTplById(self.trialPetCfgId)
    self.petCfgId = _trialPetTpl:getTrialPet(trialPetCfg)
  end
  self:refreshView()
end

function cls:refresh()
  self.petCfgId = self.bind.petCfgId
  self.petLv = self.bind.petLv
  self.petSpecial = self.bind.petSpecial
  self.petGuid = self.bind.petGuid
  self.petItem = L_PetStore:getPetItem(self.petGuid)
  self.cellMode = self.bind.cellMode
  self.slotId = self.bind.slotId
  self.selectSlotId = self.bind.selectSlotId
  self.isTrial = self.bind.is_trial
  self.isForbidden = self.bind.isForbidden
  self.trialPetCfgId = nil
  self.isTeachMode = self.bind.isTeachMode
  if self.isTeachMode then
    self.trialPetCfgId = self.bind.trialPetCfgId
    local trialPetCfg = _trialPetTpl:getTplById(self.trialPetCfgId)
    self.petCfgId = _trialPetTpl:getTrialPet(trialPetCfg)
  end
  self:refreshView()
end

function cls:refreshView()
  if self.isTrial or self.petItem == nil then
    self.bind.shiningActive = false
    self.bind.shiningFxActive = false
    self.bind.active_annoy = false
  else
    self.bind.shiningActive = self.petItem:hasFlashGene()
    self.bind.shiningFxActive = self.petItem:hasFlashGene()
    self.bind.active_annoy = self.petItem:getPetAbilityLimited()
  end
  if self.cellMode == L_PetConst.PetDuelEntranceCellMode.PreparePvp then
    self.bind.toggle_empty = false
    self.bind.active_front = false
    self:refreshBackImg(self.bind.catchItem)
  end
  if self.cellMode == L_PetConst.PetDuelEntranceCellMode.PrepareEnemy then
    self.bind.toggle_empty = false
    self.bind.none_img_mask = true
    self.bind.active_img_select = false
    self.bind.active_img_onDrag = false
    self.bind.active_trialNode = false
    self.bind.active_forbiddenNode = false
    self.bind.alpha_content = 1
    local petCfg = petTpl:getTplById(self.petCfgId)
    if not petCfg then
      self.bind.toggle_empty = true
      return
    end
    self.bind.img_petIcon = petTpl:getKiboCardIcon(petCfg)
    local petIconNew = petTpl:getKiboCardIconNew(petCfg)
    self.bind.img_bg = petTpl:getKiboCardIconBg(petCfg)
    if petIconNew and #petIconNew ~= 0 then
      self.bind.active_petIconNew = true
      self.bind.img_petIconNew = petIconNew
    else
      self.bind.active_petIconNew = false
    end
    self.bind.txt_level = string.format("Lv.%s", self.petLv)
    self.bind.txt_cost = tostring(L_PetStore:getPetOriginalCost(self.petCfgId))
    self.bind.img_cost = costIconEnum[L_PetStore:getPetOriginalCost(self.petCfgId)]
    self.bind.txt_petName = petTpl:getName(petCfg)
    self:refreshElementInfo(petCfg)
    self:refreshTagList(self.petCfgId)
    self:refreshBackImg(0)
    return
  end
  if self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationNestTeamMember then
    self.bind.toggle_empty = false
    self.bind.none_img_mask = true
    self.bind.active_img_select = false
    self.bind.active_img_onDrag = false
    self.bind.active_trialNode = false
    self.bind.active_forbiddenNode = false
    self.bind.alpha_content = 1
    local petCfg = petTpl:getTplById(self.petCfgId)
    if not petCfg then
      self.bind.toggle_empty = true
      self.bind.active_goNestEmpty = true
      return
    end
    local isSpecial = 0
    if self.petSpecial == L_Const.PetSpecialType.PST_COLOR or self.petSpecial == L_Const.PetSpecialType.PST_FLASH_COLOR or self.petSpecial == L_Const.PetSpecialType.PST_FLASH_COLORFUL then
      isSpecial = 1
    end
    self.bind.img_petIcon = petTpl:getKiboCardIcon(petCfg, isSpecial)
    local petIconNew = petTpl:getKiboCardIconNew(petCfg, isSpecial)
    self.bind.img_bg = petTpl:getKiboCardIconBg(petCfg, isSpecial)
    if petIconNew and #petIconNew ~= 0 then
      self.bind.active_petIconNew = true
      self.bind.img_petIconNew = petIconNew
    else
      self.bind.active_petIconNew = false
    end
    self.bind.txt_level = string.format("Lv.%s", self.petLv)
    self.bind.txt_cost = tostring(L_PetStore:getPetOriginalCost(self.petCfgId))
    self.bind.img_cost = costIconEnum[L_PetStore:getPetOriginalCost(self.petCfgId)]
    self.bind.txt_petName = petTpl:getName(petCfg, isSpecial)
    self:refreshElementInfo(petCfg)
    self:refreshTagList(self.petCfgId)
    local isFlash = self.petSpecial == L_Const.PetSpecialType.PST_FLASH or self.petSpecial == L_Const.PetSpecialType.PST_FLASH_COLOR or self.petSpecial == L_Const.PetSpecialType.PST_FLASH_COLORFUL
    self.bind.shiningActive = isFlash
    self.bind.shiningFxActive = isFlash
    self:refreshBackImg(0)
    return
  end
  if self.cellMode == L_PetConst.PetDuelEntranceCellMode.PrepareSelf then
    self.bind.none_img_mask = true
    self.bind.active_img_select = false
    self.bind.active_img_onDrag = false
    self.bind.toggle_empty = 0 >= self.petGuid
    self.bind.active_trialNode = self.isTrial and 0 < self.petGuid
    self.bind.active_forbiddenNode = self.isForbidden
    self.bind.alpha_content = self.isForbidden and 0.5 or 1
    if self.isTeachMode then
      self:setTeachModeInfo()
      return
    end
    if 0 >= self.petGuid then
      return
    end
    local petCatchItemId = 0
    local petCfgId = 0
    local petLv = 0
    local isSpecial = 0
    if self.isTrial then
      local trialPetCfg = _trialPetTpl:getTplById(self.petGuid)
      petCfgId = _trialPetTpl:getTrialPet(trialPetCfg)
      petLv = L_PetDuelStore:getTrialPetLevel(_trialPetTpl:getTrialPetLevel(trialPetCfg))
      self:refreshTagList(petCfgId)
    else
      petCfgId = self.petItem:petCfgId()
      petCatchItemId = self.petItem:petCatchItemId()
      petLv = self.petItem:petLv()
      self:refreshTagList(self.petItem.id)
      isSpecial = self.petItem:isSpecialPet()
    end
    self.bind.txt_petName = self.bind.petName
    local petCfg = petTpl:getTplById(petCfgId)
    self.bind.img_petIcon = petTpl:getKiboCardIcon(petCfg, isSpecial)
    local petIconNew = petTpl:getKiboCardIconNew(petCfg, isSpecial)
    self.bind.img_bg = petTpl:getKiboCardIconBg(petCfg, isSpecial)
    if petIconNew and #petIconNew ~= 0 then
      self.bind.active_petIconNew = true
      self.bind.img_petIconNew = petIconNew
    else
      self.bind.active_petIconNew = false
    end
    self.bind.txt_level = string.format("Lv.%s", petLv)
    self.bind.txt_cost = tostring(L_PetStore:getPetOriginalCost(petCfgId))
    self.bind.img_cost = costIconEnum[L_PetStore:getPetOriginalCost(petCfgId)]
    self:refreshElementInfo(petCfg)
    self:refreshBackImg(petCatchItemId)
    return
  end
  if self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationSlot then
    self.bind.toggle_empty = 0 >= self.petGuid
    self.bind.active_trialNode = self.isTrial and 0 < self.petGuid
    self.bind.active_forbiddenNode = self.isForbidden
    self.bind.alpha_content = (self.isForbidden or self._isDragSelect) and 0.5 or 1
    self.bind.active_img_selectFrame = self.slotId == self.selectSlotId
    self.bind.none_img_select = self.slotId == self.selectSlotId and 0 >= self.petGuid
    self.bind.active_img_onDrag = self._isDragSelect
    self.bind.active_removeBtn = 0 < self.slotId and not self.bind.toggle_empty
    if 0 >= self.petGuid then
      return
    end
    local petCatchItemId = 0
    local petCfgId = 0
    local petLv = 0
    local isSpecial = 0
    if self.isTrial then
      local trialPetCfg = _trialPetTpl:getTplById(self.petGuid)
      petCfgId = _trialPetTpl:getTrialPet(trialPetCfg)
      petLv = L_PetDuelStore:getTrialPetLevel(_trialPetTpl:getTrialPetLevel(trialPetCfg))
      self:refreshTagList(petCfgId)
    else
      petCfgId = self.petItem:petCfgId()
      petCatchItemId = self.petItem:petCatchItemId()
      petLv = self.petItem:petLv()
      self:refreshTagList(self.petItem.id)
      isSpecial = self.petItem:isSpecialPet()
    end
    self.bind.txt_petName = self.bind.petName
    local petCfg = petTpl:getTplById(petCfgId)
    self.bind.img_petIcon = petTpl:getKiboCardIcon(petCfg, isSpecial)
    local petIconNew = petTpl:getKiboCardIconNew(petCfg, isSpecial)
    self.bind.img_bg = petTpl:getKiboCardIconBg(petCfg, isSpecial)
    if petIconNew and #petIconNew ~= 0 then
      self.bind.active_petIconNew = true
      self.bind.img_petIconNew = petIconNew
    else
      self.bind.active_petIconNew = false
    end
    self.bind.txt_level = string.format("Lv.%s", petLv)
    self.bind.txt_cost = tostring(L_PetStore:getPetOriginalCost(petCfgId))
    self.bind.img_cost = costIconEnum[L_PetStore:getPetOriginalCost(petCfgId)]
    self:refreshElementInfo(petCfg)
    self:refreshBackImg(petCatchItemId)
    return
  end
  if self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationPetPool then
    self.bind.active_img_select = 0 <= self.slotId
    self.bind.active_img_selectFrame = self.slotId == self.selectSlotId
    self.bind.active_img_onDrag = self._isDragSelect
    self.bind.toggle_empty = false
    self.bind.active_trialNode = self.isTrial and 0 < self.petGuid
    self.bind.active_forbiddenNode = self.isForbidden
    self.bind.alpha_content = (self.isForbidden or self._isDragSelect) and 0.5 or 1
    self.bind.active_removeBtn = 0 < self.slotId and not self.bind.toggle_empty
    local petCatchItemId = 0
    local petCfgId = 0
    local petLv = 0
    local isSpecial = 0
    if self.isTrial then
      local trialPetCfg = _trialPetTpl:getTplById(self.petGuid)
      petCfgId = _trialPetTpl:getTrialPet(trialPetCfg)
      petLv = L_PetDuelStore:getTrialPetLevel(_trialPetTpl:getTrialPetLevel(trialPetCfg))
      local petCfg = petTpl:getTplById(petCfgId)
      self.bind.txt_petName = petTpl:getName(petCfg)
      self:refreshTagList(petCfgId)
    else
      petCfgId = self.petItem:petCfgId()
      petCatchItemId = self.petItem:petCatchItemId()
      petLv = self.petItem:petLv()
      self.bind.txt_petName = self.petItem.pet_name
      self:refreshTagList(self.petItem.id)
      isSpecial = self.petItem:isSpecialPet()
    end
    local petCfg = petTpl:getTplById(petCfgId)
    self.bind.img_petIcon = petTpl:getKiboCardIcon(petCfg, isSpecial)
    local petIconNew = petTpl:getKiboCardIconNew(petCfg, isSpecial)
    self.bind.img_bg = petTpl:getKiboCardIconBg(petCfg, isSpecial)
    if petIconNew and #petIconNew ~= 0 then
      self.bind.active_petIconNew = true
      self.bind.img_petIconNew = petIconNew
    else
      self.bind.active_petIconNew = false
    end
    self.bind.txt_level = string.format("Lv.%s", petLv)
    self.bind.txt_cost = tostring(L_PetStore:getPetOriginalCost(petCfgId))
    self.bind.img_cost = costIconEnum[L_PetStore:getPetOriginalCost(petCfgId)]
    self:refreshElementInfo(petCfg)
    self:refreshBackImg(petCatchItemId)
    return
  end
  if self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationPreviewSlot then
    if not self.petGuid then
      self.petGuid = 0
    end
    self.bind.toggle_empty = 0 >= self.petGuid
    self.bind.none_img_mask = true
    self.bind.active_trialNode = self.isTrial and 0 < self.petGuid
    self.bind.active_forbiddenNode = self.isForbidden
    self.bind.alpha_content = (self.isForbidden or self._isDragSelect) and 0.5 or 1
    self.bind.active_img_selectFrame = false
    self.bind.none_img_select = false
    if 0 >= self.petGuid then
      return
    end
    self.bind.active_removeBtn = false
    local petCatchItemId = 0
    local petCfgId = 0
    local petLv = 0
    local isSpecial = 0
    if self.isTrial then
      local trialPetCfg = _trialPetTpl:getTplById(self.petGuid)
      petCfgId = _trialPetTpl:getTrialPet(trialPetCfg)
      petLv = L_PetDuelStore:getTrialPetLevel(_trialPetTpl:getTrialPetLevel(trialPetCfg))
      self:refreshTagList(petCfgId)
    else
      petCfgId = self.petItem:petCfgId()
      petCatchItemId = self.petItem:petCatchItemId()
      petLv = self.petItem:petLv()
      self:refreshTagList(self.petItem.id)
      isSpecial = self.petItem:isSpecialPet()
    end
    self.bind.txt_petName = self.bind.petName
    local petCfg = petTpl:getTplById(petCfgId)
    if petCfg == nil then
      errorf("没有该宠物的配置" .. petCfgId)
    end
    self.bind.img_petIcon = petTpl:getKiboCardIcon(petCfg, isSpecial)
    local petIconNew = petTpl:getKiboCardIconNew(petCfg, isSpecial)
    self.bind.img_bg = petTpl:getKiboCardIconBg(petCfg, isSpecial)
    if petIconNew and #petIconNew ~= 0 then
      self.bind.active_petIconNew = true
      self.bind.img_petIconNew = petIconNew
    else
      self.bind.active_petIconNew = false
    end
    self.bind.txt_level = string.format("Lv.%s", petLv)
    self.bind.txt_cost = tostring(L_PetStore:getPetOriginalCost(petCfgId))
    self.bind.img_cost = costIconEnum[L_PetStore:getPetOriginalCost(petCfgId)]
    self:refreshElementInfo(petCfg)
    self:refreshBackImg(petCatchItemId)
    return
  end
end

function cls:setTeachModeInfo()
  local trialPetCfg = _trialPetTpl:getTplById(self.trialPetCfgId)
  local petLv = L_PetDuelStore:getTrialPetLevel(_trialPetTpl:getTrialPetLevel(trialPetCfg))
  local isSpecial = 0
  self.bind.toggle_empty = 0 >= self.petCfgId
  self.bind.active_trialNode = self.isTrial and 0 < self.petCfgId
  local petCfg = petTpl:getTplById(self.petCfgId)
  self.bind.txt_petName = petTpl:getName(petCfg)
  self.bind.img_petIcon = petTpl:getKiboCardIcon(petCfg, isSpecial)
  local petIconNew = petTpl:getKiboCardIconNew(petCfg, isSpecial)
  self.bind.img_bg = petTpl:getKiboCardIconBg(petCfg, isSpecial)
  if petIconNew and #petIconNew ~= 0 then
    self.bind.active_petIconNew = true
    self.bind.img_petIconNew = petIconNew
  else
    self.bind.active_petIconNew = false
  end
  self.bind.txt_level = string.format("Lv.%s", petLv)
  self.bind.txt_cost = tostring(L_PetStore:getPetOriginalCost(self.petCfgId))
  self.bind.img_cost = costIconEnum[L_PetStore:getPetOriginalCost(self.petCfgId)]
  self:refreshElementInfo(petCfg)
  self:refreshBackImg(0)
end

function cls:playShakeAnim()
  self.bindComponents.KiboCardAnim:Play("anim_pagePetDuelMain_EntranceNew_330_shake")
  Timer.once(0.467, function()
    self.bindComponents.KiboCardAnim:Play("anim_pagePetDuelMain_EntranceNew_330_shake_state")
  end, self, self.gameObject)
end

function cls:refreshBackImg_Out(petGuid)
  local petItem = L_PetStore:getPetItem(petGuid)
  if petItem ~= nil then
    self:refreshBackImg(petItem:petCatchItemId())
  else
    self:refreshBackImg(0)
  end
end

function cls:refreshBackImg(petCatchItemId)
  if petCatchItemId ~= 0 then
    local commonItemTpl = _commonItemTpl:getTplById(petCatchItemId)
    if commonItemTpl == nil then
      self.bind.img_cardIcon = "UI/Texture/PetBoxCard/tex_icon_petcard_quality_1.png"
      return
    end
    local subId = _commonItemTpl:getSubId(commonItemTpl)
    local catchItemTpl = _petCatchItemTpl:getTplById(subId)
    self.bind.img_cardIcon = _petCatchItemTpl:getCardBgImg(catchItemTpl, 1)
  else
    self.bind.img_cardIcon = "UI/Texture/PetBoxCard/tex_icon_petcard_quality_1.png"
  end
end

function cls:refreshElementInfo(petCfg)
  local elementIds = petTpl:getElement(petCfg)
  local eTpl = elementTpl:getTplById(elementIds[1])
  if self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationPetPool then
    self.bind.img_dec = elementTpl:getKiboDuelCardElementImg(eTpl, 5)
    self.bind.img_glowDec = elementTpl:getKiboDuelCardElementImg(eTpl, 6)
    self.bind.img_elementBg = elementTpl:getKiboDuelCardElementImg(eTpl, 7)
    self.bind.img_elementIcon = elementTpl:getKiboDuelCardElementImg(eTpl, 8)
  else
    self.bind.img_dec = elementTpl:getKiboDuelCardElementImg(eTpl, 1)
    self.bind.img_glowDec = elementTpl:getKiboDuelCardElementImg(eTpl, 2)
    self.bind.img_elementBg = elementTpl:getKiboDuelCardElementImg(eTpl, 3)
    self.bind.img_elementIcon = elementTpl:getKiboDuelCardElementImg(eTpl, 4)
  end
  local _, outlineColor = C_ColorUtility.TryParseHtmlString(elementTpl:getKiboDuelNameOutlineColor(eTpl))
  self.bindComponents.txt_name.style.outlineColor = outlineColor or C_Color(1, 1, 1, 1)
  self.bindComponents.txt_name:RefreshStyle()
  self.bind.active_subElementBg = false
  if 1 < #elementIds then
    local sub_eTpl = elementTpl:getTplById(elementIds[2])
    self.bind.active_subElementBg = true
    self.bind.img_subElementBg = elementTpl:getKiboDuelCardElementImg(eTpl, 3)
    self.bind.img_subElementIcon = elementTpl:getKiboDuelCardElementImg(sub_eTpl, 4)
  end
end

function cls:refreshTagList(petId)
  if not self.isBind then
    return
  end
  local tpl = petTpl:getTplById(petId)
  local tags = petTpl:getKiboDuelTag(tpl)
  local data = {}
  for _, id in ipairs(tags) do
    table.insert(data, {tagId = id})
  end
  self.bind.tagList:clear()
  self.bind.tagList:insert_array(data)
end

function cls:setSelectHero(select)
  if self.cellMode ~= L_PetConst.PetDuelEntranceCellMode.FormationSlot then
    return
  end
  if self.bind.toggle_empty then
    self.bind.active_img_select = not self.slotId == self.selectSlotId
    self.bind.none_img_select = self.slotId == self.selectSlotId and not select
  else
    self.bind.active_img_select = self.slotId == self.selectSlotId and not select
    self.bind.none_img_select = not self.slotId == self.selectSlotId
  end
end

function cls:getRaycastGo()
  if self.isBind then
    return self.bindComponents.btn_select.gameObject
  end
end

function cls:setExchangeEmptySelect(bool)
  self.bind.active_img_onDrag = bool
end

function cls:setExchangeSelect(bool)
  if self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationPetPool then
    return
  end
  self.bind.active_exchange = bool
  self.bind.active_img_onDrag = bool
  if bool then
    self._petExchangeWrap = L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_PickUp_Hold")
    self.exchangeAudioTimer = Timer.repeated(1, function(self)
      self._petExchangeWrap = L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_PickUp_Hold")
    end, self)
  else
    L_AudioUtil.stopSound(self._petExchangeWrap)
    Timer.remove(self.exchangeAudioTimer)
  end
end

function cls:setIsDragging(isDragging, isDragSelect)
  if self.bind.active_exchange or self.exchangeAudioTimer or self._petExchangeWrap then
    self:setExchangeSelect(false)
  end
  if self.bind.pointExitCallback then
    self.bind.pointExitCallback(self)
  end
  self._isDragging = isDragging
  self._isDragSelect = isDragSelect
  self.bind.active_back = not isDragSelect
  self.bind.active_img_onDrag = isDragSelect
  self:refreshView()
end

return cls
