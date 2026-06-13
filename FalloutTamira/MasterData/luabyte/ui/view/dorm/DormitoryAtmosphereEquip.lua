---自动生成代码----start----
local DormitoryAtmosphereEquip = BaseClass( 'DormitoryAtmosphereEquip' , BaseView )
local M = DormitoryAtmosphereEquip 
--desc

function M:__init(go)
--require
  local DormAtmosphereItem = require( 'UI.View.Dorm.DormAtmosphereItem')
--declare
  local trans = go.transform 
  self.CurValue = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "Bg/DescBg/Title/Value" )
  self.NextValue = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Text) , "Bg/DescBg/Line2/NextAtmosphere/Value" )
  self.NextPanel = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Bg/DescBg/AttributePanel2" )
  self.Curattr1 = DormAtmosphereItem.New(trans:Find("Bg/DescBg/AttributePanel1/attrBg1").gameObject)
  self.Curattr2 = DormAtmosphereItem.New(trans:Find("Bg/DescBg/AttributePanel1/attrBg2").gameObject)
  self.Curattr3 = DormAtmosphereItem.New(trans:Find("Bg/DescBg/AttributePanel1/attrBg3").gameObject)
  self.Curattr4 = DormAtmosphereItem.New(trans:Find("Bg/DescBg/AttributePanel1/attrBg4").gameObject)
  self.Nextattr1 = DormAtmosphereItem.New(trans:Find("Bg/DescBg/AttributePanel2/attrBg1").gameObject)
  self.Nextattr2 = DormAtmosphereItem.New(trans:Find("Bg/DescBg/AttributePanel2/attrBg2").gameObject)
  self.Nextattr3 = DormAtmosphereItem.New(trans:Find("Bg/DescBg/AttributePanel2/attrBg3").gameObject)
  self.Nextattr4 = DormAtmosphereItem.New(trans:Find("Bg/DescBg/AttributePanel2/attrBg4").gameObject)
  self.CurPanel = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Bg/DescBg/AttributePanel1" )
  self.Close = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.UI.Image) , "Close" )
  self.CurTips = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Bg/DescBg/Tips1" )
  self.NextTips = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Bg/DescBg/Tips2" )
  self.NextAtmosphere = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.RectTransform) , "Bg/DescBg/Line2/NextAtmosphere" )
end
return DormitoryAtmosphereEquip
---自动生成代码----end----