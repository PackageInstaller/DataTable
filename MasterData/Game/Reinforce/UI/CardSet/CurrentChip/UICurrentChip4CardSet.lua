local base = require("Game.Exploration.UI.CurrentChip.UICurrentChip")
local UICurrentChip4CardSet = class("UICurrentChip4CardSet", base)
local util = require("XLua.Common.xlua_util")

function UICurrentChip4CardSet:OnInit()
  base.OnInit(self)
  self.__OnSelectStartCareerTag = BindCallback(self, self.OnSelectStartCareerTag)
end

function UICurrentChip4CardSet:InitCurrentChip(chipDataList, startChipDataList)
  base.InitCurrentChip(self, chipDataList)
  self.startChipDataList = startChipDataList
  if 0 < #startChipDataList then
    local startCareerItem = self.careerItemPool:GetOne()
    startCareerItem:InitCareerTag(6, #startChipDataList, self.__OnSelectStartCareerTag)
    startCareerItem:Select(false)
    startCareerItem:SetSelectState()
  end
end

function UICurrentChip4CardSet:OnSelectStartCareerTag(careerTag, flag)
  if not flag then
    return
  end
  local selectCareerId = careerTag.careerId
  for _, v in ipairs(self.careerItemPool.listItem) do
    v:SetSelectState()
  end
  self.ui.scrollbar.value = 1
  self.ui.scrollbarGroup.alpha = 0
  self.showItemPool:HideAll()
  self._chipDataList = self.startChipDataList
  if self._initChipCo ~= nil then
    GR.StopCoroutine(self._initChipCo)
    self._initChipCo = nil
  end
  self._CoUpdChipFunc = self._CoUpdChipFunc or BindCallback(self, self._CoUpdChip)
  self._initChipCo = GR.StartCoroutine(util.cs_generator(self._CoUpdChipFunc))
  if not self._notClickTog then
    if selectCareerId == 0 then
      AudioManager:PlayAudioById(4100)
    elseif selectCareerId == 6 then
      AudioManager:PlayAudioById(4100)
    else
      local careerCfg = ConfigData.career[selectCareerId]
      AudioManager:PlayAudioById(careerCfg.click_audio)
    end
  end
end

function UICurrentChip4CardSet:OnDelete()
  base.OnDelete(self)
end

return UICurrentChip4CardSet
