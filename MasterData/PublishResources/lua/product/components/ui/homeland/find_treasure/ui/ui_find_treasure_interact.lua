_class("UIFindTreasureInteract", UICustomWidget)
UIFindTreasureInteract = UIFindTreasureInteract

function UIFindTreasureInteract:OnShow(uiParams)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  characterController:SetForbiddenMove(true)
  self._dialogLayout1 = self:GetGameObject("DialogLayout1")
  self._speakerName1Label = self:GetUIComponent("UILocalizedTMP", "SpeakerName1")
  self._matReq = UIWidgetHelper.SetLocalizedTMPMaterial(self, "SpeakerName1", "UIHomeStorySpeakerName.mat", self._matReq)
  self._myTalkGo = self:GetGameObject("DialogLayout2")
  self._petTalkGo = self:GetGameObject("DialogLayout1")
  self._myTalkGo:SetActive(false)
  self._petTalkGo:SetActive(false)
  self._content1Label = self:GetUIComponent("UILocalizationText", "Content1")
  self._options = self:GetGameObject("Options")
  self._chooseLoader = self:GetUIComponent("UISelectObjectPath", "choosePool")
  self._poolRect = self:GetUIComponent("RectTransform", "choosePool")
  self._bodyLeft = self:GetUIComponent("RawImageLoader", "body1")
  self:Refresh()
end

function UIFindTreasureInteract:OnHide()
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  characterController:SetForbiddenMove(false)
end

function UIFindTreasureInteract:Destroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UIFindTreasureInteract:Refresh()
  self._dialogLayout1:SetActive(true)
  self._options:SetActive(true)
  local roleModule = GameGlobal.GetModule(RoleModule)
  self._speakerName1Label:SetText(StringTable.Get("str_homeland_find_treasure_dialog_pet_name"))
  self._content1Label:SetText(StringTable.Get("str_homeland_find_treasure_dialog_content"))
  local count = 2
  local btnDatas = {
    {
      name = StringTable.Get("str_homeland_find_treasure_enter_game_btn_name")
    },
    {
      name = StringTable.Get("str_homeland_find_treasure_exit_interact_btn_name")
    }
  }
  self._chooseLoader:SpawnObjects("UIHomeStoryChooseItem", count)
  self._pools = self._chooseLoader:GetAllSpawnList()
  for i = 1, #self._pools do
    local btn = self._pools[i]
    if count >= i then
      btn:Active(true)
      local txt = btnDatas[i].name
      btn:SetData(i, txt, function(idx)
        self:ItemClick(idx)
      end)
    else
      btn:Active(false)
    end
  end
  self._bodyLeft:LoadImage(HomelandFindTreasureConst.GetNPCHeadImage())
  self._poolRect.anchoredPosition = Vector2(self._poolRect.anchoredPosition.x, 0)
end

function UIFindTreasureInteract:Init(main)
  self._main = main
end

function UIFindTreasureInteract:ItemClick(id)
  if id == 1 then
    self._main:Enter()
  elseif id == 2 then
    self._main:Exit()
  end
end
