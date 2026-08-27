local UINCarnival22TechBranchDetail = class("UINCarnival22TechBranchDetail", UIBaseNode)
local base = UIBaseNode
local UINCarnival22TechBranchDetailItem = require("Game.ActivityCarnival.UI.CarnivalTech.UINCarnival22TechBranchDetailItem")
local ActivityCarnivalEnum = require("Game.ActivityCarnival.ActivityCarnivalEnum")

function UINCarnival22TechBranchDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_BG, self, self.Hide)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.Hide)
  UIUtil.AddButtonListener(self.ui.btn_Reset, self, self.OnClickReset)
  self._itemPool = UIItemPool.New(UINCarnival22TechBranchDetailItem, self.ui.item)
  self.ui.item:SetActive(false)
  self._colorGray = self.ui.img_resetBottom.color
end

function UINCarnival22TechBranchDetail:InitBranchDetail(carnivalData, branchId, resetFunc)
  self._carnivalData = carnivalData
  self._branchId = branchId
  self._resetFunc = resetFunc
  local techDic = self._carnivalData:GetCarnivalTech()[self._branchId]
  self._itemPool:HideAll()
  local techList = {}
  for _, techData in pairs(techDic) do
    if techData:IsActTechAutoUnlock() then
      table.insert(techList, techData)
    end
  end
  table.sort(techList, function(a, b)
    return a:GetTechId() < b:GetTechId()
  end)
  for _, techData in ipairs(techList) do
    local item = self._itemPool:GetOne()
    item:InitBranchEft(techData)
  end
  local techType = self._carnivalData:GetCarnivalTechType()
  self.branchCfg = ConfigData.activity_tech_branch[techType][branchId]
  self.ui.tex_TitleCN.text = LanguageUtil.GetLocaleText(self.branchCfg.branch_name)
  self.ui.tex_TitleEN.text = self.branchCfg.branch_name_en
  self.ui.tex_cost.text = tostring(self.branchCfg.revertCostNums[1])
  self.ui.icon_cost.sprite = CRH:GetSpriteByItemId(self.branchCfg.revertCostIds[1], true)
  self:__RefreshLevelState()
  self:__RefreshCost()
  self:__RefreshReddot()
end

function UINCarnival22TechBranchDetail:__RefreshCost()
  for i, itemId in ipairs(self.branchCfg.revertCostIds) do
    if PlayerDataCenter:GetItemCount(itemId) < self.branchCfg.revertCostNums[i] then
      self.ui.tex_cost.color = Color.red
      self.ui.img_resetBottom.color = self.ui.color_gray
      return
    end
  end
  self.ui.tex_cost.color = Color.white
  self.ui.img_resetBottom.color = self._colorGray
end

function UINCarnival22TechBranchDetail:RefreshBranchDetail()
  for _, techItem in ipairs(self._itemPool.listItem) do
    techItem:RefreshBranchEft()
  end
  self:__RefreshLevelState()
  self:__RefreshCost()
  self:__RefreshReddot()
end

function UINCarnival22TechBranchDetail:__RefreshLevelState()
  local techDic = self._carnivalData:GetCarnivalTech()[self._branchId]
  local curLevel = 0
  local totalLevel = 0
  for _, techData in pairs(techDic) do
    if not techData:IsActTechAutoUnlock() then
      curLevel = curLevel + techData:GetCurLevel()
      totalLevel = totalLevel + techData:GetMaxLevel()
    end
  end
  self.ui.tex_Level:SetIndex(0, tostring(curLevel), tostring(totalLevel))
  self._curLevel = curLevel
end

function UINCarnival22TechBranchDetail:__RefreshReddot()
  local reddot = self._carnivalData:GetActivityReddot()
  if reddot ~= nil then
    reddot = reddot:GetChild(ActivityCarnivalEnum.eActivityCarnivalReddot.AutoTech)
    if reddot ~= nil then
      reddot = reddot:GetChild(self._branchId)
    end
  end
  if reddot == nil then
    for i, v in ipairs(self._itemPool.listItem) do
      v:RefreshBranchDetailItemReddot(false)
    end
    return
  end
  for i, v in ipairs(self._itemPool.listItem) do
    local childReddot = reddot:GetChild(v:GetBranchDetailItemId())
    v:RefreshBranchDetailItemReddot(childReddot ~= nil and childReddot:GetRedDotCount() > 0)
  end
end

function UINCarnival22TechBranchDetail:OnClickReset()
  if self._curLevel == 0 then
    return
  end
  if self._resetFunc ~= nil then
    self._resetFunc(self._branchId)
  end
end

function UINCarnival22TechBranchDetail:OnHide()
  local reddot = self._carnivalData:GetActivityReddot()
  if reddot ~= nil then
    reddot = reddot:GetChild(ActivityCarnivalEnum.eActivityCarnivalReddot.AutoTech)
    if reddot ~= nil then
      reddot:RemoveChild(self._branchId)
    end
  end
  base.OnHide(self)
end

return UINCarnival22TechBranchDetail
