local this = class("pageCommonCBTProcessEnd", G_UIPageBase)
local _gameConstTpl = L_GameTpl:getGameConstTpl()

function this.bind()
  return {
    active_btnClose = true,
    txt_hintCh = "",
    txt_hintCh1 = ""
  }
end

function this.methods()
  return {
    onclick_close = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:showProcessEndInfo()
  self:initTimer()
end

function this:escHandle()
end

function this:initTimer()
  local time = _gameConstTpl:getData("THANKSPLAY_TIME", L_Const.GameTplType.int)
  Timer.once(time, function()
    self.bindComponents.anim:Play("anim_cbtend_change")
  end)
end

function this:myUpdate()
  local round = math.floor(self.timeCount / self.deltaTimeChange)
  if round == self.oldRound then
    self.timeCount = self.timeCount + 1
    return
  end
  self.oldRound = round
  if round % 2 == 0 then
    if self.bind.active_guide == true then
      self:fadeAndShowBoard(function()
        self:showProcessEndInfo()
      end)
    else
      self:showProcessEndInfo()
    end
  elseif self.bind.active_processEnd == true then
    self:fadeAndShowBoard(function()
      self:showGuideInfo()
    end)
  else
    self:showGuideInfo()
  end
  self.timeCount = self.timeCount + 1
end

function this:showProcessEndInfo()
  self.bind.txt_hintCh = L_WordsTpl:getValue("ui_systemMessage_05")
  self.bind.txt_hintCh1 = L_WordsTpl:getValue("ui_systemMessage_06")
end

function this:showGuideInfo()
  self.bind.active_btnClose = true
end

function this:fadeAndShowBoard(callback)
  local function getter()
    return 1
  end
  
  local function setter(v)
    self.bindComponents.canvasGroup_board.alpha = v
  end
  
  self.Tween1 = DOTween.To(getter, setter, 0, 0.7)
  self.Tween1:SetEase(Tweening.Ease.OutQuad)
  
  function self.Tween1.onComplete()
    callback()
    
    local function getter()
      return 0
    end
    
    local function setter(v)
      self.bindComponents.canvasGroup_board.alpha = v
    end
    
    self.Tween2 = DOTween.To(getter, setter, 1, 0.7)
    self.Tween2:SetEase(Tweening.Ease.OutQuad)
  end
end

function this:close()
  this.super.close(self)
  L_TimerManager:clearTimer(self)
  if self.Tween1 then
    self.Tween1:Kill()
    self.Tween1 = nil
  end
  if self.Tween2 then
    self.Tween2:Kill()
    self.Tween2 = nil
  end
end

return this
