local base = UIBaseWindow
local UIEpTalkDialog = class("UIEpTalkDialog", base)
local PlayType = {autoPlay = 1, clickPlay = 2}
local cs_ResLoader = CS.ResLoader

function UIEpTalkDialog:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_backGround, self, self.__OnClickNext)
  self.resLoader = cs_ResLoader.Create()
  self._onCloseClick = BindCallback(self, self._OnCloseClick)
  MsgCenter:AddListener(eMsgEventId.OnRoomSelected, self._onCloseClick)
end

function UIEpTalkDialog:StartEpTalkDialog(epTalkCfg, stopWaitCallback)
  self.epTalkCfg = epTalkCfg
  self.stopWaitCallback = stopWaitCallback
  self.__curIndex = 0
  local firstLine = self.epTalkCfg[1]
  local ui_frame = firstLine.ui_frame
  self.__play_type = firstLine.play_type
  if self.__play_type == PlayType.autoPlay then
    self:__StopWait()
    self:__PlayNext()
    self.ui.btn_backGround.gameObject:SetActive(false)
  elseif self.__play_type == PlayType.clickPlay then
    self:__PlayNext()
    self.ui.btn_backGround.gameObject:SetActive(true)
  else
    error("unknow ep talk tip playType, ep_tip id:" .. tostring(epTalkCfg.id))
  end
end

function UIEpTalkDialog:StartTalkDialogInBattle(epTalkCfg, pauseCallback, continueCallback)
  self.epTalkCfg = epTalkCfg
  self.__curIndex = 0
  local firstLine = self.epTalkCfg[1]
  local ui_frame = firstLine.ui_frame
  self.__play_type = firstLine.play_type
  if self.__play_type == PlayType.autoPlay then
    self:__StopWait()
    self:__PlayNext()
    self.ui.btn_backGround.gameObject:SetActive(false)
  elseif self.__play_type == PlayType.clickPlay then
    self:__PlayNext()
    if pauseCallback ~= nil then
      pauseCallback()
    end
    self.stopWaitCallback = continueCallback
    self.ui.btn_backGround.gameObject:SetActive(true)
  else
    error("unknow ep talk tip playType, ep_tip id:" .. tostring(epTalkCfg.id))
  end
end

function UIEpTalkDialog:__PlayNext()
  self.__curIndex = self.__curIndex + 1
  if self.__curIndex <= #self.epTalkCfg then
    local tipCfg = self.epTalkCfg[self.__curIndex]
    local context = LanguageUtil.GetLocaleText(tipCfg.context)
    self.ui.tex_TalkDialog.text = context
    if tipCfg.heroId ~= nil and tipCfg.heroId ~= 0 then
      self.ui.img_TalkHeroPic.gameObject:SetActive(true)
      self.ui.img_monsterHeadImg.gameObject:SetActive(false)
      local heroCfg = ConfigData.hero_data[tipCfg.heroId]
      if heroCfg ~= nil then
        local itemCfg = ConfigData.item[heroCfg.fragment]
        self.ui.img_TalkHeroPic.sprite = CRH:GetSpriteByItemConfig(itemCfg)
        else
          if tipCfg.monsterid ~= nil and tipCfg.monsterid ~= 0 then
            self.ui.img_TalkHeroPic.gameObject:SetActive(false)
            self.ui.img_monsterHeadImg.gameObject:SetActive(true)
            local monsterCfg = ConfigData.monster[tipCfg.monsterid]
            if monsterCfg ~= nil then
              local resId = monsterCfg.src_id
              local resCfg = ConfigData.resource_model[resId]
              if resCfg ~= nil then
                local path = PathConsts:GetCharacterSmallPicPath(resCfg.res_Name)
                self.resLoader:LoadABAssetAsync(path, function(texture)
                  if texture ~= nil and not IsNull(self.gameObject) then
                    self.ui.img_monsterHeadImg.texture = texture
                  end
                end)
              end
              else
                self.ui.img_TalkHeroPic.gameObject:SetActive(true)
                self.ui.img_monsterHeadImg.gameObject:SetActive(false)
                local isGirl = PlayerDataCenter.inforData:GetSex()
                local headId
                if isGirl then
                  headId = ConstGlobalItem.ProfessorGridHead
                else
                  headId = ConstGlobalItem.ProfessorBodyHead
                end
                local cfg = ConfigData.portrait[headId]
                if cfg == nil then
                  return
                end
                local icon = cfg.icon
                if not string.IsNullOrEmpty(icon) then
                  self.ui.img_TalkHeroPic.sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
                end
              end
              local posIndex = tipCfg.info_pos
              local holder = self.ui.Holder[posIndex]
              if not IsNull(holder) then
                self.ui.talkDialogNode.transform.localPosition = holder.localPosition
              end
              if self.__play_type == PlayType.autoPlay then
                if self.__playNextTimerId ~= nil then
                  TimerManager:StopTimer(self.__playNextTimerId)
                  self.__playNextTimerId = nil
                end
                self.__playNextTimerId = TimerManager:StartTimer(tipCfg.auto_time / 1000, function()
                  self:__PlayNext()
                end, self, true)
              end
            end
        end
      end
  else
    self:__StopWait()
    self:_OnCloseClick()
  end
end

function UIEpTalkDialog:__OnClickNext()
  self:__PlayNext()
end

function UIEpTalkDialog:__StopWait()
  if self.stopWaitCallback ~= nil then
    self.stopWaitCallback()
    self.stopWaitCallback = nil
  end
end

function UIEpTalkDialog:_OnCloseClick()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEpTalkDialog:OnDelete()
  if self.__playNextTimerId ~= nil then
    TimerManager:StopTimer(self.__playNextTimerId)
    self.__playNextTimerId = nil
  end
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  base.OnDelete(self)
end

return UIEpTalkDialog
