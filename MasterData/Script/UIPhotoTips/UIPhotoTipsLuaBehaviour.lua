local View = require("UIPhotoTips/UIPhotoTipsView")
local DataModel = require("UIPhotoTips/UIPhotoTipsDataModel")
local ViewFunction = require("UIPhotoTips/UIPhotoTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local info = Json.decode(initParams)
      local photoCA = PlayerData:GetFactoryData(info.photoId, "ProfilePhotoFactory")
      View.Img_BG.Img_Photo.Img_Character:SetSprite(photoCA.imagePath)
      View.Img_BG.Img_name.Txt_Name:SetText(photoCA.name)
      View.Img_BG.Txt_Des:SetText(photoCA.des)
      CommonTips:SetPlayerHeadShader(View.Img_BG.Img_Photo.Img_spAdd, photoCA)
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
