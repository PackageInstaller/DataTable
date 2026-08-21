--[[ 
-----------------------------------------------------
@filename       : MainUIWallpaper
@Description    : 主界面壁纸功能
@date           : 2025-09-22 17:42:06
@Author         : Jacob
@copyright      : (LY) 2025 雷焰网络
-----------------------------------------------------
]]
module('game.mainui.view.MainUIWallpaper', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mainui/MainUIWallpaper.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mSupplyItemList = {}
    -- 自动随机壁纸时间
    self.RANDOM_TIME_DIC = { 0, 60, 180, 600 }
    -- self.RANDOM_TIME_DIC = { 0, 10, 300, 600 }
    self.mRandomTime = 0
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO(""):GetComponent(ty.Image)
    self.mImgClick = self:getChildGO("mImgClick")
    self.mBtnChange = self:getChildGO("mBtnChange")

    self.mImgPower = self:getChildTrans("mImgPower")
    self.mTxtClock = self:getChildGO("mTxtClock"):GetComponent(ty.Text)
    self.mImgWifi = self:getChildGO("mImgWifi"):GetComponent(ty.AutoRefImage)

    self.mTxtDay = self:getChildGO("mTxtDay"):GetComponent(ty.Text)

    self.mGroupInfo = self:getChildTrans("mGroupInfo")
    self.mImgLine = self:getChildTrans("mImgLine")
end

--激活
function active(self, args)
    super.active(self, args)

    self:checkRandomSetting()

    GameView.subPop.gameObject:SetActive(false)
    GameView.msg.gameObject:SetActive(false)

    self.timeTense = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.wallpaperTense)
    self.mTimerSn = LoopManager:addTimer(1, 0, self, self.onTimer)
    self:onTimer()

    GameDispatcher:addEventListener(EventName.SYSTEM_SETTING_NOTCH_CHANGE, self.setAdapta, self)
    self:setAdapta()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    if self.mTimerSn then
        LoopManager:removeTimerByIndex(self.mTimerSn)
        self.mTimerSn = nil
    end

    self.mRandomWaitTime = 0

    GameView.subPop.gameObject:SetActive(true)
    GameView.msg.gameObject:SetActive(true)

    GameDispatcher:removeEventListener(EventName.SYSTEM_SETTING_NOTCH_CHANGE, self.setAdapta, self)

    local showId = role.RoleManager:getRoleVo():getShowBoardHeroId()
    local heroVo = hero.HeroManager:getHeroVo(showId)
    if heroVo and hero.HeroInteractManager.wallpaperTempModelId and heroVo:getHeroModel() ~= hero.HeroInteractManager.wallpaperTempModelId then
        hero.HeroInteractManager.wallpaperTempModelId = nil
        mainui.MainUIManager.isDragSpine = true
        role.RoleManager:getRoleVo():dispatchEvent(role.RoleVo.CHANGE_SHOW_BOARD_HERO)
    end
    hero.HeroInteractManager.wallpaperTempModelId = nil
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mImgClick, self.onClickHide)
    self:addUIEvent(self.mBtnChange, self.onClickChange)
end

-- 设置ui节点名称（ui通过节点名拿ui节点）
-- SCENE,MAIN_UI,POP,SUB_POP,GUIDE,LOADING,ALERT,MSG
function getUiNodeName(self)
    return "ALERT"
end

function onTimer(self)
    local timeTb = TimeUtil.getServerTimeTable()
    local timeStr = ""
    if self.timeTense == 1 then
        -- 24小时
        timeStr = string.format('%02d:%02d', timeTb.hour, timeTb.min)
        gs.TransQuick:SizeDelta01(self.mImgLine, 297)
        gs.TransQuick:LPosX(self.mGroupInfo, -94)
    else
        -- 12小时
        timeStr = self:convertTo12Hour(timeTb.hour, timeTb.min)
        gs.TransQuick:SizeDelta01(self.mImgLine, 369)
        gs.TransQuick:LPosX(self.mGroupInfo, -164)
    end
    self.mTxtClock.text = timeStr
    local battery = gs.DeviceInfoMgr:GetBatteryLevel() == -1 and 1 or gs.DeviceInfoMgr:GetBatteryLevel()
    gs.TransQuick:ScaleX(self.mImgPower, battery)
    if gs.DeviceInfoMgr:GetIsWifi() == 1 then
        self.mImgWifi:SetImg(UrlManager:getPackPath("mainui/mainui_3.png"), true)
    else
        self.mImgWifi:SetImg(UrlManager:getPackPath("mainui/mainui_28.png"), true)
    end

    local time = string.getWeekNumParseWeekStr(_TT(72117), tonumber(os.date("%w")) + 1) .. " " .. os.date("%Y/%m/%d", GameManager:getClientTime())
    self.mTxtDay.text = time

    if self.mRandomTime ~= 0 then
        if not self.mRandomWaitTime then
            self.mRandomWaitTime = 0
        else
            self.mRandomWaitTime = self.mRandomWaitTime + 1
        end
        if self.mRandomWaitTime >= self.mRandomTime then
            self:onClickChange()
        end
    end
end

function convertTo12Hour(self, hour, minute)
    local period = "AM"
    if hour >= 12 then
        period = "PM"
    end
    hour = hour % 12
    if hour == 0 then
        hour = 12
    end
    return string.format("%02d:%02d<size=48>%s</size>", hour, minute, period)
end

function onClickHide(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_MAINUI_WALLPAPER)
end

-- 随机切换壁纸
function onClickChange(self)
    self.mRandomWaitTime = 0
    hero.HeroInteractManager.wallpaperTempModelId = nil

    local isShowBigHostel = bigHostel.BigHostelManager:getMainUIShow()
    if isShowBigHostel then
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_LIVE_SETTRIGGER, BigHostelConst.BaseAnimatorParams.Switch)
        return
    end


    mainui.MainUIManager.isDragSpine = true

    local isShowSpine = mainui.MainUIManager:getIsShowDynamic()

    if isShowSpine == 1 then
        local fashionList = {}
        local dic = fashion.FashionManager:getAllHeroFashion()

        local guradType, guradId
        local paintingList = purchase.FashionShopManager:getAllUnlockPatintingData()
        local isShowHero = 0
        if paintingList and #paintingList > 0 then
            isShowHero = math.random(0, 1)
        end
        if isShowHero == 0 then
            for k, list in pairs(dic) do
                for _, fashionVo in pairs(list) do
                    local heroVo = hero.HeroManager:getHeroVo(fashionVo.heroId)
                    local fashionConfigVo = fashion.FashionManager:getFashionData(heroVo.tid, fashionVo.fashionId)
                    if hero.HeroInteractManager:getModelIsDynamic(fashionConfigVo.model) then
                        table.insert(fashionList, fashionVo)
                    end
                end
            end

            local fashionVo = fashionList[math.random(1, #fashionList)]
            if fashionVo.isWear then
                local heroVo = hero.HeroManager:getHeroVo(fashionVo.heroId)
                local fashionConfigVo = fashion.FashionManager:getFashionData(heroVo.tid, fashionVo.fashionId)
                GameDispatcher:dispatchEvent(EventName.REQ_CHANGE_SHOW_BOARD_HERO, { heroId = fashionVo.heroId })
                guradId = fashionConfigVo.model
            else
                local heroVo = hero.HeroManager:getHeroVo(fashionVo.heroId)
                local fashionConfigVo = fashion.FashionManager:getFashionData(heroVo.tid, fashionVo.fashionId)
                hero.HeroInteractManager.wallpaperTempModelId = fashionConfigVo.model --只针对没有穿戴的临时皮肤（图册不需要管）

                -- GameDispatcher:dispatchEvent(EventName.MAINUI_SPINE_MODEL_CHANGE)
                -- GameDispatcher:dispatchEvent(EventName.REFRESH_MIAN_UI_MODEL)
                -- role.RoleManager:getRoleVo():dispatchEvent(role.RoleVo.CHANGE_SHOW_BOARD_HERO)
                guradId = fashionConfigVo.model
            end
            guradType = role.GuradType.Gurad_hero
        else
            local paintingDataVo = paintingList[math.random(1, #paintingList)]

            guradId = paintingDataVo.id
            guradType = role.GuradType.Gurad_painting
        end

        role.RoleManager:setMainUISpineTypeAndId(guradType, guradId)
        GameDispatcher:dispatchEvent(EventName.REFRESH_MIAN_UI_MODEL)
    else

        -- local heroList = {}
        -- local isShowSpine = mainui.MainUIManager:getIsShowDynamic()
        local heroAllList = hero.HeroManager:getHeroList()
        -- for i, heroVo in ipairs(heroAllList) do
        --     if isShowSpine == 0 or (isShowSpine == 1 and hero.HeroInteractManager:getModelIsDynamic(heroVo:getHeroModel())) then
        --         table.insert(heroList, heroVo)
        --     end
        -- end
        local heroVo = heroAllList[math.random(1, #heroAllList)]
        GameDispatcher:dispatchEvent(EventName.REQ_CHANGE_SHOW_BOARD_HERO, { heroId = heroVo.id })
    end

end

-- 随机壁纸设置时间
function checkRandomSetting(self)
    local randomTimeIndex = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.wallpaperRandomTime)
    self.mRandomTime = self.RANDOM_TIME_DIC[randomTimeIndex]
end

function __playOpenAction(self)
end
function __closeOpenAction(self)
    self:close()
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]