---自动生成代码----start----
local ManufacturingCabin = BaseClass( 'ManufacturingCabin' , BaseView )
local M = ManufacturingCabin 
--desc

function M:__init(go)
  local trans = go.transform 
  self.numberBar =   self:AddValue('','UI.View.Create.CreateNumberBarUI','numberBar')  
  self.addBtn =   self._binder:GetValue('addBtn')  
  self.createItem =   self._binder:GetValue('createItem')  
  self.content =   self._binder:GetValue('content')  
  self.CreateTimePart =   self._binder:GetValue('CreateTimePart')  
  self.timeDesText = self:AddBaseCom( GameUIText ,'timeDesText')
  self.EngText = self:AddBaseCom( GameUIText ,'EngText')
  self.timeText1 = self:AddBaseCom( GameUIText ,'timeText1')
  self.TimeBg1 =   self._binder:GetValue('TimeBg1')  
  self.TimeBg2 =   self._binder:GetValue('TimeBg2')  
  self.btn_Speed = self:AddBaseCom( GameUIImage ,'btn_Speed')
  self.timeText2 = self:AddBaseCom( GameUIText ,'timeText2')
  self.num = self:AddBaseCom( GameUIText ,'num')
  self.led01 =   self._binder:GetValue('led01')  
  self.makeAnimator1 =   self._binder:GetValue('makeAnimator1')  
  self.makeAnimator2 =   self._binder:GetValue('makeAnimator2')  
  self.makeAnimator3 =   self._binder:GetValue('makeAnimator3')  
  self.addMakeObj =   self._binder:GetValue('addMakeObj')  


end

return ManufacturingCabin
---自动生成代码----end----