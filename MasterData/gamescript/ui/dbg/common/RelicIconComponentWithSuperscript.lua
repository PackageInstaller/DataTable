local RelicIconComponentWithSuperscript, Super = System.NewComponent("RelicIconComponentWithSuperscript", RelicIconComponent)

function RelicIconComponentWithSuperscript:ctor(node, view, relicTid, superscript, model)
  Super.ctor(self, node, view, relicTid)
  self.superscript = superscript
  self.model = model
end

function RelicIconComponentWithSuperscript:OnBind(binder)
  Super.OnBind(self, binder)
  self.ui.Group_Tab_Nor:SetActive(true)
  binder:SetText(self.ui.Text_Tab_Nor, self.superscript)
  binder:BindToRaw(function(_, stageId)
    self.stageId = stageId
  end, function()
    do return self.model.GetSelectedLevelID end
    return self.model.GetSelectedLevelID, self.model
  end)
end

return RelicIconComponentWithSuperscript
