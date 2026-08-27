local UINMilestoneStar = class("UINMilestoneStar", UIBaseNode)
local base = UIBaseNode
local cs_Tweening = CS.DG.Tweening
local cs_Ease = cs_Tweening.Ease
local cs_DOTween = cs_Tweening.DOTween
local MilestoneEnum = require("Game.MileStone.MilestoneEnum")
local MilestoneUtil = require("Game.MileStone.MilestoneUtil")
local defaultStarCfg = {
  starAixLengt = 410,
  starEdgeAixLengt = 410 / math.sqrt(3),
  firstProcessLength = 115,
  processLength = 295
}

function UINMilestoneStar:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.starCfg = defaultStarCfg
  self.stageDic = {}
  self.processDic = {}
  self.onClickFunc = nil
  self.ui.even_sixPointStar:onClick("+", BindCallback(self, self.__OnClickStar))
end

function UINMilestoneStar:InitSixPointStar(onClickFunc, customStarCfg)
  self.onClickFunc = onClickFunc
  if customStarCfg ~= nil then
    self.starCfg = customStarCfg
  end
  self.ui.sixPointStarUnder:SetStarSize(self.starCfg.starAixLengt, self.starCfg.starEdgeAixLengt)
  self.ui.sixPointStar:SetStarSize(self.starCfg.starAixLengt, self.starCfg.starEdgeAixLengt)
end

function UINMilestoneStar:RefreshSPSMultPoint(stageDic, processDic, isHaveAime)
  for _, msModuleId in pairs(MilestoneEnum.eMileStoneModule) do
    self:RefreshSPSSinglePoint(msModuleId, stageDic[msModuleId], processDic[msModuleId], isHaveAime)
  end
  self.ui.sixPointStarUnder:RefreshStar()
  self.ui.sixPointStar:RefreshStar()
end

function UINMilestoneStar:RefreshSPSSinglePoint(msModuleId, stage, process, isHaveAime)
  local oldStage = self.stageDic[msModuleId]
  local oldProcess = self.processDic[msModuleId]
  if self.stageDic[msModuleId] ~= stage then
    self.stageDic[msModuleId] = stage
  end
  if self.processDic[msModuleId] ~= process then
    self.processDic[msModuleId] = process
  end
  if oldStage == stage and oldProcess == process then
    return
  end
  if stage <= 1 then
    self.ui.sixPointStarUnder:SetStarPoint(msModuleId - 1, 1, Color.clear)
  else
    self.ui.sixPointStarUnder:SetStarPoint(msModuleId - 1, 1, MilestoneUtil.GetSPSColor4Stage(stage - 1))
  end
  if not isHaveAime then
    self.ui.sixPointStar:SetStarPoint(msModuleId - 1, self:GetSPSFillRate(process), MilestoneUtil.GetSPSColor4Stage(stage))
  else
    if self.tween ~= nil then
      self.tween:Complete()
      self.tween = nil
    end
    if stage ~= oldStage then
      oldProcess = 0
    end
    local cp = oldProcess
    self.tween = cs_DOTween.To(function()
      return cp
    end, function(x)
      self.ui.sixPointStar:SetStarPoint(msModuleId - 1, self:GetSPSFillRate(x), MilestoneUtil.GetSPSColor4Stage(stage))
      self.ui.sixPointStar:RefreshStar()
    end, process, 4 * (process - oldProcess)):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject):OnComplete(function()
      self.tween = nil
    end)
  end
end

function UINMilestoneStar:GetSPSFillRate(process)
  return (self.starCfg.firstProcessLength + self.starCfg.processLength * process) / self.starCfg.starAixLengt
end

function UINMilestoneStar:__OnClickStar(go, eventData)
  local trans = self.ui.sixPointStar.transform
  local clickPosition = UIManager:Screen2UIPosition(eventData.position, trans, UIManager.UICamera)
  local toCenter = clickPosition
  if toCenter:SqrMagnitude() > self.starCfg.starAixLengt ^ 2 then
    return
  end
  local z = math.rad(self.transform.rotation.z + 90 - 30)
  local startVector = Vector2.New(math.cos(z), math.sin(z))
  local betweenDegree = Vector2.Angle(startVector, toCenter)
  local isClockwise = startVector.x * toCenter.y - startVector.y * toCenter.x < 0
  local msModuleId
  if isClockwise then
    msModuleId = MilestoneEnum.maxProcess - betweenDegree // 60
  else
    msModuleId = betweenDegree // 60 + 1
  end
  if self.onClickFunc ~= nil then
    self.onClickFunc(msModuleId)
  end
end

function UINMilestoneStar:OnDelete()
  if self.tween ~= nil then
    self.tween:Kill()
    self.tween = nil
  end
  base.OnDelete(self)
end

return UINMilestoneStar
