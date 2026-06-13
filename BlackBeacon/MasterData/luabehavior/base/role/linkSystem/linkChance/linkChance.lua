local linkChance = Util.create_class()

function linkChance._setUp(chance)
  local chance = chance
  chance.chanceBase = linkChance
  chance.linkMgr = ComnMgr.LinkMgr
  chance.isEnable = false
  chance.isQteEnable = false
end

function linkChance.isReady(chance, linkQte)
  return chance.isEnable and chance.isQteEnable
end

function linkChance.consumeQte(chance, linkQte)
  local mgr = chance.linkMgr
  mgr:setStage(nil, mgr.CHILD_STAGE.BURST)
  mgr:tryEffect(linkQte)
end

function linkChance.disable(chance)
  chance.isEnable = false
  chance.isQteEnable = false
  chance.linkMgr:disableQteUi()
end

function linkChance.enable(chance)
  chance.isEnable = true
  chance.isQteEnable = false
end

function linkChance.enableQte(chance)
  chance.isQteEnable = true
  local mgr = chance.linkMgr
  mgr:enableQteUi()
  mgr:updateQteUi()
end

function linkChance.hasLinkQte(chance)
  return chance.isQteEnable
end

return linkChance
