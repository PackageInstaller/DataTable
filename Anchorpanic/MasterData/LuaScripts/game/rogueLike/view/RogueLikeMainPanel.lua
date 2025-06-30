--[[ 
-----------------------------------------------------
@filename       : RogueLikeMainPanel
@Description    : 肉鸽主界面界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("rogueLike.RogueLikeMainPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(331))
    self:setBg("")
end

-- 析构
function dtor(self)
end

function initData(self)
    self.selectLevel = 1
    self.canReset = false
end

-- 初始化
function configUI(self)
    super.configUI(self)

    --self.videoPlayer = self:getChildGO("Video Player"):GetComponent(ty.VideoPlayer)
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mTxtFight = self:getChildGO("mTxtFight"):GetComponent(ty.Text)
    self.mBtnReset = self:getChildGO("mBtnReset")
    self.mBtnTask = self:getChildGO("mBtnTask")
    self.mBtnCollection = self:getChildGO("mBtnCollection")
    self.mBtnRank = self:getChildGO("mBtnRank")
    self.mBtnShop = self:getChildGO("mBtnShop")

    --self.mBtnLevel = self:getChildGO("mBtnLevel")
    --self.mBtnLevelCanvasGroup = self:getChildGO("mBtnLevel"):GetComponent(ty.CanvasGroup)
    --self.mBtnLevelTran = self:getChildTrans("mBtnLevel")
    self.mBtnItem = self:getChildGO("mBtnItem")

    self.mTxtReset = self:getChildGO("mTxtReset"):GetComponent(ty.Text)
    self.mTxtPro = self:getChildGO("mTxtPro"):GetComponent(ty.Text)
    self.mBtnHero = self:getChildGO("mBtnHero")
    --self.mBtnLevelList = {}

    self.mRemainingTime = self:getChildGO("mRemainingTime"):GetComponent(ty.Text)
    self.mBtnRank:SetActive(false)

    self:setGuideTrans("funcTips_rogueLike_timeTips", self:getChildTrans("mTimetips"))
    self:setGuideTrans("funcTips_rogueLike_collection", self:getChildTrans("mBtnCollection"))
    self:setGuideTrans("funcTips_rogueLike_task", self:getChildTrans("mBtnTask"))
    self:setGuideTrans("funcTips_rogueLike_fight", self:getChildTrans("mBtnFight"))
end

-- 激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ROGUELIKE_TID })
    GameDispatcher:addEventListener(EventName.UPDATE_ROGUELIKE_MAIN_PANEL, self.updateMainPanel, self)

    self:showView()
    self:updateRedPoint()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    LoopManager:removeTimer(self, self.__updateResetTime)
    LoopManager:removeTimer(self, self.updateResRogueLiekTime)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    GameDispatcher:removeEventListener(EventName.UPDATE_ROGUELIKE_MAIN_PANEL, self.updateMainPanel, self)
    self:clearDiffList()
    -- if self.videoPlayer then
    --     self.videoPlayer:Stop()
    --     --self.videoPlayer = nil
    -- end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onFightClick)
    self:addUIEvent(self.mBtnReset, self.mBtnResetClick)
    self:addUIEvent(self.mBtnTask, self.mBtnTaskClick)
    self:addUIEvent(self.mBtnRank, self.mBtnRankClick)
    self:addUIEvent(self.mBtnShop, self.mBtnShopClick)
    self:addUIEvent(self.mBtnCollection, self.mBtnCollectionClick)

    self:addUIEvent(self.mBtnHero, self.mBtnHeroClick)
end

function updateRedPoint(self)
    if mainui.MainUIManager:getRedFuncIdDicFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, funcopen.FuncOpenConst.FUNC_ID_ROGUE) then
        RedPointManager:add(self.mBtnTask.transform, nil, -36, 36)
    else
        RedPointManager:remove(self.mBtnTask.transform)
    end
end

function onLevelChangeClick(self, selectLevel)
    self.selectLevel = selectLevel
    --self:updateLevelBtn()
end

function updateLevelBtn(self)
    -- for i = 1, #self.mBtnLevelList do
    --     self.mBtnLevelList[i]:getChildGO("mIsSelect"):SetActive(self.selectLevel == i)
    -- end
end

function updateMainPanel(self)
    self:showView()
end

function __updateResetTime(self)
    local currentTime = GameManager:getClientTime()
    local reamainTime = self.mResetTime - currentTime

    if (reamainTime <= 0) then
        LoopManager:removeTimer(self, self.__updateResetTime)
        -- self.canReset = true
        -- self.mTxtReset.text = ""
        -- self.mTxtReset.gameObject:SetActive(false)
        self:showView()
        return
    else
        self.mTxtReset.gameObject:SetActive(not self.canReset)
        self.mTxtReset.text = "冷却时间:" .. TimeUtil.getFormatTimeBySeconds_1(reamainTime)
    end
end

function updateResRogueLiekTime(self)
    --local currentTime = GameManager:getClientTime()

    --local reamainTime = self.mResRogueLikeTime - currentTime

    --if (reamainTime <= 0) then
    --    LoopManager:removeTimer(self, self.updateResRogueLiekTime)
    --else
    -- local wday = tonumber(os.date("%w")) == 0 and 7 or tonumber(os.date("%w"))
    -- wday = (wday == 1 and tonumber(os.date("%H")) < 5) and 8 or wday
    -- local endTime = ((8 - wday) * 24 * 3600) - os.date("%H") * 3600 - os.date("%M") * 60 - os.date("%S") + 5 * 3600
    -- self.mRemainingTime.text = TimeUtil.getFormatTimeBySeconds_1(endTime)
    --end

    local currentTime = GameManager:getClientTime()
    local reamainTime = GameManager:getWeekResetTime() - currentTime
    self.mRemainingTime.text = TimeUtil.getFormatTimeBySeconds_1(reamainTime)
end

function showView(self)

    -- local videoUrl = gs.PathUtil.GetExistFullPath("extra/video/ui/roguelike_cg.mp4")
    -- self.videoPlayer.url = videoUrl
    -- self.videoPlayer:Play()


    -- if systemSetting.SystemSettingManager:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.totalVolumeSwitch) and
    -- systemSetting.SystemSettingManager:getSystemSettingBoolValue(systemSetting.SystemSettingDefine.musicVolumeSwitch) then
    --     self.videoPlayer:SetDirectAudioVolume(0, systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.musicVolume) / 100)
    -- else
    --     self.videoPlayer:SetDirectAudioVolume(0, 0)
    -- end

    self.mResetTime = rogueLike.RogueLikeManager:getResetTime()
    local currentTime = GameManager:getClientTime()
    local reamainTime = self.mResetTime - currentTime
    self.canReset = reamainTime <= 0
    self.mTxtReset.text = ""
    self.mTxtReset.gameObject:SetActive(not self.canReset)
    if not self.canReset then
        LoopManager:addTimer(0, 0, self, self.__updateResetTime)
    end


    --self.mResRogueLikeTime = rogueLike.RogueLikeManager:getResRogueLikeTime()
    LoopManager:addTimer(0, 0, self, self.updateResRogueLiekTime)

    -- self:clearDiffList()
    -- local difDic = rogueLike.RogueLikeManager:getDifficultyDic()
    -- for id, data in pairs(difDic) do
    --     local item = SimpleInsItem:create(self.mBtnItem, self.mBtnLevelTran, "difficulty" .. id)
    --     item:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(data.name)

    --     local function callFun()
    --         self:onLevelChangeClick(id)
    --     end

    --     item:addUIEvent(nil, callFun)
    --     table.insert(self.mBtnLevelList, item)
    -- end

    local difficulty = rogueLike.RogueLikeManager:getRogueDifficulty()
    if difficulty == nil or difficulty == 0 then
        self.mTxtPro.text = ""
        self.mTxtFight.text = "开始战斗"
        ---self.mBtnLevel:SetActive(true)
        ---self.mBtnLevelCanvasGroup.interactable = true
        ---self.mBtnLevelCanvasGroup.blocksRaycasts = true
        self.mBtnReset:SetActive(false)
    else
        local name = rogueLike.RogueLikeManager:getSingleDifficulty(difficulty).name
        local layout = rogueLike.RogueLikeManager:getRogueLayout()
        self.mTxtPro.text = "当前进度:<color=#00EAFF>" .. _TT(name) .. "(" .. layout .. ")</color>"

        self.mTxtFight.text = "继续战斗"
        self.mBtnReset:SetActive(true)
        -- self.mBtnLevel:SetActive(false)
        ---self.mBtnLevelCanvasGroup.interactable = false
        ---self.mBtnLevelCanvasGroup.blocksRaycasts = false
        self.selectLevel = difficulty
    end
    self:updateLevelBtn()
end

function clearDiffList(self)
    -- for i = 1, #self.mBtnLevelList do
    --     self.mBtnLevelList[i]:recover()
    -- end
    -- self.mBtnLevelList = {}
end

-- 开始按钮点击
function onFightClick(self)
    -- 如果已经有了服务器的数据就不再请求 直接打开面板
    local difficulty = rogueLike.RogueLikeManager:getRogueDifficulty()

    if not self.canReset then
        gs.Message.Show("未到时间不能进入游戏")
        return
    end


    if difficulty == nil or difficulty == 0 then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_LEVEL_SELECT_PANEL)
        --GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_START, {level = self.selectLevel})
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_MAP_PANEL, self)
    end
end

-- 重置按钮点击
function mBtnResetClick(self)
    if self.canReset then
        UIFactory:alertMessge(_TT(56071), true, function()
            GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_RESET)
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
        --GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_RESET)
    else
        gs.Message.Show(_TT(56079))
    end
end

-- 任务面板点击
function mBtnTaskClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_TASK_PANEL)
end

-- 收藏品界面
function mBtnCollectionClick(self)
    GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_COLLECTION)
end

---排行榜界面
function mBtnRankClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RANK_MAIN_PANEL, { type = rank.RankConst.RANK_ROGUELIKE })
end

-- 肉鸽商店
function mBtnShopClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.ShopRogueLike })
end

--战员按钮
function mBtnHeroClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Hero })
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]