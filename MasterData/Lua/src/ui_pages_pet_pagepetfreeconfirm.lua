local this = class("pagePetFreeConfirm", G_UIPageBase)
local gameConstTpl = L_GameTpl:getGameConstTpl()
local petFreeRewardLimit = L_GameTpl:getGameConstTpl():getData("PET_FREEREWARDLIMIT", L_Const.GameTplType.int)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    warning_txt = {
      [1] = "notice_pagePetFreeConfirm_01",
      [2] = "notice_pagePetFreeConfirm_02",
      [3] = "notice_pagePetFreeConfirm_03",
      [4] = "notice_pagePetFreeConfirm_04",
      [5] = "notice_pagePetFreeConfirm_05"
    }
  }
end

function this.bind()
  return {
    reward = "",
    petList = {
      moduleName = "pages/Pet/cellPetItem"
    },
    warningTxt = "",
    showCanReward = true
  }
end

function this.methods()
  return {
    onClick_popupCancelBtn = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_closeBtn = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_popupNotarizeBtn = function(self)
      local list = {}
      for i, v in pairs(self.selectPet) do
        table.insert(list, v.guid)
      end
      local data = {pet_list = list}
      L_PetStore:req_removePet(data, function()
        L_UI:close(self.pageName)
      end)
    end
  }
end

function this:preOpen(options)
  self.selectPet = options.removeList
  self:refreshPetList(options.removeList)
end

function this:close(options)
end

function this:refreshPetList(selectPet)
  local countList = {}
  for i, v in pairs(selectPet) do
    local pet = L_PetStore:getPetItem(v.guid)
    if pet ~= nil then
      table.insert(countList, pet)
    end
  end
  self.bind.petList:clear()
  local lst = {}
  local hasHighLevel = false
  for i = 1, #countList do
    if 1 < countList[i].lv then
      hasHighLevel = true
    end
    table.insert(lst, {
      guid = countList[i].guid,
      name = countList[i].pet_name,
      Lv = L_WordsTpl:getValue("ui_pageHomeCenterPetStationedManage_01") .. tostring(countList[i].lv),
      id = countList[i].id
    })
  end
  self.bind.petList:insert_array(lst)
  local hasFormationPet = false
  for i = 1, #self.selectPet do
  end
  if hasFormationPet == true and hasHighLevel == true then
    self.bind.warningTxt = L_WordsTpl:getValue(self.data.warning_txt[4])
  elseif hasFormationPet == false and hasHighLevel == true then
    self.bind.warningTxt = L_WordsTpl:getValue(self.data.warning_txt[1])
  elseif hasFormationPet == true and hasHighLevel == false then
    self.bind.warningTxt = L_WordsTpl:getValue(self.data.warning_txt[3])
  elseif hasHighLevel == false and hasFormationPet == false then
    self.bind.warningTxt = L_WordsTpl:getValue(self.data.warning_txt[2])
  end
  self.bind.showCanReward = true
  local currentNum = L_PetStore:getPetFreeRewardNum()
  if #self.selectPet * gameConstTpl:getData("PET_FREEREWARD", L_Const.GameTplType.list_int) <= petFreeRewardLimit - currentNum then
    local key = #self.selectPet * gameConstTpl:getData("PET_FREEREWARD", L_Const.GameTplType.list_int)
    local str = L_GameUtil.fillColor(key, L_Const.colorHtml.green001)
    local msg = string.format("%d + %s / %d", currentNum, str, petFreeRewardLimit)
    self.bind.reward = msg
  else
    local key = petFreeRewardLimit - currentNum
    local str = L_GameUtil.fillColor(key, L_Const.colorHtml.red001)
    local msg = string.format("%d + %s / %d", currentNum, str, petFreeRewardLimit)
    self.bind.reward = msg
  end
end

function this:closePetModule()
  L_UI:close(self.pageName)
end

return this
