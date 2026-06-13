---自动生成代码----start----
local OtakuEmployeeOverviewUI = BaseClass( 'OtakuEmployeeOverviewUI' , BaseView )
local M = OtakuEmployeeOverviewUI 
--desc

function M:__init(go)
--require
  local OtakuEmployeeOverviewItemUI = require( 'UI.View.Otaku.EmployeeOverview.OtakuEmployeeOverviewItemUI')
  local OtakuEmployeeOverivewSimpleItemUI = require( 'UI.View.Otaku.EmployeeOverview.OtakuEmployeeOverivewSimpleItemUI')
--declare
  local trans = go.transform 
  self.detailItem = OtakuEmployeeOverviewItemUI.New(trans:Find("detailScrollView/Viewport/Content/detailItem").gameObject)
  self.detailScrollView = UIUtil.FindComponent( trans , typeof(CS.CircularScrollView.UICircularScrollView) , "detailScrollView" )
  self.simpleItem1 = OtakuEmployeeOverivewSimpleItemUI.New(trans:Find("detail/container/simpleItem1").gameObject)
  self.simpleItem2 = OtakuEmployeeOverivewSimpleItemUI.New(trans:Find("detail/container/simpleItem2").gameObject)
  self.simpleItem3 = OtakuEmployeeOverivewSimpleItemUI.New(trans:Find("detail/container/simpleItem3").gameObject)
  self.simpleItem4 = OtakuEmployeeOverivewSimpleItemUI.New(trans:Find("detail/container/simpleItem4").gameObject)
  self.simpleItem5 = OtakuEmployeeOverivewSimpleItemUI.New(trans:Find("detail/container/simpleItem5").gameObject)
  self.tab = UIUtil.FindComponent( trans , typeof(CS.GameX.BaseTab) , "tab" )
  self.maxLabel = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "detail/maxLabel" )
  self.detailLabel = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "detail/detailLabel" )
end
return OtakuEmployeeOverviewUI
---自动生成代码----end----