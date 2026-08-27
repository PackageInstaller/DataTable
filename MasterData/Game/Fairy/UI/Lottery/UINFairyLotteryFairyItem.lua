local UINFairyLotteryFairyItem = class("UINFairyLotteryFairyItem", UIBaseNode)
local base = UIBaseNode
local UINFairySkillItem = require("Game.Fairy.UI.UINFairySkillItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local FairyHelper = require("Game.Fairy.FairyHelper")

function UINFairyLotteryFairyItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_fairy, self, self.__OnClick)
  self.__fairySkillItem = UINFairySkillItem.New()
  self.__fairySkillItem:Init(self.ui.uINFairySkill)
end

function UINFairyLotteryFairyItem:InitFLFairyItem(fairyData, resloader)
  self.fairyData = fairyData
  self.resloader = resloader
  self:__Refresh()
end

function UINFairyLotteryFairyItem:__Refresh()
  local picPath = self.fairyData:GetFairyPicResStr()
  self.ui.img_Fairy.gameObject:SetActive(false)
  self.resloader:LoadABAssetAsync(picPath, function(texture)
    if not IsNull(texture) and not IsNull(self.ui.img_Fairy) then
      self.ui.img_Fairy.gameObject:SetActive(true)
      self.ui.img_Fairy.texture = texture
    end
  end)
  local fairySkillData = self.fairyData:GetFairySkillBySlotIndex(1)
  self.__fairySkillItem:InitFairySkillItem(fairySkillData, self.resloader, function()
    self:__OnClick()
  end)
  self:__RefreshQuality()
end

function UINFairyLotteryFairyItem:__RefreshQuality()
  local quality = self.fairyData:GetCurFairyQuality()
  self.ui.img_frame.color = FairyHelper.GetFairyQualitColor(quality)
  self.ui.fx_Loop[quality]:SetActive(true)
  self.ui.fx_Start[quality]:SetActive(true)
end

function UINFairyLotteryFairyItem:__OnClick()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonFairyInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonFairyInfoWin(self.fairyData, nil)
    local infoNode = window:GetFairyInfoNode()
    infoNode:FloatTo(self.transform, HAType.autoCenter, VAType.downAuto)
    infoNode:ShowCollectBtn(function()
      local fairyNetwork = NetworkManager:GetNetwork(NetworkTypeID.Fairy)
      fairyNetwork:CS_Fairy_Favor(self.fairyData:GetFairyUID(), function()
        self.fairyData:SetIsFavouriteFairy(not self.fairyData:GetIsFavouriteFairy())
        infoNode:RefreshIsFavor(self.fairyData)
      end)
    end)
  end)
end

function UINFairyLotteryFairyItem:OnDelete()
end

return UINFairyLotteryFairyItem
