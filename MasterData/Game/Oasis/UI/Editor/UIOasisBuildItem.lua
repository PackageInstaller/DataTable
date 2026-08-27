local UIOasisBuildItem = class("UIOasisBuildItem", UIBaseNode)
local base = UIBaseNode
local BuildingEnum = require("Game.Oasis.Data.BuildingEnum")

function UIOasisBuildItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  UIUtil.AddButtonListener(self.ui.btn_Preview, self, self._OnClickPreview)
end

function UIOasisBuildItem:InitOasisBuildItem(buildTypeData, resLoader, newBuildingFunc, previewBuildFunc)
  self.newBuildingFunc = newBuildingFunc
  self.previewBuildFunc = previewBuildFunc
  self.buildTypeData = buildTypeData
  local buildingData = buildTypeData:GetNextUnlockBuildData()
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(buildingData.dynData.stcData.name)
  self.ui.tex_Intro.text = LanguageUtil.GetLocaleText(buildingData.dynData.stcData.intro)
  local path = PathConsts:GetOasisBuildingIconPath(buildingData.dynData.icon_res)
  self.ui.img_Pic.enabled = false
  resLoader:LoadABAssetAsync(path, function(texture)
    if texture == nil then
      return
    end
    self.ui.img_Pic.texture = texture
    self.ui.img_Pic.enabled = true
  end)
  self.ui.img_Icon.sprite = CRH:GetSprite(buildingData.dynData.stcData.small_icon)
  self:RefreshUIOasisBuildData(buildingData)
end

function UIOasisBuildItem:RefreshUIOasisBuildData(buildingData)
  self.buildingData = buildingData
  self:RefreshUIOasisBuildItemState()
end

function UIOasisBuildItem:RefreshUIOasisBuildItemState()
  local curNum, maxNum = self.buildTypeData:GetBuildTypeNum()
  self.ui.tex_Count:SetIndex(0, tostring(curNum), tostring(maxNum))
  local buildingData = self.buildingData
  self.ui.isLock:SetActive(false)
  self.ui.tips:SetActive(false)
  self.ui.hasBuildCount:SetActive(true)
  local typeState = self.buildTypeData:GetBuildTypeState()
  if typeState == BuildingEnum.BuildingTypeState.Lock then
    self.ui.hasBuildCount:SetActive(false)
    self.ui.isLock:SetActive(true)
    self.ui.tips:SetActive(true)
    self:_RefreshUnlockTips(buildingData)
  elseif typeState == BuildingEnum.BuildingTypeState.MaxNum then
    self.ui.tips:SetActive(true)
    self.ui.tex_Tips:SetIndex(0)
  elseif typeState == BuildingEnum.BuildingTypeState.MoreNumLock then
    self.ui.tips:SetActive(true)
    self:_RefreshUnlockTips(buildingData)
  elseif typeState == BuildingEnum.BuildingTypeState.CanBuild and not buildingData.dynData:CanBuild() then
    local levelCfg = buildingData.dynData.levelConfig[1]
    if 0 < #levelCfg.consumeIds then
      error(string.format("Building [%s] level 1 cost is not null", buildingData.id))
    end
  end
end

function UIOasisBuildItem:_RefreshUnlockTips(buildingData)
  local lockMsg
  local unlockTab = buildingData.dynData:GetPreBuildingLvlInfo(1)
  for k, condition in ipairs(unlockTab) do
    if not condition.unlock then
      if string.IsNullOrEmpty(lockMsg) then
        lockMsg = condition.lockReason
      else
        lockMsg = lockMsg .. "\n" .. condition.lockReason
      end
    end
  end
  self.ui.tex_Tips.text.text = lockMsg
end

function UIOasisBuildItem:_OnClickRoot()
  if self.buildTypeData:GetBuildTypeState() == BuildingEnum.BuildingTypeState.CanBuild and self.newBuildingFunc ~= nil then
    self.newBuildingFunc(self)
  end
end

function UIOasisBuildItem:_OnClickPreview()
  if self.previewBuildFunc ~= nil then
    self.previewBuildFunc(self.buildingData)
  end
end

function UIOasisBuildItem:OnDelete()
  base.OnDelete(self)
end

return UIOasisBuildItem
