---自动生成代码----start----
local EncounteRecordItemView = BaseClass( 'EncounteRecordItemView' , BaseView )
local M = EncounteRecordItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.passItem =   self:AddValue('UI.Ctrl.Mission.EncounteProcessCtrl','UI.View.Mission.EncounteProcessView','passItem')  
  self.icon = self:AddBaseCom( GameUIImage ,'icon')


end

return EncounteRecordItemView
---自动生成代码----end----