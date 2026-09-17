local this = class("pageHeroGradeAdvanceSuccess", G_UIPageBase)

function this.bind()
  return {txt_detail = "", txt_title = ""}
end

function this.methods()
  return {
    onClick_btnExit = function(self)
      L_UI:close("pageHeroGradeAdvanceSuccess")
    end
  }
end

function this:preOpen(options)
  self.bind.txt_detail = options.describe
  self.options = options
  self.bind.txt_title = options.title
  local imgPath = "Assets/Arts/UI/Page/HeroPanel/HeroGradeFate/tex_hero_grade_icon_0" .. options.index .. "_illustration.png"
  self.bindComponents.img_grade:LoadSprite(imgPath, false)
  self.bindComponents.up_iconeff:LoadTexture(imgPath)
end

function this:close()
end

return this
