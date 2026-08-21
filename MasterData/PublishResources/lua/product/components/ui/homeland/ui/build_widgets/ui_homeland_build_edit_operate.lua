_class("UIHomelandBuildEditOperate", UICustomWidget)
UIHomelandBuildEditOperate = UIHomelandBuildEditOperate

function UIHomelandBuildEditOperate:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  self.homeBuildManager = self.homelandClient:BuildManager()
  self.mItem = GameGlobal.GetModule(ItemModule)
end

function UIHomelandBuildEditOperate:OnShow(uiParams)
  self:InitWidget()
  self:AttachEvent(GameEventType.HomeBuildOnAmbientChanged, self.HomeBuildOnAmbientChanged)
  self:AttachEvent(GameEventType.OnHomeBuildRotateOpen, self.OnOpenRotate)
end

function UIHomelandBuildEditOperate:OnHide()
  self:DetachEvent(GameEventType.HomeBuildOnAmbientChanged, self.HomeBuildOnAmbientChanged)
  self:DetachEvent(GameEventType.OnHomeBuildRotateOpen, self.OnOpenRotate)
end

function UIHomelandBuildEditOperate:InitWidget()
  self.operate = self:GetGameObject("operate")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.goTakeIn = self:GetGameObject("imgTakeIn")
  self.goRotate = self:GetGameObject("imgRotate")
  self.goConfirm = self:GetGameObject("imgConfirm")
  self._rotateImg = self:GetUIComponent("Image", "rotateimg")
end

function UIHomelandBuildEditOperate:FlushOperate()
  local homeBuilding = self.homeBuildManager:GetCurrentBuilding()
  self.txtName:SetText(UIHomelandBuildEdit.GetBuildingName(homeBuilding:GetBuildId()))
  if not homeBuilding:ShowDeleteBtn() then
    self.goTakeIn:SetActive(false)
  else
    local canDelete, reason, showBtn = UIHomelandBuildEdit.CanBuildingDelete(homeBuilding)
    self.goTakeIn:SetActive(showBtn)
    if UIHomelandBuildEdit.CanBuildingMove(homeBuilding:GetBuildId()) then
      self.goRotate:SetActive(true)
      self.goConfirm:SetActive(true)
    else
      self.goRotate:SetActive(false)
      self.goConfirm:SetActive(false)
    end
  end
end

function UIHomelandBuildEditOperate:_Exit(TT)
  self:Lock("HomeExitBuildMode")
  self:SwitchState(UIStateType.UIHomeland)
  while GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.UIHomeland do
    YIELD(TT)
  end
  self.homelandClient:FinishBuild(TT)
  self:UnLock("HomeExitBuildMode")
end

function UIHomelandBuildEditOperate:ImgCancelOnClick(go)
  self.homeBuildManager:RevertCurrent()
end

function UIHomelandBuildEditOperate:ImgTakeInOnClick(go)
  local homeBuilding = self.homeBuildManager:GetCurrentBuilding()
  local canDelete, reason = UIHomelandBuildEdit.CanBuildingDelete(homeBuilding)
  if canDelete then
    self.homeBuildManager:Delete()
  elseif not string.isnullorempty(reason) then
    ToastManager.ShowHomeToast(reason)
  else
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_build_cant_delete"))
  end
end

function UIHomelandBuildEditOperate:ImgRotateOnClick(go)
  local homeBuilding = self.homeBuildManager:GetCurrentBuilding()
  if not homeBuilding:CanRotate() then
    ToastManager.ShowToast(StringTable.Get("str_homeland_build_fixed_rotation"))
    return
  end
  self:ShowDialog("UIHomelandBuildEditRotate")
end

function UIHomelandBuildEditOperate:ImgConfirmOnClick(go)
  self.homeBuildManager:DropDown()
end

function UIHomelandBuildEditOperate:GetSpecialTag()
  return self._specialTag:GetGameObject("imgTab")
end

function UIHomelandBuildEditOperate:GetSpecialLand()
  return self._specialLand:GetGameObject("imgTab")
end

function UIHomelandBuildEditOperate:OnOpenRotate(isOpen)
  if isOpen then
    self._rotateImg.color = Color(0.9686274509803922, 0.6823529411764706, 0.17254901960784313)
  else
    self._rotateImg.color = Color.white
  end
end
