local this = class("cellPetEvoSkill", G_UIModuleBase)

function this.bind()
  return {
    skillBeforeIcon = "",
    skillBeforeColor = C_Color.White,
    skillAfterIcon = "",
    skillAfterColor = C_Color.White
  }
end

function this.methods()
  return {
    onClick_Choose = function(self, data)
      self:emit("onClick_Choose", self.bind, self.bindComponents.skillTrans.position)
    end
  }
end

function this:open()
  self:setColor()
end

function this:setColor()
  if self.isBind and self.bind.linearColor then
    return
  end
end

function this:playAnim(animName)
  if string.isEmpty(animName) then
    return
  end
  if self.isBind then
    self.bindComponents.animRoot:SetTrigger(animName)
  end
end

return this
