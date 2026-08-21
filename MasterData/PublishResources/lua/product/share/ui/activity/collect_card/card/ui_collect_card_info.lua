_class("UICollectCardInfo", UIController)
UICollectCardInfo = UICollectCardInfo

function UICollectCardInfo:OnShow(uiParam)
  self._cfg = uiParam[1]
  self._haveCount = uiParam[2]
  self._cardComInfo = uiParam[3]
  self._selectID = nil
  self:GetComponents()
  self:OnValue()
end

function UICollectCardInfo:GetComponents()
  self._iconGo = self:GetGameObject("IconGo")
  self._iconMask = self:GetGameObject("IconMask")
  self._icon = self:GetUIComponent("RawImageLoader", "icontmp")
  self._iconRawImage = self:GetUIComponent("RawImage", "icontmp")
  local iconNewGo = self:GetGameObject("Icon")
  local iconOldGo = self:GetGameObject("Icon (1)")
  self._animName1 = "uieff_UICollectCardInfo_Switch01"
  self._animName2 = "uieff_UICollectCardInfo_Switch02"
  self._iconNewTr = iconNewGo.transform
  self._iconOldTr = iconOldGo.transform
  self._iconNew = iconNewGo:GetComponent(typeof(UnityEngine.MeshRenderer))
  self._iconOld = iconOldGo:GetComponent(typeof(UnityEngine.MeshRenderer))
  self._number = self:GetUIComponent("UILocalizationText", "Number")
  self._nameTex = self:GetUIComponent("UILocalizationText", "NameTex")
  self._specialBg = self:GetGameObject("SpecialBg")
  self._normalBg = self:GetGameObject("NormalBg")
  self._pool = self:GetUIComponent("UISelectObjectPath", "Pool")
  self._shareGo = self:GetGameObject("ShareGo")
  self._qqGo = self:GetGameObject("qq")
  self._wxGo = self:GetGameObject("wx")
  self._anim = self:GetUIComponent("Animation", "IconGo")
  local btns = self:GetUIComponent("UISelectObjectPath", "topbtn")
  local backBtn = btns:SpawnObject("UINewCommonTopButton")
  backBtn:SetData(function()
    self:CloseDialog()
  end)
end

function UICollectCardInfo:OnValue()
  self:SetPool()
  self:SetNumber()
  self:SetShareBtn()
  self:SetIcon()
  self:Select()
end

function UICollectCardInfo:SetNumber()
  local cardList = self._cfg.CardList
  self._number:SetText(self._haveCount .. "/" .. #cardList)
  self._nameTex:SetText(StringTable.Get(self._cfg.Name))
end

function UICollectCardInfo:GetCardCount(cardid)
  local count = self._cardComInfo.card[cardid]
  count = count or 0
  return count
end

function UICollectCardInfo:SortList(list)
  local sortList = {}
  for key, value in pairs(list) do
    table.insert(sortList, value)
  end
  table.sort(sortList, function(a, b)
    local cfg_a = Cfg.cfg_component_collect_card[a]
    local cfg_b = Cfg.cfg_component_collect_card[b]
    if cfg_a.Type == cfg_b.Type then
      return a < b
    else
      return cfg_a.Type == 1
    end
  end)
  return sortList
end

function UICollectCardInfo:SetPool()
  local cardList = self._cfg.CardList
  local sortList = self:SortList(cardList)
  self._pool:SpawnObjects("UICollectCardInfoItem", #sortList)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #sortList do
    local item = pools[i]
    local card = sortList[i]
    local count = self:GetCardCount(card)
    item:SetData(card, function(id)
      self:OnCardItemClick(id)
    end, count)
  end
  self._selectID = sortList[1]
  self._selectCount = self:GetCardCount(self._selectID)
end

function UICollectCardInfo:Select()
  local cardList = self._cfg.CardList
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #cardList do
    local item = pools[i]
    item:Select(self._selectID)
  end
  self:SetShareBtn()
end

function UICollectCardInfo:OnCardItemClick(id, count)
  if self._selectID == id then
    return
  end
  self._selectID = id
  self._selectCount = self:GetCardCount(self._selectID)
  self:SetIcon()
  self:Select()
end

function UICollectCardInfo:SetIcon()
  self._iconGo:SetActive(self._selectID ~= nil)
  if self._selectID then
    local cfg = Cfg.cfg_component_collect_card[self._selectID]
    if self._newMatObj then
      self._newMatObj = self._newMatObj
    end
    self._newMatObj = self:GetAsset(cfg.IconBig .. ".mat", LoadType.Mat)
    self._specialBg:SetActive(cfg.Type == 2)
    self._normalBg:SetActive(cfg.Type == 1)
  end
  self._iconMask:SetActive(self._selectCount == 0)
  local tmpMainTex = self._iconRawImage.material:GetTexture("_MainTex")
  self._mainTexNew = tmpMainTex
  if self._oldID then
    self._iconNewTr:SetAsFirstSibling()
    local tmp = self._iconNew
    self._iconNew = self._iconOld
    self._iconOld = tmp
    local tmp2 = self._iconNewTr
    self._iconNewTr = self._iconOldTr
    self._iconOldTr = tmp2
    local tmp3 = self._animName2
    self._animName2 = self._animName1
    self._animName1 = tmp3
    local animName = self._animName2
    self._anim:Stop()
    self._anim:Play(animName)
  else
    self._oldID = true
  end
  local MatNew = self._newMatObj:GetTexture("_MainTex")
  self._iconNew.material:SetTexture("_MainTex", MatNew)
  if self._oldMatObj then
    local MatOld = self._oldMatObj:GetTexture("_MainTex")
    self._iconOld.material:SetTexture("_MainTex", MatOld)
  end
end

function UICollectCardInfo:OnHide()
end

function UICollectCardInfo:SetShareBtn()
  local cfg = Cfg.cfg_component_collect_card[self._selectID]
  local cardType = cfg.Type
  self._shareGo:SetActive(self:IsInland() and self._selectCount == 0 and cardType == 1)
  if self:IsInland() and self._selectCount == 0 and cardType == 1 then
    local info = GameGlobal.GameLogic().ClientInfo
    local source = info.m_login_source
    self._qqGo:SetActive(source ~= MobileClientLoginChannel.MCLC_WX)
    self._wxGo:SetActive(source == MobileClientLoginChannel.MCLC_WX)
  end
end

function UICollectCardInfo:BtnOnClick(go)
  self:ShowDialog("UICollectCardShare", self._selectID)
end

function UICollectCardInfo:IsInland()
  if IsInland then
    return true
  end
  return false
end
