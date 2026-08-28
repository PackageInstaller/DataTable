local View = require("UIGroup_WeaponBreakSuccess/UIGroup_WeaponBreakSuccessView")
local DataModel = require("UIGroup_WeaponBreakSuccess/UIGroup_WeaponBreakSuccessDataModel")
local ViewFunction = require("UIGroup_WeaponBreakSuccess/UIGroup_WeaponBreakSuccessViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local data = Json.decode(initParams)
      DataModel.equipCA = data.equipCA
      DataModel.equipLv = data.equipLv
      DataModel.lastBkLv = data.lastBkLv
      DataModel.curBkLv = data.curBkLv
      local equipConfig = PlayerData:GetFactoryData(99900027)
      View.Img_Equipment:SetSprite(DataModel.equipCA.tipsPath)
      local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(DataModel.equipCA, DataModel.equipLv, DataModel.lastBkLv, DataModel.curBkLv)
      View.Img_Message1.Txt_Level1:SetText(equipConfig.equipMaxLv + lastLv)
      View.Img_Message1.Txt_Level2:SetText(equipConfig.equipMaxLv + extraLv)
      View.Img_Message2.Txt_AttributeName:SetText(pro.name)
      View.Img_Message2.Txt_Num1:SetText(lastNum)
      View.Img_Message2.Txt_Num2:SetText(curNum)
      local content = View.Img_Message3.ScrollView_Content.Viewport.Content.Group_Entry
      local count = content.self.transform.childCount
      for i = 0, count - 1 do
        content.self.transform:GetChild(i):GetComponent(typeof(CS.Seven.UITxt)):SetActive(false)
      end
      local weaponBreakEffect
      if DataModel.equipCA.quality == "Orange" then
        weaponBreakEffect = equipConfig.URWeaponBreakCost
      elseif DataModel.equipCA.quality == "Golden" then
        weaponBreakEffect = equipConfig.SSRWeaponBreakCost
      elseif DataModel.equipCA.quality == "Purple" then
        weaponBreakEffect = equipConfig.SRWeaponBreakCost
      elseif DataModel.equipCA.quality == "Blue" then
        weaponBreakEffect = equipConfig.RWeaponBreakCost
      end
      DataModel.WeaponBreakEffect = weaponBreakEffect
      if lastAttr < extraAttr then
        local str = ""
        for i = 1, #DataModel.WeaponBreakEffect do
          if DataModel.WeaponBreakEffect[i].effect == "MainAttrUp" then
            str = GetText(DataModel.WeaponBreakEffect[i].effectDes)
            break
          end
        end
        content.self.transform:GetChild(0):GetComponent(typeof(CS.Seven.UITxt)):SetActive(true)
        content.self.transform:GetChild(1):GetComponent(typeof(CS.Seven.UITxt)):SetActive(true)
        str = string.format(str, PlayerData:GetPreciseDecimalFloor(extraAttr * 100))
        content.self.transform:GetChild(0):GetComponent(typeof(CS.Seven.UITxt)):SetText(str)
        local attrStr = GetText(80612190)
        attrStr = string.format(attrStr, pro.name, lastNum, pro.name, curNum)
        content.self.transform:GetChild(1):GetComponent(typeof(CS.Seven.UITxt)):SetText(attrStr)
      end
      if lastSkill < extraSkill then
        local str = ""
        for i = 1, #DataModel.WeaponBreakEffect do
          if DataModel.WeaponBreakEffect[i].effect == "AddRandomSkill" then
            str = GetText(DataModel.WeaponBreakEffect[i].effectDes)
            break
          end
        end
        content.self.transform:GetChild(2):GetComponent(typeof(CS.Seven.UITxt)):SetActive(true)
        str = string.format(str, PlayerData:GetPreciseDecimalFloor(extraSkill))
        content.self.transform:GetChild(2):GetComponent(typeof(CS.Seven.UITxt)):SetText(str)
      end
      if mainSkillUp then
        content.self.transform:GetChild(3):GetComponent(typeof(CS.Seven.UITxt)):SetActive(true)
        content.self.transform:GetChild(4):GetComponent(typeof(CS.Seven.UITxt)):SetActive(true)
        local skillCA = PlayerData:GetFactoryData(DataModel.equipCA.skillList[1].skillId)
        content.self.transform:GetChild(4):GetComponent(typeof(CS.Seven.UITxt)):SetText(skillCA.levelUpDescription)
      end
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  perupdate = function()
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
