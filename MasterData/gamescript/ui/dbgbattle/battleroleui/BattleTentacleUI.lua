local BattleTentacleUI, Super = System.NewComponent("BattleTentacleUI")

function BattleTentacleUI:ctor(uiNode, battleRole, roleData)
  Super.ctor(self)
  self.ui = Func_Battle_ChuwanResource(uiNode)
  self.battleRole = battleRole
  self.roleData = roleData
end

function BattleTentacleUI:OnBind(binder)
  self.binder = binder
  binder:BindToVisible(self.ui.Image_Tentacle, function()
    return self.roleData:GetTentacleMaxCount() > 0
  end)
  if bg.battleDataCenter:IsMixSchoolExChoas() then
    self.ui.uiNode.transform.localScale = CS.UnityEngine.Vector3(0.8, 0.8, 1)
    self.ui.uiNode.transform.localPosition = CS.UnityEngine.Vector3(0, 25, 0)
  end
  self.ui.Image_Tentacle:SetActive(true)
  self.tentacleStatusItem = binder:BindComponent(TentacleStatusUIItem(self.ui.Group_First_Tentacle, self.ui.Group_Other_Tentacle, self.roleData))
  binder:BindToVisible(self.ui.Btn_Switch, function()
    do return self.IsCanSwitch end
    return self.IsCanSwitch, self
  end)
  binder:BindButtonClick(self.ui.Btn_Switch, function()
    self:OnBtnSwitch()
  end)
  if self.roleData.camp == bc.BattleCamp.Camp1 then
    local uName = "KeySchoolUse"
    binder:BindComponent(ShortCutComp(self.ui.Text_ShortCut, uName, function()
      if bg.battleDataCenter:GetRealCamp() == bc.BattleCamp.Camp2 then
        return
      end
      self:OnBtnSwitch()
    end))
  end
end

function BattleTentacleUI:IsCanSwitch()
  return self.roleData.camp == bc.BattleCamp.Camp1 and self.roleData:GetTentacleMaxCount() > 0
end

function BattleTentacleUI:OnBtnSwitch()
  local battleIndex = bg.battleRender.battleTid
  local boutIndex = bg.battleRender.boutMgr:GetBoutNum()
  if GuideManager.Instance:CheckGuideStageBoutValid(CommonDefine.GuideBattle.GuideCondOceanHide, battleIndex, boutIndex) then
    return
  end
  if not bg.battleDataCenter:IsMyActionCamp() then
    return
  end
  if bg.battleDataCenter:GetOceanModel() ~= BattleConst.OceanModel.OceanModel1 then
    Alert.ShowStr(LT.Text("TentacleModeSwitchCondTips"))
    return
  end
  UIManager.Instance:Reopen(Urls.DbgTentacleModeSwitch, self.roleData)
end

function BattleTentacleUI:OnUnbind()
  Super.OnUnbind(self)
end

return BattleTentacleUI
