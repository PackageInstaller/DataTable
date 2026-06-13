---自动生成代码----start----
local MissionPointItemView = BaseClass( 'MissionPointItemView' , BaseView )
local M = MissionPointItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.line =   self._binder:GetValue('line')  
  self.doubleTag =   self._binder:GetValue('doubleTag')  
  self.heroTag =   self._binder:GetValue('heroTag')  
  self.heroImg = self:AddBaseCom( GameUIImage ,'heroImg')
  self.attackState =   self._binder:GetValue('attackState')  
  self.defenseState =   self._binder:GetValue('defenseState')  
  self.missionLab = self:AddBaseCom( GameUIText ,'missionLab')
  self.itemTag = self:AddBaseCom( GameUIImage ,'itemTag')
  self.itemIcon = self:AddBaseCom( GameUIImage ,'itemIcon')
  self.missionState =   self._binder:GetValue('missionState')  
  self.selectState =   self._binder:GetValue('selectState')  
  self.itemRare =   self._binder:GetValue('itemRare')  
  self.lockState =   self._binder:GetValue('lockState')  
  self.img_banner = self:AddBaseCom( GameUIImage ,'img_banner')
  self.img_picture = self:AddBaseCom( GameUIImage ,'img_picture')
  self.ticAnim =   self._binder:GetValue('ticAnim')  
  self.lineAnim =   self._binder:GetValue('lineAnim')  
  self.star1 =   self._binder:GetValue('star1')  
  self.star2 =   self._binder:GetValue('star2')  
  self.star3 =   self._binder:GetValue('star3')  
  self.star4 =   self._binder:GetValue('star4')  
  self.star4bg =   self._binder:GetValue('star4bg')  


end

return MissionPointItemView
---自动生成代码----end----