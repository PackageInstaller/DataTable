local this = class("modulePetGameplayStatus", G_UIModuleBase)
local _homeLaborCapacityTpl = L_GameTpl:getHomeLaborCapacityTpl()
local petTpl = L_GameTpl:getPetTpl()
local Color = {
  [L_Const.PetState.PET_WORKING] = C_Color(0.7764706, 0.4196078, 0.4627451, 1),
  [L_Const.PetState.PET_RESTING] = C_Color(0.7764706, 0.4196078, 0.4627451, 1),
  [L_Const.PetState.PET_HUB] = C_Color(0.2, 0.6862745, 0.5764706, 1),
  [L_Const.PetState.PET_ROULETTE] = C_Color(0.4352941, 0.4470588, 0.682353, 1),
  [L_Const.PetState.PET_HERO] = C_Color(0.3294117, 0.6705882, 0.6039215, 1),
  Place = C_Color(0.2, 0.6862745, 0.5764706, 1),
  Special = C_Color(0.9529411, 0.5686275, 0.1176471, 1),
  curWork = C_Color(0.2, 0.6862745, 0.5764706, 1),
  curPlace = C_Color(0.2, 0.6862745, 0.5764706, 1),
  curMount = C_Color(0.2, 0.6862745, 0.5764706, 1),
  inCanteen = C_Color(0.7764706, 0.4196078, 0.4627451, 1)
}
local NameHome = {
  [L_Const.PetState.PET_WORKING] = L_WordsTpl:getValue("notice_qibo_mutex_working"),
  [L_Const.PetState.PET_RESTING] = L_WordsTpl:getValue("notice_qibo_mutex_rest"),
  [L_Const.PetState.PET_HUB] = L_WordsTpl:getValue("ui_cellFastProductQueue_02"),
  [L_Const.PetState.PET_ROULETTE] = L_WordsTpl:getValue("notice_qibo_mutex_mount"),
  [L_Const.PetState.PET_HERO] = L_WordsTpl:getValue("notice_qibo_mutex_hero"),
  Place = L_WordsTpl:getValue("notice_qibo_mutex_ranch"),
  Special = L_WordsTpl:getValue("notice_qibo_mutex_special"),
  curWork = L_WordsTpl:getValue("notice_qibo_current_rest"),
  curPlace = L_WordsTpl:getValue("notice_qibo_current_ranch"),
  curMount = L_WordsTpl:getValue("notice_qibo_current_mount"),
  inCanteen = L_WordsTpl:getValue("notice_qibo_mutex_rest")
}
local NameHome_e = {
  [L_Const.PetState.PET_WORKING] = "art_working",
  [L_Const.PetState.PET_RESTING] = "art_resting",
  [L_Const.PetState.PET_HUB] = "art_idle",
  [L_Const.PetState.PET_ROULETTE] = "art_riding",
  [L_Const.PetState.PET_HERO] = "art_hero",
  Place = "art_placing",
  Special = "art_special",
  curWork = "art_cur_working",
  curPlace = "art_cur_place",
  curMount = "art_cur_riding",
  InCanteen = "art_canteen"
}
local IconHome = {
  [L_Const.PetState.PET_ROULETTE] = "UI/Atlas/PetBox/tex_pet_icon_ing_ride.png",
  [L_Const.PetState.PET_HERO] = "UI/Atlas/PetBox/tex_objectreturn_icon_xd_temp.png",
  [L_Const.PetState.PET_HUB] = "UI/Atlas/HomeLaborItem/tex_icon_homesift_mine1.png",
  Special = "UI/Atlas/PetBox/tex_objectreturn_icon_qb_temp.png",
  curMount = "UI/Atlas/PetBox/tex_pet_icon_ing_ride.png",
  InCanteen = "UI/Atlas/HomeLaborItem/tex_icon_homesift_shitang1.png"
}
local Name = {
  [L_Const.PetState.PET_WORKING] = L_WordsTpl:getValue("notice_qibo_mutex_home"),
  [L_Const.PetState.PET_RESTING] = L_WordsTpl:getValue("notice_qibo_mutex_home"),
  [L_Const.PetState.PET_HUB] = L_WordsTpl:getValue("notice_qibo_mutex_home"),
  [L_Const.PetState.PET_ROULETTE] = L_WordsTpl:getValue("notice_qibo_mutex_mount"),
  [L_Const.PetState.PET_HERO] = L_WordsTpl:getValue("notice_qibo_mutex_hero"),
  Place = L_WordsTpl:getValue("notice_qibo_mutex_home"),
  Special = L_WordsTpl:getValue("notice_qibo_mutex_special"),
  curWork = L_WordsTpl:getValue("notice_qibo_mutex_home"),
  curPlace = L_WordsTpl:getValue("notice_qibo_mutex_home"),
  curMount = L_WordsTpl:getValue("notice_qibo_current_mount"),
  inCanteen = L_WordsTpl:getValue("notice_qibo_mutex_rest")
}
local Name_e = {
  [L_Const.PetState.PET_WORKING] = "art_working",
  [L_Const.PetState.PET_RESTING] = "art_working",
  [L_Const.PetState.PET_HUB] = "art_working",
  [L_Const.PetState.PET_ROULETTE] = "art_riding",
  [L_Const.PetState.PET_HERO] = "art_hero",
  Place = "art_placing",
  Special = "art_special",
  curWork = "art_cur_working",
  curPlace = "art_cur_working",
  curMount = "art_cur_riding",
  InCanteen = "art_cur_working"
}
local Icon = {
  [L_Const.PetState.PET_ROULETTE] = "UI/Atlas/PetLabor_Icon/tex_pet_icon_state_3.png",
  [L_Const.PetState.PET_HERO] = "UI/Atlas/PetLabor_Icon/tex_pet_icon_state_4.png",
  [L_Const.PetState.PET_RESTING] = "UI/Atlas/PetLabor_Icon/tex_pet_icon_state_1.png",
  [L_Const.PetState.PET_HUB] = "UI/Atlas/PetLabor_Icon/tex_pet_icon_state_1.png",
  Special = "UI/Atlas/PetLabor_Icon/tex_pet_icon_state_2.png",
  curMount = "UI/Atlas/PetLabor_Icon/tex_pet_icon_state_3.png",
  InCanteen = "UI/Atlas/HomeLaborItem/tex_icon_homesift_shitang1.png"
}

function this.bind()
  return {
    go_content = false,
    txt_name = nil,
    txt_name_e = nil,
    img_icon = nil,
    active_icon = false,
    img_work = false,
    color_bg = nil,
    img_work_txt_desc = false
  }
end

function this.methods()
  return {}
end

function this:setData(guid, isPetPlaceRanch, onlyShowHammer, isHome)
  local nameTable = isHome and NameHome or Name
  local nameETable = isHome and NameHome_e or Name_e
  local iconTable = isHome and IconHome or Icon
  local pet = L_PetStore:getPetItem(guid)
  local gameplayStatus = pet:getGameplayStatus()
  local needShow = gameplayStatus ~= L_Const.PetState.PET_NORMAL and gameplayStatus ~= L_Const.PetState.PET_HERO
  self.bind.go_content = needShow
  self.bind.img_work_txt_desc = needShow
  if needShow then
    if pet.capacity_id == 6002 and gameplayStatus == L_Const.PetState.PET_RESTING then
      self.bind.txt_name = nameTable.Place
      self.bind.txt_name_e = nameETable.Place
      self.bind.color_bg = Color.Place
    else
      self.bind.txt_name = nameTable[gameplayStatus]
      self.bind.txt_name_e = nameETable[gameplayStatus]
      self.bind.color_bg = Color[gameplayStatus]
    end
    self.bind.active_icon = true
    if isHome and gameplayStatus == L_Const.PetState.PET_WORKING then
      self.bind.img_work = true
      if onlyShowHammer then
        self.bind.active_icon = false
      elseif pet:isInCanteen() then
        self.bind.img_icon = iconTable.InCanteen
      else
        local tpl_capacity = _homeLaborCapacityTpl:getTplById(pet.capacity_id)
        if tpl_capacity then
          local icon = _homeLaborCapacityTpl:getIconLight(tpl_capacity)
          self.bind.img_icon = icon
        else
          errorf("" .. pet.guid .. L_WordsTpl:getValue("residual_code_modulepetgameplaystatus_01") .. pet.work_status .. L_WordsTpl:getValue("residual_code_modulepetgameplaystatus_02") .. pet.work_build .. " capacity_id:" .. pet.capacity_id)
        end
      end
    else
      self.bind.img_work = false
      if isHome and (gameplayStatus == L_Const.PetState.PET_HUB or gameplayStatus == L_Const.PetState.PET_RESTING) then
        self.bind.active_icon = false
        self.bind.img_icon = ""
      else
        self.bind.img_icon = iconTable[gameplayStatus]
      end
    end
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_modulePetGameplayStatus)
  end
end

function this:setPetReleaseData(guid)
  local gameplayStatus = L_Const.PetState.PET_NORMAL
  local pet = L_PetStore:getPetItem(guid)
  if pet then
    local tpl = petTpl:getTplById(pet.id)
    if not petTpl:getIsRelease(tpl) then
      gameplayStatus = "Special"
    else
      gameplayStatus = pet:getGameplayStatus()
    end
  end
  local needShow = gameplayStatus ~= L_Const.PetState.PET_NORMAL
  self:setContentShow(needShow)
  self.bind.img_work_txt_desc = needShow
  if needShow then
    self.bind.active_icon = true
    self.bind.txt_name = Name[gameplayStatus]
    self.bind.txt_name_e = Name_e[gameplayStatus]
    self.bind.img_icon = Icon[gameplayStatus]
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_modulePetGameplayStatus)
  end
end

function this:setContentShow(show)
  if show then
    self:setFadeIn()
  else
    self:setFadeOut()
  end
end

function this:setCurSelectForPlace()
  self.bind.txt_name = NameHome.curPlace
  self.bind.txt_name_e = NameHome_e.curPlace
  self.bind.color_bg = Color.curPlace
end

function this:setCurSelectForWorking(isPetPlaceRanch)
  if isPetPlaceRanch then
    self.bind.txt_name = NameHome.curWork
    self.bind.txt_name_e = NameHome_e.curWork
    self.bind.color_bg = Color.curWork
    self.bind.active_icon = true
  else
    self.bind.txt_name = NameHome.curPlace
    self.bind.txt_name_e = NameHome_e.curPlace
    self.bind.color_bg = Color.curPlace
    self.bind.active_icon = true
  end
end

function this:setCurSelectForMount()
  self.bind.txt_name = Name.curMount
  self.bind.txt_name_e = Name_e.curMount
  self.bind.color_bg = Color.curMount
  self.bind.img_icon = Icon.curMount
end

function this:setIsShow(isShow)
  self.bind.go_content = isShow
end

function this:setFadeIn()
  self.isFadeOut = false
  self.bind.go_content = true
  L_TimerManager:stopTimer(self, "delayHide")
  if self.bindComponents and self.bindComponents.animation then
    self.bindComponents.animation:Play("anim_modulePetGameplayStatus_FadeIn")
  end
end

function this:setFadeOut()
  if self.isFadeOut then
    return
  end
  self.isFadeOut = true
  if self.bindComponents and self.bindComponents.animation then
    self.bindComponents.animation:Play("anim_modulePetGameplayStatus_FadeOut")
  end
  L_TimerManager:newOrResetTimer(self, "delayHide", function()
    self.isFadeOut = false
    self.bind.go_content = false
  end, self.bindValue.timeFadeOut)
end

return this
