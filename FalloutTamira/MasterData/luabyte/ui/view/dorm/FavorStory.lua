---自动生成代码----start----
local FavorStory = BaseClass( 'FavorStory' , BaseView )
local M = FavorStory 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_dialog =   self._binder:GetValue('txt_dialog')  
  self.Raycast = self:AddBaseCom( GameUIImage ,'Raycast')
  self.CommandPanel =   self._binder:GetValue('CommandPanel')  
  self.PowerItem1 =   self:AddValue('','UI.View.Dorm.PowerItemView','PowerItem1')  
  self.PowerItem2 =   self:AddValue('','UI.View.Dorm.PowerItemView','PowerItem2')  
  self.PowerItem3 =   self:AddValue('','UI.View.Dorm.PowerItemView','PowerItem3')  
  self.Story =   self._binder:GetValue('Story')  
  self.Gift =   self:AddValue('','UI.View.Dorm.DormStoryGiftView','Gift')  
  self.BtnSkip = self:AddBaseCom( GameUIImage ,'BtnSkip')


end

return FavorStory
---自动生成代码----end----