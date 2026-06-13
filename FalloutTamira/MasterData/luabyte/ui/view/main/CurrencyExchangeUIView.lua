---自动生成代码----start----
local CurrencyExchangeUIView = BaseClass( 'CurrencyExchangeUIView' , BaseView )
local M = CurrencyExchangeUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectCancel =   self._binder:GetValue('rectCancel')  
  self.rectExchange =   self._binder:GetValue('rectExchange')  
  self.rectClose =   self._binder:GetValue('rectClose')  
  self.imgStarStone = self:AddBaseCom( GameUIImage ,'imgStarStone')
  self.imgCreditPoint = self:AddBaseCom( GameUIImage ,'imgCreditPoint')
  self.txtDes = self:AddBaseCom( GameUIText ,'txtDes')
  self.txtStarStone = self:AddBaseCom( GameUIText ,'txtStarStone')
  self.txtCreditPoint = self:AddBaseCom( GameUIText ,'txtCreditPoint')
  self.rectExchangeLock =   self._binder:GetValue('rectExchangeLock')  
  self.numSlider =   self:AddValue('UI.Ctrl.Common.ComNumSliderCtrl','UI.View.Common.ComNumSliderView','numSlider')  


end

return CurrencyExchangeUIView
---自动生成代码----end----