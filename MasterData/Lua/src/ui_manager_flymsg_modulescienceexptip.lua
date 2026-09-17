local FlyMsgAsyncImageBase = require("ui.manager.flyMsg.moduleFlyMsgAsyncImageBase")
local this = class("moduleScienceExpTip", FlyMsgAsyncImageBase)
local _homeTechnologyLevelTpl = L_GameTpl:getHomeTechnologyLevelTpl()
local _txtColorStyle = {
  [1] = "red003",
  [2] = "yellow001",
  [3] = "blue004",
  [4] = "green003"
}
local _sliderImg = {
  [1] = "UI/Atlas/HomeScience/tex_battleresult_bar_exp4.png",
  [2] = "UI/Atlas/HomeScience/tex_battleresult_bar_exp2.png",
  [3] = "UI/Atlas/HomeScience/tex_battleresult_bar_exp3.png",
  [4] = "UI/Atlas/HomeScience/tex_battleresult_bar_exp1.png"
}
local _bgImg = {
  [1] = "UI/Atlas/HomeScience/tex_battleresult_frame_3.png",
  [2] = "UI/Atlas/HomeScience/tex_battleresult_frame_2.png",
  [3] = "UI/Atlas/HomeScience/tex_battleresult_frame_4.png",
  [4] = "UI/Atlas/HomeScience/tex_battleresult_frame_1.png"
}
local _animName = {
  [1] = "anim_scienceexp_in_red",
  [2] = "anim_scienceexp_in_yellow",
  [3] = "anim_scienceexp_in_blue",
  [4] = "anim_scienceexp_in_green"
}

function this.bind()
  return {
    img_icon = "",
    txt_level = "",
    txt_tarLevel = "",
    txt_AddExp = "",
    color_Exp1 = nil,
    color_Exp2 = nil,
    color_Exp3 = nil,
    color_tarLevel1 = nil,
    color_tarLevel2 = nil,
    active_exp = false,
    active_tarLevel = false,
    img_Slider = "",
    img_bg = ""
  }
end

function this:open(params)
  self.isOpen = true
  this.super.open(self)
  self.uiBinding.gameObject:SetActive(true)
  self:initAsyncImageLoad()
  self:updatePageAsync(params)
end

function this:setCloseCB(closeCB)
  self.closeCB = closeCB
end

function this:close()
  if self.tween then
    self.tween:Kill()
    self.tween = nil
  end
  self:clearTimer()
  this.super.close(self)
  self.isShow = false
  self.isOpen = false
  if self.isBind then
    self.uiBinding.gameObject:SetActive(false)
  end
end

function this:updatePageAsync(info)
  if not info then
    return
  end
  self.info = info
  self.technologyType = info.technologyType
  self.oldLevel = info.oldLevel
  self.oldExp = info.oldExp
  local _homeTechnologyTypeTpl = L_GameTpl:getHomeTechnologyTypeTpl()
  local tplTechnologyType = _homeTechnologyTypeTpl:getTplById(self.technologyType)
  local _, color = C_ColorUtility.TryParseHtmlString(L_Const.colorHtml[_txtColorStyle[self.technologyType]])
  self.bind.color_Exp1 = color
  self.bind.color_Exp2 = color
  self.bind.color_Exp3 = color
  local techTypeInfo = L_TechnologyStore:getTechTypeInfo(self.technologyType)
  self.curLevel = techTypeInfo.level
  self.curExp = techTypeInfo.exp
  local add = self.curExp - self.oldExp
  if self.oldLevel ~= self.curLevel then
    self.bind.color_tarLevel1 = color
    self.bind.color_tarLevel2 = color
    self.bind.txt_tarLevel = string.format("%d", self.curLevel)
    for i = self.oldLevel, self.curLevel - 1 do
      local tpl = _homeTechnologyLevelTpl:getLevelInfo(self.technologyType, i)
      local needExp = _homeTechnologyLevelTpl:getTechnologyExp(tpl)
      if needExp then
        add = add + needExp
      end
    end
  end
  self.bind.txt_AddExp = tostring(add)
  self.bind.txt_level = string.format("%d", self.oldLevel)
  local imgIconPath = _homeTechnologyTypeTpl:getTechnologyExpBarIcon(tplTechnologyType)
  local imgSliderPath = _sliderImg[self.technologyType]
  local imgBgPath = _bgImg[self.technologyType]
  local ctx = self._imageLoadCtx
  if imgIconPath then
    self:_loadImageAsync(ctx, self.bindComponents.img_icon, imgIconPath)
  end
  if imgSliderPath then
    self:_loadImageAsync(ctx, self.bindComponents.img_Slider, imgSliderPath)
  end
  if imgBgPath then
    self:_loadImageAsync(ctx, self.bindComponents.img_bg, imgBgPath)
  end
  self:_finishImageLoadSetup(ctx, function()
    if not self:showUIAfterImageLoad() then
      return
    end
    self:doExpTween()
  end, "moduleScienceExpTip")
end

function this:updatePage(info)
  self:updatePageAsync(info)
end

function this:doExpTween()
  local tpl = _homeTechnologyLevelTpl:getLevelInfo(self.technologyType, self.curLevel)
  local needExp = _homeTechnologyLevelTpl:getTechnologyExp(tpl)
  self.bindComponents.animation:Play(_animName[self.technologyType])
  self.bindComponents.img_Slider.fillAmount = self.oldExp / needExp
  self.bind.active_tarLevel = false
  self.bind.active_exp = true
  if self.curLevel == self.oldLevel then
    self.tween = self.bindComponents.img_Slider:DOFillAmount(self.curExp / needExp, 1.167)
    self.tween:SetEase(Tweening.Ease.InOutQuart)
    self.bindComponents.animation:PlayQueued("anim_scienceexp_out")
    self:newOrResetTimer("doCloseAnim", function()
      self:doCloseAnim(handler(self, self.runCB))
    end, 1.24, 1)
  else
    self.tween = self.bindComponents.img_Slider:DOFillAmount(1, 0.666)
    self.tween:SetEase(Tweening.Ease.InQuad)
    self:newOrResetTimer("syncTweenTimer_1", function()
      self.bind.active_tarLevel = true
      self.bind.active_exp = false
    end, 0.666, 1)
    self:newOrResetTimer("syncTweenTimer_2", function()
      self:runCB()
      self:doCloseAnim()
    end, 1, 1)
  end
end

function this:runCB()
  if self.closeCB then
    self.closeCB(self.info, self.curLevel)
  end
end

function this:doCloseAnim(cb)
  if self.isBind then
    self.bindComponents.animation:Play("anim_scienceexp_out")
  end
  self:newOrResetTimer("closeTimer", function()
    if cb then
      cb()
    end
    self:close()
  end, 0.267, 1)
end

return this
