---自动生成代码----start----
local OtakuOverviewListView = BaseClass( 'OtakuOverviewListView' , BaseView )
local M = OtakuOverviewListView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item1 =   self:AddValue('UI.Ctrl.Otaku.OtakuOverviewItem1Ctrl','UI.View.Otaku.OtakuOverviewItem1View','item1')  
  self.item2 =   self:AddValue('UI.Ctrl.Otaku.OtakuOverviewItem2Ctrl','UI.View.Otaku.OtakuOverviewItem2View','item2')  
  self.item3 =   self:AddValue('UI.Ctrl.Otaku.OtakuOverviewItem3Ctrl','UI.View.Otaku.OtakuOverviewItem3View','item3')  


end

return OtakuOverviewListView
---自动生成代码----end----