_class("UILuaLeak", UIController)
UILuaLeak = UILuaLeak
local data = {}

function UILuaLeak:Constructor()
end

function UILuaLeak:OnShow(uiParams)
  self.content = self:GetUIComponent("Text", "content")
  self.text = self:GetUIComponent("Text", "Text")
  self.text.text = "快照lua"
end

function UILuaLeak:btnCloseOnClick(go)
  self:CloseDialog()
end

function UILuaLeak:Log(msg)
  self.content.text = msg
end

function UILuaLeak:btnSnapShotOnClick(go)
  Monitor:GetInstance():LuaSnapShot()
  data.luaMemery = collectgarbage("count")
  data.monoMemory = App.CMem
  data.recordTime = UnityEngine.Time.realtimeSinceStartup
  self:Log("开始记录lua内存函数引用")
end

function UILuaLeak:btnCompareOnClick(go)
  assert(next(data), "need snapshot frist")
  local time = ToTimingFormat2(UnityEngine.Time.realtimeSinceStartup - data.recordTime)
  local msg1 = string.format("记录前mono内存：%s MB；当前mono内存：%s MB；\n记录前lua内存：%s MB；当前lua内存：%s MB \n记录时长：%s\n是否开启缓存：%s\n", data.monoMemory / 1024, App.CMem / 1024, data.luaMemery / 1024, collectgarbage("count") / 1024, time, not NoCache)
  local path = Monitor:GetInstance():CompareLuaSnapShot(msg1)
  if path then
    self:Log("有lua泄露，记录成功！\n保存路径：" .. path .. " 停止记录lua内存函数引用")
  else
    self:Log("无lua泄露，停止记录lua内存函数引用")
  end
end
