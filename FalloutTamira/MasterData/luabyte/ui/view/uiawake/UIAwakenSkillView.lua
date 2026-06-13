---自动生成代码----start----
local UIAwakenSkillView = BaseClass( 'UIAwakenSkillView' , BaseView )
local M = UIAwakenSkillView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.labDesc = self:AddBaseCom( EmojiText ,'labDesc')
  self.state =   self._binder:GetValue('state')  
  self.labGet = self:AddBaseCom( GameUIText ,'labGet')


end

return UIAwakenSkillView
---自动生成代码----end----