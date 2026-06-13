---自动生成代码----start----
local SetQualityView = BaseClass( 'SetQualityView' , BaseView )
local M = SetQualityView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tg_low = self:AddBaseCom( UIToggle ,'tg_low')
  self.tg_medium = self:AddBaseCom( UIToggle ,'tg_medium')
  self.tg_high = self:AddBaseCom( UIToggle ,'tg_high')
  self.tg_30 = self:AddBaseCom( UIToggle ,'tg_30')
  self.tg_45 = self:AddBaseCom( UIToggle ,'tg_45')
  self.tg_60 = self:AddBaseCom( UIToggle ,'tg_60')
  self.tg_anti_aliasing = self:AddBaseCom( UIToggle ,'tg_anti_aliasing')
  self.slider_screenFit = self:AddBaseCom( UISlider ,'slider_screenFit')
  self.tgGroup_quality = self:AddBaseCom( UIToggleGroup ,'tgGroup_quality')
  self.battle_bg_30 = self:AddBaseCom( UIToggle ,'battle_bg_30')
  self.battle_bg_45 = self:AddBaseCom( UIToggle ,'battle_bg_45')
  self.battle_bg_60 = self:AddBaseCom( UIToggle ,'battle_bg_60')


end

return SetQualityView
---自动生成代码----end----