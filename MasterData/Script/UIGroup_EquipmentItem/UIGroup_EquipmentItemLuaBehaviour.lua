local View = require("UIGroup_EquipmentItem/UIGroup_EquipmentItemView")
local DataModel = require("UIGroup_EquipmentItem/UIGroup_EquipmentItemDataModel")
local ViewFunction = require("UIGroup_EquipmentItem/UIGroup_EquipmentItemViewFunction")

local function notGet()
  View.Group_Show.self:SetLocalPositionY(0)
end

local CA

local function haveGet()
  View.Group_Show.self:SetLocalPositionY(48)
  View.Group_Change.self:SetActive(true)
end

local function changeGet()
  View.Group_Show.self:SetLocalPositionY(48)
  View.Group_Strengthen.self:SetActive(true)
end

local buttomState = {
  [0] = notGet,
  [1] = haveGet,
  [2] = changeGet
}

local function init(parms)
  CA = PlayerData:GetFactoryData(parms.id)
  View.Img_FlagRare.Img_Equipment:SetSprite(parms.tipsPath)
  View.Img_FlagRare:SetSprite(UIConfig.TipConfig[tonumber(parms.qualityInt + 1)])
  View.Img_Rare:SetSprite(UIConfig.WeaponQuality[tonumber(parms.qualityInt + 1)])
  View.Img_Rare:SetNativeSize()
  View.Group_Equipment.Txt_EquipmentNum:SetText(parms.name)
  View.Group_Equipment.Txt_EquipmentLevel:SetText("LV " .. parms.server.lv or 0)
  local index = PlayerData:GetTypeInt("enumEquipTypeList", DataModel.equipCA.equipTagId)
  View.Img_EquipmentIcom:SetSprite(UIConfig.EquipmentTypeMark[index])
  View.Group_Lock.self:SetActive(true)
  View.Group_Lock.Btn_Lock:SetActive(false)
  View.Group_Lock.Btn_Unlock:SetActive(false)
  DataModel.isLockState = 0
  if DataModel.params.server.is_locked == nil or DataModel.params.server.is_locked == 0 then
    View.Group_Lock.Btn_Unlock:SetActive(true)
    DataModel.isLockState = 0
  else
    View.Group_Lock.Btn_Lock:SetActive(true)
    DataModel.isLockState = 1
  end
  View.Group_Two.self:SetActive(false)
  View.Group_One.self:SetActive(false)
  View.Img_whoBg:SetActive(false)
  if parms.server.hid and parms.server.hid ~= "" then
    View.Group_Two.self:SetActive(true)
    View.Img_whoBg.Txt_Character:SetActive(true)
    local name = PlayerData:GetFactoryData(parms.server.hid).name
    View.Img_whoBg:SetActive(true)
    View.Img_whoBg.Txt_Character:SetText(string.format(GetText(80600429), name))
  else
    View.Group_One.self:SetActive(true)
    View.Img_whoBg.Txt_Character:SetActive(false)
  end
  DataModel:RefreshRightContent()
  if DataModel.params.isPre then
    View.Group_Two.self:SetActive(false)
    View.Group_One.self:SetActive(false)
    View.Group_Lock.self:SetActive(false)
  end
end

local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel:SetUIScript("UIGroup_EquipmentItem/UIGroup_EquipmentItemView")
    if initParams then
      local data = Json.decode(initParams)
      DataModel.params = data
      DataModel.isChangeLock = false
      DataModel.eid = data.eid
      DataModel.itemId = data.id
      DataModel.equipCA = PlayerData:GetFactoryData(data.id)
      DataModel.EquipFactory = PlayerData:GetFactoryData(99900027)
      DataModel.server = PlayerData:GetEquipByEid(DataModel.eid) or {}
      local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(DataModel.equipCA, not DataModel.server or DataModel.server.lv or 1, 0, not DataModel.server or DataModel.server.bk_lv or 0)
      DataModel.Max_Affix_Num = PlayerData:GetFactoryData(DataModel.equipCA.equipTagId).typeName + math.floor(extraSkill)
      init(data)
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
