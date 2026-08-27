local base = UIBaseWindow
local UIInfiniteFrmCheckWindow = class("UIInfiniteFrmCheckWindow", base)
local UINFmtSaveHeroItem = require("Game.Exploration.UI.FormationSave.Item.UINFmtSaveHeroItem")
local UINFmtSaveFairyItem = require("Game.Exploration.UI.FormationSave.Item.UINFmtSaveFairyItem")
local UINFmtSaveBuffItem = require("Game.Exploration.UI.FormationSave.Item.UINFmtSaveBuffItem")
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local UINFmtSaveChipDetail = require("Game.Exploration.UI.FormationSave.ChipDetail.UINFmtSaveChipDetail")

function UIInfiniteFrmCheckWindow:OnInit()
  self.resloader = CS.ResLoader.Create()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):PushTopStatusDataToBackStack(true)
  UIUtil.AddButtonListener(self.ui.Btn_Tip, self, self._OnClickScore)
  UIUtil.AddButtonListener(self.ui.Btn_Close, self, self.Delete)
  self._fairyItem = UINFmtSaveFairyItem.New()
  self._fairyItem:Init(self.ui.fairyItem)
  self._chipDetailNode = UINFmtSaveChipDetail.New()
  self._chipDetailNode:Init(self.ui.ChipDetail)
  self._chipDetailNode:Hide()
  self._heroItemPool = UIItemPool.New(UINFmtSaveHeroItem, self.ui.heroItem, false)
  self._buffItemPool = UIItemPool.New(UINFmtSaveBuffItem, self.ui.img_Protpcol, false)
  self._chipItemPool = UIItemPool.New(UINChipItem, self.ui.uINChipItem, false)
  self._OnClickChipFunc = BindCallback(self, self._OnClickChip)
end

function UIInfiniteFrmCheckWindow:InitFmtSaveChipPanel(fmtSaveData)
  self._fmtSaveData = fmtSaveData
  self.ui.tex_Additon:SetIndex(0, tostring(fmtSaveData:GetFmtSvInfinityAddition()))
  self.ui.tex_Score:SetIndex(0, tostring(fmtSaveData:GetFmtSvScore()))
  local heroDataList = fmtSaveData:GetFmtSvHeroDataList()
  self._heroItemPool:HideAll()
  for i = 1, 8 do
    local heroData = heroDataList[i]
    local heroItem = self._heroItemPool:GetOne()
    heroItem:InitFmtSaveHeroItem(heroData, self.resloader)
  end
  self._fairyItem:InitFmtSaveFairyItem(fmtSaveData:GetFmtSvFairyData(), self.resloader)
  self._fairyItem.transform:SetAsLastSibling()
  for index, epBuff in ipairs(fmtSaveData:GetFmtSvBuffList()) do
    if epBuff:IsBuffNeedShowOnBuffList() then
      local item = self._buffItemPool:GetOne(true)
      item:InitFmtSaveBuffItem(epBuff:GetBuffCfg())
    end
  end
  self._chipItemPool:HideAll()
  for k, chipData in ipairs(fmtSaveData:GetFmtSvChipDataList()) do
    local chipItem = self._chipItemPool:GetOne()
    chipItem:InitChipItem(chipData, true, self._OnClickChipFunc)
  end
end

function UIInfiniteFrmCheckWindow:_OnClickChip(chipData)
  local dynChipSuitMgr = self._fmtSaveData:GetFmtSvChipSuitMgr()
  self._chipDetailNode:InitFmtSaveChipDetail(chipData, dynChipSuitMgr, self.resloader)
end

function UIInfiniteFrmCheckWindow:_OnClickScore()
end

function UIInfiniteFrmCheckWindow:OnDelete()
  self._heroItemPool:DeleteAll()
  self._buffItemPool:DeleteAll()
  self._chipItemPool:DeleteAll()
  self.resloader:Put2Pool()
  self.resloader = nil
  base.OnDelete(self)
end

return UIInfiniteFrmCheckWindow
