_class("UISeasonMazeBossAtk", UICustomWidget)
UISeasonMazeBossAtk = UISeasonMazeBossAtk
_enum("SeasonMazeBossType", {Normal = 1, Special = 2})
SeasonMazeBossType = SeasonMazeBossType

function UISeasonMazeBossAtk:InitWidget()
  self._headIcon = self:GetUIComponent("RawImageLoader", "Head")
  self._turnTex = self:GetUIComponent("UILocalizedTMP", "Turn")
  self._warning = self:GetGameObject("Warning")
  self._warning2 = self:GetGameObject("Warning2")
  self._go = self:GetGameObject("Go")
  self._goTr = self:GetUIComponent("RectTransform", "Go")
  self._goAlpha = self:GetUIComponent("CanvasGroup", "Go")
  self._alpha = self:GetUIComponent("CanvasGroup", "Turn")
  self._tr = self:GetUIComponent("Transform", "Turn")
  self._anim = self:GetUIComponent("Animation", "Go")
  self._anim2 = self:GetUIComponent("Animation", "UISeasonMazeBossAtk")
  self._rateImg = self:GetUIComponent("Image", "rateImg")
  self._rateImgPos = self:GetUIComponent("RectTransform", "rateImgPos")
  self._rateImgBg = self:GetUIComponent("RectTransform", "rateImgBg")
  self._rateImgUnit = self:GetGameObject("img")
  self._rateImgUnit:SetActive(false)
end

function UISeasonMazeBossAtk:CreateImgUnit()
  local comInfo = self._seasonMazeObj:GetComponentInfo(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  local missionInfoList = comInfo.boss_info
  local count = table.count(missionInfoList)
  local width = self._rateImgBg.sizeDelta.x
  self._imgUnitList = {}
  for i = 1, count do
    local go = UnityEngine.GameObject.Instantiate(self._rateImgUnit, self._rateImgBg)
    go:SetActive(true)
    table.insert(self._imgUnitList, go)
    local pos = width * (i / count)
    go:GetComponent("RectTransform").anchoredPosition = Vector2(pos, 0)
  end
end

function UISeasonMazeBossAtk:OnShow()
  self._seasonMazeObj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  self:InitWidget()
  self:CreateImgUnit()
  self._anim2:Play("uieff_UISeasonMazeBossAtk_in")
  self:AttachEvent(GameEventType.OnUISeasonMazeAttChanged, self.ShowAtkBossInfo)
end

function UISeasonMazeBossAtk:SetData()
  self:ShowAtkBossInfo(SeasonMazeAttrType.SMAT_Round, true)
end

function UISeasonMazeBossAtk:PlayAnim(yieldTime, hideAnim, callback)
  if hideAnim then
    if callback then
      callback()
    end
    return
  end
  self._anim:Play()
  local rate = self:GetImgFillVal()
  self._rateImg:DOFillAmount(rate, yieldTime * 0.002)
  local width = self._rateImgBg.sizeDelta.x
  local pos = width * rate
  self._rateImgPos:DOAnchorPos(Vector2(pos, 0), yieldTime * 0.002)
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self:Lock("UISeasonMazeBossAtk:PlayAnim")
  self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
    if callback then
      callback()
    end
    self:UnLock("UISeasonMazeBossAtk:PlayAnim")
  end)
end

function UISeasonMazeBossAtk:ShowAtkBossInfo(attType, hideAnim)
  if attType == SeasonMazeAttrType.SMAT_Round then
    self._goTr.anchoredPosition = Vector2(170, -182)
    self._goTr.localScale = Vector3(1, 1, 1)
    self._goAlpha.alpha = 1
    local comInfo = self._seasonMazeObj:GetComponentInfo(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
    self._missionInfoList = comInfo.boss_info
    self._isLastBoss = false
    self._missionInfo = nil
    self._currIdx = table.count(self._missionInfoList)
    self._finishIdx = 0
    for i = 0, table.count(self._missionInfoList) - 1 do
      local val = self._missionInfoList[i]
      if val.do_cnt ~= -1 then
        self._missionInfo = val
        self._currIdx = i + 1
        if i + 1 == table.count(self._missionInfoList) then
          self._isLastBoss = true
        end
        break
      end
      self._finishIdx = i + 1
    end
    self:PlayAnim(134, hideAnim, function()
      self._alpha.alpha = 1
      self._tr.localScale = Vector3.one
      self:SetCurrentAtkBoss()
    end)
  end
end

function UISeasonMazeBossAtk:SetCurrentAtkBoss()
  if not self._missionInfo then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self:SetMonsterInfo()
  self:SetTurnInfo()
end

function UISeasonMazeBossAtk:SetMonsterInfo()
  local missionid = self._missionInfo.cfg_id
  if not missionid then
    Log.error("###[UISeasonMazeBossAtk] not missionid !")
    return
  end
  local cfg_mission = Cfg.cfg_season_maze_mission[missionid]
  local levelid = cfg_mission.FightLevel
  local monsterIDs = UICommonHelper:GetInstance():GetOptimalEnemys(levelid)
  local bossid = monsterIDs[1]
  local cfg_monster = Cfg.cfg_monster[bossid]
  if not cfg_monster then
    Log.error("###[UISeasonMazeBossAtk] cfg_monster is nil ! id :", bossid)
  end
  local cfg_monster_class = Cfg.cfg_monster_class[cfg_monster.ClassID]
  if not cfg_monster_class then
    Log.error("###[UISeasonMazeBossAtk] cfg_monster_class is nil ! id:", cfg_monster.ClassID)
  end
  local head = cfg_monster_class.HeadIcon
  self._headIcon:LoadImage(head)
  self._warning:SetActive(not self._isLastBoss)
  self._warning2:SetActive(self._isLastBoss)
end

function UISeasonMazeBossAtk:GetImgFillVal()
  local com = self._seasonMazeObj:GetMazeComponent()
  local turn = com:GetAttrValue(SeasonMazeAttrType.SMAT_Round)
  local rate2 = (self._missionInfo.cfg_wave - turn) / self._missionInfo.cfg_wave
  local rate = (self._currIdx - 1) / table.count(self._missionInfoList) + rate2 * (1 / table.count(self._missionInfoList))
  return rate
end

function UISeasonMazeBossAtk:SetTurnInfo()
  local com = self._seasonMazeObj:GetMazeComponent()
  local turn = com:GetAttrValue(SeasonMazeAttrType.SMAT_Round)
  self._turnTex:SetText(tostring(turn))
  local rate = self:GetImgFillVal()
  self._rateImg.fillAmount = rate
  local width = self._rateImgBg.sizeDelta.x
  local pos = width * rate
  self._rateImgPos.anchoredPosition = Vector2(pos, 0)
  for i = 1, #self._imgUnitList do
    local go = self._imgUnitList[i]
    if i == #self._imgUnitList then
      go.transform:GetChild(0).gameObject:SetActive(false)
      go.transform:GetChild(1).gameObject:SetActive(true)
    else
      go.transform:GetChild(1).gameObject:SetActive(false)
      go.transform:GetChild(0).gameObject:SetActive(true)
    end
    if i <= self._finishIdx then
      go.transform:GetChild(2).gameObject:SetActive(true)
      go.transform:GetChild(0).gameObject:GetComponent("Image").color = Color(0.5, 0.5, 0.5, 1)
      go.transform:GetChild(1).gameObject:GetComponent("Image").color = Color(0.5, 0.5, 0.5, 1)
    else
      go.transform:GetChild(2).gameObject:SetActive(false)
      go.transform:GetChild(0).gameObject:GetComponent("Image").color = Color(1, 1, 1, 1)
      go.transform:GetChild(1).gameObject:GetComponent("Image").color = Color(1, 1, 1, 1)
    end
  end
end

function UISeasonMazeBossAtk:OnHide()
end

function UISeasonMazeBossAtk:BossAtkAnim()
  self._anim2:Stop()
  self._anim2:Play("uieff_UISeasonMazeBossAtk_out")
  self:ShowAtkBossInfo(SeasonMazeAttrType.SMAT_Round)
end
