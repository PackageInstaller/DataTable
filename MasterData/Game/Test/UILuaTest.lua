local pb = require("pb")
local UILuaTest = class("UIMain", UIBaseWindow)
local base = UIBaseWindow
local NetworkManager = CS.NetworkManager.Instance
local cs_ResLoader = CS.ResLoader
local cs_NetMsgData = CS.NetMsgData

local function onbtnClick(self)
  self.click_num = self.click_num + 1
  self.ui_info.text = self.ui.t1 .. tostring(self.click_num) .. " click button"
  if self.click_num % 2 == 0 then
    self.ui_img.gameObject:SetActive(not self.ui_img.gameObject.activeSelf)
  end
  local msgData = cs_NetMsgData.Get()
  msgData.CmdID = 1
  local loginReq = {
    name = "GG思密达来也!!"
  }
  msgData:Encode(pb.encode("usercmd.LoginC2S", loginReq))
  NetworkManager:SendTcpMsg(msgData)
  msgData:Put()
end

local function OnTcpPacket(msgData)
  if msgData == nil then
    return
  end
  if msgData.CmdID == 2 then
    local msg = pb.decode("usercmd.LoginS2C", msgData.ByteData.RawData)
    print(serpent.block(msg))
  end
end

local function InitNetwork()
  NetworkManager:ConnectTcpChannel()
  NetworkManager:onTcpPacket("+", OnTcpPacket)
  local resloader = cs_ResLoader.Create()
  local pbDefBytes = resloader:LoadABAsset("Test/TestLuaPB/MyDemo.pb.bytes").bytes
  resloader:Put2Pool()
  pb.load(pbDefBytes)
end

function UILuaTest:OnInit()
  self.ui_info = self:FindComponent("BG/Info", eUnityComponentID.Text)
  self.ui_img = self:FindComponent("Img", eUnityComponentID.Image)
  self.click_num = 0
  UIUtil.AddButtonListener(self.ui.btn, self, onbtnClick)
  InitNetwork()
end

function UILuaTest:OnDelete()
  base.OnDelete(self)
  print("ondelete")
end

return UILuaTest
