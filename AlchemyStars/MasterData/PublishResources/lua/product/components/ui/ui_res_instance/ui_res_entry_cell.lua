_class("UIResEntryCell", UICustomWidget)
UIResEntryCell = UIResEntryCell

function UIResEntryCell:OnShow()
  self.nameTxt = self:GetUIComponent("UILocalizationText", "name")
  self.materialTxt = self:GetUIComponent("UILocalizationText", "material")
  self.dateTxt = self:GetUIComponent("UILocalizationText", "date")
  self.picImg = self:GetUIComponent("Image", "pic")
  self.unOpenTxt = self:GetUIComponent("UILocalizationText", "notopen")
  self.atlas = self:GetAsset("UIResInstance.spriteatlas", LoadType.SpriteAtlas)
  self.maskGO = self:GetGameObject("mask")
  self.rectTrans = self:GetGameObject().transform:GetComponent("RectTransform")
  self.anim = self:GetGameObject().transform:GetComponent("Animation")
  self.module = self:GetModule(ResDungeonModule)
end

function UIResEntryCell:Refresh(entryData, dontShowAni)
  self.entryData = entryData
  local name = self.entryData:GetEntryName()
  self.nameTxt:SetText(name)
  local materialName = self.entryData:GetMaterialName()
  self.materialTxt:SetText(materialName)
  local date = self.entryData:GetShowDate()
  self.dateTxt:SetText(date)
  self.picImg.sprite = self.atlas:GetSprite(self.entryData:GetEntryPic())
  self:SetPos()
  self:CheckOpen(dontShowAni)
end

function UIResEntryCell:GetMainType()
  return self.entryData and self.entryData:GetMainType()
end

function UIResEntryCell:SetPos()
  self.rectTrans.anchoredPosition = self.entryData:GetPos()
end

function UIResEntryCell:OnHide()
end

function UIResEntryCell:picOnClick(_, subType)
  self:StartTask(function(TT)
    local mainType = self.entryData:GetMainType()
    local resDungeonModule = self:GetModule(ResDungeonModule)
    local clientResInstance = resDungeonModule:GetClientResInstance()
    local result, data
    if mainType == DungeonType.DungeonType_Coin then
      result, data = resDungeonModule:GetCoinInstanceData(TT)
    elseif mainType == DungeonType.DungeonType_Experience then
      local subKey = clientResInstance.resInstanceSubLocalDBKey
      LocalDB.SetInt(subKey, 0)
      result, data = resDungeonModule:GetExperienceInstanceData(TT)
    elseif mainType == DungeonType.DungeonType_AircraftMaterial then
      result, data = resDungeonModule:GetAircraftmaterialInstanceData(TT)
    elseif mainType == DungeonType.DungeonType_equip then
      result, data = resDungeonModule:GetEquipInstanceData(TT)
    end
    if result == OpenStatus.Dungeon_OpenToday then
      if self.isOpen == false then
        local result = resDungeonModule:GetOpenStatus(TT)
        if result ~= {} then
          local controller = GameGlobal.UIStateManager():GetController("UIResEntryController")
          if controller then
            controller:Refresh()
          end
        end
      end
      self:ShowDialog("UIResDetailController", mainType, subType)
    elseif result == OpenStatus.Dungeon_CloseToday then
      if self.isOpen == false then
        ToastManager.ShowToast(StringTable.Get("str_res_instance_entry_not_open_msg"))
        return
      else
        ToastManager.ShowToast(StringTable.Get("str_res_instance_entry_kuatian_msg"))
        local result = resDungeonModule:GetOpenStatus(TT)
        if result ~= {} then
          local controller = GameGlobal.UIStateManager():GetController("UIResEntryController")
          if controller then
            controller:Refresh()
          end
        end
      end
    elseif result == OpenStatus.Dungeon_ReturnError or result == OpenStatus.Dungeon_StatusError then
      ToastManager.ShowToast(StringTable.Get("str_toast_manager_res_controller_open_unusual"))
    elseif result == OpenStatus.Dungeon_EntryLocked then
      local condMissionID = Cfg.cfg_res_instance_entry[mainType].condition
      condMissionName = DiscoveryStage.GetStageIndexString(condMissionID)
      local text = StringTable.Get("str_res_instance_entry_unlock_cond", condMissionName)
      ToastManager.ShowToast(text)
    end
  end, self)
end

function UIResEntryCell:CheckOpen(dontShowAni)
  local mainType = self.entryData:GetMainType()
  local openStatus = self.module:GetEntryOpenStatus(mainType)
  self.isOpen = openStatus == OpenStatus.Dungeon_OpenToday
  self.maskGO:SetActive(not self.isOpen)
  if openStatus == OpenStatus.Dungeon_OpenToday then
    self.unOpenTxt:SetText(StringTable.Get("str_res_instance_entry_not_open"))
  elseif openStatus == OpenStatus.Dungeon_EntryLocked then
    self.unOpenTxt:SetText(StringTable.Get("str_res_instance_entry_locking"))
  end
  if not dontShowAni then
    if self.isOpen then
      self.anim:Play("eff_UIResEntryCell_1")
    else
      self.anim:Play("eff_UIResEntryCell_2")
    end
  end
end
