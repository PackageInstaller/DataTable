---自动生成代码----start----
local StoryBgRoleView = BaseClass( 'StoryBgRoleView' , BaseView )
local M = StoryBgRoleView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rimgBg1 = self:AddBaseCom( GameRawImage ,'rimgBg1')
  self.rimgBg2 = self:AddBaseCom( GameRawImage ,'rimgBg2')
  self.rimgRole1 = self:AddBaseCom( GameRawImage ,'rimgRole1')
  self.rimgRole2 = self:AddBaseCom( GameRawImage ,'rimgRole2')
  self.rimgRole3 = self:AddBaseCom( GameRawImage ,'rimgRole3')
  self.imgEmoji1 = self:AddBaseCom( GameUIImage ,'imgEmoji1')
  self.imgEmoji2 = self:AddBaseCom( GameUIImage ,'imgEmoji2')
  self.imgEmoji3 = self:AddBaseCom( GameUIImage ,'imgEmoji3')
  self.txtHeart1 = self:AddBaseCom( GameUIText ,'txtHeart1')
  self.txtHeart2 = self:AddBaseCom( GameUIText ,'txtHeart2')
  self.txtHeart3 = self:AddBaseCom( GameUIText ,'txtHeart3')
  self.rectHeart1 =   self._binder:GetValue('rectHeart1')  
  self.rectHeart2 =   self._binder:GetValue('rectHeart2')  
  self.rectHeart3 =   self._binder:GetValue('rectHeart3')  
  self.spine =   self._binder:GetValue('spine')  
  self.media =   self._binder:GetValue('media')  
  self.rectSkip =   self._binder:GetValue('rectSkip')  
  self.rimgRemoteEffect = self:AddBaseCom( GameRawImage ,'rimgRemoteEffect')
  self.roleSpine1 =   self._binder:GetValue('roleSpine1')  
  self.roleSpine2 =   self._binder:GetValue('roleSpine2')  
  self.roleSpine3 =   self._binder:GetValue('roleSpine3')  
  self.rolePanel =   self._binder:GetValue('rolePanel')  


end

return StoryBgRoleView
---自动生成代码----end----