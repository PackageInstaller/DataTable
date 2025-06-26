-- @FileName:   DanKeSceneUI.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.view.DanKeSceneUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("danke/DanKeSceneUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口

-- 初始化数据
function initData(self)
    -- self.isOver = false

end

-- 初始化
function configUI(self)
    self.m_startView = fightUI.FightStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.mImgStart = self:getChildGO("mImgStart")
    self.mImgPause = self:getChildGO("mImgPause")
    self.mTextTime = self:getChildGO("mTextTime"):GetComponent(ty.Text)

    self.mBtnPause = self:getChildGO("mBtnPause")
    -- self.mRayEmpty = self:getChildGO("mRayEmpty")

    self.mPlayerHp = self:getChildGO("mPlayerHp")
    self.mImgHp = self:getChildGO("mImgHp"):GetComponent(ty.Image)

    self.mGroupBossWarn = self:getChildGO("mGroupBossWarn")
    self.mGroupBossHp = self:getChildGO("mGroupBossHp")
    self.mImgBossHp = self:getChildGO("mImgBossHp"):GetComponent(ty.Image)
    self.mTextBossHp = self:getChildGO("mTextBossHp"):GetComponent(ty.Text)

    self.mPlayerHpTran = self:getChildTrans("mPlayerHp")

    self.mItemSkill = self:getChildGO("mItemSkill")
    self.mGroupLeftSkill = self:getChildTrans("mGroupLeftSkill")
    self.mGroupRightSkill = self:getChildTrans("mGroupRightSkill")

    self.mGroupSkillTips = self:getChildGO("mGroupSkillTips")
    self.mItemSkillTips = self:getChildGO("mItemSkillTips")
    self.mGroupSkillTipsGrid = self:getChildTrans("mGroupSkillTipsGrid")

    self.mBtnCloseSkillTips = self:getChildGO("mBtnCloseSkillTips")

    self.mText_KillNum = self:getChildGO("mText_KillNum"):GetComponent(ty.Text)
    self.mText_lv = self:getChildGO("mText_lv"):GetComponent(ty.Text)
    self.mImgExp = self:getChildGO("mImgExp"):GetComponent(ty.Image)
    self.mImgHp = self:getChildGO("mImgHp"):GetComponent(ty.Image)
end

function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onPause)

    self:addUIEvent(self.mGroupLeftSkill.gameObject, function ()
        self:onShowSkillTips(DanKeConst.PlayerSkill_Type.Initiative)
    end)

    self:addUIEvent(self.mGroupRightSkill.gameObject, function ()
        self:onShowSkillTips(DanKeConst.PlayerSkill_Type.Passive)
    end)

    self:addUIEvent(self.mBtnCloseSkillTips, self.onCloseSkllTips)
end

--激活
function active(self, args)
    super.active(self)

    self:AddEventListener()

    -- self.mRayEmpty:SetActive(self.isOver)

    self.mTextTime.text = "00:00"

    local function _finishCall()
        self.m_startView:setActive(false)
        self:startGameTime()

        GameDispatcher:dispatchEvent(EventName.DANKE_GAME_START)
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)

    self.mGroupBossWarn:SetActive(false)
    self.mGroupSkillTips:SetActive(false)
    self.mGroupBossHp:SetActive(false)

    self:initSkillItem()
    self:refreshPauseState(false)

    self:onRefreshPlayerThingInfo()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:RemoveEventListener()

    self:clearJoystick()
    self:clearSkillItem()
    self:onCloseSkllTips()
end

function AddEventListener(self)
    GameDispatcher:addEventListener(EventName.DANKE_UPDATE_PAUSESTATE, self.refreshPauseState, self)
    GameDispatcher:addEventListener(EventName.DANKE_REFRESH_GAMETIME, self.refreshDupTime, self)

    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_JOYSTICK_UPDATE, self.onPlayMove, self)

    GameDispatcher:addEventListener(EventName.DANKE_PLAYERTHING_SKILL_REFRESH, self.refreshSkillItem, self)
    GameDispatcher:addEventListener(EventName.DANKE_PLAYERTHING_ATTRREFRESH, self.onRefreshPlayerThingInfo, self)
    GameDispatcher:addEventListener(EventName.DANKE_ELITEMONSTER_SHOW, self.onEliteMonsterShow, self)
    GameDispatcher:addEventListener(EventName.DANKE_MONSTER_REFRESH_HP, self.onRefreshEliteMonsterHp, self)
    -- GameDispatcher:addEventListener(EventName.DANKE_MONSTER_DIE, self.onRefreshEliteMonsterHp, self)

end

function RemoveEventListener(self)
    GameDispatcher:removeEventListener(EventName.DANKE_UPDATE_PAUSESTATE, self.refreshPauseState, self)
    GameDispatcher:removeEventListener(EventName.DANKE_REFRESH_GAMETIME, self.refreshDupTime, self)

    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_JOYSTICK_UPDATE, self.onPlayMove, self)

    GameDispatcher:removeEventListener(EventName.DANKE_PLAYERTHING_SKILL_REFRESH, self.refreshSkillItem, self)
    GameDispatcher:removeEventListener(EventName.DANKE_PLAYERTHING_ATTRREFRESH, self.onRefreshPlayerThingInfo, self)
    GameDispatcher:removeEventListener(EventName.DANKE_ELITEMONSTER_SHOW, self.onEliteMonsterShow, self)
    GameDispatcher:removeEventListener(EventName.DANKE_MONSTER_REFRESH_HP, self.onRefreshEliteMonsterHp, self)
    -- GameDispatcher:addEventListener(EventName.DANKE_MONSTER_DIE, self.onRefreshEliteMonsterHp, self)

end

function onEliteMonsteDie(self)
    self.mGroupBossHp:SetActive(false)
end

--更新精英怪血量
function onRefreshEliteMonsterHp(self, eliteMonster_snId)
    local eliteMonsterThing = danke.DanKeSceneController:getThing(DanKeConst.ColliderTag.Elite_Monster, eliteMonster_snId)
    if eliteMonsterThing then
        local attr = eliteMonsterThing:getAttr()
        local hp_max_hp = attr.hp / attr.max_hp
        self.mImgBossHp.fillAmount = hp_max_hp
        local str = math.floor(hp_max_hp * 1000) / 10
        self.mTextBossHp.text = string.format("%s%%", str)

        self.mGroupBossHp:SetActive(attr.hp > 0)
    end
end

--精英怪出现
function onEliteMonsterShow(self, eliteMonster_snId)
    local eliteMonsterThing = danke.DanKeSceneController:getThing(DanKeConst.ColliderTag.Elite_Monster, eliteMonster_snId)
    if eliteMonsterThing then
        self.mGroupBossWarn:SetActive(true)

        self:setTimeout(1, function ()
            self.mGroupBossWarn:SetActive(false)
        end)
    end
end

function onRefreshPlayerThingInfo(self)
    local playerThing = danke.DanKeSceneController:getPlayerThing()
    if playerThing then
        local attr = playerThing:getAttr()
        self.mText_KillNum.text = attr.kill_num
        self.mText_lv.text = attr.level
        local levelExp = playerThing:getLevelExp()
        self.mImgExp.fillAmount = attr.exp / levelExp

        self.mImgHp.fillAmount = attr.hp / attr.max_hp
    end
end

function onShowSkillTips(self, skill_type)
    self.mGroupSkillTips:SetActive(true)

    self.m_lastTimeScale = gs.Time.timeScale
    fight.FightManager:setupTimeScale(0)

    self:createSkillTipsItem(self.m_skillItemList[skill_type])
end

function onCloseSkllTips(self)
    if not self.m_lastTimeScale then
        return
    end

    fight.FightManager:setupTimeScale(self.m_lastTimeScale)

    self:clearSkillTipsItem()
    self:clearSkillTipsItemLvItem()

    self.mGroupSkillTips:SetActive(false)
end

function createSkillTipsItem(self, skill_list)
    self:clearSkillTipsItem()
    self:clearSkillTipsItemLvItem()

    for i = 1, #skill_list do
        local skillItem = skill_list[i]
        local skillVo = skillItem:getData()
        if skillVo ~= nil then
            local skillTipsItem = SimpleInsItem:create(self.mItemSkillTips, self.mGroupSkillTipsGrid, "DanKeSceneUI_SkillTipsItem")
            skillTipsItem:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(skillVo:getIcon())

            local skill_lv = skillVo:getLevel()
            skillTipsItem:getChildGO("mTextName"):GetComponent(ty.Text).text = string.format("%sLV.%s", skillVo:getName(), skill_lv)
            for i = 1, 5 do
                local lvItem = SimpleInsItem:create(skillTipsItem:getChildGO("mItem"), skillTipsItem:getChildTrans("mGroupLv"), "DanKeSceneUI_SkllTipsItem_LvItem")
                lvItem:getChildGO("mImgShow"):SetActive(i <= skill_lv)
                table.insert(self.m_skillTipsItemLvItemList, lvItem)
            end

            table.insert(self.m_skillTipsItemList, skillTipsItem)
        end
    end
end

function clearSkillTipsItem(self)
    if self.m_skillTipsItemList then
        for _, item in pairs(self.m_skillTipsItemList) do
            item:poolRecover()
        end
    end

    self.m_skillTipsItemList = {}
end

function clearSkillTipsItemLvItem(self)
    if self.m_skillTipsItemLvItemList then
        for _, item in pairs(self.m_skillTipsItemLvItemList) do
            item:poolRecover()
        end
    end

    self.m_skillTipsItemLvItemList = {}
end

function initSkillItem(self)
    self:clearSkillItem()

    --左边主动技能
    for i = 1, DanKeConst.PlayerMaxSkillCount do
        local skillItem = danke.DanKeSceneUISkillItem:create(self.mItemSkill, self.mGroupLeftSkill, "DanKeSceneUI_SkillItem")
        skillItem:setData(nil)
        table.insert(self.m_skillItemList[DanKeConst.PlayerSkill_Type.Initiative], skillItem)
    end

    --右边被动技能
    for i = 1, DanKeConst.PlayerMaxSkillCount do
        local skillItem = danke.DanKeSceneUISkillItem:create(self.mItemSkill, self.mGroupRightSkill, "DanKeSceneUI_SkillItem")
        skillItem:setData(nil)
        table.insert(self.m_skillItemList[DanKeConst.PlayerSkill_Type.Passive], skillItem)
    end
end

function refreshSkillItem(self, skillVo)
    if self.m_skillItemList == nil or self.m_skillItemList[skillVo.type] == nil then
        return
    end

    local existSkillItem = nil
    for _, skillItem in pairs(self.m_skillItemList[skillVo.type]) do
        local itemSkillVo = skillItem:getData()
        if itemSkillVo ~= nil and skillVo.tid == itemSkillVo.tid then
            existSkillItem = skillItem
            break
        end
    end
    if existSkillItem == nil then
        for _, skillItem in pairs(self.m_skillItemList[skillVo.type]) do
            if skillItem:getData() == nil then
                existSkillItem = skillItem
                break
            end
        end
    end
    if existSkillItem then
        existSkillItem:setData(skillVo)
    end
end

function clearSkillItem(self)
    if self.m_skillItemList then
        for skillType, skillList in pairs(self.m_skillItemList) do
            for _, skill in pairs(skillList) do
                skill:poolRecover()
            end
        end
    end

    self.m_skillItemList =
    {
        [DanKeConst.PlayerSkill_Type.Initiative] = {},
        [DanKeConst.PlayerSkill_Type.Passive] = {},
    }
end

function onPlayMove(self)
    -- self:onRefreshPlayerHpPos()
end

-- function onRefreshPlayerHpPos(self)
--     local playerThing = danke.DanKeSceneController:getPlayerThing()
--     if playerThing then
--         local followTrans = playerThing:getTrans()
--         gs.CameraMgr:World2UIOffsetY(followTrans, self.UITrans, self.mPlayerHpTran, 0.8)
--     end
-- end

function refreshDupTime(self, time)
    self.mTextTime.text = TimeUtil.getHMSByTime_1(time)
end

--开始倒计时
function startGameTime(self)
    if (not self.mJoyStick) then
        self.mJoyStick = danke.DanKeJoystickView.new()
        self.mJoyStick:setParentTrans(self.UITrans)
    end
end

function clearJoystick(self)
    if (self.mJoyStick) then
        self.mJoyStick:destroy()
        self.mJoyStick = nil
    end
end

function onPause(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DANKE_PAUSEPANEL)
end

function refreshPauseState(self, pauseState)
    self.mImgStart:SetActive(pauseState)
    self.mImgPause:SetActive(not pauseState)
end

return _M
