local this = class("modulePetBoxRating", G_UIModuleBase)
local petGradeTpl = L_GameTpl:getPetGradeTpl()
local commonItemTpl = L_GameTpl:getCommonItemTpl()
local GETPETBG = {
  [1] = "UI/Atlas/PetGet/tex_kibogain_icon_pf_ef.png",
  [2] = "UI/Atlas/PetGet/tex_kibogain_icon_pf_ef.png",
  [3] = "UI/Atlas/PetGet/tex_kibogain_icon_pf_cd.png",
  [4] = "UI/Atlas/PetGet/tex_kibogain_icon_pf_cd.png",
  [5] = "UI/Atlas/PetGet/tex_kibogain_icon_pf_ab.png",
  [6] = "UI/Atlas/PetGet/tex_kibogain_icon_pf_ab.png",
  [7] = "UI/Atlas/PetGet/tex_kibogain_icon_pf_s.png",
  [8] = "UI/Atlas/PetGet/tex_kibogain_icon_pf_ss.png",
  [9] = "UI/Atlas/PetGet/tex_kibogain_icon_pf_sss.png"
}

function this.bind()
  return {
    gradeBar = true,
    gradeBg = "",
    txt_grade_top = "",
    txt_grade_normal = "",
    icon_grade_rank = "",
    toggle_isTop = false,
    txt_scan_lavel = ""
  }
end

function this:setGuid(guid, isGetPet)
  local grade, gradeRank = L_PetStore:getPetGradeNew(guid)
  self.grade = grade
  local gradeTpl = petGradeTpl:getTplById(gradeRank)
  self.bind.gradeBg = isGetPet and GETPETBG[gradeRank] or petGradeTpl:getGradeBackground(gradeTpl)
  self.bind.icon_grade_rank = petGradeTpl:getGradeScore(gradeTpl)
  self.bind.txt_grade_top = tostring(grade)
  self.bind.txt_grade_normal = tostring(grade)
  self.bind.toggle_isTop = gradeRank == #petGradeTpl:getAllData()
  self.bindComponents.Img_icon_rating:SetNativeSize()
end

function this:setScanLevel(scanId)
  local tpl = commonItemTpl:getTplById(scanId)
  self.bind.txt_scan_lavel = string.format(commonItemTpl:getName(tpl))
end

function this:setGrade(grade, petRank, petRare)
  self.bind.gradeBar = true
  self.grade = grade
  local gradeRank = L_PetStore:calGradeRank(grade, petRank, petRare)
  local gradeTpl = petGradeTpl:getTplById(gradeRank)
  self.bind.gradeBg = petGradeTpl:getGradeBackground(gradeTpl)
  self.bind.icon_grade_rank = petGradeTpl:getGradeScore(gradeTpl)
  self.bind.txt_grade_top = tostring(grade)
  self.bind.txt_grade_normal = tostring(grade)
  self.bind.toggle_isTop = gradeRank == #petGradeTpl:getAllData()
  self.bindComponents.Img_icon_rating:SetNativeSize()
end

function this:setLockGrade(rank)
  self.bind.gradeBar = true
  local gradeTpl = petGradeTpl:getTplById(rank)
  self.bind.gradeBg = petGradeTpl:getGradeBackground(gradeTpl)
  self.bind.icon_grade_rank = petGradeTpl:getGradeScore(gradeTpl)
  self.bind.txt_grade_top = "???"
  self.bind.txt_grade_normal = "???"
  self.bind.toggle_isTop = false
  self.bindComponents.Img_icon_rating:SetNativeSize()
end

function this:setLockGradeAndRank()
  self.bind.gradeBar = false
end

local function playFxGo(fx)
  if fx == nil or fx.gameObject == nil then
    return
  end
  fx.gameObject:SetActive(false)
  fx.gameObject:SetActive(true)
end

function this:playLevelUpFx(isMaxLv)
  if not self.bindComponents or not self.bindComponents.fx_levelup then
    return
  end
  playFxGo(self.bindComponents.fx_levelup)
end

function this:playAnim()
  L_TimerManager:newOrResetTimer(self, "Qibo_Score", function()
    L_AudioUtil.playSound("Play_SFX_System_HUD_General_Reward_Qibo_Score")
  end, 0.2)
  self.bind.txt_grade_top = "0"
  self.bind.txt_grade_normal = "0"
  self.timerGradeValue = Timer.once(0.1, function()
    local function getter()
      return 0
    end
    
    local function setter(r)
      self.bind.txt_grade_top = L_HeroManager:addComma(math.floor(r))
      self.bind.txt_grade_normal = L_HeroManager:addComma(math.floor(r))
    end
    
    self._doTween = DOTween.To(getter, setter, self.grade, 0.83)
    self._doTween:SetEase(Tweening.Ease.OutCubic)
  end, self, self.gameObject)
end

function this:show()
  if not self.bindComponents then
    return
  end
  if self.bindComponents.fx_levelup then
    self.bindComponents.fx_levelup.gameObject:SetActive(false)
  end
end

function this:close()
  if L_CommonUtil.isValid(self._doTween) then
    self._doTween:Kill()
    self._doTween = nil
  end
  if self.timerGradeValue then
    Timer.remove(self.timerGradeValue)
    self.timerGradeValue = nil
  end
  L_TimerManager:clearTimer(self)
end

return this
