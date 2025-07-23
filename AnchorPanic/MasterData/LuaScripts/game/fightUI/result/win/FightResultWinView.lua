--[[ 
-----------------------------------------------------
@filename       : FightResultWinView
@Description    : 战斗结算胜利界面
@date           : 2021-01-21 13:53:28
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('fightUI.FightResultWinView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("figthtResult/FightResultWinView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构  
function dtor(self)
end

function initData(self)
    self.mHeadList = {}
    self.idx = 1
end

-- 初始化
function configUI(self)
    self.mImgToucher = self:getChildGO('mImgToucher')
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtChapter = self:getChildGO("mTxtChapter"):GetComponent(ty.Text)
    self.mTxtDup = self:getChildGO("mTxtDup"):GetComponent(ty.Text)
    self.mTxtLvl = self:getChildGO("mTxtLvl"):GetComponent(ty.Text)
    self.mTxtAddExp = self:getChildGO("mTxtAddExp"):GetComponent(ty.Text)
    -- self.mProgressBar = self:getChildGO("mProgressBar"):GetComponent(ty.ProgressBar)
    -- self.mProgressBar:InitData(0)
    self.mProgressBar = self:getChildTrans("mProgressBar")

    self.mScrollView = self:getChildGO("Scroll View"):GetComponent(ty.ScrollRect)
    self.mGroupInfo = self:getChildTrans("mGroupInfo")
    self.mGroupHead = self:getChildTrans("mGroupHead")

    -- self.mImgTitleBg = self:getChildTrans("mImgTitleBg")
    -- self.mImgTitle1 = self:getChildTrans("mImgTitle1")
    -- self.mImgTitle2 = self:getChildTrans("mImgTitle2")

    self.mPreviewBtn = self:getChildGO("mPreViewBtn")

    self.mTxtPlayerName = self:getChildGO("mTxtPlayerName"):GetComponent(ty.Text)
    -- self.mNextLevel = self:getChildGO("mBtnNextLevel")
    self.mTxtNextLevel = self:getChildGO("mTxtNextLevel"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
    self.resultData = args.resultData
    self.battleType = args.battleType
    self.battleFieldID = args.battleFieldID

    self.preResultData = fight.FightManager:getPreResultData()

    self.mImgToucher:SetActive(true)

    self:enterTween()

    self:setTimeout(1 + #self.preResultData.heroData * 0.3, function()
        self.mImgToucher:SetActive(false)
    end)

    self.mShowTime = os.time()

    if (#self.resultData.award > 0 or #self.resultData.detail_item_award > 0) and self.battleType == PreFightBattleType.ClimbTowerDup then
        self.mCloseSn = LoopManager:addTimer(2, 1, self, self.onClickClose)
    end

    local notHpPre = self.battleType == PreFightBattleType.Fashion_Imitate or self.battleType == PreFightBattleType.HeroTrial
    self.mPreviewBtn:SetActive(not notHpPre)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:sendFightOver()

    self:clearTimeout(self.timeId)
    self:removeTimerByIndex(self.timeId2)
    self:clearHeadList()
    if self.mCloseSn then 
        LoopManager:removeTimerByIndex(self.mCloseSn)
        self.mCloseSn = nil
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtDes.text = _TT(269) --'-点击屏幕继续-'
    self.mTxtNextLevel.text = _TT(44220)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mPreviewBtn, self.onPreviewClick)
    -- self:addUIEvent(self.mNextLevel, self.onClickNextLevel)

    -- self:addUIEvent(self.aa,self.onClick)
    self:addUIEvent(self.mImgToucher, self.onPreTouch)
end

-- 下一关
function onClickNextLevel(self)
    self:onClickClose()
    dup.DupClimbTowerManager:setGotoNextLevel(true, self.battleFieldID)
end

function onPreviewClick(self)
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PREVIEW_SHOW)
end

-- 关闭界面发送通知
function sendFightOver(self)
    if #self.resultData.award > 0 or #self.resultData.detail_item_award > 0 then
        local total = table.mergeAll(self.resultData.award, self.resultData.detail_item_award)
        ShowAwardPanel_New:showPropsAwardMsg(total, function()
            role.RoleController:onShowPlayerLvlUp(function()
                GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, { isWin = true })
            end)
        end)

        if (self.battleType == PreFightBattleType.ClimbTowerDup) then
            if self:isShowClimbTowerDupNext() then
                ShowAwardPanel_New:setClimbTowerData(self.battleFieldID)
            end
        end
    else
        role.RoleController:onShowPlayerLvlUp(function()
            GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, { isWin = true })
        end)
    end
end

-- 提前结束动效
function onPreTouch(self)
    if os.time() - self.mShowTime > 1 then
        self:close()
    end
end

function enterTween(self)
    -- gs.TransQuick:UIPosX(self.mImgTitleBg, -1200)
    -- self.mGroupInfo:GetComponent(ty.CanvasGroup).alpha = 0
    self.mGroupInfo.gameObject:SetActive(false)
    self.mGroupHead.gameObject:SetActive(false)
    self:updateHeadList()
    self.mGroupInfo.gameObject:SetActive(true)
    self:updateInfo()

    if #self.preResultData.heroData > 0 then
        self.timeId = self:setTimeout(0.25, function()
            self.mGroupHead.gameObject:SetActive(true)

            self.timeId2 = self:addTimer(0.07, #self.mHeadList, function()
                local item = self.mHeadList[self.idx]
                if item then
                    item:setActive(true)
                end
                self.idx = self.idx + 1
            end)
        end)
    end
    -- end)
end


-- 更新信息
function updateView(self)
    self:updateInfo()

    if #self.preResultData.heroData <= 0 then
        self.mGroupHead.gameObject:SetActive(false)
    else
        self.mGroupHead.gameObject:SetActive(true)
        for i, v in ipairs(self.mHeadList) do
            v:setActive(true)
        end
    end
    
   
end

function updateInfo(self)
    local roleVo = role.RoleManager:getRoleVo()
    local maxWidth = self.mProgressBar.sizeDelta.x

    -- self.mProgressBar:SetValue(self.preResultData.playerExp, self.preResultData.playerMaxExp)
    local temS = self.preResultData.playerExp / self.preResultData.playerMaxExp
    gs.TransQuick:SizeDelta01(self.mProgressBar, maxWidth * temS)

    self.mTxtLvl.text = "" .. self.preResultData.playerLvl
    self.mTxtPlayerName.text = roleVo:getPlayerName()

    self:setTimeout(1, function()
        if roleVo:getPlayerLvl() > self.preResultData.playerLvl then
            -- 升级
            -- self.mProgressBar:SetValue(roleVo:getPlayerExp(), roleVo:getPlayerMaxExp(), true, false, true, 1)
            -- self:setTimeout(0.3, function()
            --     self.mTxtLvl.text = "Lv." .. roleVo:getPlayerLvl()
            -- end)
            local mBarTween = self.mProgressBar:DOWidth(maxWidth, 0.5)
            mBarTween:OnComplete(function()
                self.mTxtLvl.text = "" .. roleVo:getPlayerLvl()
                gs.TransQuick:SizeDelta01(self.mProgressBar, 0)
                temS = roleVo:getPlayerExp() / roleVo:getPlayerMaxExp()
                mBarTween = self.mProgressBar:DOWidth(maxWidth * temS, 0.5)
            end)

        else
            temS = roleVo:getPlayerExp() / roleVo:getPlayerMaxExp()
            self.mProgressBar:DOWidth(maxWidth * temS, 1)
            -- self.mProgressBar:SetValue(roleVo:getPlayerExp(), roleVo:getPlayerMaxExp(), true, false, false, 1)
        end
    end)
    self.mTxtAddExp.text = "+" .. self.resultData.player_exp
    local chapterName, dupName = FightResultProxy:getDupName(self.battleType, self.battleFieldID)
    self.mTxtDup.text = dupName
    self.mTxtChapter.text = chapterName

    -- if (self.battleType == PreFightBattleType.ClimbTowerDup and #self.resultData.award == 0 and #self.resultData.detail_item_award == 0) then
    --     if self:isShowClimbTowerDupNext() then
    --         self.mNextLevel:SetActive(true)
    --     end
    -- end
end

function updateHeadList(self)
    if #self.preResultData.heroData <= 0 then
        self.mGroupHead.gameObject:SetActive(false)
    else
        -- self.mGroupHead.gameObject:SetActive(true)
        self:showHeroList()
    end
end


function showHeroList(self)
    self:clearHeadList()

    local idList = self.preResultData.heroData
    local addExpHeroCount = 0
    for k, v in pairs(idList) do
        local heroVo = hero.HeroManager:getHeroVo(v.heroId)
        if heroVo then
            if v.lvl < heroVo:getMaxMilitaryLvl() then
                addExpHeroCount = addExpHeroCount + 1
            end
        end
    end

    local exp = addExpHeroCount == 0 and 0 or math.floor(self.resultData.hero_exp / addExpHeroCount)
    for i = 1, #idList do
        local heroVo = hero.HeroManager:getHeroVo(idList[i].heroId)
        local evolutionLvl = 0
        if heroVo then
            evolutionLvl = heroVo.evolutionLvl
        end
        local preHeroData = self.preResultData.heroData[i]
        local item = fightUI.FightResultHeroItem:create(self.mGroupHead, { id = preHeroData.id, exp = exp, favorableValue = self.resultData.hero_relation, preHeroData = preHeroData, index = i - 1, evolutionLvl = evolutionLvl })
        item:setActive(false)
        table.insert(self.mHeadList, item)
    end
    if #idList > 5 then
        self.mScrollView.movementType = gs.ScrollRect.MovementType.Elastic
    else
        self.mScrollView.movementType = gs.ScrollRect.MovementType.Clamped
    end
end

-- 是否显示爬塔副本的下一关
function isShowClimbTowerDupNext(self)
    if (self.battleType == PreFightBattleType.ClimbTowerDup) then
        local cusDupId = dup.DupClimbTowerManager:curDupId()
        if cusDupId ~= 0 and cusDupId ~= tonumber(self.battleFieldID) then
            local vo = dup.DupClimbTowerManager:getDupVo(cusDupId)
            local areaVo = dup.DupClimbTowerManager:getAreaVo(vo.areaId)
            if areaVo.level <= role.RoleManager:getRoleVo():getPlayerLvl() and areaVo.areaId <= dup.DupClimbTowerManager:maxAreaId() then
                return true
            end
        end
    else
        -- local deepDupVo = dup.DupClimbTowerManager:getDeepDupVo(self.battleFieldID)
        -- local areaMsgVo = dup.DupClimbTowerManager:getDeepDetail(deepDupVo.areaId)
        -- if(areaMsgVo.curDup ~= 0) then 
        --     local week = os.date("%w", GameManager:getClientTime())
        --     local areaVo = dup.DupClimbTowerManager:getDeepAreaData()[deepDupVo.areaId]
        --     if(areaVo:getIsOpen()) then
        --         return true
        --     end
        -- end
    end
    return false
end


-- function __updateStarLvl(self,lv)
--     local mod = lv % 2
--     local sub = math.floor(lv / 2)
--     for i = 1, 6 do
--         if (i <= sub) then
--             self.m_childGos["Image" .. i]:SetActive(true)
--             self.m_childGos["Image" .. i]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("FFFB83ff")
--         else
--             if (mod == 1 and i == (sub + 1)) then
--                 self.m_childGos["Image" .. i]:SetActive(true)
--                 self.m_childGos["Image" .. i]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("D9D9D9ff")
--             else
--                 self.m_childGos["Image" .. i]:SetActive(false)
--             end
--         end
--     end

-- end

function clearHeadList(self)
    for i = 1, #self.mHeadList do
        local item = self.mHeadList[i]
        item:poolRecover()
    end
    self.mHeadList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]