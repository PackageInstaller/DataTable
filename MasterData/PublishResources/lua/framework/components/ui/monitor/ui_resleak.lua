_class("UIResLeak", UIController)
UIResLeak = UIResLeak
local data = {}

function UIResLeak:Constructor()
end

function UIResLeak:OnShow(uiParams)
  self.content = self:GetUIComponent("Text", "content")
  self.text = self:GetUIComponent("Text", "Text")
  self.text.text = "快照资源"
end

function UIResLeak:btnCloseOnClick(go)
  self:CloseDialog()
end

function UIResLeak:Log(msg)
  self.content.text = msg
end

function UIResLeak:btnSnapShotOnClick(go)
  Monitor:GetInstance():SnapShot()
  data.luaMemery = collectgarbage("count")
  data.monoMemory = App.CMem
  data.recordTime = UnityEngine.Time.realtimeSinceStartup
  self:Log("开始记录")
end

function UIResLeak:btnCompareOnClick(go)
  assert(next(data), "need snapshot frist")
  local time = ToTimingFormat2(UnityEngine.Time.realtimeSinceStartup - data.recordTime)
  local msg1 = string.format("记录前mono内存：%s MB；当前mono内存：%s MB；\n记录前lua内存：%s MB；当前lua内存：%s MB \n记录时长：%s\n是否开启缓存：%s\n", data.monoMemory / 1024, App.CMem / 1024, data.luaMemery / 1024, collectgarbage("count") / 1024, time, not NoCache)
  local path = Monitor:GetInstance():CompareSnapShot(msg1)
  if path then
    self:Log("有泄露，记录成功！\n保存路径：" .. path)
  else
    self:Log("无资源泄露")
  end
end
