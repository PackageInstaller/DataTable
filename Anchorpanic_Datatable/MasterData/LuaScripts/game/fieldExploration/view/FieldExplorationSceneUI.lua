-- @FileName:   FieldExplorationSceneUI.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationSceneUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fieldExploration/FieldExplorationSceneUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口

function initData(self)
    self.m_showFuncDataList = {}
end

-- 初始化
function configUI(self)
    self.m_startView = fightUI.FightStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.mTextScore = self:getChildGO("mTextScore"):GetComponent(ty.Text)
    self.mTextLife = self:getChildGO("mTextLife"):GetComponent(ty.Text)
    self.mTextMaxLife = self:getChildGO("mTextMaxLife"):GetComponent(ty.Text)

    self.mImgStart = self:getChildGO("mImgStart")
    self.mImgPause = self:getChildGO("mImgPause")
    self.mTextTime = self:getChildGO("mTextTime"):GetComponent(ty.Text)

    self.mLifeGroup = self:getChildGO("mLifeGroup")
    self.score = self:getChildGO("score")
    self.mTime = self:getChildGO("mTime")
    self.settlement_Type3Group = self:getChildGO("settlement_Type3Group")

    self.mItem1 = self:getChildGO("mItem1")
    self.mItem2 = self:getChildGO("mItem2")

    self.mTextSettlementCount_1 = self:getChildGO("mTextSettlementCount_1"):GetComponent(ty.Text)
    self.mTextSettlementCount_2 = self:getChildGO("mTextSettlementCount_2"):GetComponent(ty.Text)

    self.mImgLife = {}
    for i = 1, 3 do
        self.mImgLife[i] = self:getChildGO("mImgLife_" .. i):GetComponent(ty.Image)
    end

    self.mBtnPause = self:getChildGO("mBtnPause")
    self.mRayEmpty = self:getChildGO("mRayEmpty")

    self.mItemFunc = self:getChildGO("mItemFunc")
    self.mGroupFuncList = self:getChildTrans("mGroupFuncList")
end

function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onPause)
end

--激活
function active(self, args)
    super.active(self)

    self.isOver = false
    self.mRayEmpty:SetActive(self.isOver)

    self.mGroupFuncList.gameObject:SetActive(false)

    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_PLAYERATTR_INFO_UPDATE, self.refreshPlayerAttr, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_UPDATE_PAUSESTATE, self.refreshPauseState, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_GAMETIME_UPDATE, self.refreshDupTime, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_GAME_OVER, self.onGameOver, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_SHOWFUNCLICK, self.onShowFunclist, self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_HIDEFUNCLICK, self.onHideFunclist, self)

    local dup_id = fieldExploration.FieldExplorationManager:getDupId()
    self.mDupConfigVo = fieldExploration.FieldExplorationManager:getDupConfigVO(dup_id)

    local function _finishCall()
        self.m_startView:setActive(false)
        self:startGameTime()
        GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_GAME_START)
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
    self.score:SetActive(self.mDupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.Time_Over)
    self.mTime:SetActive(self.mDupConfigVo.settlement_type ~= FieldExplorationConst.Settlement_Type.EventDie)
    self.settlement_Type3Group:SetActive(self.mDupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.EventDie)

    self.mTextTime.text = "00:00"

    self:createSkillItem()
    self:refreshPlayerAttr({id = self.mPlayerTing.id, attr = self.mPlayerTing:getAttr()})
    self:refreshPauseState(false)

    self:setGuideTrans("guide_FieldExploration_prop_1", self:getChildTrans("guide_prop1"))
    self:setGuideTrans("guide_FieldExploration_prop_2", self:getChildTrans("guide_prop2"))
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_PLAYERATTR_INFO_UPDATE, self.refreshPlayerAttr, self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_UPDATE_PAUSESTATE, self.refreshPauseState, self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_GAMETIME_UPDATE, self.refreshDupTime, self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_GAME_OVER, self.onGameOver, self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_SHOWFUNCLICK, self.onShowFunclist, self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_HIDEFUNCLICK, self.onHideFunclist, self)

    self:recyAllItem()
    self:clearJoystick()
    self:clearFuncList()
    self.m_showFuncDataList = {}
end

function onHideFunclist(self, tag)
    self.m_showFuncDataList[tag] = nil

    if table.empty(self.m_showFuncDataList) then
        self.mGroupFuncList.gameObject:SetActive(false)
    else
        self:refreshFuncItemList()
    end

end

function onShowFunclist(self, data)
    self.mGroupFuncList.gameObject:SetActive(true)

    self.m_showFuncDataList[data.tag] = data.params

    self:refreshFuncItemList()
end

function refreshFuncItemList(self)
    self:clearFuncList()
    for tag, params in pairs(self.m_showFuncDataList) do
        for i = 1, #params do
            local item = SimpleInsItem:create(self.mItemFunc, self.mGroupFuncList, "FieldExplorationSceneUI_ClickItem")

            item:getChildGO("mTextLabel"):GetComponent(ty.Text).text = _TT(params[i].enId)
            item:addUIEvent(nil, function()
                if params[i].callback then
                    params[i].callback()
                end
            end)
            table.insert(self.mFuncItemList, item)
        end
    end

    local thing = fieldExploration.FieldExplorationSceneController:getPlayerThing()
    local followTrans = thing:getTrans()
    gs.CameraMgr:World2UIOffsetY(followTrans, self.mGroupFuncList.parent, self.mGroupFuncList, 0.5)
end

function clearFuncList(self)
    if self.mFuncItemList then
        for _, item in pairs(self.mFuncItemList) do
            item:recover()
        end
    end

    self.mFuncItemList = {}
end

function clearJoystick(self)
    if (self.mJoyStick) then
        self.mJoyStick:destroy()
        self.mJoyStick = nil
    end
end

function onPause(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FIELDEXPLORATIONPAUSEPANEL)
end

function refreshPauseState(self, pauseState)
    self.mImgStart:SetActive(pauseState)
    self.mImgPause:SetActive(not pauseState)
end

--开始倒计时
function startGameTime(self)
    if (not self.mJoyStick) then
        self.mJoyStick = fieldExploration.FieldExplorationJoystickView.new()
        self.mJoyStick:setParentTrans(self.UITrans)
    end
end

function refreshDupTime(self, time)
    if self.mDupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.EventDie then
        return
    end

    local surplustime = self.mDupConfigVo.time - time
    if surplustime < 0 then
        surplustime = 0
    end
    self.mTextTime.text = TimeUtil.getHMSByTime_1(surplustime)
end

function onGameOver(self)
    self.isOver = true
    self.mRayEmpty:SetActive(self.isOver)
    self:clearJoystick()
    self:recyAllItem()
end

function refreshPlayerAttr(self, args)
    self.mTextScore.text = args.attr.score

    if args.attr.maxLife > 0 then
        local count = 3
        local life_level = args.attr.maxLife / count

        local color = "34f552FF"
        if args.attr.life > life_level and args.attr.life <= life_level * 2 then
            color = "0056ffFF"
        elseif args.attr.life <= life_level then
            color = "FC2929FF"
        end

        for i = 1, count do
            if args.attr.life >= life_level * i then
                self.mImgLife[i].fillAmount = 1
            else
                local curlife = args.attr.life - life_level * (i - 1)
                self.mImgLife[i].fillAmount = curlife / life_level
            end

            self.mImgLife[i].color = gs.ColorUtil.GetColor(color)
        end

        self.mTextLife.text = args.attr.life
        self.mTextMaxLife.text = "/" .. args.attr.maxLife

        self.mLifeGroup:SetActive(true)
    else
        self.mLifeGroup:SetActive(false)
    end

    if self.mDupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.EventDie then
        local maxGold, maxSilver = 0, 0
        local sceneConfig = fieldExploration.FieldExplorationManager:getSceneConfigVo(self.mDupConfigVo.scene_id)
        for _, event in pairs(sceneConfig.eventList) do
            local eventConfigVo = fieldExploration.FieldExplorationManager:getEventConfigVo(event.event_id)
            if eventConfigVo then
                if eventConfigVo.type == FieldExplorationConst.EventThing_Silver then
                    maxSilver = maxSilver + 1
                elseif eventConfigVo.type == FieldExplorationConst.EventThing_Gold then
                    maxGold = maxGold + 1
                end
            end
        end

        self.mTextSettlementCount_1.text = string.format("%s/%s", args.attr.money_silver, maxSilver)
        self.mTextSettlementCount_2.text = string.format("%s/%s", args.attr.money_gold, maxGold)

        self.mItem1:SetActive(maxSilver > 0)
        self.mItem2:SetActive(maxGold > 0)
    end
end

function createSkillItem(self)
    self.mSkillItemList = {}

    self.mPlayerTing = fieldExploration.FieldExplorationSceneController:getPlayerThing()
    if self.mPlayerTing then
        local heroSkill = self.mPlayerTing:getAllSkill()
        local pos = 1
        for skillTid, skill in pairs(heroSkill) do
            self:setGuideTrans("guide_FieldExploration_Skill_" .. skillTid, self:getChildTrans("pos_" .. pos))

            local item = fieldExploration.FieldExplorationHeroSkillItem:poolGet()
            item:setData(self:getChildTrans("pos_" .. pos), skill, pos)
            pos = pos + 1

            table.insert(self.mSkillItemList, item)
        end
    end
end

function recyAllItem(self)
    if self.mSkillItemList then
        for _, item in pairs(self.mSkillItemList) do
            item:poolRecover()
        end
    end
    self.mSkillItemList = {}
end

return _M
