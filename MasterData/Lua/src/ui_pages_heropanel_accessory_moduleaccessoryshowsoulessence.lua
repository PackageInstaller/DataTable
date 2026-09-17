local this = class("moduleAccessoryShowSoulEssence", G_UIModuleBase)
local _soulessenceTpl = L_GameTpl:getSoulessenceTpl()
local quality_color = {
  [L_Const.quality.n_] = "#A0AEB7",
  [L_Const.quality.n] = "#27AE89",
  [L_Const.quality.r] = "#3AB3FF",
  [L_Const.quality.sr] = "#A264FF",
  [L_Const.quality.ssr] = "#FFBF35"
}

function this.bind()
  return {
    soulessenceNullActive = false,
    soulessencPossessActive = false,
    txt_currLv = "",
    color_soulessence = C_Color(1, 1, 1, 1),
    txt_maxLv = "",
    txt_dec_e = "",
    go_star = false,
    go_selected = false,
    go_model = false,
    modelPath = ""
  }
end

function this.methods()
  return {
    onClick_addSoulessence = function(self)
      self._showSpiritFunc(self.spiritGuid, self.heroGuid)
    end,
    onClick_maxBtn = function(self)
      if self.bOpenPageCD == false then
        return
      end
      self.bOpenPageCD = false
      self.timer = Timer.once(2, function()
        self.bOpenPageCD = true
      end, self)
      if self.bind.soulessencPossessActive then
        local spTpl = L_GameTpl:getSoulessenceTpl()
        local serverData = C_SoulEssenceMgr:getsoulessenceItem(self.spiritGuid)
        local tpl = spTpl:getTplById(serverData.soulEssenceId)
        local cgPath = spTpl:getCgPath(tpl)
        L_UI:open("pageSoulEssenceInfo", {
          id = serverData.soulEssenceId,
          isPreview = self.isPreview
        })
      end
    end,
    onClick_viewSpiritBg = function(self)
      self._showSpiritFunc(self.spiritGuid, self.heroGuid)
    end,
    onPointEnter_viewSoulessenceBg = function(self)
      L_AudioUtil.playSound("Play_SFX_System_UI_Inventory_HoverIn")
    end,
    onPointExit_viewSoulessenceBg = function(self)
      L_AudioUtil.playSound("Play_SFX_System_UI_Inventory_HoverOut")
    end,
    onClick_soulessenceStrength = function(self)
      local currSpData = C_SoulEssenceMgr:getsoulessenceItem(self.spiritGuid)
      local maxLevel = C_SoulEssenceMgr:getMaxLevelByGuid(self.spiritGuid)
      local jumpParam = L_Const.soulEssenceUpgradeModules.moduleSoulEssenceBasicInfo
      if maxLevel <= currSpData.level then
        local soulessenceRankTpl = L_GameTpl:getSoulessenceRankTpl()
        local maxRank = soulessenceRankTpl:getMaxRank(currSpData.soulEssenceId)
        if maxRank <= currSpData.rank then
          jumpParam = L_Const.soulEssenceUpgradeModules.moduleSoulEssenceLevelUp
        else
          jumpParam = L_Const.soulEssenceUpgradeModules.moduleSoulEssenceBreak
        end
      else
        jumpParam = L_Const.soulEssenceUpgradeModules.moduleSoulEssenceLevelUp
      end
      L_UI:open("pageSoulEssenceUpgrade", {
        isPreview = false,
        soulEssenceGuid = self.spiritGuid,
        jumpMode = jumpParam
      })
    end,
    onClick_soulessenceReplace = function(self)
      local options = {
        spiritGuid = self.spiritGuid,
        heroGuid = self.heroGuid
      }
      options.hideBg = L_UI:checkPageOpen("pageHero")
      L_UI:open("pageHeroSoulEssenceSwitch", options)
    end,
    onClick_lock = function(self)
      self.isEnterLock = true
    end
  }
end

function this:refreshWeaponInitModule(data)
  self:initModule(data)
end

function this:switchSpiritInitModule(data)
  self:initModule(data)
  L_AudioUtil.playSound("Play_SFX_System_UI_Inventory_ItemEquipped")
  if data.spiritGuid ~= 0 then
    self:PlayVoice()
  end
end

function this:PlayVoice()
  if self.bInVoiceCD then
    return
  end
  self.bInVoiceCD = true
  local configId = L_HeroStore:getHeroConfigId(L_HeroStore:getHero(self.heroGuid))
  L_AudioUtil.playSound("Play_VO_System_" .. configId .. "_ChangeEquip")
  self:newOrResetTimer("voiceCD", function()
    self.bInVoiceCD = false
  end, L_GameTpl:getGameConstTpl():getData("CHARACTER_CHANGEEQUIP_VOICE_CD", L_Const.GameTplType.int))
end

function this:initModule(data)
  data = data or {
    spiritGuid = self.spiritGuid,
    heroGuid = self.heroGuid
  }
  local oldHeroGuid = self.heroGuid
  if data.heroGuid ~= nil then
    self.heroGuid = data.heroGuid
  end
  if data.spiritGuid ~= nil then
    self.spiritGuid = data.spiritGuid
  end
  if self.heroGuid then
    AzurWorld.RedDotMgr:BindRedDotRenderer(string.format("HeroSoulEssence_%s", self.heroGuid), self.bindComponents.reddotNormal.gameObject)
  end
  if data.spiritGuid == nil then
    return
  end
  self.bind.soulessenceNullActive = math.isEmpty(self.spiritGuid)
  self.bind.soulessencPossessActive = not math.isEmpty(self.spiritGuid)
  self.bind.go_star = not math.isEmpty(self.spiritGuid)
  self.bOpenPageCD = true
  self:initSpiritPossess()
end

function this:onGetShowSpiritFunc(func)
  self._showSpiritFunc = func
end

function this:initSpiritPossess()
  if math.isEmpty(self.spiritGuid) == false then
    local spiritItem = C_SoulEssenceMgr:getsoulessenceItem(self.spiritGuid)
    self.soulEssenceItem = spiritItem
    self.bind.go_star = true
    local starPath = string.format("UI/Texture/AccessoryRank/tex_equipment_bg_lzstar%d.png", spiritItem.star - 1)
    self.bindComponents.img_star:LoadSprite(starPath, false)
    local soulEssenceCfg = _soulessenceTpl:getTplById(spiritItem.soulEssenceId)
    local rarity = _soulessenceTpl:getRarity(soulEssenceCfg)
    self.bind.txt_currLv = L_GameUtil.fillColor(tostring(spiritItem.level), quality_color[rarity])
    local _, color = C_ColorUtility.TryParseHtmlString(quality_color[rarity])
    self.bind.color_soulessence = color
    self.bind.txt_maxLv = L_GameUtil.fillColor(tostring(C_SoulEssenceMgr:getMaxLevelByGuid(self.spiritGuid)), quality_color[rarity])
    self.bind.txt_dec_e = L_GameUtil.fillColor("LEVEL", quality_color[rarity])
    if soulEssenceCfg then
      local modelPath = _soulessenceTpl:getUIPath(soulEssenceCfg)
      if self.curPath ~= modelPath then
        self.curPath = modelPath
        self.bind.go_model = true
        self.bind.modelPath = modelPath
        
        function self.bindComponents.soulEssenceModel.loadCallBack()
          self.modelTrans = self.bindComponents.soulEssenceModelTrans:GetChild(self.bindComponents.soulEssenceModelTrans.transform.childCount - 1)
          if self.modelTrans then
            C_SoulEssenceMovieHelper.SetSoulEssencePrefabPlatformStyle(self.modelTrans, L_DeviceTpl:getIsMobile())
            self.bind.go_model = true
          end
        end
      end
    end
    self:refreshRedDot()
  else
    self:releaseAsset()
  end
end

function this:initStarList(starNum)
  if not self.isBind then
    return
  end
  local stars = {}
  for i = 1, starNum do
    table.insert(stars, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(stars)
end

function this:changeLockStatus()
  self.isEnterLock = false
end

function this:refreshRedDot()
  if self.soulEssenceItem then
    AzurWorld.RedDotMgr:BindRedDotRenderer(string.format("SoulEssencePageHeroStory_%s", self.soulEssenceItem.soulEssenceId), self.bindComponents.reddotNormal_btn_max.gameObject)
  end
end

function this:open()
  self.bInVoiceCD = false
  if L_DeviceTpl:getIsMobile() then
    C_UIMgr.pushPopUIRTStack(false)
  else
    C_UIMgr.pushPopUIRTStack(true)
  end
  self.topUICount = 0
  L_UI:addListener(L_UI.pageEvent.preOpen, self.onEvent_preOpenPage, self)
  L_UI:addListener(L_UI.pageEvent.closed, self.onEvent_hidePage, self)
  self.switchHandle = handler(self, self.refreshWeaponInitModule)
  C_BagEvent.instance:Listen(C_EBagEvent.SoulEssenceSwitch, self.switchHandle)
  self.changeHandle = handler(self, self.refreshWeaponInitModule)
  C_BagEvent.instance:Listen(C_EBagEvent.SoulEssenceChange, self.changeHandle)
  self.changeLockStatusHandle = handler(self, self.changeLockStatus)
  C_BagEvent.instance:Listen(C_EBagEvent.SoulEssenceLockStatusChange, self.changeLockStatusHandle)
end

function this:show()
end

function this:hide()
end

function this:close()
  AzurWorld.RedDotMgr:UnBindRedDotRenderer(string.format("HeroSoulEssence_%s", self.heroGuid))
  if self.soulEssenceItem then
    AzurWorld.RedDotMgr:UnBindRedDotRenderer(string.format("SoulEssencePageHeroStory_%s", self.soulEssenceItem.soulEssenceId))
  end
  self.topUI = nil
  self:releaseAsset()
  C_BagEvent.instance:Cancel(C_EBagEvent.SoulEssenceSwitch, self.switchHandle)
  C_BagEvent.instance:Cancel(C_EBagEvent.SoulEssenceChange, self.changeHandle)
  C_BagEvent.instance:Cancel(C_EBagEvent.SoulEssenceLockStatusChange, self.changeLockStatusHandle)
  L_UI:removeListener(L_UI.pageEvent.preOpen, self.onEvent_preOpenPage)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onEvent_hidePage)
  C_UIMgr.popUIRTStack()
end

function this:releaseAsset()
  if self.curPath and self.curPath ~= "" then
    self.curPath = ""
    self.bind.modelPath = ""
    C_SoulEssenceMovieHelper.ReleaseSoulEssencePrefabRefResource(self.modelTrans)
    self.modelTrans = nil
  end
end

function this:onEvent_preOpenPage(pageName)
  if pageName == "pageSoulEssenceUpgrade" or pageName == "pageSoulEssenceInfo" then
    self.topUICount = self.topUICount + 1
    if self.bind.go_model then
      self.bind.go_model = false
    end
  end
end

function this:onEvent_hidePage(pageName)
  if pageName == "pageSoulEssenceUpgrade" or pageName == "pageSoulEssenceInfo" then
    self.topUICount = self.topUICount - 1
  end
  if self.topUICount == 0 and self.bind.go_model == false then
    self.bind.go_model = true
  end
end

return this
