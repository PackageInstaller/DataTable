_class("UIHomelandMedalWall", UIController)
UIHomelandMedalWall = UIHomelandMedalWall

function UIHomelandMedalWall:OnShow(uiParams)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._uiHomelandModule = self._homelandModule:GetUIModule()
  self._homelandClient = self._uiHomelandModule:GetClient()
  self._isVisit = self._homelandClient:IsVisit()
  self._btnEdit = self:GetGameObject("BtnEdit")
  self._btnEdit:SetActive(not self._isVisit)
  self._mobileMedalWallControlGO = self:GetGameObject("MobileMedalWallControl")
  self._mobileMedalWallConWidgetPool = self:GetUIComponent("UISelectObjectPath", "MobileMedalWallControl")
  self:Init()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetInteractPointUIStatus, false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.EnterFindTreasure)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideHomelandAllUI, false)
  local characterController = self._homelandClient:CharacterManager():MainCharacterController()
  characterController:ShowHideCharacter(false)
  local petMng = self._homelandClient:PetManager()
  petMng:SetPetsVisible(false)
  local homelandMainController = GameGlobal.UIStateManager():GetController("UIHomelandMain")
  if homelandMainController then
    homelandMainController:SetMinimapStatus(false)
  end
  local cameraTransform = uiParams[1]
  self._homelandClient:InputManager():ChangeMedalWallController(true, cameraTransform)
  self._homelandClient:CameraManager():SetMedalWallCameraActive(true)
end

function UIHomelandMedalWall:Init()
  self._mobileMedalWallControlGO:SetActive(true)
  self._uiWidgetMedalWallCtrl = self._mobileMedalWallConWidgetPool:SpawnObject("UIWidgetHomelandMedalWallController")
  self._blackMask = self:GetGameObject().transform.parent.parent:Find("BGMaskCanvas/black_mask"):GetComponent(typeof(UnityEngine.UI.Image))
  self._blackMask.raycastTarget = false
end

function UIHomelandMedalWall:OnHide()
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  if not homelandClient then
    return
  end
  local cameraMgr = homelandClient:CameraManager()
  local medalWallCameraController = cameraMgr:MedalWallCameraController()
  medalWallCameraController:ResetInitPos(function()
    self._blackMask.raycastTarget = true
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideHomelandAllUI, true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshInteractUI)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetInteractPointUIStatus, true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ExitFindTreasure)
    homelandClient:InputManager():ChangeMedalWallController(false)
    cameraMgr:SetMedalWallCameraActive(false)
    local followCameraController = cameraMgr:FollowCameraController()
    followCameraController:LeaveFocusUseAngles()
    local characterController = homelandClient:CharacterManager():MainCharacterController()
    characterController:ShowHideCharacter(true)
    characterController:SetForbiddenMove(false)
    local petMng = homelandClient:PetManager()
    petMng:SetPetsVisible(true)
    local homelandMainController = GameGlobal.UIStateManager():GetController("UIHomelandMain")
    if homelandMainController then
      homelandMainController:SetMinimapStatus(true)
    end
  end)
end

function UIHomelandMedalWall:BtnCloseOnClick(go)
  self:CloseDialog()
end

function UIHomelandMedalWall:BtnEditOnClick(go)
  self:ShowDialog("UIN22MedalEdit", true)
end
