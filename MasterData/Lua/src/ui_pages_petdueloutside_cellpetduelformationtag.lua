local cls = class("cellPetDuelFormationTag", G_UIModuleBase)
local OrderNameEnums = {
  [1] = "ui_cellPetDuelFormationTag_01",
  [2] = "ui_cellPetDuelFormationTag_02",
  [3] = "ui_cellPetDuelFormationTag_03",
  [4] = "ui_cellPetDuelFormationTag_04",
  [5] = "ui_cellPetDuelFormationTag_05"
}

function cls.bind()
  return {toggle_select = false, txt_formationOrder = ""}
end

function cls.methods()
  return {
    onClick_select = function(self)
      if self.slot == self.selectSlot then
        return
      end
      if self.bind.callback then
        self.bind.callback(self)
      end
    end
  }
end

function cls:refresh()
  self.slot = self.bind.slotId
  self.selectSlot = self.bind.selectSlotId
  self:refreshView()
end

function cls:refreshView()
  self.bind.toggle_select = self.slot == self.selectSlot
  if self.bind.toggle_select then
    self.bind.txt_formationOrder = L_GameUtil.fillColor(L_WordsTpl:getValue(OrderNameEnums[self.slot]), "#8B8C8F")
  else
    self.bind.txt_formationOrder = L_GameUtil.fillColor(L_WordsTpl:getValue(OrderNameEnums[self.slot]), "##FFFFFF")
  end
end

return cls
