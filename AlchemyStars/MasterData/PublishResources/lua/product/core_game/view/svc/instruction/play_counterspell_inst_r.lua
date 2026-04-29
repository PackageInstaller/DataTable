require("base_ins_r")
_class("PlayCounterSpellInstruction", BaseInstruction)
PlayCounterSpellInstruction = PlayCounterSpellInstruction

function PlayCounterSpellInstruction:Constructor(paramList)
  self._monsterCG = paramList.monsterCG
  self._waitTime = tonumber(paramList.waitTime)
  self._offsetPos = Vector2.zero
  self._offsetScale = 1
end

function PlayCounterSpellInstruction:_InitCgData()
  self._offsetPos = Vector2.zero
  self._offsetScale = 1
  self._monsterCGMat = self._monsterCG .. ".mat"
  local cfg = Cfg.pet_cg_transform({
    ResName = self._monsterCG,
    UIName = "UIBossCounter"
  })
  if cfg then
    local v = cfg[1]
    if v then
      local scaleOri = 1
      if v.CGTransform then
        self._offsetPos.x = v.CGTransform[1]
        self._offsetPos.y = v.CGTransform[2]
        self._offsetScale = scaleOri * v.CGTransform[3]
      else
        self._offsetScale = scaleOri
      end
    end
  end
end

function PlayCounterSpellInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self:_InitCgData()
  GameGlobal.UIStateManager():ShowDialog("UIBossCounter", {
    monsterCGMat = self._monsterCGMat,
    offsetPos = self._offsetPos,
    offsetScale = self._offsetScale
  })
  YIELD(TT, self._waitTime)
  GameGlobal.UIStateManager():CloseDialog("UIBossCounter")
end
