--[[   
     主UI数据管理
]]
module("mainui.MainUIManager", Class.impl(Manager))


--构造函数
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构函数
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:init()
end

function init(self)
    self.m_mainuiInitComplete = false
    self.m_showUIDic = {}
    self.m_iconDic = {}

    -- 红点状态改变
    self.isRedFlagUdpate = false
    -- 红点状态列表
    self.mRedFlag = {}
    -- 头像位置红点
    self.mHudRedFlag = {}

    self.mRedFuncIdDic = {}

    -- 是否已播放欢迎cv
    self.mIsPlayFirstCv = false

    -- 战员是否已经初始化
    self.isHeroInit = false

    -- 等待主场景加载完成后需要打开的uicode
    self.mWaitOpenUICode = 0

    -- 是否拖拽改变spine
    self.isDragSpine = nil

    -- 是否展示交互场景
    self.isShowBigHostel = nil

    -- 付费活动相关功能开放id manager需要拥有函数 checkShowState()
    self.activityFuncList = {
        { funcId = funcopen.FuncOpenConst.FUNC_ID_FIRSTCHARGE, mgr = firstCharge.FirstChargeManager },
        { funcId = funcopen.FuncOpenConst.FUNC_ID_GROWTHFUND, mgr = purchase.GrowthFundManager },
        { funcId = funcopen.FuncOpenConst.FUNC_ID_PERMIT, mgr = permit.PermitManager },
        { funcId = funcopen.FuncOpenConst.FUNC_ID_HOME_SIGNIN, mgr = dailyCheckIn.DailyCheckInManager },
    --{ funcId = funcopen.FuncOpenConst.FUNC_ID_FASHIONPERMIT, mgr = fashionPermit.FashionPermitManager },
    }
end

-- 主UI初始化完成
function setMainUIInitComplete(self, value)
    if self.m_mainuiInitComplete ~= value then
        self.m_mainuiInitComplete = value
        GameDispatcher:dispatchEvent(EventName.MAINUI_INIT_COMPLATE)
    end
end

function getMainUIInitComplete(self)
    return self.m_mainuiInitComplete
end

-- 注册图标
function registerIcon(self, cusId, cusType, cusIcon, ignoreRed)
    self.m_iconDic[cusId] = { icon = cusIcon, type = cusType, ignore = ignoreRed }
end

-- 获取图标
function getFuncIcon(self, cusId)
    return self.m_iconDic[cusId]
end

-- 删除图标
function deleteIcon(self, cusId)
    if self.m_iconDic[cusId] ~= nil then
        self.m_iconDic[cusId] = nil
    end
end

-- 设置红点状态  当一个按钮有多个功能时，需要传入具体的funcId（参考：FUNC_ID_ADVENTURE）
function setRedFlag(self, key, value, funcId)
    local flag = value
    if funcId then
        if not self.mRedFuncIdDic[key] then
            self.mRedFuncIdDic[key] = {}
        end
        self.mRedFuncIdDic[key][funcId] = value

        for i, v in pairs(self.mRedFuncIdDic[key]) do
            if v then
                flag = v
                break
            end
        end
    end

    self.mRedFlag[key] = flag
    self.isRedFlagUdpate = true
end

-- 获取红点状态列表
function getRedFlag(self)
    return self.mRedFlag
end

-- 根据功能id获取红点字典key主功能 funcId分支id
function getRedFuncIdDicFlag(self, key, funcId)
    return self.mRedFuncIdDic[key][funcId]
end

-- 设置头像位置红点
function setHudRed(self, funcId, value)
    --cb2屏蔽
    -- self.mHudRedFlag[funcId] = value
    -- for k, v in pairs(self.mHudRedFlag) do
    --     if v then
    --         self:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_HOME, true)
    --         return
    --     end
    -- end
    -- self:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_HOME, false)
end


-- 根据地图类型设置UI是否显示
function setUIShow(self)
    self.m_showUIDic = {}
    local isSwitch = nil
    local curMapType = map.MapManager:getMapType()

    -- 设置需要显示的UI
    if curMapType == MAP_TYPE.MAIN_CITY then
        self.m_showUIDic[UI_TYPE.MAIN] = true
        self.m_showUIDic[UI_TYPE.ROLE_HEAD] = true
        self.m_showUIDic[UI_TYPE.LEFE_UP] = true
        self.m_showUIDic[UI_TYPE.RIGHT_UP] = true
        self.m_showUIDic[UI_TYPE.BOTTOM] = true
        isSwitch = true
    elseif curMapType == MAP_TYPE.FIGHT_MAP then

    end

    if isSwitch ~= nil then
        self:isSwitchUI(isSwitch)
    else
        GameDispatcher:dispatchEvent(EventName.UI_SHOW_CHANGE)
    end
end

-- 关闭所有主界面UI
function closeAllUI(self)
    self.m_showUIDic = {}
    GameDispatcher:dispatchEvent(EventName.UI_SHOW_CHANGE)
end

-- 是否展开UI
function isSwitchUI(self, cusB)
    local b = cusB == nil and true or cusB
    GameDispatcher:dispatchEvent(EventName.UI_SHOW_CHANGE, { isSwitch = b })
end

-- 获取指定UI是否显示
function getUIIsShow(self, cusType)
    if self.m_showUIDic[cusType] ~= nil then
        return self.m_showUIDic[cusType]
    end
    return false
end

-- 展示互动
function getHeroInteract(self, cusInteractId)
    local heroVo = hero.HeroManager:getHeroVo(role.RoleManager:getRoleVo():getShowBoardHeroId())
    if (not heroVo) then
        local list = hero.HeroManager:getHeroList()
        if list and #list > 0 then
            heroVo = list[1]
        end
    end
    if not heroVo then
        return
    end

    local baseData = hero.HeroInteractManager:getConfigData(heroVo:getHeroModel())
    if not baseData then
        logError("没有该英雄互动配置", "MainUIManager")
        return
    end
    local len = #baseData.interact
    local random = self:getNoRepeatRandom(len)
    local interactId = cusInteractId or random
    local data = baseData.interact[interactId]

    return true, data
end
-- 去重随机
function getNoRepeatRandom(self, max)
    if (max <= 1) then
        return max
    else
        local rand = math.random(1, max)
        if not self.lastRandom or self.lastRandom ~= rand then
            self.lastRandom = rand
            return rand
        end
        return self:getNoRepeatRandom(max)
    end
end

-- 互动是否已结束
function isInteractOver(self)
    return self.m_IsInteract or false
end
-- 强制关闭互动
function setIsInteract(self, value)
    self.m_IsInteract = value
end

function cancelFirstCV(self)
    self.mIsPlayFirstCv = true

    if self.mlazySn then
        LoopManager:clearTimeout(self.mlazySn)
        self.mlazySn = nil
    end
end

function setHeroInit(self)
    self.isHeroInit = true
end

function getHeroInit(self)
    return self.isHeroInit
end

function setMainUIOpen(self, isOpen)
    self.isMainUIOpen = isOpen
end

function getMainUIOpen(self)
    return self.isMainUIOpen
end

function setCurPlayCv(self, audioData)
    self.m_curCvAudioData = audioData
end

function StopCvMutual(self)
    GameDispatcher:dispatchEvent(EventName.MAINUI_LIVEVIEW_CVCALLFINISH)
    self:setIsInteract(false)

    self:stopCurPlayCv()
end

function stopCurPlayCv(self)
    if not self.m_curCvAudioData then return end

    AudioManager:stopAudioSound(self.m_curCvAudioData)
    self:setCurPlayCv(nil)
end

-- 播放首次的CV
function playFirstCV(self)
    if self.mIsPlayFirstCv == false and self.isHeroInit and self.isMainUIOpen then
        local function lazyCall()
            self.mlazySn = nil
            local roleVo = role.RoleManager:getRoleVo()
            if roleVo then
                local heroVo = hero.HeroManager:getHeroVo(roleVo:getShowBoardHeroId())
                if (not heroVo) then
                    local list = hero.HeroManager:getHeroList()
                    if list and #list > 0 then
                        heroVo = list[1]
                    end
                end
                if heroVo then
                    local finishPlayCvCall = function()
                        GameDispatcher:dispatchEvent(EventName.MAINUI_LIVEVIEW_CVCALLFINISH)
                        mainui.MainUIManager:setCurPlayCv(nil)
                    end

                    local audioData, cvId = AudioManager:playHeroCVByFieldName(heroVo.tid, "hello_voice", finishPlayCvCall)
                    if audioData then
                        self:setCurPlayCv(audioData)
                        local cvData = AudioManager:getCVData(cvId)
                        GameDispatcher:dispatchEvent(EventName.SHOW_HERO_INTERACT_TEXT_ONLY, cvData.lines)
                    end
                    self.mIsPlayFirstCv = true
                end
            end
        end
        LoopManager:clearTimeout(self.mlazySn)
        self.mlazySn = LoopManager:setTimeout(0, self, lazyCall)
    end
end

-- 设置等待主场景加载完成后需要打开的uicode
function setWaitOpenUIcode(self, linkId)
    self.mWaitOpenUICode = linkId
end

-- 获取等待主场景加载完成后需要打开的uicode
function getWaitOpenUIcode(self)
    return self.mWaitOpenUICode
end

-- 获取是否显示动态立绘状态
function getIsShowDynamic(self)
    return StorageUtil:getNumber1(gstor.MAINUI_SHOW_DYNAMIC_PIC)
end

-- 设置是否显示动态立绘状态
function setIsShowDynamic(self, value)
    StorageUtil:saveNumber1(gstor.MAINUI_SHOW_DYNAMIC_PIC, value)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]