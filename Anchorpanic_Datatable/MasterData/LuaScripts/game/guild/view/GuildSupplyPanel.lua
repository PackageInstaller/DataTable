--[[ 
-----------------------------------------------------
@filename       : GuildSupplyPanel
@Description    : 联盟补给界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]] module("guild.GuildSupplyPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildSupplyPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    self:setTxtTitle(_TT(94535))
end

-- 适应全面屏，刘海缩进
function setAdapta(self)

end

function initData(self)
    self.awardList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")

    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mImgProps = self:getChildGO("mImgProps"):GetComponent(ty.AutoRefImage)
    self.mTxtPropsCount = self:getChildGO("mTxtPropsCount"):GetComponent(ty.Text)

    self.mBtnOpen = self:getChildGO("mBtnOpen")
    self.mBtnGet = self:getChildGO("mBtnGet")
end

function initViewText(self)
    self:getChildTrans("mTxtSupply"):GetComponent(ty.Text).text = _TT(94536)
    
    -- self.mScoreTitle.text = _TT(44657) --"EMAIL LIST"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
    self:addUIEvent(self.mBtnOpen, self.onOpenClick)
    self:addUIEvent(self.mBtnGet, self.onGetClick)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.GUILD_TID, MoneyTid.GUILD_FUND_TID })
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_SUPPLY_PANEL, self.showPanel, self)
    GameDispatcher:addEventListener(EventName.FIVE_RESET, self.close, self)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_SUPPLY_PANEL, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.FIVE_RESET, self.close, self)
    self:clearPropsList()
end

function onOpenClick(self)
    if self.isLeader then
        local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.GUILD_FUND_TID, self.localData.supplyCost, true, true)
        if tips == "" and result == true then
            GameDispatcher:dispatchEvent(EventName.REQ_OPEN_SUPPLY_AWARD)
        else
            gs.Message.Show(tips)
        end
    else
        gs.Message.Show(_TT(94529))
    end
end

function onGetClick(self)
    if self.isPass == false then
        GameDispatcher:dispatchEvent(EventName.REQ_GAIN_SUPPLY_AWARD)
    else
        gs.Message.Show("已领取")
    end
end

function showPanel(self)
    self.isLeader = guild.GuildManager:getSelfIsGuildLeader() or guild.GuildManager:getSelfIsChairman()
    self.guildInfo = guild.GuildManager:getGuildInfo()
    if self.guildInfo.is_open_supply == 0 then
        self.mBtnOpen:SetActive(true)
        self.mBtnGet:SetActive(false)
    else
        self.mBtnOpen:SetActive(false)
        self.mBtnGet:SetActive(true)
    end

    self.awardInfo = guild.GuildManager:getAwardPanelInfo()
    self.localData = guild.GuildManager:getGuildData(self.guildInfo.award_lv)
    self.isPass = self.awardInfo.gained_supply == 1
    self.mBtnGet:GetComponent(ty.Button).interactable = not self.isPass
    self:clearPropsList()
    local tempList = AwardPackManager:getAwardListById(self.localData.supplyAward)
    for i = 1, #tempList do
        local vo = tempList[i]
        local propsItem = PropsGrid:create(self.mAwardContent, {vo.tid, vo.num}, 0.8, false)
        propsItem:setHasRec(self.isPass)
        table.insert(self.awardList, propsItem)
    end
    self.mImgProps:SetImg(MoneyUtil.getMoneyIconUrlByType(MoneyTid.GUILD_FUND_TID))
    self.mTxtPropsCount.text = self.localData.supplyCost

    local hasCount = MoneyUtil.getMoneyCountByTid(MoneyTid.GUILD_FUND_TID)
    if hasCount >= self.localData.supplyCost then
        self.mTxtPropsCount.color = gs.ColorUtil.GetColor("000000ff")
    else
        self.mTxtPropsCount.color = gs.ColorUtil.GetColor("f94234ff")
    end
end

function clearPropsList(self)
    for i = 1, #self.awardList do
        self.awardList[i]:poolRecover()
    end
    self.awardList = {}
end

return _M
