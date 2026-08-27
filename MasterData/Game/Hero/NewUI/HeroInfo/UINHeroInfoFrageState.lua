local UINHeroInfoFrageState = class("UINHeroInfoFrageState", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local JumpManager = require("Game.Jump.JumpManager")

function UINHeroInfoFrageState:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Unlock, self, self.__OnClickUnlock)
  UIUtil.AddButtonListener(self.ui.btn_buttom, self, self.__OnClickFragDescribe)
  self.__onItemUpdate = BindCallback(self, self.__OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
end

function UINHeroInfoFrageState:RefreshFrageState(heroData, resloader)
  self.heroData = heroData
  self.ui.img_Pic.texture = resloader:LoadABAsset(PathConsts:GetCharacterPicPath(heroData:GetResPicName()))
  self:__RefreshFrageNum()
  JumpManager.couldUseItemJump = true
end

function UINHeroInfoFrageState:__RefreshFrageNum()
  local couldMerge, curFrage, mergeNeedFrage = self.heroData:GetIsCouldMerge()
  if couldMerge then
    self.ui.img_btn_Unlock.color = self.ui.color_orange
    self.ui.tex_ChipCount:SetIndex(0, tostring(curFrage), tostring(mergeNeedFrage))
  else
    self.ui.img_btn_Unlock.color = self.ui.color_gray
    self.ui.tex_ChipCount:SetIndex(1, tostring(curFrage), tostring(mergeNeedFrage))
  end
  self.couldMerge = couldMerge
end

function UINHeroInfoFrageState:__OnItemUpdate(itemUpdateDic)
  local fragId = self.heroData.fragId
  if itemUpdateDic[fragId] ~= nil then
    self:__RefreshFrageNum()
  end
end

function UINHeroInfoFrageState:__OnClickUnlock()
  if not self.couldMerge then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Frag_MergeFrageInsufficient))
    return
  end
  NetworkManager:GetNetwork(NetworkTypeID.Hero):CS_HERO_MERGE(self.heroData.fragId, function()
    UIUtil.OnClickBackByWinId(UIWindowTypeID.HeroInfomation)
    UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
      if window == nil then
        return
      end
      window:SetCustomVoiceType(eVoiceType.GAIN)
      window:InitGetHeroList({
        self.heroData.dataId
      }, true, true, {true}, function()
        local win = UIManager:GetWindow(UIWindowTypeID.HeroList)
        if win == nil then
          return nil
        end
        local heroData = PlayerDataCenter.heroDic[self.heroData.dataId]
        win:Roll2Hero(heroData.dataId)
        win:OnSelHeroItemClick(heroData)
        window:Delete()
      end, true)
    end)
  end)
end

function UINHeroInfoFrageState:__OnClickFragDescribe()
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
    if window == nil then
      return
    end
    window:InitCommonItemDetail(ConfigData.item[self.heroData.fragId])
  end)
end

function UINHeroInfoFrageState:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  JumpManager.couldUseItemJump = false
  base.OnDelete(self)
end

return UINHeroInfoFrageState
