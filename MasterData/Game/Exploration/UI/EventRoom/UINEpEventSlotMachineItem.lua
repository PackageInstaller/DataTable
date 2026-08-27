local UINEpEventSlotMachineItem = class("UINEpEventSlotMachineItem", UIBaseNode)
local base = UIBaseNode
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local EpCommonUtil = require("Game.Exploration.Util.EpCommonUtil")

function UINEpEventSlotMachineItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn_item.onPressDown:AddListener(BindCallback(self, self._OnPressDown))
  self.ui.btn_item.onPressUp:AddListener(BindCallback(self, self._OnPressUp))
end

function UINEpEventSlotMachineItem:InitSlotMachineItem(choiceData, onPressUp, onPressDown)
  self.choiceData = choiceData
  self._onPressUp = onPressUp
  self._onPressDown = onPressDown
  self.cfg = ConfigData.event_choice[self.choiceData.choiceId]
  self.strName = EpCommonUtil.GetEventReplaceText(self.cfg, "describe")
  self.strDesc = LanguageUtil.GetLocaleText(self.cfg.exDescribe)
  self.ui.tex_Random.text = self.strName
  self.ui.bottom:SetIndex(self.cfg.gamblebenefit_tag ~= ExplorationEnum.epGamblebenefitTagType.Debuff and 0 or 1)
  self.ui.img_Icon.sprite = CRH:GetSprite(self.cfg.icon, CommonAtlasType.ExplorationIcon)
  self.hasExDesc = self.strDesc ~= nil or not string.IsNullOrEmpty(self.strDesc)
  self.ui.img_OnSelect.gameObject:SetActive(self.hasExDesc)
  self.ui.img_OnSelect.color = self.ui.col_gray
  self.ui.btn_item.enabled = self.hasExDesc
end

function UINEpEventSlotMachineItem:_OnPressDown()
  if not self.hasExDesc then
    return
  end
  if self._onPressDown ~= nil then
    self.ui.img_OnSelect.color = Color.white
    self._onPressDown(self.strName, self.strDesc)
  end
end

function UINEpEventSlotMachineItem:_OnPressUp()
  if self._onPressUp ~= nil then
    self.ui.img_OnSelect.color = self.ui.col_gray
    self._onPressUp()
  end
end

return UINEpEventSlotMachineItem
