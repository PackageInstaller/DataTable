local UINEventRoomPageBase = class("UINEventRoomPageBase", UIBaseNode)
local base = UIBaseNode
local EpCommonUtil = require("Game.Exploration.Util.EpCommonUtil")
local Enum = require("Game.Exploration.EpEventRoomEnum")

function UINEventRoomPageBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.tex_EventText.text = ""
end

function UINEventRoomPageBase:InitBranchPage(uiEvent, onChoiceClick)
  self.uiEvent = uiEvent
  self.onChoiceClick = onChoiceClick
  self.choicePool = self.uiEvent:GetChoiceItemPool()
  uiEvent:SetRefreshBtn(false)
  uiEvent:SetSkipBtnActive(false)
  self:RefreshBranchPage(uiEvent)
end

function UINEventRoomPageBase:RefreshBranchPage()
  self:RefreshEventText()
  self:RefreshEntChoiceList()
end

function UINEventRoomPageBase:RefreshEventText()
  local eventText = EpCommonUtil.GetEventReplaceText(self.uiEvent.eventCfg, "event_txt")
  self.ui.tex_EventText:DOKill()
  self.ui.tex_EventText:DOText(eventText, 1, true):SetLink(self.ui.tex_EventText.gameObject)
end

function UINEventRoomPageBase:RefreshEntChoiceList()
  local roomData = self.uiEvent.roomData
  self.choiceItemDic = {}
  self.choicePool:HideAll()
  local extraItemPool = self:_GetExtraItemPool()
  extraItemPool:HideAll()
  for index, choiceData in ipairs(roomData.choiceDatalist) do
    if choiceData.cfg ~= nil then
      local hasTag = choiceData.cfg.gamblebenefit_tag ~= nil
      if hasTag then
        local hasGamble = choiceData.cfg.gamblebenefit_tag > 0
        if hasGamble then
          goto lbl_72
        end
      end
      local choiceItem = self.choicePool:GetOne()
      choiceItem:SetParent(self.ui.rect)
      choiceItem:InitEventChoiceItem(choiceData, self.onChoiceClick)
      if choiceData.displayNewData ~= nil then
        choiceItem:InjectExtraItemPool(extraItemPool)
      end
      if self.uiEvent.eventCfg.event_tag == Enum.eBranch.EventShop then
        choiceItem:IsNeedExtraItemLimitWidth(true)
      end
      choiceItem:RefreshChoiceUI(choiceData.displayNewData)
      choiceItem.gameObject.name = tostring(index)
      self.choiceItemDic[index] = choiceItem
    end
    ::lbl_72::
  end
end

function UINEventRoomPageBase:_GetExtraItemPool()
  return self.uiEvent:GetExtraItemPool()
end

function UINEventRoomPageBase:OnDelete()
  base.OnDelete(self)
end

return UINEventRoomPageBase
