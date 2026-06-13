---自动生成代码----start----
local OtakuRoomsOverivewHeroItemUI = BaseClass( 'OtakuRoomsOverivewHeroItemUI' , BaseView )
local M = OtakuRoomsOverivewHeroItemUI 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.noPos = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "noPos" )
  self.lock = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "lock" )
  self.HeroHeadItem = UIUtil.FindComponent( trans , typeof(CS.GameX.HeroHeadItem) , "container/HeroHeadItem" )
  self.Slider = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Slider) , "container/Slider" )
  self.plus = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "plus" )
  self.hunger = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "container/hunger" )
  self.container = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "container" )
end
return OtakuRoomsOverivewHeroItemUI
---自动生成代码----end----