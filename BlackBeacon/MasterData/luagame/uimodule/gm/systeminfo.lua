local Base = require("ui.uibase")
local UnitySystemInfo = UnityEngine.SystemInfo
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show()
  Base.ui_on_show(self)
  local msg = "deviceModel: " .. UnitySystemInfo.deviceModel .. "\n" .. "deviceName: " .. UnitySystemInfo.deviceName .. "\n" .. "deviceType: " .. tostring(UnitySystemInfo.deviceType) .. "\n" .. "processorFrequency: " .. UnitySystemInfo.processorFrequency .. "\n" .. "processorCount: " .. UnitySystemInfo.processorCount .. "\n" .. "processorType: " .. UnitySystemInfo.processorType .. "\n" .. "graphicsMemorySize: " .. UnitySystemInfo.graphicsMemorySize .. "\n" .. "graphicsShaderLevel: " .. UnitySystemInfo.graphicsShaderLevel .. "\n" .. "graphicsDeviceName: " .. UnitySystemInfo.graphicsDeviceName .. "\n" .. "graphicsDeviceVendor: " .. UnitySystemInfo.graphicsDeviceVendor .. "\n" .. "graphicsDeviceType: " .. tostring(UnitySystemInfo.graphicsDeviceType) .. "\n" .. "graphicsDeviceVersion: " .. UnitySystemInfo.graphicsDeviceVersion .. "\n" .. "graphicsDeviceID: " .. UnitySystemInfo.graphicsDeviceID .. "\n" .. "graphicsDeviceVendorID: " .. UnitySystemInfo.graphicsDeviceVendorID .. "\n" .. "graphicsMultiThreaded: " .. tostring(UnitySystemInfo.graphicsMultiThreaded) .. "\n" .. "supportedRenderTargetCount: " .. tostring(UnitySystemInfo.supportedRenderTargetCount) .. "\n" .. "systemMemorySize: " .. UnitySystemInfo.systemMemorySize .. "\n" .. "maxTextureSize: " .. UnitySystemInfo.maxTextureSize .. "\n"
  if UNITY_ANDROID then
    local cpu_name = Util.get_android_cpuhardware() or "no defined"
    msg = msg .. "cpu hardware: " .. cpu_name .. "\n"
  end
  self.v_uicompents.Text_txt.text = msg
end

return ui
