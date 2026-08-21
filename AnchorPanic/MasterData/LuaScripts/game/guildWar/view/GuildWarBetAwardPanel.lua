

module("guildWar.GuildWarBetAwardPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarBetAwardPanel.prefab")
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end

-- 初始化数据
function initData(self)
    self.mPropsList = {}
end

function configUI(self)
    super.configUI(self)
    self.mTxtResult = self:getChildGO("mTxtResult"):GetComponent(ty.Text)
    self.mTxtAwardTips = self:getChildGO("mTxtAwardTips"):GetComponent(ty.Text)
    self.mTxtNext = self:getChildGO("mTxtNext"):GetComponent(ty.Text)
    self.mTxtInfo1 = self:getChildGO("mTxtInfo1"):GetComponent(ty.Text)
    self.mTxtInfo2 = self:getChildGO("mTxtInfo2"):GetComponent(ty.Text)

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon1 = self:getChildGO("mImgIcon1"):GetComponent(ty.AutoRefImage)
    self.mTxtName1 = self:getChildGO("mTxtName1"):GetComponent(ty.Text)
    self.mTxtLv1 = self:getChildGO("mTxtLv1"):GetComponent(ty.Text)
    self.mImgIcon2 = self:getChildGO("mImgIcon2"):GetComponent(ty.AutoRefImage)
    self.mTxtName2 = self:getChildGO("mTxtName2"):GetComponent(ty.Text)
    self.mTxtLv2 = self:getChildGO("mTxtLv2"):GetComponent(ty.Text)
    self.mAwardContent = self:getChildGO("mAwardContent"):GetComponent(ty.Transform)

    self.mImgWin1 = self:getChildGO("mImgWin1")
    self.mImgWin2 = self:getChildGO("mImgWin2")

    self.mBtnRet = self:getChildGO("mBtnRet")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRet, self.close)
end

function initViewText(self)
    self.mTxtNext.text = _TT(8)
end

function active(self, args)
    super.active(self, args)
    self:showPanel()
end


function deActive(self)
    super.deActive(self)
     self:clearPropsList()
end

function showPanel(self)
    local awardBetResult, awardGroupId, awardDay, betUid = guildWar.GuildWarManager:getGuildWarBetAwardData()
    local url = ""
    if awardBetResult == 1 then
        self.mTxtResult.text = _TT(149259)
        self.mTxtInfo1.text = _TT(149261)
        self.mTxtAwardTips.text = _TT(149242)
      
        url = UrlManager:getPackPath("guildWar/award_type1.png")
    elseif awardBetResult == 2 then
        self.mTxtResult.text = _TT(149258)
        self.mTxtInfo1.text = _TT(149262)
        self.mTxtAwardTips.text = _TT(149243)
        url = UrlManager:getPackPath("guildWar/award_type2.png")
    elseif awardBetResult == 3 then
        self.mTxtResult.text = _TT(149260) 
        self.mTxtInfo1.text = _TT(149263)
        self.mTxtAwardTips.text = _TT(149264)
        url = UrlManager:getPackPath("guildWar/award_type3.png")
    end
  self.mTxtInfo2.text = _TT(149265)
    self.mImgBg:SetImg(url,false)
    local firstGroup = guildWar.GuildWarManager:getFirstDayGroup()
    local winGroup = guildWar.GuildWarManager:getWinGroup()
    local loseGroup = guildWar.GuildWarManager:getLoseGroup()
    for i = 1, #loseGroup, 1 do
        table.insert(winGroup, loseGroup[i])
    end

    for i = 1, #firstGroup, 1 do
        table.insert(winGroup, firstGroup[i])
    end

    local awardBetInfo = nil
    for i = 1,#winGroup do
        if winGroup[i].group_id == awardGroupId then
            awardBetInfo = winGroup[i]
        end
    end

    local iconUrl = guild.GuildManager:getIconDataById(awardBetInfo.team_1_icon).icon
    self.mImgIcon1:SetImg(UrlManager:getIconPath(iconUrl),false)
    self.mTxtName1.text = awardBetInfo.team_1_name
    self.mTxtLv1.text = _TT(1361)..awardBetInfo.team_1_lv

    local iconUrl2 = guild.GuildManager:getIconDataById(awardBetInfo.team_2_icon).icon
    self.mImgIcon2:SetImg(UrlManager:getIconPath(iconUrl2),false)
    self.mTxtName2.text = awardBetInfo.team_2_name
    self.mTxtLv2.text = _TT(1361)..awardBetInfo.team_2_lv

    local selectBet = 0
  
    local winIndex = 0
    for i = 1,#winGroup do
        if winGroup[i].group_id == awardGroupId then
            if winGroup[i].team_1 == winGroup[i].win_uid then
                winIndex = 1
            else
                winIndex = 2
            end
        end
    end

    self.mImgWin1:SetActive(winIndex == 1)
    self.mImgWin2:SetActive(winIndex == 2)

    local day =  guildWar.GuildWarManager:getGuildWarTopSelectDay()
    local awardVo = guildWar.GuildWarManager:getGuildAwardBetAward(day)
    local award
    if awardBetResult == 1 then
        award = awardVo.successAward
    elseif awardBetResult == 2 then
        award = awardVo.failAward
    elseif awardBetResult == 3 then
        award = awardVo.joinAward
    end
    self:clearPropsList()
    for i = 1,#award do
        local propGrid = PropsGrid:createByData({ tid = award[i][1], num = award[i][2], parent =self.mAwardContent, scale = 0.7, showUseInTip = true })
        table.insert(self.mPropsList, propGrid)
    end

end

function clearPropsList(self)

    for i = 1, #self.mPropsList, 1 do
        self.mPropsList[i]:poolRecover()
    end
    self.mPropsList = {}
end


return _M