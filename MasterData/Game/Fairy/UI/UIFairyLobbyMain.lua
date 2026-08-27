local UIFairyLobbyMain = class("UIFairyLobbyMain", UIBaseWindow)
local base = UIBaseWindow
local JumpManager = require("Game.Jump.JumpManager")
local eFairyEnum = require("Game.Fairy.eFairyEnum")
local cs_MessageCommon = CS.MessageCommon

function UIFairyLobbyMain:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ElfList, self, self.OnClickFairyList)
  UIUtil.AddButtonListener(self.ui.btn_GetElf, self, self.OnClickGetFairy)
  UIUtil.SetTopStatus(self, self.OnClickBack, {
    ConstGlobalItem.FairyLotteryTicket
  }, function()
    local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
    GuidePicture.OpenGuidePicture(56, nil)
  end)
end

function UIFairyLobbyMain:OnShow()
  self.ui.anim_ElfList:DORestart()
  self.ui.anim_GetElf:DORestart()
end

function UIFairyLobbyMain:InitFairyLobbyMain(fairyController)
  self.fairyController = fairyController
end

function UIFairyLobbyMain:OnClickFairyList()
  if not self.fairyController:GetPlayerHaveFairy() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22001))
    return
  end
  self.fairyController:EnterFairyCultivate(nil, nil, 1, eFairyEnum.ShowFaiyType.FairyHallScene)
end

function UIFairyLobbyMain:OnClickGetFairy(callback)
  UIManager:ShowWindowAsync(UIWindowTypeID.FairyLottery, function(window)
    if window ~= nil then
      window:InitFairyLottery()
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function UIFairyLobbyMain:OnClickBack()
  self.fairyController:ExitFairyLobby()
end

function UIFairyLobbyMain:OnDelete()
end

return UIFairyLobbyMain
