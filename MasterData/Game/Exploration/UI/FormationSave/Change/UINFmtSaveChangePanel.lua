local base = UIBaseNode
local UINFmtSaveChangePanel = class("UINFmtSaveChangePanel", base)
local UINFmtSaveHeroItem = require("Game.Exploration.UI.FormationSave.Item.UINFmtSaveHeroItem")
local UINFmtSaveFairyItem = require("Game.Exploration.UI.FormationSave.Item.UINFmtSaveFairyItem")
local UINFmtSaveBuffItem = require("Game.Exploration.UI.FormationSave.Item.UINFmtSaveBuffItem")
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local FmtSaveEnum = require("Game.Exploration.UI.FormationSave.Enum.FmtSaveEnum")

function UINFmtSaveChangePanel:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self._OnClickScore)
  self._heroItemPool = UIItemPool.New(UINFmtSaveHeroItem, self.ui.heroItem, false)
  self._fairyItem = UINFmtSaveFairyItem.New()
  self._fairyItem:Init(self.ui.fairyItem)
  self._buffItemPool = UIItemPool.New(UINFmtSaveBuffItem, self.ui.img_Protpcol, false)
  self._chipItemPool = UIItemPool.New(UINChipItem, self.ui.uINChipItem, false)
  self._OnClickChipFunc = BindCallback(self, self._OnClickChip)
end

function UINFmtSaveChangePanel:InitFmtSaveChipPanel(titleIdx, fmtSaveData, resloader, fmtSaveRoot)
  self._fmtSaveRoot = fmtSaveRoot
  self.ui.Title:SetIndex(titleIdx)
  local addition = fmtSaveData:GetFmtSvInfinityAddition()
  if titleIdx == FmtSaveEnum.ChangePanelType.Current then
    addition = fmtSaveData:IsEpWinFmtSaveData() and fmtSaveData:GetFmtSvInfinityAddition() or 0
  end
  self.ui.tex_Additon:SetIndex(0, tostring(addition))
  self.ui.tex_Score:SetIndex(0, tostring(fmtSaveData:GetFmtSvScore()))
  local heroDataList = fmtSaveData:GetFmtSvHeroDataList()
  self._heroItemPool:HideAll()
  for i = 1, 8 do
    local heroData = heroDataList[i]
    local heroItem = self._heroItemPool:GetOne()
    heroItem:InitFmtSaveHeroItem(heroData, resloader)
  end
  self._fairyItem:InitFmtSaveFairyItem(fmtSaveData:GetFmtSvFairyData(), resloader)
  self._fairyItem.transform:SetAsLastSibling()
  self._buffItemPool:HideAll()
  local epBuffList = fmtSaveData:GetFmtSvBuffList()
  for index, epBuff in ipairs(epBuffList) do
    if epBuff:IsBuffNeedShowOnBuffList() then
      local item = self._buffItemPool:GetOne(true)
      item:InitFmtSaveBuffItem(epBuff:GetBuffCfg())
    end
  end
  self.ui.obj_EmptyProtocol:SetActive(#self._buffItemPool.listItem == 0)
  self._chipItemPool:HideAll()
  local chipList = fmtSaveData:GetFmtSvChipDataList()
  local _, dropChipIdDic = fmtSaveData:GetFmtSvDorpChipIdData()
  for k, chipData in ipairs(chipList) do
    if not dropChipIdDic[chipData.dataId] then
      local chipItem = self._chipItemPool:GetOne()
      chipItem:InitChipItem(chipData, true, self._OnClickChipFunc)
    end
  end
  self.ui.obj_EmptyFx:SetActive(#chipList == 0)
end

function UINFmtSaveChangePanel:_OnClickChip(chipData)
  self._fmtSaveRoot:ShowFmtSaveChipDetail(chipData)
end

function UINFmtSaveChangePanel:_OnClickScore()
end

function UINFmtSaveChangePanel:OnDelete()
  self._heroItemPool:DeleteAll()
  self._buffItemPool:DeleteAll()
  self._chipItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINFmtSaveChangePanel
