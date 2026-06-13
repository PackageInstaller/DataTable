---自动生成代码----start----
local OtakuChooseHeroUIView = BaseClass( 'OtakuChooseHeroUIView' , BaseView )
local M = OtakuChooseHeroUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectClose =   self._binder:GetValue('rectClose')  
  self.item =   self:AddValue('UI.Ctrl.Otaku.OtakuChooseHeroItemCtrl','UI.View.Otaku.OtakuChooseHeroItemView','item')  
  self.btnConfirm = self:AddBaseCom( GameUIImage ,'btnConfirm')
  self.btnClear = self:AddBaseCom( GameUIImage ,'btnClear')


end

return OtakuChooseHeroUIView
---自动生成代码----end----