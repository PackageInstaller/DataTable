---自动生成代码----start----
local Style01Image_TextView = BaseClass( 'Style01Image_TextView' , BaseView )
local M = Style01Image_TextView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ScrollView =   self._binder:GetValue('ScrollView')  
  self.ToggleDots = self:AddBaseCom( DotsToggler ,'ToggleDots')
  self.BtnL = self:AddBaseCom( UIButton ,'BtnL')
  self.BtnR = self:AddBaseCom( UIButton ,'BtnR')
  self.PageTemplate = self:AddBaseCom( GameRawImage ,'PageTemplate')
  self.PageCube = self:AddBaseCom( UIToggle ,'PageCube')


end

return Style01Image_TextView
---自动生成代码----end----