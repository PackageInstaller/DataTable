_class("UIN0CookMakeController", UIController)
UIN0CookMakeController = UIN0CookMakeController

function UIN0CookMakeController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIN0CookMakeController:OnShow(uiParams)
  self._dataId = uiParams[1]
  self._cookData = uiParams[2]
  self:InitWidget()
  self:InitData()
  self.curTipsIndex = 1
  self:InitTips()
  self._spine:LoadSpine("n0_g_spine_idle")
  self._spine:SetAnimation(0, "idle", true)
  self:Refresh(true)
  self:RefreshTips()
  self._eventMakeSucc = GameHelper:GetInstance():CreateCallback(self.OnMakeSucc, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnN0CookMakeSucc, self._eventMakeSucc)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self:PlayEnterAni()
  if self._spine.AnimationState then
    self._spine.AnimationState.Data.DefaultMix = 0
  end
end

function UIN0CookMakeController:OnHide()
  if self._eventMakeSucc then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnN0CookMakeSucc, self._eventMakeSucc)
    self._eventMakeSucc = nil
  end
  self._isHide = true
end

function UIN0CookMakeController:PlayEnterAni()
  self:StartTask(function(TT)
    local lockName = "UIN0CookMainController:PlayEnterAni"
    self.rootAni:Play("uieff_N0_CookMakeController")
    self:Lock(lockName)
    local delay = 20
    for i, v in ipairs(self.matItems) do
      YIELD(TT, delay)
      v:PlayEnterAni()
      delay = delay + 20
    end
    YIELD(TT, 600)
    self:UnLock(lockName)
    self:CheckPreStory()
  end)
end

function UIN0CookMakeController:CheckPreStory()
  if not self.preStoryId then
    return
  end
  local componentid = self._cookData:GetComponentId()
  local key = componentid .. "CookGamePreStory_" .. self._foodId
  if UIN0CookData.HasKey(key) then
    return
  end
  UIN0CookData.SetKey(key)
  self:ShowDialog("UIStoryController", self.preStoryId)
  return true
end

function UIN0CookMakeController:OnMakeSucc()
  self:CloseDialog()
end

function UIN0CookMakeController:InitWidget()
  self.list = self:GetUIComponent("UISelectObjectPath", "list")
  self.detail = self:GetUIComponent("UISelectObjectPath", "detail")
  self.left = self:GetGameObject("left")
  self.right = self:GetGameObject("right")
  self.listGo = self:GetGameObject("list")
  self.txtMatHave = self:GetUIComponent("UILocalizationText", "txtMatHave")
  self.txtMatUse = self:GetUIComponent("UILocalizationText", "txtMatUse")
  self.head = self:GetUIComponent("RawImageLoader", "head")
  self.frame = self:GetUIComponent("RawImageLoader", "frame")
  self._headBgIcon = self:GetUIComponent("UICircleMaskLoader", "headBg")
  self.leftBtn = self:GetGameObject("LeftBtn")
  self.rightBtn = self:GetGameObject("RightBtn")
  self.pointPool = self:GetUIComponent("UISelectObjectPath", "pointPool")
  self.tips = self:GetUIComponent("UILocalizationText", "tips")
  self.name1 = self:GetUIComponent("UILocalizationText", "name1")
  self.cookPos = self:GetUIComponent("RectTransform", "cookPos")
  self.switchAni = self:GetUIComponent("Animation", "switchAni")
  self.rightBtnAni = self:GetUIComponent("Animation", "rightBtnAni")
  self.leftBtnAni = self:GetUIComponent("Animation", "leftBtnAni")
  self.rootAni = self:GetUIComponent("Animation", "UIN0CookMakeController")
  self._spine = self:GetUIComponent("SpineLoader", "Spine")
  local btns = self:GetUIComponent("UISelectObjectPath", "topBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    self:CloseDialog()
  end, nil, nil)
end

function UIN0CookMakeController:InitData()
  self._foodCfg = Cfg.cfg_component_newyear_dinner_food[self._dataId]
  if not self._foodCfg then
    Log.error("UIN0CookMakeController error , cfg_component_newyear_dinner_food can not find id : " .. self._dataId)
    return
  end
  local recipeCfg = self._foodCfg.Recipe
  self._foodId = self._foodCfg.FoodID
  self._matNumLimit = 0
  self._recipeData = {}
  for i, v in ipairs(recipeCfg) do
    local recipe = {}
    recipe.num = 0
    recipe.bestNum = v[2]
    recipe.id = v[1]
    self._matNumLimit = self._matNumLimit + recipe.bestNum
    self._recipeData[i] = recipe
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local itemid = self._cookData:GetCostId()
  self._itemCount = itemModule:GetItemCount(itemid)
  self._AllTip = self._foodCfg.Tip
  self.name1:SetText(StringTable.Get(self._foodCfg.Name))
  self.head:LoadImage(self._foodCfg.PetIcon)
  local storys = self._foodCfg.StoryId
  for k, v in pairs(storys) do
    local storyType = v[1]
    if storyType == 1 then
      self.preStoryId = v[2]
    elseif storyType == 2 then
      self.afterStoryId = v[2]
    end
  end
end

function UIN0CookMakeController:Refresh(hide)
  self.txtMatHave:SetText(StringTable.Get("str_n0_cook_has_mat", self._itemCount))
  self:RefreshUseNum()
  local len = #self._recipeData
  local items = self.list:SpawnObjects("UIN0CookMatSelectItem", 4)
  self.matItems = items
  for i, v in ipairs(items) do
    if hide then
      v:SetVisible(false)
    end
    if i <= len then
      local subData = self._recipeData[i]
      v:SetData(subData, self._matNumLimit, function()
        return self:GetSelectedMatCount()
      end, function()
        return self:GetRemianMatCount()
      end, function(selNum)
        subData.num = selNum
        self:RefreshUseNum()
      end)
    else
      v:SetAsEmpty()
    end
  end
end

function UIN0CookMakeController:RefreshUseNum()
  local str = "<color=#fdd53e>" .. self:GetSelectedMatCount() .. "</color>"
  self.txtMatUse:SetText(StringTable.Get("str_n0_cook_use_mat", str, self._matNumLimit))
end

function UIN0CookMakeController:GetSelectedMatCount()
  local num = 0
  for i, v in ipairs(self._recipeData) do
    num = num + v.num
  end
  return num
end

function UIN0CookMakeController:GetRemianMatCount()
  return self._itemCount - self:GetSelectedMatCount()
end

function UIN0CookMakeController:LeftBtnOnClick()
  if self.curTipsIndex > 1 then
    self.curTipsIndex = self.curTipsIndex - 1
    self:RefreshTips()
    self.leftBtnAni:Play()
    self.switchAni:Play("uieff_N0_CookMakeController_left_L")
  end
end

function UIN0CookMakeController:RightBtnOnClick()
  if self.curTipsIndex < self.tipsCount then
    self.curTipsIndex = self.curTipsIndex + 1
    self:RefreshTips()
    self.rightBtnAni:Play()
    self.switchAni:Play("uieff_N0_CookMakeController_left_R")
  end
end

function UIN0CookMakeController:InitTips()
  local len = #self._AllTip
  local isChg = false
  if not self.tipsContent or len ~= #self.tipsContent then
    self.tipsContent = {}
    local wrongTimes = self._cookData:GetWrongTimes(self._dataId)
    for k, v in pairs(self._AllTip) do
      local t = tonumber(v[1])
      if wrongTimes >= t then
        table.insert(self.tipsContent, v[2])
      end
    end
    isChg = true
  end
  self.tipsCount = #self.tipsContent
  local pointCount = 0
  if 1 < self.tipsCount then
    pointCount = self.tipsCount
  end
  self.allPointCont = self.allPointCont or 0
  if self.allPointCont ~= pointCount then
    self.allPointCont = pointCount
  end
  return isChg
end

function UIN0CookMakeController:RefreshTips(setIndexAsNew)
  self.curTipsIndex = #self.tipsContent
  if self.tipsContent then
    local tipsStr = self.tipsContent[self.curTipsIndex]
    self.tips:SetText(StringTable.Get(tipsStr))
  end
  self.leftBtn:SetActive(false)
  self.rightBtn:SetActive(false)
end

function UIN0CookMakeController:MakeBtnOnClick()
  if self._matNumLimit ~= self:GetSelectedMatCount() then
    ToastManager.ShowToast(StringTable.Get("str_n0_cook_make_mat_err"))
    return
  end
  if self._cookData:IsActivityClose() then
    local result = self._cookData:GetCampaign():CheckComponentOpenClientError(ECCampaignInlandDinnerComponentID.ECAMPAIGN_INLAND_DINNER)
    self._cookData:GetCampaign():CheckErrorCode(result)
    return
  end
  local err
  local diff = 0
  local errRecipeId = 0
  for i, v in ipairs(self._recipeData) do
    if v.num ~= v.bestNum then
      local d = v.num - v.bestNum
      if diff < d then
        diff = d
        errRecipeId = v.id
      end
      err = true
    end
  end
  self:StartTask(function(TT)
    if self.matItems then
      local pos = self.cookPos.position
      for i, v in ipairs(self.matItems) do
        local num = v:GetMatCount()
        local template = v:GetIconTrans()
        for k = 1, num do
          self:CopyObjAndFly(template, pos, 0.4, 0.8)
        end
      end
    end
    self.left:SetActive(false)
    self.right:SetActive(false)
    YIELD(TT, 1000)
    if self._isHide then
      return
    end
    self.listGo:SetActive(false)
    self._spine:SetAnimation(0, "splash", false)
    YIELD(TT, 1000)
    if self._isHide then
      return
    end
    self._spine:SetAnimation(0, "close", false)
    YIELD(TT, 1000)
    if self._isHide then
      return
    end
    self._spine:SetAnimation(0, "ripe", false)
    YIELD(TT, 2000)
    if self._isHide then
      return
    end
    self._spine:SetAnimation(0, "open", false)
    YIELD(TT, 1000)
    if self._isHide then
      return
    end
    if err then
      local t = self._cookData:GetWrongTimes(self._dataId)
      self._cookData:SetWrongTimes(self._dataId, t + 1)
      if self:InitTips() then
        self:RefreshTips(true)
      end
      local name = self._foodCfg.Name
      local tips = ""
      local cfg = Cfg.cfg_dinner_food_material[errRecipeId]
      if cfg then
        tips = StringTable.Get(cfg.Name)
      else
        Log.error("UIN0CookMakeController cfg_dinner_food_material can't find id " .. errRecipeId)
      end
      local petIcon = self._foodCfg.PetIcon
      self:ShowDialog("UIN0CookMakeFailedController", name, tips, petIcon)
      self.left:SetActive(true)
      self.right:SetActive(true)
      self.listGo:SetActive(true)
      self._spine:SetAnimation(0, "idle", true)
      return
    end
    local lockName = "UIN0CookMakeController_RequestMakeFood"
    self:Lock(lockName)
    local res = self._cookData:RequestMakeFood(TT, self._foodId)
    if res and res:GetSucc() then
      local res = AsyncRequestRes:New()
      res:SetSucc(true)
      self._cookData:LoadData(TT, res)
      self:Refresh()
      self:ShowDialog("UIN0CookMakeSuccController", self._dataId, self.afterStoryId)
    else
      self:Refresh()
    end
    self:UnLock(lockName)
  end, self)
end

function UIN0CookMakeController:CopyObjAndFly(templateTrasnsform, pos, startDuration, duration)
  local obj = UnityEngine.Object.Instantiate(templateTrasnsform, templateTrasnsform.parent)
  local startPos = obj.position
  startPos.x = startPos.x + math.random() * 0.5
  startPos.y = startPos.y + math.random() * 0.5
  obj:DOMove(startPos, startDuration):OnComplete(function()
    obj:DOMove(pos, duration):OnComplete(function()
      UnityEngine.Object.DestroyImmediate(obj.gameObject)
    end)
  end)
end

function UIN0CookMakeController:OnActivityCloseEvent(campaignId)
  local campaign = self._cookData:GetCampaign()
  if campaign and campaign._id == campaignId then
    self:CloseDialog()
  end
end
