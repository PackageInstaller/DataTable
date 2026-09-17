local module = class("modulePamiLetterContentCell", G_UIModuleBase)

function module.bind()
  return {
    receiverNameText = "",
    contentText = "",
    senderNameText = "",
    contentImg = "",
    rewardList = L_Const.ModuleInfo.CellIcon,
    cellActive = true,
    voicePlayBtnActive = false,
    rewardsActive = false,
    contentImgActive = false,
    rewardRedDotActive = false
  }
end

function module.methods()
  return {
    onClick_voicePlayBtn = function(self)
      local pamiLetterTextTpl = L_GameTpl:getPamiLetterTextTpl()
      local tpl = pamiLetterTextTpl:getTplById(self.bind.letterTextId)
      local voiceEvent = pamiLetterTextTpl:getVoice(tpl)
      L_PamiTalkManager:setPlayingLetterVoice(L_AudioUtil.playSound(voiceEvent))
    end
  }
end

function module:refresh()
  if self.bind.textType == L_PamiTalkManager.pamiTalkTextType.Send then
    self:setSenderCell()
  end
  if self.bind.textType == L_PamiTalkManager.pamiTalkTextType.Reply then
    self:setReplyCell()
  end
end

function module:setReplyCell()
  local pamiLetterReplyTpl = L_GameTpl:getPamiLetterReplyTpl()
  local tpl = pamiLetterReplyTpl:getTplById(self.bind.letterTextId)
  self:setTextAndPic(pamiLetterReplyTpl, tpl)
end

function module:setSenderCell()
  local pamiLetterTextTpl = L_GameTpl:getPamiLetterTextTpl()
  local tpl = pamiLetterTextTpl:getTplById(self.bind.letterTextId)
  self:setTextAndPic(pamiLetterTextTpl, tpl)
  self.bind.voicePlayBtnActive = not string.isEmpty(pamiLetterTextTpl:getVoice(tpl))
  local rewards = pamiLetterTextTpl:getReward(tpl)
  if table.isEmpty(rewards) then
    self.bind.rewardsActive = false
  else
    self.bind.rewardsActive = true
    self.isRewardGot = L_PamiTalkManager:isLetterRewardGot(self.bind.letterId, self.bind.letterTextId)
    self.bind.rewardRedDotActive = not self.isRewardGot
    local rewardsData = L_DataUtil.parseRewardConfig(rewards)
    
    local function rewardClickCallback()
      if not self.isRewardGot then
        L_PamiTalkStore:req_pamiTalkGetReward(self.bind.letterId, self.bind.letterTextId, function()
          self:setSenderCell()
        end)
      end
    end
    
    for _, reward in ipairs(rewardsData) do
      reward.activeReward = self.isRewardGot
      reward.callback = rewardClickCallback
    end
    self.bind.rewardList:clear()
    self.bind.rewardList:insert_array(rewardsData)
    if not self.isRewardGot then
      local item = self.bind.rewardList:getItemCls(#rewardsData).uiBinding.gameObject
      local itemRectTransform = item:GetComponent(typeof(C_RectTransform))
      self.bindComponents.rewardRedDot.transform:SetParent(item.transform)
      self.bindComponents.rewardRedDot.anchoredPosition = C_Vector2(itemRectTransform.sizeDelta.x / 2, itemRectTransform.sizeDelta.y / 2)
    end
  end
end

function module:setTextAndPic(tplManager, tpl)
  self.bind.receiverNameText = L_Config:provider(tplManager:getRecipient(tpl))
  self.bind.contentText = L_Config:provider(tplManager:getText(tpl))
  self.bind.senderNameText = L_Lang:get(L_Config:provider(tplManager:getSign(tpl)), {
    playername = L_PlayerStore:getPlayerName()
  })
  local picPath = tplManager:getPic(tpl)
  if string.isEmpty(picPath) then
    self.bind.contentImgActive = false
  else
    self.bind.contentImgActive = true
    self.bind.contentImg = picPath
  end
end

function module:getRewardDotPosition()
  if self.isRewardGot == nil or self.isRewardGot == nil then
    return nil
  end
  if not self.bindComponents or not self.bindComponents.rewardRedDot then
    return false
  end
  return self.bindComponents.rewardRedDot.position
end

return module
