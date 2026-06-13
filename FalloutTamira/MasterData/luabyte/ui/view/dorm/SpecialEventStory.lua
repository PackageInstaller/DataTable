---自动生成代码----start----
local SpecialEventStory = BaseClass( 'SpecialEventStory' , BaseView )
local M = SpecialEventStory 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_dialog1 =   self._binder:GetValue('txt_dialog1')  
  self.Raycast = self:AddBaseCom( GameUIImage ,'Raycast')
  self.CommandPanel =   self._binder:GetValue('CommandPanel')  
  self.PowerItem1 =   self:AddValue('','UI.View.Dorm.PowerItemView','PowerItem1')  
  self.PowerItem2 =   self:AddValue('','UI.View.Dorm.PowerItemView','PowerItem2')  
  self.txt_dialog2 =   self._binder:GetValue('txt_dialog2')  
  self.Root2 =   self._binder:GetValue('Root2')  
  self.Root1 =   self._binder:GetValue('Root1')  
  self.TalkPanel =   self._binder:GetValue('TalkPanel')  
  self.BtnSkip = self:AddBaseCom( GameUIImage ,'BtnSkip')


end

return SpecialEventStory
---自动生成代码----end----