module("guild.GuildSweepLevelSelectPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildSweepLevelSelectPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- 构造函数

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(100007))
end
-- 初始化数据
function initData(self)
    super.initData(self)

    self.mDifItemList = {}
    self.mPropsList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mLevelContent = self:getChildTrans("mLevelContent")
    self.mLevelItem = self:getChildGO("mLevelItem")

    self.mLevelInfo = self:getChildGO("mLevelInfo")
    self.mTxtLevel = self:getChildGO("mTxtLevel"):GetComponent(ty.Text)
    self.mTxtRecommend = self:getChildGO("mTxtRecommend"):GetComponent(ty.Text)
    self.mItemScroller = self:getChildGO("mItemScroller"):GetComponent(ty.ScrollRect)
    self.mTxtNeedCount = self:getChildGO("mTxtNeedCount"):GetComponent(ty.Text)
    self.mBtnFight = self:getChildGO("mBtnFight")
end

-- 激活
function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.ON_GUILD_SWEEP_INFO_CHANGE,self.onSweepInfoChange,self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.ON_GUILD_SWEEP_INFO_CHANGE,self.onSweepInfoChange,self)
    self:clearPropsList()
    self:clearDifItemList()
end

function initViewText(self)
    self:getChildGO("Txt01"):GetComponent(ty.Text).text = _TT(100011)
    self:getChildGO("mTxtGet"):GetComponent(ty.Text).text = _TT(100009)
end



function onSweepInfoChange(self)
    gs.Message.Show(_TT(94611))
    self:close()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onBtnFightClick)
end

function onBtnFightClick(self)
    local isLeader = guild.GuildManager:getSelfIsGuildLeader() or guild.GuildManager:getSelfIsChairman()
    local maxLv = guild.GuildManager:getGuildSweepMaxLevel()
    if maxLv < self.mSelectVo.id then
        gs.Message.Show(_TT(100010))
        return
    end

    if isLeader == false then
        gs.Message.Show(_TT(100006))
    else
        local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.GUILD_FUND_TID, self.mSelectVo.needFund, true, true)
        if tips == "" and result == true then
            UIFactory:alertMessge(_TT(100015), true, function()
                GameDispatcher:dispatchEvent(EventName.REQ_GUILD_SWEEP_SELECT_LEVEL,{id = self.mSelectVo.id }) 
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
            
           
            --self:close()
        else
            gs.Message.Show(tips)
        end
    end
end

function showPanel(self)
    self:clearDifItemList()
    local maxLv = guild.GuildManager:getGuildSweepMaxLevel()

    local difDic = guild.GuildManager:getSweepDifficultyData()
    local clickVo = nil
    for k, vo in pairs(difDic) do
        local item = SimpleInsItem:create(self.mLevelItem, self.mLevelContent, "mSweepDifItem")
        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getPackPath("guild/img_degree_0" .. k .. ".png"), false)
        item:getChildGO("mTxtNum"):GetComponent(ty.Text).text = k
        local isLock = maxLv < k
        if k == maxLv then--
            clickVo = vo
        end

        item:getChildGO("mLock"):SetActive(isLock)
        item:getChildGO("mSelect"):SetActive(false)

        local function clickFun()
            self:onClickDifItem(vo)
        end
        item:addUIEvent("mClick", clickFun)

        table.insert(self.mDifItemList, {
            item = item,
            vo = vo
        })
    end
    self:onClickDifItem(clickVo)
end

function onClickDifItem(self, vo)
    for k, datas in pairs(self.mDifItemList) do
        datas.item:getChildGO("mSelect"):SetActive(datas.vo.id == vo.id)
    end

    self.mSelectVo = vo
    self.mTxtLevel.text = self.mSelectVo.id
    self.mTxtRecommend.text = self.mSelectVo.monsterLevel
    self.mTxtNeedCount.text = self.mSelectVo.needFund

    local hasCount = MoneyUtil.getMoneyCountByTid(MoneyTid.GUILD_FUND_TID)
    if hasCount >= self.mSelectVo.needFund then
        self.mTxtNeedCount.color = gs.ColorUtil.GetColor("000000ff")
    else
        self.mTxtNeedCount.color = gs.ColorUtil.GetColor("f94234ff")
    end

    self:clearPropsList()
    local list = AwardPackManager:getAwardListById(self.mSelectVo.showReward)
    for k, propsVo in pairs(list) do
        local propsGrid = PropsGrid:createByData({
            tid = propsVo.tid,
            num = propsVo.num,
            parent = self.mItemScroller.content,
            showUseInTip = true
        })
        table.insert(self.mPropsList, propsGrid)
    end
end

function clearDifItemList(self)
    for i = 1, #self.mDifItemList do
        self.mDifItemList[i].item:poolRecover()
    end
    self.mDifItemList = {}
end

function clearPropsList(self)
    for i = 1, #self.mPropsList do
        self.mPropsList[i]:poolRecover()
    end
    self.mPropsList = {}
end

return _M
