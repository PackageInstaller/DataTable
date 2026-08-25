local T_Dropdown = typeof(CS.UnityEngine.UI.Dropdown)
local GmParamEquipView, Super = NewClass("GmParamEquipView", BaseView)
GmParamEquipView.uiResCls = GmParamEquipPanelResource
local MAX_PARAM = 7

function GmParamEquipView:ctor(gmConfig)
  Super.ctor(self)
  self._config = gmConfig
  self._dropDownObjs = {}
  self._equipMainAttrTbl = {}
  self._equipSubAttrTbl = {}
  self._dropDownShow = {}
  self._dropDownShowNum = 0
  self._dropdownComps = {}
  self._argList = {}
  self._dropdownEquipTypeTbl = {
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

function GmParamEquipView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Send, System.fn(self, self._OnClickSend))
  self:AddButtonClickListener(self.ui.Btn_Close, System.fn(self, self._OnClickClose))
  self:AddInputEndEditListener(self.ui.Input_Param1, System.fn(self, self._UpdateDropDownShow))
end

function GmParamEquipView:OnEnterView()
  Super.OnEnterView(self)
  self:SetRawText(self.ui.Text_GnName, "Gm命令: " .. self._config.name)
  for index = 1, MAX_PARAM do
    self:_SetTextParam(index)
  end
  table.insert(self._dropDownObjs, self.ui.Dropdown_MainAttr)
  local equipTypeOptions = self.ui.Dropdown_EquipType:GetComponent(T_Dropdown).options
  equipTypeOptions:Clear()
  local equipTypeHead = CS.UnityEngine.UI.Dropdown.OptionData()
  equipTypeHead.text = ""
  equipTypeOptions:Add(equipTypeHead)
  for _, value in pairs(self._dropdownEquipTypeTbl) do
    local equipTypeTmp = CS.UnityEngine.UI.Dropdown.OptionData()
    equipTypeTmp.text = value.name
    equipTypeOptions:Add(equipTypeTmp)
  end
  self:_UpdateDropDownShow()
  for index = 1, 5 do
    self:_BindDropdownChanged(self._dropDownObjs[index], function()
      self:_OnDropDownChange(index)
    end)
  end
end

function GmParamEquipView:OnExitView()
  self:_ClearDropdownListeners()
  Super.OnExitView(self)
end

function GmParamEquipView:_BindDropdownChanged(dropdownGo, callback)
  if not dropdownGo then
    return
  end
  local comp = dropdownGo:GetComponent(T_Dropdown)
  if not comp then
    return
  end
  comp.onValueChanged:RemoveAllListeners()
  comp.onValueChanged:AddListener(callback)
  self._dropdownComps[comp] = true
end

function GmParamEquipView:_ClearDropdownListeners()
  for comp, _ in pairs(self._dropdownComps) do
    if not IsNil(comp) then
      comp.onValueChanged:RemoveAllListeners()
    end
  end
  self._dropdownComps = {}
end

function GmParamEquipView:_UpdateDropDownShow()
  local inputID = tonumber(self:GetInputText(self.ui.Input_Param1))
  local equipItemConfig = ItemDataUtils.GetItemConfig(inputID)
  if not equipItemConfig or equipItemConfig.Type ~= CommonDefine.ItemType.Trinket then
    self:_ClearPanel()
    return
  end
  self._equipMainAttrTbl = {}
  self._equipSubAttrTbl = {}
  local trinketInfoList = ItemDataUtils.GetTrinketInfoByItemTid(inputID)
  local pos = ItemDataUtils.TrinketPosMap[trinketInfoList[1]]
  local equipMainAttrConfig = DT.Constant["TrinketMainAttrTypeWeight_" .. pos].Data
  local equipSubAttrConfig = DT.Constant["TrinketSubAttrTypeWeight_" .. pos].Data
  for i = 1, #equipMainAttrConfig, 2 do
    table.insert(self._equipMainAttrTbl, {
      id = equipMainAttrConfig[i],
      weight = equipMainAttrConfig[i + 1],
      name = DT.ActorAttrType[equipMainAttrConfig[i]].CnID
    })
  end
  for i = 1, #equipSubAttrConfig, 2 do
    table.insert(self._equipSubAttrTbl, {
      id = equipSubAttrConfig[i],
      weight = equipSubAttrConfig[i + 1],
      name = DT.ActorAttrType[equipSubAttrConfig[i]].CnID
    })
  end
  for i = 1, 5 do
    local localDropDownObj = self._dropDownObjs[i]
    local subOptions = localDropDownObj:GetComponent(T_Dropdown).options
    subOptions:Clear()
    local tmpTail = CS.UnityEngine.UI.Dropdown.OptionData()
    tmpTail.text = ""
    subOptions:Add(tmpTail)
    local equipAttrConfig = self._equipSubAttrTbl
    if 5 == i then
      equipAttrConfig = self._equipMainAttrTbl
    end
    for _, value in pairs(equipAttrConfig) do
      if 0 == value.weight then
        return
      end
      local d = CS.UnityEngine.UI.Dropdown.OptionData()
      d.text = value.name
      subOptions:Add(d)
      if self._dropDownShow[d.text] == nil then
        self._dropDownShow[d.text] = 1
      end
    end
    local tmpTail1 = CS.UnityEngine.UI.Dropdown.OptionData()
    tmpTail1.text = ""
    subOptions:Add(tmpTail1)
    localDropDownObj:GetComponent(T_Dropdown).value = 0
  end
end

function GmParamEquipView:_OnDropDownChange(index)
  if self._dropDownObjs[index]:GetComponent(T_Dropdown).value == self._dropDownShowNum then
    return
  end
  local haveShowDDList = {}
  for j = 1, 5 do
    local chooseVal = self._dropDownObjs[j]:GetComponent(T_Dropdown).captionText.text
    haveShowDDList[chooseVal] = 1
  end
  for j = 1, 5 do
    local options = self._dropDownObjs[j]:GetComponent(T_Dropdown).options
    options:Clear()
    local tmp = CS.UnityEngine.UI.Dropdown.OptionData()
    tmp.text = ""
    options:Add(tmp)
    local tmpNum = 1
    local optionAddList = {}
    for key, _ in pairs(self._dropDownShow) do
      if nil == haveShowDDList[key] then
        table.insert(optionAddList, key)
        tmpNum = tmpNum + 1
      end
      self._dropDownShowNum = tmpNum
    end
    for _, value in pairs(self._equipMainAttrTbl) do
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
  local tmpStr = self._dropDownObjs[index]:GetComponent(T_Dropdown).captionText.text
  self._dropDownObjs[index]:GetComponent(T_Dropdown).captionText.text = tmpStr
end

function GmParamEquipView:_SetTextParam(index)
  local textParamObj = self.ui["Text_Param" .. index]
  local argName = self._config["arg" .. index]
  if index <= 4 then
    table.insert(self._dropDownObjs, self.ui["Dropdown_SubAttr" .. index])
  end
  if textParamObj then
    self:SetRawText(textParamObj, argName .. ": ")
  end
end

function GmParamEquipView:_OnClickSend()
  self._argList = {}
  local tempStr = tostring(self:GetInputText(self.ui.Input_Param1))
  if "" == tempStr then
    table.insert(self._argList, 0)
  end
  table.insert(self._argList, tonumber(self:GetInputText(self.ui.Input_Param1)))
  tempStr = tostring(self.ui.Dropdown_EquipType:GetComponent(T_Dropdown).captionText.text)
  self:_GetDropDownInput(tempStr, self._dropdownEquipTypeTbl)
  tempStr = tostring(self._dropDownObjs[5]:GetComponent(T_Dropdown).captionText.text)
  self:_GetDropDownInput(tempStr, self._equipMainAttrTbl)
  for index = 1, 4 do
    tempStr = tostring(self._dropDownObjs[index]:GetComponent(T_Dropdown).captionText.text)
    self:_GetDropDownInput(tempStr, self._equipSubAttrTbl)
  end
  Logger.Info("GmCommond cmd=%s, arg1=%s arg2=%s", self._config.name, table.tostring(self._argList))
  GmManager.Instance.TriggerGm(self._config.id, table.unpack(self._argList))
  UIManager.Instance:Show(Urls.PopMsgPanel, "装备添加成功")
end

function GmParamEquipView:_GetDropDownInput(str, tbl)
  if "" == str then
    table.insert(self._argList, 0)
  else
    for _, value in pairs(tbl) do
      if value.name == str then
        table.insert(self._argList, value.id)
      end
    end
  end
end

function GmParamEquipView:_ClearPanel()
  for i = 1, 5 do
    if self._dropDownObjs[i] then
      self._dropDownObjs[i]:GetComponent(T_Dropdown).options:Clear()
      self._dropDownObjs[i]:GetComponent(T_Dropdown).captionText.text = ""
    end
  end
end

function GmParamEquipView:_OnClickClose()
  self:_ClearPanel()
  self:Close()
end

return GmParamEquipView
