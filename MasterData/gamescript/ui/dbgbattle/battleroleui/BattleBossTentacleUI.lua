local BattleBossTentacleUI, Super = System.NewComponent("BattleBossTentacleUI")

function BattleBossTentacleUI:ctor(uiNode, battleRole, roleData)
  Super.ctor(self)
  self.ui = Func_Battle_ChuwanResource(uiNode)
  self.battleRole = battleRole
  self.roleData = roleData
end

function BattleBossTentacleUI:OnBind(binder)
  self.binder = binder
  binder:BindToVisible(self.ui.Image_Tentacle, function()
    return self.roleData:GetTentacleMaxCount() > 0
  end)
  binder:BindToVisible(self.ui.Btn_Click_Tentacle, function()
    return self.roleData:GetTentacleMaxCount() > 0
  end)
  self.ui.Image_Tentacle:SetActive(true)
  self.tentacleStatusItem = binder:BindComponent(TentacleStatusUIItem(self.ui.Group_First_Tentacle, self.ui.Group_Other_Tentacle, self.roleData))
  self.ui.Btn_Switch:SetActive(false)
  binder:BindButtonClick(self.ui.Btn_Click_Tentacle, function()
    AudioManager.Instance:PostSoundEvent("POPUP_CM_WND_INFO_ON")
    local tipsData = {
      title = LT.Text("Monster_Ocean_Title", true),
      desc = LT.Text("Monster_Ocean_Tips", true),
      iconPath = bg.DT.SchoolConfig[4].SchoolBattleTipIcon
    }
    UIManager.Instance:Reopen(Urls.AlertIconToolBattleTipsPanel, tipsData, BattleGlobal.battlePanel.ui.School_Effect_Tips_Node, true)
  end)
end

function BattleBossTentacleUI:OnUnbind()
  Super.OnUnbind(self)
end

return BattleBossTentacleUI
