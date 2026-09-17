local this = class("pageTechLevelUp", G_UIPageBase)
local _homeTechnologyTypeTpl = L_GameTpl:getHomeTechnologyTypeTpl()
local _txtColorStyle = {
  [1] = "FFA6A6",
  [2] = "BCF6DE",
  [3] = "C4E8FF",
  [4] = "FBDD95"
}
local _animName = {
  [1] = "anim_science_levelup_red",
  [2] = "anim_science_levelup_green",
  [3] = "anim_science_levelup_blue",
  [4] = "anim_science_levelup_yellow"
}
local _lineName = {
  [1] = "UI/Atlas/HomeScience/tex_battlepass_lvup_bg_02_red.png",
  [2] = "UI/Atlas/HomeScience/tex_battlepass_lvup_bg_02_green.png",
  [3] = "UI/Atlas/HomeScience/tex_battlepass_lvup_bg_02_blue.png",
  [4] = "UI/Atlas/HomeScience/tex_battlepass_lvup_bg_02_yellow.png"
}

function this.bind()
  return {
    txt_level = "",
    txt_content = "",
    color_content = "",
    img_line1 = "",
    img_line2 = ""
  }
end

function this.methods()
  return {}
end

function this:open(options)
  this.super.open(self, options)
  self.techType = options.techType
  self.level = options.level
  self.closeCB = options.closeCB
  self:updatePage()
  Timer.once(1.3, function()
    L_UI:close(self.pageName)
  end, self)
end

function this:close(options)
  this.super.close(self)
  if self.closeCB then
    self.closeCB()
  end
end

function this:updatePage()
  local tplTechnologyType = _homeTechnologyTypeTpl:getTplById(self.techType)
  local content = L_WordsTpl:getValue("ui_home_technology_level_upgrade", {
    [0] = _homeTechnologyTypeTpl:getTechnologyName(tplTechnologyType)
  })
  self.bind.txt_content = content
  self.bind.txt_level = tostring(self.level)
  self.bind.color_content = _txtColorStyle[self.techType]
  self.bind.img_line1 = _lineName[self.techType]
  self.bind.img_line2 = _lineName[self.techType]
  self.bindComponents.animation:Play(_animName[self.techType])
end

return this
