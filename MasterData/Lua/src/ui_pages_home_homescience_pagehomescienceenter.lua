local this = class("pageHomeScienceEnter", G_UIPageBase)
local _homeTechnologyTypeTpl = L_GameTpl:getHomeTechnologyTypeTpl()
local _homeTechnologyLevelTpl = L_GameTpl:getHomeTechnologyLevelTpl()
local Type2Categroy = {
  JIANG_REN = 1,
  ZHONG_ZHI = 2,
  CAI_JI = 3,
  MU_CHANG = 4
}
local homeSciencePrePath = "Timeline/UI/HomeScience/pre_Home_Technology_Homelv%d.prefab"

function this.bind()
  return {
    txt_levelZz = "",
    txt_levelCj = "",
    txt_levelJr = "",
    txt_levelMc = "",
    sliderValue_Zz = 1,
    sliderValue_Cj = 1,
    sliderValue_Jr = 1,
    sliderValue_Mc = 1
  }
end

function this.methods()
  return {
    onclick_Zz = function(self)
      self:openPageHomeScience(Type2Categroy.ZHONG_ZHI)
    end,
    onclick_Cj = function(self)
      self:openPageHomeScience(Type2Categroy.CAI_JI)
    end,
    onclick_Jr = function(self)
      self:openPageHomeScience(Type2Categroy.JIANG_REN)
    end,
    onclick_Mc = function(self)
      self:openPageHomeScience(Type2Categroy.MU_CHANG)
    end,
    onclick_close = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  if options and options.isTopLayer then
    self.bindComponents.rootTrans.gameObject.layer = 15
  end
  local nextDayTimeKey = string.format("pageHomeScienceEnter_%d", L_PlayerStore:getPlayerId())
  C_PlayerPrefsUtility.SetInt(nextDayTimeKey, L_TimeUtil.getNextDayTime(tonumber(L_GameConstTpl:getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int))))
  self:loadVirtualCamera()
  self:initPage()
end

function this:show(options)
  this.super.show(self, options)
  L_AudioUtil.playSound("Play_SFX_System_UI_Tech_Menu_Open")
end

function this:open(options)
end

function this:close(options)
  self:unloadVirtualCamera()
  this.super.close(self, options)
  L_AudioUtil.playSound("Play_SFX_System_UI_Tech_Menu_Close")
end

function this:loadVirtualCamera()
  if AzurWorld.HomeMgr.isInHome == false then
    return
  end
  local level = AzurWorld.HomeMgr:OnGetHomeLevel()
  if level <= 1 then
    self._cemeraPre = L_ResPool:syncGameObject(string.format(homeSciencePrePath, 1))
  else
    self._cemeraPre = L_ResPool:syncGameObject(string.format(homeSciencePrePath, 2))
  end
  AzurWorld.HUDMgr:SetAllVisible(false, "PageScienceEnter")
end

function this:unloadVirtualCamera()
  if self._cemeraPre then
    C_GameObject.Destroy(self._cemeraPre)
  end
  AzurWorld.HUDMgr:SetAllVisible(true, "PageScienceEnter")
end

function this:initPage()
  local zzLevel = L_TechnologyStore:getTechTypeInfo(Type2Categroy.ZHONG_ZHI).level
  local cjLevel = L_TechnologyStore:getTechTypeInfo(Type2Categroy.CAI_JI).level
  local jrLevel = L_TechnologyStore:getTechTypeInfo(Type2Categroy.JIANG_REN).level
  local mcLevel = L_TechnologyStore:getTechTypeInfo(Type2Categroy.MU_CHANG).level
  self.bind.txt_levelZz = string.format("Lv.%d", zzLevel)
  self.bind.txt_levelCj = string.format("Lv.%d", cjLevel)
  self.bind.txt_levelJr = string.format("Lv.%d", jrLevel)
  self.bind.txt_levelMc = string.format("Lv.%d", mcLevel)
  self.bind.sliderValue_Zz = self:getTargetTechTypeSliderValue(Type2Categroy.ZHONG_ZHI)
  self.bind.sliderValue_Cj = self:getTargetTechTypeSliderValue(Type2Categroy.CAI_JI)
  self.bind.sliderValue_Jr = self:getTargetTechTypeSliderValue(Type2Categroy.JIANG_REN)
  self.bind.sliderValue_Mc = self:getTargetTechTypeSliderValue(Type2Categroy.MU_CHANG)
end

function this:getTargetTechTypeSliderValue(technologyType)
  local techTypeInfo = L_TechnologyStore:getTechTypeInfo(technologyType)
  local techTypeLevel = techTypeInfo.level
  local techTypeExp = techTypeInfo.exp
  local tplTechnologyLevel = _homeTechnologyLevelTpl:getLevelInfo(technologyType, techTypeLevel)
  local levelNeedExp = _homeTechnologyLevelTpl:getTechnologyExp(tplTechnologyLevel)
  return techTypeExp / levelNeedExp
end

function this:openPageHomeScience(selectId)
  L_AudioUtil.playSound("Play_SFX_System_UI_TechLine_Click")
  L_UI:open("pageHomeScienceMain", {selectId = selectId})
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.homeScience)
  callback(result)
end

return this
