local module = class("modulePetUseItem", G_UIModuleBase)
local commonItemTpl = L_GameTpl:getCommonItemTpl()

function module:ctor(...)
  self.super.ctor(self, ...)
  self.data = {
    curitemId = nil,
    petId = nil,
    itemType = 0,
    currentSelectNum = 0,
    recoverPoint = 0
  }
end

function module.bind()
  return {
    itemInfo_show = false,
    numBox_show = false,
    valueSlider_show = false,
    geneInfo_show = false,
    currentSlider = 0,
    addValueSlider = 0,
    currentValue = "",
    addValue = "",
    maxValue = "",
    num_txt = "",
    itemList = {
      moduleName = "modulePages/cellIcon"
    },
    geneList = {
      moduleName = "pages/Pet/cellSkillItem"
    },
    moduleIcon = {
      moduleName = "modulePages/cellIcon"
    },
    item_name = "",
    item_img_bg = "",
    desc = "",
    geneTips = ""
  }
end

function module.methods()
  return {
    onClick_use = function(self)
      if self.data.curitemId == nil or self.data.curitemId == 0 then
        return
      end
      local itemTpl = commonItemTpl:getTplById(self.data.curitemId)
      local type = self.data.itemType
      if type == 404 then
        if self.bind.currentSlider >= 1 then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_maxenergy"))
          return
        end
      elseif type == 405 then
        local pet = L_PetStore:getPetItem(self.data.petId)
        if 1 <= pet.recombination_time then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_maxgenerecombination"))
          return
        end
      elseif type == 406 then
        if 1 > #self.bind.geneList then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_nolegalgene"))
          return
        end
      elseif type == 408 then
        local pet = L_PetStore:getPetItem(self.data.petId)
        local list = L_PetStore:getPetSkills(pet, true, true, false)
        if 12 <= #list then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_maxgeneposition"))
          return
        end
        local useFunction = commonItemTpl:getUseFunction(itemTpl)
        local reduceNum = useFunction[#useFunction]
        if 0 > pet.vitality - reduceNum then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_lackenergy"))
          return
        end
      end
      C_BagMgr:ReqUseItem(self.data.curitemId, self.data.currentSelectNum, {
        L_Const.UseFoodTarget.UFT_PET,
        self.data.petId
      }, function()
        for _, module in ipairs(self.modules.itemList) do
          module:refreshView()
        end
        self:refreshItemInfo()
      end)
    end,
    geneList = {
      onClick_Choose = function(self, index, data)
        self:clickGeneList(data)
      end
    },
    onClick_toMin = function(self)
      if self.data.currentSelectNum > 0 then
        self.data.currentSelectNum = 1
        self:refreshPetVitality()
      end
    end,
    onClick_toMax = function(self)
      local recoverNum = self.data.recoverPoint
      local pet = L_PetStore:getPetItem(self.data.petId)
      local maxValue = tonumber(L_GameTpl:getGameConstTpl():getData("PET_MAXENERGY", L_Const.GameTplType.int))
      local currentValue = recoverNum * self.data.currentSelectNum + pet.vitality
      if maxValue > currentValue then
        local add_num = math.ceil((maxValue - currentValue) / recoverNum)
        self.data.currentSelectNum = self.data.currentSelectNum + add_num
        self:refreshPetVitality()
      end
    end,
    onClick_add = function(self)
      local recoverNum = self.data.recoverPoint
      local pet = L_PetStore:getPetItem(self.data.petId)
      local maxValue = tonumber(L_GameTpl:getGameConstTpl():getData("PET_MAXENERGY", L_Const.GameTplType.int))
      if maxValue > recoverNum * self.data.currentSelectNum + pet.vitality then
        self.data.currentSelectNum = self.data.currentSelectNum + 1
        self:refreshPetVitality()
      end
    end,
    onClick_reduce = function(self)
      if self.data.currentSelectNum > 1 then
        self.data.currentSelectNum = self.data.currentSelectNum - 1
        self:refreshPetVitality()
      end
    end
  }
end

function module:open(options)
  self.super.open(self, options)
  self.bind.itemInfo_show = self.data.curitemId ~= nil and true or false
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
end

function module:close(options)
  self.super.close(self, options)
  self.data.curitemId = nil
  self.data.currentSelectNum = 0
  self.data.recoverPoint = 0
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet)
end

function module:refreshPet(petId)
  self:initPage(petId)
end

function module:onEvent_refreshPet(pet)
  if self.data.petId == pet.guid then
    self.data.currentSelectNum = 1
  end
end

function module:initPage(petId)
  self.data.petId = petId
  self.parent:initData(petId)
  local raw_data = {}
  for k, v in pairs(C_BagMgr:getAllItem()) do
    if string.sub(k, 1, 3) == tostring(404) and v.itemNum ~= 0 and v.itemId ~= 404007 then
      local cell = {
        itemType = L_Const.resType.commonItem,
        guid = v.itemId,
        callback = function()
          self.data.curitemId = v.itemId
          self:setItemListActive()
          self:refreshItemInfo()
        end,
        quality = L_ItemTplManager:getCommonItem(v.itemId).quality
      }
      table.insert(raw_data, cell)
    end
  end
  L_CommonUtil.multipleSortByKey(raw_data, {"-quality", "-guid"})
  self.bind.itemList:clear()
  self.bind.itemList:insert_array(raw_data)
end

function module:refreshItemInfo()
  local itemConf = L_ItemTplManager:getCommonItem(self.data.curitemId)
  local itemTpl = commonItemTpl:getTplById(self.data.curitemId)
  self.modules.moduleIcon:setGeneralContent(L_Const.resType.commonItem, self.data.curitemId)
  local quality = itemConf.quality
  local key = L_Const.qualityToKey[quality]
  local imgQuality = string.format("Page/BSCommon/tex_icon_iconbg_%s", key)
  local imgQualityTitle = string.format("Page/BSCommon/tex_item_tip_title_%s", key)
  self.bind.item_name = itemConf.name
  self.bind.item_quality = imgQuality
  self.bind.item_img_bg = imgQualityTitle
  self.bind.item_icon = itemConf.icon
  self.bind.desc = itemConf.desc
  self.bind.itemInfo_show = true
  self.bind.numBox_show = false
  self.bind.valueSlider_show = false
  self.bind.geneInfo_show = false
  self.data.currentSelectNum = 1
  local type = commonItemTpl:getType(itemTpl)
  self.data.itemType = type
  if type == 404 then
    self.bind.numBox_show = true
    self.bind.valueSlider_show = true
    local useFunction = commonItemTpl:getUseFunction(itemTpl)
    local recoverNum = useFunction[#useFunction]
    self.data.recoverPoint = recoverNum
    self:refreshPetVitality()
  elseif type == 406 then
    self.bind.geneInfo_show = true
    local useFunction = commonItemTpl:getUseFunction(itemTpl)
    local minRarity = useFunction[1]
    local maxRarity = useFunction[#useFunction]
    self:initPetGeneList(minRarity, maxRarity)
  else
    if type == 408 then
      self.bind.valueSlider_show = true
      local useFunction = commonItemTpl:getUseFunction(itemTpl)
      local reduceNum = useFunction[#useFunction]
      self:reducePetVitality(reduceNum)
    else
    end
  end
end

function module:clickGeneList(data)
  local skillData = {
    skillIcon = data.itemIcon,
    skillLevelShow = data.skillLevelShow,
    levelLabel = data.levelLabel,
    skillLv = data.skillLv,
    skillName = data.skillName,
    describe = data.describe,
    starLv = data.starLv ~= nil and data.starLv or 0,
    rarity = data.rarity ~= nil and data.rarity or 1
  }
  L_UI:open("pageShowPetSkill", {optionData = skillData})
end

function module:initPetGeneList(minRarity, maxRarity)
  local pet = L_PetStore:getPetItem(self.data.petId)
  self.bind.geneList:clear()
  local list = L_PetStore:getPetSkills(pet, true, true, false)
  local limitList = {}
  for i, v in pairs(list) do
    if maxRarity >= v.rarity and minRarity <= v.rarity and v.starLv < 4 then
      table.insert(limitList, v)
    end
  end
  self.bind.geneList:insert_array(limitList)
  self.bind.geneTips = 0 < #limitList and L_WordsTpl:getValue("ui_modulePetUseItem_01") or L_WordsTpl:getValue("ui_modulePetUseItem_02")
end

function module:refreshPetVitality()
  local recoverNum = self.data.recoverPoint
  local pet = L_PetStore:getPetItem(self.data.petId)
  local maxValue = tonumber(L_GameTpl:getGameConstTpl():getData("PET_MAXENERGY", L_Const.GameTplType.int))
  self.bind.currentSlider = pet.vitality / maxValue
  if maxValue <= self.data.currentSelectNum * recoverNum + pet.vitality then
    self.bind.addValueSlider = 1
    self.bind.addValue = "+" .. tostring(maxValue - pet.vitality)
  else
    self.bind.addValueSlider = (pet.vitality + self.data.currentSelectNum * recoverNum) / maxValue
    self.bind.addValue = "+" .. tostring(self.data.currentSelectNum * recoverNum)
  end
  self.bind.num_txt = tostring(self.data.currentSelectNum)
  self.bind.currentValue = tostring(pet.vitality)
  self.bind.maxValue = tostring(maxValue)
end

function module:reducePetVitality(reduceNum)
  local pet = L_PetStore:getPetItem(self.data.petId)
  local maxValue = tonumber(L_GameTpl:getGameConstTpl():getData("PET_MAXENERGY", L_Const.GameTplType.int))
  self.bind.addValueSlider = pet.vitality / maxValue
  if pet.vitality - reduceNum <= 0 then
    self.bind.currentSlider = 0
  else
    self.bind.currentSlider = (pet.vitality - reduceNum) / maxValue
  end
  self.bind.addValue = "-" .. tostring(reduceNum)
  self.bind.currentValue = tostring(pet.vitality)
  self.bind.maxValue = ""
end

function module:setItemListActive()
  for i, module in ipairs(self.modules.itemList) do
    module:setSelectNum(module.bind.guid == self.data.curitemId and 1 or 0)
  end
end

return module
