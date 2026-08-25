local DBGTeamManageItem, Super = System.NewComponent("DBGTeamManageItem")

function DBGTeamManageItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Team_Item_MyTeam_ListResource(res)
  self.clickFunc = data.clickFunc
  self.fightedFunc = data.fightedFunc
  self.selectedFunc = data.selectedFunc
  self.index = data.index
  self.model = data.model
  self.teamData = self.model:GetTeamDataByIdx(self.index)
end

function DBGTeamManageItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Choose_Team, function()
    if not self.model:IsTeamUnlocked(self.index) then
      DBGTeamDataUtils.ReqUnlockTeam(self.model.teamType, self.index, function()
        self.model:OnTeamUnlocks(self.index)
      end)
      return
    end
    if self.clickFunc then
      self.clickFunc()
    end
  end)
  binder:BindButtonClick(self.ui.Btn_Change_Name, function()
    if not self.model:IsTeamUnlocked(self.index) then
      return
    end
    UIManager.Instance:Reopen(Urls.DBGTeamRenamePanel, self.model, self.index)
  end)
  binder:BindToVisible(self.ui.Image_Current, function()
    if self.fightedFunc then
      do return end
      return self.fightedFunc, nil
    end
  end)
  binder:BindToVisible(self.ui.Image_D_Bg, function()
    if self.selectedFunc then
      do return end
      return self.selectedFunc, nil
    end
  end)
  binder:BindToText(self.ui.Text_Number, function()
    do return LT.Text end
    return LT.Text, self.model.indexTranMap[self.index], self.index
  end)
  binder:BindToText(self.ui.Text_Team_Name, function()
    do return LT.Text, DBGTeamDataUtils.GetDBGTeamName(self.model.teamType, self.index) end
    return LT.Text, DBGTeamDataUtils.GetDBGTeamName(self.model.teamType, self.index)
  end)
  binder:BindToVisible(self.ui.Image_Locked, function()
    return not self.model:IsTeamUnlocked(self.index)
  end)
  binder:BindToVisible(self.ui.Text_CanUnlock, function()
    if not self.model:IsTeamUnlocked(self.index) and self.model:IsTeamUnlocked(self.index - 1) then
      return true
    end
  end)
  binder:SetText(self.ui.Text_CanUnlock, "Unlockable")
  self:_OnBindAwakerInfo(binder)
  self:_OnBindKeeperSkillInfo(binder)
end

function DBGTeamManageItem:_OnBindAwakerInfo(binder)
  local awakerTids = self.teamData.awakerTidList
  for i = 1, 4 do
    local objUI = self.ui["Awaker_" .. i]
    local awakerTid = awakerTids[i]
    if not awakerTid or 0 == awakerTid then
      objUI:SetActive(false)
    else
      objUI:SetActive(true)
      local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
      local itemData = {
        awakerId = awakerTid,
        itemCount = string.format("Lv.%s", awakerData.level)
      }
      binder:BindComponent(CommonIconItemType2(objUI, itemData))
    end
  end
end

function DBGTeamManageItem:_OnBindKeeperSkillInfo(binder)
  local keeperSkillTid = self.teamData.keeperSkillTid
  self.ui.Image_KeeperSkill:SetActive(0 ~= keeperSkillTid)
  binder:BindToImage(self.ui.Image_KeeperSkill, function()
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, keeperSkillTid
  end)
end

return DBGTeamManageItem
