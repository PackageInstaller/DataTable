local UINDunHexaTowerModNode = class("UINDunHexaTowerModNode", UIBaseNode)
local base = UIBaseNode

function UINDunHexaTowerModNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_Period, self, self.__OnClickPeriod)
  UIUtil.AddButtonListener(self.ui.Btn_Normal, self, self.__OnClickNormal)
end

function UINDunHexaTowerModNode:InitTowerModNode(clickPeriodCallback, clickNormalCallback)
  self.clickPeriodCallback = clickPeriodCallback
  self.clickNormalCallback = clickNormalCallback
end

function UINDunHexaTowerModNode:RefreshProgress(tnn, cnn, isHavePeriodic, tnp, cnp)
  self.ui.Go_Period:SetActive(isHavePeriodic)
  if isHavePeriodic then
    self.ui.Tex_PeriodProgress.text = string.format("%s/%s", tostring(cnp), tostring(tnp))
  end
  self.ui.Tex_ProgressNormal.text = string.format("%s/%s", tostring(cnn), tostring(tnn))
end

function UINDunHexaTowerModNode:__OnClickPeriod()
  if self.clickPeriodCallback ~= nil then
    self.clickPeriodCallback()
  end
end

function UINDunHexaTowerModNode:__OnClickNormal()
  if self.clickNormalCallback ~= nil then
    self.clickNormalCallback()
  end
end

return UINDunHexaTowerModNode
