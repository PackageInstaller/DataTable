--[[ 
-----------------------------------------------------
@filename       : GuildPreparationPanel
@Description    : 联盟筹备界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]] module("guild.GuildPreparationPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildPreparationPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    self:setTxtTitle(_TT(94534))
end

-- 适应全面屏，刘海缩进
function setAdapta(self)

end

function initData(self)
    self.getItemList = {}

    self.mAwardItemList = {}

    self.mAwardPropsList = {}
    self.mOldPropsList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBtnClose = self:getChildGO("mBtnClose")

    self.mDefInfo = self:getChildGO("mDefInfo")
    self.mDefLayout = self:getChildTrans("mDefLayout")
    self.mBtnDefPre = self:getChildGO("mBtnDefPre")
    self.mTxtDefPropsCount = self:getChildGO("mTxtDefPropsCount"):GetComponent(ty.Text)
    self.mImgDefProps = self:getChildGO("mImgDefProps"):GetComponent(ty.AutoRefImage)

    self.mBtnDefPreGeted = self:getChildGO("mBtnDefPreGeted")

    self.mHellInfo = self:getChildGO("mHellInfo")
    self.mHellLayout = self:getChildTrans("mHellLayout")
    self.mBtnHellPre = self:getChildGO("mBtnHellPre")
    self.mTxtHellPropsCount = self:getChildGO("mTxtHellPropsCount"):GetComponent(ty.Text)
    self.mImgHellProps = self:getChildGO("mImgHellProps"):GetComponent(ty.AutoRefImage)

    self.mBtnHellPreGeted = self:getChildGO("mBtnHellPreGeted")

    self.mGetItem = self:getChildGO("mGetItem")

    self.mSlideBgRt = self:getChildGO("mSlideBg"):GetComponent(ty.RectTransform)
    self.mSliderRt = self:getChildGO("mSlider"):GetComponent(ty.RectTransform)

    self.mPreparationAwardContent = self:getChildTrans("mPreparationAwardContent")
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mTxtCountMax = self:getChildGO("mTxtCountMax"):GetComponent(ty.Text)
    self.mAwardItem = self:getChildGO("mAwardItem")

    self.mBtnCloseAward = self:getChildGO("mBtnCloseAward")
    self.mAwardTipsRT = self:getChildGO("mAwardTips"):GetComponent(ty.RectTransform)
    self.mTxtAwardInfo = self:getChildGO("mTxtAwardInfo"):GetComponent(ty.Text)
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mBtnHideAward = self:getChildGO("mBtnHideAward")

    self.mOldMask = self:getChildGO("mOldMask")
    self.mBtnOld = self:getChildGO("mBtnOld")
    self.mTxtOldInfo = self:getChildGO("mTxtOldInfo"):GetComponent(ty.Text)
    self.mOldPropsRect = self:getChildGO("mOldPropsRect"):GetComponent(ty.ScrollRect)
    self.mTxtMaskTitle = self:getChildGO("mTxtMaskTitle"):GetComponent(ty.Text)
end

function initViewText(self)
    self:getChildGO("mTxtDefPre"):GetComponent(ty.Text).text = _TT(94545)
    self:getChildGO("mTxtHellPre"):GetComponent(ty.Text).text = _TT(94546)
    self:getChildGO("mTxtPreparation"):GetComponent(ty.Text).text = _TT(94547)
    self:getChildGO("mTxtAwardDes"):GetComponent(ty.Text).text = _TT(94548)
    self:getChildGO("mTxtDef"):GetComponent(ty.Text).text = _TT(94545)
    self:getChildGO("mTxtHell"):GetComponent(ty.Text).text = _TT(94546)

    self.mTxtMaskTitle.text = _TT(108019)
    self.mTxtOldInfo.text = _TT(108020)
end

function onBtnDefPreClick(self)
    if table.indexof01(self.awardPanelInfo.today_is_prepare, 1) > 0 then
        gs.Message.Show(_TT(94531))
        return
    end

    local dic = guild.GuildManager:getGuildPrepareData()
    local defVo = dic[1]
    -- local hellVo = dic[2]

    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(defVo.prepareCost[1], defVo.prepareCost[2], true, true)
    if tips == "" and result == true then

        GameDispatcher:dispatchEvent(EventName.REQ_GUILD_PREPARE, {
            prepareType = 1
        })
    else
        gs.Message.Show(tips)
    end
end

function onBtnHellPreClick(self)

    if table.indexof01(self.awardPanelInfo.today_is_prepare, 2) > 0 then
        gs.Message.Show(_TT(94531))
        return
    end

    local dic = guild.GuildManager:getGuildPrepareData()
    local hellVo = dic[2]

    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(hellVo.prepareCost[1], hellVo.prepareCost[2], true, true)
    if tips == "" and result == true then
        GameDispatcher:dispatchEvent(EventName.REQ_GUILD_PREPARE, {
            prepareType = 2
        })
    elseif not result then
        UIFactory:alertMessge(tips, true, function()
            if MoneyUtil.getMoneyCountByType(MoneyTid.PAY_ITIANIUM_TID) > 0 and
                MoneyUtil.getMoneyCountByType(MoneyTid.PAY_ITIANIUM_TID) >= ti then
                GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW)
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
                    linkId = LinkCode.Purchase
                })
            end
            -- self:close()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
        -- gs.Message.Show(tips)
    end
end

function onHideAwardClick(self)
    self.mBtnCloseAward:SetActive(false)
end

function onOldBtnClick(self)
    GameDispatcher:dispatchEvent(EventName.REQ_GAIN_OLD_PREPARE_AWARD)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)

    self:addUIEvent(self.mBtnDefPre, self.onBtnDefPreClick)
    self:addUIEvent(self.mBtnHellPre, self.onBtnHellPreClick)

    self:addUIEvent(self.mBtnHideAward, self.onHideAwardClick)

    self:addUIEvent(self.mBtnOld, self.onOldBtnClick)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({MoneyTid.GUILD_TID, MoneyTid.GUILD_FUND_TID})
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_PREPARATION_PANEL, self.showPanel, self)
    GameDispatcher:addEventListener(EventName.FIVE_RESET, self.close, self)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_PREPARATION_PANEL, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.FIVE_RESET, self.close, self)
    self:clearGetItemList()
    self:clearAwardItemList()
    self:clearAwardProps()
    self:clearOldProps()
end

function clearOldProps(self)
    for i = 1, #self.mOldPropsList do
        self.mOldPropsList[i]:poolRecover()
    end
    self.mOldPropsList = {}
end

function showPanel(self)
    self.awardPanelInfo = guild.GuildManager:getAwardPanelInfo()
    self.mOldMask:SetActive(self.awardPanelInfo.can_gain_old_award == 1)

    self:clearOldProps()
    if self.awardPanelInfo.can_gain_old_award == 1 then
        local awardDic = {}
        for i = 1, #self.awardPanelInfo.can_gained_old_prepare_award_list do
            local vo = guild.GuildManager:getGuildAwardDataById(self.awardPanelInfo.can_gained_old_prepare_award_list[i])
            for j = 1, #vo.award do
                local vo = vo.award[j]
                if awardDic[vo[1]] == nil then
                    awardDic[vo[1]] = vo[2]
                else
                    awardDic[vo[1]] = awardDic[vo[1]] + vo[2]
                end
            end
        end
        for tid, num in pairs(awardDic) do
            local propsItem = PropsGrid:create(self.mOldPropsRect.content, {tid, num}, 0.7, false)
            table.insert(self.mOldPropsList, propsItem)
        end
    end

    local dic = guild.GuildManager:getGuildPrepareData()
    local defVo = dic[1]
    local hellVo = dic[2]

    local hasDefCount = MoneyUtil.getMoneyCountByTid(defVo.prepareCost[1])
    self.mTxtDefPropsCount.text = defVo.prepareCost[2]
    if hasDefCount >= defVo.prepareCost[2] then
        self.mTxtDefPropsCount.color = gs.ColorUtil.GetColor("000000ff")
    else
        self.mTxtDefPropsCount.color = gs.ColorUtil.GetColor("f94234ff")
    end

    self.mImgDefProps:SetImg(MoneyUtil.getMoneyIconUrlByTid(defVo.prepareCost[1]), false)

    local hasHellCount = MoneyUtil.getMoneyCountByTid(hellVo.prepareCost[1])
    self.mTxtHellPropsCount.text = hellVo.prepareCost[2]
    if hasHellCount >= hellVo.prepareCost[2] then
        self.mTxtHellPropsCount.color = gs.ColorUtil.GetColor("000000ff")
    else
        self.mTxtHellPropsCount.color = gs.ColorUtil.GetColor("f94234ff")
    end
    self.mImgHellProps:SetImg(MoneyUtil.getMoneyIconUrlByTid(hellVo.prepareCost[1]), false)

    self:clearGetItemList()
    self:clearAwardItemList()

    local itemDef1 = SimpleInsItem:create(self.mGetItem, self.mDefLayout, "mGetItem1")
    itemDef1:getChildGO("mTxtDes"):GetComponent(ty.Text).text = MoneyUtil.getMoneyNameByTid(MoneyTid.GUILD_TID)
    itemDef1:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(
        MoneyUtil.getMoneyIconUrlByType(MoneyTid.GUILD_TID))
    itemDef1:getChildGO("mTxtDesCount"):GetComponent(ty.Text).text = "+" .. defVo.prepareReward[2]

    local itemDef2 = SimpleInsItem:create(self.mGetItem, self.mDefLayout, "mGetItem2")
    itemDef2:getChildGO("mTxtDes"):GetComponent(ty.Text).text = MoneyUtil.getMoneyNameByTid(MoneyTid.GUILD_FUND_TID)
    itemDef2:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(
        MoneyUtil.getMoneyIconUrlByType(MoneyTid.GUILD_FUND_TID))
    itemDef2:getChildGO("mTxtDesCount"):GetComponent(ty.Text).text = "+" .. defVo.coin

    local itemHell1 = SimpleInsItem:create(self.mGetItem, self.mHellLayout, "mGetItem1")
    itemHell1:getChildGO("mTxtDes"):GetComponent(ty.Text).text = MoneyUtil.getMoneyNameByTid(MoneyTid.GUILD_TID)
    itemHell1:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(
        MoneyUtil.getMoneyIconUrlByType(MoneyTid.GUILD_TID))
    itemHell1:getChildGO("mTxtDesCount"):GetComponent(ty.Text).text = "+" .. hellVo.prepareReward[2]

    local itemHell2 = SimpleInsItem:create(self.mGetItem, self.mHellLayout, "mGetItem2")
    itemHell2:getChildGO("mTxtDes"):GetComponent(ty.Text).text = MoneyUtil.getMoneyNameByTid(MoneyTid.GUILD_FUND_TID)
    itemHell2:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(
        MoneyUtil.getMoneyIconUrlByType(MoneyTid.GUILD_FUND_TID))
    itemHell2:getChildGO("mTxtDesCount"):GetComponent(ty.Text).text = "+" .. hellVo.coin
    table.insert(self.getItemList, itemDef1)
    table.insert(self.getItemList, itemDef2)
    table.insert(self.getItemList, itemHell1)
    table.insert(self.getItemList, itemHell2)

    self.guildInfo = guild.GuildManager:getGuildInfo()

    local maxCount = guild.GuildManager:getGuildAwardMaxTimes()

    -- self.guildInfo.prepare_times = 5
    self.mTxtCount.text = self.guildInfo.prepare_times
    self.mTxtCountMax.text = "/" .. maxCount

    self.mBtnDefPreGeted:SetActive(table.indexof01(self.awardPanelInfo.today_is_prepare, 1) > 0)
    self.mBtnHellPreGeted:SetActive(table.indexof01(self.awardPanelInfo.today_is_prepare, 2) > 0)
    self.mBtnDefPre:SetActive(table.indexof01(self.awardPanelInfo.today_is_prepare, 1) == 0)
    self.mBtnHellPre:SetActive(table.indexof01(self.awardPanelInfo.today_is_prepare, 2) == 0)
    local awardList = guild.GuildManager:getGuildAwardData()

    table.sort(awardList, function(vo1, vo2)
        return vo1.needTimes < vo2.needTimes
    end)

    local singleX = self.mSlideBgRt.sizeDelta.x / #awardList
    local needX = 0
    local needed = false
    for i = 1, #awardList do
        local awardVo = awardList[i]
        local awardItem = SimpleInsItem:create(self.mAwardItem, self.mPreparationAwardContent,
            "mGuildPreparationPanelAwardItem")
        -- gs.TransQuick:UIPos(awardItem:getGo():GetComponent(ty.RectTransform),
        --     awardVo.needTimes / maxCount * self.mPreparationAwardContent.sizeDelta.x, 0)
        awardItem:getChildGO("mTxtScore"):GetComponent(ty.Text).text = awardVo.needTimes

        local isPass = table.indexof01(self.awardPanelInfo.gained_prepare_award_list, awardVo.id) > 0
        awardItem:getChildGO("isPass"):SetActive(isPass)
        awardItem:getChildGO("mCanGet"):SetActive(false == isPass and awardVo.needTimes <= self.guildInfo.prepare_times)
        awardItem:addUIEvent(nil, function()
            self:openAwardInfo(awardVo, isPass, awardItem.m_trans)
        end)

        local redTran = awardItem:getChildTrans("mClickBg")
        if guild.GuildManager:canGetSingleAward(awardVo) then
            RedPointManager:add(redTran, nil, 35.6, 29)
        else
            RedPointManager:remove(redTran, nil, 0, 0)
        end
        table.insert(self.mAwardItemList, awardItem)

        if needed == false then
            if self.guildInfo.prepare_times > awardVo.needTimes then
                needX = needX + singleX
            else
                local v = 0
                if i == 1 then
                    v = self.guildInfo.prepare_times / awardVo.needTimes
                else
                    local firstV = awardList[i - 1].needTimes -- 5 --10
                    v = (self.guildInfo.prepare_times - firstV) / (awardVo.needTimes - firstV)
                end
                needX = needX + v * singleX
                needed = true
            end
        end
    end
    if self.guildInfo.prepare_times >= maxCount then
        gs.TransQuick:SizeDelta01(self.mSliderRt, self.mSlideBgRt.sizeDelta.x)
    else
        gs.TransQuick:SizeDelta01(self.mSliderRt, needX)
    end
end

function openAwardInfo(self, awardVo, isPass, trans)
    if awardVo.needTimes <= self.guildInfo.prepare_times and isPass == false then
        GameDispatcher:dispatchEvent(EventName.REQ_GAIN_PREPARE_AWARD, {
            id = awardVo.id
        })
        return
    end

    self.mBtnCloseAward:SetActive(true)
    self.mTxtAwardInfo.text = _TT(94530, awardVo.needTimes)
    gs.TransQuick:Pos(self.mAwardTipsRT.transform, trans)

    self:clearAwardProps()
    for i = 1, #awardVo.award do
        local vo = awardVo.award[i]
        local propsItem = PropsGrid:create(self.mAwardContent, {vo[1], vo[2]}, 0.95, false)
        propsItem:setHasRec(isPass)
        table.insert(self.mAwardPropsList, propsItem)
    end
end

function clearAwardProps(self)
    for i = 1, #self.mAwardPropsList do
        self.mAwardPropsList[i]:poolRecover()
    end
    self.mAwardPropsList = {}
end

function clearGetItemList(self)
    for i = 1, #self.getItemList do
        self.getItemList[i]:poolRecover()
    end
    self.getItemList = {}
end

function clearAwardItemList(self)
    for i = 1, #self.mAwardItemList do
        self.mAwardItemList[i]:poolRecover()
    end
    self.mAwardItemList = {}
end

return _M
