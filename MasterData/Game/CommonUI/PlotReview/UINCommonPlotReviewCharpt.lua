local UINCommonPlotReviewCharpt = class("UINCommonPlotReviewCharpt", UIBaseNode)
local base = UIBaseNode
local UINCommonPlotReviewAvg = require("Game.CommonUI.PlotReview.UINCommonPlotReviewAvg")
local vector3One_ReverseY = Vector3.New(1, -1, 1)

function UINCommonPlotReviewCharpt:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_DropDown, self, self.OnClickSwitch)
  self._avgPool = UIItemPool.New(UINCommonPlotReviewAvg, self.ui.plotItem)
  self.ui.plotItem:SetActive(false)
  self.__RefreshBlueDot = BindCallback(self, self.__RefreshBlueDot)
end

function UINCommonPlotReviewCharpt:InitPlotReviewCharpt(AvgGroupData)
  self.AvgGroupData = AvgGroupData
  local groupENName, groupName, groupDes = AvgGroupData:GetAvgGroupName()
  self.ui.tex_EN.text = groupENName
  self.ui.tex_Type.text = groupName
  self.ui.tex_Desc.text = groupDes
  self._avgPool:HideAll()
  for _, avgId in ipairs(AvgGroupData:GetAvgGroupAvgIdList()) do
    local item = self._avgPool:GetOne()
    item:InitHeroPlotReviewAvg(avgId, AvgGroupData, self.__RefreshBlueDot)
  end
  self.ui.dropDown:SetActive(false)
  self:__RefreshBlueDot()
  self.ui.img_Tri.transform.localScale = Vector3.one
end

function UINCommonPlotReviewCharpt:OnClickSwitch()
  local active = not self.ui.dropDown.activeSelf
  self.ui.dropDown:SetActive(active)
  if active then
    self.ui.img_Tri.transform.localScale = vector3One_ReverseY
  else
    self.ui.img_Tri.transform.localScale = Vector3.one
  end
  if active and self.ui.blueDot.activeSelf then
    local unfoldCallback = self.AvgGroupData:GetAvgGroupDataUnfoldCallback()
    if unfoldCallback ~= nil then
      unfoldCallback()
    end
    self:__RefreshBlueDot()
  end
end

function UINCommonPlotReviewCharpt:SetAvgJustClientPlay()
  for i, v in ipairs(self._avgPool.listItem) do
    v:SetAvgJustClientPlay()
  end
end

function UINCommonPlotReviewCharpt:__RefreshBlueDot()
  if IsNull(self.ui.blueDot) then
    return
  end
  self.ui.blueDot:SetActive(self.AvgGroupData:IsAvgGroupDataCouldBlueDot())
end

return UINCommonPlotReviewCharpt
