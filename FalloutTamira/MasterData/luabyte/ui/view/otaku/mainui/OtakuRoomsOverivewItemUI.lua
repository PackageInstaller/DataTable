---自动生成代码----start----
local OtakuRoomsOverivewItemUI = BaseClass( 'OtakuRoomsOverivewItemUI' , BaseView )
local M = OtakuRoomsOverivewItemUI 
--desc

function M:__init(go)
  local trans = go.transform 
  self.name = self:AddBaseCom( GameUIText ,'name')
  self.level = self:AddBaseCom( GameUIText ,'level')
  self.desc = self:AddBaseCom( GameUIText ,'desc')
  self.noBuilding =   self._binder:GetValue('noBuilding')  
  self.upgrade =   self._binder:GetValue('upgrade')  
  self.award =   self._binder:GetValue('award')  
  self.build =   self._binder:GetValue('build')  
  self.icon = self:AddBaseCom( GameRawImage ,'icon')
  self.buildingTag =   self._binder:GetValue('buildingTag')  
  self.buildingDesc = self:AddBaseCom( GameUIText ,'buildingDesc')
  self.noBuilding =   self._binder:GetValue('noBuilding')  
  self.txt_UnOpenReason = self:AddBaseCom( GameUIText ,'txt_UnOpenReason')
  self.goObj =   self._binder:GetValue('goObj')  
  self.notBuilding =   self._binder:GetValue('notBuilding')  


end

return OtakuRoomsOverivewItemUI
---自动生成代码----end----