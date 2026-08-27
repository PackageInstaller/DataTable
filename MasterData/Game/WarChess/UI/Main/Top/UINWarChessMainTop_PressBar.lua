local base = UIBaseNode
local UINWarChessMainTop_PressBar = class("UINWarChessMainTop_PressBar", UIBaseNode)
local UINWarChessMainTop_PressBarItem = require("Game.WarChess.UI.Main.Top.UINWarChessMainTop_PressBarItem")
local CS_DOTween = CS.DG.Tweening.DOTween
local aniTime = 1
local STRESS_MAX_LENGTH = 10

function UINWarChessMainTop_PressBar:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._totalWith = self.ui.trans_Group.sizeDelta.x
  self.ui.obj_smallItem:SetActive(false)
  self.ui.obj_bigItem:SetActive(false)
  self._bigDic = {}
  self._bigRecycleList = {}
  self._smallDic = {}
  self._smallRecycleList = {}
  self._isInit = false
  self._lastLevel = nil
  self._lastPoint = nil
end

function UINWarChessMainTop_PressBar:BindPressResloader(resloader)
  self._resloader = resloader
  self._iconAtlas = AtlasUtil.GetSpirteAtlas(UIAtlasConsts.Atlas_WarChess, resloader)
end

function UINWarChessMainTop_PressBar:__RefreshPressBar(wcStressCfgs, stressLevel, stressPoint, isInit)
  local stressId = WarChessManager:GetWCLevelStressId()
  local stress_level_cfg = ConfigData.warchess_stress.stree_level[stressId]
  if stress_level_cfg == nil then
    error("stress_level_cfg not exist wcid:" .. tostring(stressId))
    return
  end
  for _, stressItem in pairs(self._bigDic) do
    self:__RecyclePressItem(stressItem)
  end
  for _, stressItem in pairs(self._smallDic) do
    self:__RecyclePressItem(stressItem)
  end
  local startLevel, endLevel, isNeedEmpty
  if stress_level_cfg.max_level > STRESS_MAX_LENGTH then
    local backNum = STRESS_MAX_LENGTH // 2
    startLevel = stressLevel - backNum + 1
    startLevel = math.clamp(startLevel, 0, stress_level_cfg.max_level)
    endLevel = startLevel + STRESS_MAX_LENGTH - 1
    endLevel = math.clamp(endLevel, 1, stress_level_cfg.max_level)
    if endLevel - startLevel < STRESS_MAX_LENGTH then
      startLevel = endLevel - STRESS_MAX_LENGTH + 1
    end
    isNeedEmpty = endLevel >= stress_level_cfg.max_level
  else
    startLevel = 0
    endLevel = stress_level_cfg.max_level
    isNeedEmpty = true
  end
  local unit
  if isNeedEmpty then
    unit = 1 / (endLevel - startLevel)
    self.ui.mask_bar.enabled = false
  else
    unit = 1 / (endLevel - startLevel)
    self.ui.mask_bar.enabled = true
  end
  for level = startLevel, endLevel do
    if 0 < level then
      local stressCfg = wcStressCfgs[level]
      local stressItem = self:__GetPressItem(stressCfg, level)
      local pos_x = (level - startLevel) * unit * self._totalWith
      stressItem.transform.anchoredPosition = Vector2.New(pos_x, 0)
      stressItem:RefreshPressBarItem(stressLevel >= level)
    end
  end
  local curLevelPoint = 0
  local nextLevelPoint = wcStressCfgs[stress_level_cfg.max_level].stresspoint
  if 0 < stressLevel then
    curLevelPoint = wcStressCfgs[stressLevel].stresspoint
  end
  if stressLevel + 1 < stress_level_cfg.max_level then
    nextLevelPoint = wcStressCfgs[stressLevel + 1].stresspoint
  end
  local curLevelRatio
  if nextLevelPoint == curLevelPoint then
    curLevelRatio = 0
  else
    curLevelRatio = (stressPoint - curLevelPoint) / (nextLevelPoint - curLevelPoint)
  end
  local showRatio = unit * (stressLevel - startLevel + curLevelRatio)
  if 0 < stressLevel and self._lastLevel ~= stressLevel then
    if self._bigDic[stressLevel] ~= nil then
      AudioManager:PlayAudioById(1240)
    else
      AudioManager:PlayAudioById(1239)
    end
  end
  self.ui.tex_Lv:SetIndex(0, tostring(stressLevel))
  local nextLevelCfg = wcStressCfgs[stressLevel + 1]
  if nextLevelCfg == nil then
    nextLevelCfg = wcStressCfgs[stressLevel]
  end
  self.ui.tex_Progress.text = tostring(stressPoint) .. "/" .. tostring(nextLevelCfg.stresspoint)
  if self._sequence ~= nil then
    self._sequence:Kill(true)
  end
  self._sequence = CS_DOTween.Sequence()
  for i = self._lastLevel + 1, stressLevel do
    local stressItem = self._bigDic[i] or self._smallDic[i]
    if stressItem ~= nil then
      do
        local time = (stressLevel - self._lastLevel) * aniTime
        self._sequence:InsertCallback(time, function()
          stressItem:PlayBarItemOver()
        end)
      end
    end
  end
  self._sequence:OnComplete(function()
    self._sequence = nil
  end)
  if isInit then
    self.ui.silder_Value.value = showRatio
    self.ui.trans_Progress.anchoredPosition = Vector2.New(self._totalWith * showRatio, 0)
  else
    if self._startLevel ~= startLevel then
      self.ui.silder_Value:DOKill()
      self.ui.trans_Progress:DOKill()
      local lastRelativeRation = self.ui.silder_Value.value - unit * (startLevel - self._startLevel)
      self.ui.silder_Value.value = lastRelativeRation
      self.ui.trans_Progress.anchoredPosition = Vector2.New(self._totalWith * lastRelativeRation, 0)
    end
    self.ui.silder_Value:DOValue(showRatio, aniTime)
    self.ui.trans_Progress:DOAnchorPosX(self._totalWith * showRatio, aniTime)
  end
  self._startLevel = startLevel
  self._endLevel = endLevel
  self._lastLevel = stressLevel
  self._lastPoint = stressPoint
end

function UINWarChessMainTop_PressBar:__GetPressItem(stressCfg, level)
  local stressItem
  local isBig = not string.IsNullOrEmpty(stressCfg.stressicon)
  if isBig then
    if #self._bigRecycleList > 0 then
      stressItem = table.remove(self._bigRecycleList, 1)
    else
      stressItem = UINWarChessMainTop_PressBarItem.New()
      local go = self.ui.obj_bigItem:Instantiate()
      go:SetActive(true)
      stressItem:Init(go)
    end
    local iconSprite = AtlasUtil.GetResldSprite(self._iconAtlas, stressCfg.stressicon)
    stressItem:WCInitPressItem(true, level, iconSprite)
    self._bigDic[level] = stressItem
  else
    if 0 < #self._smallRecycleList then
      stressItem = table.remove(self._smallRecycleList, 1)
    else
      stressItem = UINWarChessMainTop_PressBarItem.New()
      local go = self.ui.obj_smallItem:Instantiate()
      go:SetActive(true)
      stressItem:Init(go)
    end
    stressItem:WCInitPressItem(false, level, nil)
    self._smallDic[level] = stressItem
  end
  stressItem:Show()
  return stressItem
end

function UINWarChessMainTop_PressBar:__RecyclePressItem(stressItem)
  local isBig = stressItem:WCPressBarGetIsBigItem()
  local level = stressItem:WCPressBarGetLevel()
  if isBig then
    self._bigDic[level] = nil
    table.insert(self._bigRecycleList, stressItem)
  else
    self._smallDic[level] = nil
    table.insert(self._smallRecycleList, stressItem)
  end
  stressItem:Hide()
end

function UINWarChessMainTop_PressBar:RefreshWCPress(forceReinitial)
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local wcStressCfgs = wcCtrl.turnCtrl:GetWCStressCfgs()
  local stressLevel, stressPoint = wcCtrl.turnCtrl:GetWCStressLevelAndPoint()
  local isInit = false
  if not self._isInit or forceReinitial then
    self._lastLevel = stressLevel
    self._lastPoint = stressPoint
    self._isInit = true
    isInit = true
  end
  self:__RefreshPressBar(wcStressCfgs, stressLevel, stressPoint, isInit)
end

function UINWarChessMainTop_PressBar:OnDelete()
  self.ui.silder_Value:DOKill()
  self.ui.trans_Progress:DOKill()
  if self._sequence ~= nil then
    self._sequence:Kill()
  end
  base.OnDelete(self)
end

return UINWarChessMainTop_PressBar
