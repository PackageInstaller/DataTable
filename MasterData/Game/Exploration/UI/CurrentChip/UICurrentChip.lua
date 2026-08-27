local UICurrentChip = class("UICurrentChip", UIBaseWindow)
local base = UIBaseWindow
local UINCurrentChipCareerItem = require("Game.Exploration.UI.CurrentChip.UINCurrentChipCareerItem")
local UINCurrentChipShowItem = require("Game.CommonUI.Chip.UINBaseChipDetail")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local util = require("XLua.Common.xlua_util")
local cs_resLoader = CS.ResLoader
local cs_Edge = CS.UnityEngine.RectTransform.Edge

function UICurrentChip:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickCloseCurrentChip)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self.OnClickCloseCurrentChip)
  self.resloader = cs_resLoader.Create()
  self.careerItemPool = UIItemPool.New(UINCurrentChipCareerItem, self.ui.obj_careerItem)
  self.ui.obj_careerItem:SetActive(false)
  self.showItemPool = UIItemPool.New(UINCurrentChipShowItem, self.ui.obj_chipItem)
  self.ui.obj_chipItem:SetActive(false)
  self.__OnSelectCareerTag = BindCallback(self, self.OnSelectCareerTag)
  self.ui.tex_Tile:SetIndex(0)
end

function UICurrentChip:InitCurrentChip(chipDataList)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack()
  self.careerChipDataDic = {}
  for _, chipData in ipairs(chipDataList) do
    local key
    if chipData.chipCfg.influence == ChipEnum.eChipInfluenceType.Career then
      key = chipData.chipCfg.arg
    else
      key = 0
    end
    local list = self.careerChipDataDic[key]
    if list == nil then
      list = {}
      self.careerChipDataDic[key] = list
    end
    table.insert(list, chipData)
  end
  for _, list in pairs(self.careerChipDataDic) do
    table.sort(list, function(a, b)
      local aCount = a:GetCount()
      local bCount = b:GetCount()
      if aCount ~= bCount then
        return aCount > bCount
      end
      return a.chipCfg.id < b.chipCfg.id
    end)
  end
  self.careerItemPool:HideAll()
  local tags = {}
  for careerId, _ in pairs(self.careerChipDataDic) do
    table.insert(tags, careerId)
  end
  table.sort(tags, function(a, b)
    if a == 0 then
      return false
    end
    if b == 0 then
      return true
    end
    return a < b
  end)
  for _, careerId in ipairs(tags) do
    local item = self.careerItemPool:GetOne()
    item:InitCareerTag(careerId, table.count(self.careerChipDataDic[careerId]), self.__OnSelectCareerTag)
  end
  self._initInit = true
  self._notClickTog = true
  local toggleGroup = self.ui.obj_careerList:FindComponent(eUnityComponentID.ToggleGroup)
  toggleGroup:SetAllTogglesOff(false)
  if #self.careerItemPool.listItem > 1 then
    self.careerItemPool.listItem[1]:Select(true)
  end
  self._notClickTog = false
end

function UICurrentChip:SetCurrentChipTitleIdx(texIdx)
  self.ui.tex_Tile:SetIndex(texIdx)
end

function UICurrentChip:OnSelectCareerTag(careerTag, flag)
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
  local chipDataList = self.careerChipDataDic[selectCareerId]
  self._chipDataList = chipDataList
  if self._initChipCo ~= nil then
    GR.StopCoroutine(self._initChipCo)
    self._initChipCo = nil
  end
  self._CoUpdChipFunc = self._CoUpdChipFunc or BindCallback(self, self._CoUpdChip)
  self._initChipCo = GR.StartCoroutine(util.cs_generator(self._CoUpdChipFunc))
  if not self._notClickTog then
    if selectCareerId == 0 then
      AudioManager:PlayAudioById(4100)
    else
      local careerCfg = ConfigData.career[selectCareerId]
      AudioManager:PlayAudioById(careerCfg.click_audio)
    end
  end
end

function UICurrentChip:_CoUpdChip()
  local win = UIManager:GetWindow(UIWindowTypeID.RichIntro)
  if win ~= nil then
    win:Hide()
  end
  for index, chipData in ipairs(self._chipDataList) do
    if self._initInit and index % 3 == 0 then
      coroutine.yield(nil)
    end
    local item = self.showItemPool:GetOne()
    item:InitBaseChipDetail(index, chipData, nil, self.resloader)
  end
  self.ui.scrollbarGroup.alpha = 1
  self._initInit = false
  self._initChipCo = nil
end

function UICurrentChip:_BackAction()
  self:Delete()
  if self.closeFunc ~= nil then
    self.closeFunc()
  end
end

function UICurrentChip:OnClickCloseCurrentChip()
  UIUtil.OnClickBackByUiTab(self)
end

function UICurrentChip:SetCurrentChipCloseFunc(func)
  self.closeFunc = func
end

function UICurrentChip:OnHide()
  if ExplorationManager:GetDynPlayer() == nil then
    UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
  end
end

function UICurrentChip:OnDelete()
  if self._initChipCo ~= nil then
    GR.StopCoroutine(self._initChipCo)
    self._initChipCo = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  local window = UIManager:GetWindow(UIWindowTypeID.RichIntro)
  if window ~= nil then
    window:Delete()
  end
  self.showItemPool:DeleteAll()
  self.showItemPool:DeleteAll()
  base.OnDelete(self)
end

return UICurrentChip
