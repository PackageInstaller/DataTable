local View = require("UIGroup_StrengthenWindow/UIGroup_StrengthenWindowView")
local DataModel = require("UIGroup_StrengthenWindow/UIGroup_StrengthenWindowDataModel")
local ViewFunction = require("UIGroup_StrengthenWindow/UIGroup_StrengthenWindowViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local param = Json.decode(initParams)
    DataModel.Data = param
    print_r(param)
    print_r("\229\188\186\229\140\150\230\136\144\229\138\159----------------")
    View.Img_Equipment:SetSprite(param.ca.tipsPath)
    View.Img_Message1.Txt_EquipmentName:SetText(param.ca.name)
    View.Img_Message1.Txt_Level1:SetText("LV " .. param.beforeLv)
    View.Img_Message1.Txt_Level2:SetText("LV " .. param.nowLv)
    local pro_before, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(param.ca, param.beforeLv, 0, param.bk_lv or 0)
    View.Img_Message2.Txt_AttributeName:SetText(pro_before.name)
    View.Img_Message2.Txt_Num1:SetText(curNum)
    local pro_now, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(param.ca, param.nowLv, 0, param.bk_lv or 0)
    View.Img_Message2.Txt_Num2:SetText(curNum)
    DataModel:Clear()
    local list = {}
    for k, v in pairs(DataModel.Data.content) do
      list[v.index] = v
    end
    DataModel:RefreshRightDownContent(list)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
