local this = class("moduleBattlePetCatchBonusTipDetail", require("ui.pages.pet.new.moduleBattlePetCatchBonusTip"))
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _petCatchItemTpl = L_GameTpl:getPetCatchItemTpl()

function this.bind()
  return {
    active_tip = false,
    active_catch_rate_title = true,
    active_catch_rate_info = true,
    module_rate_title = {
      moduleName = "pages/pet/new/moduleBattlePetCatchRateTitle"
    },
    module_petBox_rating = {
      moduleName = "pages/pet/new/modulePetBoxRating"
    },
    txt_base_catch_rate = "",
    txt_card = "",
    list_catch_rate_info = {
      moduleName = "pages/pet/new/cellBattlePetCatchDetailRate"
    },
    list_petTipsGene = {
      moduleName = "pages/pet/new/cellPetTipsGene"
    },
    list_petCatchBonueIcon = {
      moduleName = "pages/battle/cellPetCatchBonueIcon"
    },
    txt_name = "",
    txt_level = "",
    active_catch_line1 = true,
    active_catch_line2 = true,
    active_catch_line3 = true,
    active_recommand = false,
    active_catch_TitleA = false,
    active_catch_InfoA = false,
    active_btn_Info = false,
    active_prompt = false,
    txt_prompt_level = ""
  }
end

function this.methods()
  return {
    onClick_btn = function(self)
      self:emit("onClick")
    end
  }
end

function this:updateInfos(baseShowValue, infos)
  self:initIndexParams()
  local recommandIndexEnum = {
    baseShowValue = 0,
    hp = 1,
    graph = 2,
    lv = 3
  }
  local base2Recommend = {
    [self.indexEnum.baseShowValue] = recommandIndexEnum.baseShowValue,
    [self.indexEnum.hp] = recommandIndexEnum.hp,
    [self.indexEnum.graph] = recommandIndexEnum.graph
  }
  local recommandList = self.monsterEntity.entity.data.catchProperty:GetCatchRateBaseContribution(self.monsterEntity.entity.data)
  local posY = 0
  self.bind.active_recommand = false
  posY = -14.5
  local localPos = self.bindComponents.rect_starLinktitle.localPosition
  self.bindComponents.rect_starLinktitle:SetLocalPosition(localPos.x, posY, localPos.z)
  local tempMaps = {}
  for index, info in ipairs(infos) do
    local recommandIndex = base2Recommend[info.petCatchRateIndex]
    if recommandIndex ~= nil then
      local recommandValue = recommandList:GetFloat(recommandIndex)
      if 0.4 <= recommandValue then
        info.recommand = true
      end
    end
    if self._rateInfoMaps and not self._rateInfoMaps[info.petCatchRateIndex] then
      info.isNew = true
    else
      info.isNew = false
    end
    tempMaps[info.petCatchRateIndex] = true
  end
  self._rateInfoMaps = tempMaps
  self:showBaseValue(baseShowValue)
  self:showInfoList(infos)
end

function this:open()
  this.super.open(self)
  self.bind.active_btn_Info = L_DeviceTpl:getIsPc()
  self.bind.list_catch_rate_info:clear()
  self.bind.list_catch_rate_info:insert_array(L_DataUtil.getEmptyModuleDatas(5))
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.catchRateInfo)
end

function this:playScanAnim()
  if self.bind.active_tip then
    self.bindComponents.anim_Board:Play("anim_scan_tips_large_fresh")
  end
end

function this:showInfoList(infos)
  local count = #infos
  self.bind.active_catch_line1 = 4 < count
  self.bind.active_catch_line2 = 4 < count
  self.bind.active_catch_line3 = 3 < count
  if count > #self.modules.list_catch_rate_info then
    self.bind.list_catch_rate_info:clear()
    self.bind.list_catch_rate_info:insert_array(infos)
  else
    for i, _module in ipairs(self.modules.list_catch_rate_info) do
      _module:refreshInfo(infos[i])
    end
  end
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.catchRateInfo)
end

return this
