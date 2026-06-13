---自动生成代码----start----
local ChiefNoteUIView = BaseClass( 'ChiefNoteUIView' , BaseView )
local M = ChiefNoteUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.scrollTab =   self._binder:GetValue('scrollTab')  
  self.scrollNote = self:AddBaseCom( LoopListView ,'scrollNote')
  self.rectBack =   self._binder:GetValue('rectBack')  


end

return ChiefNoteUIView
---自动生成代码----end----