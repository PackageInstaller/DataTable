local this = class("pageSnackBagConfigTip", G_UIPageBase)

function this.bind()
  return {
    list_heroConfig = {
      moduleName = "pages/main/cellHealingHint"
    },
    module_selectNum_hero = L_Const.ModuleInfo.SelectNum,
    list_petConfig = {
      moduleName = "pages/main/cellHealingHint"
    },
    module_selectNum_pet = L_Const.ModuleInfo.SelectNum,
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip
  }
end

function this.methods()
  return {
    moduleCommonTipMedium = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        print(string.format("Save Config heroSelectNum:%s; petSelectNum:%s", self._heroSelectNum, self._petSelectNum))
        local data = {}
        if self._heroSelectNum ~= C_BagMgr:getSnackBagThreshold(L_Const.snackBagType.hero) then
          table.insert(data, {
            bag_type = L_Const.snackBagType.hero,
            num = self._heroSelectNum
          })
        end
        if self._petSelectNum ~= C_BagMgr:getSnackBagThreshold(L_Const.snackBagType.mount) then
          table.insert(data, {
            bag_type = L_Const.snackBagType.mount,
            num = self._petSelectNum
          })
        end
        if #data ~= 0 then
          L_Net:sendMessage(MsgGenCode.CSProtoSetSnackBagNum, {info = data})
        end
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_accessory_savesuccess"))
        L_UI:close(self.pageName)
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end
    }
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:close()
  this.super.close(self)
end

function this:preOpen()
  this.super.preOpen(self)
  self._heroSelectNum = C_BagMgr:getSnackBagThreshold(L_Const.snackBagType.hero)
  self._petSelectNum = C_BagMgr:getSnackBagThreshold(L_Const.snackBagType.mount)
  self:initPage()
  self:initCommonTipModule()
end

function this:initPage()
  local heroMaxSatiety = L_StarHealingStore:getMaxCharge()
  local gameConstTpl = L_GameTpl:getGameConstTpl()
  local petMaxSatiety = gameConstTpl:getData("PET_SATIETY_MAX_VALUE", L_Const.GameTplType.int)
  self:initList(self.bind.list_heroConfig, L_Const.roleType.hero)
  self:initList(self.bind.list_petConfig, L_Const.roleType.pet)
  self.modules.module_selectNum_hero:initModule(function(num)
    self._heroSelectNum = num
  end, heroMaxSatiety, 0, self._heroSelectNum)
  self.modules.module_selectNum_pet:initModule(function(num)
    self._petSelectNum = num
  end, petMaxSatiety, 0, self._petSelectNum)
end

function this:initList(list, roleType)
  local listData = {}
  local data = roleType == L_Const.roleType.hero and L_GameTpl:getChargeSatietyTpl().data or L_GameTpl:getCommonPetSatietyTpl().data
  for id, _ in pairs(data) do
    local tmp = {
      cellId = id,
      isPetSatiety = roleType == L_Const.roleType.pet
    }
    table.insert(listData, tmp)
  end
  list:clear()
  list:insert_array(listData)
end

function this:initCommonTipModule()
  local moduleTip = self.modules.moduleCommonTipMedium
  moduleTip:initModule({
    txtTitle = L_WordsTpl:getValue("residual_code_pagesnackbagconfigtip_01")
  })
end

return this
