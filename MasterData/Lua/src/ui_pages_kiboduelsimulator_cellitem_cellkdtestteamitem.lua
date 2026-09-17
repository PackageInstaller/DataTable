local this = class("cellKDTestTeamItem", G_UIModuleBase)
local PAGE_TYPE = {kibo = 1}

function this.bind()
  return {
    txt_name = "",
    txt_level = "",
    img_select = false
  }
end

function this.methods()
  return {}
end

function this:ctor()
  this.super.ctor(self)
  self.pageType = PAGE_TYPE.kibo
end

function this:initData(index, side)
  self.index = index
  self.side = side
  self.store = L_KiboDuelSimulatorStore:getData().playerInfo[self.side].kiboList[self.index]
  if not self.store.kiboId then
    self.kiboInfo = nil
    self.bind.txt_name = L_WordsTpl:getValue("residual_code_cellkdtestteamitem_01")
  else
    self.kiboInfo = L_GameTpl:getPetTpl():getTplById(self.store.kiboId)
    self.bind.txt_name = L_GameTpl:getPetTpl():getName(self.kiboInfo)
  end
  self.bind.txt_level = tostring(self.store.lv)
end

function this:setSelect(flag)
  self.bind.img_select = flag
end

function this:setLevel(level)
  self.bind.txt_level = tostring(level)
  self.store:setLevel(level)
end

function this:setKibo(kiboId)
  self.store:setKiboId(kiboId)
  self.kiboInfo = L_GameTpl:getPetTpl():getTplById(kiboId)
  self.bind.txt_name = L_GameTpl:getPetTpl():getName(self.kiboInfo)
  return true
end

function this:refreshType(type)
  self.pageType = type
end

return this
