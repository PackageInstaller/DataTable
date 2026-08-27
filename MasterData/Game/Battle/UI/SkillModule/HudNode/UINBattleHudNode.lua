local UINBattleHudNode = class("UINBattleHudNode", UIBaseNode)
local base = UIBaseNode
local UINHudItem = require("Game.Battle.UI.SkillModule.HudNode.UINHudItem")
local StartHudValue = 30
local EndHudValue = 150
local itemHudSize = 30

function UINBattleHudNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.scrollItemDic = {}
end

function UINBattleHudNode:InitBattleHud(camera)
  self.camera = camera
  self.camHudTimerId = TimerManager:StartTimer(5, self.RefreshBattleHudCamera, self)
  local totalCount = (EndHudValue - StartHudValue) / 30
  self.ui.scrollRect.totalCount = totalCount
  self.ui.scrollRect:RefillCells()
end

function UINBattleHudNode:RefreshBattleHudCamera()
  if IsNull(self.camera) then
    return
  end
  local pos = self.camera.transform.position
  self.ui.tex_PosX.text = GetPreciseDecimalStr(pos.x, 4)
  self.ui.tex_PosY.text = GetPreciseDecimalStr(pos.y, 4)
  self.ui.tex_PosZ.text = GetPreciseDecimalStr(pos.z, 4)
  self.ui.tex_FOV.text = GetPreciseDecimalStr(self.camera.fieldOfView, 4)
  local angle = self.camera.transform.eulerAngles
  self.ui.tex_RoteX.text = GetPreciseDecimalStr(angle.x, 4)
  self.ui.tex_RoteY.text = GetPreciseDecimalStr(angle.y, 4)
  self.ui.tex_RoteZ.text = GetPreciseDecimalStr(angle.z, 4)
  local rotation = self.camera.transform.rotation
  self.ui.tex_QuaX.text = GetPreciseDecimalStr(rotation.x, 4)
  self.ui.tex_QuaY.text = GetPreciseDecimalStr(rotation.y, 4)
  self.ui.tex_QuaZ.text = GetPreciseDecimalStr(rotation.z, 4)
  self.ui.tex_QuaW.text = GetPreciseDecimalStr(rotation.w, 4)
end

function UINBattleHudNode:RefreshHudScroll(value)
  local normalPos = self.ui.scrollRect.normalizedPosition
  normalPos.y = 1 - value
  self.ui.scrollRect.normalizedPosition = normalPos
end

function UINBattleHudNode:__OnNewItem(go)
  local item = UINHudItem.New()
  item:Init(go)
  self.scrollItemDic[go] = item
end

function UINBattleHudNode:__OnChangeItem(go, index)
  local item = self.scrollItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local startNum = EndHudValue - (StartHudValue + index * itemHudSize)
  item:RefreshHudItem(startNum)
end

function UINBattleHudNode:OnDelete()
  TimerManager:StopTimer(self.camHudTimerId)
  for k, v in pairs(self.scrollItemDic) do
    v:Delete()
  end
  self.scrollItemDic = nil
  base.OnDelete(self)
end

return UINBattleHudNode
