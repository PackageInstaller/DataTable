---自动生成代码----start----
local OtakuEmployeeOverivewSimpleItemUI = BaseClass( 'OtakuEmployeeOverivewSimpleItemUI' , BaseView )
local M = OtakuEmployeeOverivewSimpleItemUI 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.normal = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "normal" )
  self.lock = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "lock" )
  self.empty = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "empty" )
  self.name = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "normal/name" )
  self.state = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "normal/state" )
  self.value = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "normal/value" )
end
return OtakuEmployeeOverivewSimpleItemUI
---自动生成代码----end----