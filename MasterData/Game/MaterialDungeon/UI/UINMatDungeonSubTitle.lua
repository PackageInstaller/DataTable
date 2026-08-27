local UINMatDungeonSubTitle = class("UINMatDungeonSubTitle", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINMatDungeonSubTitle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_tile, self, self.OnClickTitle)
end

function UINMatDungeonSubTitle:SetSubTitleInfo(dungeonSubInfoCfg, resLoader, isShowOpen, onClickFunc)
  self.ui.img_Icon.sprite = AtlasUtil.GetSpriteFromAtlas("CommonDungeon", dungeonSubInfoCfg.icon, resLoader)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(dungeonSubInfoCfg.text)
  self.isShowOpen = isShowOpen or false
  self.stage_type = dungeonSubInfoCfg.stage_type
  self.onClickFunc = onClickFunc
  if not IsNull(self.ui.img_SelectBG) then
    self.ui.img_SelectBG:SetIndex(dungeonSubInfoCfg.img_bottom_idx)
  end
  self:RefreshState()
end

function UINMatDungeonSubTitle:RefreshIsMultReward(dungeonItemDic)
  local isHaveMultReward = false
  local isOnlyDouble = true
  for dungeonData, item in pairs(dungeonItemDic) do
    if dungeonData:GetSubTitleId() == self.stage_type and dungeonData:GetIsHaveMultReward() then
      isHaveMultReward = true
      local multAddRate = dungeonData:GetActivityMultRewardRate()
      if multAddRate ~= 1 then
        isOnlyDouble = false
      end
    end
  end
  if isHaveMultReward then
    self.ui.obj_dropUp:SetActive(true)
    if isOnlyDouble then
      self.ui.tex_multType:SetIndex(1)
    else
      self.ui.tex_multType:SetIndex(0)
    end
  else
    self.ui.obj_dropUp:SetActive(false)
  end
end

function UINMatDungeonSubTitle:RefreshDgSubShowBluedot(dungeonItemDic)
  local showRedDot = false
  for dungeonData, item in pairs(dungeonItemDic) do
    if dungeonData:GetSubTitleId() == self.stage_type and item:IsShowAthDgItemeBlueDot() then
      showRedDot = true
      break
    end
  end
  self:ShowDgSubTitleBlueDot(showRedDot)
end

function UINMatDungeonSubTitle:RefreshState()
  self.ui.obj_CloseList.gameObject:SetActive(self.isShowOpen)
  self.ui.obj_OpenList.gameObject:SetActive(not self.isShowOpen)
end

function UINMatDungeonSubTitle:SetMatDgSubTitleLock(firstDgData)
  self._firstDgData = firstDgData
  self.ui.state_lock.gameObject:SetActive(not firstDgData:GetIsUnlock())
end

function UINMatDungeonSubTitle:OnClickTitle()
  if self._firstDgData ~= nil and not self.isShowOpen and not self._firstDgData:GetIsUnlock() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(self._firstDgData:GetDungeonUnlockDes())
  end
  self.isShowOpen = not self.isShowOpen
  self:RefreshState()
  if self.onClickFunc ~= nil then
    self.onClickFunc(self.stage_type, self.isShowOpen)
  end
  AudioManager:PlayAudioById(1060)
end

function UINMatDungeonSubTitle:SetDungeonSubTitleState(isOpen)
  self.isShowOpen = isOpen
  self:RefreshState()
end

function UINMatDungeonSubTitle:ShowDgSubTitleBlueDot(isShow)
  self.ui.obj_blueDot:SetActive(isShow)
end

function UINMatDungeonSubTitle:OnDelete()
  base.OnDelete(self)
end

return UINMatDungeonSubTitle
