---自动生成代码----start----
local TraingingSetHero = BaseClass( 'TraingingSetHero' , BaseView )
local M = TraingingSetHero 
--desc

function M:__init(go)
--require
  local TraingingHeroPrefab = require( 'UI.View.TraingingHeroPrefab')
--declare
  local trans = go.transform 
  self.BG = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "BG" )
  self.HeroPrefab = TraingingHeroPrefab.New(trans:Find("Scroll View/Viewport/Content/TraingingHeroPrefab").gameObject)
  self.btn_enter = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "Btn/EnterBtn" )
  self.btn_cancel = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "Btn/CancalBtn" )
end
return TraingingSetHero
---自动生成代码----end----