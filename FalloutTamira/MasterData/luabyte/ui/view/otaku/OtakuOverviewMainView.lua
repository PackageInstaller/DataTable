---自动生成代码----start----
local OtakuOverviewMainView = BaseClass( 'OtakuOverviewMainView' , BaseView )
local M = OtakuOverviewMainView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.listPanel =   self:AddValue('UI.Ctrl.Otaku.OtakuOverviewListCtrl','UI.View.Otaku.OtakuOverviewListView','listPanel')  
  self.infoPanel =   self:AddValue('UI.Ctrl.Otaku.OtakuOverviewInfoCtrl','UI.View.Otaku.OtakuOverviewInfoView','infoPanel')  


end

return OtakuOverviewMainView
---自动生成代码----end----