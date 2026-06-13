---自动生成代码----start----
local BossWarAwardUIView = BaseClass( 'BossWarAwardUIView' , BaseView )
local M = BossWarAwardUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tgl_battle = self:AddBaseCom( UIToggle ,'tgl_battle')
  self.tgl_cycle = self:AddBaseCom( UIToggle ,'tgl_cycle')
  self.bossTab =   self._binder:GetValue('bossTab')  
  self.looplist = self:AddBaseCom( CircularScrollView ,'looplist')
  self.btn_quick =   self._binder:GetValue('btn_quick')  
  self.txt_back =   self._binder:GetValue('txt_back')  
  self.chestTips =   self._binder:GetValue('chestTips')  
  self.firstTips =   self._binder:GetValue('firstTips')  


end

return BossWarAwardUIView
---自动生成代码----end----