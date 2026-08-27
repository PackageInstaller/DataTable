local M = class("HotfixTest", HotfixBase)
local OasisCameraController = CS.OasisCameraController
xlua.private_accessible(CS.OasisCameraController)

local function EnableBlur(self, enable)
  self.m_cameraBlur.enabled = enable
  self.m_focusAssistCam.enabled = enable
  warn("EnableBlur in lua" .. self.gameObject.name)
end

local function EnableBlur_RetainOld(self, enable)
  self:EnableBlur(enable)
  warn("EnableBlur in lua" .. self.gameObject.name)
end

function M:Register()
  self:RegisterHotfix(OasisCameraController, "EnableBlur", EnableBlur_RetainOld, true)
end

return M
