---自动生成代码----start----
local CreateSelectAreaUI = BaseClass( 'CreateSelectAreaUI' , BaseView )
local M = CreateSelectAreaUI 
--desc

function M:__init(go)
--require
  local ItemPfbView = require( 'UI.View.Common.ItemPfbView')
  local CreateNumberBarUI = require( 'UI.View.Create.CreateNumberBarUI')
--declare
  local trans = go.transform 
  self.okBtn = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "preview/ok" )
  self.item = ItemPfbView.New(trans:Find("preview/ItemPfbSmall1").gameObject)
  self.titlieTf = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "preview/title" )
  self.numberBar = CreateNumberBarUI.New(trans:Find("preview/numberBar").gameObject)
  self.timeText = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "preview/timeText" )
end
return CreateSelectAreaUI
---自动生成代码----end----