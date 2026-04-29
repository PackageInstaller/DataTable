_class("UICN20N49Ryza_ShopSellAnim", UICustomWidget)
UICN20N49Ryza_ShopSellAnim = UICN20N49Ryza_ShopSellAnim

function UICN20N49Ryza_ShopSellAnim:OnShow(uiParams)
  self:InitWidgets()
  self._cgTab = {
    [1] = {
      [1] = "1602341_assistant_spine_cg",
      [2] = "1502351_assistant_spine_cg",
      [3] = "1602181_assistant_spine_cg"
    },
    [2] = {
      [1] = "1300651_assistant_spine_cg",
      [2] = "1601881_assistant_spine_cg",
      [3] = "1601993_assistant_spine_cg"
    },
    [3] = {
      [1] = "1601164_assistant_spine_cg",
      [2] = "1600063_assistant_spine_cg",
      [3] = "1501903_assistant_spine_cg"
    }
  }
  self._cgRtTab = {
    [1] = {
      [1] = Vector2(0, -170),
      [2] = Vector2(0, -163),
      [3] = Vector2(0, -92)
    },
    [2] = {
      [1] = Vector2(0, -75),
      [2] = Vector2(0, -58),
      [3] = Vector2(0, -100)
    },
    [3] = {
      [1] = Vector2(0, -130),
      [2] = Vector2(0, -163),
      [3] = Vector2(0, -109)
    }
  }
  self._effRtTab = {
    [1] = {
      [1] = Vector2(16, 202),
      [2] = Vector2(0, 0),
      [3] = Vector2(25, 236)
    },
    [2] = {
      [1] = Vector2(32, 97),
      [2] = Vector2(0, 0),
      [3] = Vector2(72, 236)
    },
    [3] = {
      [1] = Vector2(30, 245),
      [2] = Vector2(54, -26),
      [3] = Vector2(54, 305)
    }
  }
  self._inAnim = "uieffanim_UICN20N49Ryza_Shop_spine_in"
  self._buyAnim = "uieffanim_UICN20N49Ryza_Shop_spine_go_01"
  self._inAnimTime = 767
  self._buyAnimTime = 5300
  self._allAnimTime = self._inAnimTime + self._buyAnimTime
end

function UICN20N49Ryza_ShopSellAnim:InitWidgets()
  self._cg1 = self:GetUIComponent("RawImageLoader", "c1cg")
  self._cg2 = self:GetUIComponent("RawImageLoader", "c2cg")
  self._cg3 = self:GetUIComponent("RawImageLoader", "c3cg")
  self._cg1rt = self:GetUIComponent("RectTransform", "c1cg")
  self._cg2rt = self:GetUIComponent("RectTransform", "c2cg")
  self._cg3rt = self:GetUIComponent("RectTransform", "c3cg")
  self._eff1rt = self:GetUIComponent("RectTransform", "eff01")
  self._eff2rt = self:GetUIComponent("RectTransform", "eff02")
  self._eff3rt = self:GetUIComponent("RectTransform", "eff03")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._go = self:GetGameObject("root")
  self._go:SetActive(false)
end

function UICN20N49Ryza_ShopSellAnim:SetData(callback)
  self._callback = callback
  self:RefreshUI()
  self:PlayAnim()
end

function UICN20N49Ryza_ShopSellAnim:RefreshUI()
  local random = math.random(1, 3)
  Log.debug("###[UICN20N49Ryza_ShopSellAnim] random:", random)
  local data = self._cgTab[random]
  local cg1 = data[1]
  local cg2 = data[2]
  local cg3 = data[3]
  self._cg1:LoadImage(cg1)
  self._cg2:LoadImage(cg2)
  self._cg3:LoadImage(cg3)
  local rtData = self._cgRtTab[random]
  local rt1 = rtData[1]
  local rt2 = rtData[2]
  local rt3 = rtData[3]
  self._cg1rt.anchoredPosition = rt1
  self._cg2rt.anchoredPosition = rt2
  self._cg3rt.anchoredPosition = rt3
  local effRtData = self._effRtTab[random]
  local effRt1 = effRtData[1]
  local effRt2 = effRtData[2]
  local effRt3 = effRtData[3]
  self._eff1rt.anchoredPosition = effRt1
  self._eff2rt.anchoredPosition = effRt2
  self._eff3rt.anchoredPosition = effRt3
end

function UICN20N49Ryza_ShopSellAnim:PlayAnim()
  self:Lock("UICN20N49Ryza_ShopSellAnim:PlayAnim")
  if self._lockTimer then
    GameGlobal.Timer():CancelEvent(self._lockTimer)
  end
  self._lockTimer = GameGlobal.Timer():AddEvent(self._allAnimTime, function()
    self._go:SetActive(false)
    if self._callback then
      self._callback()
    end
    self:UnLock("UICN20N49Ryza_ShopSellAnim:PlayAnim")
  end)
  self._go:SetActive(true)
  self._anim:Play(self._inAnim)
  if self._inAnimTimer then
    GameGlobal.Timer():CancelEvent(self._inAnimTimer)
  end
  self._inAnimTimer = GameGlobal.Timer():AddEvent(self._inAnimTime, function()
    self._anim:Play(self._buyAnim)
  end)
end

function UICN20N49Ryza_ShopSellAnim:OnHide()
  self:UnLock("UICN20N49Ryza_ShopSellAnim:PlayAnim")
  if self._lockTimer then
    GameGlobal.Timer():CancelEvent(self._lockTimer)
  end
  if self._inAnimTimer then
    GameGlobal.Timer():CancelEvent(self._inAnimTimer)
  end
end
