local DBGTeamManagePanel, Super = System.NewClass("DBGTeamManagePanel", UIBasePanel)
DBGTeamManagePanel.uiResCls = UI_Team_Popup_MyTeam_Awaker_ListResource

function DBGTeamManagePanel:ctor(dbgTeamBuildModel)
  Super.ctor(self)
  self.model = dbgTeamBuildModel
  self.curSelectTeamIdx = Vue.ref(self.model.curTeamIndex)
  self.teamItemComps = {}
end

function DBGTeamManagePanel:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Title, LT.Text("Formation_Administration_Title_String"))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindZ1Button(self.ui.Btn_Select, function()
    if self.curSelectTeamIdx.value == self.model.curTeamIndex then
      Alert.Show(10809)
      return
    end
    self.model:SetAssistData(nil)
    self.model:ChooseNewTeam(self.curSelectTeamIdx.value)
    self.model:SetCurBuildingAwakerTeam(table.clone(self.model.teamAwakerTids))
    self:Close()
  end, function()
    if self.curSelectTeamIdx.value == self.model.curTeamIndex then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end)
  self.teamView = self:CreateTableview(self.ui.ScrollView_Team, function()
    if not self.model.allTeamList then
      return 0
    end
    return #self.model.allTeamList
  end, function(view, index)
    do return self.TeamCellAtIndex, self, view end
    return self.TeamCellAtIndex, self, view, index
  end, function()
    return 701, 203
  end)
  self.binder:BindToRaw(function(_, newValue, oldValue)
    if oldValue then
      function self.teamView.reloadFinishCallback()
        self.teamView:MoveCellToCenter(newValue)
      end
    end
    self.teamView:ReloadData()
  end, function()
    return #self.model.allTeamList
  end)
  
  function self.teamView.reloadFinishCallback()
    self.teamView:MoveCellToCenter(self.curSelectTeamIdx.value - 1)
    self:PlayTableViewFadeInAnim(self.ui.ScrollView_Team)
  end
end

function DBGTeamManagePanel:TeamCellAtIndex(view, index)
  local cell = self:DequeueCell(view, self.ui.UI_Team_Item_MyTeam_List)
  local oldComp = self.teamItemComps[cell.gameObject]
  if oldComp and oldComp.binder then
    oldComp.binder:teardown()
  end
  
  local function clickFunc()
    self.curSelectTeamIdx.value = index
  end
  
  local function fightedFunc()
    return index == self.model.curTeamIndex
  end
  
  local function selectedFunc()
    return index == self.curSelectTeamIdx.value
  end
  
  local itemData = {
    clickFunc = clickFunc,
    fightedFunc = fightedFunc,
    selectedFunc = selectedFunc,
    index = index,
    model = self.model
  }
  local comp = self.binder:BindComponent(DBGTeamManageItem(cell.gameObject, itemData))
  self.teamItemComps[cell.gameObject] = comp
  return cell
end

function DBGTeamManagePanel:OnUnbind()
  self.teamItemComps = nil
end

return DBGTeamManagePanel
