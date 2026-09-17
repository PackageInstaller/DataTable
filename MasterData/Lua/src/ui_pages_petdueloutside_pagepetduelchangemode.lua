local cls = class("pagePetDuelChangeMode", G_UIPageBase)

function cls.bind()
  return {
    txt_modeContentArena = "",
    txt_modeContentBattle = "",
    toggle_currentIcon = false,
    toggle_currentMask = false,
    toggle_currentBtns = false,
    toggle_btnsArena = false,
    toggle_btnsBattle = false
  }
end

function cls.methods()
  return {
    onclick_selecModeArena = function(self)
      self.selectMode = L_PetConst.PetDuelGameType.Arena
      self:refreshSelectView(self.selectMode)
    end,
    onClick_selectModeBattle = function(self)
      self.selectMode = L_PetConst.PetDuelGameType.Battle
      self:refreshSelectView(self.selectMode)
    end,
    onclick_selecModeArenaConfirm = function(self)
      self.mode = L_PetConst.PetDuelGameType.Arena
      self:refreshSelectContentView(self.mode)
      if self.callback then
        self.callback(self.mode)
      end
      L_UI:close(self.pageName)
    end,
    onClick_selectModeBattleConfirm = function(self)
      self.mode = L_PetConst.PetDuelGameType.Battle
      self:refreshSelectContentView(self.mode)
      if self.callback then
        self.callback(self.mode)
      end
      L_UI:close(self.pageName)
    end,
    onClick_close = function(self)
      if self.close_callback then
        self.close_callback()
      end
      L_UI:close(self.pageName)
    end
  }
end

function cls:preOpen(options)
  self.callback = options.callback
  self.close_callback = options.close_callback
  self.mode = options.mode
  self.selectMode = options.mode
  self:refreshSelectView(self.mode)
  self:refreshSelectContentView(self.selectMode)
end

function cls:refreshSelectView(mode)
  if mode == L_PetConst.PetDuelGameType.Arena then
    self.bind.toggle_currentMask = false
    self.bind.toggle_currentBtns = true
  elseif mode == L_PetConst.PetDuelGameType.Battle then
    self.bind.toggle_currentMask = true
    self.bind.toggle_currentBtns = false
  end
end

function cls:refreshSelectContentView(mode)
  if mode == L_PetConst.PetDuelGameType.Arena then
    self.bind.toggle_currentIcon = true
    self.bind.toggle_btnsArena = false
    self.bind.toggle_btnsBattle = true
  elseif mode == L_PetConst.PetDuelGameType.Battle then
    self.bind.toggle_currentIcon = false
    self.bind.toggle_btnsArena = true
    self.bind.toggle_btnsBattle = false
  end
end

function cls:close()
  cls.super.close(self)
end

return cls
