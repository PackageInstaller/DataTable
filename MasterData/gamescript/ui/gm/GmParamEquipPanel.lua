local typeof = _ENV.typeof
local Text = typeof(CS.UnityEngine.UI.Text)
local Dropdown = typeof(CS.UnityEngine.UI.Dropdown)
local InputField = typeof(CS.UnityEngine.UI.InputField)
local GmParamEquipPanel, Super = System.NewClass("GmParamEquipPanel", UIBasePanel)
GmParamEquipPanel.uiResCls = GmParamEquipPanelResource
local MAX_PARAM = 7

function GmParamEquipPanel:ctor(gmConfig)
  Super.ctor(self)
  self.config = gmConfig
  self.dropDownObjs = {}
  self.equipMainAttrTbl = {}
  self.equipSubAttrTbl = {}
  self.dropDownShow = {}
  self.dropDownShowNum = 0
  self.dropdownEquipTypeTbl = {
    [1] = {
      id = 1,
      name = "生成普通特定装备"
    },
    [2] = {
      id = 2,
      name = "生成满级满副属性装备"
    },
    [3] = {
      id = 3,
      name = "生成满级最低属性装备"
    }
  }
end

function GmParamEquipPanel:OnBind(binder)
  self.binder = binder
  self.ui.Text_GnName:GetComponent(typeof(Text)).text = "Gm命令: " .. self.config.name
  self.binder:BindButtonClick(self.ui.Btn_Send, System.fn(self, self.OnClickSend))
  self.binder:BindButtonClick(self.ui.Btn_Close, System.fn(self, self.OnClickClose))
  self.binder:BindToInputEndEdit(self.ui.Input_Param1, System.fn(self, self.UpdateDropDownShow))
  for index = 1, MAX_PARAM do
    self:SetTextParam(index)
  end
  table.insert(self.dropDownObjs, self.ui.Dropdown_MainAttr)
  local equipTypeOptions = self.ui.Dropdown_EquipType:GetComponent(Dropdown).options
  equipTypeOptions:Clear()
  local equipTypeHead = CS.UnityEngine.UI.Dropdown.OptionData()
  equipTypeHead.text = ""
  equipTypeOptions:Add(equipTypeHead)
  for _, value in pairs(self.dropdownEquipTypeTbl) do
    local equipTypeTmp = CS.UnityEngine.UI.Dropdown.OptionData()
    equipTypeTmp.text = value.name
    equipTypeOptions:Add(equipTypeTmp)
  end
  self:UpdateDropDownShow()
  for index = 1, 5 do
    self.binder:BindDropdownChanged(self.dropDownObjs[index], function()
      self:OnDropDownChange(index)
    end)
  end
end

function GmParamEquipPanel:UpdateDropDownShow()
  local inputID = tonumber(self.ui.Input_Param1:GetComponent(InputField).text)
  local equipItemConfig = ItemDataUtils.GetItemConfig(inputID)
  if not equipItemConfig or equipItemConfig.Type ~= CommonDefine.ItemType.Trinket then
    self:ClearPanel()
    return
  end
  self.equipMainAttrTbl = {}
  self.equipSubAttrTbl = {}
  local trinketInfoList = ItemDataUtils.GetTrinketInfoByItemTid(inputID)
  local pos = ItemDataUtils.TrinketPosMap[trinketInfoList[1]]
  print("trinketInfoList ", table.tostring(trinketInfoList))
  print("trinketInfoList ", DT.Constant["TrinketMainAttrTypeWeight_" .. pos])
  local equipMainAttrConfig = DT.Constant["TrinketMainAttrTypeWeight_" .. pos].Data
  local equipSubAttrConfig = DT.Constant["TrinketSubAttrTypeWeight_" .. pos].Data
  for i = 1, #equipMainAttrConfig, 2 do
    table.insert(self.equipMainAttrTbl, {
      id = equipMainAttrConfig[i],
      weight = equipMainAttrConfig[i + 1],
      name = DT.ActorAttrType[equipMainAttrConfig[i]].CnID
    })
  end
  for i = 1, #equipSubAttrConfig, 2 do
    table.insert(self.equipSubAttrTbl, {
      id = equipSubAttrConfig[i],
      weight = equipSubAttrConfig[i + 1],
      name = DT.ActorAttrType[equipSubAttrConfig[i]].CnID
    })
  end
  for i = 1, 5 do
    local localDropDownObj = self.dropDownObjs[i]
    local subOptions = localDropDownObj:GetComponent(Dropdown).options
    subOptions:Clear()
    local tmpTail = CS.UnityEngine.UI.Dropdown.OptionData()
    tmpTail.text = ""
    subOptions:Add(tmpTail)
    local equipAttrConfig = self.equipSubAttrTbl
    if 5 == i then
      equipAttrConfig = self.equipMainAttrTbl
    end
    for _, value in pairs(equipAttrConfig) do
      if 0 == value.weight then
        return
      end
      local d = CS.UnityEngine.UI.Dropdown.OptionData()
      d.text = value.name
      subOptions:Add(d)
      if self.dropDownShow[d.text] == nil then
        self.dropDownShow[d.text] = 1
      end
    end
    local tmpTail1 = CS.UnityEngine.UI.Dropdown.OptionData()
    tmpTail1.text = ""
    subOptions:Add(tmpTail1)
    localDropDownObj:GetComponent(Dropdown).value = 0
  end
end

function GmParamEquipPanel:OnDropDownChange(index)
  if self.dropDownObjs[index]:GetComponent(Dropdown).value == self.dropDownShowNum then
    return
  end
  local haveShowDDList = {}
  for j = 1, 5 do
    local chooseVal = self.dropDownObjs[j]:GetComponent(Dropdown).captionText.text
    haveShowDDList[chooseVal] = 1
  end
  for j = 1, 5 do
    local options = self.dropDownObjs[j]:GetComponent(Dropdown).options
    options:Clear()
    local tmp = CS.UnityEngine.UI.Dropdown.OptionData()
    tmp.text = ""
    options:Add(tmp)
    local tmpNum = 1
    local optionAddList = {}
    for key, _ in pairs(self.dropDownShow) do
      if nil == haveShowDDList[key] then
        table.insert(optionAddList, key)
        tmpNum = tmpNum + 1
      end
      self.dropDownShowNum = tmpNum
    end
    for _, value in pairs(self.equipMainAttrTbl) do
      for _, addName in pairs(optionAddList) do
        if value.name == addName then
          local d = CS.UnityEngine.UI.Dropdown.OptionData()
          d.text = addName
          options:Add(d)
        end
      end
    end
    local tmpTail = CS.UnityEngine.UI.Dropdown.OptionData()
    tmpTail.text = ""
    options:Add(tmpTail)
  end
  local tmpStr = self.dropDownObjs[index]:GetComponent(Dropdown).captionText.text
  self.dropDownObjs[index]:GetComponent(Dropdown).captionText.text = tmpStr
end

function GmParamEquipPanel:SetTextParam(index)
  local textParamObj = self.ui["Text_Param" .. index]
  local argName = self.config["arg" .. index]
  if index <= 4 then
    table.insert(self.dropDownObjs, self.ui["Dropdown_SubAttr" .. index])
  end
  textParamObj:GetComponent(Text).text = argName .. ": "
end

function GmParamEquipPanel:OnClickSend()
  self.argList = {}
  local tempStr = tostring(self.ui.Input_Param1:GetComponent(InputField).text)
  if "" == tempStr then
    table.insert(self.argList, 0)
  end
  table.insert(self.argList, tonumber(self.ui.Input_Param1:GetComponent(InputField).text))
  tempStr = tostring(self.ui.Dropdown_EquipType:GetComponent(Dropdown).captionText.text)
  self:GetDropDownInput(tempStr, self.dropdownEquipTypeTbl)
  tempStr = tostring(self.dropDownObjs[5]:GetComponent(Dropdown).captionText.text)
  self:GetDropDownInput(tempStr, self.equipMainAttrTbl)
  for index = 1, 4 do
    tempStr = tostring(self.dropDownObjs[index]:GetComponent(Dropdown).captionText.text)
    self:GetDropDownInput(tempStr, self.equipSubAttrTbl)
  end
  Logger.Info("GmCommond cmd=%s, arg1=%s arg2=%s", self.config.name, table.tostring(self.argList))
  GmManager.Instance.TriggerGm(self.config.id, table.unpack(self.argList))
  UIManager.Instance:Show(Urls.PopMsgPanel, "装备添加成功")
end

function GmParamEquipPanel:GetDropDownInput(str, tbl)
  if "" == str then
    table.insert(self.argList, 0)
  else
    for _, value in pairs(tbl) do
      if value.name == str then
        table.insert(self.argList, value.id)
      end
    end
  end
end

function GmParamEquipPanel:ClearPanel()
  for i = 1, 5 do
    self.dropDownObjs[i]:GetComponent(Dropdown).options:Clear()
    self.dropDownObjs[i]:GetComponent(Dropdown).captionText.text = ""
  end
end

function GmParamEquipPanel:OnClickClose()
  self:ClearPanel()
  UIManager.Instance:CloseByUrl(Urls.GmParamEquipPanel)
end

return GmParamEquipPanel
