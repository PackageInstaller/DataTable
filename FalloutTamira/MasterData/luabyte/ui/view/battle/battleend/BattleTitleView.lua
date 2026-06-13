---自动生成代码----start----
local BattleTitleView = BaseClass( 'BattleTitleView' , BaseView )
local M = BattleTitleView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.missionName = self:AddBaseCom( GameUIText ,'missionName')
  self.chapterText = self:AddBaseCom( GameUIText ,'chapterText')
  self.star1 =   self._binder:GetValue('star1')  
  self.star2 =   self._binder:GetValue('star2')  
  self.star3 =   self._binder:GetValue('star3')  
  self.star4 =   self._binder:GetValue('star4')  
  self.star4Bg = self:AddBaseCom( GameUIImage ,'star4Bg')
  self.img_text = self:AddBaseCom( GameUIImage ,'img_text')
  self.starGroup =   self._binder:GetValue('starGroup')  
  self.Group9 =   self._binder:GetValue('Group9')  
  self.StarNumber = self:AddBaseCom( GameUIText ,'StarNumber')


end

return BattleTitleView
---自动生成代码----end----