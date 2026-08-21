_class("UISkillEditorController", UIController)
UISkillEditorController = UISkillEditorController

function UISkillEditorController:OnShow(uiParams)
  Editor.Enter()
  self:CloseDialog()
end

function UISkillEditorController:BtnBackOnClick(go)
  Editor.Enter()
  self:CloseDialog()
end
