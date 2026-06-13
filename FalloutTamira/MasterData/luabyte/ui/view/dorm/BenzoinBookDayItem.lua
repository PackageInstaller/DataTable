---自动生成代码----start----
local BenzoinBookDayItem = BaseClass( 'BenzoinBookDayItem' , BaseView )
local M = BenzoinBookDayItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ClickTarget = self:AddBaseCom( GameUIImage ,'ClickTarget')
  self.WeatherImage_1 = self:AddBaseCom( GameUIImage ,'WeatherImage_1')
  self.TitleText_1 = self:AddBaseCom( GameUIText ,'TitleText_1')
  self.Unselect =   self._binder:GetValue('Unselect')  
  self.Select =   self._binder:GetValue('Select')  
  self.Locked =   self._binder:GetValue('Locked')  
  self.TitleEng_1 = self:AddBaseCom( GameUIText ,'TitleEng_1')
  self.TitleText_2 = self:AddBaseCom( GameUIText ,'TitleText_2')
  self.WeatherImage_2 = self:AddBaseCom( GameUIImage ,'WeatherImage_2')
  self.TitleEng_2 = self:AddBaseCom( GameUIText ,'TitleEng_2')
  self.LockText = self:AddBaseCom( GameUIText ,'LockText')

  self.index = self:GetBaseValue('index')
end

return BenzoinBookDayItem
---自动生成代码----end----