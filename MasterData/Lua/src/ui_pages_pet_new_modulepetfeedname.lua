local this = class("modulePetFeedName", G_UIModuleBase)
local petLevelTpl = L_GameTpl:getPetLevelTpl()
local petTalentTpl = L_GameTpl:getPetTalentTpl()
local petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {pet_name = "", show_modifyBtn = true}
end

function this.methods()
  return {
    onClick_modify = function(self)
      local systemId = L_SystemConst.enum.renameKibo
      if L_SystemBreakManager:checkBanSystemAndTip(systemId) then
        return
      end
      local pet = L_PetStore:getPetItem(self.petId)
      local tpl = petTpl:getTplById(pet.id)
      local canRename = petTpl:getIsRename(tpl)
      if not canRename then
        L_FlyMsgManager:showNormalMsgByKey("ui_modulePetBoxName_01")
        return
      end
      local data = {
        txtTitle = L_WordsTpl:getValue("ui_modulePetBoxName_02"),
        placeHolder = L_WordsTpl:getValue("ui_modulePetBoxName_03"),
        limit = 7,
        textBoxType = L_Const.CommonTextBoxType.Rename,
        confirmCallback = function(txt)
          if string.isEmpty(string.trim(txt)) then
            L_FlyMsgManager:showNormalMsgByKey("notice_pageFormationMain_03")
            return
          end
          if string.gsub(txt, " ", "") ~= txt then
            L_FlyMsgManager:showNormalMsgByKey("notice_pageFormationMain_02")
            return
          end
          
          local function contains_special_char(str)
            local special_char_pattern = "[^%w一-龥]"
            return string.find(str, special_char_pattern) ~= nil
          end
          
          local hasSpecial = contains_special_char(txt)
          if hasSpecial == true then
            L_FlyMsgManager:showNormalMsgByKey("ui_modulePetBoxName_04")
            return
          end
          L_PetStore:req_changePetName(txt, self.petId, function(name)
            if name == nil then
              self:setGuid(self.petId)
              L_FlyMsgManager:showNormalMsgByKey("ui_modulePetBoxName_05")
            end
          end)
        end
      }
      L_GameUtil.showNormalTextBox(data)
    end
  }
end

function this:open()
  L_PetStore:listenCallFunc(L_PetStore.event.setPetReleaseMode, self.onChangePetReleaseMode, self)
end

function this:close()
  L_PetStore:unListenCallFunc(L_PetStore.event.setPetReleaseMode, self.onChangePetReleaseMode, self)
end

function this:setGuid(guid)
  local pet = L_PetStore:getPetItem(guid)
  self.petId = guid
  self:refreshPetName(pet.pet_name)
  self:onChangePetReleaseMode()
end

function this:setConfigId(configId, isDetail)
  local tpl = petTpl:getTplById(configId)
  self:refreshPetName(petTpl:getName(tpl))
  self:refreshModifyBtnActive(false)
end

function this:onChangePetReleaseMode()
  self:refreshModifyBtnActive(not L_PetReleaseManager:getIsReleaseMode())
end

function this:refreshPetName(petName)
  self.bind.pet_name = petName
end

function this:refreshModifyBtnActive(isShow)
  self.bind.show_modifyBtn = isShow
end

return this
