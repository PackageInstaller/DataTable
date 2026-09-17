local this = class("pageStaminaReward", G_UIPageBase)
local _staminaChestTpl = L_GameTpl:getStaminaChestDropTpl()

function this.bind()
  return {
    go_up_left = false,
    txt_leftTimes = nil,
    go_leftTimes = false,
    txt_title = nil,
    list_icon = L_Const.ModuleInfo.CellIconBag,
    go_up_btn = false,
    txt_upLeftTimes = nil,
    module_buttonReward = L_Const.ModuleInfo.ButtonSingle,
    module_currency = L_Const.ModuleInfo.Currency
  }
end

function this.methods()
  return {
    onClickClose = function(self)
      L_UI:close(self.pageName)
    end,
    onClickCancel = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:check(options, callback)
  local tpl = _staminaChestTpl:getTplById(options.staminaChestId)
  local lastTime = _staminaChestTpl:getTime(tpl)
  local serverData = AzurWorld.StaminaChestMgr:GetStaminaChestData(options.staminaChestId)
  if L_TimeUtil.getServerTime() >= serverData.finishTime + lastTime then
    L_FlyMsgManager:showNormalMsgByKey("ui_pageStaminaReward_02")
    callback(false)
    return
  end
  callback(true)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._staminaChestId = options.staminaChestId
  self._callback = options.callback
  self:refreshView()
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(L_SystemConst.enum.mainMenu)
  self.modules.module_currency:refreshRes(tpl_sys)
end

function this:refreshView()
  local tpl_chest = _staminaChestTpl:getTplById(self._staminaChestId)
  local leftRewardTime, isUp = L_StaminaChestManager:getStaminaRewardTimes(self._staminaChestId)
  self.bind.go_up_btn = isUp
  self.bind.go_up_left = isUp
  if isUp then
    self.bind.txt_upLeftTimes = L_WordsTpl:getValue("ui_pageStaminaReward_01", {
      [0] = leftRewardTime
    })
    self.bind.go_leftTimes = true
    self.bind.txt_leftTimes = tostring(leftRewardTime)
  else
    local refreshType, canRewardTimes = table.unpack(_staminaChestTpl:getRewardChance(tpl_chest))
    local isInfinite = refreshType == L_Const.StaminaBoxCountType.SBCT_INFINITE
    self.bind.go_leftTimes = not isInfinite
    if not isInfinite then
      self.bind.txt_leftTimes = tostring(leftRewardTime)
    end
  end
  local reward = L_DataUtil.parseRangeRewardConfig(isUp and _staminaChestTpl:getRewardDisplayUp(tpl_chest) or _staminaChestTpl:getRewardDisplay(tpl_chest))
  self.bind.list_icon:clear()
  self.bind.list_icon:insert_array(reward)
  local currencyConfigData = L_ItemTplManager:getCurrencyItem(L_Const.currencyType.stamina)
  local needCost = L_DataUtil.parseRewardConfig(_staminaChestTpl:getNeed(tpl_chest))[1]
  self.bind.txt_title = L_WordsTpl:getValue("ui_pageStaminaReward_03", {
    [0] = currencyConfigData.icon,
    [1] = needCost.itemNum
  })
  self.modules.module_buttonReward:setData(L_WordsTpl:getValue("ui_cellNoviceTaskItem_06"), handler(self, self.checkGetReward), {
    itemType = needCost.itemType,
    itemId = needCost.itemId,
    txtNum = needCost.itemNum
  })
end

function this:checkGetReward()
  local tpl = _staminaChestTpl:getTplById(self._staminaChestId)
  local lastTime = _staminaChestTpl:getTime(tpl)
  local serverData = AzurWorld.StaminaChestMgr:GetStaminaChestData(self._staminaChestId)
  if L_TimeUtil.getServerTime() >= serverData.finishTime + lastTime then
    L_FlyMsgManager:showNormalMsgByKey("ui_pageStaminaReward_02")
    L_UI:close(self.pageName)
    return
  end
  local needCost = L_DataUtil.parseRewardConfig(_staminaChestTpl:getNeed(tpl))[1]
  if L_ItemTplManager:getItemNum(needCost.itemType, needCost.itemId) < needCost.itemNum then
    L_FlyMsgManager:showNormalMsg(L_GameUtil.getStrByKey("notice_dungeon_lackenergy"))
    return
  end
  L_StaminaChestStore:req_CSProtoStaminaBoxGet(self._staminaChestId, 1, function(msg, errCode)
    if errCode == L_Const.errorCode.ErrCodeSucc then
      local clientSortRwdList = _staminaChestTpl:getRewardDisplay(tpl)
      local rewards = L_DataUtil.parseRewardConfig(msg.rewards, true, true, clientSortRwdList)
      L_UI:close(self.pageName, nil, function()
        local rewardData = require("ui.manager.reward.rewardData").new()
        rewardData.rewardShowType = L_Const.rewardShowType.full
        rewardData:constructList(rewards)
        L_RewardManager:ShowReward(rewardData, nil, nil, msg.src)
        if self._callback then
          self._callback()
        end
      end)
    end
  end)
end

return this
