--[[ 
-----------------------------------------------------
@Description    : 联盟团战成员状态
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module('guildWar.GuildWarMemberPanel', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarMemberPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(1120, 540)
    self:setTxtTitle(_TT(149181))
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mPlayerHeadList = {}
    self.mMembersItemList = {}
end

-- 初始化
function configUI(self)
    self.mMemberItem = self:getChildGO("mMemberItem")
    self.mTxtMemberCount = self:getChildGO("mTxtMemberCount"):GetComponent(ty.Text)
    self.mMembersScroll = self:getChildGO("mMembersScroll"):GetComponent(ty.ScrollRect)
end

function active(self, args)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_SINGUP, self.showPanel, self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_SINGUP, self.showPanel, self)
    self:clearPlayerHeadList()
    self:clearMembersItemList()
end

function showPanel(self)

    self:clearPlayerHeadList()
    self:clearMembersItemList()

    self.membersList = guild.GuildManager:getGuildAllMembers()

    local curMem = {}
    local remMem = {}
    for i = 1, #self.membersList do
        if self.membersList[i].build_info.build_id == 0 then
            table.insert(remMem, self.membersList[i])
        else
            table.insert(curMem, self.membersList[i])
        end
    end

    table.sort(curMem, function(vo1, vo2)
        local buVo1 = guildWar.GuildWarManager:getGuildWarBuildDataById(vo1.build_info.build_id)
        local buVo2 = guildWar.GuildWarManager:getGuildWarBuildDataById(vo2.build_info.build_id)
        return buVo1.type < buVo2.type
    end)

    for i = 1, #remMem do
        table.insert(curMem, remMem[i])
    end
    self.membersList = curMem

    local buildCount = 0

    local allFightCount = sysParam.SysParamManager:getValue(SysParamType.GUILDWAR_COUNT)
    for i = 1, #self.membersList do
        local battleList = self.membersList[i].build_info.battle_result
        local item = SimpleInsItem:create(self.mMemberItem, self.mMembersScroll.content, "mMemberItem2")
        local playerHead = PlayerHeadGrid:poolGet()
        playerHead:setData(self.membersList[i].avatar_id)
        playerHead:setHeadFrame(self.membersList[i].avatar_frame_id)
        playerHead:setParent(item:getChildTrans("mHeadPos"))
        table.insert(self.mPlayerHeadList, playerHead)

        local buildId = self.membersList[i].build_info.build_id
        if buildId == 0 then
            item:getChildGO("mIconBuild"):SetActive(false)
            item:getChildGO("mImgHpBg"):SetActive(false)
        else
            buildCount = buildCount + 1
            local buildVo = guildWar.GuildWarManager:getGuildWarBuildDataById(buildId)
            item:getChildGO("mIconBuild"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
                "guildWar/child_min_type_" .. buildVo.type .. ".png", false))

            local color = "FFFFFFFF"
            if self.membersList[i].build_info.now_hp == 0 then
                color = "6C737BFF"
            end

            item:getChildGO("mIconBuild"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(color)

            item:getChildGO("mIconBuild"):SetActive(true)
            local pro = 1
            if guildWar.GuildWarNotHpInfo() == false then
                pro = self.membersList[i].build_info.now_hp / self.membersList[i].build_info.max_hp
            end

            gs.TransQuick:SizeDelta01(item:getChildGO("mImgHp"):GetComponent(ty.RectTransform), (item:getChildGO(
                "mImgHpBg"):GetComponent(ty.RectTransform).sizeDelta.x - 2) * pro)
            item:getChildGO("mImgHpBg"):SetActive(true)
        end

        item:getChildGO("mBtnFall"):SetActive(false)
        item:getChildGO("mBtnJoin"):SetActive(buildId > 0)

        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = self.membersList[i].player_name
        item:getChildGO("mTxtLv"):GetComponent(ty.Text).text = _TT(1361) .. self.membersList[i].player_lv
        item:getChildGO("mTxtPoint"):GetComponent(ty.Text).text = _TT(149107) .. self.membersList[i].build_info.point
        item:getChildGO("mTxtWin"):GetComponent(ty.Text).text = _TT(149108) ..
                                                                    self:getBattleResultTimes(battleList,
                guildWar.BattleType.ATK_WIN)
        item:getChildGO("mTxtLose"):GetComponent(ty.Text).text = _TT(149109) ..
                                                                     self:getBattleResultTimes(battleList,
                guildWar.BattleType.ATK_LOSE)
        item:getChildGO("mTxtDraw"):GetComponent(ty.Text).text = _TT(149110) ..
                                                                     self:getBattleResultTimes(battleList,
                guildWar.BattleType.ATK_DRAW)
        item:getChildGO("mTxtCount"):GetComponent(ty.Text).text =
            self.membersList[i].build_info.challenge_times .. "/" .. allFightCount

        item:getChildGO("mTxtFall"):GetComponent(ty.Text).text = _TT(149111)
        item:getChildGO("mTxtJoin"):GetComponent(ty.Text).text = _TT(149182)
        item:getChildGO("mTxtInfo"):GetComponent(ty.Text).text = _TT(149113)

        local sign_up_info = {}
        item:addUIEvent("mBtnFall", function()
            table.insert(sign_up_info, {
                player_id = self.membersList[i].player_id,
                build_id = 0
            })
            GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_SINGUP, {
                info = sign_up_info
            })
        end)
        item:addUIEvent("mBtnJoin", function()
            self.canSignUp = guildWar.guildWarCanSignUp()
            self.canShowEnemy = guildWar.GuildWarCanReqEnemy()
            if self.canSignUp == false and self.canShowEnemy == false then
                gs.Message.Show(_TT(149142))
                return
            end
            local buildVo = guildWar.GuildWarManager:getGuildWarBuildDataById(buildId)
            GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_CHILD_PANEL, {
                posId = buildVo.regionId,
                isEnemy = false,
                lastShowBuild = buildVo.id
            })

            self:close()
        end)
        item:addUIEvent("mBtnInfo", function()
            guildWar.GuildWarManager:setLastClickPlayerIdAndState(self.membersList[i].player_id, self.isEnemy)

            GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_PLAYER_INFO, {
                playerId = self.membersList[i].player_id
            })
        end)
        table.insert(self.mMembersItemList, item)
    end

    self.mTxtMemberCount.text = _TT(149183, buildCount, #self.membersList)
end

function getBattleResultTimes(self, list, result)
    for i = 1, #list do
        if list[i].result == result then
            return list[i].times
        end
    end
    return 0
end

function clearPlayerHeadList(self)
    for i = 1, #self.mPlayerHeadList do
        self.mPlayerHeadList[i]:poolRecover()
    end
    self.mPlayerHeadList = {}
end

function clearMembersItemList(self)
    for i = 1, #self.mMembersItemList do
        self.mMembersItemList[i]:poolRecover()
    end
    self.mMembersItemList = {}
end

return _M
