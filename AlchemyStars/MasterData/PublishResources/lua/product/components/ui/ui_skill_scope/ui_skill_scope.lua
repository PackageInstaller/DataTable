_class("UISkillScope", UIController)
UISkillScope = UISkillScope

function UISkillScope:OnShow(uiParams)
  local skillId = uiParams[1]
  self._petId = uiParams[2]
  self.pet = uiParams[4]
  self._row, self._col = BattleConst.DefaultMaxX, BattleConst.DefaultMaxY
  self._txtSkill = self:GetUIComponent("UILocalizationText", "txtSkill")
  self._activeSkillGo = self:GetGameObject("activeSkill")
  self._txtPower = self:GetUIComponent("UILocalizationText", "txtPower")
  self._chainSkillGo = self:GetGameObject("chainSkill")
  self._chainSkill = self:GetUIComponent("UISelectObjectPath", "chainSkill")
  self._cam = self:GetGameObject("Camera"):GetComponent("Camera")
  self._offsetWorld = self:GetGameObject("offsetWorld"):GetComponent("RectTransform")
  self._piece = self:GetAsset("UISkillScopePiece.prefab", LoadType.GameObject)
  self._skillConfigHelper = SkillConfigHelper:New()
  self._cfg = self:GetCfgSkill(skillId)
  if self._cfg:GetSkillType() == 2 then
    self:AttachEvent(GameEventType.FlushSkillScope, self.Flush)
  end
  self._clrCenter = Color(0.9254901960784314, 0.9098039215686274, 0.7019607843137254, 1)
  self._clrScope = Color(0.9725490196078431, 0.9254901960784314, 0.3215686274509804, 0.7)
  self._clrWhiteTran = Color.white
  self._clrWhiteTran.a = 0.42
  self._gray = Color.white
  self._gray.a = 0.15
  self:GenMap()
  self:InitUIBoard()
  self:Flush(skillId)
end

function UISkillScope:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISkillScopeClose)
  self:DisposeAsset("UISkillScopePiece.prefab")
  self._cam.targetTexture = nil
  if self._cfg:GetSkillType() == 2 then
    self:DetachEvent(GameEventType.FlushSkillScope, self.Flush)
  end
  self:KillTweener()
end

function UISkillScope:KillTweener()
  if self._twns then
    for i, v in ipairs(self._twns) do
      v:Kill()
    end
  end
end

function UISkillScope:IsGapTile(x, y)
  local GapTile = BattleConst.GapTiles
  for _, v in ipairs(GapTile) do
    if x == v[1] and y == v[2] then
      return true
    end
  end
  return false
end

function UISkillScope:GenMap()
  self._boardData = {}
  for j = 1, self._col do
    for k = 1, self._row do
      if not self:IsGapTile(j, k) then
        self._boardData[j .. "_" .. k] = UISkillScopePiece:New(j, k)
      end
    end
  end
end

function UISkillScope:InitUIBoard()
  if not self._offsetWorld then
    return
  end
  local tran = self._offsetWorld
  local names = {"l", "h"}
  local rowCenter = math.ceil(self._row * 0.5)
  local colCenter = math.ceil(self._col * 0.5)
  local unit = 1
  local scale = 0.9
  for i = 1, #names do
    local goi = GameObjectHelper.CreateEmpty(names[i], tran)
    if i == 1 then
      goi.transform.localPosition = Vector3(0, 0, 20)
    end
    for j = 1, self._row do
      local goj = GameObjectHelper.CreateEmpty(tostring(j), goi.transform)
      goj.transform.localPosition = Vector3(0, (j - rowCenter) * unit, 0)
      for k = 1, self._col do
        local boardV = self._boardData[j .. "_" .. k]
        if boardV then
          local gok = UnityEngine.Object.Instantiate(self._piece, goj.transform)
          gok.name = tostring(k)
          GameObjectHelper.SetGameObjectLayer(gok, tran.gameObject.layer)
          gok:SetActive(true)
          gok.transform.localPosition = Vector3((k - colCenter) * unit, 0, 0)
          gok.transform.localRotation = Quaternion.identity
          gok.transform.localScale = Vector3.one * scale
          local img = self:GetImage(gok)
          if i == 2 then
            boardV:SetImage(img)
          else
            img.color = self._gray
          end
        end
      end
    end
  end
end

function UISkillScope:Flush(skillId)
  if skillId == 0 then
    Log.fatal("### UISkillScope skillId=0")
  end
  self._skillId = skillId
  self:FlushSkillScope()
  self:FlushSkillInfo()
end

function UISkillScope:FlushSkillScope()
  if not self._boardData then
    return
  end
  for k, v in pairs(self._boardData) do
    self:SetColor(v.col, v.row, self._clrWhiteTran)
  end
  local skillScopeCal = SkillScopeCalculator:New()
  self._cfg = self:GetCfgSkill(self._skillId)
  local playerPos = Vector2(5, 5)
  self:SetColor(playerPos.x, playerPos.y, self._clrCenter)
  local skillScope = skillScopeCal:CalcSkillScope(self._cfg, playerPos, Vector2(0, 1), {
    Vector2(0, 0)
  })
  if skillScope then
    local wholeGridRange = skillScope:GetWholeGridRange()
    self:KillTweener()
    self._twns = {}
    for i, v in ipairs(wholeGridRange) do
      if playerPos.x ~= v.x or playerPos.y ~= v.y then
        local twn = self:DOColor(v.x, v.y, self._clrScope, self._clrWhiteTran)
        table.insert(self._twns, twn)
      end
    end
  end
  local skillType = self._cfg:GetSkillType()
  local skillTypeStr = ""
  if skillType == PetSkillType.SkillType_ChainSkill then
    skillTypeStr = "str_discovery_chain"
  elseif skillType == PetSkillType.SkillType_Active then
    skillTypeStr = "str_discovery_active"
  else
    skillTypeStr = "str_discovery_leader"
  end
  self._txtSkill.text = StringTable.Get(skillTypeStr) .. StringTable.Get("str_discovery_skill") .. " " .. StringTable.Get("str_discovery_scope_view")
end

function UISkillScope:FlushSkillInfo()
  local skillType = self._cfg:GetSkillType()
  self._activeSkillGo:SetActive(false)
  self._chainSkillGo:SetActive(false)
  if skillType == PetSkillType.SkillType_ChainSkill then
    self._chainSkillGo:SetActive(true)
    local petModule = self:GetModule(PetModule)
    local pet
    if self.pet then
      pet = self.pet
    else
      pet = petModule:GetPet(self._petId)
    end
    local skillInfo = pet:GetSkillByType(skillType)
    local ids = skillInfo.GetIdFunc(pet)
    self._chainSkill:SpawnObjects("UISkillScopeChainItem", table.count(ids))
    local uiPool = self._chainSkill:GetAllSpawnList()
    for i, v in ipairs(uiPool) do
      local go = v:GetGameObject()
      local id = ids[i]
      if id then
        go:SetActive(true)
        local confV = BattleSkillCfg(id)
        v:Flush(confV.TriggerParam, id)
        v:Highlight(id == self._skillId)
      else
        go:SetActive(false)
      end
    end
  else
    if skillType == PetSkillType.SkillType_Active then
      self._activeSkillGo:SetActive(true)
      local triggerParam = self._cfg:GetSkillTriggerParam()
      self._txtPower.text = StringTable.Get("str_discovery_cool_down", triggerParam)
    else
    end
  end
end

function UISkillScope:GetCfgSkill(skillId)
  local cfg = self._skillConfigHelper:GetSkillData(skillId)
  return cfg
end

function UISkillScope:bgOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CloseSkillScope, nil)
  self:CloseDialog()
end

function UISkillScope:GetImage(go)
  if not go then
    return
  end
  local img = go.transform:Find("Image"):GetComponent("Image")
  return img
end

function UISkillScope:SetColor(i, j, color)
  local item = self._boardData[i .. "_" .. j]
  if item then
    item.img.color = color
  end
end

function UISkillScope:DOColor(i, j, color, startColor)
  local item = self._boardData[i .. "_" .. j]
  if item then
    local twn = item.img:DOColor(color, 1):OnStart(function()
      self:SetColor(i, j, startColor)
    end):SetLoops(-1, DG.Tweening.LoopType.Yoyo):SetEase(DG.Tweening.Ease.OutSine)
    return twn
  end
end

_class("UISkillScopePiece", Object)
UISkillScopePiece = UISkillScopePiece

function UISkillScopePiece:Constructor(col, row)
  self.col = col
  self.row = row
  self.img = nil
end

function UISkillScopePiece:SetImage(img)
  self.img = img
end
