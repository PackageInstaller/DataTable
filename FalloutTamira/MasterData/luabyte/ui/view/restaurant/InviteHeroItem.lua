---自动生成代码----start----
local InviteHeroItem = BaseClass( 'InviteHeroItem' , BaseView )
local M = InviteHeroItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.HeadIcon =   self._binder:GetValue('HeadIcon')  
  self.name = self:AddBaseCom( GameUIText ,'name')
  self.SliderrLabel = self:AddBaseCom( GameUIText ,'SliderrLabel')
  self.Slider = self:AddBaseCom( UISlider ,'Slider')
  self.tfSelect =   self._binder:GetValue('tfSelect')  
  self.Select =   self._binder:GetValue('Select')  


end

return InviteHeroItem
---自动生成代码----end----