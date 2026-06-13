---自动生成代码----start----
local BridgeUIView = BaseClass( 'BridgeUIView' , BaseView )
local M = BridgeUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.scrollCabin = self:AddBaseCom( CircularScrollView ,'scrollCabin')
  self.rectSkill =   self._binder:GetValue('rectSkill')  
  self.ctrlSettle =   self:AddValue('UI.Ctrl.Otaku.OtakuSettleHeroCtrl','UI.View.Otaku.OtakuSettleHeroView','ctrlSettle')  
  self.ctrlTitle =   self:AddValue('UI.Ctrl.Otaku.OtakuTitleCtrl','UI.View.Otaku.OtakuTitleView','ctrlTitle')  


end

return BridgeUIView
---自动生成代码----end----