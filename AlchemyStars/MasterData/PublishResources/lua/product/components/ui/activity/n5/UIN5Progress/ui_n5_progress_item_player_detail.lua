_class("UIN5ProgressItemPlayerDetail", UIN5ProgressItem)
UIN5ProgressItemPlayerDetail = UIN5ProgressItemPlayerDetail

function UIN5ProgressItemPlayerDetail:Constructor()
end

function UIN5ProgressItemPlayerDetail:_FillRewardArea()
end

function UIN5ProgressItemPlayerDetail:_FillInfoArea()
  local curCfg = Cfg.cfg_activity_person_progress_ui[self._cmptCfgId]
  if curCfg and self.atlas then
    local bShowDetail = false
    do
      local titleStr = curCfg.RankTitle
      local rankIndex = self._itemInfo.rank
      if rankIndex then
        if self._rankTitleText1 then
          self._rankTitleText1:SetText(StringTable.Get(titleStr, rankIndex))
        end
        if self._rankTitleText2 then
          self._rankTitleText2:SetText(StringTable.Get(titleStr, rankIndex))
        end
      end
    end
    if self._playerNameText then
      local oriStr = GameGlobal.GetModule(RoleModule):GetName()
      if not string.isnullorempty(oriStr) then
        self._playerNameText:RefreshText(oriStr)
      end
    end
    if self._playerTitleText then
      local oriStr = curCfg.PlayerTitle
      if not string.isnullorempty(oriStr) then
        self._playerTitleText:SetText(StringTable.Get(oriStr))
      end
    end
    if self._rewardBgImg then
      local cardImgCfg = {}
      local cardImgDefaultCfg
      local cardImgVec = curCfg.CardImg
      if cardImgVec then
        for index, value in ipairs(cardImgVec) do
          local cfgStr = value
          local rank, res
          local params = string.split(cfgStr, ",")
          if #params == 2 then
            rank = tonumber(params[1])
            res = params[2]
            cardImgCfg[rank] = res
          end
        end
      end
      cardImgDefaultCfg = curCfg.CardImgDefault
      local rank = self._itemInfo.rank
      local bgRes = cardImgDefaultCfg
      if cardImgCfg[rank] then
        bgRes = cardImgCfg[rank]
      end
      if not string.isnullorempty(bgRes) then
        self._rewardBgImg.sprite = self.atlas:GetSprite(bgRes)
      end
    end
    if self._rankInfoText then
      local detailStr = curCfg.DetailInfo
      if string.isnullorempty(detailStr) then
      else
        self._rankInfoText:SetText(StringTable.Get(detailStr))
        local height = self._rankInfoText.preferredHeight
        if 120 < height then
          self._openDetailAreaGo:SetActive(true)
        end
        bShowDetail = true
      end
    end
    self._detailArea:SetActive(bShowDetail)
  end
end

function UIN5ProgressItemPlayerDetail:_SetUIByRank()
  local rankInfoStyleCfg = {}
  local rankInfoStyleDefaultCfg
  local curCfg = Cfg.cfg_activity_person_progress_ui[self._cmptCfgId]
  if curCfg then
    local rankInfoStyleVec = curCfg.RankInfoStyle
    if rankInfoStyleVec then
      for index, value in ipairs(rankInfoStyleVec) do
        local cfgStr = value
        local rank, res
        local params = string.split(cfgStr, ",")
        if #params == 2 then
          rank = tonumber(params[1])
          res = tonumber(params[2])
          rankInfoStyleCfg[rank] = res
        end
      end
    end
    rankInfoStyleDefaultCfg = tonumber(curCfg.RankInfoStyleDefault)
  end
  local cellType = self._itemInfo.cellType
  local rank = self._itemInfo.rank
  local rankStyle = rankInfoStyleDefaultCfg
  if rankInfoStyleCfg[rank] then
    rankStyle = rankInfoStyleCfg[rank]
  end
  if self._rankInfoAreaGo1 then
    self._rankInfoAreaGo1:SetActive(rankStyle == 1)
  end
  if self._rankInfoAreaGo2 then
    self._rankInfoAreaGo2:SetActive(rankStyle == 2)
  end
end
