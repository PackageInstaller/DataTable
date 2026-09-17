local this = class("conditionNode_50002", require(L_R.condition .. "conditionNode"))
local _kiboDuelChapterTpl = L_GameTpl:getKiBoDuelChapterTpl()
local _kiboDuelGroupTpl = L_GameTpl:getKiBoDuelGroupTpl()
local _modeNameEnums = {
  [1] = "ui_pagePetDuelChapterPass_02",
  [2] = "ui_pagePetDuelChapterPass_03"
}

function this.checkFunc(condition)
  return L_PetDuelStore:getIsSuccess(condition[2])
end

function this.descFunc(key, codData)
  local kiBoDuelGroupCfg = _kiboDuelGroupTpl:getTplById(codData[2])
  local chapterId = _kiboDuelGroupTpl:getChapterId(kiBoDuelGroupCfg)
  local kiBoDuelChapterCfg = _kiboDuelChapterTpl:getTplById(chapterId)
  return L_Lang:get(key, {
    mode = L_WordsTpl:getValue(_modeNameEnums[_kiboDuelChapterTpl:getModeId(kiBoDuelChapterCfg)]),
    index = _kiboDuelChapterTpl:getIndex(kiBoDuelChapterCfg),
    name = _kiboDuelGroupTpl:getLevelName(kiBoDuelGroupCfg)
  })
end

return this
