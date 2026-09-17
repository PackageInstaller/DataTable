local this = class("cellChangeCamTab", G_UIModuleBase)
local cameraPresetName = {
  [1] = "notice_pagePhoto_07",
  [2] = "notice_pagePhoto_08",
  [3] = "notice_pagePhoto_09"
}

function this.bind()
  return {
    txt_campresetOff = "",
    txt_campresetOn = "",
    tabId = -1
  }
end

function this.methods()
  return {}
end

function this:open()
  self.bind.tabId = self.bind.id
  self.bind.txt_campresetOff = L_WordsTpl:getValue(cameraPresetName[self.bind.id])
  self.bind.txt_campresetOn = L_WordsTpl:getValue(cameraPresetName[self.bind.id])
end

return this
