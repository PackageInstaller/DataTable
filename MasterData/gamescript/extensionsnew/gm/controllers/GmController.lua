local GmController = NewClass("GmController", BaseController)

function GmController:OnInit()
end

function GmController:OnReset()
end

function GmController:OnOpenGmView(sceneType)
  UIManager.Instance:Reopen(Urls.GmPanel, sceneType)
end

function GmController:OnOpenGmEntryView()
  UIManager.Instance:Reopen(Urls.GmEntryPanel)
end

function GmController:OnOpenGmParamView(gmConfig)
  UIManager.Instance:Reopen(Urls.GmParamPanel, gmConfig)
end

function GmController:OnOpenGmParamEquipView(gmConfig)
  UIManager.Instance:Reopen(Urls.GmParamEquipPanel, gmConfig)
end

function GmController:OnOpenGmAccountJsonRenameView(accountContent)
  UIManager.Instance:Reopen(Urls.GmAccountJsonRenamePanel, accountContent)
end

return GmController
