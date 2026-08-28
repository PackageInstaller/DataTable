local View = require("UIActivityRechargeCommon/UIActivityRechargeCommonView")
local DataModel = require("UIActivityRechargeCommon/UIActivityRechargeCommonDataModel")
local Controller = require("UIActivityRechargeCommon/UIActivityRechargeCommonController")
local ViewFunction = {
  ActivityRechargeCommon_StaticGrid_RewardsList_SetGrid = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  ActivityRechargeCommon_Btn_Help_Click = function(btn, str)
    CommonTips.OpenHelp(80306628)
  end,
  ActivityRechargeCommon_Group_Diamond_Btn_Add_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  ActivityRechargeCommon_Group_Diamond_Btn_Icon_Click = function(btn, str)
  end,
  ActivityRechargeCommon_StaticGrid_RewardsList_Group_Common_Btn_Item_Click = function(btn, str)
    Controller:OnClick(tonumber(str))
  end
}
return ViewFunction
