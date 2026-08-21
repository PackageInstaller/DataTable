_class("UIMedalMainController", UIController)
UIMedalMainController = UIMedalMainController

function UIMedalMainController:Constructor()
  self.medalModule = GameGlobal.GetModule(MedalModule)
  self.uiMedalModuel = self.medalModule:GetUIModule()
  self._canShare = self:GetModule(ShareModule):CanShare()
end

function UIMedalMainController:OnShow(uiParams)
  self:InitWidget()
  self:Refresh()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UIMedalMainController:OnHide()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UIMedalMainController:InitWidget()
  local topButton = self:GetUIComponent("UISelectObjectPath", "topbtn")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:StartTask(function(TT)
      local lockName = "UIMedalMainController_PlayAnimOut()"
      self:Lock(lockName)
      self._ani:Play("uieff_UIMedalMainController_out")
      YIELD(TT, 450)
      self:UnLock(lockName)
      self:CloseDialog()
    end, self)
  end, nil, nil, nil, nil)
  self.medalBtn = self:GetGameObject("medalBtn")
  self.medalRed = self:GetGameObject("medalRed")
  self.medalBgBtn = self:GetGameObject("medalBgBtn")
  self.medalBgRed = self:GetGameObject("medalBgRed")
  self._ani = self:GetUIComponent("Animation", "_ani")
  local boardMedalPool = self:GetUIComponent("UISelectObjectPath", "boardMedal")
  self.boardMedal = boardMedalPool:SpawnObject("UIMedalCardSimple")
  self._backgroundGo = self:GetGameObject("Background")
  self._editBtnGo = self:GetGameObject("EditButton")
  self._bottomGo = self:GetGameObject("Bottom")
  self._boardMedalRect = self:GetUIComponent("RectTransform", "boardMedal")
  self._shareBtnGO = self:GetGameObject("ShareBtn")
  self._shareBtnGO:SetActive(self._canShare)
end

function UIMedalMainController:Refresh()
  local placeData = self.medalModule:GetPlacementInfo()
  self.boardMedal:SetData(1820, placeData)
end

function UIMedalMainController:AfterUILayerChanged()
  self:_CheckRed()
end

function UIMedalMainController:_CheckRed()
  self.medalRed:SetActive(self.uiMedalModuel:IsMedalNew())
  self.medalBgRed:SetActive(self.uiMedalModuel:IsMedalBoardNew())
end

function UIMedalMainController:MedalBtnOnClick(go)
  GameGlobal.UIStateManager():ShowDialog("UIMedalListController")
end

function UIMedalMainController:MedalBgBtnOnClick(go)
  self:ShowDialog("UIMedalBgListController")
end

function UIMedalMainController:MedalGroupBtnOnClick(go)
  self:ShowDialog("UIMedalGroupListController")
end

function UIMedalMainController:EditButtonOnClick(go)
  self:ShowDialog("UIN22MedalEdit")
end

function UIMedalMainController:ShareBtnOnClick(go)
  self:Lock("UIMedalMainControllerShare")
  self:StartTask(function(TT)
    self:_SetShareUI(false)
    YIELD(TT)
    self:ShowDialog("UIShare", self:GetName(), nil, function()
      self:_SetShareUI(true)
    end, nil, nil, nil, ShareSceneType.Medal)
    self:UnLock("UIMedalMainControllerShare")
  end, self)
end

function UIMedalMainController:_SetShareUI(show)
  self.topButtonWidget.view.gameObject:SetActive(show)
  self._backgroundGo:SetActive(show)
  self._editBtnGo:SetActive(show)
  self._bottomGo:SetActive(show)
  self._shareBtnGO:SetActive(show)
  if show then
    self._boardMedalRect.anchoredPosition = Vector2(self._boardMedalRect.anchoredPosition.x, 72)
  else
    self._boardMedalRect.anchoredPosition = Vector2(self._boardMedalRect.anchoredPosition.x, 0)
  end
end
