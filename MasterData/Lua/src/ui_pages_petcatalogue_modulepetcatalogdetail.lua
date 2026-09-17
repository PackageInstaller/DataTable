local this = class("modulePetCatalogDetail", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()
local _petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
local _homeTalentTpl = L_GameTpl:getHomeTalentTpl()
local _mountTpl = L_GameTpl:getMountTpl()
local _petRaceTpl = L_GameTpl:getPetRaceTpl()
local _iconographyLevelTpl = L_GameTpl:getIconographyLevelTpl()
local _iconographyTypeTpl = L_GameTpl:getIconographyTypeTpl()
local _battleTpl = L_GameTpl:getBattleInfoTpl()
local _elementTpl = L_GameTpl:getElementTypeTpl()
local _unitTpl = L_GameTpl:getUnitTpl()
local C_TDPetHomeTalentTable = CS.Azur.Gameplay.Table.TDPetHomeTalentTable
local PETSCENEPATH = "Program/UIScene/petCatalogScene.prefab"
local PETGETBLACKPATH = "Program/UIScene/pre_KiboCatalogAddBlack.prefab"
local BGNORMAL = "UI/Texture/PetCatalog/tex_petillustrative_bg_15.png"
local BGFULL = "UI/Texture/PetCatalog/tex_petillustrative_bg_16.png"
local PETFEATURESKILLPATH = "UI/Pages/PetBox/modulePetFeatureSkillTagTips.prefab"
local MODULEPETFEATURESKILLTAGTIPS = "ui.pages.pet.new.modulePetFeatureSkillTagTips"
local PETSKILLPATH = "UI/Pages/PetBox/modulePetSkillTagTips.prefab"
local MODULEPETSKILLTAGTIPS = "ui.pages.pet.new.modulePetSkillTagTips"
local PETTALENTPATH = "UI/Pages/PetBox/modulePetTalentTagTips.prefab"
local MODULEPETTALENTTAGTIPS = "ui.pages.pet.new.modulePetTalentTagTips"
local colorNml = "#9BAABD"
local colorFull = "#BFA98E"
local mountType = {
  [1] = L_WordsTpl:getValue("ui_modulePetCatalogDetail_01"),
  [2] = L_WordsTpl:getValue("ui_modulePetCatalogDetail_02"),
  [3] = L_WordsTpl:getValue("ui_modulePetCatalogDetail_03"),
  [4] = L_WordsTpl:getValue("ui_modulePetCatalogDetail_04"),
  [5] = L_WordsTpl:getValue("ui_modulePetCatalogDetail_08"),
  [6] = L_WordsTpl:getValue("ui_modulePetCatalogDetail_09")
}
local PageTipBubbleOffsetDic = {
  baseSkill = C_Vector3(-75, 0, 0),
  baseFeather = C_Vector3(-50, 0, 0),
  skill = C_Vector3(70, 0, 0),
  feather = C_Vector3(127, 0, 0),
  skillCount = 0,
  featherCount = 0
}
local petCatalogParam = L_GameConstTpl:getData("KIBO_HANDBOOK_PETROOT_SCALE_PARAM", L_Const.GameTplType.list_int)
local starColorId = 0

function this:ctor(...)
  this.super.ctor(self, ...)
  self._is3D = true
end

function this.bind()
  return {
    activeMask = false,
    petSceneActive = true,
    modulePetCard = {
      moduleName = "pages/pet/new/modulePetCard"
    },
    petCardActive = false,
    active_flashNone = true,
    active_flashSelect = false,
    color_flash = C_Color(0.7411765, 0.7921569, 0.7764706, 1),
    active_specialSelect = true,
    color_special = C_Color(0.7411765, 0.7921569, 0.7764706, 1),
    list_specialIndex = {
      moduleName = "pages/petCatalogue/cellCatalogSpecial"
    },
    txtIs3D = "2D",
    active_btnSpecial = true,
    active_btnFlash = true,
    modulePetStarColor = {
      moduleName = "pages/petCatalogue/modulePetStarColorGroup"
    },
    active_hasTask = true,
    active_noTask = false,
    obtainActive = false,
    unObtainActive = false,
    txtPetIndex = "",
    txtPetName = "",
    modulePetTags = {
      moduleName = "pages/pet/new/modulePetNewSimpleTags"
    },
    list_homeTalent = {
      moduleName = "pages/petCatalogue/cellCatalogTalent"
    },
    list_attrTag = {
      moduleName = "pages/pet/new/cellNewTagItem"
    },
    active_mountType = true,
    active_bg2 = false,
    list_mountType = {
      moduleName = "pages/pet/new/cellPetMoveType"
    },
    list_drop = {
      moduleName = "pages/petCatalogue/cellPetDrop"
    },
    txtPetRace = "",
    txtPetStage = "",
    txtPetSize = "",
    txtPetDesc = "",
    list_skill = {
      moduleName = "pages/petCatalogue/cellPetCatalogSkill"
    },
    img_taskLevel = "",
    txtTaskLevel = "",
    txtLevelTip = "",
    sliderLevelExpValue = 0,
    active_lockTip = true,
    txtLockTip = "",
    listReward = {
      moduleName = "pages/petCatalogue/cellPetTaskRewardTag"
    },
    color_itemTitle = C_Color(1, 1, 1, 1),
    color_lineTitle = C_Color(1, 1, 1, 1),
    listTaskItem = {
      moduleName = "pages/petCatalogue/cellCatalogTaskItem"
    },
    redDotActive = false,
    taskBorderBg = "",
    txtRewardActive = true,
    txtFullActive = false,
    colorTip = C_Color(1, 1, 1),
    colorTask = C_Color(1, 1, 1),
    titleNmlActive = true,
    titleFullActive = false,
    txtFull = "",
    txtFullReward = L_Lang:get(L_WordsTpl:getValue("ui_iconography_upgrade")),
    txtTaskTitle = "",
    txtNoTaskTip = L_Lang:get(L_WordsTpl:getValue("ui_kibo_iconography_no_task")),
    modulePetReportInfo = {
      moduleName = "pages/petCatalogue/modulePetReportInfo"
    }
  }
end

function this.methods()
  return {
    onClickFlash = function(self)
      self._isFlash = not self._isFlash
      self.bind.active_flashSelect = self._isFlash
      self.bind.active_flashNone = not self._isFlash
      if self._isFlash then
        self.bind.color_flash = C_Color(1, 1, 1, 1)
        local _, topColor = C_ColorUtility.TryParseHtmlString("#DCD9C6")
        local _, bottomColor = C_ColorUtility.TryParseHtmlString("#FBDF9A")
        self.bindComponents.flashTxt:SetColorGradient(topColor, topColor, bottomColor, bottomColor)
      else
        self.bind.color_flash = C_Color(0.7411765, 0.7921569, 0.7764706, 1)
        local _, topColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
        local _, bottomColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
        self.bindComponents.flashTxt:SetColorGradient(topColor, topColor, bottomColor, bottomColor)
      end
      self:set3DMode()
    end,
    onClickSpecial = function(self)
      local tpl = _petTpl:getTplById(self._petId)
      local unitId = _petTpl:getUnitID(tpl)
      local specialParms = _unitTpl:getSpecialParm(_unitTpl:getTplById(unitId))
      if table.isEmpty(specialParms) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_iconography_not_have_special"))
        return
      end
      self:refreshBtnSpecial()
    end,
    list_specialIndex = {
      onClick_specialIndex = function(self, id)
        if self.selectSpecialId == id then
          return
        end
        self:refreshSpecialIndexSelect(id)
        self:set3DMode()
        self:setDetailInfo()
      end
    },
    onClickModel = function(self)
      self:clickSwitchShowModel()
    end,
    onClickTaskPreview = function(self)
      L_CatalogStore:setNotTask(self._petId)
      self.parent:refreshTaskRedDot()
      L_UI:open("pagePetCatalogReward", {
        petId = self._petId
      })
    end,
    onClickFeatherInfo = function(self)
      local isOpen = L_UI:checkPageOpen("pageTipBubble")
      if isOpen and self.featherInfoFlag then
        self.featherInfoFlag = false
        L_UI:close("pageTipBubble")
        return
      end
      self:setTipBubbleClose()
      self.featherInfoFlag = true
      local params = {
        pointTo = 2,
        borderDistance = C_Vector2(30, 27),
        transSize = C_Vector2(100, 10),
        offset = PageTipBubbleOffsetDic.baseFeather + PageTipBubbleOffsetDic.feather * PageTipBubbleOffsetDic.featherCount
      }
      L_UI:open("pageTipBubble", {
        data = {
          PETFEATURESKILLPATH,
          MODULEPETFEATURESKILLTAGTIPS,
          self._petId,
          self.bindComponents.rectFeatherInfo,
          params.pointTo,
          true,
          1,
          params.borderDistance,
          params.transSize,
          params.offset
        }
      })
    end,
    onClickSkillInfo = function(self)
      local isOpen = L_UI:checkPageOpen("pageTipBubble")
      if isOpen and self.skillInfoFlag then
        self.skillInfoFlag = false
        L_UI:close("pageTipBubble")
        return
      end
      self:setTipBubbleClose()
      self.skillInfoFlag = true
      local params = {
        pointTo = 2,
        borderDistance = C_Vector2(30, 27),
        transSize = C_Vector2(150, 10),
        offset = PageTipBubbleOffsetDic.baseSkill + PageTipBubbleOffsetDic.skill * PageTipBubbleOffsetDic.skillCount
      }
      L_UI:open("pageTipBubble", {
        data = {
          PETSKILLPATH,
          MODULEPETSKILLTAGTIPS,
          self._petId,
          self.bindComponents.rectSkillInfo,
          params.pointTo,
          true,
          1,
          params.borderDistance,
          params.transSize,
          params.offset
        }
      })
    end,
    onClickTalentInfo = function(self)
      local isOpen = L_UI:checkPageOpen("pageTipBubble")
      if isOpen and self.talentInfoFlag then
        L_UI:close("pageTipBubble")
        self.talentInfoFlag = false
        return
      end
      self:setTipBubbleClose()
      self.talentInfoFlag = true
      local params = {
        pointTo = 2,
        borderDistance = C_Vector2(30, 27),
        transSize = C_Vector2(100, 10)
      }
      local C_TDPetHomeTalent = C_TDPetHomeTalentTable.GetData(self._petId)
      local C_LaborConfigInfoList = C_TDPetHomeTalent:GetLaborConfigInfoList()
      if C_LaborConfigInfoList.Count == 0 then
        return
      end
      L_UI:open("pageTipBubble", {
        data = {
          PETTALENTPATH,
          MODULEPETTALENTTAGTIPS,
          self._petId,
          self.bindComponents.rectTalentInfo,
          params.pointTo,
          true,
          1,
          params.borderDistance,
          params.transSize
        }
      })
    end,
    onClickMask = function(self)
      self.modules.modulePetStarColor:setOptionActive(false)
      self:tryHideSpecialList()
    end
  }
end

function this:open()
  self.bind.txtTaskTitle = L_WordsTpl:getValue("ui_iconography_kibo_mission")
  self:refreshCurSpecialId(0)
end

function this:close(options)
  this.super.close(self, options)
  if self.petHandle then
    L_ResPool:destroyGo(self.petHandle)
    self.petHandle = nil
  end
  if L_CommonUtil.isValid(self.petGo) then
    C_GameObject.Destroy(self.petGo)
  end
  if L_CommonUtil.isValid(self.petFlashObj) then
    C_GameObject.Destroy(self.petFlashObj)
  end
  self:stopFlashSound()
end

function this:setSceneGo(go)
  self.sceneGo = go
end

function this:initSpecialIndexList(petId)
  self._isSpecial = false
  self._isFlash = false
  if self.bindComponents.ani_flashSelect then
    self.bindComponents.ani_flashSelect:Play("anim_petcatalogdeta_init")
  end
  local tpl = _petTpl:getTplById(petId)
  local unitId = _petTpl:getUnitID(tpl)
  local unitTpl = _unitTpl:getTplById(unitId)
  if not unitTpl then
    C_MJLog.LogError("UnitTpl is nil. unitId = " .. unitId)
    return
  end
  local specialParms = _unitTpl:getSpecialParm(unitTpl)
  self.specialIndexTmp = {}
  local hasUnlock = false
  local colors = table.empty
  local petInfo = L_CatalogStore:getPetCatalogByPetId(petId)
  if petInfo and petInfo.colors then
    colors = petInfo.colors
  end
  for i, param in pairs(specialParms) do
    local isLock = true
    if table.indexOf(colors, i) then
      isLock = false
      hasUnlock = true
    end
    table.insert(self.specialIndexTmp, {
      id = i,
      active_select = false,
      active_lock = isLock,
      active_default = false,
      active_index = not isLock,
      txt_index = L_Const.Number2Roma[i]
    })
  end
  if hasUnlock then
    table.insert(self.specialIndexTmp, 1, {
      id = 0,
      active_select = false,
      active_lock = false,
      active_default = true,
      active_index = false
    })
  end
  self.bind.list_specialIndex:clear()
  self.bind.list_specialIndex:insert_array(self.specialIndexTmp)
end

function this:tryHideSpecialList()
  if self._isSpecial then
    self:refreshBtnSpecial()
  end
end

function this:refreshBtnSpecial()
  self._isSpecial = not self._isSpecial
  self:setMaskActive(self._isSpecial, 2)
  if self.bindComponents.ani_flashSelect then
    self.bindComponents.ani_flashSelect:Play(self._isSpecial and "anim_petcatalogdeta_in" or "anim_petcatalogdeta_out")
    if self._isSpecial then
      for i, v in pairs(self.modules.list_specialIndex) do
        v:playInAni()
      end
    end
  end
  if self._isSpecial then
    self.bind.color_special = C_Color(1, 1, 1, 1)
    local _, topColor = C_ColorUtility.TryParseHtmlString("#CBFADF")
    local _, bottomColor = C_ColorUtility.TryParseHtmlString("#9BD1F8")
    self.bindComponents.specialTxt:SetColorGradient(topColor, topColor, bottomColor, bottomColor)
  else
    self.bind.color_special = C_Color(0.7411765, 0.7921569, 0.7764706, 1)
    local _, topColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
    local _, bottomColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
    self.bindComponents.specialTxt:SetColorGradient(topColor, topColor, bottomColor, bottomColor)
  end
end

function this:showPet(petId, isForceRefresh)
  print("@@@ set petId: " .. petId)
  if isForceRefresh then
    starColorId = 0
    self:refreshCurSpecialId(0)
  end
  self._petId = petId
  self:initSpecialIndexList(self._petId)
  self.bind.active_flashSelect = self._isFlash
  self.bind.active_flashNone = not self._isFlash
  self.bind.color_flash = C_Color(0.7411765, 0.7921569, 0.7764706, 1)
  local _, topColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
  local _, bottomColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
  self.bindComponents.flashTxt:SetColorGradient(topColor, topColor, bottomColor, bottomColor)
  self.bind.color_special = C_Color(0.7411765, 0.7921569, 0.7764706, 1)
  _, topColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
  _, bottomColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
  self.bindComponents.specialTxt:SetColorGradient(topColor, topColor, bottomColor, bottomColor)
  local isGet = L_CatalogStore:isGetPet(petId)
  if isGet then
    self.bind.obtainActive = true
    self.bind.unObtainActive = false
    self:set3DMode(isForceRefresh)
    self:setDetailInfo()
    self:setTaskInfo()
    self:refreshRedDot()
  else
    self:refreshBlackPet(petId)
    self.bind.obtainActive = false
    self.bind.unObtainActive = true
  end
end

function this:refreshRedDot()
  self.bind.redDotActive = L_CatalogStore:checkCanGetReward()
end

function this:clickSwitchShowModel()
  self._is3D = not self._is3D
  if self._is3D then
    self.bind.txtIs3D = "2D"
  else
    self.bind.txtIs3D = "3D"
  end
  self:set3DMode()
end

function this:set3DMode(isForceRefresh)
  if self._is3D then
    self.bind.petCardActive = false
    self:removePet()
    if isForceRefresh then
      self:setPet(self._petId, false, false)
    else
      self:setPet(self._petId, self.selectSpecialId > 0, self._isFlash)
    end
  else
    self.bind.petCardActive = true
    self:removePet()
    print("@@@ " .. tostring(self.petHandle == nil))
    if isForceRefresh then
      self:stopFlashSound()
      self.modules.modulePetCard:setPidWithAnim(self._petId, 0, false)
      self:refreshSpecialIndexSelect(0)
    else
      if not self._isFlash then
        self:stopFlashSound()
      elseif not L_CommonUtil.isValid(self.flashSound) then
        self:playFlashSound()
      end
      self.modules.modulePetCard:setPidWithAnim(self._petId, self.selectSpecialId, self._isFlash)
      self:refreshSpecialIndexSelect(self.selectSpecialId)
    end
    self.modules.modulePetCard:setInitRdy()
  end
end

function this:setTipBubbleClose()
  self.featherInfoFlag = false
  self.skillInfoFlag = false
  self.talentInfoFlag = false
end

function this:setDetailInfo()
  local petData = _petTpl:getTplById(self._petId)
  self.bind.txtPetIndex = tostring(petData.iconographyNum) .. petData.iconographyNumSuffix
  self.bind.txtPetName = _petTpl:getName(petData, self.selectSpecialId > 0 and 1 or 0)
  local isVIPPet = 0 < string.len(petData.iconographyNumSuffix)
  local params = {
    pointTo = 2,
    borderDistance = C_Vector2(30, 27),
    transSize = C_Vector2(100, 10)
  }
  self.modules.modulePetTags:setConfigId(self._petId, true, params)
  local C_TDPetHomeTalent = C_TDPetHomeTalentTable.GetData(self._petId)
  local lTalent = {}
  if not TableIsNull(C_TDPetHomeTalent) then
    local C_LaborConfigInfoList = C_TDPetHomeTalent:GetLaborConfigInfoList()
    for i = 0, C_LaborConfigInfoList.Count - 1 do
      local C_LaborConfigInfo = C_LaborConfigInfoList[i]
      table.insert(lTalent, {
        id = C_LaborConfigInfo.laborTypeId
      })
    end
  end
  self.bind.list_homeTalent:clear()
  self.bind.list_homeTalent:insert_array(lTalent)
  local petHomeTalentTpl = _petHomeTalentTpl:getTplById(self._petId)
  local petSize = _petHomeTalentTpl:getSizeType(petHomeTalentTpl)
  self.bind.list_attrTag:clear()
  local tagData = {}
  local kiboFeatureSkill = L_PetManager:getFPropertySkillList(self._petId)
  PageTipBubbleOffsetDic.featherCount = 0
  for i, v in ipairs(kiboFeatureSkill) do
    table.insert(tagData, {
      type = i % 3 == 0 and 3 or i % 3,
      label = string.format("%s", v.skillName)
    })
    PageTipBubbleOffsetDic.featherCount = PageTipBubbleOffsetDic.featherCount + 1
  end
  if 0 < PageTipBubbleOffsetDic.featherCount then
    PageTipBubbleOffsetDic.featherCount = PageTipBubbleOffsetDic.featherCount - 1
  end
  self.bind.list_attrTag:insert_array(tagData)
  self.bind.list_mountType:clear()
  local tmp = {}
  local tpl_mount = _mountTpl:getTplById(self._petId)
  if tpl_mount then
    local moveType = _mountTpl:getMoveType(tpl_mount)
    if moveType then
      for i, v in pairs(moveType) do
        table.insert(tmp, {
          moveType = v,
          img_icon = string.format("UI/Atlas/PetSaddle/tex_petsaddle_icon_%s.png", v),
          txt_moveType = mountType[v]
        })
      end
    end
  end
  self.bind.active_mountType = 0 < #tmp
  self.bind.active_bg2 = 0 < #tmp
  self.bind.list_mountType:insert_array(tmp)
  local dropItem = {}
  self.bind.list_drop:clear()
  for _, id in ipairs(petData.iconographyDrop) do
    table.insert(dropItem, {id = id})
  end
  self.bind.list_drop:insert_array(dropItem)
  local stage = _petTpl:getPetStage(petData)
  self.bind.txtPetStage = L_GameTpl:getWordsTpl():getTplById("ui_pet_stage" .. stage)
  local race = _petTpl:getRace(petData)
  local txt_race = ""
  for i = 1, #race do
    local raceTpl = _petRaceTpl:getTplById(race[i])
    if i == 1 then
      txt_race = _petRaceTpl:getRaceType(raceTpl)
    else
      txt_race = string.format("%s·%s", txt_race, _petRaceTpl:getRaceType(raceTpl))
    end
  end
  self.bind.txtPetRace = txt_race
  local size = _petTpl:getSize(petData)
  if math.isEmpty(size) then
    self.bind.txtPetSize = "???"
  else
    local integer, float = math.modf(tonumber(string.format("%.1f", size / 10000)))
    if float == 0 then
      self.bind.txtPetSize = string.format("%dcm", integer)
    else
      self.bind.txtPetSize = string.format("%.1fcm", size / 10000)
    end
  end
  self.bind.txtPetDesc = _petTpl:getDesc(petData)
  local skillList = _petTpl:getSignatureSkillList(petData)
  local sList = {}
  PageTipBubbleOffsetDic.skillCount = 0
  for _, skill in ipairs(skillList) do
    table.insert(sList, {
      id = skill[2],
      ele = _petTpl:getFirstElement(petData)
    })
    PageTipBubbleOffsetDic.skillCount = PageTipBubbleOffsetDic.skillCount + 1
  end
  if 0 < PageTipBubbleOffsetDic.skillCount then
    PageTipBubbleOffsetDic.skillCount = PageTipBubbleOffsetDic.skillCount - 1
  end
  self.bind.list_skill:clear()
  self.bind.list_skill:insert_array(sList)
  if isVIPPet then
    self.bind.active_btnSpecial = false
    self.bind.active_btnFlash = false
  else
    self.bind.active_btnSpecial = true
    self.bind.active_btnFlash = true
  end
  self.modules.modulePetStarColor:setPetColorList(self._petId)
  self.modules.modulePetReportInfo:setReportInfo(self._petId)
end

function this:setTaskInfo()
  local petData = _petTpl:getTplById(self._petId)
  local isVIPPet = string.len(petData.iconographyNumSuffix) > 0
  print("@@@ setTaskInfo, petId = " .. tostring(self._petId))
  if isVIPPet then
    self.bind.active_hasTask = false
    self.bind.active_noTask = true
    return
  end
  self.bind.active_hasTask = true
  self.bind.active_noTask = false
  local petCatalogData = L_CatalogStore:getPetCatalogByPetId(self._petId) or {}
  local taskLevel = petCatalogData.lv or 1
  print("@@@ taskLevel = " .. taskLevel)
  local tpl = L_GameTpl:getIconographyLevelTpl():getTplByLvPetId(taskLevel, self._petId)
  local nextTpl = tpl
  self.bind.img_taskLevel = tpl.iconparticulars or "PetCatalog/tex_petillustrative_icon_dw1"
  self.bind.txtTaskLevel = _iconographyLevelTpl:getText(tpl)
  self.bind.txtFull = _iconographyLevelTpl:getText(tpl)
  if taskLevel == 10 then
    self.bind.txtLevelTip = L_WordsTpl:getValue("ui_modulePetCatalogDetail_05")
    self.bind.sliderLevelExpValue = 1
    self.bind.taskBorderBg = BGFULL
    self.bind.titleNmlActive = false
    self.bind.titleFullActive = true
    self.bind.colorTip = C_LuaUtility.ParseHtmlStringColor(colorFull)
    self.bind.txtRewardActive = false
    self.bind.txtFullActive = true
    self.bind.color_itemTitle = C_Color(0.7490196, 0.6627451, 0.5568628, 1)
    self.bind.color_lineTitle = C_Color(0.854902, 0.7686275, 0.6666667, 1)
    self.bind.listReward:clear()
  else
    nextTpl = L_GameTpl:getIconographyLevelTpl():getTplByLvPetId(taskLevel + 1, self._petId)
    local curExp = petCatalogData.exp or 0
    local nextExp = tpl.exp
    self.bind.txtLevelTip = L_WordsTpl:getValue("ui_modulePetCatalogDetail_06", {
      [0] = curExp,
      [1] = nextExp
    })
    self.bind.sliderLevelExpValue = curExp / tpl.exp
    self.bind.taskBorderBg = BGNORMAL
    self.bind.titleNmlActive = true
    self.bind.titleFullActive = false
    self.bind.colorTip = C_LuaUtility.ParseHtmlStringColor(colorNml)
    self.bind.txtRewardActive = true
    self.bind.txtFullActive = false
    self.bind.color_itemTitle = C_Color(0.6078432, 0.6666667, 0.7411765, 1)
    self.bind.color_lineTitle = C_Color(0.7686275, 0.8078431, 0.8352941, 1)
    local rewardInfo = L_DataUtil.parseRewardConfig(nextTpl.reward)
    self.bind.listReward:clear()
    self.bind.listReward:insert_array(rewardInfo)
  end
  if taskLevel == L_GameTpl:getGameConstTpl():getData("ICONOGRAPHYLEVEL_UNLOCK_HABITAT", L_Const.GameTplType.int) - 1 then
    self.bind.active_lockTip = true
    self.bind.txtLockTip = L_WordsTpl:getValue("ui_modulePetCatalogDetail_07")
  else
    self.bind.active_lockTip = false
    self.bind.txtLockTip = ""
  end
  local tasks = {}
  local taskGroup = _petTpl:getTplById(self._petId).iconographyTaskId
  print("@@@ petId = " .. self._petId)
  for i = 1, #taskGroup do
    local taskId = taskGroup[i]
    local taskCnt = 0
    local isComplete = false
    if petCatalogData.tasks and petCatalogData.tasks[i] then
      taskId = petCatalogData.tasks[i].task_id or taskGroup[i]
      taskCnt = petCatalogData.tasks[i].count or 0
      isComplete = petCatalogData.tasks[i].complete
    end
    table.insert(tasks, {
      idx = i,
      taskId = taskId,
      taskCnt = taskCnt,
      isComplete = isComplete
    })
    print("@@@ taskId = " .. taskId)
  end
  local taskCount = #tasks
  print("@@@ # = " .. taskCount)
  self.bind.listTaskItem:clear()
  self.bind.listTaskItem:insert_array(tasks)
  local singleHeight = self.bindComponents.rectCellTaskItem.sizeDelta.y
  local spacing = self.bindComponents.verticalGroupTaskItem.spacing
  local totalHeight = singleHeight * taskCount + spacing * (taskCount - 1)
  local maxHeight = self.bindComponents.rectScrollTaskItem.sizeDelta.y
  self.bindComponents.tableViewTaskItem.disableScroll = totalHeight <= maxHeight
end

function this:refreshBlackPet(petId)
  local function setPetCallback()
    self:setBlackOnPetLoaded()
    
    if self.entity and self.entity.biologyData then
      self.entity.biologyData:RemoveAllPartUpdateListener(setPetCallback)
    end
  end
  
  self:removePet()
  self:setPet(petId, false, false, true, true, setPetCallback)
end

function this:_setPetBlackColor(blackObj, color)
  local effectMaterialHelper = blackObj.transform:GetComponent(typeof(CS.EffectMaterialHelper))
  local EffectAutoMultiColCom = blackObj.transform:GetComponent(typeof(CS.EffectAutoMultiCol))
  local material = effectMaterialHelper.insMaterial
  material:SetColor("_IB_Color", color)
  local percent = 1 - color.a
  EffectAutoMultiColCom.effectMultiColor = C_Color(percent, percent, percent, 1)
  EffectAutoMultiColCom.isCullingBodyEffectMesh = true
  EffectAutoMultiColCom:RefreshMat()
  local cullings = effectMaterialHelper.curllings
end

function this:setPet(petId, isSpecial, isFlash, banAnim, isBlack, callback)
  self:stopFlashSound()
  if math.isEmpty(petId) then
    self:removePet()
    return
  end
  local tpl = _petTpl:getTplById(petId)
  local unitId = _petTpl:getUnitID(tpl)
  local petPath = L_GameUtil.getAvatarModelPathByUnitId(unitId, L_Const.avatarModelIndex.UnitModel)
  if isSpecial then
    local specialParms = _unitTpl:getSpecialParm(_unitTpl:getTplById(unitId))
    if not table.isEmpty(specialParms) then
      local replaceStr = specialParms[self.selectSpecialId]
      if replaceStr then
        petPath = string.gsub(petPath, ".prefab", "_" .. replaceStr .. ".prefab")
      end
    end
    self:refreshSpecialIndexSelect(self.selectSpecialId)
  else
    self:refreshSpecialIndexSelect()
  end
  if self.petHandle then
    L_ResPool:destroyGo(self.petHandle)
    self.petHandle = nil
  end
  self.petHandle = L_ResPool:asyncGameObject(petPath, function(id, go)
    local petGo = go
    self.petGo = petGo
    self.curPetGoId = petId
    petGo.name = string.concat("pet_", petId)
    if self.entity then
      self.entity:onDestroy()
      self.entity = nil
    end
    
    local function callbackSetFlash(...)
      self:_setPetFlashEft(isFlash, self.petGo)
      if self.entity and self.entity.biologyData then
        self.entity.biologyData:RemoveAllPartUpdateListener(callbackSetFlash)
      end
    end
    
    self.entity = L_EntityManager:generatePreviewPet(petId, petGo, nil, nil, callback, callbackSetFlash, C_EEntityEntranceType.PetCatalog)
    local animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), petGo)
    if not banAnim then
      animator.enabled = true
      animator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
      animator.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
      animator.rootMotionController.selfApplyRootMotion = true
      self.entity.playableAnimator:Play("Idle")
    else
    end
    self:setSceneBind()
    petGo.transform:SetParent(self.modelRoot)
    local detailTpl = _petTpl:getTplById(petId)
    local all_stage_scale = _petTpl:getUnitScale(detailTpl) or 10000
    local unitTpl = _unitTpl:getTplById(unitId)
    local worldScale = _unitTpl:getModelScale(unitTpl)
    local scale = all_stage_scale / 10000
    local bodyType = _petTpl:getBodyType(detailTpl)
    petCatalogParam = L_GameConstTpl:getData("KIBO_HANDBOOK_PETROOT_SCALE_PARAM", L_Const.GameTplType.list_int)
    local pageScale = petCatalogParam[bodyType] / 10000
    L_Vector3.setSize(petGo.transform, worldScale * scale * pageScale)
    local position = _petTpl:getIconographyPosition(detailTpl)
    if table.isEmpty(position) then
      L_Vector3.setLocalPos(petGo.transform, L_Vector3.zero)
    else
      L_Vector3.setLocalPos(petGo.transform, L_Vector3.new(position[1], position[2], position[3]))
    end
    L_Vector3.setLocalRot(petGo.transform, L_Vector3.new(3, 50, 0))
    local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), petGo)
    if biologyData then
      biologyData:SetStarColor(starColorId)
    end
    if isBlack then
      self:setBlackOnPetLoaded()
    end
    if self.parent and self.parent.onPetLoaded then
      self.parent:onPetLoaded()
    end
  end)
end

function this:setSceneBind()
  if not L_CommonUtil.isValid(self.modelRoot) and self.sceneGo then
    self.modelRoot = self.sceneGo.transform:Find("ModelRoot")
  else
    return
  end
  if not self.shadowRoot then
    self.shadowRoot = self.modelRoot.transform:Find("shadow")
  end
  local script = self.modelRoot:GetComponent(typeof(CS.Lens.Gameplay.UI.CharacterAnchorFit))
  if L_CommonUtil.isValid(script) then
    script:SetBindObject(self.bindComponents.SceneRect)
  end
end

function this:setBlackOnPetLoaded()
  if L_CommonUtil.isValid(self.blackObj) then
    C_GameObject.Destroy(self.blackObj)
    self.blackObj = nil
  end
  local blackObj = L_ResPool:syncGameObject(PETGETBLACKPATH)
  blackObj.transform:Reset(self.petGo.transform)
  blackObj.transform.localScale = L_Vector3.one
  blackObj.transform.localPosition = C_UIMgr.SceneLoadDefaultPosition
  blackObj.name = "blackRoot"
  self.blackObj = blackObj
  local EffectMaterialHelperCom = self.blackObj.transform:GetComponent(typeof(CS.EffectMaterialHelper))
  if EffectMaterialHelperCom then
    EffectMaterialHelperCom.characterRoot = self.petGo
  end
  local EffectAutoMultiColCom = self.blackObj.transform:GetComponent(typeof(CS.EffectAutoMultiCol))
  if EffectAutoMultiColCom then
    EffectAutoMultiColCom.characterRoot = self.petGo
    EffectAutoMultiColCom.isCullingBodyEffectMesh = true
  end
  self.blackObj:SetActive(false)
  self.blackObj:SetActive(true)
  self:_setPetBlackColor(self.blackObj, C_Color(0, 0, 0, 1))
  if self.parent and self.parent.onPetLoaded then
    self.parent:onPetLoaded()
  end
end

function this:removePet()
  if self.entity then
    self.entity:onDestroy()
    self.entity = nil
  end
  if self.petHandle then
    L_ResPool:destroyGo(self.petHandle)
    self.petHandle = nil
  end
  if L_CommonUtil.isValid(self.petGo) then
    C_GameObject.Destroy(self.petGo)
    self.petGo = nil
  end
end

function this:_setPetFlashEft(isFlash, petObj)
  if not isFlash then
    if L_CommonUtil.isValid(self.petFlashObj) then
      L_CommonUtil.setObjActive(self.petFlashObj, false)
      self.petFlashObj.transform:SetParent(self.modelRoot)
    end
    return
  end
  local obj
  if L_CommonUtil.isValid(self.petFlashObj) then
    obj = self.petFlashObj
  else
    local mediaPackTpl = L_GameTpl:getMediaPackTplTpl()
    local petFlashKey = L_GameTpl:getGameConstTpl():getData("PET_FLASH_EFFECT_PATH_PAGE", L_Const.GameTplType.string)
    local path = mediaPackTpl:getPath(mediaPackTpl:getTplByKey(petFlashKey))
    obj = L_ResPool:syncGameObject(path)
  end
  local EffectMaterialHelperCom = obj.transform:GetComponentInChildren(typeof(CS.EffectMaterialHelper))
  if EffectMaterialHelperCom then
    EffectMaterialHelperCom.characterRoot = petObj
  end
  local ImmuneBuffHelperCom = obj.transform:GetComponentInChildren(typeof(CS.ImmuneBuffHelper))
  if ImmuneBuffHelperCom then
    ImmuneBuffHelperCom.characterRoot = petObj
  end
  local BindMeshEffectCom = obj.transform:GetComponentInChildren(typeof(CS.Lens.Gameplay.Modules.BigWorld.BindMeshEffect))
  if BindMeshEffectCom then
    BindMeshEffectCom:BindMeshBody(petObj)
  end
  obj.transform:SetParent(petObj.transform)
  L_CommonUtil.setObjActive(obj, false)
  L_CommonUtil.setObjActive(obj, true)
  L_Vector3.setLocalPos(obj.transform, L_Vector3.zero)
  L_Vector3.setLocalRot(obj.transform, L_Vector3.zero)
  L_Vector3.setSize(obj.transform, 1)
  self:playFlashSound()
  self.petFlashObj = obj
end

function this:refreshSpecialIndexSelect(selectId)
  self:refreshCurSpecialId(selectId or 0)
  if 0 < self.selectSpecialId and 0 < starColorId then
    starColorId = 0
    self.modules.modulePetStarColor:setCurColor(0)
  end
  for _, v in pairs(self.modules.list_specialIndex) do
    v:refreshSelect(self.selectSpecialId)
  end
end

function this:refreshCurSpecialId(selectId)
  self.selectSpecialId = selectId
  self.bind.active_specialSelect = 0 < selectId
end

function this:setStarColorId(colorId)
  starColorId = colorId
  if 0 < starColorId and 0 < self.selectSpecialId then
    self:refreshCurSpecialId(0)
  end
  if self._is3D then
    self:set3DMode()
  else
    self:clickSwitchShowModel()
  end
end

function this:playFlashSound()
  self.flashSound = C_AudioManager.Play("Play_SFX_CREAT_Common_FX_Shining_System")
end

function this:stopFlashSound()
  if L_CommonUtil.isValid(self.flashSound) then
    C_AudioManager.FreeSource(self.flashSound)
    self.flashSound = nil
  end
end

function this:hide()
  self:CloseFlash(false)
end

function this:show()
  if self._isFlash then
    self:playFlashSound()
  else
    self:stopFlashSound()
  end
  L_CatalogStore:listenCallFunc(L_CatalogStore.event.getCatalogReward, self.onEvent_getCatalogReward, self)
end

function this:CloseFlash(flash)
  self._isFlash = flash
  self:stopFlashSound()
  self.bind.active_flashSelect = self._isFlash
  self.bind.active_flashNone = not self._isFlash
  self.bind.color_flash = C_Color(0.7411765, 0.7921569, 0.7764706, 1)
  local _, topColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
  local _, bottomColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
  self.bindComponents.flashTxt:SetColorGradient(topColor, topColor, bottomColor, bottomColor)
  self:set3DMode()
end

function this:onEvent_getCatalogReward()
  self:refreshRedDot()
end

function this:setMaskActive(active, targetType)
  self.bind.activeMask = active
  if active then
    if targetType == 1 then
      self:tryHideSpecialList()
    elseif targetType == 2 then
      self.modules.modulePetStarColor:refreshSelfActive(false)
    end
  end
end

return this
