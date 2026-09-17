local this = class("cellPetSkillTipsTab", G_UIModuleBase)

function this.bind()
  return {
    txt_name = "",
    txt_name_choose = "",
    txt_shortCut = "",
    go_shortCut = false,
    tabId = -1
  }
end

function this:methods()
  return {
    onClick_Btn = function(self)
      if self.bind.onClickTab then
        self.bind.onClickTab()
      end
    end
  }
end

function this:refresh()
  self.bind.tabId = self.bind.tabGroupId
  self.bind.txt_name_choose = self.bind.txt_name
  self.bind.go_shortCut = false
end

function this:refreshState(isShow)
  self.bind.go_shortCut = L_DeviceTpl:getIsPc() and not isShow
end

return this
