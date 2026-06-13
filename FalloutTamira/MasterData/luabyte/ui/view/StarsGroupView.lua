---自动生成代码----start----
local StarsGroupView = BaseClass( 'StarsGroupView' , BaseView )
local M = StarsGroupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.starBg1 = self:AddBaseCom( GameUIImage ,'starBg1')
  self.starBg2 = self:AddBaseCom( GameUIImage ,'starBg2')
  self.starBg3 = self:AddBaseCom( GameUIImage ,'starBg3')
  self.starBg4 = self:AddBaseCom( GameUIImage ,'starBg4')
  self.starBg5 = self:AddBaseCom( GameUIImage ,'starBg5')
  self.starBg6 =   self._binder:GetValue('starBg6')  
  self.starBg7 =   self._binder:GetValue('starBg7')  
  self.starBg8 =   self._binder:GetValue('starBg8')  
  self.starBg9 = self:AddBaseCom( GameUIImage ,'starBg9')
  self.starBg10 = self:AddBaseCom( GameUIImage ,'starBg10')
  self.star1 = self:AddBaseCom( GameUIImage ,'star1')
  self.star2 = self:AddBaseCom( GameUIImage ,'star2')
  self.star3 = self:AddBaseCom( GameUIImage ,'star3')
  self.star4 = self:AddBaseCom( GameUIImage ,'star4')
  self.star5 = self:AddBaseCom( GameUIImage ,'star5')
  self.star6 = self:AddBaseCom( GameUIImage ,'star6')
  self.star7 = self:AddBaseCom( GameUIImage ,'star7')
  self.star8 = self:AddBaseCom( GameUIImage ,'star8')
  self.star9 = self:AddBaseCom( GameUIImage ,'star9')
  self.star10 = self:AddBaseCom( GameUIImage ,'star10')


end

return StarsGroupView
---自动生成代码----end----