---自动生成代码----start----
local HomeHodler = BaseClass( 'HomeHodler' , BaseView )
local M = HomeHodler 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Home =   self:AddValue('','Scenes.Objects.Home','Home')  
  self.FashionShow =   self:AddValue('','Scenes.Objects.RoleFashionScene','FashionShow')  
  self.lateState =   self._binder:GetValue('lateState')  


end

return HomeHodler
---自动生成代码----end----