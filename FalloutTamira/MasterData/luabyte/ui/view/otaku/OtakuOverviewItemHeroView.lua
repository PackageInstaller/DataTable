---自动生成代码----start----
local OtakuOverviewItemHeroView = BaseClass( 'OtakuOverviewItemHeroView' , BaseView )
local M = OtakuOverviewItemHeroView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.state =   self._binder:GetValue('state')  
  self.addClick =   self._binder:GetValue('addClick')  
  self.headImg = self:AddBaseCom( GameUIImage ,'headImg')
  self.professionImg = self:AddBaseCom( GameUIImage ,'professionImg')
  self.barState =   self._binder:GetValue('barState')  
  self.bar =   self._binder:GetValue('bar')  
  self.lockText = self:AddBaseCom( GameUIText ,'lockText')
  self.food =   self._binder:GetValue('food')  


end

return OtakuOverviewItemHeroView
---自动生成代码----end----