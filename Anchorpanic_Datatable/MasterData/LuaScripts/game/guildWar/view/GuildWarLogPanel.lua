--[[ 
-----------------------------------------------------
@Description    : 联盟团战日志界面
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('guildWar.GuildWarLogPanel', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarLogPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(1120, 540)
    self:setTxtTitle(_TT(149162))
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mLogItemList = {}
    self.mPlayerHeadList = {}

    self.mBtnFightLogItemList = {}
end

-- 初始化
function configUI(self)
    self.mLogScroll = self:getChildGO("mLogScroll"):GetComponent(ty.ScrollRect)
    self.mLogScrollRect = self.mLogScroll.gameObject:GetComponent(ty.RectTransform)
    self.mLogItem = self:getChildGO("mLogItem")

    self.mLogNo = self:getChildGO("mLogNo")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mBtnFightLogItem = self:getChildGO("mBtnFightLogItem")

    self.mPageContent = self:getChildGO("mPageContent")
    self.mPretBtn = self:getChildGO("mPretBtn")
    self.mNextBtn = self:getChildGO("mNextBtn")
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTxtEmptyTip.text = _TT(149163)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mPretBtn, self.onPreClick)
    self:addUIEvent(self.mNextBtn, self.onNextClick)
end

function onPreClick(self)
    if self.curPage > 1 then
        self.curPage = self.curPage - 1
    else
        gs.Message.Show(_TT(149153))
        return
    end
   self:updatePageInfo()
end

function updatePageInfo(self)
    GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_BATTLE_LOG, {
        buildId = 0,
        page = {(self.curPage - 1) * 5 + 1, self.curPage * 5},
        isAtk = 2
    })
end

function onNextClick(self)
    if self.curPage * 5 < self.mLogCount then
        self.curPage = self.curPage + 1
    else
        gs.Message.Show(_TT(149154))
        return
    end
    self:updatePageInfo()
end

function active(self, args)
    super.active(self)
    self.curPage = 1
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_BATTLE_LOG, self.updateLogInfo, self)
    self:updatePageInfo()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearBtnLogList()
    self:clearPlayerHeadList()
    self:clearLogList()
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_BATTLE_LOG, self.updateLogInfo, self)
end

function updateLogInfo(self, args)
    self:clearBtnLogList()
    self:clearPlayerHeadList()
    self:clearLogList()

    self.mLogCount = args.logNum
    self.mLogList = args.logList
    self.mLogNo:SetActive(#self.mLogList == 0)

    self.mTxtNum.text = self.curPage

    self.mPageContent:SetActive(self.mLogCount > 5)

    gs.TransQuick:SizeDelta02(self.mLogScrollRect, self.mLogCount > 5 and 378 or 444)
    

    for i = 1, #self.mLogList do
        local item = SimpleInsItem:create(self.mLogItem, self.mLogScroll.content, "mGuildWarLogItem")
        local isAtk = self.mLogList[i].is_atk == 1

        local playerHead1 = PlayerHeadGrid:poolGet()
        if isAtk then
            playerHead1:setData(self.mLogList[i].atk_avatar)
            playerHead1:setHeadFrame(self.mLogList[i].atk_avatar_frame)
            playerHead1:setParent(item:getChildTrans("mHeadPos"))

            item:getChildGO("mTxtPoint"):GetComponent(ty.Text).text =
             _TT(149208, self.mLogList[i].atk_old_point ,self.mLogList[i].atk_new_point - self.mLogList[i].atk_old_point) 
           

            item:getChildGO("mTxtName"):GetComponent(ty.Text).text = self.mLogList[i].atk_name
            item:getChildGO("mTxtLv"):GetComponent(ty.Text).text = _TT(1361).. self.mLogList[i].atk_lv
        else
            playerHead1:setData(self.mLogList[i].def_avatar)
            playerHead1:setHeadFrame(self.mLogList[i].def_avatar_frame)
            playerHead1:setParent(item:getChildTrans("mHeadPos"))

            item:getChildGO("mTxtPoint"):GetComponent(ty.Text).text = --_TT(149107) .. self.mLogList[i].def_new_point
            _TT(149208, self.mLogList[i].def_old_point ,self.mLogList[i].def_new_point - self.mLogList[i].def_old_point) 

            item:getChildGO("mTxtName"):GetComponent(ty.Text).text = self.mLogList[i].def_name
            item:getChildGO("mTxtLv"):GetComponent(ty.Text).text = _TT(1361) .. self.mLogList[i].def_lv
        end
        table.insert(self.mPlayerHeadList, playerHead1)

        item:getChildGO("mImgAtk"):SetActive(isAtk)
        item:getChildGO("mImgDef"):SetActive(not isAtk)

        local buildVo = guildWar.GuildWarManager:getGuildWarBuildDataById(self.mLogList[i].build_id)
        item:getChildGO("mIconBuildAtk"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
            "guildWar/child_min_type_" .. buildVo.type .. ".png", false))
        item:getChildGO("mIconBuildDef"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
            "guildWar/child_min_type_" .. buildVo.type .. ".png", false))

        local playerHead2 = PlayerHeadGrid:poolGet()
        if isAtk then
            playerHead2:setData(self.mLogList[i].def_avatar)
            playerHead2:setHeadFrame(self.mLogList[i].def_avatar_frame)
            playerHead2:setParent(item:getChildTrans("mHeadPos2"))

            item:getChildGO("mTxtPoint2"):GetComponent(ty.Text).text = --_TT(149107) .. self.mLogList[i].def_new_point
            _TT(149208, self.mLogList[i].def_old_point ,self.mLogList[i].def_new_point - self.mLogList[i].def_old_point) 
            item:getChildGO("mTxtName2"):GetComponent(ty.Text).text = self.mLogList[i].def_name
            item:getChildGO("mTxtLv2"):GetComponent(ty.Text).text = _TT(1361) .. self.mLogList[i].def_lv
        else
            playerHead2:setData(self.mLogList[i].atk_avatar)
            playerHead2:setHeadFrame(self.mLogList[i].atk_avatar_frame)
            playerHead2:setParent(item:getChildTrans("mHeadPos2"))

            item:getChildGO("mTxtPoint2"):GetComponent(ty.Text).text = --_TT(149107) .. self.mLogList[i].atk_new_point
            _TT(149208, self.mLogList[i].atk_old_point ,self.mLogList[i].atk_new_point - self.mLogList[i].atk_old_point) 
            item:getChildGO("mTxtName2"):GetComponent(ty.Text).text = self.mLogList[i].atk_name
            item:getChildGO("mTxtLv2"):GetComponent(ty.Text).text = _TT(1361) .. self.mLogList[i].atk_lv
        end
        table.insert(self.mPlayerHeadList, playerHead2)

        item:getChildGO("mTxtResult"):GetComponent(ty.Text).text = _TT(149197+self.mLogList[i].result) 
        for j = 1, #self.mLogList[i].team_list do
            local fightItem = SimpleInsItem:create(self.mBtnFightLogItem, item:getChildTrans("mLogFightContent"),
                "mBtnFightLogItem")
            local url = ""

            url = "guildWar/battle_pre_" .. self.mLogList[i].team_list[j].result .. ".png"
            fightItem:getChildGO("mBtnIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(url), false)
            fightItem:addUIEvent("mBtnIcon", function()
                GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_FIGHT_RESULT_INFO_PANEL,{log = self.mLogList[i]})
                self:close()
                -- if self.mLogList[i].team_list[j].can_replay == 1 then
                --     UIFactory:alertMessge(_TT(178), true, function()
                --         if self.mLogList[i].battle_id ~= 0 then
                --             fight.FightManager:reqReplay(PreFightBattleType.GuildWar, self.mLogList[i].battle_id,
                --                 self.mLogList[i].team_list[j].team_id)
                --         else
                --             gs.Message.Show(_TT(179))
                --         end
                --     end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.GUILDWAR_REPLAY)
                -- end
            end)

            table.insert(self.mBtnFightLogItemList, fightItem)
        end
        item:getChildGO("mTxtTimer"):GetComponent(ty.Text).text =
            TimeUtil.getFormatTimeBySeconds_13(self.mLogList[i].time)
        table.insert(self.mLogItemList, item)
    end
end

function clearLogList(self)
    for i = 1, #self.mLogItemList, 1 do
        self.mLogItemList[i]:poolRecover()
    end
    self.mLogItemList = {}
end

function clearPlayerHeadList(self)
    for i = 1, #self.mPlayerHeadList, 1 do
        self.mPlayerHeadList[i]:poolRecover()
    end
    self.mPlayerHeadList = {}
end

function clearBtnLogList(self)
    for i = 1, #self.mBtnFightLogItemList, 1 do
        self.mBtnFightLogItemList[i]:poolRecover()
    end
    self.mBtnFightLogItemList = {}
end
return _M
