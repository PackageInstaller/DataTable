--[[ 
-----------------------------------------------------
@filename       : DupApostlesMainPanel
@Description    : 使徒之战
@date           : 2022-06-13 15:03:15
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostle_war.view.DupApostlesMainPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupApostleWar/DupApostlesMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52089))
    self:setBg("dup_apostles_bg_2.jpg", false, "dup5")
end

--析构  
function dtor(self)
end

function initData(self)
    self.mEnterItemList = {}
    self.mDifficultyList = { "Ⅰ", "Ⅱ", "Ⅲ" }
    self.updateTime = 1
    self.data = dup.DupApostlesWarManager:getPanelInfo()
    self.configVo = dup.DupApostlesWarManager:getClositerDataById(self.data.id)
end

-- 初始化
function configUI(self)
    self.mTxtNowDiff = self:getChildGO("mTxtNowDiff"):GetComponent(ty.Text)
    self.mTxtLevel = self:getChildGO("mTxtLevel"):GetComponent(ty.Text)
    self.mTxt = self:getChildGO("mTxt"):GetComponent(ty.Text)

    self.mTxtDifficulty = self:getChildGO("mTxtDifficulty"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mBtnShop = self:getChildGO("mBtnShop")
    self.mBtnStage = self:getChildGO("mBtnStage")
    self.mNextAward = self:getChildTrans("mNextAward")
    self.mImgPro = self:getChildGO("mImgPro"):GetComponent(ty.Image)
    self.mTxtStageNum = self:getChildGO("mTxtStageNum"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtTimes = self:getChildGO("mTxtTimes"):GetComponent(ty.Text)

    self.mBossContent = self:getChildTrans("mBossContent")
    self.DupApostlesEnterItem = self:getChildGO("DupApostlesEnterItem")

    self.Receive = self:getChildGO("Receive")
    self.Complete = self:getChildGO("Complete")

    self:setGuideTrans("funcTips_apostles_1", self:getChildTrans("mGuideApostles1"))
    self:setGuideTrans("funcTips_apostles_2", self:getChildTrans("mGuideApostles2"))
    self:setGuideTrans("funcTips_apostles_3", self:getChildTrans("mTxtTimes"))
    self:setGuideTrans("funcTips_apostles_4", self:getChildTrans("mGuideApostles4"))
end

--激活
function active(self)
    super.active(self)
    -- self:updateView()
    GameDispatcher:dispatchEvent(EventName.REQ_DUP_APOSTLES2_PANEL_INFO)
    GameDispatcher:addEventListener(EventName.UPDATE_DUP_APOSTLES_PANEL, self.onUpdateHandler, self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DUP_APOSTLES_PANEL, self.onUpdateHandler, self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
    self:recoverItem()
    if self.timerId then
        LoopManager:removeTimerByIndex(self.timerId)
    end
    self.timerId = nil
    RedPointManager:remove(self.mBtnStage.transform)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtNowDiff.text = _TT(3529)
    self.mTxt.text = _TT(3530)
    self.mTxtTitle.text = _TT(3531)
    self:setBtnLabel(self.mBtnShop, 10, "兑换")
    -- self:setBtnLabel(self.mBtnStage, nil, "下一阶星级奖励")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnShop, self.onOpenShop)
    self:addUIEvent(self.mBtnStage, self.onOpenReward)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
end

function onOpenShop(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.ShopDupApostles })
end

function onOpenReward(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DUP_APOSTLES_REWARD_PANEL)
end
--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.DupApostlesWar })
end

function onUpdateHandler(self)
    self.data = dup.DupApostlesWarManager:getPanelInfo()
    self.configVo = dup.DupApostlesWarManager:getClositerDataById(self.data.id)
    self:updateView()
end

function updateView(self)
    self:updateRed()
    self:recoverItem()
    if self.timerId then
        LoopManager:removeTimerByIndex(self.timerId)
    end
    self.mTxtLevel.text = "（等级推荐  <color=#46b7ff><size=22>" .. self.configVo.level[1] .. "~" .. self.configVo.level[2] .. "</size></color> ）"
    self.mTxtDifficulty.text = self.mDifficultyList[self.data.id]
    local str, _ = dup.DupApostlesWarManager:getResetTimeStr()
    self.mTxtTime.text = str
    local onTimer = function()
        if (not dup.DupApostlesWarManager:getWeekEnd()) then
            local str, _ = dup.DupApostlesWarManager:getResetTimeStr()
            self.mTxtTime.text = str
        else
            self:closeAll()
        end
    end
    self.timerId = LoopManager:addTimer(self.updateTime, 0, self, onTimer)

    local taskList = self.configVo.taskRewardList
    if (self.data.starNum < self.configVo.maxStar) then
        --策划要显示下一阶段的进度
        for i = 1, #taskList do
            if (taskList[i].star > self.data.starNum) then
                self.mImgPro.fillAmount = self.data.starNum / taskList[i].star
                self.mTxtStageNum.text = self.data.starNum .. "/" .. taskList[i].star
                break
            end
        end
    else
        self.mImgPro.fillAmount = self.data.starNum / self.configVo.maxStar
        self.mTxtStageNum.text = self.data.starNum .. "/" .. self.configVo.maxStar
    end

    local nextRewardVo = nil
    local hasGetList = self.data.receivedStarId
    local rewardVo = self.configVo.taskRewardList
    for k, v in pairs(rewardVo) do
        if (not table.indexof(hasGetList, v.id)) then
            nextRewardVo = v
            break
        end
    end
    if (nextRewardVo ~= nil) then
        for k, v in pairs(nextRewardVo.rewards) do
            local propsGrid = PropsGrid:createByData({ tid = v[1], num = v[2], parent = self.mNextAward, scale = 1, showUseInTip = true })
            table.insert(self.mEnterItemList, propsGrid)
        end
    end
    self.mTxtTimes.text = self.configVo.challengeNum - self.data.challengeTimes
    local bossList = self.data.bossList
    for i = 1, #self.data.bossList do
        local item = SimpleInsItem:create(self.DupApostlesEnterItem, self.mBossContent, "DupApostlesEnterItem")

        self:setGuideTrans("funcTips_apostles_item_" .. i, item:getTrans())

        item:getChildGO("Root"):SetActive(false)
        local function callTween()
            if (not gs.GoUtil.IsCompNull(item.m_go:GetComponent(ty.UIDoTween))) then
                item:getChildGO("Root"):SetActive(true)
                item.m_go:GetComponent(ty.UIDoTween):BeginTween()
            end
        end

        item.tweenId = LoopManager:setTimeout(i * 0.03, item, callTween)

        local enterIcon = item:getChildGO("mEnterIcon"):GetComponent(ty.AutoRefImage)
        enterIcon:SetImg(UrlManager:getMonsterIconPath(self.configVo.bossImgList[bossList[i].id]))
        local difficulty = item:getChildGO("mDifficultyPro"):GetComponent(ty.Image)
        local difficultyText = item:getChildGO("mTxtDifficultyNum"):GetComponent(ty.Text)
        local complete = item:getChildGO("mComplete")
        local txtName = item:getChildGO("mTxtName"):GetComponent(ty.Text)

        local completeNum = 0
        local allStarNum = 0
        for k = 1, #bossList[i].difficultyList do
            completeNum = completeNum + #bossList[i].difficultyList[k].completedTarget
            allStarNum = allStarNum + #dup.DupApostlesWarManager:getDupDataById(bossList[i].difficultyList[k].id).starList
        end
        txtName.text = _TT(self.configVo.name[bossList[i].id])
        difficultyText.text = "<size=40>" .. completeNum .. "</size>/" .. allStarNum
        if (allStarNum == 0) then
            allStarNum = 1
        end
        difficulty.fillAmount = completeNum / allStarNum
        if completeNum >= allStarNum then
            complete:SetActive(true)
        else
            complete:SetActive(false)
        end

        item:addUIEvent(nil, function()
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_APOSTLES_WAR_PANEL, { bossData = bossList[i] })
        end)
        table.insert(self.mEnterItemList, item)
    end
end

-- 回收项
function recoverItem(self)
    if self.mEnterItemList then
        for i, v in pairs(self.mEnterItemList) do
            LoopManager:clearTimeout(v.timerId)
            v.tweenId = nil
            v:poolRecover()
        end
    end
    self.mEnterItemList = {}
end

function updateRed(self)
    local isFlag = dup.DupApostlesWarManager:checkFlag()
    if isFlag then
        RedPointManager:add(self.mBtnStage.transform, nil, -124, 47)
        self.Receive:SetActive(true)
    else
        RedPointManager:remove(self.mBtnStage.transform)
        self.Receive:SetActive(false)
        if self.data.starNum >= self.configVo.maxStar then
            self.Complete:SetActive(true)
        else
            self.Complete:SetActive(false)
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(3531):	"剩余挑战次数："
	语言包: _TT(3530):	"剩余时间："
	语言包: _TT(3529):	"当前难度"
]]