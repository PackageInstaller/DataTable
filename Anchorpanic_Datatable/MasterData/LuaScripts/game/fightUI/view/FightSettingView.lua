--[[-----------------------------------------------------
@filename       : FightSettingView
@Description    : 战斗设置（新）
@date           : 2021-12-22 11:08:43
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.fightUI.view.FightSettingView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fight/FightSettingView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0
isAdapta = 0 --是否开启适配刘海

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(950, 540)
    self:setTxtTitle(_TT(3049))
    --self:setSize(1120, 520)
end
--析构
function dtor(self)
end

function initData(self)
    self.SETTING_ITEM1_INFOs = {
        { gstor.FIGHT_JUMP_CAMERA, _TT(3008), sysParam.SysParamManager:getValue(SysParamType.FIGHT_JUMP_CAMERA) == 1 },
        { gstor.FIGHT_HIDE_INFO, _TT(3081), sysParam.SysParamManager:getValue(SysParamType.FIGHT_HIDE_INFO) == 1 },
        { gstor.FIGHT_SHOW_AUTO_HP, _TT(3089), false, gstor.FIGHT_SHOW_AUTO_HP_BUFF },
    -- { gstor.FIGHT_SKIP_SKILL, "跳过技能后摇", sysParam.SysParamManager:getValue(SysParamType.FIGHT_JUMP_CAMERA) == 1 },
    -- { gstor.FIGHT_SHOW_HP, _TT(3009), sysParam.SysParamManager:getValue(SysParamType.FIGHT_SHOW_HP) == 1 },
    -- { gstor.FIGHT_SHOW_DAMAGE, _TT(3010), sysParam.SysParamManager:getValue(SysParamType.FIGHT_SHOW_DAMAGE) == 1 },
    -- { gstor.FIGHT_SHOW_PROFESSIONTYPE, _TT(3026), sysParam.SysParamManager:getValue(SysParamType.FIGHT_SHOW_PROFESSIONTYPE) == 1 },
    }
    -- self.SETTING_HIDE_UI = { gstor.FIGHT_SHOW_UI, _TT(3011), sysParam.SysParamManager:getValue(SysParamType.FIGHT_SHOW_UI) == 1 }
    -- self.SETTING_SHOW_COUNT = { gstor.FIGHT_QUEUE10, _TT(3012), sysParam.SysParamManager:getValue(SysParamType.FIGHT_QUEUE10) == 1 }

end

-- 初始化
function configUI(self)
    -- self.mGoClose = self:getChildGO("mImgClose")
    -- self.mTxtPanelTitle = self:getChildGO("mTxtPanelTitle"):GetComponent(ty.Text)
    -- self.aa = self:getChildGO("aa"):GetComponent(ty.Image)
    self.mGroupTab = self:getChildTrans("mGroupTab")

    self.mGroupFightGo = self:getChildGO("mGroupFight")
    self.mGroupFightTrans = self:getChildTrans("mGroupFight")
    self.mGroupUiGo = self:getChildGO("mGroupUi")
    self.mGroupUiTrans = self:getChildTrans("mGroupUi")

    self.mBtnContinue = self:getChildGO("mBtnContinue")
    self.mBtnQuit = self:getChildGO("mBtnQuit")
end

--激活
function active(self)
    super.active(self)
    -- self:updateTab()
    self:updateFight()
    -- self:updateHideUI()
    -- self:updateShowCount()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItem()

    if self.tabBar then
        self.tabBar:reset()
        self.tabBar = nil
    end

    GameDispatcher:dispatchEvent(EventName.FIGHT_SETTING_SAVE)
end

--[[    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self.mTxtPanelTitle.text = _TT(3049)
    self:setBtnLabel(self.mBtnContinue, 3014, "继续战斗")
    self:setBtnLabel(self.mBtnQuit, 3013, "退出战斗")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.mGoClose, self.close, self:getCloseSoundPath())
    self:addUIEvent(self.mBtnQuit, self.onClickQuit)
    self:addUIEvent(self.mBtnContinue, self.onClickClose)
end
-- 退出战斗
function onClickQuit(self)

    if fight.FightManager:getBattleType() == PreFightBattleType.Arena_Peak_Pvp and fight.FightManager:isReplaying() == false then
        -- gs.Message.Show("当前战斗不可以中途退出哦")
        gs.Message.Show(_TT(92022))
        return
    end

    if fight.FightManager:getBattleType() == PreFightBattleType.GuildWar and fight.FightManager:isReplaying() == false then
        -- gs.Message.Show("当前战斗不可以中途退出哦")
        gs.Message.Show(_TT(92022))
        return
    end

    if fight.FightManager:isReplaying() then
        fight.FightManager:setManualExitReplay(true)
        fight.FightManager:reqBattleQuit()
        self:close()
        return
    end

    local function _resultCall()
        if fight.SceneManager:isInFightScene() then
            fight.FightManager:reqBattleQuit()
        end
        self:close()
    end

    local mainExploreDupConfigVo = nil
    if (fight.FightManager:getBattleType() == PreFightBattleType.MainExplore) then
        mainExploreDupConfigVo = mainExplore.MainExploreSceneManager:getDupConfigVo(tonumber(fight.FightManager:getBattleFieldID()))
    end
    if (mainExploreDupConfigVo and mainExploreDupConfigVo:getFailEffect() > 0) then
        UIFactory:alertMessge(string.substitute(_TT(63006), mainExploreDupConfigVo:getFailEffect()), true, _resultCall, nil, nil, true)
    else
        if (fight.FightManager:getBattleType() == PreFightBattleType.Guild_boss_war or fight.FightManager:getBattleType() == PreFightBattleType.Guild_Sweep) then
            UIFactory:alertMessge(_TT(94601), true, _resultCall, nil, nil, true)
        elseif (fight.FightManager:getBattleType() == PreFightBattleType.Guild_boss_imitate) then
            _resultCall()
        elseif (fight.FightManager:getBattleType() == PreFightBattleType.Disaster or fight.FightManager:getBattleType() == PreFightBattleType.Disater_imitate) then
            _resultCall()
        else
            UIFactory:alertMessge(_TT(3015), true, _resultCall, nil, nil, true)
        end
    end
end
-- 页签
function updateTab(self)
    local list = {}
    list[1] = { page = 1, nomalLan = _TT(3006), nomalLanEn = "" }
    list[2] = { page = 2, nomalLan = _TT(3007), nomalLanEn = "" }
    self.tabBar = CustomTabBar:create(self:getChildGO("GroupTabItem"), self.mGroupTab, self.setPage, self)
    self.tabBar:setData(list)
    self.tabBar:setPage(1)
end

function setPage(self, page)
    if page == 1 then
        self.mGroupFightGo:SetActive(true)
        self.mGroupUiGo:SetActive(false)
    else
        self.mGroupFightGo:SetActive(false)
        self.mGroupUiGo:SetActive(true)
    end
end
-- 战斗设置
function updateFight(self)
    self:recoverItem()
    self.mBtnQuit:GetComponent(ty.Button).interactable = fight.FightManager:getBattleType() ~= PreFightBattleType.Arena_Peak_Pvp

    --self.mBtnQuit:SetActive(fight.FightManager:getBattleType() ~= PreFightBattleType.Arena_Peak_Pvp)

    for i, v in ipairs(self.SETTING_ITEM1_INFOs) do
        local item = SimpleInsItem:create(self:getChildGO("GroupSettingItem"), self.mGroupFightTrans, "FightSettingViewSettingItem")
        item:setText("mTxtInfo", nil, v[2])
        item:getChildGO("mToggle2"):SetActive(false)

        local val = v[3]
        if StorageUtil:hasKey1(v[1]) == true then
            val = StorageUtil:getBool1(v[1])
        else
            StorageUtil:saveBool1(v[1], v[3])
        end


        local onToggle = function(val)
            StorageUtil:saveBool1(v[1], val)
        end
        item:getChildGO("mToggle"):GetComponent(ty.Toggle).onValueChanged:AddListener(onToggle)
        item:getChildGO("mToggle"):GetComponent(ty.Toggle).isOn = val

        if v[4] then
            local val2 = v[3]
            item:getChildGO("mToggle2"):SetActive(true)
            if StorageUtil:hasKey1(v[4]) == true then
                val2 = StorageUtil:getBool1(v[4])
            else
                StorageUtil:saveBool1(v[1], v[3])
            end

            local onToggle2 = function(val)
                StorageUtil:saveBool1(v[4], val)
            end
            item:getChildGO("mToggle2"):GetComponent(ty.Toggle).onValueChanged:AddListener(onToggle2)
            item:getChildGO("mToggle2"):GetComponent(ty.Toggle).isOn = val2
        end

        table.insert(self.fightItemList, item)
    end
end
-- 隐藏UI
function updateHideUI(self)
    if not self.hideUiItem then
        self.hideUiItem = SimpleInsItem:create2(self:getChildGO("GroupSettingItem1"))

        self.hideUiItem:setText("mTxtInfo", nil, self.SETTING_HIDE_UI[2])

        local val = self.SETTING_HIDE_UI[3]
        if StorageUtil:hasKey1(self.SETTING_HIDE_UI[1]) == true then
            val = StorageUtil:getBool1(self.SETTING_HIDE_UI[1])
        else
            StorageUtil:saveBool1(self.SETTING_HIDE_UI[1], self.SETTING_HIDE_UI[3])
        end

        local onToggle = function(val)
            StorageUtil:saveBool1(self.SETTING_HIDE_UI[1], val)
        end
        self.hideUiItem:getChildGO("mToggle"):GetComponent(ty.Toggle).onValueChanged:AddListener(onToggle)

        self.hideUiItem:getChildGO("mToggle"):GetComponent(ty.Toggle).isOn = val
    end
end
-- 队列数设置
function updateShowCount(self)

    if not self.showCountItem then
        self.showCountItem = SimpleInsItem:create2(self:getChildGO("GroupSettingItem2"))

        self.showCountItem:setText("mTxtInfo", nil, self.SETTING_SHOW_COUNT[2])
        self.showCountItem:setText("mTxtToggle5", 3050, _TT(3050))
        self.showCountItem:setText("mTxtToggle10", 3051, _TT(3051))

        local val1 = self.SETTING_SHOW_COUNT[3] == false
        local val2 = self.SETTING_SHOW_COUNT[3]
        if StorageUtil:hasKey1(self.SETTING_SHOW_COUNT[1]) == true then
            val1 = (StorageUtil:getBool1(self.SETTING_SHOW_COUNT[1]) == false)
            val2 = StorageUtil:getBool1(self.SETTING_SHOW_COUNT[1])
        else
            StorageUtil:saveBool1(self.SETTING_SHOW_COUNT[1], self.SETTING_SHOW_COUNT[3])
        end

        local onToggle5 = function(val)
            if val then
                StorageUtil:saveBool1(self.SETTING_SHOW_COUNT[1], false)
            end
        end
        self.showCountItem:getChildGO("mToggle5"):GetComponent(ty.Toggle).onValueChanged:AddListener(onToggle5)

        self.showCountItem:getChildGO("mToggle5"):GetComponent(ty.Toggle).isOn = val1
        self.showCountItem:getChildGO("mToggle10"):GetComponent(ty.Toggle).isOn = val2

        local onToggle10 = function(val)
            if val then
                StorageUtil:saveBool1(self.SETTING_SHOW_COUNT[1], true)
            end
        end
        self.showCountItem:getChildGO("mToggle10"):GetComponent(ty.Toggle).onValueChanged:AddListener(onToggle10)
    end
end

-- 回收项
function recoverItem(self)
    if self.fightItemList then
        for i, v in pairs(self.fightItemList) do
            v:poolRecover()
        end
    end
    self.fightItemList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(3051):"10人"
语言包: _TT(3050):"5人"
语言包: _TT(3049):"<size=24>战</size>斗设置"
]]