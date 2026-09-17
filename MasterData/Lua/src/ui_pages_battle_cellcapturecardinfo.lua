local this = class("cellCaptureCardInfo", G_UIModuleBase)

function this.bind()
  return {
    img_cardIcon = "",
    active_tuijian = "",
    active_card = "",
    active_root = "",
    active_image = "",
    active_num = "",
    txt_cardCount = "",
    txt_shortCutKet = ""
  }
end

function this.methods()
  return {
    onClick_sphere = function(self)
      self:onClick()
    end
  }
end

function this:open()
  self.ballIndexDic = {
    [0] = C_InputManager_KeyType.EMainPetCatchBall1,
    [1] = C_InputManager_KeyType.EMainPetCatchBall2,
    [2] = C_InputManager_KeyType.EMainPetCatchBall3,
    [3] = C_InputManager_KeyType.EMainPetCatchBall4,
    [4] = C_InputManager_KeyType.EMainPetCatchBall5,
    [5] = C_InputManager_KeyType.EMainPetCatchBall6
  }
  self.ballIndex = self.gameObject.transform:GetSiblingIndex()
  if self.ballIndex == nil then
    return
  end
  self.keyType = self.ballIndexDic[self.ballIndex]
  if self.keyType then
    self.bind.txt_shortCutKet = tostring(self.ballIndex + 1)
    if self.bind.cnt ~= nil and self.bind.cnt > 9999 then
      self.bind.txt_cardCount = tostring(9999)
    else
      self.bind.txt_cardCount = tostring(self.bind.cnt)
    end
  end
end

function this:show(options)
  this.super.show(self, options)
  if self.keyType then
    if self.parent and self.parent.pageName ~= nil then
      L_ShortCutManager:registerShortCut(self.parent.pageName, self.keyType, function(value)
        self:onClick()
      end)
    else
      L_ShortCutManager:registerShortCut("pageNestCoopPetCatch", self.keyType, function(value)
        self:onClick()
      end)
    end
  end
end

function this:close()
  if self.parent and self.parent.pageName ~= nil then
    L_ShortCutManager:removeShortCut(self.parent.pageName)
  else
    L_ShortCutManager:removeShortCut("pageNestCoopPetCatch")
  end
end

function this:onClick()
  if self.parent.bBlockHand or self.parent.catchIsStart or self.parent.isClose or self.parent.isPlayingAnim then
    return
  end
  if self.bind.cnt <= 0 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_noItem"))
    return
  end
  if self.parent and self.parent.pageName ~= nil then
    self:emit("onClick_sphere", self.bind.sphereId, self.bind.cnt, self.bind.quality, self.bind.type)
  else
    self.parent:onClick_sphere(self.bind.sphereId, self.bind.cnt, self.bind.quality, self.bind.type)
  end
end

function this:refreshCnt(cnt)
  if 9999 < cnt then
    cnt = 9999
  end
  self.bind.txt_cardCount = tostring(cnt)
end

function this:playInitAnim(selectId)
  local commonItemTpl = L_GameTpl:getCommonItemTpl()
  local petCatchItemTpl = L_GameTpl:getPetCatchItemTpl()
  local tempTpl = commonItemTpl:getTplById(self.bind.sphereId)
  local tempSubId = commonItemTpl:getSubId(tempTpl)
  local catchItemTpl = petCatchItemTpl:getTplById(tempSubId)
  local catchItemType = tonumber(petCatchItemTpl:getCardType(catchItemTpl))
  local animName = self.bind.sphereId == selectId and "anim_battlecapture_card_show_select" or "show_none"
  self.bind.type = catchItemType
  self.bindComponents.anim:Play(animName, -1, 0)
end

function this:playHideAnim()
  print("dbg playHideAnim")
  self.bindComponents.anim:Play("anim_battlecapture_card_hide", 0)
end

function this:playSelectAnim(oldId, newId)
  if oldId == self.bind.sphereId then
    self.bindComponents.anim:Play("anim_battlecapture_card_to_none", 0)
  end
  if newId == self.bind.sphereId then
    self.bindComponents.anim:Play("toSelect", 0)
  end
end

function this:playUnSelectAnim(id)
  if id ~= self.bind.sphereId then
    return
  end
  self.bindComponents.anim:Play("anim_battlecapture_card_to_none", 0)
end

function this:setBindData(ballData)
  self.ballIndex = self.gameObject.transform:GetSiblingIndex()
  self.bind.quality = ballData.quality
  self.bind.cnt = ballData.cnt
  self.bind.sphereId = ballData.sphereId
  self.keyType = self.ballIndexDic[self.ballIndex]
  L_ShortCutManager:registerShortCut("pageNestCoopPetCatch", self.keyType, function(value)
    self:onClick()
  end)
  self.bind.txt_shortCutKet = tostring(self.ballIndex + 1)
  if self.bind.cnt > 9999 then
    self.bind.txt_cardCount = tostring(9999)
  else
    self.bind.txt_cardCount = tostring(self.bind.cnt)
  end
end

function this:refreshCardCount(ballData)
  if ballData.sphereId == self.bind.sphereId then
    self.bind.cnt = ballData.cnt
  end
  if self.bind.cnt > 9999 then
    self.bind.txt_cardCount = tostring(9999)
  else
    self.bind.txt_cardCount = tostring(self.bind.cnt)
  end
end

return this
