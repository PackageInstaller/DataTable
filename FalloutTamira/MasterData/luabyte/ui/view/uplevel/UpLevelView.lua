---自动生成代码----start----
local UpLevelView = BaseClass( 'UpLevelView' , BaseView )
local M = UpLevelView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnClose =   self._binder:GetValue('btnClose')  
  self.labChina = self:AddBaseCom( GameUIText ,'labChina')
  self.labEn1 = self:AddBaseCom( GameUIText ,'labEn1')
  self.labEn2 = self:AddBaseCom( GameUIText ,'labEn2')
  self.animator =   self._binder:GetValue('animator')  


end

return UpLevelView
---自动生成代码----end----