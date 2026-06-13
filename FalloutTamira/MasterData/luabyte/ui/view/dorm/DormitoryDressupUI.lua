---自动生成代码----start----
local DormitoryDressupUI = BaseClass( 'DormitoryDressupUI' , BaseView )
local M = DormitoryDressupUI 
--desc

function M:__init(go)
  local trans = go.transform 
  self.TabItem1 =   self:AddValue('','UI.View.Dorm.DormitoryDressupTabItem','TabItem1')  
  self.TabItem2 =   self:AddValue('','UI.View.Dorm.DormitoryDressupTabItem','TabItem2')  
  self.noGifts =   self._binder:GetValue('noGifts')  
  self.Content =   self._binder:GetValue('Content')  
  self.BtnL =   self._binder:GetValue('BtnL')  
  self.BtnR =   self._binder:GetValue('BtnR')  
  self.UIState =   self._binder:GetValue('UIState')  
  self.BtnSave =   self._binder:GetValue('BtnSave')  
  self.BtnFold =   self._binder:GetValue('BtnFold')  
  self.BtnOK =   self._binder:GetValue('BtnOK')  
  self.BtnCancel =   self._binder:GetValue('BtnCancel')  
  self.AreaPart =   self:AddValue('','UI.View.Dorm.DormitoryDressupArea','AreaPart')  
  self.FurnitureItem =   self:AddValue('','UI.View.Dorm.FurnitureItem','FurnitureItem')  
  self.ScrollView =   self._binder:GetValue('ScrollView')  
  self.BtnGroup =   self._binder:GetValue('BtnGroup')  
  self.Animator =   self._binder:GetValue('Animator')  
  self.BgDown = self:AddBaseCom( GameUIImage ,'BgDown')
  self.BgUp = self:AddBaseCom( GameUIImage ,'BgUp')
  self.TabItem3 =   self:AddValue('','UI.View.Dorm.DormitoryDressupTabItem','TabItem3')  
  self.obtainBtn = self:AddBaseCom( GameUIImage ,'obtainBtn')
  self.BtnAuto =   self._binder:GetValue('BtnAuto')  


end

return DormitoryDressupUI
---自动生成代码----end----