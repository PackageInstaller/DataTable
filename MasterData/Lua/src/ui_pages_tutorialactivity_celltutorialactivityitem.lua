local this = class("cellTutorialActivityItem", G_UIModuleBase)

function this:created(...)
  this.super.created(self, ...)
end

function this.bind()
  return {
    tutorial_name = "",
    tutorialName_selected = "",
    select_icon = false,
    show_tutorial_name = true,
    reddot = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      if not string.isEmpty(self.bind.reddotName) then
        L_ReddotManager:clearNew(L_ReddotManager.DotDef.NewTutorialActivityGuide, self.bind.id)
      end
      if self.bind.select_icon == true then
        return
      end
      self:emit("onClick", self.bind)
    end
  }
end

function this:open()
  self.bind.tutorialName_selected = self.bind.tutorial_name
end

function this:refresh()
  self.bind.show_tutorial_name = self.bind.select_icon ~= true and true or false
  local reddotName = ""
  if self.bind and self.bind.reddotName then
    reddotName = self.bind.reddotName
  end
  if self.bindComponents.reddotNew then
    if string.isEmpty(reddotName) then
      self.bindComponents.reddotNew.gameObject:SetActive(false)
    else
      L_ReddotManager:registerReddot(self.bindComponents.reddotNew, reddotName)
    end
  end
end

function this:playSelectAnim()
  if not self.isBind then
    return
  end
  self.bindComponents.selectAnim:Stop()
  self.bindComponents.selectAnim:Play("anim_cell_tutorial_select")
end

return this
