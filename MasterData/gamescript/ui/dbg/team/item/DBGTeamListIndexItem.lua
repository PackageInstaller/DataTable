local tableInsert = table.insert
local Z1Toggle = CS.Z1Client.Z1Toggle
local typeof = _ENV.typeof
local DBGTeamListIndexItem, Super = System.NewComponent("DBGTeamListIndexItem")

function DBGTeamListIndexItem:ctor(res, idx, model)
  Super.ctor(self)
  self.ui = UI_Team_Item_TeamIndexResource(res)
  self.idx = idx
  self.model = model
end

function DBGTeamListIndexItem:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_Normal_Team, function()
    return self.model.indexTranMap[self.idx]
  end)
  binder:BindToText(self.ui.Text_Select_Team, function()
    return self.model.indexTranMap[self.idx]
  end)
  binder:BindToRaw(function(_, nVal, _)
    self.ui.Group_Normal:SetActive(nVal ~= self.idx)
    self.ui.Group_Selected:SetActive(nVal == self.idx)
  end, function()
    return self.model.curTeamIndex
  end)
  binder:BindToRaw(function(_, isUnlocked)
    binder:SetActive(self.ui.Group_Locked, not isUnlocked)
  end, function()
    do return self.model.IsTeamUnlocked, self.model end
    return self.model.IsTeamUnlocked, self.model, self.idx
  end)
  binder:BindToRaw(function(_, interactable)
    binder:SetZ1ToggleInteractable(self.ui.uiNode, interactable)
  end, function()
    return self.idx ~= self.model.curTeamIndex and self.model:IsTeamUnlocked(self.idx)
  end)
  binder:BindButtonClick(self.ui.Group_Locked, function()
    DBGTeamDataUtils.ReqUnlockTeam(self.model.teamType, self.idx, function()
      self.model:OnTeamUnlocks(self.idx)
    end)
  end)
  binder:BindToZ1Toggle(self.ui.uiNode, nil, function(isOn)
    if not self.model:IsTeamUnlocked(self.idx) then
      return
    end
    if isOn then
      self.model:SetAssistData(nil)
      if self.model.fightAwakerNum == self.model.MaxBattleNum or 0 == self.model.fightAwakerNum then
        self.model:UpdateAwakerTeamInfoWithCurData(self.model.curTeamIndex)
      else
        self.model:UpdateAwakerTeamInfoWithCurData(self.model.curTeamIndex, true)
      end
      
      local function saveFunc()
        self.model:ChooseNewTeam(self.idx)
      end
      
      Logger.ReportApusInfo("DBGTeam SaveTeamToServer ListIndexItem OnToggle ")
      self.model:SaveTeamToServer(saveFunc)
      self.model:SetCurBuildingAwakerTeam(table.clone(self.model.teamAwakerTids))
    else
      self.model:UpdateAwakerTeamInfoWithCurData(self.model.curTeamIndex, true)
    end
  end)
end

return DBGTeamListIndexItem
