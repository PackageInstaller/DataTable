local GachaCoverCtrl_NewBie = class("GachaCoverCtrl_NewBie", BaseCtrl)
GachaCoverCtrl_NewBie._mapNodeConfig = {
  root = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Transform"
  },
  imgRateUpPanel = {},
  TMPSummonText = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieSummonNum"
  },
  TMPSummonTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieSummonTip"
  }
}
GachaCoverCtrl_NewBie._mapEventConfig = {}

function GachaCoverCtrl_NewBie:Awake()
end

function GachaCoverCtrl_NewBie:FadeIn()
end

function GachaCoverCtrl_NewBie:FadeOut()
end

function GachaCoverCtrl_NewBie:OnEnable()
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

function GachaCoverCtrl_NewBie:OnDisable()
end

function GachaCoverCtrl_NewBie:OnDestroy()
end

function GachaCoverCtrl_NewBie:OnRelease()
end

function GachaCoverCtrl_NewBie:PlayInAnim()
  local anim = self.gameObject.transform:GetComponent("Animator")
  anim:SetTrigger("tIn")
end

function GachaCoverCtrl_NewBie:SetCover(nId)
  local newbie = ConfigTable.GetData("GachaNewbie", nId)
  if newbie == nil then
    return
  end
  local newbieData = PlayerData.Gacha:GetGachaNewbieData(nId)
  if newbieData == nil then
    return
  end
  local nTotalCount = newbie.SpinCount
  local remainCount = nTotalCount - newbieData.Times
  NovaAPI.SetTMPText(self._mapNode.TMPSummonText, orderedFormat(ConfigTable.GetUIText("Gacha_NewBieSummonNum"), remainCount))
  NovaAPI.SetTMPText(self._mapNode.TMPSummonTip, orderedFormat(ConfigTable.GetUIText("Gacha_NewBieSummonTip"), nTotalCount, 1))
end

function GachaCoverCtrl_NewBie:EnableCover()
end

function GachaCoverCtrl_NewBie:DisableCover()
end

return GachaCoverCtrl_NewBie
