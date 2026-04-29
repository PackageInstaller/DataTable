_class("UIHomelandToolLevelUp", UIController)
UIHomelandToolLevelUp = UIHomelandToolLevelUp

function UIHomelandToolLevelUp:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetHomelandBackpackData()
  self.mItem = GameGlobal.GetModule(ItemModule)
  self.mRole = GameGlobal.GetModule(RoleModule)
end

function UIHomelandToolLevelUp:OnShow(uiParams)
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.imgQuality = self:GetUIComponent("Image", "imgQuality")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.txtChangeDesc = self:GetUIComponent("UILocalizationText", "txtChangeDesc")
  self.cost = self:GetUIComponent("UISelectObjectPath", "cost")
  self.id = uiParams[1] or 0
  self:Flush()
end

function UIHomelandToolLevelUp:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIHomelandToolLevelUp:Flush()
  local item = self.data:GetItemById(self.id)
  local tpl = item:GetTemplate()
  self.imgIcon:LoadImage(tpl.Icon)
  self.imgQuality.color = UIForgeData.qualityColors[tpl.Color]
  self.txtName:SetText(StringTable.Get(tpl.Name))
  local tplId = item:GetTemplateID()
  local toolItem = self.data:GetHomelandBackpackToolItemByTplId(tplId)
  local toolItemNextLv = self.data:GetHomelandBackpackToolItemByTplId(toolItem.tplIdNextLv)
  if toolItemNextLv then
    local lvNextDesc = StringTable.Get("str_homeland_backpack_level_desc_" .. toolItemNextLv.tplId)
    self.txtChangeDesc:SetText(lvNextDesc)
  else
    self.txtChangeDesc:SetText("")
  end
  if toolItem.cost then
    local len = table.count(toolItem.cost)
    self.cost:SpawnObjects("UIItemHomeland", len)
    local uis = self.cost:GetAllSpawnList()
    for i, ui in ipairs(uis) do
      local ra = toolItem.cost[i]
      ui:Flush(ra, nil)
      ui:TxtCountRedIfNotEnough(ra.count)
    end
  end
end

function UIHomelandToolLevelUp:bgOnClick(go)
  self:CloseDialog()
end

function UIHomelandToolLevelUp:btnCloseOnClick(go)
  self:CloseDialog()
end

function UIHomelandToolLevelUp:btnConfirmOnClick(go)
  local item = self.data:GetItemById(self.id)
  local tplId = item:GetTemplateID()
  local toolItem = self.data:GetHomelandBackpackToolItemByTplId(tplId)
  if not toolItem:IsCostEnough() then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_backpack_upgrade_cost_not_enough"))
    return
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioUpgradeProp)
  self:StartTask(function(TT)
    local key = "UIHomelandToolLevelUp_btnConfirmOnClick"
    self:Lock(key)
    local res = self.mItem:ItemUpgradeByTemplate(TT, toolItem.tplId)
    self:UnLock(key)
    if UIHomelandBackpackData.CheckCode(res:GetResult()) then
      local tpl = item:GetTemplate()
      ToastManager.ShowHomeToast(StringTable.Get("str_homeland_backpack_tool_item_X_upgraded", StringTable.Get(tpl.Name)))
    end
    self:CloseDialog()
  end, self)
end
