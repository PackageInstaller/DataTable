local DBGTeamListAwakerGroupItem, Super = System.NewComponent("DBGTeamListAwakerGroupItem")

function DBGTeamListAwakerGroupItem:ctor(res, dbgTeamBuildModel, index)
  Super.ctor(self)
  self.ui = UI_Team_Item_MyTeam_ListResource(res)
  self.model = dbgTeamBuildModel
  self.index = index
end

function DBGTeamListAwakerGroupItem:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Change_Name, System.fn(self, self.OnChangeName))
  binder:BindButtonClick(self.ui.Btn_Choose_Team, System.fn(self, self.OnChooseTeam))
  binder:BindToText(self.ui.Text_Number, function()
    return self.model.indexTranMap[self.index]
  end)
  binder:BindToText(self.ui.Text_Fight, function()
    do return LT.Text end
    return LT.Text, "Formation_Administration_Current_Team_String"
  end)
  binder:BindToText(self.ui.Text_Team_Name, function()
    do return LT.Text, DBGTeamDataUtils.GetDBGTeamName(self.model.teamType, self.index) end
    return LT.Text, DBGTeamDataUtils.GetDBGTeamName(self.model.teamType, self.index)
  end)
  binder:BindToImage(self.ui.Image_Awaker, function()
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, self.model.config.ID
  end)
  binder:BindToVisible(self.ui.Image_D_Bg, function()
    return self.model.teamTempChooseIndex == self.index
  end)
  binder:BindToVisible(self.ui.Group_Fight, function()
    local awakerTeamData = self.model:GetTeamDataByIdx(self.index)
    return awakerTeamData.isSelect
  end)
  binder:BindToVisible(self.ui.Image_Locked, function()
    return false
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Team, function()
    local awakerTeamData = self.model:GetTeamDataByIdx(self.index)
    return awakerTeamData.awakerTidList
  end, function(itemBinder, item, index)
    local awakerTeamData = self.model:GetTeamDataByIdx(self.index)
    local tid = awakerTeamData.awakerTidList[index]
    local awakerData
    local level = 0
    if 0 ~= tid then
      awakerData = self.model.awakerDataMap[tid]
      level = awakerData.level
      local itemData = {
        awakerId = tid,
        itemCount = string.format("LV.%s", level)
      }
      itemBinder:BindComponent(CommonIconItemType2(item, itemData))
      item:SetActive(true)
    else
      item:SetActive(false)
    end
  end)
end

function DBGTeamListAwakerGroupItem:OnChangeName()
  UIManager.Instance:Reopen(Urls.DBGTeamRenamePanel, self.model, self.index)
end

function DBGTeamListAwakerGroupItem:OnChooseTeam()
  if not self.model:IsTeamUnlocked(self.index) then
    return
  end
  self.model:SetTeamTempChooseIndex(self.index)
end

return DBGTeamListAwakerGroupItem
