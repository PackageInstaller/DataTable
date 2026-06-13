---自动生成代码----start----
local DailyListItemView = BaseClass( 'DailyListItemView' , BaseView )
local M = DailyListItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txtDes = self:AddBaseCom( GameUIText ,'txtDes')
  self.txtPropertion = self:AddBaseCom( GameUIText ,'txtPropertion')
  self.imgProgress = self:AddBaseCom( GameUIImage ,'imgProgress')
  self.awardScrollView = self:AddBaseCom( CircularScrollView ,'awardScrollView')
  self.rectGoto =   self._binder:GetValue('rectGoto')  
  self.rectReceive =   self._binder:GetValue('rectReceive')  
  self.rectComplete =   self._binder:GetValue('rectComplete')  
  self.rectClickArea =   self._binder:GetValue('rectClickArea')  
  self.rectTask =   self._binder:GetValue('rectTask')  


end

return DailyListItemView
---自动生成代码----end----