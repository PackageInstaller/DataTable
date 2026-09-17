local this = class("cellPageActivityTaskToggleItem", G_UIModuleBase)
local _commonTabTpl = L_GameTpl:getCommonTabTpl()

function this.bind()
  return {
    txt_titleSel = "",
    txt_title = "",
    txt_eng = "",
    txt_eng_sel = ""
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      if self.bind.type == self.parent.selectType then
        self.isSampleType = true
        return
      else
        self.isSampleType = false
      end
      self:emit("onClick_select", self.bind.type)
      if not self.isSampleType then
        self.parent.bindComponents.mainLeftContentAnim:Stop()
        self.parent.bindComponents.mainLeftContentAnim:Play()
        self.parent.bindComponents.mainRightContentAnim:Stop()
        self.parent.bindComponents.mainRightContentAnim:Play()
        self.parent.parent:resetSelectObj()
      end
    end
  }
end

function this:open()
  self:refreshView()
end

function this:refreshView()
  self.bind.txt_titleSel = _commonTabTpl:getName(_commonTabTpl:getTplById(self.bind.comTabID))
  self.bind.txt_title = _commonTabTpl:getName(_commonTabTpl:getTplById(self.bind.comTabID))
  self.bind.txt_eng = self.bind.txt_eng
  self.bind.txt_eng_sel = self.bind.txt_eng
end

return this
