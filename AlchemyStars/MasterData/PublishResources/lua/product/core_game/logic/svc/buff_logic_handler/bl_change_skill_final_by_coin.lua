_class("BuffLogicChangeSkillFinalByCoin", BuffLogicBase)
BuffLogicChangeSkillFinalByCoin = BuffLogicChangeSkillFinalByCoin

function BuffLogicChangeSkillFinalByCoin:Constructor(buffInstance, logicParam)
  self._buffInstance._effectList = logicParam.effectList
  self._a = logicParam.a
  self._n = logicParam.n
end

function BuffLogicChangeSkillFinalByCoin:DoLogic(notify)
  if self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze then
    local seasonMazeSvc = self._world:GetService("SeasonMaze")
    for _, paramType in ipairs(self._buffInstance._effectList) do
      local goldCoin = seasonMazeSvc:GetGoldCoin()
      local changeValue = self._a * goldCoin ^ self._n
      Log.fatal("ChangeSkillFinalByCoin Value:", changeValue, " a=", self._a, " gold=", goldCoin, " n=", self._n)
      self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, changeValue)
    end
  end
end

_class("BuffLogicRemoveChangeSkillFinalByCoin", BuffLogicBase)
BuffLogicRemoveChangeSkillFinalByCoin = BuffLogicRemoveChangeSkillFinalByCoin

function BuffLogicRemoveChangeSkillFinalByCoin:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveChangeSkillFinalByCoin:DoLogic()
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
end
