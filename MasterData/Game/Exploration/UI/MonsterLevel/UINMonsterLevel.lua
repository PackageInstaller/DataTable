local UINMonsterLevel = class("UINMonsterLevel", UIBaseNode)
local base = UIBaseNode
local UINMonsterLevelPreview = require("Game.Exploration.UI.MonsterLevel.UINMonsterLevelPreview")

function UINMonsterLevel:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_MstPreview, self, self.OpenMonsterLevelPreview)
  self.__everygridsize = self.ui.img_Count.sizeDelta.x
  local maxSizeDelta = self.ui.img_TotalCount.sizeDelta
  self.__gridHeight = maxSizeDelta.y
  self.__maxExpWidth = maxSizeDelta.x
  if not IsNull(self.ui.logicPreviewNode) then
    self.UINMonsterLevelDataPreview = UINMonsterLevelPreview.New()
    self.UINMonsterLevelDataPreview:Init(self.ui.logicPreviewNode)
    self.UINMonsterLevelDataPreview:Hide()
  end
end

function UINMonsterLevel:InitMonsterLevelUI(dynPlayer, justOpen)
  self.isJustOpen = justOpen
  if dynPlayer.epCommonData == nil or dynPlayer.epCommonData.monster == nil then
    return
  end
  local monsterData = dynPlayer.epCommonData.monster
  self:Show()
  self:UpdateMonsterLevelByData(monsterData)
  if self.__UpdateMonsterLevelByData == nil then
    self.__UpdateMonsterLevelByData = BindCallback(self, self.UpdateMonsterLevelByData)
    MsgCenter:AddListener(eMsgEventId.UpdateEpMonsterLevel, self.__UpdateMonsterLevelByData)
  end
end

function UINMonsterLevel:UpdateMonsterLevelByData(monsterLevelData)
  if monsterLevelData ~= nil then
    self:UpdateMonsterLevelUI(monsterLevelData.lv, monsterLevelData.exp)
  end
end

function UINMonsterLevel:UpdateMonsterLevelUI(level, exp)
  local monsterLevelCfgs = ExplorationManager:GetMonsterLevelCfgs(level)
  if monsterLevelCfgs == nil then
    error("monsterLevelCfgs is nil")
    return
  end
  local curLevelCfg = monsterLevelCfgs[level]
  if curLevelCfg == nil then
    return
  end
  local exp = exp - curLevelCfg.exp
  if self.__lastLevel ~= level then
    self.__lastLevel = level
    self:__UpdateMonsterLevel(level, monsterLevelCfgs, curLevelCfg)
  end
  self.ui.img_Count.sizeDelta = Vector2.New(self.__everygridsize * exp, self.__gridHeight)
end

function UINMonsterLevel:__UpdateMonsterLevel(level, monsterLevelCfgs, curLevelCfg)
  local isFullLevel = level >= monsterLevelCfgs.maxLevel
  self.ui.tex_Max.gameObject:SetActive(isFullLevel)
  self.ui.levelNode:SetActive(not isFullLevel)
  local sign = ""
  if curLevelCfg.hp_amplify > 0 then
    sign = "+"
  end
  self.ui.tex_Num1.text = sign .. GetPreciseDecimalStr(curLevelCfg.hp_amplify / 10, 1) .. "%"
  sign = ""
  if 0 < curLevelCfg.pow_amplify then
    sign = "+"
  end
  self.ui.tex_Num2.text = sign .. GetPreciseDecimalStr(curLevelCfg.pow_amplify / 10, 1) .. "%"
  self.ui.tex_MonsterLv.text = tostring(level)
  if not isFullLevel then
    local levelexp = curLevelCfg.levelexp
    if levelexp == 0 then
      levelexp = 1
    end
    local scale = self.__maxExpWidth / (self.__everygridsize * levelexp)
    self.ui.img_TotalCount.localScale = Vector3.New(scale, 1, 1)
    self.ui.img_TotalCount.sizeDelta = Vector2.New(self.__everygridsize * curLevelCfg.levelexp, self.__gridHeight)
  end
end

function UINMonsterLevel:IsMonsterLevelPreviewOpen()
  if self.UINMonsterLevelDataPreview == nil then
    return false
  end
  return self.UINMonsterLevelDataPreview.active
end

function UINMonsterLevel:OpenMonsterLevelPreview()
  if self.UINMonsterLevelDataPreview ~= nil then
    if not self.isJustOpen and self._onLevelPreviewClose == nil then
      self._onLevelPreviewClose = BindCallback(self, self.SetDungeonStateInfoBuffListActive, true)
    end
    self.UINMonsterLevelDataPreview:Show()
    self.UINMonsterLevelDataPreview:InitMonsterLevelPreview(self.__lastLevel, self._onLevelPreviewClose, self.isJustOpen)
    if not self.isJustOpen then
      self:SetDungeonStateInfoBuffListActive(false)
    end
  end
end

function UINMonsterLevel:SetDungeonStateInfoBuffListActive(Active)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, Active)
  GuideManager:TryTriggerGuide(eGuideCondition.InEpRoomOutside)
end

function UINMonsterLevel:OnDelete()
  if self.__UpdateMonsterLevelByData ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.UpdateEpMonsterLevel, self.__UpdateMonsterLevelByData)
  end
  if self.UINMonsterLevelDataPreview ~= nil then
    self.UINMonsterLevelDataPreview:Delete()
    self.UINMonsterLevelDataPreview = nil
  end
  base.OnDelete(self)
end

return UINMonsterLevel
