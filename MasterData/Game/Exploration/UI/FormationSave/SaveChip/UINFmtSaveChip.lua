local base = UIBaseNode
local UINFmtSaveChip = class("UINFmtSaveChip", base)
local UINFmtSaveHeroItem = require("Game.Exploration.UI.FormationSave.Item.UINFmtSaveHeroItem")
local UINFmtSaveFairyItem = require("Game.Exploration.UI.FormationSave.Item.UINFmtSaveFairyItem")
local UINFmtSaveBuffItem = require("Game.Exploration.UI.FormationSave.Item.UINFmtSaveBuffItem")
local UINFmtSaveChipItem = require("Game.Exploration.UI.FormationSave.Item.UINFmtSaveChipItem")
local cs_MessageCommon = CS.MessageCommon

function UINFmtSaveChip:ctor(fmtSaveRoot)
  self._fmtSaveRoot = fmtSaveRoot
end

function UINFmtSaveChip:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_Tip, self, self._OnClickScore)
  UIUtil.AddButtonListener(self.ui.Btn_Next, self, self._OnClickNext)
  self._heroItemPool = UIItemPool.New(UINFmtSaveHeroItem, self.ui.HeroItem, false)
  self._fairyItem = UINFmtSaveFairyItem.New()
  self._fairyItem:Init(self.ui.FairyItem)
  self._buffItemPool = UIItemPool.New(UINFmtSaveBuffItem, self.ui.Img_Protpcol, false)
  self._chipItemPool = UIItemPool.New(UINFmtSaveChipItem, self.ui.ChipItem, false)
  self._OnClickChipFunc = BindCallback(self, self._OnClickChip)
  self._OnSelectChipFunc = BindCallback(self, self._OnSelectChip)
end

function UINFmtSaveChip:InitFmtSaveChip(fmtSaveData, resloader)
  self._fmtSaveData = fmtSaveData
  self._saveChipMaxNum = fmtSaveData:GetFmtSvSaveChipMaxNum()
  self._heroItemPool:HideAll()
  local heroDataList = fmtSaveData:GetFmtSvHeroDataList()
  for i = 1, 8 do
    local heroData = heroDataList[i]
    local heroItem = self._heroItemPool:GetOne()
    heroItem:InitFmtSaveHeroItem(heroData, resloader)
  end
  self._fairyItem:InitFmtSaveFairyItem(fmtSaveData:GetFmtSvFairyData(), resloader)
  self._fairyItem.transform:SetAsLastSibling()
  local epBuffList = fmtSaveData:GetFmtSvBuffList()
  self._buffItemPool:HideAll()
  for index, epBuff in ipairs(epBuffList) do
    if epBuff:IsBuffNeedShowOnBuffList() then
      local item = self._buffItemPool:GetOne(true)
      item:InitFmtSaveBuffItem(epBuff:GetBuffCfg())
    end
  end
  self.ui.obj_EmptyProtocol:SetActive(#self._buffItemPool.listItem == 0)
  self._SelectedChipDataDic = {}
  self._chipItemPool:HideAll()
  local chipList = fmtSaveData:GetFmtSvChipDataList()
  for k, chipData in ipairs(chipList) do
    local chipItem = self._chipItemPool:GetOne()
    chipItem:InitFmtSaveChipItem(chipData, self._OnClickChipFunc, self._OnSelectChipFunc)
  end
  self:_UpdChipNum()
  self.ui.obj_EmptyFx:SetActive(#chipList == 0)
  local infinityAddition = self._fmtSaveData:IsEpWinFmtSaveData() and self._fmtSaveData:GetFmtSvInfinityAddition() or 0
  self.ui.Tex_InfinityAdditon:SetIndex(0, tostring(infinityAddition))
  local score = self._fmtSaveData:GetFmtSvScore()
  self.ui.Tex_Score:SetIndex(0, tostring(score))
end

function UINFmtSaveChip:_PlayShowTween()
  self.ui.main_cg:DOKill(true)
  self.ui.main_cg:DOFade(0, 0.4):From():SetLink(self.gameObjct)
  self.ui.main_cg.transform:DOKill(true)
  self.ui.main_cg.transform:DOLocalMoveY(200, 0.4):From():SetLink(self.gameObjct)
  self.ui.bottom_cg:DOKill(true)
  self.ui.bottom_cg:DOFade(0, 0.4):From():SetDelay(0.1):SetLink(self.gameObjct)
  self.ui.bottom_cg.transform:DOKill(true)
  self.ui.bottom_cg.transform:DOLocalMoveY(200, 0.4):From():SetDelay(0.1):SetLink(self.gameObjct)
end

function UINFmtSaveChip:OnShow()
  base.OnShow(self)
  self:_PlayShowTween()
end

function UINFmtSaveChip:_OnClickChip(chipData)
  self._fmtSaveRoot:ShowFmtSaveChipDetail(chipData)
end

function UINFmtSaveChip:_OnSelectChip(chipData, isSelect)
  if isSelect then
    if table.count(self._SelectedChipDataDic) >= self._saveChipMaxNum then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(57001))
      return false
    end
    self._SelectedChipDataDic[chipData] = true
  else
    self._SelectedChipDataDic[chipData] = nil
  end
  self:_UpdChipNum()
  return true
end

function UINFmtSaveChip:_UpdChipNum()
  self.ui.tex_ChipNum:SetIndex(0, tostring(table.count(self._SelectedChipDataDic)), tostring(self._saveChipMaxNum))
end

function UINFmtSaveChip:_OnClickScore()
  UIManager:ShowWindowAsync(UIWindowTypeID.ChipScoreShow, function(win)
    if win == nil then
      return
    end
    win:InitChipScoreShow()
  end)
end

function UINFmtSaveChip:_OnClickNext()
  local function nextFunc()
    local chipList = {}
    
    for chipData, _ in pairs(self._SelectedChipDataDic) do
      table.insert(chipList, chipData)
      table.sort(chipList, function(a, b)
        return a.dataId < b.dataId
      end)
    end
    self._fmtSaveData:SetFmtSvSelectedChipList(chipList)
    self._fmtSaveRoot:EnterFmtSaveChange()
  end
  
  local curSelectNum = table.count(self._SelectedChipDataDic)
  local waitSelectNum = #self._fmtSaveData:GetFmtSvChipDataList()
  local maxNum = math.min(self._saveChipMaxNum, waitSelectNum)
  if curSelectNum < maxNum and not PlayerDataCenter.cacheSaveData:IsEpSvFmtSelectChipTip() then
    local windonw = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    windonw:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(57002), nextFunc)
    windonw:ShowDontRemindTog(function(isOn)
      PlayerDataCenter.cacheSaveData:SetEpSvFmtSelectChipTip(isOn)
    end)
    return
  end
  nextFunc()
end

function UINFmtSaveChip:OnDelete()
  self._heroItemPool:DeleteAll()
  self._buffItemPool:DeleteAll()
  self._chipItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINFmtSaveChip
