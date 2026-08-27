local UINActSum22MapItem = class("UINActSum22MapItem", UIBaseNode)
local base = UIBaseNode

function UINActSum22MapItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.baseItem, self, self.OnClickSelected)
  self._starDefaultWidth = self.ui.challenge.rect.width
end

function UINActSum22MapItem:InitSum22MapItem(sectorLevelData, index, callback)
  self._sectorLevelData = sectorLevelData
  self._callback = callback
  if self._sectorLevelData:GetIsBattle() then
    self:__RefreshSectorStage()
  else
    self:__RefreshSectorAvg()
  end
  self:RefreshSum22MapItemCompleteState()
  self:SetSum22MapItemSelectState(false)
end

function UINActSum22MapItem:__RefreshSectorStage()
  local isSideStage = self._sectorLevelData:GetSectroIILevelIsSide()
  local isHardStage = self._sectorLevelData:GetSectroIILevelIsHard()
  if isSideStage then
    self.ui.img_Buttom:SetIndex(3)
    self.ui.img_Icon:SetIndex(3)
    self.ui.img_Dis:SetIndex(3)
  elseif isHardStage then
    self.ui.img_Buttom:SetIndex(2)
    self.ui.img_Icon:SetIndex(2)
    self.ui.img_Dis:SetIndex(2)
  else
    self.ui.img_Buttom:SetIndex(0)
    self.ui.img_Icon:SetIndex(0)
    self.ui.img_Dis:SetIndex(0)
  end
  for i, v in ipairs(self.ui.array_point_imgs) do
    v:SetIndex(0)
  end
  local stageCfg = self._sectorLevelData:GetLevelEpStageCfg()
  if isSideStage then
    self.ui.tex_Point:SetIndex(2, tostring(stageCfg.num))
  else
    self.ui.tex_Point:SetIndex(0, tostring(stageCfg.num))
  end
  local hasChallengeTask = self._sectorLevelData:HasSectorIILevelChallengeTask()
  if not hasChallengeTask then
    self.ui.challengeHolder:SetActive(false)
  else
    self.ui.challengeHolder:SetActive(true)
    local total, count = self._sectorLevelData:GetSectorIILevelChallengeTaskNum()
    local vec = self.ui.challenge.sizeDelta
    vec.x = self._starDefaultWidth * total
    self.ui.challenge.sizeDelta = vec
    vec = self.ui.img_ChallengeCur.sizeDelta
    vec.x = self._starDefaultWidth * count
    self.ui.img_ChallengeCur.sizeDelta = vec
  end
end

function UINActSum22MapItem:__RefreshSectorAvg()
  self.ui.img_Buttom:SetIndex(1)
  self.ui.img_Icon:SetIndex(1)
  self.ui.img_Dis:SetIndex(1)
  for i, v in ipairs(self.ui.array_point_imgs) do
    v:SetIndex(1)
  end
  local avgCfg = self._sectorLevelData:GetLevelAvgCfg()
  self.ui.tex_Point:SetIndex(1, tostring(avgCfg.number))
  self.ui.challengeHolder:SetActive(false)
end

function UINActSum22MapItem:SetSum22MapItemSelectState(flag)
  self.ui.ani_LatestPoint.gameObject:SetActive(flag)
  if flag then
    self.ui.ani_LatestPoint:Play()
  end
end

function UINActSum22MapItem:RefreshSum22MapItemCompleteState()
  self.ui.img_Complete:SetActive(self._sectorLevelData:GetIsLevelClaer())
  self.ui.go_Next:SetActive(not self._sectorLevelData:GetIsLevelClaer())
  if self._sectorLevelData:GetIsBattle() then
    self.ui.blueDot:SetActive(false)
  else
    self.ui.blueDot:SetActive(not self._sectorLevelData:GetIsLevelClaer())
  end
end

function UINActSum22MapItem:OnClickSelected()
  if self._callback ~= nil then
    self._callback(self._sectorLevelData, self)
  end
end

function UINActSum22MapItem:GetSum22SectorLevelData()
  return self._sectorLevelData
end

return UINActSum22MapItem
