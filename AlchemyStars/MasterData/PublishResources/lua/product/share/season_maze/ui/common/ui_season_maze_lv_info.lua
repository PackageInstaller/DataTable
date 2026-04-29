_class("UISeasonMazeLvInfo", UIController)
UISeasonMazeLvInfo = UISeasonMazeLvInfo

function UISeasonMazeLvInfo:InitWidget()
  self._tex = self:GetGameObject("tex")
  self._tex:SetActive(false)
  self._root = self:GetUIComponent("RectTransform", "Content")
  self._lvTex = self:GetUIComponent("UILocalizedTMP", "lv")
  self._rateTex = self:GetUIComponent("UILocalizationText", "rate")
  self._rateImg = self:GetUIComponent("Image", "rateImg")
  self._effTexPool = self:GetUIComponent("Transform", "effTexPool")
  self._pools = {}
  for i = 1, self._effTexPool.childCount do
    local child = self._effTexPool:GetChild(i - 1).gameObject
    table.insert(self._pools, child)
  end
end

function UISeasonMazeLvInfo:CreateData()
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._com = self._seasonMazeObj:GetMazeComponent()
  self._comInfo = self._com:GetComponentInfo()
end

function UISeasonMazeLvInfo:GetMaxLv()
  local cfgid = self._com:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_season_maze_lv({ComponentID = cfgid})
  return table.count(cfgs)
end

function UISeasonMazeLvInfo:GetLvCfg(lv)
  local cfgid = self._com:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_season_maze_lv({ComponentID = cfgid, Lv = lv})
  if cfgs and next(cfgs) then
    return cfgs[1]
  end
end

function UISeasonMazeLvInfo:OnShow(uiParams)
  self:InitWidget()
  self:CreateData()
  local lvMax = false
  self._currentLv = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Lv)
  self._nextLv = self._currentLv + 1
  local maxLv = self:GetMaxLv()
  if maxLv == self._currentLv then
    lvMax = true
  end
  local cfglv = self:GetLvCfg(self._currentLv)
  local currentExp = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Exp)
  local nextExp = cfglv.Exp
  local rate, rateTex
  if lvMax then
    rate = 1
    rateTex = "MAX"
  else
    rate = currentExp / nextExp
    local rateInt = math.floor(rate * 100)
    rateTex = currentExp .. "/" .. nextExp
  end
  self._rateTex:SetText(rateTex)
  self._rateImg.fillAmount = rate
  self._lvTex:SetText(tostring(self._currentLv))
  if lvMax then
    local lvDesc = "str_season_maze_lv_max"
    self:ShowDescList("", 1, lvDesc)
  else
    local cfg_lv = self:GetLvCfg(self._nextLv)
    local key = cfg_lv.UpLvDesc
    local n = 0
    while true do
      n = n + 1
      local keyHead = StringTable.Has(key .. "_" .. n)
      if not keyHead then
        n = n - 1
        break
      end
    end
    if n <= 0 then
      Log.fatal("###[UISeasonMazeLvInfo] no [" .. key .. "_x] in str smaze.xlsx")
      return
    end
    self:ShowDescList(key, n)
  end
  self:SetEffTexPool()
end

function UISeasonMazeLvInfo:ShowDescList(key, n, maxLv)
  for i = 1, n do
    local go = UnityEngine.GameObject.Instantiate(self._tex, self._root)
    go:SetActive(true)
    local str
    if maxLv then
      str = StringTable.Get(maxLv)
    else
      str = StringTable.Get(key .. "_" .. i)
    end
    go:GetComponent(typeof(UILocalizationText)):SetText(str)
  end
end

function UISeasonMazeLvInfo:OnHide()
end

function UISeasonMazeLvInfo:SetEffTexPool()
  local effs = {}
  local cfgs = Cfg.cfg_component_season_maze_lv({
    Lv = self._currentLv
  })
  if cfgs and next(cfgs) then
    local cfg_lv = cfgs[1]
    local grade = cfg_lv.PetGrade
    local lv = cfg_lv.PetLv
    local equip = cfg_lv.PetEquip
    local effTex_grade_lv = StringTable.Get("str_season_maze_lv_grade", grade, lv)
    local effTex_equip = StringTable.Get("str_season_maze_lv_equip", equip)
    table.insert(effs, effTex_grade_lv)
    table.insert(effs, effTex_equip)
  else
    Log.error("###[UISeasonMazeUpLv] cfg_component_season_maze_lv is nil ! lv:", self._currentLv)
  end
  local atkVal = self._com:GetAttrValue(SeasonMazeAttrType.SMET_PetAttackRatio)
  if atkVal and atkVal ~= 0 then
    local strAtk
    if atkVal < 0 then
      strAtk = math.ceil(atkVal * 0.1) .. "%%"
    else
      strAtk = "+" .. math.floor(atkVal * 0.1) .. "%%"
    end
    local atkStr = StringTable.Get("str_season_maze_lv_prop_200", strAtk)
    table.insert(effs, atkStr)
  end
  local defVal = self._com:GetAttrValue(SeasonMazeAttrType.SMET_PetDefRatio)
  if defVal and defVal ~= 0 then
    local strDef
    if defVal < 0 then
      strDef = math.ceil(defVal * 0.1) .. "%%"
    else
      strDef = "+" .. math.floor(defVal * 0.1) .. "%%"
    end
    local defStr = StringTable.Get("str_season_maze_lv_prop_201", strDef)
    table.insert(effs, defStr)
  end
  local hpVal = self._com:GetAttrValue(SeasonMazeAttrType.SMET_PetHpRatio)
  if hpVal and hpVal ~= 0 then
    local strHp
    if hpVal < 0 then
      strHp = math.ceil(hpVal * 0.1) .. "%%"
    else
      strHp = "+" .. math.floor(hpVal * 0.1) .. "%%"
    end
    local hpStr = StringTable.Get("str_season_maze_lv_prop_202", strHp)
    table.insert(effs, hpStr)
  end
  local normalVal = self._com:GetAttrValue(SeasonMazeAttrType.SMET_PetAttackDamageRatio)
  if normalVal and normalVal ~= 0 then
    local strNormal
    if normalVal < 0 then
      strNormal = math.ceil(normalVal * 0.1) .. "%%"
    else
      strNormal = "+" .. math.floor(normalVal * 0.1) .. "%%"
    end
    local normalStr = StringTable.Get("str_season_maze_lv_prop_203", strNormal)
    table.insert(effs, normalStr)
  end
  local chainVal = self._com:GetAttrValue(SeasonMazeAttrType.SMET_PetChainSkillDamageRatio)
  if chainVal and chainVal ~= 0 then
    local strChain
    if chainVal < 0 then
      strChain = math.ceil(chainVal * 0.1) .. "%%"
    else
      strChain = "+" .. math.floor(chainVal * 0.1) .. "%%"
    end
    local chainStr = StringTable.Get("str_season_maze_lv_prop_204", strChain)
    table.insert(effs, chainStr)
  end
  local activeVal = self._com:GetAttrValue(SeasonMazeAttrType.SMET_PetActiveSkillDamageRatio)
  if activeVal and activeVal ~= 0 then
    local strActive
    if activeVal < 0 then
      strActive = math.ceil(activeVal * 0.1) .. "%%"
    else
      strActive = "+" .. math.floor(activeVal * 0.1) .. "%%"
    end
    local activeStr = StringTable.Get("str_season_maze_lv_prop_205", strActive)
    table.insert(effs, activeStr)
  end
  for i = 1, #self._pools do
    local go = self._pools[i]
    go:SetActive(i <= #effs)
    if i <= #effs then
      local eff = effs[i]
      local tex = go:GetComponent("UILocalizationText")
      tex:SetText(eff)
    end
  end
end

function UISeasonMazeLvInfo:BgOnClick(go)
  self:CloseDialog()
end
