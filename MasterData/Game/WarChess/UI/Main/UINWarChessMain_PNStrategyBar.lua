local base = UIBaseNode
local UINWarChessMain_PNStrategyBar = class("UINWarChessMain_PNStrategyBar", base)

function UINWarChessMain_PNStrategyBar:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__refreshWCStrategyExpAndLevel = BindCallback(self, self.RefreshWCStrategyExpAndLevel)
  MsgCenter:AddListener(eMsgEventId.WC_StrategyExpChange, self.__refreshWCStrategyExpAndLevel)
end

function UINWarChessMain_PNStrategyBar:InitWCStrategyBar()
  self:RefreshWCStrategyExpAndLevel()
end

function UINWarChessMain_PNStrategyBar:RefreshWCStrategyExpAndLevel()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local curLevel = wcCtrl.wcStragegyCtrl:GetWCStrategyLevel()
  local curExp, fullExp = wcCtrl.wcStragegyCtrl:GetWCStrategyExp()
  self.ui.tex_StrategyLevel:SetIndex(0, tostring(curLevel))
  self.ui.img_exp.fillAmount = curExp / fullExp
  self.ui.tex_StrategyExp:SetIndex(0, tostring(curExp), tostring(fullExp))
end

function UINWarChessMain_PNStrategyBar:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.WC_StrategyExpChange, self.__refreshWCStrategyExpAndLevel)
end

return UINWarChessMain_PNStrategyBar
