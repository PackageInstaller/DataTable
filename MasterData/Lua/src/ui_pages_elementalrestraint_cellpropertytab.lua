local this = class("cellPropertyTab", G_UIModuleBase)

function this.bind()
  return {
    txt_name = "",
    txt_decoration = "",
    txt_name_choose = "",
    txt_decoration_choose = "",
    toggle_isChoose = false
  }
end

function this:methods()
  return {
    onClick_Btn = function(self)
      if self.bind.onClickTab then
        self.bind.onClickTab(self.bind.tabGroupId)
      end
    end
  }
end

function this:refresh()
  self.bind.txt_name_choose = self.bind.txt_name
  self.bind.txt_decoration_choose = self.bind.txt_decoration
end

return this
