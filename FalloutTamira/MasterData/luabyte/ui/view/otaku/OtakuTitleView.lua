---自动生成代码----start----
local OtakuTitleView = BaseClass( 'OtakuTitleView' , BaseView )
local M = OtakuTitleView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txtLevel = self:AddBaseCom( GameUIText ,'txtLevel')
  self.rectUpgrade =   self._binder:GetValue('rectUpgrade')  
  self.stateUpgrade =   self._binder:GetValue('stateUpgrade')  
  self.barDots =   self:AddValue('UI.Ctrl.Otaku.OtakuBridgeDotGroupCtrl','UI.View.Otaku.MainUI.OtakuBridgeDotGroupView','barDots')  
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.txtName = self:AddBaseCom( GameUIText ,'txtName')


end

return OtakuTitleView
---自动生成代码----end----