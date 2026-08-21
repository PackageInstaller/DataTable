_class("SMazeCard", Object)
SMazeCard = SMazeCard

function SMazeCard:Constructor(id)
  self._id = id
  self._cfg = Cfg.cfg_component_season_maze_hand[id]
  if not self._cfg then
    Log.fatal("SMazeCard cfg_component_season_maze_hand nil.", id)
  end
  self._actPoint = nil
  self._resValue = 0
end

function SMazeCard:ID()
  return self._id
end

function SMazeCard:ActPoint()
  return self._actPoint
end

function SMazeCard:ResValue()
  return self._awardAsset and self._awardAsset:Count() or 0
end

function SMazeCard:SetData(svrData, actPoint)
  if self._id ~= svrData.id then
    Log.exception("行动牌id不一致:", self._id, svrData.id)
  end
  self._actPoint = actPoint
  if svrData.effct then
    local effect
    local result, eft = SeasonMazeTool:GetInstance():TryMergeBeadEft(svrData.effct)
    if result then
      effect = eft
    else
      effect = svrData.effct[1]
    end
    if effect then
      self._awardAsset = SeasonMazeTool:GetInstance():Effect2Asset(effect, effect.value_min or 0)
    end
  end
end

function SMazeCard:AwardAsset()
  return self._awardAsset
end

function SMazeCard:PlayCard(TT)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonMazeCardSettle, self)
end

function SMazeCard:CfgActPoint()
  return self._cfg.Steps[1], self._cfg.Steps[2]
end

function SMazeCard:CopyedCard()
  return self._cfg.CopyLast and self._cfg.CopyLast == 1
end
