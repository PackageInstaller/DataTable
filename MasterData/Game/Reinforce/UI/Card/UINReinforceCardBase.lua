local base = UIBaseNode
local UINReinforceCardBase = class("UINReinforceCardBase", base)
local UINRfCdTagItem = require("Game.Reinforce.UI.Card.Item.UINRfCdTagItem")
local UINRfCdRoomItem = require("Game.Reinforce.UI.Card.Item.UINRfCdRoomItem")
local eReinforce = require("Game.Reinforce.Enum.eReinforce")
local ReinforceUtil = require("Game.Reinforce.Util.ReinforceUtil")
local SkinEnum = require("Game.Skin.SkinEnum")

function UINReinforceCardBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINReinforceCardBase:InitRfCardBase(rfCardData, resloader, isFmt)
  self._rfCardData = rfCardData
  self._resloader = resloader
  self._isFmt = isFmt
  self:_Reset()
  if rfCardData:GetRfCdType() == eReinforce.eRfCardType.System then
    self:InitRfCDBaseSystem()
  elseif isFmt then
    self:InitRfCDBaseFacFmt()
  else
    self:InitRfCDBaseFac()
  end
end

function UINReinforceCardBase:_Reset()
  if self._rfCardData:GetRfCdType() == eReinforce.eRfCardType.Factor then
    self.ui.factorCard:SetActive(false)
    self.ui.factorCardFmt:SetActive(false)
  end
end

function UINReinforceCardBase:InitRfCDBaseSystem()
  self.ui.tex_Name.text = self._rfCardData:GetRfCdSysName()
  self._tagItemPool = self._tagItemPool or UIItemPool.New(UINRfCdTagItem, self.ui.tagItem, false)
  local labelIdList = self._rfCardData:GetRfCardLabelIdList()
  self._tagItemPool:HideAll()
  for k, labelId in ipairs(labelIdList) do
    local tagItem = self._tagItemPool:GetOne()
    tagItem:InitRfCdTagItem(labelId)
  end
  self:LoadRfCdBg(self.ui.Img_BgPic)
  self:InitRfCdRoomSys()
end

function UINReinforceCardBase:LoadRfCdBg(rawImg)
  local path = self._rfCardData:GetRfCardBgPath()
  rawImg.enabled = false
  self._resloader:LoadABAssetAsync(PathConsts:GetReinforceCardBgPath(path), function(texture)
    if IsNull(texture) then
      return
    end
    rawImg.texture = texture
    rawImg.enabled = true
  end)
end

function UINReinforceCardBase:InitRfCdRoomSys()
  self._roomItemPool = self._roomItemPool or UIItemPool.New(UINRfCdRoomItem, self.ui.sysRoomItem, false)
  self._roomItemPool:HideAll()
  local curRoomList = self._rfCardData:GetRfCdRoomGroup()
  local maxRoomList = self._rfCardData:GetRfCdRoomGroupMax()
  self._ClickRoomFunc = self._ClickRoomFunc or BindCallback(self, self._OnClickRoom)
  for i = 1, 2 do
    local roomId = maxRoomList[i]
    local roomItem = self._roomItemPool:GetOne()
    if roomId == nil then
      roomItem:SetRfCdRoomItemEmpty(true)
    else
      local isLock = curRoomList[i] == nil
      roomItem:InitRfCdRoomItem(i, roomId, self._resloader, isLock, self._ClickRoomFunc)
    end
  end
end

function UINReinforceCardBase:_OnClickRoom(roomIdx)
  local curStar = self._rfCardData:GetRfCardStar()
  local unlockStar = self._rfCardData:GetRfCdRoomUnlockStar(roomIdx)
  if curStar < unlockStar then
    CS.MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(59001), unlockStar))
  end
end

function UINReinforceCardBase:InitRfCDBaseFac()
  self.ui.factorCard:SetActive(true)
  self:_UpdOrder()
  self:LoadRfCdBg(self.ui.img_FactorPic)
  self:InitRfCdRoomFac()
end

function UINReinforceCardBase:InitRfCdRoomFac()
  self._roomItemPool = self._roomItemPool or UIItemPool.New(UINRfCdRoomItem, self.ui.roomItemFac, false)
  self._roomItemPool:HideAll()
  local curRoomList = self._rfCardData:GetRfCdRoomGroup()
  for i = 1, 2 do
    local roomId = curRoomList[i]
    local roomItem = self._roomItemPool:GetOne()
    if roomId == nil then
      roomItem:SetRfCdRoomItemEmpty(true)
    else
      roomItem:InitRfCdRoomItem(i, roomId, self._resloader)
    end
  end
end

function UINReinforceCardBase:_UpdOrder()
  local order = self._rfCardData:GetRfCdFactorOrder()
  if order == nil then
    self.ui.tex_OrderFactor.transform.parent.gameObject:SetActive(false)
  else
    local orderStr = ReinforceUtil.GetRfCdCactorOrderStr(order)
    self.ui.tex_OrderFactor.text = orderStr
  end
end

function UINReinforceCardBase:InitRfCDBaseFacFmt()
  self.ui.factorCardFmt:SetActive(true)
  self:_UpdOrder()
  local bonus = self._rfCardData:GetRfCdFacFmtInfiniteCoe()
  self.ui.tex_FmtBonus:SetIndex(0, tostring(bonus))
  self.ui.tex_FmtScore.text = tostring(self._rfCardData:GetRfCdFacFmtScore())
  local heroId, skinId = self._rfCardData:GetRfCdFacLeaderSkinId()
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resCfg = skinCtr:GetResModel(heroId, skinId)
  if resCfg == nil then
    warn("can't get resCfg by heroId" .. tostring(heroId) .. " skinId:" .. tostring(skinId))
    return
  end
  self.ui.img_HeroPic.enabled = false
  local path = PathConsts:GetCharacterPicPath(resCfg.src_id_model or resCfg.res_Name, SkinEnum.fromWhere.reinforceCard)
  self._resloader:LoadABAssetAsync(path, function(texture)
    if texture == nil then
      return
    end
    self.ui.img_HeroPic.texture = texture
    self.ui.img_HeroPic.enabled = true
  end)
end

function UINReinforceCardBase:OnDelete()
  if self._tagItemPool then
    self._tagItemPool:DeleteAll()
  end
  if self._roomItemPool then
    self._roomItemPool:DeleteAll()
  end
  base.OnDelete(self)
end

return UINReinforceCardBase
