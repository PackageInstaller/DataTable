local this = class("pageCommonIntroduction", G_UIPageBase)
local introductionTpl = L_GameTpl:getIntroductionTpl()

function this.bind()
  return {
    title = "",
    title_fontSize = 20,
    pic = "",
    desc = "",
    switchNodeAcitve = false,
    currentPage = "",
    totalPages = "",
    nextMaskActive = false,
    previousMaskActive = false,
    nextBtnActive = false,
    previousBtnActive = false,
    picActive = true
  }
end

function this.methods()
  return {
    onClick_nextBtn = function(self)
      if self.currentIndex < self.maxPageNum then
        self.currentIndex = self.currentIndex + 1
      end
      self.bindComponents.page_Animation:Stop()
      self.bindComponents.page_Animation:Play("anim_common_intro_r_out")
      L_TimerManager:newOrResetTimer(self, "refreshPageL", function()
        self:refreshPage()
        self.bindComponents.page_Animation:Play("anim_common_intro_r_in")
      end, math.abs(self.bindComponents.page_Animation:GetClip("anim_common_intro_r_out").length))
    end,
    onClick_previousBtn = function(self)
      if self.currentIndex > 1 then
        self.currentIndex = self.currentIndex - 1
      end
      self.bindComponents.page_Animation:Stop()
      self.bindComponents.page_Animation:Play("anim_common_intro_l_out")
      L_TimerManager:newOrResetTimer(self, "refreshPageR", function()
        self:refreshPage()
        self.bindComponents.page_Animation:Play("anim_common_intro_l_in")
      end, math.abs(self.bindComponents.page_Animation:GetClip("anim_common_intro_l_out").length))
    end,
    onClick_closeBtn = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_mask = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  self.groupId = options.groupId
  self:initPages()
end

function this:initPages()
  if math.isEmpty(self.groupId) then
    return
  end
  self.pages = introductionTpl:getPages(self.groupId)
  self.currentIndex = 1
  self.maxPageNum = #self.pages
  self.bind.totalPages = tostring(self.maxPageNum)
  self.bind.switchNodeAcitve = 1 < self.maxPageNum
  if not L_DeviceTpl:getIsPc() then
    self.bind.title_fontSize = 22
  end
  self:refreshPage()
end

function this:refreshPage()
  local tpl = self.pages[self.currentIndex]
  self.bind.nextBtnActive = self.currentIndex < self.maxPageNum
  self.bind.previousBtnActive = self.currentIndex > 1
  self.bind.nextMaskActive = not self.bind.nextBtnActive
  self.bind.previousMaskActive = not self.bind.previousBtnActive
  self.bind.currentPage = tostring(self.currentIndex)
  self.bind.desc = introductionTpl:getContent(tpl)
  self.bind.pic = introductionTpl:getPicture(tpl)
  self.bind.title = introductionTpl:getTitle(tpl)
  self.bind.picActive = introductionTpl:getIsPictureIntroduction(tpl)
end

function this:escHandle()
  L_TimerManager:clearTimer(self)
  L_UI:close(self.pageName)
end

function this:close(options)
  L_TimerManager:clearTimer(self)
  this.super.close(options)
end

return this
