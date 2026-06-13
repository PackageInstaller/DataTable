---自动生成代码----start----
local AchievementBoxView = BaseClass( 'AchievementBoxView' , BaseView )
local M = AchievementBoxView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.null1 = self:AddBaseCom( GameUIImage ,'null1')
  self.null2 = self:AddBaseCom( GameUIImage ,'null2')
  self.null3 = self:AddBaseCom( GameUIImage ,'null3')
  self.editBtn =   self._binder:GetValue('editBtn')  
  self.num = self:AddBaseCom( GameUIText ,'num')
  self.show1 = self:AddBaseCom( GameUIImage ,'show1')
  self.show2 = self:AddBaseCom( GameUIImage ,'show2')
  self.show3 = self:AddBaseCom( GameUIImage ,'show3')


end

return AchievementBoxView
---自动生成代码----end----