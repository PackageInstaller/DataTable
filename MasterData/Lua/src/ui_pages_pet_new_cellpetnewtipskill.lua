local this = class("cellPetNewTipSkill", G_UIModuleBase)
local SKILLBORDERICON = {
  [0] = "#828282",
  [1] = "#fb7675",
  [2] = "#fd9c47",
  [3] = "#e5b933",
  [4] = "#5dca95",
  [5] = "#47cdc9",
  [6] = "#16d0ff",
  [7] = "#708bff",
  [8] = "#e2ca2a",
  [9] = "#9a76f5"
}
local dmgTypeIcon = {
  [0] = "UI/Atlas/PetBox/tex_petget_tag_icon_01",
  [1] = "UI/Atlas/PetBox/tex_petget_tag_icon_01",
  [2] = "UI/Atlas/PetBox/tex_petget_tag_icon_01",
  [3] = "UI/Atlas/PetBox/tex_petget_tag_icon_01",
  [4] = "UI/Atlas/PetBox/tex_petget_tag_icon_02"
}
local dmgInfoBgColor = {
  [0] = "#E9aa60",
  [1] = "#E9aa60",
  [2] = "#E9aa60",
  [3] = "#E9aa60",
  [4] = "#E29073"
}
local nameTxtColor = {
  [0] = "#4f525d",
  [1] = "#76777d"
}
local bgColorStr = "#E1E1E1"
local bannerColorStr = "#ffffff"
local mainSkillIconColor = "#51B6E5"
local _skillLevelTpl = L_GameTpl:getSkillLevelTpl()

function this.bind()
  return {
    img_bgColor = C_Color(1, 1, 1, 1),
    img_icon = "",
    img_lv = "",
    txt_name = "",
    txt_desc = "",
    txt_cd = "",
    skillBgColor = C_Color(0.5, 0.5, 0.5, 1),
    go_cd = false,
    go_dmgInfo = false,
    img_dmgType = "",
    txt_dmgValue = "",
    img_dmgInfoColor = C_Color(1, 1, 1, 1),
    go_skillTypeNormal = false,
    go_skillTypeSpecial = false,
    txt_skillTypeNormal = "",
    color_Name = C_Color(1, 1, 1, 1),
    color_Desc = C_Color(1, 1, 1, 1),
    color_mask = C_Color(1, 1, 1, 0.4),
    color_banner = C_Color(1, 1, 1, 0.8),
    active_skillBg = false
  }
end

function this:refresh()
end

function this:open()
  self:refreshInfos()
end

function this:close()
  self.cacheSkillBgColorIndex = nil
end

function this:refreshInfos()
  if not self.bind.kiboInfo then
    if self.bind.skillElement ~= nil then
      self.bind.skillBgColor = C_LuaUtility.ParseHtmlStringColor(SKILLBORDERICON[self.bind.skillElement[1]])
    end
    self:SetMainSkillBg()
    local isKboProperty = not self.bind.isKiboFProperty
    self.bind.go_cd = isKboProperty
    self.bind.go_skillTypeNormal = isKboProperty
    self.bind.go_skillTypeSpecial = isKboProperty
    return
  end
  local info = self.bind.kiboInfo
  self.bind.img_icon = info.itemIcon
  self.bind.img_lv = string.gsub(info.skillLv, "Lv.", "")
  self.bind.txt_name = info.skillName
  self.bind.txt_desc = info.describe
  local elementInfo = info.skillElement
  local skillBgColorIndex
  if elementInfo ~= nil and elementInfo[1] ~= nil then
    skillBgColorIndex = elementInfo[1]
  else
    skillBgColorIndex = 0
  end
  if self.cacheSkillBgColorIndex == nil or self.cacheSkillBgColorIndex ~= skillBgColorIndex then
    self.cacheSkillBgColorIndex = skillBgColorIndex
    local skillBgColor = C_LuaUtility.ParseHtmlStringColor(SKILLBORDERICON[skillBgColorIndex])
    self.bind.skillBgColor = skillBgColor
  end
  self.bind.skillSlot = info.skillSlot
  self.bind.skillLevelTpl = info.skillLevelTpl
  local showDmgInfo = info.skillPower ~= nil and info.skillPower ~= ""
  self.bind.go_dmgInfo = showDmgInfo
  if showDmgInfo then
    self.bind.txt_dmgValue = tostring(info.skillPower)
    if info.skillPowerName ~= nil then
      self.bind.go_dmgInfo = true
      self.bind.img_dmgInfoColor = C_LuaUtility.ParseHtmlStringColor(dmgInfoBgColor[info.skillPowerName])
      self.bind.img_dmgType = dmgTypeIcon[info.skillPowerName]
    else
      self.bind.go_dmgInfo = false
    end
  end
  local isKboProperty = not self.bind.isKiboFProperty
  self.bind.go_cd = isKboProperty
  if isKboProperty then
    self.bind.txt_cd = L_WordsTpl:getValue("menu_skill_coolDownTime", {
      [0] = math.floor(info.skillCd / 1000)
    })
    self.bind.go_skillTypeNormal = true
    self.bind.go_skillTypeSpecial = false
    self.bind.txt_skillTypeNormal = info.name
  else
    self.bind.go_skillTypeNormal = false
    self.bind.go_skillTypeSpecial = true
  end
  self:SetMainSkillBg()
end

function this:setKiboInfo(kiboInfo, isKiboFProperty)
  if kiboInfo then
    self.bind.kiboInfo = kiboInfo
  end
  if isKiboFProperty then
    self.bind.isKiboFProperty = isKiboFProperty
  end
  self:refreshInfos()
end

function this:SetMainSkillBg()
  local bgColor = C_LuaUtility.ParseHtmlStringColor(bgColorStr)
  local bannerColor = C_LuaUtility.ParseHtmlStringColor(bannerColorStr)
  local petSpecialSkill = L_GameConstTpl:getData("PET_SIGNATURESKILLLIST", L_Const.GameTplType.int)
  if self.bind.skillSlot == petSpecialSkill then
    local colorInfo
    local info = self.bind.kiboInfo
    local elementInfo = info and info.skillElement
    if elementInfo ~= nil and elementInfo[1] ~= nil then
      colorInfo = C_LuaUtility.ParseHtmlStringColor(SKILLBORDERICON[elementInfo[1]])
    else
      colorInfo = C_LuaUtility.ParseHtmlStringColor(SKILLBORDERICON[0])
    end
    colorInfo.a = 0.4
    self.bind.color_mask = colorInfo
    self.bind.color_Name = C_LuaUtility.ParseHtmlStringColor(nameTxtColor[0])
    self.bind.color_Desc = C_LuaUtility.ParseHtmlStringColor(nameTxtColor[0])
    bannerColor.a = 0.8
    bgColor.a = 0.5
    self.bind.active_skillBg = true
  else
    self.bind.color_Name = C_LuaUtility.ParseHtmlStringColor(nameTxtColor[1])
    self.bind.color_Desc = C_LuaUtility.ParseHtmlStringColor(nameTxtColor[1])
    bannerColor.a = 0.35
    bgColor.a = 0.6
    self.bind.active_skillBg = false
  end
  self.bind.img_bgColor = bgColor
  self.bind.color_banner = bannerColor
end

function this:showDetail(isOn)
  if self.bind.skillLevelTpl == nil then
    return
  end
  if isOn then
    self.bind.txt_desc = _skillLevelTpl:getSkillDetailDescribe(self.bind.skillLevelTpl)
  else
    self.bind.txt_desc = _skillLevelTpl:getSkillDescribe(self.bind.skillLevelTpl)
  end
end

return this
