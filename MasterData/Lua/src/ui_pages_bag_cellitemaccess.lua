local this = class("cellItemAccess", G_UIModuleBase)

function this.bind()
  return {
    txt_access = "",
    go_arrow = false,
    go_lock = false,
    alpha_content = 1,
    activeBg = nil,
    color_arrow = nil,
    color_unlock = nil,
    activeLockBg = nil,
    color_location = C_Color(0.31, 0.321, 0.365, 0.5),
    color_txt = C_Color(0.31, 0.321, 0.365, 1)
  }
end

function this:open(options)
  if L_DeviceTpl:getIsMobile() then
    self.bindComponents.txt_name_fontsize.fontSize = 24.5
  else
    self.bindComponents.txt_name_fontsize.fontSize = 22
  end
end

function this.methods()
  return {
    onClick = function(self)
      if C_KiBoDuelLuaWrapper:IsInKiBoDuel() then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_common_cannot_trans"))
        return
      end
      if L_UI:checkPageShown("pageNestcoopShop", true) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_common_cannot_trans"))
        return
      end
      local optionInfo = {
        itemId = self.bind.itemId,
        parentId = self.bind.parentId,
        fromBuildId = self.bind.fromBuildId,
        parentPageGuid = self.bind.parentPageGuid,
        itemNum = self.bind.itemNum
      }
      local canJump = L_JumpMgr:jumpTo(self.bind.systemId, optionInfo)
      if canJump then
        local _jumpTpl2 = L_GameTpl:getCommonJumpTpl()
        local jumpCfg2 = _jumpTpl2:getTplById(self.bind.systemId)
        local pageName = jumpCfg2 and jumpCfg2.page or ""
        if pageName ~= "" then
          AzurWorld.StatisticPointMgr:DispatchMainPage2(pageName, 4, tostring(self.bind.itemId or 0) .. "," .. tostring(self.bind.systemId))
        end
        if canJump and not L_GameUtil.getIsUseUseGiftType(self.bind.systemId) then
          local closePages = {
            "PageTipElement",
            "pageInfoTip",
            "pageReward",
            "pageExplore",
            "pageHeroTalentInfo",
            "pageRuneCompose",
            "pageAccessoryInfoTipLarge",
            "pagePetCatalogReward"
          }
          for _, page in ipairs(closePages) do
            if page ~= pageName then
              L_UI:close(page)
            end
          end
        end
      end
    end
  }
end

function this:initData()
  if not self.colorType then
    self.colorType = {
      light = C_Color(1, 1, 1, 0.7),
      dark = C_Color(0, 0, 0, 0.5)
    }
    self.styleTypeEnum = {Normal = 1, Roulette = 2}
  end
  self.styleType = self.bind.styleType or self.styleTypeEnum.Normal
end

function this:refresh()
  self:initData()
  local isOpen = false
  local hasSystemId = not math.isEmpty(self.bind.systemId)
  if hasSystemId then
    isOpen = L_JumpMgr:checkJumpFuncOpen(self.bind.systemId)
    self.bind.go_lock = not isOpen
    self.bind.go_arrow = isOpen
    local str = self.bind.txt_access or ""
    if str == "" then
      local _jumpTpl = L_GameTpl:getCommonJumpTpl()
      local jumpCfg = _jumpTpl:getTplById(self.bind.systemId)
      if _jumpTpl:getType(jumpCfg) == L_Const.commonJumpType.DungeonEntrust then
        local param = _jumpTpl:getParam(jumpCfg)
        local toId = param[3] and param[3] or param[1]
        if param and toId then
          local dungeonTpl = L_GameTpl:getDungeonEntrustTpl()
          local id = tonumber(toId)
          local tpl = dungeonTpl:getTplById(id)
          str = L_WordsTpl:getValue("ui_commonjump_entrust", {
            [0] = dungeonTpl:getName(tpl)
          })
        else
          str = L_Config:provider(jumpCfg.desc)
        end
      end
      self.bind.txt_access = str
    end
    if self.styleType == self.styleTypeEnum.Normal then
    elseif self.styleType == self.styleTypeEnum.Roulette then
      local color = isOpen and self.colorType.light or self.colorType.dark
      if color then
        self.bindComponents.img_arrow.color = color
        self.bindComponents.img_lock.color = color
        self.bindComponents.img_location.color = color
      end
      if not isOpen then
        self.bind.txt_access = L_GameUtil.fillColor(self.bind.txt_access, "#000000")
      end
      self.bind.alpha_content = isOpen and 1 or 0.7
      self:showLockBg(not isOpen)
    end
  else
    self.bind.go_lock = false
    self.bind.go_arrow = false
  end
  if hasSystemId and not isOpen then
    self.bind.color_location = C_Color(0.31, 0.321, 0.365, 0.2)
    self.bind.color_txt = C_Color(0.31, 0.321, 0.365, 0.5)
  else
    self.bind.color_location = C_Color(0.31, 0.321, 0.365, 0.5)
    self.bind.color_txt = C_Color(0.31, 0.321, 0.365, 1)
  end
end

function this:setDataContent(data)
  self.bind.itemId = data.itemId or self.bind.itemId
  self.bind.systemId = data.systemId or self.bind.systemId
  self.bind.txt_access = data.txt_access or self.bind.txt_access
  self:refresh()
end

function this:showLockBg(isShow)
  isShow = L_CommonUtil.toBoolean(isShow)
  self.bind.activeLockBg = isShow
  self.bind.activeBg = not isShow
end

return this
