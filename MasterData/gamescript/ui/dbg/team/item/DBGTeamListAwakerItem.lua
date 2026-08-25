local DBGTeamListAwakerItem, Super = System.NewComponent("DBGTeamListAwakerItem")

function DBGTeamListAwakerItem:ctor(res, tid, level)
  Super.ctor(self)
  self.ui = UI_Team_Item_Awaker_List2Resource(res)
  self.tid = tid
  self.level = level
end

function DBGTeamListAwakerItem:OnBind(binder)
  if 0 == self.tid then
    self:ShowEmptyItem()
    return
  end
  self.model = binder:createModel(DBGTeamListAwakerItemModel, self.tid, self.level)
  binder:BindToText(self.ui.Text_Level, function()
    return self.model.teamType ~= CommonDefine.TeamType.Daily and LT.Textf("Team_AwakerLevel", self.model.level) or LT.Textf("Team_AwakerLevel", 1)
  end)
  binder:BindToImage(self.ui.Image_Awaker, function()
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, self.model.config.ID
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    return self.model.quality and DT.ItemQuality[self.model.quality].ItemQualityFrame or ""
  end)
  binder:BindToImage(self.ui.Image_Occupation, function()
    local schoolConfig = self.model.config and DT.SchoolConfig[self.model.config.School] or nil
    return schoolConfig and schoolConfig.Icon or ""
  end)
end

function DBGTeamListAwakerItem:ShowEmptyItem()
  self.ui.Image_Bg:SetActive(false)
  self.ui.Image_Quality:SetActive(false)
  self.ui.Image_Occupation:SetActive(false)
  self.ui.Text_Level:SetActive(false)
end

return DBGTeamListAwakerItem
