---自动生成代码----start----
local UITeamItemView2 = BaseClass( 'UITeamItemView2' , BaseView )
local M = UITeamItemView2 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tfOff =   self._binder:GetValue('tfOff')  
  self.tfOn =   self._binder:GetValue('tfOn')  
  self.labOff = self:AddBaseCom( GameUIText ,'labOff')
  self.labOn = self:AddBaseCom( GameUIText ,'labOn')
  self.btn1 = self:AddBaseCom( GameUIImage ,'btn1')
  self.inputField = self:AddBaseCom( UIInput ,'inputField')
  self.btn2 = self:AddBaseCom( GameUIImage ,'btn2')


end

return UITeamItemView2
---自动生成代码----end----