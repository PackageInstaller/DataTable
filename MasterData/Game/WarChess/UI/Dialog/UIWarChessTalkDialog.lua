local base = UIBaseWindow
local UIWarChessTalkDialog = class("UIWarChessTalkDialog", base)
local cs_ResLoader = CS.ResLoader

function UIWarChessTalkDialog:OnInit()
  self.resLoader = cs_ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_backGround, self, self.__OnClickNext)
end

function UIWarChessTalkDialog:InitWCMiniTV(tipCfgs, playOverCallback)
  self.__tipCfgs = tipCfgs
  self.playOverCallback = playOverCallback
  self.__curPlayIndex = 0
  self:__PlayNext()
  local wcMain = UIManager:GetWindow(UIWindowTypeID.WarChessMain)
  if wcMain ~= nil then
    wcMain:WcMainFadeBttomUI(true)
  end
end

function UIWarChessTalkDialog:__PlayNext()
  self.__curPlayIndex = self.__curPlayIndex + 1
  local tipCfg = self.__tipCfgs[self.__curPlayIndex]
  if tipCfg ~= nil then
    local context = LanguageUtil.GetLocaleText(tipCfg.context)
    self.ui.tex_TalkDialog.text = context
    if tipCfg.heroId ~= nil and tipCfg.heroId ~= 0 then
      self.ui.img_TalkHeroPic.gameObject:SetActive(true)
      self.ui.img_monsterHeadImg.gameObject:SetActive(false)
      local heroCfg = ConfigData.hero_data[tipCfg.heroId]
      if heroCfg ~= nil then
        local itemCfg = ConfigData.item[heroCfg.fragment]
        self.ui.img_TalkHeroPic.sprite = CRH:GetSpriteByItemConfig(itemCfg)
      end
    elseif tipCfg.monsterid ~= nil and tipCfg.monsterid ~= 0 then
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
    if tipCfg.is_need_focus then
      local wcCtrl = WarChessManager:GetWarChessCtrl()
      local x = tipCfg.x
      local y = tipCfg.y
      local showPos = Vector3.New(x, 0, y)
      wcCtrl.wcCamCtrl:SetWcCamFollowPos(showPos)
    end
  else
    self:__PlayOver()
  end
end

function UIWarChessTalkDialog:__PlayOver()
  local wcMain = UIManager:GetWindow(UIWindowTypeID.WarChessMain)
  if wcMain ~= nil then
    wcMain:WcMainFadeBttomUI(false)
  end
  if self.playOverCallback ~= nil then
    self.playOverCallback()
  end
  self:Delete()
end

function UIWarChessTalkDialog:__OnClickNext()
  self:__PlayNext()
end

function UIWarChessTalkDialog:OnDelete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
end

return UIWarChessTalkDialog
