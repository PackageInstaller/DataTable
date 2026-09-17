local this = class("modulePetBoxFilter", G_UIModuleBase)
local SelectIndexKeyStringEnums = {
  [L_PetConst.PetBoxFilterEnums.PetDuel] = "PetDuel",
  [L_PetConst.PetBoxFilterEnums.Formation] = "Formation"
}

function this.bind()
  return {txt_index = "", txt_name = ""}
end

function this.methods()
  return {
    onClick_left = function(self)
      self.selectIndex = self.selectIndex - 1
      self:refreshInfo()
    end,
    onClick_right = function(self)
      self.selectIndex = self.selectIndex + 1
      self:refreshInfo()
    end,
    onClick_openPetBox = function(self)
      local page = L_UI:getPage("pagePetDuel")
      if page then
        return
      end
      local kiboDuelFromationPage = L_UI:getPage("pagePetDuelMain")
      if kiboDuelFromationPage then
        return
      end
      L_UI:open("pagePetBox", {
        defaultBoxIndex = self.selectIndex
      })
    end,
    onClick_selectPetBox = function(self)
      L_UI:open("pagePetBoxSelect", {
        initBoxIndex = self.selectIndex,
        ignoreLimit = true,
        callback = function(boxIndex)
          self.selectIndex = boxIndex
          self:refreshInfo()
        end
      })
    end
  }
end

function this:initPetBoxFilterModule(entranceEnum, callback)
  self.callback = callback
  self.keyString = string.format("%s_%s", L_PlayerStore:getPlayerId(), SelectIndexKeyStringEnums[entranceEnum])
  self.selectIndex = C_PlayerPrefsUtility.GetInt(self.keyString)
  if not self.selectIndex or self.selectIndex < 1 then
    self.selectIndex = 1
  end
  self:refreshInfo()
end

function this:initModuleByDefaultIndex(selectIndex, callback)
  self.callback = callback
  self.selectIndex = selectIndex
  self:refreshInfo()
end

function this:refreshInfoWithoutCallback(index)
  self.selectIndex = index
  self:refreshInfo(true)
end

function this:changeIndexOutside(index)
  self.selectIndex = index
  self:refreshInfo()
end

function this:refreshInfo(ignore)
  self.selectIndex = self.selectIndex or 1
  if self.selectIndex < 1 then
    self.selectIndex = L_PetStore:getPetBoxNum()
  elseif self.selectIndex > L_PetStore:getPetBoxNum() then
    self.selectIndex = 1
  end
  if self.keyString then
    C_PlayerPrefsUtility.SetInt(self.keyString, self.selectIndex)
  end
  self.bind.txt_name = self:getPagePetBoxDisplayName(self.selectIndex)
  self.bind.txt_index = string.format("%02d", self.selectIndex)
  if self.callback and not ignore then
    self.callback(self.selectIndex)
  end
end

function this:getPagePetBoxDisplayName(index)
  if L_PetStore:hasPetBoxCustomName(index) then
    return L_PetStore:getPetBoxName(index)
  end
  return L_WordsTpl:getValue("notice_pagePetBox_07")
end

return this
