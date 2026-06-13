---自动生成代码----start----
local DormitoryDressupArea = BaseClass( 'DormitoryDressupArea' , BaseView )
local M = DormitoryDressupArea 
--desc

function M:__init(go)
  local trans = go.transform 
  self.BtnL = self:AddBaseCom( GameUIImage ,'BtnL')
  self.BtnR = self:AddBaseCom( GameUIImage ,'BtnR')
  self.Item =   self:AddValue('','UI.View.Dorm.DormitoryDressupAreaItem','Item')  
  self.Content =   self._binder:GetValue('Content')  
  self.ScrollView =   self._binder:GetValue('ScrollView')  


end

return DormitoryDressupArea
---自动生成代码----end----