local page = class("pageFps", G_UIPageBase)
local C_NetManager = CS.Azur.Gameplay.Core.Net.NetManager
page.sampleTime = 0.5
page.sampleTime10s = 10
page.sampleTime60s = 60
page.sampleTime10m = 600
page.sampleTimeTotal = 0.1
page.time = 0
page.time10s = 0
page.time60s = 0
page.time10m = 0
page.timeTotal = 0
page.timeTotalUpdate = 0
page.frame = 0
page.frame10s = 0
page.frame60s = 0
page.frame10m = 0
page.frameTotal = 0

function page.bind()
  return {
    fps = "FPS: 0",
    fps10s = "(10s avg): 0",
    fps60s = "(60s avg): 0",
    fps10m = "(10m avg): 0",
    fpsTotal = "(Total avg): 0",
    fpsObj = true
  }
end

function page:preOpen()
  self.bind.fpsObj = Unity.Debug.isDebugBuild
  self.strTab = {
    1,
    "X",
    3,
    "_",
    5,
    " FPS:",
    7,
    " ",
    9,
    " ",
    11,
    " ",
    13,
    " ",
    15,
    " server:",
    17,
    " ",
    19,
    " ",
    21
  }
  self.fpsTotalTab = {
    "(Total avg): ",
    "0.0",
    "  client:",
    ""
  }
  self.clientSecondCache = -1
  self.clientSecondStr = ""
  page.timeTotalUpdate = 0
  self.updateHandle = handler(self, self.updateFps)
  if self.bind.fpsObj then
    C_UpdateSource.AddUpdateEventHandler(self.updateHandle, L_WordsTpl:getValue("residual_code_pagefps_01"))
  end
  self.deviceStr = C_DeviceGradeHelper.IsLowMemoryDevice() and L_WordsTpl:getValue("residual_code_pagefps_02") or ""
  local isHide = C_PlayerPrefsUtility.GetBool("IsOpenWaterMarkOrFPS")
  if isHide then
    self:setActiveFPS()
  end
end

function page:close()
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
end

function page:updateFps()
  if self.bind.fpsObj then
    local delta = Unity.Time.deltaTime
    page.frame = page.frame + 1
    page.time = page.time + delta
    page.frame10s = page.frame10s + 1
    page.time10s = page.time10s + delta
    page.frame60s = page.frame60s + 1
    page.time60s = page.time60s + delta
    page.frame10m = page.frame10m + 1
    page.time10m = page.time10m + delta
    page.frameTotal = page.frameTotal + 1
    page.timeTotal = page.timeTotal + delta
    if page.time >= page.sampleTime then
      local fpsCount = page.frame / page.time
      self.bind.fps = self:getString(fpsCount)
      page.frame = 0
      page.time = 0
    end
    if page.time10s >= page.sampleTime10s then
      local fps10sCount = page.frame10s / page.time10s
      self.bind.fps10s = string.format("(10s avg): %.1f", fps10sCount)
      page.frame10s = 0
      page.time10s = 0
    end
    if page.time60s >= page.sampleTime60s then
      local fps60sCount = page.frame60s / page.time60s
      self.bind.fps60s = string.format("(60s avg): %.1f", fps60sCount)
      page.frame60s = 0
      page.time60s = 0
    end
    if page.time10m >= page.sampleTime10m then
      local fps10mCount = page.frame10m / page.time10m
      self.bind.fps10m = string.format("(10m avg): %.1f", fps10mCount)
      page.frame10m = 0
      page.time10m = 0
    end
    page.timeTotalUpdate = page.timeTotalUpdate + delta
    if page.timeTotalUpdate >= page.sampleTimeTotal then
      page.timeTotalUpdate = 0
      local fpsTotalCount = page.frameTotal / math.max(page.timeTotal, 0.001)
      local clientTime = self:getClientTimeString(C_TimeUtility.NowClient)
      self.bind.fpsTotal = self:getFpsTotalString(fpsTotalCount, clientTime)
    end
  end
end

function page:getClientTimeString(nowClient)
  local sec = math.floor(nowClient)
  if self.clientSecondCache ~= sec then
    self.clientSecondCache = sec
    self.clientSecondStr = L_TimeUtil.getDisplayTime(sec)
  end
  local ms = math.floor((nowClient - sec) * 1000)
  if ms < 0 then
    ms = 0
  elseif 999 < ms then
    ms = 999
  end
  local msStr
  if ms < 10 then
    msStr = "00" .. ms
  elseif ms < 100 then
    msStr = "0" .. ms
  else
    msStr = tostring(ms)
  end
  return self.clientSecondStr .. "." .. msStr
end

function page:getFpsTotalString(fpsTotalCount, clientTime)
  self.fpsTotalTab[2] = string.format("%.1f", fpsTotalCount)
  self.fpsTotalTab[4] = clientTime
  return table.concat(self.fpsTotalTab)
end

function page:getString(fpsCount)
  local ac = C_DeviceGradingManager.GetQualityValue(C_QualityConstants.PIPELINE_RENDER_SCALE) or "1"
  if C_CameraManager.mainCamera ~= nil then
    self.strTab[1] = math.floor(C_CameraManager.mainCamera.pixelWidth * C_UniversalRenderPipeline.renderScale + 0.5)
    self.strTab[3] = math.floor(C_CameraManager.mainCamera.pixelHeight * C_UniversalRenderPipeline.renderScale + 0.5)
  else
    self.strTab[1] = "-1"
    self.strTab[3] = "-1"
  end
  self.strTab[5] = ac
  self.strTab[7] = string.format("%.1f", fpsCount)
  self.strTab[9] = self.bind.fps10s
  self.strTab[11] = self.bind.fps60s
  self.strTab[13] = self.bind.fps10m
  self.strTab[15] = self.bind.fpsTotal
  self.strTab[17] = L_TimeUtil.getDisplayTime()
  self.strTab[19] = self.deviceStr
  self.strTab[21] = C_NetManager.EnableKcp and "kcp" or C_NetManager.EnableSsl and "ssl" or "tcp"
  return table.concat(self.strTab)
end

function page:setActiveFPS()
  if L_CommonUtil.isValid(self.gameObject) then
    self.gameObject:SetActive(false)
  end
end

return page
