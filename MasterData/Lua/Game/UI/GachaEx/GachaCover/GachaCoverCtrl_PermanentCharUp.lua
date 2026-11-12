local GachaCoverCtrl_PermanentCharUp = class("GachaCoverCtrl_PermanentCharUp", BaseCtrl)
GachaCoverCtrl_PermanentCharUp._mapNodeConfig = {
  root = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Transform"
  },
  TMPRemianCount = {sComponentName = "TMP_Text"}
}
GachaCoverCtrl_PermanentCharUp._mapEventConfig = {}

function GachaCoverCtrl_PermanentCharUp:Awake()
end

function GachaCoverCtrl_PermanentCharUp:FadeIn()
end

function GachaCoverCtrl_PermanentCharUp:FadeOut()
end

function GachaCoverCtrl_PermanentCharUp:OnEnable()
  local btnDetail1, btnDetail2, btnDetail3, btnDetail4
  
  local function func_MarkAllNode(trRoot)
    local nChildCount = trRoot.childCount - 1
    for i = 0, nChildCount do
      local trChild = trRoot:GetChild(i)
      if trChild.name == "btnDetail1" then
        btnDetail1 = trChild
      end
      if trChild.name == "btnDetail2" then
        btnDetail2 = trChild
      end
      if trChild.name == "btnDetail3" then
        btnDetail3 = trChild
      end
      if trChild.name == "btnDetail4" then
        btnDetail4 = trChild
      end
      if trChild.childCount > 0 then
        func_MarkAllNode(trChild)
      end
    end
  end
  
  func_MarkAllNode(self._mapNode.root)
  
  local function callback1()
    EventManager.Hit("GachaPoolDetail", 1)
  end
  
  local function callback2()
    EventManager.Hit("GachaPoolDetail", 2)
  end
  
  local function callback3()
    EventManager.Hit("GachaPoolDetail", 3)
  end
  
  local function callback4()
    EventManager.Hit("GachaPoolDetail", 4)
  end
  
  if btnDetail1 ~= nil then
    local btn = btnDetail1:GetComponent("UIButton")
    if btn ~= nil then
      btn.onClick:AddListener(callback1)
    end
  end
  if btnDetail2 ~= nil then
    local btn = btnDetail2:GetComponent("UIButton")
    if btn ~= nil then
      btn.onClick:AddListener(callback2)
    end
  end
  if btnDetail3 ~= nil then
    local btn = btnDetail3:GetComponent("UIButton")
    if btn ~= nil then
      btn.onClick:AddListener(callback3)
    end
  end
  if btnDetail4 ~= nil then
    local btn = btnDetail4:GetComponent("UIButton")
    if btn ~= nil then
      btn.onClick:AddListener(callback4)
    end
  end
end

function GachaCoverCtrl_PermanentCharUp:OnDisable()
end

function GachaCoverCtrl_PermanentCharUp:OnDestroy()
end

function GachaCoverCtrl_PermanentCharUp:OnRelease()
end

function GachaCoverCtrl_PermanentCharUp:PlayInAnim()
  local anim = self.gameObject.transform:GetComponent("Animator")
  anim:SetTrigger("tIn")
end

function GachaCoverCtrl_PermanentCharUp:SetCover(nId)
  local nAupMissing = PlayerData.Gacha:GetAMissTimesById(nId)
  local mapGachaData = ConfigTable.GetData("Gacha", nId)
  if mapGachaData ~= nil then
    local nMaxMissing = mapGachaData.ATypeGuaranteeTimes
    local nSum = nMaxMissing - nAupMissing
    local text = orderedFormat(ConfigTable.GetUIText("GachaCover_Guarantee_Char"), nSum)
    NovaAPI.SetTMPText(self._mapNode.TMPRemianCount, text)
  end
end

function GachaCoverCtrl_PermanentCharUp:EnableCover()
end

function GachaCoverCtrl_PermanentCharUp:DisableCover()
end

return GachaCoverCtrl_PermanentCharUp
