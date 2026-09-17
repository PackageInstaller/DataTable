local this = class("cellPetTipHomeLabor", G_UIModuleBase)
local moduleLaborDetailTips_Path = "UI/Pages/Pet/moduleLaborBuffDetailTips.prefab"
local moduleLaborDetailTips = "ui.pages.pet.labor.moduleLaborBuffDescDetailTab"
local _HomeTalentTpl = L_GameTpl:getHomeTalentTpl()
local _homeLaborTypeTpl = L_GameTpl:getHomeLaborTypeTpl()
local _homeLaborTrainTpl = L_GameTpl:getHomeLaborTarinTpl()
local _petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
local _petHomeSizeTpl = L_GameTpl:getPetHomeSizeTpl()
local _petAccessoryRarityProductTpl = L_GameTpl:getPetAccessoryRarityProductTpl()
local _petLaborAccessoryExtraTpl = L_GameTpl:getPetLaborAccessoryExtraTpl()
local _homeBuffTpl = L_GameTpl:getHomeBuffTpl()
local _homeLaborTrainConditionTpl = L_GameTpl:getHomeLaborTrainConditionTpl()
local _petLaborTrainExpTpl = L_GameTpl:getPetLaborTrainExpTpl()
local _homeLaborEfficiencyTpl = L_GameTpl:getHomeLaborEfficiencyTpl()
local StationBuildingType2LaborDescIndex = {
  [L_HomeConst.StationBuildingType.HomeBuilding] = 1,
  [L_HomeConst.StationBuildingType.Collection] = 2,
  [L_HomeConst.StationBuildingType.Ranch] = 3,
  [L_HomeConst.StationBuildingType.Crop] = 4
}
local levelText = {
  [1] = "I",
  [2] = "II",
  [3] = "III",
  [4] = "IV",
  [5] = "V"
}
local path_infoBg_petBox = {
  [1] = "UI/Pages/PetTalent/tex_pet_bg_tips_talent_b_infobg1.png",
  [2] = "UI/Pages/PetTalent/tex_pet_bg_tips_talent_p_infobg2.png",
  [3] = "UI/Pages/PetTalent/tex_pet_bg_tips_talent_y_infobg3.png"
}
local path_infoBg_station = {
  [1] = "UI/Pages/PetTalent/tex_pet_bg_tips_talent_infobg1.png",
  [2] = "UI/Pages/PetTalent/tex_pet_bg_tips_talent_infobg2.png",
  [3] = "UI/Pages/PetTalent/tex_pet_bg_tips_talent_infobg3.png"
}
local color_infoBg = {
  [1] = {
    line = L_Const.colorHtml.grey015,
    talentName = L_Const.colorHtml.blue001,
    talentDesc = L_Const.colorHtml.grey015
  },
  [2] = {
    line = L_Const.colorHtml.purple003,
    talentName = L_Const.colorHtml.purple004,
    talentDesc = L_Const.colorHtml.purple003
  },
  [3] = {
    line = L_Const.colorHtml.yellow004,
    talentName = L_Const.colorHtml.yellow020,
    talentDesc = L_Const.colorHtml.yellow004
  }
}
local path_starDesc = {
  [1] = "UI/Atlas/PetTalentObsolute/tex_pet_dec_tips_talent_infodec_fx1.png",
  [2] = "UI/Atlas/PetTalentObsolute/tex_pet_dec_tips_talent_infodec_fx2.png",
  [3] = "UI/Atlas/PetTalentObsolute/tex_pet_dec_tips_talent_infodec_fx3.png"
}
local path_talentIcon = {
  [1] = "UI/Atlas/PetTalentObsolute/tex_bg_talent_bg1.png",
  [2] = "UI/Atlas/PetTalentObsolute/tex_bg_talent_bg2.png",
  [3] = "UI/Atlas/PetTalentObsolute/tex_bg_talent_bg3.png"
}
local path_talentLight = {
  [1] = "UI/Atlas/PetTalentObsolute/tex_dec_talent_light1.png",
  [2] = "UI/Atlas/PetTalentObsolute/tex_dec_talent_light2.png",
  [3] = "UI/Atlas/PetTalentObsolute/tex_dec_talent_light3.png"
}

function this.bind()
  return {
    img_icon = "",
    txt_name = "",
    txt_curScore = "",
    slider_exp_value = 0,
    list_laborDesc = {
      moduleName = "pages/pet/labor/moduleLaborEntryTabList"
    },
    list_laborDesc_staton = {
      moduleName = "pages/pet/cellLaborDesc"
    },
    list_build = {
      moduleName = "pages/pet/new/cellPetLaborBuild"
    },
    active_list_build = true,
    go_infoBg = false,
    img_infoBg = "",
    img_starDes = "",
    img_talentIcon = "",
    img_talentTypeIcon = "",
    txt_talentLevel = "",
    color_talent_e = C_Color(1, 1, 1, 1),
    color_line = C_Color(1, 1, 1, 1),
    txt_talentName = "",
    color_talentName = C_Color(1, 1, 1, 1),
    img_light = "",
    color_talentDesc0 = C_Color(1, 1, 1, 1),
    txt_talentDesc = "",
    color_talentDesc = C_Color(1, 1, 1, 1),
    active_noTalentPart = false,
    size_root = C_Vector2(512, 182),
    activate_disableIcon = false,
    go_canAddExp = false,
    txt_canAddExp = "",
    txt_petSize = "",
    active_secondTip = false,
    txt_labor_tipTitle = "",
    txt_tipDesc1 = "",
    txt_tipDesc2 = "",
    txt_tipDesc3 = "",
    txt_tipDesc4 = "",
    txt_accessory_tipTitle = "",
    txt_tipDesc5 = ""
  }
end

function this.methods()
  return {
    onclick_help = function(self)
      self:emit("onclick_help", self.bindComponents)
    end,
    onClick_DetailTip = function(self)
      local isOpen = L_UI:checkPageOpen("pageTipBubble")
      if isOpen and self.bubbleInfoFlag then
        self.bubbleInfoFlag = false
        L_UI:close("pageTipBubble")
        return
      end
      self.bubbleInfoFlag = true
      local _data = {
        laborId = self.bind.laborId,
        laborGrade = self.bind.laborGrade,
        needLaborType = self.bind.needLaborType
      }
      local leng = math.empty
      leng = self.modules.list_laborDesc:getListCount() * 50 + 30
      L_UI:open("pageTipBubble", {
        data = {
          moduleLaborDetailTips_Path,
          moduleLaborDetailTips,
          _data,
          self.bindComponents.detailBtnRect,
          3,
          true,
          1,
          C_Vector2(226, leng),
          C_Vector2(0, 100),
          C_Vector3(15, 0, 0),
          nil,
          nil,
          nil,
          true,
          3
        }
      })
    end
  }
end

function this:open()
  if self.bind.isSelectCoolie then
    self.bind.go_desc = false
    self.active_list_build = false
  end
  local laborId = self.bind.laborId
  local laborGrade = self.bind.laborGrade
  local upperLaborGrade = self.bind.upperLaborGrade
  local petId = self.bind.petId
  local isStationEnter = self.bind.isStationEnter
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(laborId)
  local petHomeTalentTpl = _petHomeTalentTpl:getTplById(petId)
  local petSize = _petHomeTalentTpl:getSizeType(petHomeTalentTpl)
  local talentId = self.bind.talentId
  local isSelectCoolie = self.bind.isSelectCoolie
  self.bind.active_secondTip = false
  self.bind.img_icon = _homeLaborTypeTpl:getLaborIcon(homeLaborTypeTpl)
  self.bind.txt_name = _homeLaborTypeTpl:getLaborName(homeLaborTypeTpl)
  if self.bind.isPreview then
    self.bind.txt_curScore = "?"
  else
    self.bind.txt_curScore = string.format("%d", laborGrade)
  end
  local trainTpl = _homeLaborTrainTpl:getTplById(laborGrade)
  if trainTpl then
    local maxLaborExp = _homeLaborTrainTpl:getExp(trainTpl)
    local curLaborExp = 0
    if self.bind.laborExp then
      curLaborExp = self.bind.laborExp
    end
    self.bind.txt_curScore = string.format("%d", laborGrade)
    if laborGrade >= upperLaborGrade then
      self.bind.slider_exp_value = 1
    else
      local percent = math.clamp(curLaborExp / maxLaborExp)
      self.bind.slider_exp_value = math.lerp(0, 1, percent)
    end
  end
  if isStationEnter then
    local tmp = {}
    local funcNameList = _homeLaborTypeTpl:getLaborParameter(homeLaborTypeTpl)
    for i = 1, #_homeLaborTypeTpl:getLaborDescDetailList(homeLaborTypeTpl) do
      local descLangString = _homeLaborTypeTpl:getLaborDescDetailList(homeLaborTypeTpl)[i]
      if descLangString ~= nil and descLangString ~= " " and descLangString ~= "" then
        local buffValue = L_HomeBuffManager:getLaborBuffValueWithFunc(funcNameList[i], self.bind.laborGrade) / 10000
        local showBuffValue = buffValue * 100
        local showBuffValueIntPart = math.ceil(showBuffValue - showBuffValue % 1)
        local showBuffValue = showBuffValueIntPart
        local textOfBuffValue = showBuffValue .. "%"
        local descContent = L_Lang:get(descLangString, {
          [0] = textOfBuffValue
        })
        if not string.isEmpty(descContent) then
          table.insert(tmp, {txt_desc = descContent})
        end
      end
    end
    self.bind.list_laborDesc_staton:clear()
    self.bind.list_laborDesc_staton:insert_array(tmp)
  else
    self.modules.list_laborDesc:setTextData(homeLaborTypeTpl, self.bind.laborId, self.bind.needLaborType, self.bind.laborGrade)
  end
  self.bind.list_build:clear()
  if not isSelectCoolie then
    local buildingIconList = _homeLaborTypeTpl:getBuildingIconListByPetSize(homeLaborTypeTpl, petSize)
    local buildingNameList = _homeLaborTypeTpl:getBuildingNameListByPetSize(homeLaborTypeTpl, petSize)
    local tmp = {}
    for _, _ in pairs(buildingIconList) do
      table.insert(tmp, {})
    end
    self.bind.list_build:insert_array(tmp)
    for i = 1, #self.bind.list_build do
      local cellPetLaborBuild = self.bind.list_build:getItemCls(i)
      local params = {
        icon = buildingIconList[i],
        itemType = L_Const.resType.commonItem,
        itemId = 0,
        itemNum = buildingNameList[i]
      }
      cellPetLaborBuild:setCellIconBagShowParams(params)
    end
    local petHomeSizeTpl = _petHomeSizeTpl:getTplById(petSize)
    self.bind.txt_petSize = _petHomeSizeTpl:getSizeName(petHomeSizeTpl)
  end
  if talentId then
    self.bind.active_noTalentPart = false
    self.bind.go_infoBg = true
    local tpl = _HomeTalentTpl:getTplById(talentId)
    if self.bind.isSelectCoolie then
      self.bind.img_infoBg = path_infoBg_station[_HomeTalentTpl:getTalentLevel(tpl)]
    else
      self.bind.img_infoBg = path_infoBg_petBox[_HomeTalentTpl:getTalentLevel(tpl)]
    end
    self.bind.img_starDes = path_starDesc[_HomeTalentTpl:getTalentLevel(tpl)]
    self.bind.img_talentIcon = path_talentIcon[_HomeTalentTpl:getTalentLevel(tpl)]
    self.bind.img_talentTypeIcon = _HomeTalentTpl:getTypeIcon(tpl)
    self.bind.txt_talentLevel = levelText[_HomeTalentTpl:getTalentLevel(tpl)]
    self.bind.img_light = path_talentLight[_HomeTalentTpl:getTalentLevel(tpl)]
    local _, lineColor = C_ColorUtility.TryParseHtmlString(color_infoBg[_HomeTalentTpl:getTalentLevel(tpl)].talentName .. "80")
    self.bind.color_line = lineColor
    self.bind.txt_talentName = string.format("%s·%s", _HomeTalentTpl:getTalentName(tpl), levelText[_HomeTalentTpl:getTalentLevel(tpl)])
    local _, nameColor = C_ColorUtility.TryParseHtmlString(color_infoBg[_HomeTalentTpl:getTalentLevel(tpl)].talentName)
    self.bind.color_talentName = nameColor
    self.bind.txt_talentDesc = _HomeTalentTpl:getTalentDescription(tpl)
    local _, descColor0 = C_ColorUtility.TryParseHtmlString(color_infoBg[_HomeTalentTpl:getTalentLevel(tpl)].talentDesc .. "99")
    self.bind.color_talentDesc0 = descColor0
    local _, descColor = C_ColorUtility.TryParseHtmlString(color_infoBg[_HomeTalentTpl:getTalentLevel(tpl)].talentDesc)
    self.bind.color_talentDesc = descColor
    self.bind.color_talent_e = descColor
  else
    self.bind.go_infoBg = false
  end
  self.bind.size_root = C_Vector2(512, self.bindComponents.desc.preferredHeight + 102)
  local canAddExpTxt = self:getMinRarityDescByLaborGrade(self.bind.laborGrade, laborId)
  if self.bind.needLaborType and type(self.bind.needLaborType) == "table" then
    if 1 >= #self.bind.needLaborType and not string.isEmpty(canAddExpTxt) then
      self.bind.go_canAddExp = false
      self.bind.txt_canAddExp = canAddExpTxt
    end
  elseif not string.isEmpty(canAddExpTxt) then
    self.bind.go_canAddExp = false
    self.bind.txt_canAddExp = canAddExpTxt
  end
  self.bind.txt_labor_tipTitle = L_WordsTpl:getValue("ui_text_kibo_labor_title_1")
  self.bind.txt_tipDesc1 = L_WordsTpl:getValue("ui_text_kibo_labor_desc_1")
  self.bind.txt_tipDesc2 = L_WordsTpl:getValue("ui_text_kibo_labor_desc_2")
  self.bind.txt_tipDesc3 = L_WordsTpl:getValue("ui_text_kibo_labor_desc_3")
  self.bind.txt_tipDesc4 = L_WordsTpl:getValue("ui_text_kibo_labor_desc_4")
  self.bind.txt_accessory_tipTitle = L_WordsTpl:getValue("ui_text_kibo_labor_title_2")
  self.bind.txt_tipDesc5 = L_WordsTpl:getValue("ui_text_kibo_labor_desc_5")
  if self.bind.listenKey then
    self.onKeyEventHandle = self.onKeyEventHandle or handler(self, self.onListenKeyEvent)
    C_InputManager.AddKeyListener(self.bind.listenKey, self.onKeyEventHandle)
  end
end

function this:close()
  if self.bind.listenKey then
    C_InputManager.RemoveKeyListener(self.bind.listenKey, self.onKeyEventHandle)
  end
end

function this:getNoTalentDescText(index)
  local laborId
  if self.bind.needLaborType then
    if type(self.bind.needLaborType) == "table" then
      laborId = self.bind.needLaborType[1]
    else
      laborId = self.bind.needLaborType
    end
  else
    laborId = self.bind.laborId
  end
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(laborId)
  local noTalentDesc
  noTalentDesc = _homeLaborTypeTpl:getLaborDescDetailList(homeLaborTypeTpl)[index]
  local notEmptyDescDetailList = {}
  for _, descDetail in pairs(_homeLaborTypeTpl:getLaborDescDetailList(homeLaborTypeTpl)) do
    if descDetail ~= nil and descDetail ~= " " and descDetail ~= "" then
      table.insert(notEmptyDescDetailList, descDetail)
    end
  end
  local buffIdIndex
  for i, notEmptyDescDetail in pairs(notEmptyDescDetailList) do
    if notEmptyDescDetail == noTalentDesc then
      buffIdIndex = i
      break
    end
  end
  local buffId = _homeLaborTypeTpl:getHomeBuffIdList(homeLaborTypeTpl)[buffIdIndex or 1]
  if buffId == nil then
    buffId = _homeLaborTypeTpl:getHomeBuffIdList(homeLaborTypeTpl)[1]
  end
  local homeBuffTpl = _homeBuffTpl:getTplById(buffId)
  local buffValueType = _homeBuffTpl:getType(homeBuffTpl)
  local buffValue = L_HomeBuffManager:getLaborBuffValue(laborId, self.bind.laborGrade, buffId)
  buffValue = 10000 / (10000 - buffValue) - 1
  local textOfBuffValue
  if buffValueType == L_HomeConst.buffValueType.PERCENT then
    local showBuffValue = buffValue * 100
    local showBuffValueIntPart = math.ceil(showBuffValue - showBuffValue % 1)
    local showBuffValueFloatPart = showBuffValue % 1
    local showBuffValue = showBuffValueIntPart
    textOfBuffValue = showBuffValue .. "%"
  else
    local showBuffValue = buffValue
    local showBuffValueIntPart = math.ceil(showBuffValue - showBuffValue % 1)
    local showBuffValueFloatPart = showBuffValue % 1
    local showBuffValue = showBuffValueIntPart
    textOfBuffValue = tostring(showBuffValue)
  end
  if buffId == 2015 then
    textOfBuffValue = _petAccessoryRarityProductTpl:getMaxRarityDescByLaborScore(self.bind.laborGrade)
    local canMakeDesc = _homeLaborTypeTpl:getBuffCanMakeDesc(homeLaborTypeTpl, buffId)
    if self.bind.needLaborType and #self.bind.needLaborType > 1 then
      return string.empty
    end
    return L_Lang:get(noTalentDesc, {
      [0] = textOfBuffValue,
      [1] = canMakeDesc
    })
  end
  if buffId == 2016 then
    local homeBuffTpl = _homeBuffTpl:getTplById(buffId)
    local buffDesc = _homeBuffTpl:getBuffDescription(homeBuffTpl)
    local canMakeDesc = _homeLaborTypeTpl:getBuffCanMakeDesc(homeLaborTypeTpl, buffId)
    local buffValue = _petLaborAccessoryExtraTpl:getGoldRarityDescByLaborScore(self.bind.laborGrade, canMakeDesc)
    if self.bind.needLaborType and #self.bind.needLaborType > 1 then
      return string.empty
    end
    if string.isEmpty(buffValue) then
      return string.empty
    end
    return L_Lang:get(not string.isEmpty(buffDesc) and buffDesc or "{0}", {
      [0] = buffValue
    })
  end
  return L_Lang:get(noTalentDesc, {
    [0] = textOfBuffValue
  })
end

function this:getMinRarityDescByLaborGrade(laborGrade, laborId)
  local minRarity
  local homeLaborTrainConditionTpl = _homeLaborTrainConditionTpl:getTplById(laborId)
  if homeLaborTrainConditionTpl == nil then
    return string.empty
  end
  for _, rarity in ipairs(L_Const.qualityList) do
    local exp = _petLaborTrainExpTpl:getExpByScoreAndRarity(laborGrade, rarity)
    if exp ~= 0 then
      minRarity = rarity
      break
    end
  end
  if not minRarity then
    return string.empty
  end
  local rarityTpl = L_RarityTpl:getTplById(minRarity)
  local color = L_Const.colorHtml[L_RarityTpl:getEquipmentColorAst(rarityTpl)]
  local rarityDescNoColor = L_RarityTpl:getRarityName(rarityTpl)
  local rarityDesc = L_GameUtil.fillColor(rarityDescNoColor, color)
  local desc = _homeLaborTrainConditionTpl:getDesc(homeLaborTrainConditionTpl)
  local showDesc = L_Lang:get(desc, {
    [0] = rarityDesc
  })
  return showDesc or string.empty
end

function this:onListenKeyEvent(isPress)
  if not isPress then
    return
  end
  self.methods.onclick_help(self)
end

return this
