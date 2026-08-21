--[[ 
-----------------------------------------------------
@Description    : 联盟团战结算界面
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("guildWar.GuildWarResultPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarResultPanel.prefab")
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
    self.itemList = {}
    self.mGroupItems = {}
    self.mSnList = {}
end

function configUI(self)
    super.configUI(self)
    self.mGroup = self:getChildGO("mGroup")
    self.mGroupPlayback = self:getChildGO("mGroupPlayback")
    self.mWinInfo = self:getChildGO("mWinInfo")
    self.mLoseInfo = self:getChildGO("mLoseInfo")
    self.mDrawInfo = self:getChildGO("mDrawInfo")
    self.mTxtCurSorce = self:getChildGO("mTxtCurSorce"):GetComponent(ty.Text)
    self.mTxtExtraSorce = self:getChildGO("mTxtExtraSorce"):GetComponent(ty.Text)

    self.mGroupProps = self:getChildTrans("mGroupProps")
    self.mGroupResult = self:getChildTrans("mGroupResult")

    self.mResultItem = self:getChildGO("mResultItem")

    self.mPreviewBtn = self:getChildGO("mPreViewBtn")
end

function active(self, args)
    super.active(self, args)
    self.state = args.state


    self.mGroup:SetActive(fight.FightManager:isReplaying() == false)
    self.mGroupPlayback:SetActive(fight.FightManager:isReplaying() == true)

    if not fight.FightManager:isReplaying() then
        self:showPanel()
    end

    self.isCanClose = false
    self:setTimeout(1.5, function()
        self.isCanClose = true
    end)
end

function deActive(self)
    super.deActive(self)
    self:clearSnList()
    --arenaEntrance.ArenaEntranceManager.roundTime = 1 --恢复回合数

    self:clearItems()
    if fight.FightManager:getIsFighting() then
        GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, { isWin = self.state == guildWar.ResultState.WIN })

        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)

        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Guild })
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_MAIN_PANEL)
    else
        -- 不进入战斗的跳过处理
        --arenaEntrance.ArenaEntranceManager:setLastClickRefresh(GameManager:getClientTime())
        --GameDispatcher:dispatchEvent(EventName.REQ_ARENA_HELL_PANEL_INFO)
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mPreviewBtn, self.onPreviewClick)
end

function onClickClose(self)
    if self.isCanClose then
        super.onClickClose(self)
    end
end

function onPreviewClick(self)
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PREVIEW_SHOW)
end

function showPanel(self)
    self.mWinInfo:SetActive(self.state == guildWar.ResultState.WIN)
    self.mLoseInfo:SetActive(self.state == guildWar.ResultState.LOSE)
    self.mDrawInfo:SetActive(self.state == guildWar.ResultState.DRAW)
    self.resultData = fight.FightManager:getResultData()

    self:clearItems()

    for i = 2, 3 do
        local item = SimpleInsItem:create(self.mResultItem, self.mGroupResult, "myResultItem")
        item:getChildGO("mRoot"):SetActive(false)
        item:getChildGO("mWinResult"):SetActive(self.resultData.args[i] == guildWar.ResultState.WIN)
        item:getChildGO("mLoseResult"):SetActive(self.resultData.args[i] == guildWar.ResultState.LOSE)
        item:getChildGO("mDrawResult"):SetActive(self.resultData.args[i] == guildWar.ResultState.DRAW)
        -- local url = UrlManager:getPackPath("arena/arena_pnl_01.png")
        -- item:getChildGO("mTxtResult"):GetComponent(ty.Text).text = "WIN"
        -- if self.resultData.args[i] == 2 then
        --     url = UrlManager:getPackPath("arena/arena_pnl_02.png")
        --     item:getChildGO("mTxtResult"):GetComponent(ty.Text).text = "FAIL"
        -- end
        -- item:getChildGO("mImgResult"):GetComponent(ty.AutoRefImage):SetImg(url, false)
        item:getChildGO("mTxtRound"):GetComponent(ty.Text).text = _TT(149184) .. i - 1
        local sn = LoopManager:setFrameout(13 + i * 7, self, function()
            item:getChildGO("mRoot"):SetActive(true)
        end)

        table.insert(self.itemList, item)
        table.insert(self.mSnList, sn)
    end

    self.mTxtCurSorce.text = self.resultData.args[4]
    if self.resultData.args[5] >= self.resultData.args[4] then
        self.mTxtExtraSorce.text = "+" .. self.resultData.args[5] - self.resultData.args[4]
        self.mTxtExtraSorce.color = gs.ColorUtil.GetColor("1AE92Cff")
    else
        self.mTxtExtraSorce.text = self.resultData.args[5] - self.resultData.args[4]
        self.mTxtExtraSorce.color = gs.ColorUtil.GetColor("F34B3Fff")
    end

    self:updateAward()
end

function updateAward(self)
    self:clearPros()
    local cusPropsList = self.resultData.award
    local list = {}
    for _, v in ipairs(cusPropsList) do
        local configVo = props.PropsManager:getPropsConfigVo(v.tid)
        if configVo.type == PropsType.EQUIP then
            -- 服务器发来的会自动合并tid一样的，前端先全部拆分
            local count = v.count
            v.count = 1
            for i = 1, count do
                local equipVo = LuaPoolMgr:poolGet(props.EquipVo)
                equipVo:setPropsAwardMsgData(v)
                table.insert(list, equipVo)
            end
        else
            local propsVo = LuaPoolMgr:poolGet(props.PropsVo)
            propsVo:setPropsAwardMsgData(v)
            table.insert(list, propsVo)
        end
    end
    table.sort(list, bag.BagManager.sortPropsListByDescending)

    for i = 1, #list do
        local propsVo = list[i]
        local grid = ShowAwardItem:poolGet()
        grid:setData(self.mGroupProps, propsVo)
        table.insert(self.mGroupItems, grid)
    end
end

function clearSnList(self)
    for i = 1, #self.mSnList do
        if self.mSnList[i] then
            LoopManager:removeFrameByIndex(self.mSnList[i])
        end
    end
    self.mSnList = {}
end

function clearItems(self)
    for i = 1, #self.itemList do
        self.itemList[i]:poolRecover()
    end
    self.itemList = {}
end

function clearPros(self)
    for i = 1, #self.mGroupItems do
        self.mGroupItems[i]:poolRecover()
    end
    self.mGroupItems = {}
end

return _M