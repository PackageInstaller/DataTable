local SettingItemType = CommonDefine.SettingItemType
local SettingBtnDropItem, Super = System.NewComponent("SettingBtnDropItem", SettingBaseItem)

function SettingBtnDropItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Setting_Content_DateResource(uiNode)
  self.data = data
end

function SettingBtnDropItem:OnBind(binder)
  local model = binder:createModel(SettingContentItemModel, self.data)
  self.model = model
  self.binder = binder
  self:InitBaseUIElement()
  binder:BindToText(self.ui.Text_Drop_Tips, function()
    do return LT.Text end
    return LT.Text, model.curDropData
  end)
  binder:BindToZ1Toggle(self.ui.Group_Drop, nil, function(isOn)
    if isOn then
      local function clickFunc(newText, setVal)
        binder:SetZ1Toggle(self.ui.Group_Drop, false)
        
        if newText then
          model:SetCurDropData(newText)
          SettingManager.Instance:SetSettingData(model.setUpUid, setVal)
          if model.setUpUid == CommonDefine.SettingUniqueName.GraphicQuality then
            SettingManager.Instance:EnableSetting(model.tid, model.dropList)
          else
            SettingManager.Instance:EnableSetting(model.tid, model.dropList, true)
          end
        end
      end
      
      local data = {
        dropList = model.dropList,
        parentNode = self.ui.Group_Drop_Sel,
        clickFunc = clickFunc,
        curText = model.curDropData,
        setUpUid = model.setUpUid,
        setupTab = model.setupTab
      }
      binder:BindNewComponentWithMask(UIManager.GetTipPopRoot(), SettingDropGroupItem, UI_Setting_Dropdown_GroupResource, data)
    end
  end)
  binder:BindEvent(EventMgr.Instance.GraphicSetting, function()
    model:RefreshData()
  end)
end

return SettingBtnDropItem
