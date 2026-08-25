local PlayerStatsKey = CommonDefine.PlayerStatsKey
local PlayerStatsType = CommonDefine.PlayerStatsType
local STARMAXNUM = 5
local SummonCareerSelectItem, Super = System.NewComponent("SummonCareerSelectItem")

function SummonCareerSelectItem:ctor(uiNode, data, selectedEffect)
  Super.ctor(self)
  self.ui = UI_Summon_Btn_RealmsResource(uiNode)
  self.schoolId = data.schoolId
  self.summonId = data.summonId
  self.clickCb = data.clickCb
  self.model = data.model
  self.selectedFunc = data.selectedFunc
  self.effectedFunc = data.effectedFunc
  self.cfg = DT.SchoolConfig[self.schoolId]
  self.selectedEffect = selectedEffect
end

function SummonCareerSelectItem:OnBind(binder)
  self.bidner = binder
  self:_OnBindHardStar(binder)
  binder:BindToImage(self.ui.Image_Icon, function()
    return self.cfg.Icon
  end)
  binder:BindToText(self.ui.Text_Active_Name, function()
    return self.cfg.Name
  end)
  binder:BindToText(self.ui.Text_Active_Describe, function()
    return self.cfg.SchoolFeature
  end)
  binder:BindToVisible(self.ui.Image_Selected, self.selectedFunc)
  binder:BindToVisible(self.ui.Image_TipsBG, self.effectedFunc)
  binder:UpdateLocalizedTextAndResouce(self.ui.UI_Common_Item_Hint)
  binder:BindToVisible(self.ui.UI_Common_Item_Hint, function()
    return false
  end)
  binder:BindButtonClick(self.ui.Btn_Click, self.clickCb)
  binder:BindToRaw(function(_, isSelected, _)
    self.ui.Image_Selected:SetActive(isSelected)
    if self.selectedEffect then
      self.selectedEffect:SetActive(isSelected)
    end
  end, self.selectedFunc)
end

function SummonCareerSelectItem:_OnBindHardStar(binder)
  local starNum = self.cfg.Difficulty
  for i = 1, STARMAXNUM do
    binder:BindToVisible(self.ui["Image_Star_" .. i], function()
      return i <= starNum
    end)
  end
end

return SummonCareerSelectItem
