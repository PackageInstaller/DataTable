local UIN_HBBackground = class("UIN_HBBackground", UIBaseNode)
local base = UIBaseNode

function UIN_HBBackground:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIN_HBBackground:PlayDoTweenAnimation(id)
  self.ui.DoTweenAnimation:DORestartAllById(id)
end

return UIN_HBBackground
