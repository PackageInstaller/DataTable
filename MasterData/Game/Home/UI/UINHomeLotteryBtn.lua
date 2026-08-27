local base = require("Game.Home.UI.UINHomeGeneralBtn")
local UINHomeLotteryBtn = class("UINHomeLotteryBtn", base)

function UINHomeLotteryBtn:InitHomeLotteryBtn()
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.LotteryPr)
  if ok then
    self:_UpdRedDot(node)
  end
  self.__UpdRedDotFunc = BindCallback(self, self._UpdRedDot)
  RedDotController:AddListener(RedDotStaticTypeId.LotteryPr, self.__UpdRedDotFunc)
end

function UINHomeLotteryBtn:_UpdRedDot(node)
  local ltrCfg = PlayerDataCenter.allLtrData:GetMaxPriorityLtrCfg()
  self.ui.obj_LtrTenPrior:SetActive(node:GetRedDotCount() > 0)
  if ltrCfg ~= nil then
    self.ui.img_LtrTenPrior:SetIndex(ltrCfg.nav_tagIcon)
  else
    self.ui.img_LtrTenPrior:SetIndex(1)
  end
end

function UINHomeLotteryBtn:OnDelete()
  RedDotController:RemoveListener(RedDotStaticTypeId.LotteryPr, self.__UpdRedDotFunc)
  base.OnDelete(self)
end

return UINHomeLotteryBtn
