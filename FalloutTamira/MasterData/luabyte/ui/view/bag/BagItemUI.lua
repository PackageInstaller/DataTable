---自动生成代码----start----
local BagItemUI = BaseClass( 'BagItemUI' , BaseView )
local M = BagItemUI 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.icon = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "Item210/IconBg/Icon" )
  self.quality = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "Item210/IconBg/QualityColor" )
  self.numberTf = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "Item210/TextBg/Text" )
  self.select = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "select" )
end
return BagItemUI
---自动生成代码----end----