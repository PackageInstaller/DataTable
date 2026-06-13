---自动生成代码----start----
local UIItemView = BaseClass( 'UIItemView' , BaseView )
local M = UIItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnClose =   self._binder:GetValue('btnClose')  
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.labDesc = self:AddBaseCom( GameUIText ,'labDesc')
  self.goFromPanel =   self._binder:GetValue('goFromPanel')  
  self.labTips = self:AddBaseCom( GameUIText ,'labTips')
  self.labAllNum = self:AddBaseCom( GameUIText ,'labAllNum')
  self.gridScroll = self:AddBaseCom( CircularScrollView ,'gridScroll')
  self.goTips =   self._binder:GetValue('goTips')  
  self.Icon = self:AddBaseCom( GameUIImage ,'Icon')
  self.UIStateType =   self._binder:GetValue('UIStateType')  
  self.UIStateQuality =   self._binder:GetValue('UIStateQuality')  
  self.HeroList = self:AddBaseCom( CircularScrollView ,'HeroList')
  self.ItemList = self:AddBaseCom( CircularScrollView ,'ItemList')
  self.Content =   self._binder:GetValue('Content')  
  self.posCtrl =   self._binder:GetValue('posCtrl')  
  self.ClickArea =   self._binder:GetValue('ClickArea')  


end

return UIItemView
---自动生成代码----end----