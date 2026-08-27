local UINEventRoomRandomResult = class("UINEventRoomRandomResult", UIBaseNode)
local base = UIBaseNode
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local eResukltLogic = {
  addItem = 1,
  eventJump = 2,
  minItem = 3
}
local eLogicFunc = {
  [eResukltLogic.addItem] = function(para1, para2)
    local temp = string.split(para1, "_")
    local itemNum = temp[2]
    local des = LanguageUtil.GetLocaleText(para2)
    des = string.format(des, itemNum)
    return des
  end,
  [eResukltLogic.eventJump] = function(para1, para2)
    return LanguageUtil.GetLocaleText(para2)
  end,
  [eResukltLogic.minItem] = function(para1, para2)
    local temp = string.split(para1, "_")
    local itemNum = temp[2]
    local des = LanguageUtil.GetLocaleText(para2)
    des = string.format(des, itemNum)
    return des
  end
}

function UINEventRoomRandomResult:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINEventRoomRandomResult:InitRandomResult(passNum, probability, logic, para1, para2, jumpTarget)
  self.ui.txt_passNum.text = passNum
  self.des = eLogicFunc[logic](para1, para2)
  self.jumpTarget = jumpTarget
  self.ui.txt_resultText:SetIndex(0, tostring(GetPreciseDecimalStr(probability * 100, 0)), self.des)
end

function UINEventRoomRandomResult:GetDes()
  return self.des
end

function UINEventRoomRandomResult:OnDelete()
  base.OnDelete(self)
end

return UINEventRoomRandomResult
