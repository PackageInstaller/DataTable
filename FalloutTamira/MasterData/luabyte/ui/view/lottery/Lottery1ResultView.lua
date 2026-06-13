---自动生成代码----start----
local Lottery1ResultView = BaseClass( 'Lottery1ResultView' , BaseView )
local M = Lottery1ResultView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.trans_Bg =   self._binder:GetValue('trans_Bg')  
  self.txt_part2CnName = self:AddBaseCom( GameUIText ,'txt_part2CnName')
  self.txt_part2EnName =   self._binder:GetValue('txt_part2EnName')  
  self.rimg_roleShadow = self:AddBaseCom( GameRawImage ,'rimg_roleShadow')
  self.rimg_role = self:AddBaseCom( GameRawImage ,'rimg_role')
  self.Btn_Skip =   self._binder:GetValue('Btn_Skip')  
  self.newEmployee = self:AddBaseCom( GameUIImage ,'newEmployee')
  self.img_part2RoleQualityShadow = self:AddBaseCom( GameUIImage ,'img_part2RoleQualityShadow')
  self.img_part2RoleQuality = self:AddBaseCom( GameUIImage ,'img_part2RoleQuality')
  self.Nation = self:AddBaseCom( GameUIImage ,'Nation')
  self.colorQuality2 = self:AddBaseCom( GameUIImage ,'colorQuality2')
  self.colorQuality3 = self:AddBaseCom( GameUIImage ,'colorQuality3')
  self.img_profession = self:AddBaseCom( GameUIImage ,'img_profession')
  self.rimg_roleShadow2 = self:AddBaseCom( GameRawImage ,'rimg_roleShadow2')
  self.NationShadow = self:AddBaseCom( GameUIImage ,'NationShadow')
  self.monologueText = self:AddBaseCom( GameUIText ,'monologueText')
  self.finalProductIcon = self:AddBaseCom( GameUIImage ,'finalProductIcon')
  self.finalProduct = self:AddBaseCom( GameUIImage ,'finalProduct')
  self.state =   self._binder:GetValue('state')  
  self.Logo = self:AddBaseCom( GameUIImage ,'Logo')
  self.LogoShadow = self:AddBaseCom( GameUIImage ,'LogoShadow')


end

return Lottery1ResultView
---自动生成代码----end----