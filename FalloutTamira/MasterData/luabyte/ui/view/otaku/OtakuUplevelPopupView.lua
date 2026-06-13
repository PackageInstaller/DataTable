---自动生成代码----start----
local OtakuUplevelPopupView = BaseClass( 'OtakuUplevelPopupView' , BaseView )
local M = OtakuUplevelPopupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.upInfo =   self:AddValue('UI.Ctrl.Otaku.OtakuUpgradeInfoCtrl','UI.View.Otaku.OtakuUpgradeInfoView','upInfo')  
  self.txt_count = self:AddBaseCom( GameUIText ,'txt_count')


end

return OtakuUplevelPopupView
---自动生成代码----end----