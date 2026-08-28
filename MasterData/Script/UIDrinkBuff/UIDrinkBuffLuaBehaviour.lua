local View = require("UIDrinkBuff/UIDrinkBuffView")
local DataModel = require("UIDrinkBuff/UIDrinkBuffDataModel")
local ViewFunction = require("UIDrinkBuff/UIDrinkBuffViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    if data.buffId == 0 then
      return
    end
    local buffCA = PlayerData:GetFactoryData(data.buffId, "HomeBuffFactory")
    local oneForAll = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.OneForAll)
    local desc = buffCA.desc
    if 0 < oneForAll then
      desc = buffCA.intensifyDesc
    end
    View.Group_1.Txt_Dec:SetText(desc)
    local min = buffCA.continueTime / 60
    View.Group_1.Txt_Time:SetText(string.format(GetText(80600958), min))
    View.Group_Huifu.Txt_Pilao:SetActive(0 < data.recoverEnergy)
    View.Group_Huifu.Txt_Pilao:SetText(string.format(GetText(80600961), data.recoverEnergy))
    View.Group_Huifu.Txt_Man:SetActive(0 >= data.recoverEnergy)
    View.Txt_1:SetText(buffCA.name)
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
