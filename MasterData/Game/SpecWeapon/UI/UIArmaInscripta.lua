local UIArmaInscripta = class("UIArmaInscripta", UIBaseWindow)
local base = UIBaseWindow
local UINSpecWeaponStepItem = require("Game.SpecWeapon.UI.UINSpecWeaponStepItem")
local UINSpecWeaponLvUp = require("Game.SpecWeapon.UI.UINSpecWeaponLvUp")
local UINSpecWeaponSkillCompare = require("Game.SpecWeapon.UI.UINSpecWeaponSkillCompare")
local UINSpecWeaponAttriPre = require("Game.SpecWeapon.UI.UINSpecWeaponAttriPre")
local UINSpecWeaponPointItem = require("Game.SpecWeapon.UI.UINSpecWeaponPointItem")
local HeroSkillData = require("Game.PlayerData.Skill.HeroSkillData")
local CampEnum = require("Game.Common.Camp.CampEnum")
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_MovieManager = CS.MovieManager.Instance
local cs_tweening = CS.DG.Tweening
local util = require("XLua.Common.xlua_util")

function UIArmaInscripta:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickCloseSpecWeapon)
  self._stepItemList = {}
  self.__OnSelectStepCallback = BindCallback(self, self.__OnSelectStep)
  for index, obj in ipairs(self.ui.objs_step) do
    local item = UINSpecWeaponStepItem.New()
    item:Init(obj)
    item:BindSpecWeaponStep(self.__OnSelectStepCallback)
    table.insert(self._stepItemList, item)
  end
  self.ui.logo_Mask.gameObject:SetActive(false)
  self.ui.logoHolder.gameObject:SetActive(false)
  self.__OnSelectLevelCallback = BindCallback(self, self.__OnSelectLevel)
  self._lockPointPool = UIItemPool.New(UINSpecWeaponPointItem, self.ui.lockPoint)
  self.ui.lockPoint:SetActive(false)
  self._unlockPointPool = UIItemPool.New(UINSpecWeaponPointItem, self.ui.unLockPoint)
  self.ui.unLockPoint:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_center, self, self.OnClickcenter)
  UIUtil.AddButtonListener(self.ui.btn_Enhancement, self, self.OnClickLvUp)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.OnCloseLvupAndPreView)
  UIUtil.AddButtonListener(self.ui.btn_QuickEnhance, self, self.OnClickQuickLv)
  self.__CompareSkillCallback = BindCallback(self, self.__CompareSkill)
  self.__ReqLvUpCallback = BindCallback(self, self.__ReqLvUp)
  self.__OnCloseSubNodeCallbcak = BindCallback(self, self.__OnCloseSubNode)
  self.__OnCloseLeftSubNodeEvent = BindCallback(self, self.__OnCloseLeftSubNode)
  self.__PlayPowerUpShowCallback = BindCallback(self, self.__PlayPowerUpShow)
  self._lockPointPool:HideAll()
  self._unlockPointPool:HideAll()
  self._lockPointDic = {}
  self._resloader = cs_ResLoader.Create()
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
end

function UIArmaInscripta:InitUISpecWeapon(specWeaponData, heroData, callback)
  self._specWeaponData = specWeaponData
  self._heroData = heroData
  self._callback = callback
  self._selectStep = 1
  self._pointCfg = PlayerDataCenter.allSpecWeaponData:GetSpecWeaponLevelPointCfg(self._specWeaponData:GetSpecWeaponId())
  local basicCfg = self._specWeaponData:GetSpecWeaponBasicCfg()
  local heroId = basicCfg.hero_id
  local heroCfg = ConfigData.hero_data[heroId]
  local campCfg = ConfigData.camp[heroCfg.camp]
  local careerCfg = ConfigData.career[heroCfg.career]
  self.ui.img_Camp.sprite = CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
  self.ui.img_career.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  self.ui.tex_HeroCenterTip:SetIndex(0, self._heroData:GetName(), LanguageUtil.GetLocaleText(basicCfg.name))
  self._herpTypeColor = nil
  local isEntorpy = heroCfg.camp == CampEnum.eCampTaype.entropy
  if isEntorpy then
    self._herpTypeColor = self.ui.heroTypeColorArray[6]
  else
    self._herpTypeColor = self.ui.heroTypeColorArray[heroCfg.career]
  end
  for _, img in ipairs(self.ui.imgs_heroType) do
    img.color = self._herpTypeColor
  end
  if isEntorpy then
    self.ui.img_background.texture = self._resloader:LoadABAsset(PathConsts:GetResImagePath("NoAtlas/UI_SpecifyWeaponEntropy.png"))
    self.ui.img_background.color = Color.white
    local effectPath = "FX/UI_effct/shanghua/UI_ArmaInscripta_shanghua.prefab"
    self._resloader:LoadABAssetAsync(effectPath, function(prefab)
      if IsNull(prefab) then
        return
      end
      if self.ui == nil then
        return
      end
      if self.ui.tran_EffHolder == nil or IsNull(self.ui.tran_EffHolder.gameObject) then
        return
      end
      prefab:Instantiate(self.ui.tran_EffHolder)
    end)
  end
  for i, item in ipairs(self._stepItemList) do
    item:InitSpecWeaponStep(i, self._specWeaponData)
    item:RefreshStepFrame(heroCfg.camp)
  end
  self:__Refresh()
  if 0 < self._specWeaponData:GetSpecWeaponCurStep() then
    self:__InitEffect()
  else
    self.ui.ani_root:Play("UI_ArmaInscripta")
  end
end

function UIArmaInscripta:__Refresh()
  local level = self._specWeaponData:GetSpecWeaponCurLevel()
  local maxLevel = self._specWeaponData:GetSpecWeaponMaxLevel()
  local isFullLevel = self._specWeaponData:IsSpecWeaponFullLevel()
  local curStep = self._specWeaponData:GetSpecWeaponCurStep()
  if curStep == 0 then
    self.ui.btn_Unlock:SetActive(true)
    self.ui.tex_NowBreakLv.gameObject:SetActive(false)
    self.ui.tex_level.gameObject:SetActive(false)
    self.ui.btn_Enhancement.gameObject:SetActive(false)
    self:__RefreshQuickLvBtn()
  else
    self.ui.btn_Unlock:SetActive(false)
    self.ui.tex_NowBreakLv.gameObject:SetActive(true)
    self.ui.tex_level.gameObject:SetActive(true)
    self.ui.tex_NowBreakLv:SetIndex(curStep - 1)
    self.ui.tex_level.text = tostring(level) .. "/" .. tostring(maxLevel)
    local hideLvNode = self._lvupNode == nil or not self._lvupNode.active
    self.ui.btn_Enhancement.gameObject:SetActive(not isFullLevel and hideLvNode)
    self:__RefreshQuickLvBtn()
    self.ui.tex_EnhancementType:SetIndex(self._specWeaponData:IsSpecWeaponContinueStep() and 1 or 0)
    for i, v in ipairs(self._stepItemList) do
      v:RefreshSpecWeaponStep()
    end
  end
  local canLvup = self._specWeaponData:IsSpecWeaponCouldUprage()
  self.ui.blueDot:SetActive(canLvup)
end

function UIArmaInscripta:OnClickLvUp()
  self:__OpenLvup(nil, nil)
end

function UIArmaInscripta:OnClickcenter()
  if self._specWeaponData:GetSpecWeaponCurStep() == 0 then
    self.ui.obj_selected:SetActive(false)
    for i, v in ipairs(self._stepItemList) do
      v:OnSelectSpecWeaponStep(false)
    end
    self:__ForcePoint(nil)
    self:__OpenLvup(nil, nil, true)
    self:__OpenAttriPre(true)
  else
    self:__OpenAttriPre()
  end
end

function UIArmaInscripta:__OnSelectLevel(level)
  self:__OpenLvup(nil, level)
end

function UIArmaInscripta:__OnSelectStep(stepId)
  self:__OpenLvup(stepId, nil)
end

function UIArmaInscripta:__OpenLvup(step, level, keepPreNodeOpen)
  if not keepPreNodeOpen and self._preNode ~= nil then
    self._preNode:OnClosePreView()
  end
  if self._lvupNode == nil then
    self.ui.rightArea:SetActive(true)
    self._lvupNode = UINSpecWeaponLvUp.New()
    self._lvupNode:Init(self.ui.rightArea)
    self._lvupNode:InitSpecWeaponLvUp(self._specWeaponData, self._heroData, self.__ReqLvUpCallback, self.__CompareSkillCallback, self.__OnCloseSubNodeCallbcak)
  end
  self.ui.btn_Enhancement.gameObject:SetActive(false)
  self:__RefreshQuickLvBtn()
  self._lvupNode:Show()
  self._lvupNode:OpenSpecWeaponLvUp(step, level)
  if step ~= nil or self._specWeaponData:GetSpecWeaponCurStep() > 0 then
    local pos = self:__GetClickPointAndSetSelected(step, level)
    self:__ForcePoint(pos)
  end
end

function UIArmaInscripta:__OpenAttriPre(lock)
  if self._specWeaponData:GetSpecWeaponCurStep() ~= 0 and self._lvupNode ~= nil then
    self._lvupNode:OnCloseLvup()
  end
  if self._preNode == nil then
    self.ui.leftArea:SetActive(true)
    self._preNode = UINSpecWeaponAttriPre.New()
    self._preNode:Init(self.ui.leftArea)
    self._preNode:InitSpecWeaponAttriPre(self._specWeaponData, self._heroData, self._resloader, self.__CompareSkillCallback, self.__OnCloseLeftSubNodeEvent)
  end
  self.ui.btn_Enhancement.gameObject:SetActive(false)
  self:__RefreshQuickLvBtn()
  self._preNode:Show()
  self._preNode:OpenSpecWeaponAttriPre(lock)
end

function UIArmaInscripta:OnCloseLvupAndPreView()
  if self._lvupNode ~= nil then
    self._lvupNode:OnCloseLvup()
  end
  if self._preNode ~= nil then
    self._preNode:OnClosePreView()
  end
end

function UIArmaInscripta:__OnCloseSubNode()
  self.ui.btn_Enhancement.gameObject:SetActive(not self._specWeaponData:IsSpecWeaponFullLevel() and self._specWeaponData:GetSpecWeaponCurStep() > 0)
  self.ui.tex_EnhancementType:SetIndex(self._specWeaponData:IsSpecWeaponContinueStep() and 1 or 0)
  self.ui.obj_selected:SetActive(false)
  self:__RefreshQuickLvBtn()
  for i, v in ipairs(self._stepItemList) do
    v:OnSelectSpecWeaponStep(false)
  end
  self:__ForcePoint(nil)
end

function UIArmaInscripta:__OnCloseLeftSubNode()
  self.ui.btn_Enhancement.gameObject:SetActive(not self._specWeaponData:IsSpecWeaponFullLevel() and self._specWeaponData:GetSpecWeaponCurStep() > 0)
  self.ui.tex_EnhancementType:SetIndex(self._specWeaponData:IsSpecWeaponContinueStep() and 1 or 0)
  self:__RefreshQuickLvBtn()
end

function UIArmaInscripta:__RefreshQuickLvBtn()
  if not self.ui.btn_Enhancement.gameObject.activeSelf then
    self.ui.btn_QuickEnhance.gameObject:SetActive(false)
    return
  end
  local targetLv = self._specWeaponData:GetSpecWeaponMultipleUprageTargetLevel()
  self.ui.btn_QuickEnhance.gameObject:SetActive(targetLv - self._specWeaponData:GetSpecWeaponCurLevel() > 1)
end

function UIArmaInscripta:__CompareSkill(nowSkill, lastSkill)
  if self._compareNode == nil then
    self.ui.checkSkillWindow:SetActive(true)
    self._compareNode = UINSpecWeaponSkillCompare.New()
    self._compareNode:Init(self.ui.checkSkillWindow)
  end
  local nowSkillData = HeroSkillData.New(nowSkill, self._heroData)
  local lastSkillData = HeroSkillData.New(lastSkill, self._heroData)
  nowSkillData:UpdateSkill(nowSkillData:GetMaxLevel())
  lastSkillData:UpdateSkill(lastSkillData:GetMaxLevel())
  self._compareNode:Show()
  self._compareNode:SpecWeaponSkillCompare(lastSkillData, nowSkillData, self._resloader)
end

function UIArmaInscripta:__ReqLvUp()
  if not self._specWeaponData:IsSpecWeaponCouldUprage() then
    return
  end
  self:__RealReqLvUp(1)
end

function UIArmaInscripta:__RealReqLvUp(addLevel)
  local lastLevel = self._specWeaponData:GetSpecWeaponCurLevel()
  local lastStep = self._specWeaponData:GetSpecWeaponCurStep()
  self._tempPower = self._heroData:GetFightingPower()
  PlayerDataCenter.allSpecWeaponData:LvupHeroSpecWeapon(self._specWeaponData:GetSpecWeaponId(), addLevel, function()
    if IsNull(self.transform) then
      return
    end
    self:__Refresh()
    self:__PlayEffectLvup(lastStep, lastLevel)
    if self._lvupNode ~= nil and self._lvupNode.active then
      if self._specWeaponData:IsSpecWeaponFullLevel() or lastStep == 0 then
        self._lvupNode:OnCloseLvup()
      else
        self._lvupNode:RefreshSpecWeaponLvUp()
      end
    end
    if self._preNode ~= nil and self._preNode.active then
      self._preNode:OnClosePreView()
    end
  end)
end

function UIArmaInscripta:OnClickCloseSpecWeapon()
  self:Delete()
  if self._callback then
    self._callback()
  end
end

function UIArmaInscripta:__GetClickPointAndSetSelected(step, level)
  self.ui.obj_selected:SetActive(false)
  for i, v in ipairs(self._stepItemList) do
    v:OnSelectSpecWeaponStep(false)
  end
  
  local function func_LevelDeal(level)
    local pointCfg = self._pointCfg[level]
    local vec = Vector3.New(pointCfg.pos_x, pointCfg.pos_y, 0)
    self.ui.obj_selected:SetActive(true)
    self.ui.obj_selected.transform.localPosition = vec
    return vec
  end
  
  local function func_StepDeal(step)
    local item = self._stepItemList[step]
    item:OnSelectSpecWeaponStep(true)
    return item.gameObject.transform.localPosition
  end
  
  if step == nil and level == nil and not self._specWeaponData:IsSpecWeaponFullLevel() then
    if self._specWeaponData:IsSpecWeaponContinueStep() then
      step = self._specWeaponData:GetSpecWeaponCurStep() + 1
    else
      level = self._specWeaponData:GetSpecWeaponCurLevel() + 1
    end
  end
  if step ~= nil then
    return func_StepDeal(step)
  elseif level ~= nil then
    return func_LevelDeal(level)
  else
    return nil
  end
end

function UIArmaInscripta:__ForcePoint(pointVec)
  if self._moveTween ~= nil then
    self._moveTween:Kill()
  end
  self._moveTween = cs_DoTween.Sequence()
  if pointVec == nil then
    self._moveTween:Append(self.ui.main:DOLocalMoveX(0, 0.3))
  else
    local offset = (850 + pointVec.x) / 1900 * 500
    offset = Mathf.FloorToInt(offset / 10) * 10
    self._moveTween:Append(self.ui.main:DOLocalMoveX(-offset, 0.3))
  end
  self._moveTween:AppendCallback(function()
    self._moveTween = nil
  end)
end

function UIArmaInscripta:__InitEffect()
  local weaponId = self._specWeaponData:GetSpecWeaponId()
  local level = self._specWeaponData:GetSpecWeaponCurLevel()
  local maxLevel = self._specWeaponData:GetSpecWeaponMaxLevel()
  local curStep = self._specWeaponData:GetSpecWeaponCurStep()
  local stepLevelMax = self._specWeaponData:GetSpecWeaponStepLevel()
  for i = 1, stepLevelMax do
    local pointCfg = self._pointCfg[i]
    if pointCfg == nil then
      break
    end
    if i <= level then
      local item = self._unlockPointPool:GetOne()
      item:InitSpecWeaponPoint(i, self.__OnSelectLevelCallback)
      item:PlaySpecWeaponPoint()
      item.transform.localPosition = Vector3.Temp(pointCfg.pos_x, pointCfg.pos_y, 0)
    else
      local item = self._lockPointPool:GetOne()
      item:InitSpecWeaponPoint(i, self.__OnSelectLevelCallback)
      item.transform.localPosition = Vector3.Temp(pointCfg.pos_x, pointCfg.pos_y, 0)
      self._lockPointDic[i] = item
    end
  end
  self:__PlayLoopEffect()
  self:__PlaySpecWeaponLogo()
  self:__RefreshWaitNextPoint()
end

function UIArmaInscripta:__PlayEffectLvup(lastStep, lastLevel)
  if self._lvPointTween ~= nil then
    self._lvPointTween:Complete()
    self._lvPointTween = nil
  end
  local level = self._specWeaponData:GetSpecWeaponCurLevel()
  local curStep = self._specWeaponData:GetSpecWeaponCurStep()
  if lastStep < curStep then
    if lastStep == 0 then
      self:__PlaySpecWeaponLogo(true, function()
        self:__PlaySkillUpShow(curStep, self.__PlayPowerUpShowCallback)
        self:__AfterPlayEffectLevelUp()
      end)
    else
      self:__PlayStepEffect(curStep, lastStep, function()
        self:__PlaySkillUpShow(curStep, self.__PlayPowerUpShowCallback)
        self:__AfterPlayEffectLevelUp()
      end)
    end
  elseif lastLevel < level then
    self:__PlayLevelPointEffect(level, lastLevel, function()
      local vec = self:__GetClickPointAndSetSelected()
      self:__ForcePoint(vec)
      self:__PlayPowerUpShow()
      self:__AfterPlayEffectLevelUp()
    end)
    self:__RefreshWaitNextPoint()
  end
end

function UIArmaInscripta:__AfterPlayEffectLevelUp()
  local level = self._specWeaponData:GetSpecWeaponCurLevel()
  local curStep = self._specWeaponData:GetSpecWeaponCurStep()
  local maxStepLevel = self._specWeaponData:GetSpecWeaponStepLevel(curStep)
  local maxStep = self._specWeaponData:GetSpecWeaponMaxStep()
  if level < maxStepLevel then
    self:__OpenLvup(nil, level + 1)
  elseif curStep < maxStep then
    self:__OpenLvup(curStep + 1, nil)
  else
    self:__OpenAttriPre()
  end
end

function UIArmaInscripta:__PlayLevelPointEffect(level, lastLevel, callback)
  local function local_eftFlashFunc()
    self.ui.clickMask:SetActive(true)
    
    for i = lastLevel + 1, level do
      local curPointCfg = self._pointCfg[i]
      self.ui.efx_particle.transform.localPosition = Vector3.Temp(curPointCfg.pos_x, curPointCfg.pos_y, 0)
      self.ui.efx_particle:SetActive(false)
      self.ui.efx_particle:SetActive(true)
      local lockItem = self._lockPointDic[i]
      if lockItem ~= nil then
        lockItem:PlaySpecWeaponPoint()
        lockItem:ForbidSpecWeaponBtn(false)
      end
      local item = self._unlockPointPool:GetOne()
      item:InitSpecWeaponPoint(i, self.__OnSelectLevelCallback)
      item:PlaySpecWeaponPoint()
      local pointCfg = self._pointCfg[i]
      item.transform.localPosition = Vector3.Temp(pointCfg.pos_x, pointCfg.pos_y, 0)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.3))
    end
    self._levelEftCo = nil
    self.ui.clickMask:SetActive(false)
    if callback ~= nil then
      callback()
    end
  end
  
  if not self._levelEffectCopy then
    self._levelEffectCopy = true
    self:__CopyPartical(self.ui.particalArray_level)
  end
  if self._levelEftCo ~= nil then
    GR.StopCoroutine(self._levelEftCo)
  end
  self._levelEftCo = GR.StartCoroutine(util.cs_generator(local_eftFlashFunc))
end

function UIArmaInscripta:__PlayUnlockEffect()
  if not self._unlockEffectCopy then
    self._unlockEffectCopy = true
    self:__CopyPartical(self.ui.particalArray_unlock)
  end
  self.ui.uI_ArmaInscripta_main_start:SetActive(true)
end

function UIArmaInscripta:__PlayLoopEffect()
  if not self._loopEffectCopy then
    self._loopEffectCopy = true
    self:__CopyPartical(self.ui.particalArray_loop)
  end
  self.ui.uI_ArmaInscripta_loop:SetActive(true)
end

function UIArmaInscripta:__PlayStepEffect(curStep, lastStep, callback)
  if not self._stepEffectCopy then
    self._stepEffectCopy = true
    self:__CopyPartical(self.ui.particalArray_step)
  end
  self.ui.uI_ArmaInscripta_start.transform.localPosition = self.ui.objs_step[curStep].transform.localPosition
  self.ui.uI_ArmaInscripta_start:SetActive(false)
  self.ui.uI_ArmaInscripta_start:SetActive(true)
  self._lvPointTween = cs_DoTween.Sequence()
  self._lvPointTween:AppendInterval(1)
  local weaponId = self._specWeaponData:GetSpecWeaponId()
  local startLevel = self._specWeaponData:GetSpecWeaponStepLevel(lastStep) + 1
  local endLevel = self._specWeaponData:GetSpecWeaponStepLevel(curStep)
  for i = startLevel, endLevel do
    local pointCfg = self._pointCfg[i]
    if pointCfg == nil then
      break
    end
    local item
    if i > self._specWeaponData:GetSpecWeaponCurLevel() then
      item = self._lockPointPool:GetOne()
      self._lockPointDic[i] = item
    else
      item = self._unlockPointPool:GetOne()
    end
    item:InitSpecWeaponPoint(i, self.__OnSelectLevelCallback)
    item.transform.localPosition = Vector3.Temp(pointCfg.pos_x, pointCfg.pos_y, 0)
    self._lvPointTween:Join(item.ui.img_root:DOFade(0, 0.3):From())
    self._lvPointTween:Join(item.transform:DOScale(0.5, 0.5):From())
    if pointCfg.pos_x > 0 then
      self._lvPointTween:Join(item.transform:DOLocalMoveX(-10, 0.5):From())
    elseif pointCfg.pos_x < 0 then
      self._lvPointTween:Join(item.transform:DOLocalMoveX(10, 0.5):From())
    end
  end
  self._lvPointTween:AppendCallback(function()
    self:__RefreshWaitNextPoint()
    self._lvPointTween = nil
    if callback ~= nil then
      callback()
    end
  end)
end

function UIArmaInscripta:__RefreshWaitNextPoint()
  if not self._waitLvEffectCopy then
    self._waitLvEffectCopy = true
    self:__CopyPartical(self.ui.particalArray_waitLv)
  end
  if not self._specWeaponData:IsSpecWeaponContinueLevel() then
    self.ui.efx_wait:SetActive(false)
    return
  end
  local level = self._specWeaponData:GetSpecWeaponCurLevel() + 1
  local pointCfg = self._pointCfg[level]
  local vec = Vector3.Temp(pointCfg.pos_x, pointCfg.pos_y, 0)
  self.ui.efx_wait:SetActive(true)
  self.ui.efx_wait.transform.localPosition = vec
end

function UIArmaInscripta:__CopyPartical(particalArray)
  if self._particalCopyArray == nil then
    self._particalCopyArray = {}
  end
  for i, particleReder in ipairs(particalArray) do
    local mat = particleReder:GetMaterial()
    if not IsNull(mat) then
      local newMat = CS.UnityEngine.Object.Instantiate(mat)
      newMat:SetColor("_DyColor", self._herpTypeColor)
      particleReder.material = newMat
      table.insert(self._particalCopyArray, newMat)
    end
  end
end

function UIArmaInscripta:__PlaySpecWeaponLogo(isUnlock, callback)
  if self._movieTimerId ~= nil then
    TimerManager:StopTimer(self._movieTimerId)
    self._movieTimerId = nil
  end
  local baseCfg = self._specWeaponData:GetSpecWeaponBasicCfg()
  local avgPath = PathConsts:GetSpecWeaponVideoPath(baseCfg.avg_enter)
  if string.IsNullOrEmpty(avgPath) then
    return
  end
  if self._moviePlayer == nil then
    self._moviePlayer = cs_MovieManager:GetMoviePlayer()
  end
  self.ui.logoHolder.gameObject:SetActive(true)
  local playEnd = false
  local logoTex
  self._moviePlayer:SetVideoRender(self.ui.logoHolder)
  self._moviePlayer:PlayVideo(avgPath, function()
    if self._moviePlayer then
      self._moviePlayer:PlayVideo(avgPath)
      self._moviePlayer:SetLoopSeek(42, 43, true)
    end
  end)
  self._moviePlayer:PresetsPauseVideoFrameNo(43)
  if baseCfg.audio_id ~= 0 then
    self._movieAuBack = AudioManager:PlayAudioById(baseCfg.audio_id, function(auBack)
      if auBack == self._movieAuBack then
        self._movieAuBack = nil
      end
    end)
  end
  if self._videoTweens == nil then
    self._videoTweens = {}
  else
    for i, v in ipairs(self._videoTweens) do
      v:Kill()
    end
    table.removeall(self._videoTweens)
  end
  local temp1 = cs_DoTween.Sequence()
  if isUnlock then
    self.ui.ani_root:Play("UI_ArmaInscriptaUnlock")
    temp1:AppendInterval(1)
    temp1:AppendCallback(function()
      self:__PlayUnlockEffect()
      self:__PlayLoopEffect()
    end)
    temp1:AppendInterval(0.5)
    temp1:AppendCallback(function()
      self:__PlayStepEffect(1, 0)
    end)
  else
    local temp1 = cs_DoTween.Sequence()
    temp1:AppendInterval(0.5)
    temp1:AppendCallback(function()
      if not IsNull(self.transform) then
        self.ui.ani_root:Play("UI_ArmaInscriptaAll")
      end
    end)
  end
  table.insert(self._videoTweens, temp1)
  local temp2 = cs_DoTween.Sequence()
  temp2:AppendInterval(0.5)
  temp2:Append(self.ui.logo_Mask:DOFade(0, 0.5))
  temp2:Join(self.ui.logoHolder.transform:DOScale(0.55, 0.6):SetEase(cs_tweening.Ease.InQuad))
  table.insert(self._videoTweens, temp2)
  self.ui.logo_Mask.gameObject:SetActive(true)
  self.ui.logoHolder.transform.localScale = Vector3.one
  local vidoeTemp = cs_DoTween.Sequence()
  vidoeTemp:Append(temp1)
  vidoeTemp:Join(temp2)
  vidoeTemp:AppendCallback(function()
    if not IsNull(self.transform) then
      self.ui.logo_Mask.gameObject:SetActive(false)
      self.ui.logoHolder.transform:SetParent(self.ui.logParent)
      if callback ~= nil then
        callback()
      end
    end
  end)
  table.insert(self._videoTweens, vidoeTemp)
end

function UIArmaInscripta:__PlaySkillUpShow(step, callback)
  local stepCfg = self._specWeaponData:GetSpecWeaponStepCfg(step)
  if stepCfg == nil then
    if callback ~= nil then
      callback()
    end
    return
  end
  local skillId = stepCfg.new_skills[1]
  if skillId == nil then
    if callback ~= nil then
      callback()
    end
    return
  end
  local nowSkillData = self._heroData:GetHeroSkill(skillId)
  if self._compareNode == nil then
    self.ui.checkSkillWindow:SetActive(true)
    self._compareNode = UINSpecWeaponSkillCompare.New()
    self._compareNode:Init(self.ui.checkSkillWindow)
  end
  self._compareNode:Show()
  self._compareNode:SpecWeaponSkillNewStep(nowSkillData, self._resloader)
  self._compareNode:BindCompareHideFuncOnce(callback)
end

function UIArmaInscripta:__PlayPowerUpShow()
  local newPower = self._heroData:GetFightingPower()
  if self._tempPower ~= nil and newPower > self._tempPower then
    UIUtil.AddOneCover("HeroPowerUpSuccess")
    self._powerTimer = TimerManager:StartTimer(self.ui.delay_PowerShow, function()
      self._powerTimer = nil
      UIUtil.CloseOneCover("HeroPowerUpSuccess")
      UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
        if win == nil then
          return
        end
        win:InitHeroPowerUpSuccess(self._tempPower, newPower)
        self._tempPower = nil
      end)
    end, nil, true)
  end
end

function UIArmaInscripta:__ItemUpdate(itemDic)
  for k, v in pairs(ConfigData.spec_weapon_basic_config.totalCostIdDic) do
    if itemDic[k] ~= nil then
      self:__RefreshQuickLvBtn()
      return
    end
  end
end

function UIArmaInscripta:OnClickQuickLv()
  UIManager:ShowWindowAsync(UIWindowTypeID.ArmaInscriptaQuickEnhance, function(win)
    if win == nil then
      return
    end
    win:InitQuickEnhance(self._heroData, self._specWeaponData, function(addLevel)
      if addLevel <= 0 then
        return
      end
      self:__RealReqLvUp(addLevel)
    end)
  end)
end

function UIArmaInscripta:OnDelete()
  TimerManager:StopTimer(self._powerTimer)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  if self._levelEftCo ~= nil then
    GR.StopCoroutine(self._levelEftCo)
  end
  if self._movieTimerId ~= nil then
    TimerManager:StopTimer(self._movieTimerId)
    self._movieTimerId = nil
  end
  if self._moviePlayer ~= nil then
    self._moviePlayer:ReSet()
    cs_MovieManager:ReturnMoviePlayer(self._moviePlayer)
    self._moviePlayer = nil
  end
  if self._movieAuBack ~= nil then
    AudioManager:StopAudioByBack(self._movieAuBack)
  end
  if self._lvPointTween ~= nil then
    self._lvPointTween:Kill()
    self._lvPointTween = nil
  end
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  if self._compareNode ~= nil then
    self._compareNode:Delete()
    self._compareNode = nil
  end
  if self._preNode ~= nil then
    self._preNode:Delete()
    self._preNode = nil
  end
  if self._lvupNode ~= nil then
    self._lvupNode:Delete()
    self._lvupNode = nil
  end
  self._lockPointPool:DeleteAll()
  self._unlockPointPool:DeleteAll()
  if self._particalCopyArray ~= nil then
    for i, material in ipairs(self._particalCopyArray) do
      DestroyUnityObject(material)
    end
  end
  if self._moveTween ~= nil then
    self._moveTween:Kill()
  end
  if self._videoTweens ~= nil then
    for i, v in ipairs(self._videoTweens) do
      v:Kill()
    end
    self._videoTweens = nil
  end
  base.OnDelete(self)
end

return UIArmaInscripta
