local this = class("pageOption", G_UIPageBase)
local _wordsTpl = L_GameTpl:getWordsTpl()

function this.bind()
  return {
    goDefaultBtn = false,
    goView = true,
    goLanguageBtn = false,
    goUISet = false,
    goBoard = true,
    groupSelectId = -1,
    moduleMovementBlock = {
      type = "toggleModule",
      moduleMovementBlock = {
        assetName = "UI/CommonModules/moduleMovementBlock",
        moduleName = "modulePages/moduleMovementBlock"
      }
    },
    moduleMovementBlockName = "",
    keyMask = {
      moduleName = "pages/option/moduleOptionMask"
    },
    titleList = {
      moduleName = "pages/option/cellOptionToggle"
    },
    top = {
      moduleName = "modulePages/moduleCommonTop"
    },
    view = {
      moduleName = "pages/option/moduleOptionView"
    }
  }
end

function this.methods()
  return {
    onClick_toggleGroup = function(self, id)
      self.modules.view:onClick_changeDropdown()
      self:triggerView(id)
    end,
    onClick_save = function(self)
    end,
    onClick_cancel = function(self)
      self:showOrHideMovementBlock(false)
    end,
    onClick_defaultBtn = function(self)
      self.modules.view:onClick_changeDropdown()
      L_GameUtil.showCommonTip({
        txtTitle = _wordsTpl:getTplById("notice_default_settings_title"),
        txtContent = _wordsTpl:getTplById("notice_default_settings_content"),
        confirmCallback = function()
          self.modules.view:defaultSet()
          L_FlyMsgManager:showNormalMsg(_wordsTpl:getValue("notice_optionData_tips01"))
        end
      })
    end,
    onClick_languageBtn = function(self)
      local data = {
        title = _wordsTpl:getTplById("notice_voice_download_title"),
        content1 = _wordsTpl:getTplById("notice_voice_download_content"),
        ok = function()
        end,
        cancel = function()
        end,
        deleteCallBack = function(id)
          self:triggerView(id)
        end
      }
      L_UI:open("pageLanguagePack", data)
    end,
    view = {
      btnClick = function(self, settingType)
        self:triggerSelection(settingType)
      end,
      escSet = function(self, settingId)
        self.modules.keyMask:enter()
        self.modules.view:startRebind(settingId, function(state)
          if self.modules.keyMask then
            self.modules.keyMask:exit()
          end
          self.modules.view:refreshAllList()
        end)
      end
    }
  }
end

function this:preOpen(options)
  self:initTitleList()
end

function this:open()
  L_SettingStore:listenCallFunc(L_SettingStore.event.refreshBright, self.onEvent_refreshBright, self)
  L_SettingStore:listenCallFunc(L_SettingStore.event.refreshContrast, self.onEvent_refreshContrast, self)
  L_SettingStore:listenCallFunc(L_SettingStore.event.refreshSaturation, self.onEvent_refreshSaturation, self)
  L_SettingStore.changedRecord = {}
end

function this:onTopBarRefresh()
  C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(function()
    self:applySetting()
    L_UI:close(self.pageName)
  end)
  C_IntegrateMgr.TopBarModule:SetTopBarMainBtnFunc(function()
    self:applySettingToEsc()
    L_UI:backToRoot()
  end)
end

function this:close()
  L_SettingStore:trySaveKeyJson()
  L_SettingStore:unListenCallFunc(L_SettingStore.event.refreshBright, self.onEvent_refreshBright, self)
  L_SettingStore:unListenCallFunc(L_SettingStore.event.refreshContrast, self.onEvent_refreshContrast, self)
  L_SettingStore:unListenCallFunc(L_SettingStore.event.refreshSaturation, self.onEvent_refreshSaturation, self)
  L_SettingStore:reportSetting()
end

function this:escHandle()
  local isEnable = self.modules.keyMask:isEnable()
  if isEnable then
    self.modules.keyMask:exit()
    self.modules.view:refreshAllList()
  else
    self:applySettingToEsc()
  end
end

function this:initTitleList()
  local classTpl = L_GameTpl:getOptionDataClassTpl()
  local optionDataTpl = L_GameTpl:getOptionDataTpl()
  local tabList = {}
  local equipType = L_DeviceTpl:getEquipment()
  for _, tpl in ipairs(classTpl:getShowList()) do
    local have = false
    for _, v in pairs(optionDataTpl.data) do
      local type = optionDataTpl:getOptionclassification1(v)
      local index = classTpl:getId(tpl)
      if type == index then
        local supports = optionDataTpl:getClientType(v)
        local active = optionDataTpl:getIsActive(v)
        if active then
          for _, t in pairs(supports) do
            if t == equipType then
              have = true
              break
            end
          end
        end
      end
      if have then
        break
      end
    end
    if have then
      table.insert(tabList, {
        itemId = classTpl:getId(tpl),
        title = tpl.optionclassName
      })
    end
  end
  self.bind.titleList:insert_array(tabList)
  self.bind.groupSelectId = L_Const.optionFication.control
end

function this:triggerView(index)
  self.curPageIndex = index
  self.bind.goDefaultBtn = index ~= L_Const.optionFication.account
  self.bind.goLanguageBtn = false
  local haveBtn = self.bind.goDefaultBtn or self.bind.goLanguageBtn
  L_SettingStore:refreshVolatileSetting()
  self.modules.view:refreshView(index, haveBtn)
end

function this:triggerSelection(id)
  if id == L_Const.settingType.uiLayout then
    self:showOrHideMovementBlock(true)
    self.modules.moduleMovementBlock.moduleMovementBlock:loadSettingLayout()
  elseif id == L_Const.settingType.outStuck then
    if C_KiBoDuelLuaWrapper:IsInKiBoDuel() then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_duel_in_battle_13"))
      return
    end
    if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.PlayerToOutStuck, true) then
      return
    end
    AzurWorld.mountMgr:ReqLeaveMount(true)
    AzurWorld.playerMgr.myPlayerUnitAdapter:SwitchOutMountMainControl(nil, true)
    AzurWorld.playerMgr.myPlayerUnit:TriggerEvent(C_EPlayerInternalEvent.PlayerToOutStuck, nil)
    L_UI:close(self.pageName)
  elseif id == L_Const.settingType.logoutCurAccount then
    L_GameUtil.showCommonTip({
      txtTitle = _wordsTpl:getTplById("notice_title_hint"),
      txtContent = _wordsTpl:getTplById("notice_logout_account_content"),
      confirmCallback = function()
        L_UI:close(self.pageName)
        C_LoginManager.LogoutAccount()
      end
    })
  elseif id == L_Const.settingType.closeAccount then
    L_LoginPlatformManager:closeAccount()
  elseif id == L_Const.settingType.resourceSet then
    L_GameUtil.showCommonTip({
      txtTitle = _wordsTpl:getTplById("notice_res_check_title"),
      txtContent = _wordsTpl:getTplById("notice_res_check_content"),
      confirmCallback = function()
        L_GameUtil.showCommonTip({
          txtTitle = L_WordsTpl:getValue("notice_pageOption_01"),
          txtContent = L_WordsTpl:getValue("notice_pageOption_02")
        })
      end
    })
  elseif id == L_Const.settingType.userAgreement then
    L_LoginPlatformManager:showAgreementInfo(L_Const.sdkAgreementType.userAgreement)
  elseif id == L_Const.settingType.privacyAgreement then
    L_LoginPlatformManager:showAgreementInfo(L_Const.sdkAgreementType.provacyAgreement)
  elseif id == L_Const.settingType.childAgreement then
    L_LoginPlatformManager:showAgreementInfo(L_Const.sdkAgreementType.childAgreement)
  elseif id == L_Const.settingType.thirdInfo then
    L_LoginPlatformManager:showAgreementInfo(L_Const.sdkAgreementType.thirdInfo)
  elseif id == L_Const.settingType.userCenter then
    L_LoginPlatformManager:showUserCenter()
  elseif id == L_Const.settingType.customerService then
    L_GameUtil.logEvent(L_Const.logEventName.setup_cs, nil)
    L_LoginPlatformManager:showCustomer()
  end
end

function this:showOrHideMovementBlock(isShow)
  self.bind.goUISet = isShow
  self.bind.goBoard = not isShow
  self.bind.goView = not isShow
  self.bind.moduleMovementBlockName = isShow and "moduleMovementBlock" or string.empty
end

function this:applySetting()
  self.modules.view:applyChangeData()
  L_UI:close(self.pageName)
end

function this:applySettingToEsc()
  self.modules.view:applyChangeData()
  if C_KiBoDuelLuaWrapper:IsInKiBoDuel() then
    L_UI:close(self.pageName)
    return
  end
  L_UI:close(self.pageName)
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.option)
  callback(result)
end

function this:onEvent_refreshBright(id, value)
  if self.modules.view == nil then
    return
  end
  self.modules.view:changeSetting_imagebright(id, value)
end

function this:onEvent_refreshContrast(id, value)
  if self.modules.view == nil then
    return
  end
  self.modules.view:changeSetting_imageContrast(id, value)
end

function this:onEvent_refreshSaturation(id, value)
  if self.modules.view == nil then
    return
  end
  self.modules.view:changeSetting_imageSaturation(id, value)
end

return this
