---自动生成代码----start----
local BagPreviewItemUI = BaseClass( 'BagPreviewItemUI' , BaseView )
local M = BagPreviewItemUI 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.icon = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "Item143/IconBg/Icon" )
  self.quality = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "Item143/IconBg/QualityColor" )
  self.numberTf = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "Item143/TextBg/Text" )
end
return BagPreviewItemUI
---自动生成代码----end----