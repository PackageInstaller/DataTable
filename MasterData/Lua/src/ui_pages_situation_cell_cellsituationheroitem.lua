local this = class("cellSituationHeroItem", G_UIModuleBase)

function this.bind()
  return {
    activeSel = false,
    activeDel = false,
    iconUnit = L_Const.ModuleInfo.CellIconUnit
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind.id, function()
        self:playSelAnim()
      end)
    end,
    onClickRemove = function(self)
      self:emit("onClickRemove", self.bind.id)
    end
  }
end

function this:init()
end

function this:open()
end

function this:refresh()
  self:refreshIcon()
  self:refreshBtns()
  self:refreshSelectRoot(nil)
end

function this:refreshIcon()
  table.merge(self.modules.iconUnit.bind, self.bind.iconData)
  self.modules.iconUnit:refresh()
end

function this:refreshBtns()
  if not self.isBind then
    return
  end
  local heroConfigId = self.bind.id
  if L_GameUtil.isDefaultHero(heroConfigId) then
    self.bind.activeSel = false
    self.bind.activeDel = false
  else
    local have = L_SituationManager:hasHero(heroConfigId)
    self.bind.activeDel = have
    if self.modules.iconUnit then
      self.modules.iconUnit.bind.go_putMask = have
    end
  end
end

function this:refreshSelectRoot(heroConfigId)
  local have = L_SituationManager:hasHero(heroConfigId)
  self.bind.activeSel = self.bind.id == heroConfigId and have
end

function this:close()
end

function this:playSelAnim()
end

return this
