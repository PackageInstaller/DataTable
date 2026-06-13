---自动生成代码----start----
local PlotReviewListView = BaseClass( 'PlotReviewListView' , BaseView )
local M = PlotReviewListView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_back =   self._binder:GetValue('btn_back')  
  self.node_list = self:AddBaseCom( CircularScrollView ,'node_list')
  self.node_banner =   self:AddValue('UI.Ctrl.ComRoom.PlotReviewChapterItemCtrl','UI.View.ComRoom.PlotReviewChapterItemView','node_banner')  


end

return PlotReviewListView
---自动生成代码----end----