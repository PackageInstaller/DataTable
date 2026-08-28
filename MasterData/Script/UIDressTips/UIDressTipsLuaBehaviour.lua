local View = require("UIDressTips/UIDressTipsView")
local DataModel = require("UIDressTips/UIDressTipsDataModel")
local ViewFunction = require("UIDressTips/UIDressTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local info = Json.decode(initParams)
      local dressCA = PlayerData:GetFactoryData(info.dressId, "HomeCharacterSkinFactory")
      View.Group_Show.Txt_Name:SetText(dressCA.name)
      View.Group_Show.ScrollView_Describe.Viewport.Txt_Describe:SetText(dressCA.des)
      View.Group_Show.Img_Icon:SetSprite(dressCA.iconPath)
      local tagCA = PlayerData:GetFactoryData(dressCA.skinType, "TagFactory")
      View.Group_Show.Img_Type:SetSprite(tagCA.icon)
      View.Group_Show.Txt_Type:SetText(tagCA.name)
      View.Group_Show.Group_Fashion.Group_FashionNum.Txt_Num:SetText(dressCA.fashion)
    end
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
