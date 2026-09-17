local module = class("cellAreaLevelInfoItem", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
end

function module.bind()
  return {
    imgNormal = true,
    imgSelect = false,
    imgGet = false,
    imgIcon = "",
    txtLevel = "",
    activeContent = true,
    activeEmpty = false
  }
end

function module.methods()
  return {
    onClickSelectBtn = function(self)
      if self.bind.isEmpty or not self.bind.level then
        return
      end
      self:emit("onClick", self.bind.level)
      self:setSelect(true)
    end
  }
end

function module:open()
  self:refreshCell()
end

function module:refreshCell()
  self.bind.activeContent = not self.bind.isEmpty
  self.bind.activeEmpty = self.bind.isEmpty
  if self.bind.isEmpty then
    return
  end
  self.bind.txtLevel = L_Const.Number2Roma[self.bind.level]
  self.bind.imgGet = self.bind.rewardStatus == L_Const.commonRewardStatus.got
  self.bind.imgIcon = self.bind.levelIcon
  self.bindComponents.imgIcon:SetNativeSize()
  self:setSelect(self.bind.isSelected)
  self.bindComponents.reddotTran.gameObject:SetActive(self.bind.rewardStatus == L_Const.commonRewardStatus.complete)
end

function module:onSetData(param)
  if not param or self.bind.isEmpty then
    return
  end
  self:setSelect(param.isSelected)
end

function module:setSelect(isSelect)
  self.bind.isSelected = isSelect
end

function module:playAnimation(animName)
  if not self.isBind or not self.bindComponents.anim then
    return
  end
  self.bindComponents.anim:Stop()
  self.bindComponents.anim:Play(animName)
end

return module
