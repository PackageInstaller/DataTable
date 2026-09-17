local this = class("moduleKiboDuelQA", G_UIModuleBase)
local _kiboDuelMapTpl = L_GameTpl:getKiboDuelMapTpl()
local FormationTypeEnum = {
  [L_PetConst.PetDuelGameType.Battle] = L_WordsTpl:getValue("ui_kiboDuel_06"),
  [L_PetConst.PetDuelGameType.Arena] = L_WordsTpl:getValue("ui_kiboDuel_05")
}

function this.bind()
  return {
    txt_preName = "",
    txt_nextName = "",
    txt_title = "",
    toggle_btns = false,
    active_root = false,
    cellHeadPic = {
      moduleName = "pages/headPic/cellHeadPic"
    },
    active_icon = false
  }
end

function this.methods()
  return {
    onClick_btnAccept = function(self)
      if self.callback_accept then
        self.callback_accept()
      end
      self:setActive(false)
    end,
    onClick_btnRefuse = function(self)
      if self.callback_refuse then
        self.callback_refuse()
      end
      self:setActive(false)
    end,
    onClick_btnCancel = function(self)
      if self.callback_cancel then
        self.callback_cancel()
      end
      self:setActive(false)
    end
  }
end

function this:showModule(params)
  if params == nil then
    return
  end
  self.callback_accept = params.callback_accept
  self.callback_refuse = params.callback_refuse
  self.callback_cancel = params.callback_cancel
  if params.playerId and params.playerId ~= 0 then
    self.modules.cellHeadPic:setInfoByPlayerId(params.playerId)
  end
  self.modules.cellHeadPic:setFrameActive(false)
  self.bind.txt_title = params.textTitle
  self.bind.toggle_btns = L_PlayerStore:getPlayerId() == params.playerId
  self.bind.active_root = true
  if params.mode == L_PetConst.PetDuelQAType.ModeChangeQA then
    self.bind.txt_preName = FormationTypeEnum[params.preId]
    self.bind.txt_nextName = FormationTypeEnum[params.nextId]
    self.bind.active_icon = true
  elseif params.mode == L_PetConst.PetDuelQAType.MapChangeQA then
    self.bind.txt_preName = params.preId == 0 and L_WordsTpl:getValue("ui_kiboDuel_60") or _kiboDuelMapTpl:getName(_kiboDuelMapTpl:getTplById(params.preId))
    self.bind.txt_nextName = params.nextId == 0 and L_WordsTpl:getValue("ui_kiboDuel_60") or _kiboDuelMapTpl:getName(_kiboDuelMapTpl:getTplById(params.nextId))
    self.bind.active_icon = true
  elseif params.mode == L_PetConst.PetDuelQAType.EqualModeQA then
    self.bind.txt_preName = params.textContent
    self.bind.txt_nextName = ""
    self.bind.active_icon = false
  end
end

function this:setActive(active)
  self.bind.active_root = active
end

return this
