---自动生成代码----start----
local ManufacturePanel = BaseClass( 'ManufacturePanel' , BaseView )
local M = ManufacturePanel 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.itemScroll = UIUtil.FindComponent( trans , typeof(CS.CircularScrollView.UICircularScrollView) , "gridArea/Scroll View" )
  self.addBtn = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "gridArea/addBtn" )
end
return ManufacturePanel
---自动生成代码----end----