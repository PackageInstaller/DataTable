local this = class("cellGameActivityItem", G_UIModuleBase)
local _dateFormat = "!%m/%d"

function this.bind()
  return {
    act_name = "",
    act_name_selected = "",
    img_type = "",
    img_choose_head = "",
    img_choose_bg = "",
    active_placeholder = false,
    go_normal_completed = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      local singleEventRedDot = false
      local gameEvent = L_GameEventStore:getGameEventData(self.bind.id):getGameEvent()
      if gameEvent ~= nil then
        singleEventRedDot = gameEvent:getRedState()
      end
      if not singleEventRedDot and gameEvent then
        singleEventRedDot = gameEvent:getPtShopRedState()
      end
      if not singleEventRedDot and not string.isEmpty(self.bind.reddotName) then
        L_ReddotManager:clearNew(L_ReddotManager.DotDef.GameAct_New, self.bind.id)
      end
      if self.bind.isChoose == true then
        return
      end
      self:emit("onClick", self.bind)
    end
  }
end

function this:open()
  self.bind.act_name_selected = self.bind.act_name
  self:checkTMPLayout()
  self:refreshTextColor()
  local reddotName = ""
  if self.bind and self.bind.reddotName then
    reddotName = self.bind.reddotName
  end
  if self.bindComponents.reddotNew then
    if string.isEmpty(reddotName) then
      self.bindComponents.reddotNew.gameObject:SetActive(false)
    else
      L_ReddotManager:registerReddot(self.bindComponents.reddotNew, reddotName)
    end
  end
  self.bind.go_normal_completed = self.bind.completed
  self.bindComponents.cellAnimator:SetBool("Choose", self.bind.isChoose)
  self:initTime()
end

function this:refresh()
  self:refreshSelectedState()
  self:refreshRedDot()
end

function this:close()
end

function this:initTime()
  local gameEventData = L_GameEventStore:getGameEventData(self.bind.id)
  if gameEventData ~= nil then
    local startTime = L_TimeUtil.getDisplayTimeCustom(gameEventData:getStartTime(), _dateFormat)
    local endTime = L_TimeUtil.getDisplayTimeCustom(gameEventData:getEndTime(), _dateFormat)
  else
    errorf("活动" .. "活动id " .. self.bind.id .. "不存在", 2)
  end
end

function this:show()
  self:refreshRedDot()
end

function this:refreshRedDot()
  local clickRedDot = false
  if L_ReddotManager:haveNew(L_ReddotManager.DotDef.GameAct_New, self.bind.id) and self.bind.isChoose == false or string.isEmpty(self.bind.reddotName) then
    clickRedDot = true
  end
  local singleEventRedDot = false
  local gameEvent = L_GameEventStore:getGameEventData(self.bind.id):getGameEvent()
  if gameEvent ~= nil then
    singleEventRedDot = gameEvent:getRedState()
  end
  if not singleEventRedDot and gameEvent then
    singleEventRedDot = gameEvent:getPtShopRedState()
  end
  if clickRedDot or singleEventRedDot then
    self.bindComponents.reddotNew.gameObject:SetActive(true)
    local animator = self.bindComponents.reddotNew:GetComponent(typeof(C_Animation))
    if animator then
      animator:Play("anim_reddot_normal_show")
    end
    L_ReddotManager:markNew(L_ReddotManager.DotDef.GameAct_Events_Group_Reward, self.id)
  else
    self.bindComponents.reddotNew.gameObject:SetActive(false)
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.GameAct_Events_Group_Reward, self.id)
  end
  L_GameEventStore:forceRefreshDot()
end

function this:refreshTextColor()
  if not self.isBind then
    return
  end
  local TMP = self.bindComponents.selectedTMP
  TMP.color = self.bind.txt_color and self.bind.txt_color or C_Color(0, 0, 0, 1)
  TMP.style.outlineColor = self.bind.txt_outlineColor and self.bind.txt_outlineColor or C_Color(0, 0, 0, 1)
  TMP:RefreshStyle()
end

function this:refreshSelectedState()
  if not self.isBind then
    return
  end
  self.bindComponents.cellAnimator:SetBool("Choose", self.bind.isChoose)
  if self.bind.isChoose == true then
    self.bindComponents.layoutElement.preferredHeight = 145.7
  else
    self.bindComponents.layoutElement.preferredHeight = 115.5912
  end
end

function this:checkTMPLayout()
  local designedSingleWidth = 16
  local designedBgWidth = 10
  local txtLayoutElement = self.bindComponents.txtLayoutElement
  local txtContentSizeFitter = self.bindComponents.txtContentSizeFitter
  local TMP = self.bindComponents.TMP
  local currentSingleWidth = string.widthSingle(self.bind.act_name)
  txtContentSizeFitter.enabled = false
  txtLayoutElement.ignoreLayout = false
  self.bind.active_placeholder = false
  if designedBgWidth >= currentSingleWidth then
    txtContentSizeFitter.enabled = false
    txtLayoutElement.ignoreLayout = false
    self.bind.active_placeholder = false
    return
  end
  if designedSingleWidth >= currentSingleWidth then
    self.bind.active_placeholder = true
    txtLayoutElement.ignoreLayout = true
    txtContentSizeFitter.enabled = true
  else
    designedSingleWidth = 18
    txtContentSizeFitter.enabled = false
    TMP.autoSizeTextContainer = true
    if currentSingleWidth > designedSingleWidth then
      TMP.text = string.subWidthText(TMP.text, 18) .. "..."
    end
  end
end

return this
