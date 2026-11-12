local VampireLevelSelect_talent_iconGridCtrl = class("VampireLevelSelect_talent_iconGridCtrl", BaseCtrl)
VampireLevelSelect_talent_iconGridCtrl._mapNodeConfig = {
  Node = {
    sNodeName = "imgTalentBg_",
    nCount = 3
  },
  anim = {
    sNodeName = "imgTalentBg_1",
    sComponentName = "Animator"
  },
  Icon = {
    sComponentName = "Image",
    sNodeName = "imgCurTalentIcon_",
    nCount = 3
  },
  imgSelect = {}
}
VampireLevelSelect_talent_iconGridCtrl._mapEventConfig = {}
VampireLevelSelect_talent_iconGridCtrl._mapRedDotConfig = {}

function VampireLevelSelect_talent_iconGridCtrl:SetTalent(nId)
  self.nTalentId = nId
  local mapTalent = ConfigTable.GetData("VampireTalent", nId)
  if mapTalent ~= nil then
    self:SetPngSprite(self._mapNode.Icon[1], mapTalent.Icon)
    self:SetPngSprite(self._mapNode.Icon[2], mapTalent.Icon)
    self:SetPngSprite(self._mapNode.Icon[3], mapTalent.Icon)
  end
end

function VampireLevelSelect_talent_iconGridCtrl:SetState(nState)
  self._mapNode.Node[1]:SetActive(nState == 1)
  self._mapNode.Node[2]:SetActive(nState == 2)
  self._mapNode.Node[3]:SetActive(nState == 3)
end

function VampireLevelSelect_talent_iconGridCtrl:SetSelect(bSelect)
  self._mapNode.imgSelect:SetActive(bSelect)
end

function VampireLevelSelect_talent_iconGridCtrl:PlayActiveAnim()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    self._mapNode.anim:Play("VampireTalentBg_in")
  end
  
  cs_coroutine.start(wait)
end

return VampireLevelSelect_talent_iconGridCtrl
