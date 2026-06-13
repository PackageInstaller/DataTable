---自动生成代码----start----
local EncounterSeasonItemView = BaseClass( 'EncounterSeasonItemView' , BaseView )
local M = EncounterSeasonItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.txt_zoneCnName = self:AddBaseCom( GameUIText ,'txt_zoneCnName')
  self.node_entry1 =   self._binder:GetValue('node_entry1')  
  self.node_entry2 =   self._binder:GetValue('node_entry2')  
  self.node_entry3 =   self._binder:GetValue('node_entry3')  
  self.txt_entryCnName1 = self:AddBaseCom( GameUIText ,'txt_entryCnName1')
  self.txt_entryCnName2 = self:AddBaseCom( GameUIText ,'txt_entryCnName2')
  self.txt_entryCnName3 = self:AddBaseCom( GameUIText ,'txt_entryCnName3')


end

return EncounterSeasonItemView
---自动生成代码----end----