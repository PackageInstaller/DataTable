local page = class("pageShowPetSkill", G_UIPageBase)

function page:ctor(...)
  page.super.ctor(self, ...)
  self.data = {skillId = nil, petId = nil}
end

function page.bind()
  return {
    desc = "",
    skillName = "",
    skillIcon = "",
    showStarList = false,
    showLv = false,
    txt_lv = "",
    starList = {
      moduleName = "pages/Pet/cellStarItem"
    },
    module_commonTipBoard = L_Const.ModuleInfo.CommonTipBoard
  }
end

function page.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_closeByEmptyBg = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self:initPage(options.optionData)
end

function page:close(options)
  page.super.close(self, options)
end

function page:initPage(optionData)
  self.bind.desc = optionData.describe
  self.bind.skillName = optionData.skillName
  self.bind.skillIcon = optionData.skillIcon
  self.bind.showStarList = optionData.starLv ~= 0 and true or false
  self.bind.showLv = optionData.starLv == 0 and true or false
  self.bind.txt_lv = optionData.skillLv
  if self.bind.showStarList == true then
    self.bind.starList:clear()
    local data = {}
    for i = 1, optionData.starLv do
      table.insert(data, {
        starLv = optionData.starLv,
        rarity = optionData.rarity
      })
    end
    self.bind.starList:insert_array(data)
  end
end

return page
