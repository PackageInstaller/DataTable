local UINEventRoomRandomOptionButton = class("UINEventRoomRandomOptionButton", UIBaseNode)
local base = UIBaseNode
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UINEventRoomRandomOptionButton:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.optionButton, self, self.OnClick)
end

function UINEventRoomRandomOptionButton:InitNormalButton(cfg, idx, clickCallback)
  self.ui.btnText.text = tostring(cfg.id)
  self.ui.tipText.text = "普通选项"
  self.cfg = cfg
  self.idx = idx
  self.clickCallback = clickCallback
end

function UINEventRoomRandomOptionButton:InitRandomButton(cfg, idx, clickCallback)
  self.ui.btnText.text = LanguageUtil.GetLocaleText(cfg.name)
  self.ui.tipText.text = "判定" .. LanguageUtil.GetLocaleText(ConfigData.career[cfg.judge_profession].name)
  self.cfg = cfg
  self.idx = idx
  self.clickCallback = clickCallback
end

function UINEventRoomRandomOptionButton:OnClick()
  if self.clickCallback ~= nil then
    self.clickCallback(self.cfg, self.idx)
  end
end

function UINEventRoomRandomOptionButton:OnDelete()
  base.OnDelete(self)
end

return UINEventRoomRandomOptionButton
