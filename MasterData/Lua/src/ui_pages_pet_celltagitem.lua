local cls = class("cellTagItem", G_UIModuleBase)
local _battleTagTpl = L_GameTpl:getBattleTagTpl()

function cls.bind()
  return {txt_label = "", img_label = ""}
end

function cls.methods()
  return {
    onClick = function(self)
      if self.cbk then
        self.cbk()
      end
    end
  }
end

function cls:refresh()
  self.cfgId = self.bind.id
  self.cbk = self.bind.cbk
  self:initModule()
end

function cls:initModule()
  if not self.cfgId then
    return
  end
  local battleTagCfg = _battleTagTpl:getTplById(self.cfgId)
  self.bind.txt_label = _battleTagTpl:getTitle(battleTagCfg)
  self.bind.img_label = _battleTagTpl:getIcon(battleTagCfg)
  local txtWidth = self.bindComponents.tmpTitle.preferredWidth
  self.bindComponents.rect:SetSizeWithCurrentAnchors(0, txtWidth + 29 + 21)
end

return cls
