_class("UIDrawCardConfirmController", UIController)
UIDrawCardConfirmController = UIDrawCardConfirmController

function UIDrawCardConfirmController:OnShow(uiParams)
  self:InitWidget()
  self.itemId = uiParams[1]
  self.itemCount = uiParams[2]
  self.poolId = uiParams[3]
  self.drawType = uiParams[4]
  self.free = uiParams[5] or false
  self.isSingleFree = uiParams[6] or false
  local cfg = Cfg.cfg_item[self.itemId]
  local ss
  if self.free then
    if self.isSingleFree then
      ss = StringTable.Get("str_draw_card_cost_free")
    else
      ss = StringTable.Get("str_draw_card_cost_freeten")
    end
  else
    local heartstoneCount = 1
    local drawCount = 1
    if self.drawType == ShakeType.SHAKE_MULTIPLE then
      heartstoneCount = 10
      drawCount = 10
    end
    ss = StringTable.Get("str_draw_card_cost_to_draw", self.itemCount, StringTable.Get(cfg.Name), heartstoneCount, drawCount)
  end
  self.title:SetText(ss)
  self.iconRoot:SetActive(not self.free)
  local otherRootPosX = 0
  if self.free then
    otherRootPosX = -75
    local freeCount = self.itemCount
    self.itemCount = 0
    local lessCount = freeCount - 1
    self.have:SetText(freeCount)
    self.rest:SetText(lessCount)
  else
    local had = self:GetModule(RoleModule):GetAssetCount(self.itemId)
    local rest = had - self.itemCount
    if 99999 < had then
      had = "99999+"
    end
    if 99999 < rest then
      rest = "99999+"
    end
    self.have:SetText(had)
    self.rest:SetText(rest)
    self.icon:LoadImage(cfg.Icon)
  end
  self.otherRoot.anchoredPosition = Vector2(otherRootPosX, 0)
end

function UIDrawCardConfirmController:InitWidget()
  self.title = self:GetUIComponent("UILocalizationText", "title")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.have = self:GetUIComponent("UILocalizationText", "have")
  self.rest = self:GetUIComponent("UILocalizationText", "rest")
  self.iconRoot = self:GetGameObject("iconRoot")
  self.otherRoot = self:GetUIComponent("RectTransform", "otherRoot")
end

function UIDrawCardConfirmController:ConfirmButtonOnClick(go)
  UIRecruitAction.Drawcard(self.drawType, self.poolId, self.itemId, self.itemCount)
  self:CloseDialog()
end

function UIDrawCardConfirmController:DrawCard(TT)
end

function UIDrawCardConfirmController:CancelButtonOnClick(go)
  self:CloseDialog()
end

function UIDrawCardConfirmController:_PoolCountTestLog(viewData)
  if EDITOR then
    Log.debug("###[PoolCountTestLog] EDITOR模式,开始写入log!")
    local path = UnityEngine.Application.dataPath .. "/card_pool_count_calc_log.lua"
    local data = viewData
    local file = io.open(path, "a")
    io.output(file)
    local poolid = data._poolID
    local module = GameGlobal.GetModule(GambleModule)
    local timeStr = os.date("%Y-%m-%d %H:%M %S", os.time())
    if data._cards and table.count(data._cards) > 0 then
      for i = 1, #data._cards do
        local itemStr = ""
        local item = data._cards[i]
        local itemid = item.assetid
        local itemcount = item.count
        itemStr = itemStr .. tostring(itemid) .. "*" .. tostring(itemcount)
        local writeStr = "日志:卡池ID[" .. poolid .. "],时间[" .. timeStr .. "],获得星灵[" .. itemStr .. "].\n"
        io.write("###[PoolCountTestLog] " .. writeStr)
      end
    end
    io.close(file)
    Log.debug("###[PoolCountTestLog] EDITOR模式,结束写入log!")
  else
    Log.debug("###[PoolCountTestLog] 不是EDITOR模式,写入log失败!")
  end
end
