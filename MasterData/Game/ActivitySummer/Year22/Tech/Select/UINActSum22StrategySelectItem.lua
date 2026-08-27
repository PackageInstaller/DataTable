local UINActSum22StrategySelectItem = class("UINActSum22StrategySelectItem", UIBaseNode)
local base = UIBaseNode
local cs_WaitForSeconds = CS.UnityEngine.WaitForSeconds

function UINActSum22StrategySelectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Get, self, self._OnClickSelect)
  self.ui.fxRoot:SetParent(self.transform.parent.parent)
end

function UINActSum22StrategySelectItem:InitTechSelectItem(idx, techData, resloader, callback)
  self._callback = callback
  self._techData = techData
  self.ui.img_Icon.enabled = false
  resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorBuilding"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, techData:GetWATechIcon())
    self.ui.img_Icon.enabled = true
  end)
  self.ui.tex_NO:SetIndex(0, tostring(idx))
  self.ui.img_Frame:SetIndex(techData:GetActTechUIFrameId())
  local curLv = techData:GetCurLevel()
  local nextLevel = curLv + 1
  local loopLevel = techData:IsActTechLevelLoop()
  if loopLevel then
    self.ui.tex_Lvl.text.text = tostring(nextLevel)
  else
    local maxLv = techData:GetMaxLevel()
    if nextLevel > maxLv then
      error(string.format("nextLevel(%s) > maxLv(%s),techId:%s", nextLevel, maxLv, techData:GetTechId()))
      return
    end
    self.ui.tex_Lvl:SetIndex(0, tostring(nextLevel), tostring(maxLv))
  end
  local costDic = techData:GetLevelCost(nextLevel)
  for costId, costNum in pairs(costDic) do
    self.ui.img_Coin.sprite = CRH:GetSpriteByItemId(costId, true)
    self.ui.tex_Cost.text = tostring(costNum)
    break
  end
  self.ui.tex_TechName.text = techData:GetAWTechName()
  local longDes, shortDes, valueDes = techData:GetTechDescriptionFirst(nextLevel, eLogicDesType.Warchess)
  self.ui.tex_Des.text = techData:GetTechDescription(nextLevel, eLogicDesType.Warchess)
  self.ui.tex_ValueName.text = shortDes
  local isNew = curLv == 0
  local showBuffChange = not isNew
  local logicArray, para1Array, para2Array, para3Array = techData:GetTechLogic(nextLevel)
  if logicArray[1] == eLogicType.Activity_UnlockBuff then
    showBuffChange = false
  end
  self.ui.buffChangeBg:SetActive(showBuffChange)
  if curLv == 0 then
  else
    local _, _, curValueDes = techData:GetTechDescriptionFirst(curLv, eLogicDesType.Warchess)
    self.ui.tex_Change:SetIndex(0, curValueDes, valueDes)
  end
  local branchCfg = techData:GetActTechBranchCfg()
  self.ui.tex_Branch.text = LanguageUtil.GetLocaleText(branchCfg.branch_name)
  self.ui.tagBg:SetActive(isNew)
  self.ui.img_Get:SetIndex(isNew and 0 or 1)
  self.ui.tex_Get:SetIndex(isNew and 0 or 1)
  self.ui.img_Title.color = isNew and self.ui.color_title_new or self.ui.color_title_level
  self.ui.img_Bottom.color = isNew and self.ui.color_bottom_new or self.ui.color_bottom_level
  self.ui.img_StrategyNameBg.color = isNew and self.ui.color_namebg_new or self.ui.color_namebg_level
end

function UINActSum22StrategySelectItem:PlaySelectAnimActSum22TechSelectItem(idx, techData, resloader, callback, isSelected)
  self._posY = self._posY or self.transform.anchoredPosition.y
  TimerManager:StopTimer(self._selectTimer)
  local animState = self.ui.anim:get_Item("UI_ActSum22StrategySelectItem_after")
  animState.time = animState.length
  self._IsInAnimation = true
  if isSelected then
    self.ui.dtAnim:DORestartById("outro")
  end
  self._selectTimer = TimerManager:StartTimer(0.3, function()
    if isSelected then
      self.transform.anchoredPosition = Vector2.Temp(self.transform.anchoredPosition.x, self._posY)
      self.transform:DOAnchorPosY(self._posY - 200, 0.3):From():SetLink(self.gameObject):SetDelay(0.1)
      self.ui.canvasGroup:DOFade(1, 0.15):SetLink(self.gameObject):SetDelay(0.1)
      self:InitTechSelectItem(idx, techData, resloader, callback)
    end
    self:PlayRefreshAnimActSum22TechSelectItem(idx, techData, resloader, callback, isSelected)
  end, self, true)
end

function UINActSum22StrategySelectItem:PlayRefreshAnimActSum22TechSelectItem(idx, techData, resloader, callback, fromSelectAnim)
  self.ui.fx_LvUp:SetActive(false)
  self.ui.fx_New:SetActive(false)
  self.ui.fx_SpecailLvup:SetActive(false)
  self.ui.fx_SpecailNew:SetActive(false)
  TimerManager:StopTimer(self._refreshTimer)
  local isNew = techData:GetCurLevel() == 0
  local isSpecial = techData:IsActTechSpecial()
  if isNew then
    if isSpecial then
      self.ui.fx_SpecailNew:SetActive(true)
    else
      self.ui.fx_New:SetActive(true)
    end
  elseif isSpecial then
    self.ui.fx_SpecailLvup:SetActive(true)
  else
    self.ui.fx_LvUp:SetActive(true)
  end
  if not fromSelectAnim then
    self.ui.anim:Play("UI_ActSum22StrategySelectItem_before")
  end
  self._IsInAnimation = true
  self._refreshTimer = TimerManager:StartTimer(0.5, function()
    if not fromSelectAnim then
      self.ui.anim:Play("UI_ActSum22StrategySelectItem_after")
      self:InitTechSelectItem(idx, techData, resloader, callback)
    end
    self._IsInAnimation = false
  end, self, true)
end

function UINActSum22StrategySelectItem:_OnClickSelect()
  if self._IsInAnimation then
    return
  end
  if self._callback then
    self._callback(self._techData, self)
  end
end

function UINActSum22StrategySelectItem:OnDelete()
  TimerManager:StopTimer(self._refreshTimer)
  TimerManager:StopTimer(self._selectTimer)
end

return UINActSum22StrategySelectItem
