local UIRichIntro = class("UIRichIntro", UIBaseWindow)
local base = UIBaseWindow
local UIRichIntroList = require("Game.CommonUI.RichIntro.UIRichIntroList")
local cs_GameData_ins = CS.GameData.instance
local cs_Edge = CS.UnityEngine.RectTransform.Edge
local cs_FormulaUtility = CS.FormulaUtility

function UIRichIntro:OnInit()
  self.ui.obj_introList:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_back, self, self.onBackClick)
end

function UIRichIntro:ShowIntroBySkillData(parent, skillData, showHead, modifier, isOpenBack, showDesc, showPos, isAutoTagPos)
  if isOpenBack == nil then
    isOpenBack = true
  end
  self.ui.btn_back.gameObject:SetActive(isOpenBack)
  local uiIntroData = {}
  uiIntroData.showHead = showHead or false
  if showHead ~= false then
    uiIntroData.upColor = false
    uiIntroData.name = skillData:GetName()
    local skillLevel = skillData.level or 1
    local desc = ""
    if showDesc == nil then
      showDesc = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.skill)
    end
    desc = skillData:GetLevelDescribe(skillLevel, nil, showDesc)
    uiIntroData.desc = desc
    uiIntroData.skillLabeIdList = skillData:GetSkillLabeIdList()
    local cdTime = skillData:GetCurrentSkillCDTime()
    if cdTime ~= 0 then
      cdTime = GetPreciseDecimalStr(cdTime, 1)
    end
    uiIntroData.cdTime = cdTime
  end
  uiIntroData.introShowPos = showPos or 0
  uiIntroData.isAutoTagPos = isAutoTagPos or false
  self:SetRichIntroList(parent, uiIntroData, modifier)
end

function UIRichIntro:ShowIntroCustom(parent, name, desc, showHead, modifier)
  local uiIntroData = {}
  uiIntroData.upColor = false
  uiIntroData.showHead = showHead or false
  uiIntroData.name = name
  uiIntroData.desc = desc
  uiIntroData.skillLabeIdList = nil
  uiIntroData.introShowPos = 0
  self:SetRichIntroList(parent, uiIntroData, modifier)
end

function UIRichIntro:ShowIntroLabelList(parent, skillLabeIdList)
  local uiIntroData = {skillLabeIdList = skillLabeIdList}
  self:SetRichIntroList(parent, uiIntroData)
end

function UIRichIntro:SetRichIntroList(parent, uiIntroData, modifier)
  self._parent = parent
  if self.introList == nil or IsNull(self.introList.gameObject) then
    self.introList = UIRichIntroList.New()
    local go = self.ui.obj_introList:Instantiate(parent)
    self.introList:Init(go)
  end
  self.introList.transform:SetParent(parent)
  self.introList:Show()
  self.introList:SetModifier(modifier)
  self.introList:RefreshIntroListUI(uiIntroData)
  self.transform:SetAsLastSibling()
end

function UIRichIntro:SetIntroListPosition(widthEdge, heightEdge)
  if self.introList == nil then
    return
  end
  local introTran = self.introList.transform
  local pivotX = 0.5
  if widthEdge ~= nil then
    if widthEdge == cs_Edge.Left then
      pivotX = 0
    elseif widthEdge == cs_Edge.Bottom then
      pivotX = 0
    elseif widthEdge == cs_Edge.Right then
      pivotX = 1
    elseif widthEdge == cs_Edge.Top then
      pivotX = 1
    end
    local width = introTran.rect.width
    introTran:SetInsetAndSizeFromParentEdge(widthEdge, 0, width)
  end
  local pivotY = 0.5
  if heightEdge ~= nil then
    if heightEdge == cs_Edge.Left then
      pivotY = 0
    elseif heightEdge == cs_Edge.Bottom then
      pivotY = 0
    elseif heightEdge == cs_Edge.Right then
      pivotY = 1
    elseif heightEdge == cs_Edge.Top then
      pivotY = 1
    end
    local height = introTran.rect.height
    introTran:SetInsetAndSizeFromParentEdge(heightEdge, 0, height)
  end
  local newPivot = Vector2.New(pivotX, pivotY)
  introTran.pivot = newPivot
  introTran.anchoredPosition = Vector2.zero
end

function UIRichIntro:SetIntroListModifier(modifier, is3D)
  self.introList:SetModifier(modifier, is3D)
end

function UIRichIntro:onBackClick()
  self:Hide()
end

function UIRichIntro:OnHide()
  if self.introList ~= nil and not IsNull(self.introList.gameObject) then
    self.introList:Hide()
  end
end

function UIRichIntro:OnDelete()
  if self.introList ~= nil and not IsNull(self.introList.gameObject) then
    self.introList:Delete()
    self.introList = nil
  end
  base.OnDelete(self)
end

return UIRichIntro
