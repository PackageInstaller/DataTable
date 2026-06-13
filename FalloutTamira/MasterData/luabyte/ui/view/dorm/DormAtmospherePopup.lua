---自动生成代码----start----
local DormAtmospherePopup = BaseClass( 'DormAtmospherePopup' , BaseView )
local M = DormAtmospherePopup 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Mask =   self._binder:GetValue('Mask')  
  self.CurrentValue = self:AddBaseCom( GameUIText ,'CurrentValue')
  self.TargetValue = self:AddBaseCom( GameUIText ,'TargetValue')
  self.RewardBtn = self:AddBaseCom( GameUIImage ,'RewardBtn')
  self.Content =   self._binder:GetValue('Content')  
  self.item =   self:AddValue('','UI.View.Common.ItemPfbView','item')  
  self.UIState =   self._binder:GetValue('UIState')  
  self.BtnState =   self._binder:GetValue('BtnState')  


end

return DormAtmospherePopup
---自动生成代码----end----