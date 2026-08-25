local AvgDialogBgComp, Super = System.NewClass("AvgDialogBgComp")

function AvgDialogBgComp:ctor(ui, binder, avgModel)
  Super.ctor(self)
  self.ui = ui
  self.binder = binder
  self.avgModel = avgModel
end

function AvgDialogBgComp:SwitchBg()
end

return AvgDialogBgComp
