---自动生成代码----start----
local OtakuUpgradeUIView = BaseClass( 'OtakuUpgradeUIView' , BaseView )
local M = OtakuUpgradeUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.upInfo =   self:AddValue('UI.Ctrl.Otaku.OtakuUpgradeInfoCtrl','UI.View.Otaku.OtakuUpgradeInfoView','upInfo')  


end

return OtakuUpgradeUIView
---自动生成代码----end----