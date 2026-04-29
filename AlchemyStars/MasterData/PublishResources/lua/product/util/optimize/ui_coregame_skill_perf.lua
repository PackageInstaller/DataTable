_class("UICoreGameSkillPerfController", UIController)
UICoreGameSkillPerfController = UICoreGameSkillPerfController

function UICoreGameSkillPerfController:OnShow(uiParams)
  self._fpsText = self:GetUIComponent("UILocalizationText", "fps")
  self._info = self:GetUIComponent("UILocalizationText", "info")
  self:AttachEvent(GameEventType.UpdateTestScenceInfo, self.UpdateTestScenceInfo)
  self:AttachEvent(GameEventType.TestSceneCloseButton, self.CloseButton)
  self.buttonGO = self:GetGameObject("Button")
  self._fpsTextGO = self:GetGameObject("fps")
  self._module = GameGlobal.GetModule(SkillPerfModule)
  self._petID = self:GetUIComponent("InputField", "PetID")
  self._ActiveSkillID = self:GetUIComponent("InputField", "ActiveSkillID")
end

function UICoreGameSkillPerfController:BtnActiveSkillPerfOnClick(go)
  self._module:BeginActiveSkillStat()
end

function UICoreGameSkillPerfController:BtnBackOnClick(go)
  self._module:PerfClose()
end

function UICoreGameSkillPerfController:BtnStopOnClick(go)
  self._module:BeginActiveSkillStat()
end

function UICoreGameSkillPerfController:BtnSPActiveSkillPerfOnClick(go)
  local petID = tonumber(self._petID.text)
  local skillID = tonumber(self._ActiveSkillID.text)
  self._module:CastActiveSkill(petID, skillID)
end
