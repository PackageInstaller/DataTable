local this = class("pageExclusive", G_UIPageBase)

function this.bind()
  return {active_btn_skip = false}
end

function this.methods()
  return {
    onClick = function(self)
      self.bind.active_btn_skip = true
    end,
    onClick_btnSkip = function(self)
      if self.skipCbk then
        self.skipCbk()
      end
      self.bind.active_btn_skip = false
    end
  }
end

function this:preOpen(options)
  self.openCbk = options.openCbk
  self.skipCbk = options.skipCbk
  self.bind.active_btn_skip = false
end

function this:open(options)
  if self.openCbk then
    self.openCbk()
  end
  AzurWorld.HUDMgr:SetAllVisible(false, "pageExclusive")
end

function this:escHandle()
end

function this:close()
  L_PetStore:clearTimeLineObj()
  AzurWorld.HUDMgr:SetAllVisible(true, "pageExclusive")
end

return this
