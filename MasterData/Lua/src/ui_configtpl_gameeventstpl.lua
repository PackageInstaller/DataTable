local this = class("gameEventsTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getHelp(tpl)
  return tpl.help
end

function this:getStartShowTime(tpl)
  return tpl.startShowTime
end

function this:getType(tpl)
  return tpl.type
end

function this:getId(tpl)
  return tpl.id
end

function this:getShow(tpl)
  return tpl.show
end

function this:getUnlockShow(tpl)
  return tpl.unlockShow
end

function this:getLoopInterval(tpl)
  return tpl.loopInterval
end

function this:getSort(tpl)
  return tpl.sort
end

function this:getLoopTime(tpl)
  return tpl.loopTime
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getLockText(tpl)
  return tpl.lockText
end

function this:getEndTime(tpl)
  return tpl.endTime
end

function this:getTimeLimit(tpl)
  return tpl.timelimit
end

function this:getLoopType(tpl)
  return tpl.loopType
end

function this:getStartTime(tpl)
  return tpl.startTime
end

function this:getSystemId(tpl)
  return tpl.systemId
end

function this:getEndShowTime(tpl)
  return tpl.endShowTime
end

function this:getEndShowType(tpl)
  return tpl.endShowType
end

function this:getName(tpl)
  return tpl.name
end

function this:getParam(tpl)
  return tpl.param
end

function this:getCondition(tpl)
  return tpl.condition
end

function this:getRewardShow(tpl)
  return tpl.rewardShow or {}
end

function this:getBgPrefab(tpl)
  return tpl.prefeb or nil
end

function this:getGuideTaskId(tpl)
  return tpl.guideTaskId
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getAllData()
  return self.data
end

function this:getCommonJump(tpl)
  return tpl.commonJump
end

function this:getLockJump(tpl)
  return tpl.lockJump
end

function this:getPreShowCondition(tpl)
  return tpl.preShowCondition
end

function this:getCurrencyId(tpl)
  return tpl.currencyid
end

function this:getListBanner(tpl)
  return tpl.listBanner
end

function this:getTabBg(tpl)
  return tpl.tabBg
end

function this:getTypeIcon(tpl)
  return tpl.typeIcon
end

function this:getTypeHead(tpl)
  return tpl.tabImg
end

function this:getListColor(tpl)
  return tpl.listColor
end

function this:getEndTaskId(tpl)
  return tpl.endTaskId
end

function this:getFakeTime(tpl)
  return tpl.fakeTime
end

function this:getFackId()
  return 6001
end

function this:getPtCurrencyId(tpl)
  return tpl.ptCurrencyId
end

function this:getPtCurrencyMax(tpl)
  return tpl.ptCurrencyMax
end

function this:getPtShopId(tpl)
  return tpl.ptShopId
end

return this
